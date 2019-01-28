pragma solidity ^0.5.0;

import "./Ownable.sol";

contract LibraryDemo is Ownable {
    /** @notice Contract demos the ability to import library ('Ownable.sol') and use library modifier (onlyOwner()) to set permissions for a funciton.
      */
  
    bool counterLock;
    uint count;

    constructor() public {
        counterLock = true;
        count = 0;
    }

    function toggleLock() public onlyOwner() {  // Modifier used is from Ownable.sol
        counterLock = !counterLock;
    }

    function counter() public {
        require(counterLock == false, "Counter must be unlocked first.");
        count++;
    }

    function getCount() public view returns(uint) {
        return count;
    }



}
