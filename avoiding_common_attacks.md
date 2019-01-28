

# Avoiding Common Attacks

## Measures taken to prevent:

### Reentrancy
  - The contract has been made to minimize external function calls. Besides two instances of calling .transfer() - a reentrancy-safe function - contract functions exclusively modify state.
  
### 
