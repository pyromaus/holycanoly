// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//import {Functions, FunctionsClient} from "..";
//contract HolyCanoly is FunctionsClient {

contract HolyCanoly {
    enum CropTypeBoys {
        WHEAT,
        BARLEY,
        CANOLA
    }

    enum CropStatus {
        PLANTED,
        VEGETATIVE,
        BUDDING,
        HARVEST
    }

    struct Farmer {
        uint farmerID;
        address farmerAddress;
    }

    struct Crop {
        uint cropID;
        uint farmerID;
        CropTypeBoys cropType;
        uint cropLocation; //
        uint cropSize; // square meters m^2
        CropStatus status;
        bool insured;
        uint estimatedYield;
        uint measuredYield;
    }

    mapping(address => mapping(uint => Crop)) private s_crops;
    mapping(address => Farmer) private s_farmers;

    address private immutable i_owner;
    address private immutable acidPlug;
    uint public SEQ_farmerID = 0;
    uint public SEQ_cropID = 0;

    constructor() {
        i_owner = msg.sender;
    }

    function newFarmer(address _farmer) public returns (uint) {
        SEQ_farmerID++;
        s_farmers[_farmer] = Farmer(SEQ_farmerID, _farmer);
        return SEQ_farmerID;
    }

    function newCropBoys(
        address _farmer, 
        CropTypeBoys _type,
        uint _location,
        uint _size
        ) public returns (uint) {
        SEQ_cropID++;
        s_crops[_farmer][SEQ_cropID] = Crop(
            SEQ_cropID,
            s_farmers[_farmer].farmerID,
            _type,
            _location,
            _size,
            1,
            false,
            0,
            0
        );
        return SEQ_cropID;
    }
}
