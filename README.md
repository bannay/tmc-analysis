<div id="top"></div>
<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/bannay/tmc-analysis">
    <img src="images/logo.png" alt="Logo" width="100" height="100">
  </a>
<br>


<h3 align="center">Tune & Match Circuit Analysis</h3>
</div>

<!-- ABOUT THE PROJECT -->
## **About the project**
The script computes the the transformation of 1V incduced by a:

* locally tuned and matched reciever across a 50 ohm receiver terminal.
* A 50 ohm reciever (geneartor) across the terminals of a locally tuned and matched coil.

### Software
* MATLAB 
***

<br />
  <a href="https://github.com/bannay/tmc-analysis">
    <img src="images/circuit.jpg" alt="circuit" width="540" height="430">
  </a>
<br>

**Computation**

Complex coil impedance is defined as:

![Z_A = R_A+jX_A](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+Z_A+%3D+R_A%2BjX_A)

The tuning (Ct) and matching (Cm) element values are found by solving the matching conditions

![B = \frac{X_A\pm\sqrt{R_A/Z0}\: \sqrt{R_A(R_A-Z_0)+X_A^2}}{R_A^2+X_A^2}
](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+B+%3D+%5Cfrac%7BX_A%5Cpm%5Csqrt%7BR_A%2FZ0%7D%5C%3A+%5Csqrt%7BR_A%28R_A-Z_0%29%2BX_A%5E2%7D%7D%7BR_A%5E2%2BX_A%5E2%7D%0A)

![C_t = B/\omega_0
](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+C_t+%3D+B%2F%5Comega_0%0A)

![Z_B = \frac{1}{j\omega C_t+1/Z_A}
](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+Z_B+%3D+%5Cfrac%7B1%7D%7Bj%5Comega+C_t%2B1%2FZ_A%7D%0A)

![X = \frac{1}{B}+\frac{X_A Z_0}{R_A}-\frac{Z0}{R_A B}
](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+X+%3D+%5Cfrac%7B1%7D%7BB%7D%2B%5Cfrac%7BX_A+Z_0%7D%7BR_A%7D-%5Cfrac%7BZ0%7D%7BR_A+B%7D%0A)

![C_m = \frac{-1}{\omega X}](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+C_m+%3D+%5Cfrac%7B-1%7D%7B%5Comega+X%7D)

Ct and Cm values are only valid when B and X are positive, therefore an appropriate sign is to be chosen in for the Ct equation. Subsequently, the input impedance of the parallel LC resonant circuit is defined as:

![Z_C=Z_B+\frac{-j}{\omega C_m}
](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+Z_C%3DZ_B%2B%5Cfrac%7B-j%7D%7B%5Comega+C_m%7D%0A)

**Voltage and current distribution (Generator POV)**

The reflection coefficient looking through the generator terminals (Gen->Load)

![\Gamma_G=\frac{Z_C-Z_0}{Z_C+Z_0}](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+%5CGamma_G%3D%5Cfrac%7BZ_C-Z_0%7D%7BZ_C%2BZ_0%7D)

The accepted power by the circuit from the generator is computed as

![P_{in}=P_{av}(1-|\Gamma_G|^2)](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+P_%7Bin%7D%3DP_%7Bav%7D%281-%7C%5CGamma_G%7C%5E2%29)

As such the voltage induced across the generator terminals and current flowing through them are

![V_C = \sqrt{4 P_{in} Z_C}
](https://render.githubusercontent.com/render/math?math=\color{magenta}\displaystyle+\displaystyle+V_C+%3D+\sqrt{4+P_{in}+Z_C}%0A)

![i_C = V_C /Z_C](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+i_C+%3D+V_C+%2FZ_C)

Similallry the voltage induced across the parallel resonator is

![V_B=V_C \cdot \frac{Z_B}{Z_B+jX}](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+V_B%3DV_C+%5Ccdot+%5Cfrac%7BZ_B%7D%7BZ_B%2BjX%7D)

The current flowing through the coil is evaluated by

![i_A = V_B/Z_A](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+i_A+%3D+V_B%2FZ_A)

Therefore the power delivered to the coil is

![P_L = \frac{1}{2}\mathbb{R} (i_A^*V_B)](https://render.githubusercontent.com/render/math?math=\color{magenta}%5Cdisplaystyle+%5Cdisplaystyle+P_L+%3D+%5Cfrac%7B1%7D%7B2%7D%5Cmathbb%7BR%7D+%28i_A%5E%2AV_B%29)

<p align="right">(<a href="#top">back to top</a>)</p>

***
<!-- Results -->
## Results
<br />
  <a href="https://github.com/bannay/tmc-analysis">
    <img src="images/result.jpg" alt="result" width="560" height="420">
  </a>
<br>

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<!-- CONTACT -->
## Contact

Mohammed M. Albannay - [@Bannay](https://twitter.com/bannay) - bannay@gmail.com

Project Link: [https://github.com/bannay/rigid-surfacecoil](https://github.com/bannay/rigid-surfacecoil)

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Readme template](https://github.com/othneildrew/Best-README-Template)

<p align="right">(<a href="#top">back to top</a>)</p>

***
