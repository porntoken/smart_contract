pragma solidity ^0.4.16;

/**
 * PornTokenV2 PT Upgrader 
 * Converts PT to PTWO on a 4:1 reverse split basis
 * 
 * The PT user transfering to PTWO must call 
 * The approve(address _spender, uint256 _value) function 
 * from original token contract: 0x66497A283E0a007bA3974e837784C6AE323447de
 * 
 * ...with the address of this Contract as the first argument 
 * and the amount of PT to convert to PTWO as the 2nd argument
 * 
 * Then they must call the ptToPtwo() method in this contract
 * and they will receive a 4:1 reverse split amount of PTWO
 * meaning 4 times less PTWO than PT
 */

interface token {
    function transfer(address receiver, uint amount);
    function allowance(address _owner, address _spender) constant returns (uint remaining);
    function transferFrom(address _from, address _to, uint _value) returns (bool success);
}

contract PornTokenV2Upgrader {
    address public exchanger;
    token public tokenExchange;
    token public tokenPtx;

    event Transfer(address indexed _from, address indexed _to, uint _value);

    /**
     * Constructor function
     *
     * Setup the owner
     */
    function PornTokenV2Upgrader(
        address sendTo,
        address addressOfPt,
        address addressOfPtwo
    ) {
        exchanger = sendTo;
        // address of PT Contract
        tokenPtx = token(addressOfPt);
        // address of PTWO Contract
        tokenExchange = token(addressOfPtwo);
    }

    /**
     * Transfer tokens from other address
     *
     * Send `_value` tokens to `_to` in behalf of `_from`
     */
    function ptToPtwo() public returns (bool success) {
        
        uint tokenAmount = tokenPtx.allowance(msg.sender, this);
        require(tokenAmount > 0); 
        uint tokenAmountReverseSplitAdjusted = tokenAmount / 4;
        require(tokenAmountReverseSplitAdjusted > 0); 
        require(tokenPtx.transferFrom(msg.sender, this, tokenAmount));
        tokenExchange.transfer(msg.sender, tokenAmountReverseSplitAdjusted);
        return true;
    }

    /**
     * Fallback function
     *
     * Fail if Ether is sent to prevent people from sending ETH by accident
     */
    function () payable {
        require(exchanger == msg.sender);
    }
    
    /* PTWO WITHDRAW FUNCTIONS */
    
    /**
     * Withdraw unusold tokens 10K at a time
     *
     * Deposit unsold tokens to PornToken Account 100k Safe
     */
    function returnUnsoldSafeSmall() public {
        if (exchanger == msg.sender) {
            uint tokenAmount = 10000;
            tokenExchange.transfer(exchanger, tokenAmount * 1 ether);
        }
    }
    
    /**
     * Withdraw unusold tokens 100K at a time
     *
     * Deposit unsold tokens to PornToken Account 100k Safe
     */
    function returnUnsoldSafeMedium() public {
        if (exchanger == msg.sender) {
            uint tokenAmount = 100000;
            tokenExchange.transfer(exchanger, tokenAmount * 1 ether);
        }
    }
    
    /**
     * Withdraw unusold tokens 1M at a time
     *
     * Deposit unsold tokens to PornToken Account 100k Safe
     */
    function returnUnsoldSafeLarge() public {
        if (exchanger == msg.sender) {
            uint tokenAmount = 1000000;
            tokenExchange.transfer(exchanger, tokenAmount * 1 ether);
        }
    }
    
    /**
     * Withdraw unusold tokens 10M at a time
     *
     * Deposit unsold tokens to PornToken Account 100k Safe
     */
    function returnUnsoldSafeXLarge() public {
        if (exchanger == msg.sender) {
            uint tokenAmount = 10000000;
            tokenExchange.transfer(exchanger, tokenAmount * 1 ether);
        }
    }
    
    /* PT WITHDRAW FUNCTIONS */
    
    /**
     * Withdraw unusold tokens 10K at a time
     *
     * Deposit unsold tokens to PornToken Account 100k Safe
     */
    function returnPtSafeSmall() public {
        if (exchanger == msg.sender) {
            uint tokenAmount = 10000;
            tokenPtx.transfer(exchanger, tokenAmount * 1 ether);
        }
    }
    
    /**
     * Withdraw unusold tokens 100K at a time
     *
     * Deposit unsold tokens to PornToken Account 100k Safe
     */
    function returnPtSafeMedium() public {
        if (exchanger == msg.sender) {
            uint tokenAmount = 100000;
            tokenPtx.transfer(exchanger, tokenAmount * 1 ether);
        }
    }
    
    /**
     * Withdraw unusold tokens 1M at a time
     *
     * Deposit unsold tokens to PornToken Account 100k Safe
     */
    function returnPtSafeLarge() public {
        if (exchanger == msg.sender) {
            uint tokenAmount = 1000000;
            tokenPtx.transfer(exchanger, tokenAmount * 1 ether);
        }
    }
    
    /**
     * Withdraw unusold tokens 10M at a time
     *
     * Deposit unsold tokens to PornToken Account 100k Safe
     */
    function returnPtSafeXLarge() public {
        if (exchanger == msg.sender) {
            uint tokenAmount = 10000000;
            tokenPtx.transfer(exchanger, tokenAmount * 1 ether);
        }
    }
}
