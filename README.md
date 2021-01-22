# ASP-QSIM

ASP implementation of the QSIM algorithm (Kuipers 1986) extended with qualitative rules (Wiley 2017). 
The ASP solver produces a sequence of qualitative actions that enable a dynamic system (modelled using QSIM) to transition from an initial state to at least one goal state.

ASP-QSIM is designed to use the [Potassco Clingo][1] ASP solver, from the University of Potsdam.
ASP-QSIM may function with other ASP solvers, however, this is not guaranteed.

Features of ASP-QSIM include:
* Underspecified Goal State: The goal state may be underspecified, so that only the necessary constraints on a subset of the variables need to be specified. The solver will determine suitable values for the unspecified variables
* Fixed time and Variable time implementations: ASP-QSIM can be executed in two modes:
    * Fixed time intervals, where the total number of time intervals to be used by the qualitative simulation is fixed. ASP-QSIM will find a simulation using **all** time intervals. Note this may cause the solver to fail if a simulation can be completed in a shorter number of time intervals and the system cannot remain "at rest".
    * Variable time, where a Clingo compatible python script invokes ASP-QSIM with an increasing number of time intervals until a solution is found. This will find a simulation with the minimum number of time intervals.
* Multiple solutions: ASP will generate all solutions satisfying the goal specification within the available time intervals. Note the solution generation has no ranking of quality.
* Detached action generation: Generation of qualitative actions may be optionally enabled.
* Quantitative solving: Where the fixed *quantitative value* of qualitative landmarks is known, additional constraints may be provided to the solver to improve the simulation.

## Publications

The ASP-QSIM algorithm was originally described in Wiley, Sammut & Bratko (2014) and is based on the original description of the QSIM (Qualitative SIMulation) algorithm from Kuipers (1986).
The algorithm is part of Wiley's PhD thesis (2017). More details of the ASP-QSIM algorithm and it's application for planning robot actions can be found in the thesis publication (Wiley 2017).

# Running

ASP-QSIM is designed to be modular, with the ASP predicates separated across multiple files.
The desired functionality can be selected by invoking the ASP solver.

The minimum files that are necessary to invoke ASP-QSIM are:
1. ```db.ld``` - process the qualitative model of the selected instance
1. ```preds.ld``` - QSIM predicates and facts (without time)
1. ```show.ld``` - Control the Clingo output 

In additional:
1. A qualitative model instance must be provided. Example models are in the ```instances``` folder
1. A goal specficication, of the target state to reach. Example goals are in the ```instances``` folder

Finally, the fixed time, or iterative time version of ASP-QSIM must be selected.
* The fixed time uses the files:
    1.  ```single/qdes.lp``` - QDE descriptions
    1.  ```single/qsim.lp``` - QSIM implementation
* The iterative time uses the files:
    1.  ```iterative/qdes.lp``` - QDE descriptions
    1.  ```iterative/qsim.lp``` - QSIM implementation
    1.  ```iterative/run-py.lp``` - Python imbedded script to control Clingo iteration

Optinal elements of ASP-QSIM can be added by including the ASP file when invoking the ASP solver:
1. ```actions.ld``` - produce the qualiative actions corresponding to caclculated state sequence
1. ```quant.ld``` - include ASP rules for creating quantative constaints
1. ```quant_integrity.ld``` - used if running quantiative constraints with the iterative solver


## Fixed time version

An example fixed time version can be invoked through the Potassco Clingo solver by:
```
clingo db.lp preds.lp single/qdes.lp single/qsim.lp show.lp --const t=2 instances/db_ball.lp instances/goals_ball.lp
```

If ASP output is saved to a file, the state sequence can be formatted by:
```
./display <file>
```

## Iterative version
An example iterative version can be invoked through the Potassco Clingo solver by:
```
clingo iterative/qdes.lp iterative/qsim.lp iterative/run-py.lp db.lp preds.lp show.lp instances/db_ball.lp instances/goals_ball.lp
```

## Qualitative Actions

To generate qualitative actions corresponding to the QSIM sequence

## Example instances (qualitative models)
ASP-QSIM provides the following example models:
* Ball (```db_ball``) - The classic qualitative system of a bouncing ball
* Bathtub (```db_bathtub``) - The classic qualitative system of a single bathtub being filled from an input faucet
* Cascading tanks (```db_tanks_3/5/10``) - A cascading sequence of water tanks where the overflow from one tank leads into each tank in sequence. Models for 3, 5 and, 10 tanks are provided
* Pole-and-Cart (```db_pole_cart``) - The classic robot system of a pole-and-cart

Example goals for each model are also provided.

# Helper Scripts

Additional Perl scripts (in the ```scripts```) help with processing and viewing the ASP-QSIM results:
* ```display.pl``` - Display the ASP-QSIM state sequence in a human friendly format
* ```clean.pl``` - Pre-process the ASP-QSIM state sequence to remove unwanted variables
* ```result_stats.pl``` - Extract statistics of the ASP-QSIM performance and final results

# Versioning

ASP-QSIM is compatible with:
* Clingo v4.3 (for the ASP solver)
* Python v2.7 (for invoking the iterative ASP solver)

# Copyright
Copyright (C) 2017 
The University of New South Wales, Sydney, Australia.

Dr. Timothy Wiley

# References

* Wiley, T. (2017). *[A Planning and Learning Hierarchy for the Online Acquisition of Robot Behaviours][3]*, School of Computer Science and Engineering, The University of New South Wales, Sydney, Australia.
* Wiley, T., Sammut, C., & Bratko, I. (2014). *[Qualitative Simulation with Answer Set Programming][2]*. Proceedings of the 21st European Conference on Artificial Intelligence. Prague, Czech Republic, pp. 915-920.
* Kuipers, B. J. (1986) *Qualitative simulation*. Artificial Intelligence, vol. 29, no. 3, pp. 289–338.


[1]: https://potassco.org/clingo/
[2]: http://ebooks.iospress.nl/volumearticle/37059
[3]: http://handle.unsw.edu.au/1959.4/58775


