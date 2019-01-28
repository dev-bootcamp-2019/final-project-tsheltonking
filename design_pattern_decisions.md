# Design Pattern Decisions

## Summary

The contract serves as a digital marketplace where shoppers can purchase goods posted as offerings by store owners and where administrator accounts can manage who has permissions of ownership over shops, items, etc.

## MainMarket Contract Layout

###  Readability

  - Functions are grouped and labelled under different categories according to the permissions required to use them and are ordered top-down by order of importance/relevance to the operation of the contract as a whole. The labels are as follows:
    - *TIER1* Functions require administrator priviledges - kept track of by the isAdmin mapping - to access.
    - *TIER2* Functions are available to shop owners.
    - *TIER3* Functions anyone can access but were limited to those that modify state.
    - *TIER4* as a label is reserved for view functions.
  - The only exception to this rule is made for the emergency circuitbreaker functions which are indented separately and located at the bottom of the contract so as to differentiate them from the rest. 
  
### Structure 

  The heirarchical nature of contract structs (Item mappings are members of Shop mappings) allows most elements of the structs to be accessed by functions using the same two parameters. This was done in the effort to simplify the understanding needed to call and interact with contract functions.
  - While this method can make calling functions more intuitive it's notable that many of the function definitions may appear less readable due to their having to work down the mapping and member heirarchy in order to reference objects relevant to the funciton.

## MainMarket Contract Behavior



### Safety Measures

  - The shopEverything() and resumeEverything() functions serve as a circuit breaker and are used to create a modifier for all state-changing functions that will prevent them from being called in the event that the contract enters an unintended state. View functions may still be called at any time.

  - The 'existingShops' and 'existingItems' mappings were made to enable modifiers to check if a given shop or item has been created and thus prevent functions from attempting to edit or use data from struct instances that do not exist. 

