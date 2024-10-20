// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IUnsecuredPool} from "../interfaces/IUnsecuredPool.sol";

abstract contract ERC20Base is ERC20 {
	modifier onlyUnsecuredPool() {
		require(_msgSender() == address(unsecuredPool), "CALLER_MUST_BE_UNSECUREDPOOL");
		_;
	}

	mapping(address => uint128) internal _additionalUserData;
	IUnsecuredPool public unsecuredPool;
	uint8 private _decimals;

	constructor(
		IUnsecuredPool _unsecuredPool,
		string memory name,
		string memory symbol,
		uint8 newDecimals
	) ERC20(name, symbol){
		unsecuredPool = _unsecuredPool;
		_setDecimals(newDecimals);
	}

	function decimals() public view virtual override returns (uint8) {
		return _decimals;
	}

	function _setDecimals(uint8 newDecimals) internal {
		_decimals = newDecimals;
	}
}