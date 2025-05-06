// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract SimpleStorage {
    
    struct Person {
        uint256 favNum;
        string name;
    }

    uint256 public myFavNumber;
    Person[] public users;
    mapping(string => uint256) public nameToFavNum;

    function store(uint256 _number) public virtual  {
        myFavNumber = _number;
    }

    function retrieve() public view returns (uint256) {
        return myFavNumber;
    }

    function getUsers() public view returns (Person[] memory) {
        return users;
    }

    function addFriend(uint256 _favNum, string memory _name) public {
        users.push(Person(_favNum, _name));
        nameToFavNum[_name] = _favNum;
    }
}
