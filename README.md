# queue-theory
This is my project on Queue Theory.

# 🚦 Traffic Queuing Analysis – Auckland Southern Motorway On-Ramp  

## 1. Problem / Purpose  
Traffic congestion on the Auckland Southern Motorway is a persistent issue, particularly at on-ramps during peak hours.  
This project applies **queuing theory** to:  
- Model congestion  
- Estimate waiting times  
- Test potential solutions for improving flow efficiency  

---

## 2. Data Collection / Extraction  
- **Location:** Auckland Southern Motorway on-ramp  
- **Method:** Manual observation at 5 PM (peak hour)  
- **Collected Values:**  
  - Arrival rate **λ ≈ 1000 vehicles/hour (~16.67 per min)**  
  - Service rate **μ ≈ 400 vehicles/hour (~6.67 per min, 9s traffic signal cycle)**  

---

## 3. Data Cleaning  
- Converted rates into **consistent units (vehicles/minute)**  
- Assumptions:  
  - **Poisson arrivals**  
  - **Exponential service times**  
  - **FIFO discipline**  
- Simplified model: **M/M/1 queue** with infinite capacity  
- Limitations: snapshot observation, ignored variability, simplified ramp metering  

---

## 4. Process  
- Verified stability condition:  
  - ρ = λ/μ = **2.5 → system unstable (λ > μ)**  
- Hypothetical case: **3-lane ramp**  
  - Approximated as a single “server” with **μ = 20 vehicles/min**  
- Calculated queue metrics (L, Lq, W, Wq) using steady-state formulas  

---

## 5. Results  
### Current Single-Lane  
- System overloaded → **queues grow indefinitely**  

### Hypothetical 3-Lane  
- Utilization: **ρ = 0.83 (stable)**  
- Avg queue length: **~4 cars**  
- Avg waiting time: **~0.24 minutes (~14.7s)**  

### Proposed Interventions  
- **Infrastructure:** Add lanes → increases μ  
- **Demand Management:** Public transport, carpooling → reduces λ  

---

## 6. Conclusion  
- Current system: **unsustainable under peak load**  
- Increasing service capacity (μ) or reducing arrivals (λ) drastically improves flow  
- **Queuing theory provides a mathematical lens** for guiding Auckland’s traffic management  

---

## 📊 Queue Model Diagram  

```mermaid
flowchart LR
    A[Arrivals λ] -->|Poisson Process| Q[Queue]
    Q -->|Service μ| S[Traffic Signal / Server]
    S --> D[Departure]
