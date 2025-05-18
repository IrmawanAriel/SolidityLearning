//SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import {SimpleStorage} from "./Simple_storage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageContracts;

    function creatSimpleStorageContract() public {
        SimpleStorage Storage = new SimpleStorage();
        simpleStorageContracts.push(Storage);
    }

    function getContracts () public view returns (SimpleStorage[] memory) {
        return simpleStorageContracts;
    }

    function sfStore(uint256 _indexOfAddress, uint256 _newSimpleStorageNumber) public {
        simpleStorageContracts[_indexOfAddress].store(_newSimpleStorageNumber);
    }

    function sfRetrive(uint256 _indexOfAddress) public view returns (uint256) {
        return simpleStorageContracts[_indexOfAddress].retrieve();
    }

}