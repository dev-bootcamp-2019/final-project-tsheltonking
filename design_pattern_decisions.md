# Design Pattern Decisions


## Contract Layout

###  Readability

  - Functions are grouped and labelled under different categories according to the permissions required to use them and are ordered top-down by order of importance/relevance to the operation of the contract as a whole.
    - *TIER1* Functions require administrator priviledges - kept track of by the isAdmin mapping - to access.
    - *TIER2* Functions are available to shop owners.
    - *TIER3* Functions anyone can access but were limited to those that modify state.
    - *TIER4* as a label is reserved for view functions.
  - The only exception to this rule is made for the emergency circuitbreaker functions which are indented separately and located at the bottom of the contract so as to differentiate them from the rest. 
  
### Structure 

  The heirarchical nature of contract structs (Item mappings are members of Shop mappings)
  Function parameters  in the effort of 

## Contract Behavior

Calling functions attempts to be made simple by 
Funcitonality attmepts to be made explicit by requiring a standard set of parameters for most functions, namely 

## Circuit Breaker
  Instead of toggling the entire contract's functionality with one function, two functions ('stopEverything()' & 'resumeEverything()') were used in the design of the contract's circuit breaker system to ensure that their behavior is explicit to the person calling them.
