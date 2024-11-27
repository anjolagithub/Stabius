// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.24;

import {DecentralisedStableCoin} from "./DecentralisedStableCoin.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DSCEngine is ReentrancyGuard {

    //Errors
    error DSCEngine_NeedsMoreThanZero();
    error DSCEngine_TokenAddressesAndPriceFeedAddressesMustHaveSameLength();
    error DSCEngine_TokenNotSupported();
    error DSCEngine_TransferFailed();


    // State variables
    mapping(address token => address priceFeed) private s_priceFeeds; // Mapping from token to price feed
    mapping(address user => mapping(address token => uint256 amount));
    private s_collateralDeposit; // Mapping from user to token to collateral
    mapping(address user => uint256 amountDscMinted) private s_DSCMinted; // Mapping from user to DSC balance

    DecentralisedStableCoin private immutable i_dsc; // Decentralised stable coin

    // Events
    event CollateralDeposited(address indexed user, address indexed token, uint256 amount);

    // Modifiers
    modifier moreThanZero(uint256 _amount) {
        if(_amount == 0){
            revert DSCEngine_NeedsMoreThanZero();
        }
        _;
    }

    modifier isAllowedToken`{
       if(s_priceFeeds[token] == address(0)){
           revert DSCEngine_TokenNotSupported();
       }
        _;
    }

    // Functions
    constructor(
    address[] memory tokenAddresses, 
    address[] memory priceFeedAddresses 
    address dscAddress
    ) {
         // Initialize price feeds
         //USD price feed
        if (tokenAddresses.length != priceFeedAddresses.length) {
            revert DSCEngine_TokenAddressesAndPriceFeedAddressesMustHaveSameLength();
        }
        //For example, if tokenAddresses = [token1, token2, token3] and priceFeedAddresses = [priceFeed1, priceFeed2, priceFeed3]
        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            s_priceFeeds[tokenAddresses[i]] = priceFeedAddresses[i];
        }

        i_dsc = DecentralisedStableCoin(dscAddress);

    }


    {
        // Initialize price feeds
    }


    function depositCollateralAndMintDsc() external {
        // Deposit collateral
        // Mint DSC
    }
    function depositCollateral(
    address tokenCollateralAddress,
    uint256 amountCollateral
    
    ) 
    
    external 
    moreThanZero(amountCollateral) 
    isAllowedToken(tokenCollateralAddress) 
    nonReentrant

    {
        // Deposit collateral
        s_collateralDeposit[msg.sender][tokenCollateralAddress] += amountCollateral;
        emit CollateralDeposited(msg.sender, tokenCollateralAddress, amountCollateral);
        bool success = IERC20(tokenCollateralAddress).transferFrom(msg.sender, address(this), amountCollateral);
        if (!success) {
            revert DSCEngine_TransferFailed();
        }

    }
    
    }
    function redeemCollateralForDsc() external {
        // Redeem collateral
        // Burn DSC
    }
    function redeemCollateral() external {
        // Redeem collateral
    }
/*
* @notice follows CEI
* @param amountDscToMint amount of DSC to mint
* @notice they must have collateral
*/
    
    function mintDsc(uint256 amountDscToMint ) external moreThanZero(amountDscToMint)
     nonReentrant {
        s_DSCMinted(msg.sender) == amountDscToMint;
        //Check if they minted too much
        revert();
        // Mint DSC
    }
    function burnDscAndWithdrawCollateral() external {
        // Burn DSC
        // Withdraw collateral
    }

    function liquidateDsc() external {
        // Liquidate DSC
    }

    function getHealthFactor() external view returns (uint256) {
        // Get health factor
    }

    function  revertIfHealthFactorIsBroken(address user) internal view{
        
    }
}
