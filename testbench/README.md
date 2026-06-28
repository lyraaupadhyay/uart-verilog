# Testbenches

This directory contains the Verilog testbenches used to functionally verify each module of the UART Transceiver design.

The testbenches were simulated using **Icarus Verilog**, and the generated waveforms were analyzed using **GTKWave**.

---

# Testbench Files

## 1. `uart_tx_tb.v`

Verifies the functionality of the UART Transmitter.

### Verification Performed

* Reset operation
* Transmission start using `tx_start`
* Start bit generation
* LSB-first transmission
* Correct shifting of data bits
* Stop bit generation
* `tx_busy` assertion during transmission
* Return to the IDLE state after transmission


---

## 2. `uart_rx_tb.v`

Verifies the functionality of the UART Receiver.

### Verification Performed

* Reset operation
* Start bit detection
* 16× oversampling
* Middle-of-bit sampling
* Reception of 8 serial data bits
* Shift register operation
* Stop bit validation
* `rx_done` pulse generation
* Correct reconstruction of received parallel data

The testbench serially drives each UART frame bit while maintaining each bit for one baud period.

---

## 3. `uart_system_tb.v`

Performs end-to-end verification of the complete UART system.

### Integrated Modules

* Baud Rate Generator
* UART Transmitter
* UART Receiver

The transmitter output is internally connected to the receiver input using a loopback serial connection.




### Verification Performed

* Complete UART transmission
* Complete UART reception
* Correct baud timing
* Receiver oversampling
* End-to-end data integrity
* Successful loopback communication

The received data is automatically compared against the transmitted data.


---

# Simulation Tools

* Icarus Verilog
* GTKWave

---




---

# Verification Summary

| Test                      | Status |
| ------------------------- | :----: |
| Reset Verification        |    ✅   |
| UART TX FSM               |    ✅   |
| UART RX FSM               |    ✅   |
| Start Bit Detection       |    ✅   |
| 16× Oversampling          |    ✅   |
| LSB-First Transmission    |    ✅   |
| Stop Bit Detection        |    ✅   |
| Loopback Communication    |    ✅   |
| End-to-End Data Integrity |    ✅   |

---

# Notes

* Each RTL module has an independent testbench for functional verification.
* The system-level testbench validates the complete UART communication path from transmitter to receiver.
* Waveforms generated during simulation can be viewed using GTKWave for detailed timing analysis.
