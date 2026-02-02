# Power-efficient-Approximate-Multiplier-via-Clock-gating

---

## 🔍 Project Overview

</div>

This project focuses on the **design and evaluation of power-efficient multiplier architectures** by combining **approximate computing** with **clock gating**. The goal is to **reduce dynamic power consumption** while maintaining acceptable accuracy for **error-tolerant applications**.  
All designs are implemented in **Verilog HDL**, simulated, and analyzed across multiple bit-widths to study **power–accuracy trade-offs**.

---

## 🎯 Motivation & Problem Statement

</div>

Multipliers are critical components in modern digital systems, including:
- Digital Signal Processing (DSP)
- Image and Video Processing
- Machine Learning Accelerators
- Embedded and IoT Systems

**Challenges addressed:**
- Exact multipliers incur **high power and area overhead**
- Many applications **do not require exact arithmetic**
- Unnecessary clock activity causes **excessive dynamic power loss**

**This project demonstrates how:**
- **Approximate arithmetic** reduces hardware complexity
- **Clock gating** suppresses redundant switching
- Their combination delivers **significant power savings**

---

## 🧠 Key Concepts & Techniques Used

</div>

### 🔹 Approximate Computing
- Uses **controlled inaccuracy** to reduce power, area, and switching activity
- Approximation applied **only to Lower Significant Bits (LSBs)**
- **Most Significant Bits (MSBs)** computed exactly to preserve accuracy
- Implemented using **Approximate Half Adders (AHA)** and **Approximate Full Adders (AFA)**

**Exact Half Adder**
- Sum: `S = A ⊕ B`
- Carry: `C = A · B`

**Approximate Half Adder**
- Sum: `S = A + B`
- Carry: `C = A · B`

<table>
  <tr>
    <td align="center">
      <img width="856" height="287" alt="Circuit Diagram" src="https://github.com/user-attachments/assets/b7bda242-744b-4673-8e38-8951da4e6b23"/><br/>
      <small>(a). Exact HA, (b). Approx. HA</small>
    </td>
    <td align="center">
      <img width="642" height="238" alt="image" src="https://github.com/user-attachments/assets/25cd2272-e606-44c7-a86b-6dba567662c3" /><br/>
      <small>Exact vs Approximate HA truth table comparison</small>
    </td>
  </tr>
</table>


**Exact Full Adder**
- Sum: `S = A ⊕ B ⊕ Cin`
- Carry: `C = (A · B) + (Cin · (A ⊕ B))`

**Approximate Full Adder**
- Sum: `S = C'`
- Carry: `C = A + B + Cin`

<table>
  <tr>
    <td align="center">
      <img width="1002" height="585" alt="image" src="https://github.com/user-attachments/assets/817e38bb-f0f6-4529-9099-6ac9775cf6a5" /><br/>
      <small>(a). Exact FA, (b). Approx. FA</small>
    </td>
    <td align="center">
      <img width="1002" height="585" alt="image" src="https://github.com/user-attachments/assets/82a6e677-137a-45e8-9aaa-176e1fce5b70" /><br/>
      <small>Exact vs Approximate FA truth table comparison</small>
    </td>
  </tr>
</table>

- Carry logic simplification reduces:
  - Gate count
  - Switching activity
  - Dynamic power consumption

</div>

### 🔹 Clock Gating
- Prevents unnecessary clock toggling during idle cycles
- Targets **dynamic power**, the dominant component in synchronous circuits
- Implemented using a **latch-based clock gating cell**

**Clock Gating Behavior**
- `enable = 1` → Clock active → Computation enabled  
- `enable = 0` → Clock blocked → Output held constant  

<table>
  <tr>
    <td align="center">
      <img width="745" height="345" alt="image" src="https://github.com/user-attachments/assets/62ae6e92-8ec4-48c0-b00c-54279dfd7fac" /><br/>
      <small>Integrated clock gating circuit</small>
    </td>
  </tr>
</table>

</div>

### 🔹 Adder Architectures Used
Multiple adder architectures are implemented to evaluate **power–delay–area trade-offs**.

- **Ripple Carry Adder (RCA)**  
  Simple structure, low area, higher delay

- **Carry Save Adder (CSA)**  
  Fast partial product accumulation, ideal for multipliers

- **Carry Select Adder (CSLA)**  
  Reduced carry propagation delay at the cost of extra hardware

- **Conditional Sum Adder (COSA)**  
  Parallel carry evaluation for high-speed operation

<table>
  <tr>
    <td align="center">
      <img width="776" height="316" alt="image" src="https://github.com/user-attachments/assets/aa3907ae-a170-4d63-919f-99786dc01e42" /><br/>
      <small>4-Bit ripple carry adder (RCA)</small>
    </td>
    <td align="center">
      <img width="788" height="420" alt="image" src="https://github.com/user-attachments/assets/623c596e-f513-432c-963b-4fa329b9018f" /><br/>
      <small>4-Bit carry save adder (CSA)</small>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img width="1423" height="681" alt="image" src="https://github.com/user-attachments/assets/97621408-dc35-42f6-b04c-7df37b718154" /><br/>
      <small>4-Bit carry select adder (CSLA)</small>
    </td>
    <td align="center">
      <img width="1121" height="613" alt="image" src="https://github.com/user-attachments/assets/0e7e6c21-5c6d-4c42-ba79-de8eadd973f1" /><br/>
      <small>4-Bit conditional sum adder (COSA)</small>
    </td>
  </tr>
</table>

</div>

### 🔹 Scalable Multiplier Architecture
- Implemented in **4-bit, 8-bit, and 16-bit configurations**
- Uses **hierarchical and modular design**

**4-bit Approximate Multiplier**
- AND-based partial product generation
- Approximate adders in LSB region
- Exact adders in MSB region

<table>
  <tr>
    <td align="center">
      <img width="1156" height="820" alt="image" src="https://github.com/user-attachments/assets/9c13a2cc-9374-4e60-9b76-0231b4757148" /><br/>
      <small>Architecture of 4-bit approximate multiplier</small>
    </td>
  </tr>
</table>

**8-bit Approximate Multiplier**
- Constructed using **four 4-bit multipliers**
- Partial products aligned and accumulated using 8-bit adders

<table>
  <tr>
    <td align="center">
      <img width="1414" height="842" alt="image" src="https://github.com/user-attachments/assets/b973fd38-1663-4138-b481-7b96ef399b47" /><br/>
      <small>Architecture of 8-bit approximate multiplier using 4-bit approx. multiplier</small>
    </td>
  </tr>
</table>

**16-bit Approximate Multiplier**
- Constructed using **four 8-bit multipliers**
- Final accumulation using a 16-bit adder
- Approximation confined to lower bits

<table>
  <tr>
    <td align="center">
      <img width="850" height="549" alt="image" src="https://github.com/user-attachments/assets/618280d5-e213-4ddd-9843-d5a07c42fe8e" /><br/>
      <small>Architecture of 16-bit approximate multiplier using 8-bit approx. multiplier</small>
    </td>
  </tr>
</table>

</div>

### 🔹 Overall Functioning (16-bit Operation)
- When `enable = 1`:
  - Gated clock activates computation
  - Partial products generated
  - LSBs use approximate adders
  - MSBs use exact adders
  - Output registered on gated clock edge

- When `enable = 0`:
  - Clock disabled
  - Internal switching eliminated
  - Output remains stable

<table>
  <tr>
    <td align="center">
      <img width="1102" height="452" alt="image" src="https://github.com/user-attachments/assets/0311ec4b-27ee-4dc6-998f-0276ca19b56e" /><br/>
      <small>Approximate Multiplier block diagram with clock enabled Register</small>
    </td>
  </tr>
</table>

---

## 🏗️ Architecture & Design Flow

</div>

The design follows a **hierarchical and modular architecture**, enabling easy scalability from **4-bit to 16-bit multipliers**.

### High-Level Design Flow
- Partial product generation using **AND gate arrays**
- Partial product reduction using selected **adder architectures**
- Approximation applied in **lower-bit stages**
- Exact computation preserved in **higher-bit stages**
- Final summation produces the output product

### Hierarchical Construction
- 4-bit multiplier → basic building block  
- 8-bit multiplier → four 4-bit blocks  
- 16-bit multiplier → four 8-bit blocks  

### Clock-Gated Operation
- Enable signal controls clock propagation
- Clock disabled during inactive computation
- Output held constant during gated cycles

<table>
  <tr>
    <td align="center">
      <img width="1409" height="857" alt="image" src="https://github.com/user-attachments/assets/06243557-7c6c-4397-a815-2d79e0b782bf" /><br/>
      <small>Architecture of Clock-gated 16-bit approximate multiplier using 8-bit approx. multiplier </small>
    </td>
  </tr>
</table>

---

## ⚙️ Implementation Details

</div>

The complete design is implemented in **Verilog HDL**, organized for **clarity, reusability, and scalability**.

### Adder Modules
- Exact Half Adder and Full Adder
- Approximate Half Adder and Full Adder
- Parameterized implementations of:
  - RCA
  - CSA
  - CSLA
  - COSA

### Multiplier Variants
- 4-bit approximate multiplier
- 8-bit hierarchical approximate multiplier
- [16-bit clock-gated approximate multiplier](https://github.com/BibhuAsish1925/Power-efficient-Approximate-Multiplier-via-Clock-gating/blob/main/Clock-gated%20Multipliers/Approximate/src/clock_gated_approx_mult_16bit.v)

### Clock Gating Integration
- Enable-controlled AND-based gating
- Applied at **adder and register levels**
- Minimizes unnecessary switching activity

### RTL Design Practices
- Fully synthesizable RTL
- Parameterized and reusable modules
- Clear hierarchy and signal naming
- Separate testbenches for verification

📷 *[Insert RTL schematics and simulation waveforms here]*  
🔗 *[Link to Verilog source files]*

---

## 🧪 Simulation & Verification

</div>

Functional verification ensures correctness and controlled approximation behavior.

**Verification strategy:**
- Independent testbenches for adder modules
- Dedicated testbench for 16-bit clock-gated multiplier
- Directed and random test vectors
- Comparison against exact multiplier outputs

**Simulation checks:**
- Correct sum and carry generation
- Proper clock gating enable/disable behavior
- Output stability during gated cycles
- Error confinement to LSB region

**Tools used:**
- Xilinx Vivado Simulator
- RTL-level waveform analysis

📷 *[Insert simulation waveform screenshots here]*

---

## 📊 Results & Performance Analysis

</div>

The clock-gated approximate multiplier achieves **significant power reduction** with minimal accuracy loss.

- Reduced dynamic power due to clock gating
- Lower switching activity in approximate stages
- MSB accuracy preserved
- Predictable and bounded error behavior

📷 *[Insert power and accuracy comparison charts here]*  
🔗 *[Link to synthesis or analysis reports]*

---

## 🚀 Applications

</div>

Suitable for systems where **energy efficiency is prioritized over exact precision**:
- Image and video processing
- Machine learning accelerators
- DSP systems
- Multimedia compression
- Low-power IoT and edge devices

📷 *[Insert application block diagram here]*

---

## 🏁 Conclusion

</div>

This project presents a **power-efficient 16-bit clock-gated approximate multiplier** using multiple adder architectures.

- Clock gating effectively reduces dynamic power
- Approximate adders balance accuracy and efficiency
- Modular and scalable RTL design
- Verified through functional simulation

📷 *[Insert final architecture overview here]*

---

## 🔮 Future Scope

</div>

- Error metric analysis (MED, MSE, error rate)
- ASIC-level synthesis and power evaluation
- Adaptive approximation based on workload
- Extension to 32-bit and 64-bit designs
- Integration into ML and DSP accelerators

📷 *[Insert future enhancement roadmap here]*

---
