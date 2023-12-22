// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./helpers/HelperScript.sol";

contract MyScript is HelperScript {
    function run() external virtual override {
        vm.startBroadcast();
        setJayNFT();
        console2.log("======== New Contract Address ========");
        console2.logAddress(address(jay));
        vm.stopBroadcast();
    }
}
