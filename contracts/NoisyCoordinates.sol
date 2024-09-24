// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NoisyCoordinates {
    
    struct Coordinate {
        int256 latitude;
        int256 longitude;
    }
    
    mapping(address => Coordinate[]) public userCoordinates;
    
    event CoordinatesSubmitted(address indexed user, int256 latitude, int256 longitude);
    
    function submitNoisyCoordinates(int256 _latitude, int256 _longitude) public {
        userCoordinates[msg.sender].push(Coordinate(_latitude, _longitude));
        emit CoordinatesSubmitted(msg.sender, _latitude, _longitude);
    }
    
    function getCoordinates(address _user) public view returns (Coordinate[] memory) {
        return userCoordinates[_user];
    }
}

