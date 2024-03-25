// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/tokens/ERC4626.sol";
import "solmate/tokens/ERC20.sol";

/**
 * @title TokenVault
 * @notice A contract that allows users to deposit assets and receive vault token in exchange
 * @dev The contract is inherited from ERC4626 and uses the deposit and redeem functions from the ERC4626 library
 */
contract TokenVault is ERC4626 {
    // a mapping that keeps track of the shares of each shareholder
    mapping(address => uint256) public shareHolder;

    constructor(ERC20 _asset, string memory _name, string memory _symbol) ERC4626(_asset, _name, _symbol) {}

    /**
     * @notice function to deposit assets and receive vault token in exchange
     * @param _assets amount of the asset token
     */
    function _deposit(uint256 _assets) public {
        // checks that the deposited amount is greater than zero.
        require(_assets > 0, "Deposit less than Zero");
        // calling the deposit function ERC-4626 library to perform all the functionality
        deposit(_assets, msg.sender);
        // Increase the share of the user
        shareHolder[msg.sender] += _assets;
    }

    // returns total number of assets
    function totalAssets() public view override returns (uint256) {
        return asset.balanceOf(address(this));
    }
}