// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenGaming is ERC20, Ownable {

    string tokenName = "Degen";
    string tokenSymbol = "DGN";
    mapping (address => uint[]) public ownedItems;
    mapping (uint => uint[2]) public shopItemsManagement;
    string public ItemNames = "1. Weapon skin (70) 2. Gold Crates (100) 3. Reaper Mask (200)";
    uint256 supplyTotal = 0;


    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    constructor(uint _startingSupply) ERC20(tokenName, tokenSymbol) Ownable(msg.sender) {
        _mint(msg.sender, _startingSupply);
        shopItemsManagement[1] = [70, 5];
        shopItemsManagement[2] = [100, 4];
        shopItemsManagement[3] = [200, 3];
    }

    function mintToken(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        supplyTotal += amount;
    }

    function reward(address _player, uint _tokenAmount) public onlyOwner {
        _transfer(msg.sender, _player, _tokenAmount);
    }

    function AccountBalance(address _user) public view returns (uint) {
        return balanceOf(_user);
    }

    function BuyItem(uint8 _choice) public returns (bool) {
        if (shopItemsManagement[_choice][1] != 0) { 
            if (AccountBalance(msg.sender) >= shopItemsManagement[_choice][0]) {
                ownedItems[msg.sender].push(_choice);
                shopItemsManagement[_choice][1] -= 1;
                _transfer(msg.sender, owner(), shopItemsManagement[_choice][0]);
                return true;
            }
            else {
                return false;
            }
        }
        else {
            return false;
        }
    }

    function burnToken(uint256 amount) public {
        _burn(msg.sender, amount);
        supplyTotal -= amount;
    }

    function transferToken( address to, uint256 amount) public{
        _transfer(msg.sender, to, amount);
    }
}




