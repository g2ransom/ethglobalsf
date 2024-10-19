// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

library Types {
	struct Reserve {
		uint16 id;
		uint128 liquidityIndex;
		uint128 currentLiquidityIndex;
		uint8 decimals;
		address aTokenAddress;
    	address stableDebtTokenAddress;
    	address thTokenAddress;
    	address unsecuredDebtTokenAddress;
    	uint40 lastUpdateTimestamp;
    	uint128 accruedToTreasury;
    	uint128 accruedToGrants;
    	uint256 protocolMargin;
	}

	struct Loan {
		uint128 id;
		uint256 amount;
		address underlyingAsset;
		uint256 rate;
		uint40 lastRepaymentTimestamp;
		uint40 creationTimestamp;
		uint40 expirationTimestamp;
		uint8 paymentSchedule;
		bool deliquent;
	}
}