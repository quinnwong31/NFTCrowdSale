pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


/**
 * KaseiCoinCrowdsale
 */
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale { 
    
    // The consttructor for KaseiCoinCrowdsale
    constructor(
        uint rate,
        address payable wallet, // sale beneficiary
        KaseiCoin token
    ) public Crowdsale(rate, wallet, token) {
        // constructor can stay empty
    }
}

/**
 * KaseiCoinCrowdsaleDeployer
 */
contract KaseiCoinCrowdsaleDeployer {
    address public kasei_token_address;
    address public kasei_crowdsale_address;

    // The consttructor for KaseiCoinCrowdsaleDeployer
    constructor(
       string memory name, 
       string memory symbol,
       address payable wallet
    ) public {
        // Create a new instance of the KaseiCoin contract.
        KaseiCoin token = new KaseiCoin(name, symbol, 0);
        
        // Assign the token contract’s address to the `kasei_token_address` variable.
        kasei_token_address = address(token);

        // Create a new instance of the `KaseiCoinCrowdsale` contract
        KaseiCoinCrowdsale crowdsale = new KaseiCoinCrowdsale(1, wallet, token);
            
        // Aassign the `KaseiCoinCrowdsale` contract’s address to the `kasei_crowdsale_address` variable.
        kasei_crowdsale_address = address(crowdsale);

        // Set the `KaseiCoinCrowdsale` contract as a minter
        token.addMinter(kasei_crowdsale_address);
        
        // Have the `KaseiCoinCrowdsaleDeployer` renounce its minter role.
        token.renounceMinter();
    }
}