pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MainMarket.sol";

contract TestMainMarket {

    // Requires 'function addShop()'s 'onlyAdmin(msg.sender)' modifier commented out
    function testInternalIDsSetCorrectly() public {
        MainMarket market = MainMarket(DeployedAddresses.MainMarket());

        uint expected = 1;
        market.addShop();
        market.addShop();
        market.addShop();
        Assert.equal(
            expected,
            market.getShopID(expected),
            "ID of second shop should be 1."
        );
    }
    

    function testItemIDsSetCorrectly() public {
        MainMarket market = MainMarket(DeployedAddresses.MainMarket());

        market.addItem(1, "plant", 500);
        market.addItem(1, "flower", 250);
        uint expected = 250;
        Assert.equal(
            expected,
            market.getItemPrice(1, 1),
            "Price of second item within second shop should be '250'."
        );
    }

    function testShopExistenceMappingWorks() public {
        MainMarket market = MainMarket(DeployedAddresses.MainMarket());
        
        bool expected = false;
        Assert.equal(
            expected,
            market.getShopExistence(20),
            "20th Shop should not yet exist."
        );

    }

    // Requires 'function removeShopOwner()'s 'onlyAdmin(msg.sender)' modifier commented out
    function testRemoveShopOwnerSucceeds() public {
        MainMarket market = MainMarket(DeployedAddresses.MainMarket());

        market.removeShopOwner(1);
        address expected = 0x0000000000000000000000000000000000000000;
        Assert.equal(
            expected,
            market.getShopOwner(1),
            "Shop's owner should be '0x000...'"
        );
    }

    // Requires 'function assignShopOwner()'s 'onlyAdmin(msg.sender)' modifier commented out
    function testAddShopOwnerSucceeds() public {
        MainMarket market = MainMarket(DeployedAddresses.MainMarket());

        market.assignShopOwner(2, 0x0000000000000000000000000000000000000001);
        address expected = 0x0000000000000000000000000000000000000001;
        Assert.equal(
            expected,
            market.getShopOwner(2),
            "Shop's owner should be '0x0000000000000000000000000000000000000001'"
        );
    }

}


