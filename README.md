# ALU - Arithmetic Logic Unit

## Description

This project implements an **Arithmetic Logic Unit (ALU)** in VHDL. The ALU performs a variety of arithmetic and logical operations on two 4-bit inputs, supporting operations such as addition, subtraction, increment, signal inversion, logical AND, OR, comparison, and doubling. It also provides status flags for carry, zero, negative, and overflow conditions.

---

## Features

- **Arithmetic Operations**:
  - Addition (`000`)
  - Subtraction (`001`)
  - Increment (`010`)
  - Signal Inversion (`011`)
  - Doubling (`111`)

- **Logical Operations**:
  - Logical AND (`100`)
  - Logical OR (`101`)

- **Comparison** (`110`): Compares two inputs and outputs the result.

- **Status Flags**:
  - **Carry (flagCarry)**: Indicates if a carry/borrow occurred during the operation.
  - **Zero (flagZero)**: Indicates if the result is zero.
  - **Negative (flagNegativo)**: Indicates if the result is negative.
  - **Overflow (flagOverflow)**: Indicates if an overflow occurred during the operation.

---

## Design

The ALU is designed as a modular architecture with reusable components:
- **Components**:
  - `incremento`: Performs the increment operation.
  - `dobro`: Computes the double of the input.
  - `comparador`: Compares two inputs.
  - `fullAdder4bits`: 4-bit adder for addition operations.
  - `Subtrator`: Subtraction module.
  - `inverteSinal`: Inverts the input signal.

The `operador` signal determines the operation to be performed. The ALU's output includes the computed result (`result`) and the associated status flags.

---

## Input/Output Ports

### Input Ports
- `entrada1` (`std_logic_vector(3 downto 0)`): First operand.
- `entrada2` (`std_logic_vector(3 downto 0)`): Second operand.
- `operador` (`std_logic_vector(2 downto 0)`): Selects the operation to perform.

### Output Ports
- `result` (`std_logic_vector(3 downto 0)`): Result of the operation.
- `flagCarry` (`std_logic`): Carry flag.
- `flagNegativo` (`std_logic`): Negative flag.
- `flagZero` (`std_logic`): Zero flag.
- `flagOverflow` (`std_logic`): Overflow flag.

---

## Operation Codes

| Operation Code | Description        |
|----------------|--------------------|
| `000`          | Addition           |
| `001`          | Subtraction        |
| `010`          | Increment          |
| `011`          | Signal Inversion   |
| `100`          | Logical AND        |
| `101`          | Logical OR         |
| `110`          | Comparison         |
| `111`          | Doubling           |

---

