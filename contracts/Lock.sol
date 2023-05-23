// SPDX-License-Identifier: MIT


//#TODO: getOwnerRestituisce l'errore error:Failed to decode output: null: invalid codepoint at offset 10; unexpected continuation byte (argument="bytes", value=Uint8Arra(0x4f776e65723a200d3b07821a2425bf835c55ef6a725fd0fada7fbc), code=INVALID_ARGUMENT, version=strings/5.7.0)
//#TODO: Le funzioni totalSuppli e currentTotalSupply restituiscono lo stesso valore, sono o da fixare o da unire
//TODO: Vanno controllati i decimali del token e la total supply al momento della creazione, sembra non dare i decimali giusti
//TODO: Controllare l'impostazione antywhale perchè non deve avviarsi se impostata a 0 e deve essere 0 come valore predefinito alla creazione del token
//TODO: importare router pancakeSwap per permettere allo smartContract lo scambio tra il token creato e BNB

pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/eip/interface/IERC20.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Lock is IERC20 {
    using SafeMath for uint256;

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

    // Token wallets
    address private _owner;
    address private _devWallet;
    address private _marketingWallet;
    address private _teamWallet;

    // Anti-whale system
    uint256 private _maxWalletPercentage = 0;

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
        _maxWalletPercentage = 0;
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

    // Returns the circulating supply of the token
    function currentTotalSupply() public view returns (uint256) {
        return _totalSupply.sub(_balances[address(0)]);
    }
    

    // Returns the total supply of the token
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
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

    // Transfers a specified amount of tokens from the sender to the recipient
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        address sender = msg.sender;
        require(_balances[sender] >= amount, "Insufficient balance");

        // Check if anti-whale system is active
        if (_maxWalletPercentage > 0 && sender != _owner) {
            uint256 maxWalletBalance = _totalSupply.mul(_maxWalletPercentage).div(100);
            require(_balances[recipient].add(amount) <= maxWalletBalance, "Transfer would exceed the maximum wallet balance");
        }

        // Calculate burn and reflection amounts
        uint256 burnAmount = amount.mul(_burnPercentage).div(100);
        uint256 reflectionAmount = amount.mul(_reflectionPercentage).div(100);
        uint256 totalFeeAmount = burnAmount.add(reflectionAmount);
        uint256 transferAmount = amount.sub(totalFeeAmount);

        // Update balances
        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(transferAmount);
        _balances[address(0)] = _balances[address(0)].add(burnAmount);
        _balances[_devWallet] = _balances[_devWallet].add(reflectionAmount.mul(_devFeePercentage).div(100));
        _balances[_marketingWallet] = _balances[_marketingWallet].add(reflectionAmount.mul(_marketingFeePercentage).div(100));
        _balances[_teamWallet] = _balances[_teamWallet].add(reflectionAmount.mul(_teamFeePercentage).div(100));

        // Emit transfer and fee events
        emit Transfer(sender, recipient, transferAmount);
        emit Burn(sender, burnAmount);
        emit TransferWithReflection(sender, address(0), reflectionAmount, reflectionAmount);
        emit TransferWithReflection(sender, _devWallet, reflectionAmount.mul(_devFeePercentage).div(100), reflectionAmount);
        emit TransferWithReflection(sender, _marketingWallet, reflectionAmount.mul(_marketingFeePercentage).div(100), reflectionAmount);
        emit TransferWithReflection(sender, _teamWallet, reflectionAmount.mul(_teamFeePercentage).div(100), reflectionAmount);

        return true;
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

        // Calculate burn and reflection amounts
        uint256 burnAmount = amount.mul(_burnPercentage).div(100);
        uint256 reflectionAmount = amount.mul(_reflectionPercentage).div(100);
        uint256 totalFeeAmount = burnAmount.add(reflectionAmount);
        uint256 transferAmount = amount.sub(totalFeeAmount);

        // Update balances
        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(transferAmount);
        _balances[address(0)] = _balances[address(0)].add(burnAmount);
        _balances[_devWallet] = _balances[_devWallet].add(reflectionAmount.mul(_devFeePercentage).div(100));
        _balances[_marketingWallet] = _balances[_marketingWallet].add(reflectionAmount.mul(_marketingFeePercentage).div(100));
        _balances[_teamWallet] = _balances[_teamWallet].add(reflectionAmount.mul(_teamFeePercentage).div(100));

        // Decrease allowance
        _allowances[sender][msg.sender] = _allowances[sender][msg.sender].sub(amount);

        // Emit transfer and fee events
        emit Transfer(sender, recipient, transferAmount);
        emit Burn(sender, burnAmount);
        emit TransferWithReflection(sender, address(0), reflectionAmount, reflectionAmount);
        emit TransferWithReflection(sender, _devWallet, reflectionAmount.mul(_devFeePercentage).div(100), reflectionAmount);
        emit TransferWithReflection(sender, _marketingWallet, reflectionAmount.mul(_marketingFeePercentage).div(100), reflectionAmount);
        emit TransferWithReflection(sender, _teamWallet, reflectionAmount.mul(_teamFeePercentage).div(100), reflectionAmount);

        return true;
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
}