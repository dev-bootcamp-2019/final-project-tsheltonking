# Solidity-Market-Project

## What this project does

This contract serves as an online marketplace that operates on the blockchain. It provides a list of stores on a central marketplace (the contract) where shoppers can purchase goods posted by store owners, who may be assigned or removed ownership over each store by a list of accounts with admin permissions also stored on the blockchain. 

### Notices
  
  - The provided Test contract needs the ability to access admin functions in order to properly test the contract logic. *Before running the* ```'truffle test'``` *command, please comment out any* ```'onlyAdmin(msg.sender)'``` *modifiers* within the MainMarket.sol contract. These modifiers can be found in functions clearly labelled under the ```'// TIER1 - Admin functions'``` section.

## Requirements

### Accomplished

  - Include a project README.md that explains the project.
  - The project should be a truffle project
  - Smart Contract code should be commented according to the specs in the documentation.
  - Create at least 5 tests for the smart contract.
  - Include a document called design_pattern_desicions.md that explains choice to use present design patterns.
  - Include a document called avoiding_common_attacks.md that explains measures taken to ensure contracts are not susceptible to common attacks.
  - If the project does not require a library or an EthPM package, demonstrate how you would do that in a contract called LibraryDemo.sol

### To Do

  - Use a development server to serve the front end interface of the application.

## How to set it Up

### Install Node Modules

The following commands will ensure you have both ganache and truffle installed which are required for initial tests with the project.

  - Truffle:
```
npm install -g truffle
```
  - Ganache:
```
npm install -g ganache-cli
```

Once done, download or clone this repository to a new project folder.
From there you can either open a terminal, run ganache-cli, then navigate to the project folder and use truffle commands - or review contract code using an editor of your choice. See the notice above before running the ``'truffle test'`` command.

### App Interaction
The front end of this applicaiton is a work in progress but using ganache as a test blockchain we can demonstrate how to set up contract interaction between a running instance of the contract and a browser. To download web3 into the frontDemo folder,
navigate to the folder in a terminal, then run
  ```
  npm install web3@0.19.1 --save
  ```
  This should give the required web3 package to be able to interact with  
