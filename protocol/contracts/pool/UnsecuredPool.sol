// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {ICreditDelegationToken} from "@aave/core-v3/contracts/interfaces/ICreditDelegationToken.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Types} from "../types/Types.sol";
import {IUnsecuredPool} from "../interfaces/IUnsecuredPool.sol";
import {UnsecuredPoolStorage} from "./UnsecuredPoolStorage.sol";


contract UnsecuredPool is IUnsecuredPool, UnsecuredPoolStorage, Ownable {
	
	constructor(
		IPoolAddressesProvider _provider
	) Ownable(msg.sender) {
		ADDRESSES_PROVIDER = _provider;
		POOL = IPool(_provider.getPool());
	}

	function supply(address asset, uint256 amount) public {
		Types.Reserve storage reserve = _reserves[asset];
		// IERC20(asset).transferFrom(msg.sender, address(this), amount);
		POOL.supply(asset, amount, reserve.thTokenAddress, 0);
		// IER20(reserve.thTokenAddress).mint(msg.sender, amount);
	}

	function withdraw(address asset, uint256 amount) public {
		Types.Reserve storage reserve = _reserves[asset];
		POOL.withdraw(asset, amount, msg.sender);
		// IERC20(reserve.thTokenAddress).burn(msg.sender, amount);
	}
	
	function originateLoan(
		address asset,
		uint256 amount,
		uint8 paymentSchedule,
		uint128 rate,
		uint40 termDays
	) external onlyOwner {
		Types.Reserve storage reserve = _reserves[asset];
		// IERC20(reserve.thTokenAddress).approveDelegation(msg.sender, amount);
		POOL.borrow(asset, amount, 2, 0, msg.sender);
	}

	function repay(address asset, uint128 loanId, uint256 amount, address onBehalfOf) public {
		Types.Reserve storage reserve = _reserves[asset];
		POOL.repay(asset, amount, 2, onBehalfOf);
	}

	function addReserve(
		address asset, 
		address aTokenAddress, 
		address stableDebtTokenAddress, 
		address thTokenAddress,
		address unsecuredDebtTokenAddress,
		uint8 decimals
	) external onlyOwner {

	}

	function _updateIndexes(
		Types.Reserve storage reserve
	) internal {

	}
}
