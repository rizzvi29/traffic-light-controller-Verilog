# Traffic Light Controller - Verilog HDL

## Project Overview

This project implements a **Traffic Light Controller** using Verilog HDL, designed to mimic the operation of a two-way traffic signal system. The controller cycles through green, yellow, and red lights for North-South and East-West directions using a finite state machine (FSM).

The project is simulated and verified in **ModelSim**, demonstrating correct timing and state transitions that are typical for real-world traffic lights.

---

## Files in This Repository

- `traffic_light_controller.v`  
  The main Verilog module implementing the FSM for traffic light control.

- `tb_traffic_light_controller.v`  
  The testbench for simulating the traffic light controller. Generates clock and reset signals and monitors outputs.

---

## How to Simulate

1. **Compile** both files in ModelSim:
