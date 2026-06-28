# RTL Modules

This directory contains the Register Transfer Level (RTL) implementation of the UART Transceiver written in **Verilog HDL**.

## Modules

### 1. `baud_gen.v`

Generates the timing signals required for UART communication.

**Functionality**

* Divides the system clock to generate the UART baud rate.
* Generates:

  * `baud_tick` for the UART transmitter.
  * `sample_tick` for the UART receiver (16× oversampling).


---

### 2. `uart_tx.v`

Implements the UART Transmitter using a Finite State Machine (FSM).

**Features**

* Loads 8-bit parallel data into a shift register.
* Transmits one start bit.
* Sends 8 data bits (LSB first).
* Sends one stop bit.
* Generates a `tx_busy` signal while transmission is in progress.



---

### 3. `uart_rx.v`

Implements the UART Receiver using a Finite State Machine (FSM).

**Features**

* Detects the falling edge of the start bit.
* Uses a two-flip-flop synchronizer to safely receive asynchronous serial data.
* Samples each bit at the center using 16× oversampling.
* Receives 8-bit serial data.
* Generates an `rx_done` pulse when a complete byte has been received.


---

### 4. `uart_top_module.v`

Top-level integration module.

This module instantiates:

* Baud Rate Generator
* UART Transmitter
* UART Receiver

The transmitter output is internally connected to the receiver input through a serial wire, enabling loopback testing.


---

## UART Configuration

| Parameter          |     Value |
| ------------------ | --------: |
| Data Bits          |         8 |
| Start Bits         |         1 |
| Stop Bits          |         1 |
| Parity             |      None |
| Transmission Order | LSB First |
| Oversampling       |       16× |

---

## Design Techniques Used

* Finite State Machines (FSM)
* Shift Registers
* Clock Division
* Counter-Based Timing
* Two-Flip-Flop Synchronizer
* 16× Oversampling
* Parameterized Baud Generator
* Non-blocking Sequential Logic

---

## Module Dependency

```text
uart_top_module
│
├── baud_gen
├── uart_tx
└── uart_rx
```

---

## Notes

* All modules are fully synthesizable.
* The design targets FPGA implementation using Xilinx Vivado.
* Timing is controlled using generated baud and sample tick signals.
* The receiver samples incoming serial data at the middle of each bit period to improve reliability.
