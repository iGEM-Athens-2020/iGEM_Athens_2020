These are the simulation files which were used to solve the model proposed by the iGEM Athens 2020 team. This model describes the mechanical interactions and movement of the bacteria flavobacterium johnsoniae. You can find detailed information about it in the page: https://2020.igem.org/Team:Athens/Model.
The simulation is built to run in MATLAB (.m files). It was composed in MATLAB2020b for MacOS, but earlier 64bit versions should work fine.

CONTENTS
===============

iGEM_Athens_2020_Simulation.m
-------
This is the most important file of the simulation. It is a MATLAB function file and it is used to efficiently compute the forces that are acted to each particle at any given time. We encourage the users to alter the stiffness of the springs so that the simulation can run smoothly and the result can be physically correct. It doesn't need any other changes (unless you want to customize a force, which it is not recommended in most cases).

Run_Simulation.m
-------
It is a MATLAB scipt and it is used to easily solve the ODEs and plot the results. You can change the parameters and the initial conditions of the simulation so that the results are closer to the bacterium you want to simulate. The rest of the code probably does not need changing, but you are encouraged to change it as you please.
TIP: If the ODE solver is unsuccessful, the most probable problem is the collision resolution sub-algorithm. In this case, you can alter the stiffness of the collisions, or the number of particles per bacterium. Note that you should be careful that the assigned values reflect physically correct results.

Initial_conf.m
-------
It is a MATLAB scipt that produces the initial configuration of the system of bacteria. It only consists of three configurations. Its aim is to serve as an example, so that the prospective user can build their own initial configuration based on the algorithms proposed there.


If you have any questions about the files, contact us via:
igemathens2020@gmail.com
and/or
dimos99@gmail.com
