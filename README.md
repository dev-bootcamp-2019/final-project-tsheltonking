# Solidity-Market-Project

## What this project does

This contract serves as an online marketplace that operates on the blockchain. It provides a list of stores on a central marketplace (the contract) where shoppers can purchase goods posted by store owners, who may be assigned or removed ownership over each store by a list of accounts with admin permissions also stored on the blockchain. 

### Notices
  
  - The provided Test contract needs the ability to access admin functions in order to properly test the contract logic. *Before running the* ```'truffle test'``` *command, please comment out any* ```'onlyAdmin(msg.sender)'``` *modifiers* within the MainMarket.sol contract.* These modifiers can be found in functions under the ```'// TIER1 - Admin functions'``` section.

## Requirements

### Accomplished

  - Include a project README.md that explains the project.
  - The project should be a truffle project
  - Smart Contract code should be commented according to the specs in the documentation.
  - Create at least 5 tests for the smart contract.
  - Include a document called design_pattern_desicions.md that explains choice to use present design patterns.


  
### To Do

  
  - Include a document called avoiding_common_attacks.md that explains measures taken to ensure contracts are not susceptible to common attacks.
  - Use a development server to serve the front end interface of the application.
  - If the project does not require a library or an EthPM package, demonstrate how to do that in a contract called LibraryDemo.sol

## How to set it Up


