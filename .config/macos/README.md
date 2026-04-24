# Cruise Control logic

Demo that simulates a cruise control loop. It reads keystrokes to adjust the desired speed and runs a simple control step in a 50 Hz periodic tick.

## Disclaimer

> CURRENTLY ONLY RUNS ON POSIX COMPATIBLE MACHINES

## Feature
- Basic Cruise Control (CC) logic that maintains a driver-set target speed using throttle control.
- Finite State Machine with the following modes:
  - Inactive: CC is off.
  - Active: CC regulates vehicle speed to the desired setpoint.
  - Suspended: CC is temporarily paused due to driver override; can resume to Active.
- Driver override/interrupt handling (e.g., brake/clutch) to safely suspend or deactivate CC.
- Mocked vehicle and data source for a self-contained console simulation.

## PID controller concept
Although this minimal CC demo uses a simplified throttle computation inside the state machine, the intended control concept is a classic PID controller that regulates the throttle to keep the vehicle speed at the desired setpoint.

- Goal: minimize the speed error `e(t) = v_setpoint − v_actual`.
- Control output (throttle command `u(t)`):
  - Proportional (P): reacts to the present error — larger error, larger correction.
  - Integral (I): accumulates past error to eliminate steady-state bias (e.g., constant drag/grade).
  - Derivative (D): anticipates future trend by reacting to the error rate of change, improving damping and reducing overshoot.

In discrete 50 Hz operation (Δt ≈ 20 ms), a common implementation is:

```
e_k = v_setpoint_k − v_actual_k
I_k = I_{k−1} + e_k · Δt        # with anti-windup clamping
D_k = (e_k − e_{k−1}) / Δt
u_k = Kp · e_k + Ki · I_k + Kd · D_k

u_k is then saturated to [0.0, 1.0] (0–100% throttle).
```

Practical notes for this project:
- Sampling: the controller loop already runs at 50 Hz, suitable for a simple PID.
- Saturation and anti-windup: clamp throttle to valid bounds and limit the integral term to prevent windup when saturated.
- Units: keep speeds in km/h consistently or convert to m/s; consistency matters more than absolute choice.
- Tuning: start with P-only to achieve stable convergence, then add I to remove bias, and a small D to reduce overshoot/noise sensitivity. Classic methods like Ziegler–Nichols or manual step-response tuning work for this mock environment.

## State Machine & Control Algorithm

### State Model

Define the set of states `S = {inactive, active, suspended}` and events `E = {setActive, setInactive, interrupt}` (coded as `Event::SetActive`, `Event::SetInactive`, `Event::Interrupt`). The transition function `τ: S × E → S` has the following mappings (reflecting the current implementation in `StateTransitions.cpp`):

```
τ(inactive, setActive)      = active

τ(active, setInactive)      = inactive
τ(active, interrupt)        = suspended

τ(suspended, setActive)     = active
τ(suspended, setInactive)   = inactive
τ(suspended, interrupt)     = inactive
```

### Control Law (discrete time)

Sampling period `Ts = 0.02 s` (50 Hz). Let desired speed be `vd[k]` and actual speed be `v[k]`.

Error: `e[k] = vd[k] − v[k]`.

PID terms:

```
P[k] = Kp · e[k]
I[k] = clip(I[k−1] + Ki · Ts · e[k], Imin, Imax)
D[k] = Kd · (e[k] − e[k−1]) / Ts

u_raw[k] = P[k] + I[k] + D[k]
u[k]     = sat(u_raw[k], umin, umax)
```

Typical design: `Kp, Ki, Kd > 0`; higher `Kp` improves response but may increase overshoot, higher `Ki` reduces steady‑state error but risks windup, higher `Kd` damps transients but amplifies noise.

### State‑dependent Output Selection

- Inactive: `u[k] = u_driver[k]` (driver pedal passes through).
- Active: `u[k] = u_PID[k]` (uses the law above).
- Suspended: `u[k] = u_driver[k]` (paused cruise, driver control).

### Plant Assumption (simplified)

A first‑order approximation: `v[k+1] ≈ v[k] + α · u[k] · Ts`, bounded to a feasible range `[0, vmax]`. Saturation in `u[k]` ensures bounded actuation and safety.

## Implementation
- State machine core: `controller/CruiseControlStateMachine.h`
  - Events: `controller/Event.h` (`SetActive`, `SetInactive`, `Interrupt`)
  - States: `controller/states` (`StateInactive`, `StateActive`, `StateSuspended`)
  - Transitions: `StateTransitions.cpp`
- Controller loop: `controller/CruiseController.h`
  - 50 Hz control loop (every 20 ms)
  - Fetches `InputData`, dispatches events on interrupts, computes throttle via the state machine, and applies it to the mocked ECU
- I/O and signals:
  - Input/Output data types: `include/signals/IOData.h`
  - Mocked data source (desired/actual speed, brake/clutch): `include/ECUs/MockedDataSource.h`
  - Mocked vehicle ECU (applies throttle, provides current speed): `include/ECUs/MockedCarEcu.h`
- Demo entry point: `main.cpp`
  - Sets up state machine, data source, and ECU
  - Starts the controller and provides a simple keyboard interface

## Simulation
- Launch the console demo and control it with the keyboard:
  - Keys:
    - `W` — increase desired speed (+5 km/h)
    - `S` — decrease desired speed (−5 km/h)
    - `X` — exit demo (disables CC and quits)
  - Setpoint limits: 10–100 km/h (default 60 km/h)
  - The controller runs at 50 Hz and prints current desired speed; the mocked ECU simulates vehicle acceleration with applied throttle.
  - Note: On Windows consoles, keystrokes are line‑buffered; press Enter to submit. On Unix/macOS in this demo, raw terminal mode is enabled so Enter is not required.

## How to build

### Prerequisites
- CMake 3.20+
- C++17-compatible compiler (GCC, Clang, or MSVC)
 - Windows PowerShell or any terminal (on Windows)

### Build (from this folder)
```bash
# From src/cc
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --target CC_demo
```
### Build (from repository root)
```bash
# From repository root
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --target CC_demo
```

### Run
From this folder after a local build:
```bash
# Unix/macOS
./build/CC_demo

# Windows (path may vary by generator/config)
./build/Debug/CC_demo.exe
```

### CLion (provided target)
This folder defines the executable target `CC_demo`. In CLion, select the desired profile (e.g., Debug) and build/run the `CC_demo` target from the IDE. The executable will be placed in the profile-specific build directory (e.g., `src/cc/cmake-build-debug/`).

## Notes
- The demo uses mocked ECUs and a simple controller; there are no external runtime dependencies beyond a C++17 standard library.
- Default desired speed is 60 km/h; min 10, max 100.
