// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {IScaledBalanceToken} from "../interfaces/IScaledBalanceToken.sol";
import {IUnsecuredPool} from "../interfaces/IUnsecuredPool.sol";
import {ERC20Base} from "./ERC20Base.sol";
import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";
import {WadRayMath} from "../math/WadRayMath.sol";


contract ScaledBalanceToken is IScaledBalanceToken, ERC20Base {
	using WadRayMath for uint256;
	using SafeCast for uint256;

	constructor(
		IUnsecuredPool _unsecuredPool,
		string memory name,
		string memory symbol,
		uint8 newDecimals
	) ERC20Base(_unsecuredPool, name, symbol, newDecimals) {

	}

	function scaledBalanceOf(address user) external view returns(uint256) {
		return super.balanceOf(user);
	}

	function scaledTotalSupply() public view virtual override returns (uint256) {
		return super.totalSupply();
	}

	function getPreviousIndex(address user) external view returns (uint256) {
		return _additionalUserData[user];
	}

	function _mintScaled(
		address caller,
		uint256 amount,
		uint256 index
	) internal {
		uint256 amountScaled = amount.rayDiv(index);
		require(amountScaled != 0, "INVALID_MINT_AMOUNT");

		uint256 scaledBalance = super.balanceOf(caller);
		uint256 balanceIncrease = scaledBalance.rayMul(index) -
			scaledBalance.rayMul(_additionalUserData[caller]);

		_additionalUserData[caller] = index.toUint128();
		_mint(caller, amountScaled.toUint128());
		uint256 amountToMint = amount + balanceIncrease;
		emit Mint(caller, amountToMint, balanceIncrease, index);
	}

	function _burnScaled(
		address caller,
		uint256 amount,
		uint256 index
	) internal {
		uint256 amountScaled = amount.rayDiv(index);
		require(amountScaled != 0, "INVALID_BURN_AMOUNT");

		uint256 scaledBalance = super.balanceOf(caller);
		uint balanceIncrease = scaledBalance.rayMul(index) -
			scaledBalance.rayMul(_additionalUserData[caller]);

		_additionalUserData[caller] = index.toUint128();
		_burn(caller, amountScaled.toUint128());
		if (amount < balanceIncrease) {
			uint256 amountToMint = balanceIncrease - amount;
      		emit Mint(caller, amountToMint, balanceIncrease, index);
		} else {
			uint256 amountToBurn = amount - balanceIncrease;
			emit Burn(caller, amountToBurn, balanceIncrease, index);
		}
	}
}