// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NoisyCoordinates {
    
    struct Coordinate {
        int256 latitude;
        int256 longitude;
    }
    
    mapping(address => Coordinate[]) public userCoordinates;
    
    address public superUser;  // L'utilisateur qui aura accès à toutes les coordonnées

    event CoordinatesSubmitted(address indexed user, int256 latitude, int256 longitude);
    event CoordinatesAccessed(address indexed superUser, address indexed user, Coordinate[] coordinates);  // Nouvel événement pour les accès aux coordonnées

    modifier onlySuperUser() {
        require(msg.sender == superUser, "Acces refuse: vous n'etes pas le super utilisateur");
        _;
    }
    
    constructor(address _superUser) {
        superUser = _superUser;  // Définir le super utilisateur à la création du contrat
    }

    // Permet aux utilisateurs de soumettre leurs coordonnées
    function submitNoisyCoordinates(int256 _latitude, int256 _longitude) public {
        userCoordinates[msg.sender].push(Coordinate(_latitude, _longitude));
        emit CoordinatesSubmitted(msg.sender, _latitude, _longitude);
    }

    // Permet aux utilisateurs de récupérer uniquement leurs propres coordonnées
    function getMyCoordinates() public view returns (Coordinate[] memory) {
        return userCoordinates[msg.sender];
    }
    
    // Le super utilisateur peut récupérer les coordonnées de tous les utilisateurs
    // Cette fonction est maintenant une transaction car elle émet un événement
    function getAllCoordinates(address _user) public onlySuperUser {
        Coordinate[] memory coordinates = userCoordinates[_user];
        
        // Émettre un événement pour enregistrer l'accès
        emit CoordinatesAccessed(msg.sender, _user, coordinates);
    }

    // Le super utilisateur peut changer qui est le super utilisateur
    function setSuperUser(address _newSuperUser) public onlySuperUser {
        superUser = _newSuperUser;
    }
}

