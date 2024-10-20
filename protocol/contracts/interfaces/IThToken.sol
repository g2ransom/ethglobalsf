// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IScaledBalanceToken} from "./IScaledBalanceToken.sol";

interface IThToken is IScaledBalanceToken, IERC20 {
	function mint(address user, uint256 amount, uint256 index) external;
	function burn(address user, uint256 amount, uint256 index) external;
	function approveDelegation(address user, uint256 amount) external;
}