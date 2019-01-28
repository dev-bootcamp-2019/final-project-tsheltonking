# Measures taken to prevent common attacks:

### Reentrancy
  - The contract has been made to minimize external function calls. Besides two instances of calling .transfer() - a reentrancy-safe function - MainMarket contract functions exclusively modify state.
  
### Initial-Balance-Dependence
  - The contract does not try to use more or less ether than it receives for a given transaction and attempts to refund any excess ether received making its operation independent of the balance at its address.

### Integer Overflow/Underflow
  - The contract's arithmetic operations amount to basic addition and iteration by 1. Subtraction isn't included in the contract beyond its use in separate variables when refunding buyers. The uints involved are all uint256 ensuring there is minimal risk that the contract variables will ever overflow.

## Other Safety Features

  - The shopEverything() and resumeEverything() functions serve as a circuit breaker and are used to create a modifier for all state-changing functions that will prevent them from being called in the event that the contract enters an unintended state. View functions may still be called at any time.

  - The 'existingShops' and 'existingItems' mappings were made to enable modifiers to check if a given shop or item has been created and thus prevent functions from attempting to edit or use data from struct instances that do not exist. 
