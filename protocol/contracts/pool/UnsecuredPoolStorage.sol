// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Types} from "../types/Types.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";


contract UnsecuredPoolStorage {
	mapping(address => Types.Reserve) internal _reserves;
	mapping(uint256 => Types.Loan) internal _loans;
	IPoolAddressesProvider public immutable ADDRESSES_PROVIDER;
	IPool public immutable POOL;
}
