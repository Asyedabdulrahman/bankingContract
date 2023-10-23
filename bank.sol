// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Banking{
    //event
    event withdrawalIsSuccess();
    event transferIsSuccess(uint256);
    error minBalanceIsLow();
    //state variable
    mapping(address => uint256) public balances;
    address payable owner;
    uint256 Amount = 0;
    uint256 public minbalancce = 500;
    //constructor
    constructor(){
        owner = payable(msg.sender );
    }
//function /////////////////////////////////
// Deposit amount
    function deposit()public payable{
        require(msg.value > Amount,"deposit amount is greater than 500");
        balances[msg.sender] += msg.value;
    }
    //withdraw amount
    function withdraw(uint256 amount)public {
        require(amount <= balances[msg.sender],"amount should be less than balances");
        require(owner == msg.sender,"only owner can withdraw funds" );
        address payable receipient = payable(msg.sender);
        receipient.transfer(amount);
        balances[msg.sender] -= amount;
        emit withdrawalIsSuccess();
    }
    //transferring amount
    function transfer(address payable _recipient, uint256 _amount)public{
        require(_amount <= balances[msg.sender],"insufficient funds");
        require(_amount > 0 , "transfer amount should be greater than 0");
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        emit transferIsSuccess(_amount);
    }
    //grant access
    function grantAccess(address payable user)public {
        require(msg.sender == owner,"only the owner can grant access");
        owner = user;
        }

        function revokeAccess(address payable user)public{
            require(msg.sender == owner,"only owner can revoke access");
            owner = payable(msg.sender);
        }

        //destroy the contract
    function destroy()public {
        require(msg.sender == owner,"only owner can destroy the contract");
        selfdestruct(owner);
        }
}