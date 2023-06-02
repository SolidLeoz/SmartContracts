// SPDX-License-Identifier: MIT


pragma solidity ^0.8.0;

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address who) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}
//safeMath library 
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}


//interface pancakeFactory
interface IPancakeFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;

    function INIT_CODE_PAIR_HASH() external view returns (bytes32);
}

//interface pancakeRouter1
interface IPancakeRouter01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

//interface pancakeRouter2
interface IPancakeRouter02 is IPancakeRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

contract Lock is IERC20 {
    using SafeMath for uint256;
    //interfacePancake
    IPancakeRouter02 private pancakeRouter;
    IPancakeFactory private pancakeFactory;

    // Token information
    string private _name;
    string private _symbol;
    uint256 private _totalSupply;
    uint8 private _decimals;

    // Token percentages
    uint256 private _burnPercentage;
    uint256 private _reflectionPercentage;
    uint256 private _devFeePercentage;
    uint256 private _marketingFeePercentage;
    uint256 private _teamFeePercentage;

    //update balance fee
    uint256 private _totalDevFee;
    uint256 private _totalMarketingFee;
    uint256 private _totalTeamFee;


    // Token wallets
    address private _owner;
    address private _devWallet;
    address private _marketingWallet;
    address private _teamWallet;
    address[] private _holders;
    

    // Anti-whale system
    uint256 private _maxWalletPercentage = 100;

    // Balances and allowances
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    event Burn(address indexed from, uint256 amount);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event TransferWithReflection(address indexed from, address indexed to, uint256 amount, uint256 reflectionAmount);

    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the contract owner can call this function");
        _;
    }

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 totalSupply_,
        uint8 decimals_,
        address devWallet,
        address marketingWallet,
        address teamWallet 
    ) {
        _name = name_;
        _symbol = symbol_;
        _totalSupply = totalSupply_;
        _decimals = decimals_;

        _balances[msg.sender] = totalSupply_;
        _owner = msg.sender;
        _devWallet = devWallet;
        _marketingWallet = marketingWallet;
        _teamWallet = teamWallet;

        // Set default percentages to 0
        _burnPercentage = 6;
        _reflectionPercentage = 1;
        _devFeePercentage = 1;
        _marketingFeePercentage = 1;
        _teamFeePercentage = 1;

        // Set max wallet percentage to 0 (inactive)
        _maxWalletPercentage = 100;

        // Inizialize router PancakeSwap
        //NB: confirm the address of pancakeswapRouterV2
        pancakeRouter = IPancakeRouter02(0x10ED43C718714eb63d5aA57B78B54704E256024E);
        // Inizialize PancakeFactory
        //NB: confirm the address of pancakeswapRouterV2
        pancakeFactory = IPancakeFactory(0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73);
    }

    // Returns the name of the token
    function name() public view returns (string memory) {
        return _name;
    }

    // Returns the symbol of the token
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    // Returns the number of decimal places for the token
    function decimals() public view returns (uint8) {
        return _decimals;
    }
  
    // Returns the total supply of the token
    function totalSupply() public view override returns (uint256) {
        return _totalSupply.sub(_balances[address(0)]);
    }

    // Returns the contract owner 
    function getOwner() public view returns (string memory) {
    if (_owner == address(0)) {
        return "renounced";
    } else {
        return addressToString(_owner);
    }
    }

    function addressToString(address account) private pure returns (string memory) {
        bytes32 value = bytes32(uint256(uint160(account)));
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(42);
        str[0] = "0";
        str[1] = "x";
        for (uint256 i = 0; i < 20; i++) {
        str[2 + i * 2] = alphabet[uint8(value[i + 12] >> 4)];
        str[3 + i * 2] = alphabet[uint8(value[i + 12] & 0x0f)];
        }
        return string(str);
    }



    // Allows the contract owner to renounce their ownership
    function renounceOwnership() external onlyOwner {
        address previousOwner = _owner;
        _owner = address(0);
        emit OwnershipTransferred(previousOwner, address(0));
    }

    // Burns a specified amount of tokens
    function burn(uint256 amount) external returns (bool) {
        address sender = msg.sender;
        require(_balances[sender] >= amount, "Insufficient balance");

        // Update balances
        _balances[sender] = _balances[sender].sub(amount);
        _totalSupply = _totalSupply.sub(amount);

        // Emit burn event
        emit Burn(sender, amount);

        return true;
    }

    // Sets the burn percentage for token transfers
    function setBurnPercentage(uint256 percentage) external onlyOwner {
        require(percentage <= 100, "Invalid burn percentage");
        _burnPercentage = percentage;
    }

    // Returns the current burn percentage
    function getBurnPercentage() public view returns (uint256) {
        return _burnPercentage;
    }

    // Sets the reflection percentage for token transfers
    function setReflectionPercentage(uint256 percentage) external onlyOwner {
        require(percentage <= 100, "Invalid reflection percentage");
        _reflectionPercentage = percentage;
    }

    // Returns the current reflection percentage
    function getReflectionPercentage() public view returns (uint256) {
        return _reflectionPercentage;
    }

    // Sets the dev fee percentage for token transfers
    function setDevFeePercentage(uint256 percentage) external onlyOwner {
        require(percentage <= 100, "Invalid dev fee percentage");
        _devFeePercentage = percentage;
    }

    // Returns the current dev fee percentage
    function getDevFeePercentage() public view returns (uint256) {
        return _devFeePercentage;
    }

    // Sets the marketing fee percentage for token transfers
    function setMarketingFeePercentage(uint256 percentage) external onlyOwner {
        require(percentage <= 100, "Invalid marketing fee percentage");
        _marketingFeePercentage = percentage;
    }

    // Returns the current marketing fee percentage
    function getMarketingFeePercentage() public view returns (uint256) {
        return _marketingFeePercentage;
    }

    // Sets the team fee percentage for token transfers
    function setTeamFeePercentage(uint256 percentage) external onlyOwner {
        require(percentage <= 100, "Invalid team fee percentage");
        _teamFeePercentage = percentage;
    }

    // Returns the current team fee percentage
    function getTeamFeePercentage() public view returns (uint256) {
        return _teamFeePercentage;
    }

    // Sets the dev wallet address
    function setDevWallet(address wallet) external onlyOwner {
        require(wallet != address(0), "Invalid wallet address");
        _devWallet = wallet;
    }

    // Returns the dev wallet address
    function getDevWallet() public view returns (address) {
        return _devWallet;
    }

    // Sets the marketing wallet address
    function setMarketingWallet(address wallet) external onlyOwner {
        require(wallet != address(0), "Invalid wallet address");
        _marketingWallet = wallet;
    }

    // Returns the marketing wallet address
    function getMarketingWallet() public view returns (address) {
        return _marketingWallet;
    }

    // Sets the team wallet address
    function setTeamWallet(address wallet) external onlyOwner {
        require(wallet != address(0), "Invalid wallet address");
        _teamWallet = wallet;
    }

    // Returns the team wallet address
    function getTeamWallet() public view returns (address) {
        return _teamWallet;
    }

    // Sets the maximum wallet percentage allowed
    function setMaxWalletPercentage(uint256 percentage) external onlyOwner {
    require(percentage <= 100, "Invalid maximum wallet percentage");
    _maxWalletPercentage = percentage;
    }


    // Returns the current maximum wallet percentage allowed
    function getMaxWalletPercentage() public view returns (uint256) {
        return _maxWalletPercentage;
    }

    // Returns the balance of the specified account
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    // Pancake factory Pair 
    function createPair(address tokenA, address tokenB) external {
        // Utilizza il metodo createPair del Factory Contract
        pancakeFactory.createPair(tokenA, tokenB);
    }

    // gret Factory Pair
    function getPair(address tokenA, address tokenB) external view returns (address) {
        // Utilizza il metodo getPair del Factory Contract
        return pancakeFactory.getPair(tokenA, tokenB);
    }


    //Pancake swapToken
    function swapTokensForTokens(
    address tokenIn,
    uint256 amountIn,
    address tokenOut,
    uint256 amountOutMin,
    address to,
    uint256 deadline
        ) external {
            
    // Approva l'importo dei token di input per il router di PancakeSwap
    IERC20(tokenIn).approve(address(pancakeRouter), amountIn);

    // Effettua lo swap sui token
    pancakeRouter.swapExactTokensForTokens(
        amountIn,
        amountOutMin,
        getPathForTokens(tokenIn, tokenOut),
        to,
        deadline
    );
    }

    function getPathForTokens(address tokenIn, address tokenOut) private pure returns (address[] memory) {
        address[] memory path = new address[](2);
        path[0] = tokenIn;
        path[1] = tokenOut;
        return path;
    }

    // Transfers a specified amount of tokens from the sender to the recipient
function transfer(address recipient, uint256 amount) public override returns (bool) {
    address sender = msg.sender;
    require(_balances[sender] >= amount, "Insufficient balance");

    // Check if anti-whale system is active
    if (_maxWalletPercentage > 0 && sender != _owner) {
        uint256 maxWalletBalance = _totalSupply.mul(_maxWalletPercentage).div(100);
        require(_balances[recipient].add(amount) <= maxWalletBalance, "Transfer would exceed the maximum wallet balance");
    }

    // Exclude owner from fees and reflection
    bool isExcludedFromFees = (sender == _owner || recipient == _owner);
    bool isExcludedFromReflection = (sender == _owner);

    // Calculate fee amounts
    uint256 burnAmount = isExcludedFromFees ? 0 : amount.mul(_burnPercentage).div(100);
    uint256 reflectionAmount = isExcludedFromFees || isExcludedFromReflection ? 0 : amount.mul(_reflectionPercentage).div(100);
    uint256 devFeeAmount = isExcludedFromFees ? 0 : amount.mul(_devFeePercentage).div(100);
    uint256 marketingFeeAmount = isExcludedFromFees ? 0 : amount.mul(_marketingFeePercentage).div(100);
    uint256 teamFeeAmount = isExcludedFromFees ? 0 : amount.mul(_teamFeePercentage).div(100);

    // Subtract fee amounts from the transfer amount
    uint256 transferAmount = amount;
    transferAmount = transferAmount.sub(burnAmount);
    transferAmount = transferAmount.sub(reflectionAmount);
    transferAmount = transferAmount.sub(devFeeAmount);
    transferAmount = transferAmount.sub(marketingFeeAmount);
    transferAmount = transferAmount.sub(teamFeeAmount);
    
    // Update balances
    _balances[sender] = _balances[sender].sub(amount);
    _balances[recipient] = _balances[recipient].add(transferAmount);
    _balances[address(0)] = _balances[address(0)].add(burnAmount);
    _balances[_devWallet] = _balances[_devWallet].add(devFeeAmount);
    _balances[_marketingWallet] = _balances[_marketingWallet].add(marketingFeeAmount);
    _balances[_teamWallet] = _balances[_teamWallet].add(teamFeeAmount);

    // Update total fee amounts
    if (!isExcludedFromFees) {
        _totalDevFee = _totalDevFee.add(devFeeAmount);
        _totalMarketingFee = _totalMarketingFee.add(marketingFeeAmount);
        _totalTeamFee = _totalTeamFee.add(teamFeeAmount);
    }

    // Distribute reflection amount to all holders
    if (!isExcludedFromReflection) {
        uint256 totalReflectionAmount = reflectionAmount;
        uint256 totalHolders = _holders.length;
        uint256 distributedReflectionAmount = 0;

        for (uint256 i = 0; i < totalHolders; i++) {
            address holder = _holders[i];
            uint256 holderBalance = _balances[holder];

            uint256 holderReflectionAmount = reflectionAmount.mul(holderBalance).div(_totalSupply);
            _balances[holder] = holderBalance.add(holderReflectionAmount);
            distributedReflectionAmount = distributedReflectionAmount.add(holderReflectionAmount);
            emit TransferWithReflection(address(0), holder, holderReflectionAmount, holderReflectionAmount);
        }

        uint256 remainingReflectionAmount = totalReflectionAmount.sub(distributedReflectionAmount);
        _balances[address(this)] = _balances[address(this)].add(remainingReflectionAmount);
        emit TransferWithReflection(address(0), address(this), remainingReflectionAmount, remainingReflectionAmount);
    }

    // Emit transfer and fee events
    emit Transfer(sender, recipient, transferAmount);
    if (!isExcludedFromFees) {
        emit Burn(sender, burnAmount);
        emit TransferWithReflection(sender, address(0), reflectionAmount, reflectionAmount);
        emit TransferWithReflection(sender, _devWallet, reflectionAmount.mul(_devFeePercentage).div(100), reflectionAmount);
        emit TransferWithReflection(sender, _marketingWallet, reflectionAmount.mul(_marketingFeePercentage).div(100), reflectionAmount);
        emit TransferWithReflection(sender, _teamWallet, reflectionAmount.mul(_teamFeePercentage).div(100), reflectionAmount);
    }

    return true;
}


function _distributeReflection(uint256 reflectionAmount) private {
    uint256 totalHolders = _holders.length;
    uint256 distributedReflectionAmount = 0;

    for (uint256 i = 0; i < totalHolders; i++) {
        address holder = _holders[i];
        uint256 holderBalance = _balances[holder];

        uint256 holderReflectionAmount = reflectionAmount.mul(holderBalance).div(_totalSupply);
        _balances[holder] = holderBalance.add(holderReflectionAmount);
        distributedReflectionAmount = distributedReflectionAmount.add(holderReflectionAmount);
        emit Transfer(address(0), holder, holderReflectionAmount);
    }

    uint256 remainingReflection = reflectionAmount.sub(distributedReflectionAmount);
    _balances[address(this)] = _balances[address(this)].add(remainingReflection);
    emit Transfer(address(0), address(this), remainingReflection);
}

    // Transfers a specified amount of tokens from one account to another on behalf of the owner
function transferFrom(
    address sender,
    address recipient,
    uint256 amount
) public override returns (bool) {
    require(_balances[sender] >= amount, "Insufficient balance");
    require(_allowances[sender][msg.sender] >= amount, "Insufficient allowance");

    // Check if anti-whale system is active
    if (_maxWalletPercentage > 0 && recipient != _owner) {
        uint256 maxWalletBalance = _totalSupply.mul(_maxWalletPercentage).div(100);
        require(_balances[recipient].add(amount) <= maxWalletBalance, "Transfer would exceed the maximum wallet balance");
    }

    // Exclude owner from fees and reflection
    bool isExcludedFromFees = (sender == _owner || recipient == _owner);
    bool isExcludedFromReflection = (sender == _owner);

    // Subtract the amount from the allowance
    _allowances[sender][msg.sender] = _allowances[sender][msg.sender].sub(amount);

    // Calculate burn and reflection amounts
    uint256 burnAmount = isExcludedFromFees ? 0 : amount.mul(_burnPercentage).div(100);
    uint256 reflectionAmount = isExcludedFromFees || isExcludedFromReflection ? 0 : amount.mul(_reflectionPercentage).div(100);
    uint256 devFeeAmount = isExcludedFromFees ? 0 : amount.mul(_devFeePercentage).div(100);
    uint256 marketingFeeAmount = isExcludedFromFees ? 0 : amount.mul(_marketingFeePercentage).div(100);
    uint256 teamFeeAmount = isExcludedFromFees ? 0 : amount.mul(_teamFeePercentage).div(100);

    // Subtract the total transfer amount from the sender's balance
    _balances[sender] = _balances[sender].sub(amount);

    // Subtract the burn amount from the total supply
    if (!isExcludedFromFees) {
        _totalSupply = _totalSupply.sub(burnAmount);
    }

    // Subtract the total fee amounts from the sender's balance
    if (!isExcludedFromFees) {
        _balances[sender] = _balances[sender].sub(reflectionAmount);
        _balances[sender] = _balances[sender].sub(devFeeAmount);
        _balances[sender] = _balances[sender].sub(marketingFeeAmount);
        _balances[sender] = _balances[sender].sub(teamFeeAmount);
    }

    // Add the transfer amount to the recipient's balance
    _balances[recipient] = _balances[recipient].add(amount).sub(burnAmount);

    // Add the burn amount to the burn wallet's balance
    if (!isExcludedFromFees) {
        _balances[address(0)] = _balances[address(0)].add(burnAmount);
    }

    // Add the fee amounts to the respective wallets' balances
    if (!isExcludedFromFees) {
        _balances[_devWallet] = _balances[_devWallet].add(devFeeAmount);
        _balances[_marketingWallet] = _balances[_marketingWallet].add(marketingFeeAmount);
        _balances[_teamWallet] = _balances[_teamWallet].add(teamFeeAmount);
    }

    // Update total fee amounts
    if (!isExcludedFromFees) {
        _totalDevFee = _totalDevFee.add(devFeeAmount);
        _totalMarketingFee = _totalMarketingFee.add(marketingFeeAmount);
        _totalTeamFee = _totalTeamFee.add(teamFeeAmount);
    }

    // Emit transfer and fee events
    emit Transfer(sender, recipient, amount);
    if (!isExcludedFromFees) {
        emit Burn(sender, burnAmount);
        emit TransferWithReflection(sender, address(0), reflectionAmount, reflectionAmount);
        emit TransferWithReflection(sender, _devWallet, devFeeAmount, reflectionAmount);
        emit TransferWithReflection(sender, _marketingWallet, marketingFeeAmount, reflectionAmount);
        emit TransferWithReflection(sender, _teamWallet, teamFeeAmount, reflectionAmount);
    }

    return true;
}

function _updateHolders(address sender, address recipient) private {
    if (_balances[sender] == 0) {
        // Remove sender from holders list
        for (uint256 i = 0; i < _holders.length; i++) {
            if (_holders[i] == sender) {
                _holders[i] = _holders[_holders.length - 1];
                _holders.pop();
                break;
            }
        }
    }

    if (_balances[recipient] > 0 && _balances[recipient].add(_reflectionPercentage) <= 1) {
        // Add recipient to holders list if not already present
        bool isRecipientInHolders = false;
        for (uint256 i = 0; i < _holders.length; i++) {
            if (_holders[i] == recipient) {
                isRecipientInHolders = true;
                break;
            }
        }
        if (!isRecipientInHolders) {
            _holders.push(recipient);
        }
    }
}

    // Approves a specified amount of tokens to be spent by another account
    function approve(address spender, uint256 amount) public override returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // Returns the allowance of a spender for a specific account
    function allowance(address account, address spender) public view override returns (uint256) {
        return _allowances[account][spender];
    }

    // Increase the allowance of a spender by a specified amount
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _allowances[msg.sender][spender] = _allowances[msg.sender][spender].add(addedValue);
        emit Approval(msg.sender, spender, _allowances[msg.sender][spender]);
        return true;
    }

    // Decrease the allowance of a spender by a specified amount
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        uint256 currentAllowance = _allowances[msg.sender][spender];
        require(currentAllowance >= subtractedValue, "Decreased allowance below zero");
        _allowances[msg.sender][spender] = currentAllowance.sub(subtractedValue);
        emit Approval(msg.sender, spender, _allowances[msg.sender][spender]);
        return true;
    }

    function getTotalDevFee() public view returns (uint256) {
        return _totalDevFee;
    }

    function getTotalMarketingFee() public view returns (uint256) {
        return _totalMarketingFee;
    }

    function getTotalTeamFee() public view returns (uint256) {
        return _totalTeamFee;
    }
}
