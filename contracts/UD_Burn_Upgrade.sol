//SPDX-License-Identifier: MIT

pragma solidity 0.8.5;
import "./ProjectContract.sol";

contract AssetTokenizationContractV2 is ProjectContract{

    function burnAll(address[] memory holders, uint256[] memory amount) external onlyAdmin {
        require(holders.length == amount.length, "Arrays length mismatch");

        for(uint256 i = 0; i < holders.length; ++i) {
            _burn(holders[i], amount[i]);
        }
    }
}