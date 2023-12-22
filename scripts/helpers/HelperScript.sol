// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "contracts/JayNFT.sol";

interface IFxRoot {
    function deposit(address rootToken, address user, uint256 tokenId, bytes calldata data) external;
}

enum ContractState {
    NEW,
    OLD
}

abstract contract HelperScript is Script {
    JayNFT jay;
    IFxRoot fxRoot = IFxRoot(0xF9bc4a80464E48369303196645e876c8C7D972de);

    function run() external virtual;

    function setJayNFT() internal {
        _setJayNFT(address(0), ContractState.NEW);
    }

    function setJayNFT(address _jay) internal {
        _setJayNFT(_jay, ContractState.OLD);
    }

    function batchMintAll(address to) internal {
        jay.mint(to, jay.maxSupply() - jay.totalSupply());
    }

    function checkBalance(address user) internal view returns (uint256) {
        return jay.balanceOf(user);
    }

    function bridgeToMumbai() internal {
        jay.setApprovalForAll(address(fxRoot), true);

        for (uint256 i = 1; i <= jay.balanceOf(msg.sender); i++) {
            fxRoot.deposit(address(jay), msg.sender, i, "0x6556");
        }
    }

    function _setJayNFT(address _jay, ContractState state) internal {
        if (state == ContractState.OLD) {
            require(_jay != address(0), "JayNFT: JayNFT contract is not set");
            jay = JayNFT(_jay);
        } else {
            jay = new JayNFT();
        }
    }
}
