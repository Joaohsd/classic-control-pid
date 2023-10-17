# **Classic Control - PID**
This repository contains the first work proposed for the "C213 - Sistemas Embarcados" subject from INATEL. Based on the the response obtained applying a step of 13 on a system, it was possible to observe that the response obtained was a tipical response for a first order system. So we used the Smith method to get values to estimate the transfer function for this system.
In order to find the constants for the PID controller, it was used two methods:
*  CHR without Overshooting;
*  IAE;
It also constains a menu for the user in "menu.m" script, that allows the user to enter with the Kp, Ti and Td constants, in addition to provide the setpoint required.

## **Requirements**
*  Octave;

## **Run**
Using octave run the scripts in "src" folder at the following order:
*  load_values.m
*  ch1.m
*  integral_erro.m
*  menu.m
