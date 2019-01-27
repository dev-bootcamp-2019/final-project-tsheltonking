pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MainMarket.sol";

contract TestMainMarket {

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

        market._addItem(1, "plant", 500);
        market._addItem(1, "flower", 250);
        uint expected = 250;
        Assert.equal(
            expected,
            market.getItemPrice(1, 1),
            "Price of second item within second shop should be '250'."
        );
    }

    // testThree(){
    //     MainMarket market = MainMarket(DeployedAddresses.MainMarket());

    // }

    // testFour(){
    //     MainMarket market = MainMarket(DeployedAddresses.MainMarket());

    // }

    // testFive(){
    //     MainMarket market = MainMarket(DeployedAddresses.MainMarket());

    // }

}


