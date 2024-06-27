# DegenGaming Token

## Contracr address (Fuji Testnet) - 0xE477C09C0ae6319F3Edd5934C44EFc8a0BDD2735 (Verifies)

## Overview

Degen Gaming Token (DGN) is a unique ERC-20 token designed specifically for the gaming ecosystem of Degen Gaming 🎮. It serves as a reward mechanism for players within the game, allowing them to earn tokens through various in-game activities and achievements. These tokens can then be utilized to unlock exclusive rewards and items from the in-game store

## Features 

- `Reward System`: Players can earn DGN tokens by accomplishing specific tasks, achieving milestones, or winning challenges within the game environment.

- `In-Game Store`: DGN tokens can be exchanged for a variety of rewards, including rare items, character upgrades, and special abilities, available in the in-game store.

- `Player Interaction`: The token facilitates peer-to-peer trading among players, enabling them to exchange tokens for in-game assets or trade with other players to enhance their gaming experience.

- `Avalanche Blockchain`: Built on the Avalanche blockchain platform, DGN ensures fast transaction speeds and low fees, providing a seamless experience for gamers.
- 
## Usage
to uses this contract or exectue you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., DegenGaming.sol). Copy and paste the following code into the file:

```solidity
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
```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.25" (or another compatible version), and then click on the "Compile DegenGaming.sol" button.

Once the code is compiled, you can deploy the contract by selecting the injected provider wallert for transaction after that by Select the "DegenGaming" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can use the deployed contract interface to call the mint, reward, buy item by choosing etc. You can enter addresses and values to test the functionality. After entering data, click on "transact" button to execute the function and mint, transfer the amount and do testing. 

To see the transaction details we use the snowtrace test net which is connected to metamask wallet and by entering address shown above you can check the details of transaction on the test net.

## Contact
For any questions or suggestions, feel free to open an issue or contact the repository owner.

Mail - vermashiv1910@gmail.com
