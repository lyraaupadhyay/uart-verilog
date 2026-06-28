# UART Transceiver in Verilog

## Overview

This project implements a **Universal Asynchronous Receiver/Transmitter (UART)** in **Verilog HDL**. The design consists of a configurable baud rate generator, UART transmitter, UART receiver with **16× oversampling**, and a top-level module integrating all components.

The project was developed, simulated, synthesized, and analyzed using industry-standard FPGA design tools.

---

## Features

* UART Transmitter (TX)
* UART Receiver (RX)
* Configurable Baud Rate Generator
* 16× Oversampling Receiver
* Two-Flip-Flop Synchronizer for asynchronous RX input
* FSM-based TX and RX implementation
* Top-level UART integration module
* Functional simulation using Icarus Verilog and GTKWave
* RTL synthesis using Xilinx Vivado
* Resource utilization and timing analysis

---


---

# UART Architecture

```text
                    +-------------------+
                    |   Baud Generator  |
                    +---------+---------+
                              |
             +----------------+----------------+
             |                                 |
             |                                 |
      +------v------+                  +-------v------+
      |  UART TX    |                  |   UART RX    |
      +------+------+
             |                               ^
             |                               |
             +--------- Serial Line ---------+
```

---

# UART Frame Format

```text
Idle | Start | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop
  1      0      LSB -----------------------------> MSB    1
```

* **1 Start Bit**
* **8 Data Bits**
* **1 Stop Bit**
* **LSB transmitted first**

---

# Module Description

| Module              | Description                                          |
| ------------------- | ---------------------------------------------------- |
| `baud_gen.v`        | Generates baud tick and sampling tick signals        |
| `uart_tx.v`         | UART transmitter finite state machine                |
| `uart_rx.v`         | UART receiver with 16× oversampling and synchronizer |
| `uart_top_module.v` | Integrates baud generator, transmitter, and receiver |

---



---

# Simulation

Simulation was performed using:

* Icarus Verilog
* GTKWave

Simulation verifies:

* Start bit transmission
* LSB-first data transmission
* Stop bit generation
* Correct UART reception
* End-to-end loopback communication

---

# Synthesis

**Tool:** Xilinx Vivado

## Resource Utilization

| Resource        | Utilization |
| --------------- | ----------: |
| Slice LUTs      |      **55** |
| Slice Registers |      **66** |

---

# Timing Analysis

Timing constraints:

* Clock Frequency: **50 MHz**
* Clock Period: **20 ns**

## Timing Summary

| Metric                         |         Value |
| ------------------------------ | ------------: |
| Worst Negative Slack (WNS)     | **16.104 ns** |
| Worst Hold Slack (WHS)         |  **0.144 ns** |
| Worst Pulse Width Slack (WPWS) |  **9.500 ns** |
| Setup Violations               |         **0** |
| Hold Violations                |         **0** |

**Result:**  Timing successfully met.

---

# Tools Used

* Verilog HDL
* Icarus Verilog
* GTKWave
* Xilinx Vivado

---

# Future Improvements

* UART Parity Bit Support
* Configurable Data Width
* Configurable Stop Bits
* TX FIFO
* RX FIFO
* Interrupt Support
* AXI-Stream Interface

---

# Learning Outcomes

This project demonstrates:

* RTL Design in Verilog
* Finite State Machine (FSM) Design
* Shift Registers
* Baud Rate Generation
* UART Serial Communication
* Clocked Sequential Logic
* Two-Flip-Flop Synchronizer
* 16× Oversampling Technique
* Functional Simulation
* FPGA Synthesis
* Resource Utilization Analysis
* Static Timing Analysis

---

