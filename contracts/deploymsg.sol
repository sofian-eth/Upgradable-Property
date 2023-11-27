//SPDX-License-Identifier: MIT
pragma solidity 0.8.5;
contract changeMessage{
    string public message = "Hi this is a message";

    function changeIt(string memory _message) public {
        message = _message;
    }

    function viewMessage() public view returns (string memory) {
        return message;
    }
}