// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

interface IUnsecuredPool {
	event Supply(address indexed reserve, address indexed user, uint256 amount);
	event Withdraw(address indexed reserve, address indexed user, uint256 amount);
	event OriginateLoan(
		uint128 indexed id,
		uint128 rate,
		address indexed operator,
		address indexed reserve,
		uint256 amount,
		uint8 paymentSchedule,
		uint40 expirationTimestamp
	);
	event LoanRepaid(uint128 indexed id, address indexed operator, address indexed reserve);
	event Repay(
		uint128 indexed id,
		address indexed operator,
		address indexed reserve,
		uint256 amount
	);

	function supply(address asset, uint256 amount) external;
	function withdraw(address asset, uint256 amount) external;
	function originateLoan(
		address asset,
		uint256 amount,
		uint8 paymentSchedule,
		uint128 rate,
		uint40 termDays
	) external;
	function repay(address asset, uint128 loanId, uint256 amount) external;
	function addReserve(
		address asset, 
		address aTokenAddress, 
		address stableDebtTokenAddress, 
		address thTokenAddress,
		address unsecuredDebtTokenAddress,
		uint8 decimals
	) external;
}