// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ICreditDelegationToken} from "@aave/core-v3/contracts/interfaces/ICreditDelegationToken.sol";
import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";
import {WadRayMath} from "../math/WadRayMath.sol";
import {IUnsecuredPool} from "../interfaces/IUnsecuredPool.sol";
import {IThToken} from "../interfaces/IThToken.sol";
import {IScaledBalanceToken} from "../interfaces/IScaledBalanceToken.sol";
import {ScaledBalanceToken} from "./ScaledBalanceToken.sol";

abstract contract ThToken is ScaledBalanceToken, IThToken {
	using WadRayMath for uint256;
	using SafeCast for uint256;

	address _aTokenAddress;
	address _asset;

	constructor(
		IUnsecuredPool _unsecuredPool,
		string memory name,
		string memory symbol,
		uint8 newDecimals,
		address aTokenAddress,
		address asset
	) ScaledBalanceToken(_unsecuredPool, name, symbol, newDecimals) {
		_aTokenAddress = aTokenAddress;
		_asset = asset;
	}

	function mint(address user, uint256 amount, uint256 index) external onlyUnsecuredPool {
		_mintScaled(user, amount, index);
	}

	function burn(address user, uint256 amount, uint256 index) external onlyUnsecuredPool {
		_burnScaled(user, amount, index);
	}

	function approveDelegation(address user, uint256 amount) external onlyUnsecuredPool {
		ICreditDelegationToken delegatedToken = ICreditDelegationToken(_aTokenAddress);
		delegatedToken.approveDelegation(user, amount);
	}
}