
pragma solidity ^0.5.0;

/** @title MainMarket */
contract MainMarket {
    /** @notice Contract serves as an online marketplace that operates on the blockchain.
      */

    // DECLARATIONS & SETUP--------------------------------------------------------

    address payable none = 0x0000000000000000000000000000000000000000;
    address payable public owner;
    uint public shopCount;

    mapping (address => bool) public isAdmin;
    mapping (uint => Shop) public shops;
    mapping (uint => bool) public existingShops;//new
    
    modifier onlyAdmin(address _address){require(isAdmin[_address] == true); _;}
    modifier onlyShopOwner(uint _shopID){require(shops[_shopID].shopOwner == msg.sender); _;} 

    modifier verifyItemUnavailable(uint _shopID, uint _itemID){require(shops[_shopID].localItems[_itemID].state == State.Unavailable, "Item is not Unavailable"); _;}
    modifier verifyItemForSale(uint _shopID, uint _itemID){require(shops[_shopID].localItems[_itemID].state == State.ForSale, "Item is not for sale."); _;}
    modifier verifyItemSold(uint _shopID, uint _itemID){require(shops[_shopID].localItems[_itemID].state == State.Sold, "Item has not been sold."); _;}

    modifier paidEnough(uint _shopID, uint _itemID){require(msg.value >= shops[_shopID].localItems[_itemID].itemPrice, "Value is not enough"); _;}
    modifier ifShopExists(uint _shopID){require(existingShops[_shopID] == true, "Shop has not been made yet"); _;} 
    modifier ifItemExists(uint _shopID, uint _itemID){require(shops[_shopID].existingItems[_itemID] == true, "An Item with that value does not exist in this shop"); _;}

    event ForSale(uint _shopID, uint _itemID);
    event Sold(uint _shopID, uint _itemID); 
    event NewShop(uint _shopID);   

    constructor() public {
        owner = msg.sender; 
        isAdmin[owner] = true; 
        shopCount = 0;  
    }

    // STRUCTS & FUNCTIONS---------------------------------------------------------

    enum State {
        ForSale,
        Sold,
	    Unavailable
    }
    
    struct Item {
        string itemName;
        uint itemPrice;
        uint localItemID;  
        State state;
    } 

    struct Shop {
        uint shopID;
        address payable shopOwner;
        uint localItemCount;

        mapping (uint => Item) localItems;
        mapping (uint => bool) existingItems;
    }
    
    // TIER1 - Admin functions -------------------------------

        /** @notice Adds a 'Shop' struct to mapping 'shops'.
            */
        function addShop() 
            public
            // onlyAdmin(msg.sender)  
        {
            shops[shopCount] = Shop({ shopID: shopCount, shopOwner: msg.sender, localItemCount: 0});  //msg.sender may need change
            emit NewShop(shopCount);
            existingShops[shopCount] = true;
            shopCount = shopCount + 1;
        }


        /** @notice Adds owner to target shop.
            * @param _shopID specifies target 'Shop' in 'shops'
            * @param _address specifies new owner of Shop
            */
        function assignShopOwner(uint _shopID, address payable _address)
            public
            // onlyAdmin(msg.sender) 
        {     
            shops[_shopID].shopOwner = _address;
        } 

        /** @notice Removes owner from target shop.
            * @param _shopID specifies target 'Shop' in 'shops'.
            */
        function removeShopOwner(uint _shopID) 
            // onlyAdmin(msg.sender) 
            public 
        {
            shops[_shopID].shopOwner = none;
        } 


    // TIER2 - Shop Owner Functions ----------------------------

        /** @notice Creates new 'Item' in the 'Shop' with ID: '_shopID'
            * @param _shopID used to assign ownership of item to a shop
            * @param _name used as a description for the item
            * @param _price used to set price of item
            */
        function addItem(uint _shopID, string memory _name, uint _price) 
            public 
            ifShopExists(_shopID)
            onlyShopOwner(_shopID) 
        {
            emit ForSale(_shopID, shops[_shopID].localItemCount );
            shops[_shopID].localItems[shops[_shopID].localItemCount] = Item({itemName: _name, itemPrice: _price, localItemID: shops[_shopID].localItemCount, state: State.ForSale}); 
            shops[_shopID].existingItems[shops[_shopID].localItemCount] = true;
            shops[_shopID].localItemCount = shops[_shopID].localItemCount + 1;
		}

        /** @notice Changes 'Item' 'State' to make item unpurchasable.
            * @param _shopID specifies target shop
            * @param _itemID specifies item within target shop
            */
        function removeItem(uint _shopID, uint _itemID)
            public 
            ifItemExists(_shopID, _itemID)
            onlyShopOwner(_shopID) 
            verifyItemForSale(_shopID, _itemID)
        { 
            shops[_shopID].localItems[_itemID].state = State.Unavailable; 
		}


    // TIER3 - Shopper functions -------------------------------

        /** @notice used to purchase (change state of) an item given ether in amount 'price' to address 'shops[_shopID].shopOwner'.
            * @param _shopID specifies target shop
            * @param _itemID specifies item to purchase within target shop
            */
        function buyItem(uint _shopID, uint _itemID) 
            public 
            payable 
            ifItemExists(_shopID, _itemID)
            paidEnough(_shopID, _itemID)
            verifyItemForSale(_shopID, _itemID)
        {
            // Transfer ether of price itemPrice to owner of said Item
            address payable _shopOwner = shops[_shopID].shopOwner;
            uint _price = shops[_shopID].localItems[_itemID].itemPrice;
            _shopOwner.transfer(_price);
  
            shops[_shopID].localItems[_itemID].state = State.Sold;
            emit Sold(_shopID, _itemID);
            //refund extra ether
			uint _remainder = msg.value - shops[_shopID].localItems[_itemID].itemPrice;
            msg.sender.transfer(_remainder);
        }


        // TIER4 - View Functions -------------------------------

        /** @notice Retrieves ShopID of selected shop for verification of internal variable.
            * @param _shopID specifies target shop
            */
        function getShopID(uint _shopID) 
            public 
            view 
            ifShopExists(_shopID)
            returns(uint) 
        {
            return shops[_shopID].shopID;
        }

        /** @notice Retrieves itemPrice of target item specified by parameters.
            * @param _shopID specifies target shop
            * @param _itemID specifies target item
            */
        function getItemPrice(uint _shopID, uint _itemID)
            public
            view
            ifItemExists(_shopID, _itemID)
            returns(uint)
        {
            return shops[_shopID].localItems[_itemID].itemPrice;
        }

        /** @notice Retreives whether shop has been created yet as listed in 'existingShops' mapping.
            * @param _shopID specifies target shop
            */
        function getShopExistence(uint _shopID) 
            public
            view
            returns(bool)
        {
            return existingShops[_shopID];
        }


        /** @notice Retreives target shop owner's address.
            * @param _shopID specifies target shop
            */
        function getShopOwner(uint _shopID) 
            public
            view
            returns(address)
        {
            return shops[_shopID].shopOwner;
        }


} // CONTRACT END---------------------------------------------------------------------------------------
