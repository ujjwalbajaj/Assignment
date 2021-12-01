// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.6;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/utils/TokenTimelock.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

// interface ITokenTimelock {
//     function release() external;
// }

contract Thoritos is ERC20PresetMinterPauser {

   mapping (address => TokenTimelock) userLockedAmounts;
    constructor() ERC20PresetMinterPauser("Thoritos", "THOR") {
        _mint(msg.sender, 100000 * (10**8));
        
    }

    function decimals() public pure override returns (uint8) {
        return 8;
    }

    function lockToken(uint256 lockAmount, uint256 releaseTime) external {
        TokenTimelock timelockInstance = new TokenTimelock(
            IERC20(address(this)), msg.sender, releaseTime
        );

        userLockedAmounts[msg.sender] = timelockInstance;

        _transfer(msg.sender, address(userLockedAmounts[msg.sender]), lockAmount);
    }

    function releaseToken(uint256 releaseAmount) external{
        
        userLockedAmounts[msg.sender].release();
    }
} 
