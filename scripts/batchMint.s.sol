// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./helpers/HelperScript.sol";

contract MyScript is HelperScript {
    function run() external virtual override {
        vm.startBroadcast();
        setJayNFT(0xe30d5178a5C3071F579524f20549d8503B0c9905);
        batchMintAll(msg.sender);
        vm.stopBroadcast();
    }
}
