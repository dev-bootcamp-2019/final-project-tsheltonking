# Measures taken to prevent common attacks:

### Reentrancy
  - The contract has been made to minimize external function calls. Besides two instances of calling .transfer() - a reentrancy-safe function - MainMarket contract functions exclusively modify state.
  
### Initial-Balance-Dependence
  - The contract does not try to use more or less ether than it receives for a given transaction and attempts to refund any excess ether received making its operation independent of the balance at its address.

### Integer Overflow/Underflow
  - The contract's arithmetic operations amount to basic addition and iteration by 1. Subtraction isn't included in the contract beyond its use in separate variables when refunding buyers. The uints involved are all uint256 ensuring there is minimal risk that the contract variables will ever overflow.
