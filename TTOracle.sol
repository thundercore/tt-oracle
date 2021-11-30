// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

library Denominations {
    // HEX("Thunder Token")
    address public constant TT = 0x000000000000005468756E64657220546F6B656e;

    // TT-USDT
    address public constant USDT = 0x4f3C8E20942461e2c3Bdd8311AC57B0c222f2b82;
}

interface DataFeedConsumerInterface {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    function hasRoundData(uint80 roundId) external view returns (bool);

    function getRoundData(uint80 _roundId)
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );


    /** @dev return 0 if no previous round id */
    function getPreviousRoundId(uint80 roundId) external view returns (uint80);

    /** @dev return 0 if no next round id */
    function getNextRoundId(uint80 roundId) external view returns (uint80);

    event AnswerUpdated(
        int256 indexed current,
        uint256 indexed roundId,
        uint256 updatedAt
    );

    event NewRound(
        uint256 indexed roundId,
        address indexed startedBy,
        uint256 startedAt
    );
}

interface DataFeedAdminInterface {
    event RoundPurged(uint80 indexed roundId, uint256 timestamp);
    event RoundSkipped(uint80 indexed roundId, uint256 timestamp);
}

interface DataFeedInterface is
    DataFeedConsumerInterface,
    DataFeedAdminInterface
{}

interface FeedRegistryConsumerInterface {
    function latestRoundData(string calldata pair) external view returns (
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
    );

    function getRoundData(string calldata pair, uint80 _roundId) external view returns (
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
    );

    function getFeed(string calldata pair) external view returns (address feedAddress);
}

interface FeedRegistryChainlinkConsumerInterface {
    function decimals(address base, address quote)
        external
        view
        returns (uint8);

    function description(address base, address quote)
        external
        view
        returns (string memory);

    function version(address base, address quote)
        external
        view
        returns (uint256);

    function latestRoundData(address base, address quote)
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );

    function getRoundData(
        address base,
        address quote,
        uint80 _roundId
    )
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );

    function getFeed(address base, address quote)
        external
        view
        returns (address feedAddress);

    function isFeedEnabled(address feedAddress) external view returns (bool);

    function getPreviousRoundId(
        address base,
        address quote,
        uint80 roundId
    ) external view returns (uint80 previousRoundId);

    function getNextRoundId(
        address base,
        address quote,
        uint80 roundId
    ) external view returns (uint80 nextRoundId);
}

interface FeedRegistryInterface is
    FeedRegistryConsumerInterface,
    FeedRegistryChainlinkConsumerInterface
{}
