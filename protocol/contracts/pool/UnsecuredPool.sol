// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IUnsecuredPool} from "../interfaces/IUnsecuredPool.sol";
import {UnsecuredPoolStorage} from "./UnsecuredPoolStorage.sol";


contract UnsecuredPool is IUnsecuredPool, UnsecuredPoolStorage, Ownable {
	
	constructor(
		IPoolAddressesProvider _provider
	) Ownable(msg.sender) {
		ADDRESSES_PROVIDER = _provider;
	}

	function supply(address asset, uint256 amount) public {

	}

	function withdraw(address asset, uint256 amount) public {

	}
	
	function originateLoan(
		address asset,
		uint256 amount,
		uint8 paymentSchedule,
		uint128 rate,
		uint40 termDays
	) external onlyOwner {

	}

	function repay(address asset, uint128 loanId, uint256 amount) public {

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
}
