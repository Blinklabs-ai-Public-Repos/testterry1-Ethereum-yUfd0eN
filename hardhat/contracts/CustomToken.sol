// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

/**
 * @title CustomToken
 * @dev ERC20 token with burning capability.
 */
contract CustomToken is ERC20Burnable {
    uint256 private immutable _maxSupply;

    /**
     * @dev Constructor that gives msg.sender all of existing tokens.
     * @param name_ The name of the token.
     * @param symbol_ The symbol of the token.
     * @param maxSupply_ The maximum supply of the token.
     */
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 maxSupply_
    ) ERC20(name_, symbol_) {
        require(maxSupply_ > 0, "Max supply must be greater than 0");
        _maxSupply = maxSupply_;
        _mint(msg.sender, maxSupply_);
    }

    /**
     * @dev Returns the max supply of the token.
     */
    function maxSupply() public view returns (uint256) {
        return _maxSupply;
    }

    /**
     * @dev See {ERC20-_mint}.
     *
     * Requirements:
     *
     * - the total supply after minting must not exceed the max supply.
     */
    function _mint(address account, uint256 amount) internal virtual override {
        require(totalSupply() + amount <= _maxSupply, "ERC20: max supply exceeded");
        super._mint(account, amount);
    }
}