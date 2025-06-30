# Identification and Control of Nonlinear Systems with Neural Networks

MATLAB/Simulink-based exercises exploring neural network applications in system identification and control.

##  Description

This project includes three exercises of increasing complexity, aimed at understanding the fundamentals of using neural networks for identification and control of nonlinear systems.

---

### Exercise 1 — Identification of a Nonlinear Scalar Function

The nonlinear function to identify is:

$$
y = f(u) = \frac{\sin(2\pi u)}{2\pi}
$$

The network used is a Gaussian Radial Basis Function Network (RBFN):

$$
\hat{y} = \hat{f}(u) = \vec{c}^T \vec{\zeta}, \quad \zeta_i = \exp\left(-\frac{(u - m_i)^2}{\sigma^2}\right)
$$

An exploratory input signal $u$ is generated to allow weight vector $\vec{c}$ to be trained using backpropagation, minimizing the prediction error $y - \hat{y}$.

[![Neural Network Identification video demo](https://img.youtube.com/vi/8TWRpNh_y2E/0.jpg)](https://youtu.be/8TWRpNh_y2E)  
*Click to view demo video on YouTube.*

---

### Exercise 2 — Identification and Control of a Scalar Dynamical System

The unknown system dynamics are:

$$
\dot{q} = f(q) + H(q) \cdot u
$$

Where:

$$
f(q) = \frac{\sin(2\pi q)}{2\pi}, \quad H(q) = 1 + \frac{\cos(5\pi q)}{5\pi}
$$

Neural networks approximate both functions:

$f(q) \rightarrow N_f(q, \vec{c}_f)$  
$H(q) \rightarrow N_H(q, \vec{c}_H)$

The control law is designed as:

$$
u = \frac{1}{N_H} \left( -N_f + \dot{q}_{\text{ref}} - k(q - q_{\text{ref}}) \right)
$$

---

### Exercise 3 — Identification and Control of a 2-DOF Planar Manipulator (RR)

The system is a standard two-joint planar robot arm (RR manipulator), modeled as:

$$
\dot{\vec{\xi}} = J(\vec{q}) \cdot \dot{\vec{q}} = J(\vec{q}) \cdot \vec{u}
$$

Here, the function to approximate is the Jacobian matrix $J(\vec{q}) : \mathbb{R}^2 \rightarrow \mathbb{R}^{2 \times 2}$, making this a multi-output identification problem. The increased input dimensionality requires the RBF network to use **vector-valued Gaussian basis functions**.

---

## Documentation

Additional documentation is available (preferably the `.pptx` version, as it contains embedded videos). Note: documentation is currently in Italian only.

---

## Execution

To run the project:

1. Open MATLAB.
2. Navigate to each exercise folder.
3. Follow the execution order described in the respective `README.txt` files.

---

## Future Work

- Translate the documentation into English.
- Create a written (non-slide-based) technical report.


