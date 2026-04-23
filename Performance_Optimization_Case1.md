**From 220 µs to 34 µs — A Real Qt/QML Performance Optimization Case**

In domains like **medical devices, industrial systems, and automotive HMIs**, UI performance is not just about smoothness — it directly impacts **usability, operator efficiency, and system reliability**. Small inefficiencies, when repeated frequently, can become real bottlenecks.

In a recent project, I worked on optimizing an interactive **rotary dial built using QML**. This is a common control, but in high-frequency interaction scenarios, its implementation details matter.

---

### **Approach**

As always, the first step was **measurement using QML Profiler**:

* Identify hotspots
* Understand execution frequency
* Analyze flame graphs to see actual cost distribution

---

### **Initial observation**

The dial logic was implemented in QML using **JavaScript**:

* angle calculation
* trigonometry
* value mapping

Measured cost:
**~220 microseconds per interaction**

This is typically where many implementations stop — but this is also where inefficiencies start compounding.

---

### **Optimization strategy**

Rather than micro-optimizing JavaScript, the focus was on **architectural correction**.

**Step 1: Move computation to C++**

* Eliminated JavaScript execution
* Reduced runtime interpretation

Result: **~84 microseconds**

**Step 2: Move input handling to C++**

* Implemented a custom **QQuickItem**
* Removed QML callbacks and cross-layer calls

Result: **~34 microseconds**

---

### **Interpreting the result**

At **60 FPS**:

* 1 frame = **16.6 ms**
* 34 µs = **0.034 ms**

This is **~0.2% of the frame budget**.

At this point, the component is no longer a meaningful contributor to frame time, even under continuous interaction.

---

### **Key principles applied**

* **Measure first, optimize second**
* **Focus on removing layers, not tuning inside them**
* **Keep high-frequency logic out of QML**
* **Treat QML as a declarative UI layer**
* **Evaluate performance in terms of frame budget**

---

### **Final takeaway**

The biggest gains did not come from optimizing code, but from placing the logic in the **right layer**.

**QML for UI.**
**C++ for computation and high-frequency paths.**

This pattern consistently delivers **predictable and scalable performance** in real-world systems.

#Qt #QML #Performance #CPlusPlus #SoftwareEngineering #HMI #EmbeddedSystems
