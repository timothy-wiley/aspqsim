#script (python) 

#
# ASP implementation of QSIM
# Author: Timothy Wiley, UNSW Australia
#
# Python control for Clingo
# Controls the Clingo solving loop to modify the time steps
#

from gringo import *

def onModel(model):
    print "Model: ", model.atoms()

def get(val, default):
    return val if val != None else default

def main(prg):
    imin   = 27 #get(prg.getConst("imin"), 76)
    imax   = 27 #get(prg.getConst("imax"), 76)
    istop  = get(prg.getConst("istop"), "SAT")
    iquery = get(prg.getConst("iquery"), 1)
   
    prg.ground("cumulative", [0])
    prg.ground("base", [])

    step = 1
    while step < imin:
        print "Grounding step ", step
        prg.ground("cumulative", [step])
        step = step + 1
    
    while True:
        if imax != None and step > imax:
            break
        print "\n\nstep... ", step
        prg.ground("cumulative", [step])
        if step >= iquery: 
            if step > iquery: prg.releaseExternal(Fun("query", [step-1]))
            prg.assignExternal(Fun("query", [step]), True)
            prg.ground("volatile", [step])
            
        ret = prg.solve(onModel)
        if step >= imin and ((istop == "SAT" and ret == SolveResult.SAT) or (istop == "UNSAT" and ret != SolveResult.SAT)): break
        #if step >= imax : break
        step = step+1
#end.
