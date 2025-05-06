//SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import {SimpleStorage} from "./Simple_storage.sol";

contract addFiveContract is SimpleStorage {
    function store (uint256 _number) public override{
        myFavNumber = _number + 5;
    }
}