// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.19;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.19;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}


// OpenZeppelin Contracts (last updated v4.9.0) (access/Ownable.sol)

pragma solidity ^0.8.19;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor(address initialOwner) {
        _transferOwnership(initialOwner);
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


/*
 * This code has not been reviewed.
 * Do not use or deploy this code before reviewing it personally first.
 */
pragma solidity ^0.8.0;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
    struct Role {
        mapping (address => bool) bearer;
    }

    /**
     * @dev Give an account access to this role.
     */
    function add(Role storage role, address account) internal {
        require(!has(role, account), "Roles: account already has role");
        role.bearer[account] = true;
    }

    /**
     * @dev Remove an account's access to this role.
     */
    function remove(Role storage role, address account) internal {
        require(has(role, account), "Roles: account does not have role");
        role.bearer[account] = false;
    }

    /**
     * @dev Check if an account has this role.
     * @return bool
     */
    function has(Role storage role, address account) internal view returns (bool) {
        require(account != address(0), "Roles: account is the zero address");
        return role.bearer[account];
    }
}


/*
 * This code has not been reviewed.
 * Do not use or deploy this code before reviewing it personally first.
 */
pragma solidity ^0.8.0;

/**
 * @title MinterRole
 * @dev Minters are responsible for minting new tokens.
 */
abstract contract MinterRole {
    using Roles for Roles.Role;

    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    Roles.Role private _minters;

    constructor() {
        _addMinter(msg.sender);
    }

    modifier onlyMinter() virtual {
        require(isMinter(msg.sender));
        _;
    }

    function isMinter(address account) public view returns (bool) {
        return _minters.has(account);
    }

    function addMinter(address account) public onlyMinter {
        _addMinter(account);
    }

    function removeMinter(address account) public onlyMinter {
        _removeMinter(account);
    }

    function renounceMinter() public {
        _removeMinter(msg.sender);
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }

    function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemoved(account);
    }
}



/// @title IERC1643 Document Management (part of the ERC1400 Security Token Standards)
/// @dev See https://github.com/SecurityTokenStandard/EIP-Spec

interface IERC1643 {
    // Document Management
    function getDocument(bytes32 _name) external view returns (string memory, bytes32, uint256);
    function setDocument(bytes32 _name, string memory _uri, bytes32 _documentHash) external;
    function removeDocument(bytes32 _name) external;
    function getAllDocuments() external view returns (bytes32[] memory);

    // Document Events
    event DocumentRemoved(bytes32 indexed _name, string _uri, bytes32 _documentHash);
    event DocumentUpdated(bytes32 indexed _name, string _uri, bytes32 _documentHash);
}


/// @title IERC1400 Security Token Standard
/// @dev See https://github.com/SecurityTokenStandard/EIP-Spec

interface IERC1400Upgrate is IERC1643 {

    // Token Information
    function balanceOfByPartition(bytes32 _partition, address _tokenHolder) external view returns (uint256);
    function partitionsOf(address _tokenHolder) external view returns (bytes32[] memory);

    // Transfers
    function transferWithData(address to, uint256 value, bytes calldata data) external;
    function transferFromWithData(address from, address to, uint256 value, bytes calldata data) external;

    // Partition Token Transfers
    function transferByPartition(bytes32 _partition, address _to, uint256 _value, bytes calldata _data) external returns (bytes32);
    function operatorTransferByPartition(bytes32 _partition, address _from, address _to, uint256 _value, bytes calldata _data, bytes calldata _operatorData) external returns (bytes32);

    // Controller Operation
    function isControllable() external view returns (bool);
    //  function controllerTransfer(address _from, address _to, uint256 _value, bytes calldata _data, bytes calldata _operatorData) external;
    //  function controllerRedeem(address _tokenHolder, uint256 _value, bytes calldata _data, bytes calldata _operatorData) external;

    // Operator Management
    function authorizeOperator(address _operator) external;
    function revokeOperator(address _operator) external;
    function authorizeOperatorByPartition(bytes32 _partition, address _operator) external;
    function revokeOperatorByPartition(bytes32 _partition, address _operator) external;

    // Operator Information
    function isOperator(address _operator, address _tokenHolder) external view returns (bool);
    function isOperatorForPartition(bytes32 _partition, address _operator, address _tokenHolder) external view returns (bool);

    // Token Issuance
    function isIssuable() external view returns (bool);
    function issue(address _tokenHolder, uint256 _value, bytes calldata _data) external;
    function issueByPartition(bytes32 _partition, address _tokenHolder, uint256 _value, bytes calldata _data) external;

    // Token Redemption
    function redeem(uint256 _value, bytes calldata _data) external;
    function redeemFrom(address _tokenHolder, uint256 _value, bytes calldata _data) external;
    function redeemByPartition(bytes32 _partition, uint256 _value, bytes calldata _data) external;
    function operatorRedeemByPartition(bytes32 _partition, address _tokenHolder, uint256 _value, bytes calldata _operatorData) external;

    // Transfer Validity
    // function canTransfer(address _to, uint256 _value, bytes _data) external view returns (byte, bytes32);
    // function canTransferFrom(address _from, address _to, uint256 _value, bytes _data) external view returns (byte, bytes32);
    // function canTransferByPartition(address _from, address _to, bytes32 _partition, uint256 _value, bytes _data) external view returns (byte, bytes32, bytes32);    

    // Controller Events
    // event ControllerTransfer( address _controller, address indexed _from, address indexed _to, uint256 _value, bytes _data, bytes _operatorData);
    // event ControllerRedemption(address _controller, address indexed _tokenHolder, uint256 _value, bytes _data, bytes _operatorData);


    // Transfer Events
    event TransferByPartition(bytes32 indexed _fromPartition, address _operator, address indexed _from, address indexed _to, uint256 _value, bytes _data, bytes _operatorData);
    event ChangedPartition( bytes32 indexed _fromPartition, bytes32 indexed _toPartition, uint256 _value);

    // Operator Events
    event AuthorizedOperator(address indexed _operator, address indexed _tokenHolder);
    event RevokedOperator(address indexed _operator, address indexed _tokenHolder);
    event AuthorizedOperatorByPartition(bytes32 indexed _partition, address indexed _operator, address indexed _tokenHolder);
    event RevokedOperatorByPartition(bytes32 indexed _partition, address indexed _operator, address indexed _tokenHolder);

    // Issuance / Redemption Events
    event Issued(address indexed _operator, address indexed _to, uint256 _value, bytes _data);
    event Redeemed(address indexed _operator, address indexed _from, uint256 _value, bytes _data);
    event IssuedByPartition(bytes32 indexed _partition, address indexed _operator, address indexed _to, uint256 _value, bytes _data, bytes _operatorData);
    event RedeemedByPartition(bytes32 indexed _partition, address indexed _operator, address indexed _from, uint256 _value, bytes _operatorData);
}


// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.19;


/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}


// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/ERC20.sol)
pragma solidity ^0.8.19;


/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the default value returned by this function, unless
     * it's overridden.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }
    
    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        _update(from, to, amount);
    }

    /**
     * @dev Transfers `amount` of tokens from `from` to `to`, or alternatively mints (or burns) if `from` (or `to`) is
     * the zero address. All customizations to transfers, mints, and burns should be done by overriding this function.
     *
     * Emits a {Transfer} event.
     */
    function _update(address from, address to, uint256 amount) internal virtual {
        if (from == address(0)) {
            _totalSupply += amount;
        } else {
            uint256 fromBalance = _balances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            unchecked {
                // Overflow not possible: amount <= fromBalance <= totalSupply.
                _balances[from] = fromBalance - amount;
            }
        }

        if (to == address(0)) {
            unchecked {
                // Overflow not possible: amount <= totalSupply or amount <= fromBalance <= totalSupply.
                _totalSupply -= amount;
            }
        } else {
            unchecked {
                // Overflow not possible: balance + amount is at most totalSupply, which we know fits into a uint256.
                _balances[to] += amount;
            }
        }

        emit Transfer(from, to, amount);
    }

    /**
     * @dev Creates `amount` tokens and assigns them to `account`, by transferring it from address(0).
     * Relies on the `_update` mechanism
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");
        _update(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, by transferring it to address(0).
     * Relies on the `_update` mechanism.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead
     */
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");
        _update(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }
}

// contracts/HKD Token.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract HKD is IERC1400Upgrate, ERC20, MinterRole, Ownable {
    struct Doc {
        string docURI;
        bytes32 docHash;
        uint256 timestamp;
    }
  
    bytes32[] internal _documentNames;
    mapping(bytes32 => Doc) internal _documents;

    // Indicate whether the token can still be controlled by operators or not anymore.
    bool internal _isControllable;

    // Indicate whether the token can still be issued by the issuer or not anymore.
    bool internal _isIssuable;

    // Partition
    // List of partitions.
    bytes32[] internal _totalPartitions;
    // List of token default partitions (for ERC20 compatibility).
    bytes32[] internal _defaultPartitions;


    // Mapping from partition to global balance of corresponding partition.
    mapping (bytes32 => uint256) internal _totalSupplyByPartition;
    // Mapping from (tokenHolder, partition) to balance of corresponding partition.
    mapping (address => mapping (bytes32 => uint256)) internal _balanceOfByPartition;  


    // Mapping from tokenHolder to their partitions.
    mapping (address => bytes32[]) internal _partitionsOf;
    // Mapping from partition to their index.
    mapping (bytes32 => uint256) internal _indexOfTotalPartitions;
    // Mapping from (tokenHolder, partition) to their index.
    mapping (address => mapping (bytes32 => uint256)) internal _indexOfPartitionsOf;


    // Mapping from (partition, tokenHolder, spender) to allowed value. [TOKEN-HOLDER-SPECIFIC]
    mapping(bytes32 => mapping (address => mapping (address => uint256))) internal _allowedByPartition;
    // Mapping from (tokenHolder, partition, operator) to 'approved for partition' status. [TOKEN-HOLDER-SPECIFIC]
    mapping (address => mapping (bytes32 => mapping (address => bool))) internal _authorizedOperatorByPartition;
    // Mapping from partition to controllers for the partition. [NOT TOKEN-HOLDER-SPECIFIC]
    mapping (bytes32 => address[]) internal _controllersByPartition;
    // Mapping from (partition, operator) to PartitionController status. [NOT TOKEN-HOLDER-SPECIFIC]
    mapping (bytes32 => mapping (address => bool)) internal _isControllerByPartition;
    // End Partition


    // Mapping from (operator, tokenHolder) to authorized status. [TOKEN-HOLDER-SPECIFIC]
    mapping(address => mapping(address => bool)) internal _authorizedOperator;

    // Array of controllers. [GLOBAL - NOT TOKEN-HOLDER-SPECIFIC]
    address[] internal _controllers;

    // Mapping from operator to controller status. [GLOBAL - NOT TOKEN-HOLDER-SPECIFIC]
    mapping(address => bool) internal _isController;


    event ApprovalByPartition(bytes32 indexed partition, address indexed owner, address indexed spender, uint256 value);

    /**
    * @dev Modifier to verify if token is issuable.
    */
    modifier isIssuableToken() {
        require(_isIssuable, "55"); // 0x55	funds locked (lockup period)
        _;
    }

    /**
    * @dev Modifier to verifiy if sender is a minter.
    */
    modifier onlyMinter() override {
        require(isMinter(msg.sender) || owner() == _msgSender());
        _;
    }

    constructor(string memory name, string memory symbol, address[] memory initialControllers, bytes32[] memory defaultPartitions)
        ERC20(name, symbol) Ownable(msg.sender) {

        _setControllers(initialControllers);

        _defaultPartitions = defaultPartitions;

        _isControllable = true;

        _isIssuable = true;
    }

    // Document management
    /**
    * @dev Access a document associated with the token.
    * @param documentName Short name (represented as a bytes32) associated to the document.
    * @return Requested document + document hash + document timestamp.
    */
    function getDocument(bytes32 documentName) external override view returns (string memory, bytes32, uint256) {
        require(bytes(_documents[documentName].docURI).length != 0); // Action Blocked - Empty document
        return (
            _documents[documentName].docURI,
            _documents[documentName].docHash,
            _documents[documentName].timestamp
        );
    }

    /**
    * @dev Associate a document with the token.
    * @param documentName Short name (represented as a bytes32) associated to the document.
    * @param uri Document content.
    * @param documentHash Hash of the document [optional parameter].
    */
    function setDocument(bytes32 documentName, string calldata uri, bytes32 documentHash) external override {
        require(_isController[msg.sender], "Unauthorized");
        _documents[documentName] = Doc({
            docURI: uri,
            docHash: documentHash,
            timestamp: block.timestamp
        });

        emit DocumentUpdated(documentName, uri, documentHash);
    }


    function removeDocument(bytes32 documentName) external override {
        require(_isController[msg.sender], "Unauthorized");
        for(uint256 i = 0; i < _documentNames.length; i++){
            if(_documentNames[i] == documentName){
                _documentNames[i] = _documentNames[_documentNames.length - 1];
                _documentNames.pop();

                string memory uri = _documents[documentName].docURI;
                bytes32 documentHash = _documents[documentName].docHash;

                delete _documents[documentName];

                emit DocumentRemoved(documentName, uri, documentHash);
                return;
            }
        }
        revert();      
    }

    function getAllDocuments() external override view returns (bytes32[] memory) {
        bytes32[] memory names = new bytes32[](_documentNames.length);
        for(uint256 i = 0; i < _documentNames.length; i++){
            names[i] = _documentNames[i];       
        }
        return names;
    }


    //Token Information 
    /**
    //checked
    * @dev Get balance of a tokenholder for a specific partition.
    * @param partition Name of the partition.
    * @param tokenHolder Address for which the balance is returned.
    * @return Amount of token of partition 'partition' held by 'tokenHolder' in the token contract.
    */
    function balanceOfByPartition(bytes32 partition, address tokenHolder) external override view returns (uint256) {
        return _balanceOfByPartition[tokenHolder][partition];
    }

    /**
    //checked
    * @dev Get partitions index of a tokenholder.
    * @param tokenHolder Address for which the partitions index are returned.
    * @return Array of partitions index of 'tokenHolder'.
    */
    function partitionsOf(address tokenHolder) external override view returns (bytes32[] memory) {
        return _partitionsOf[tokenHolder];
    }


        
    //Transfers
    /**
    //checked
    * @dev Transfer token for a specified address.
    * @param to The address to transfer to.
    * @param amount The value to be transferred.
    * @return A boolean that indicates if the operation was successful.
    */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transferByDefaultPartitions(msg.sender, msg.sender, to, amount, "");
        return true;
    }


    /**
    // checked
    * @dev Transfer tokens from one address to another.
    * @param from The address which you want to transfer tokens from.
    * @param to The address which you want to transfer to.
    * @param amount The amount of tokens to be transferred.
    * @return A boolean that indicates if the operation was successful.
    */
    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {        
        require(_isOperator(msg.sender, from), "Unauthorized");

        address spender = _msgSender();
        _spendAllowance(from, spender, amount);

        _transferByDefaultPartitions(msg.sender, from, to, amount, "");
        return true;
    }


    /**
    //checked
    * @dev Transfer the amount of tokens from the address 'msg.sender' to the address 'to'.
    * @param to Token recipient.
    * @param value Number of tokens to transfer.
    * @param data Information attached to the transfer, by the token holder.
    */
    function transferWithData(address to, uint256 value, bytes calldata data) external override {
        _transferByDefaultPartitions(msg.sender, msg.sender, to, value, data);
    }

    /**
    // checked
    * @dev Transfer the amount of tokens on behalf of the address 'from' to the address 'to'.
    * @param from Token holder (or 'address(0)' to set from to 'msg.sender').
    * @param to Token recipient.
    * @param value Number of tokens to transfer.
    * @param data Information attached to the transfer, and intended for the token holder ('from').
    */
    function transferFromWithData(address from, address to, uint256 value, bytes calldata data) external override virtual {
        require(_isOperator(msg.sender, from), "Unauthorized");
          
        address spender = _msgSender();
        _spendAllowance(from, spender, value);

        _transferByDefaultPartitions(msg.sender, from, to, value, data);
    }

    /**
    // checked
    * @dev Transfer tokens from a specific partition.
    * @param partition Name of the partition.
    * @param to Token recipient.
    * @param value Number of tokens to transfer.
    * @param data Information attached to the transfer, by the token holder.
    * @return Destination partition.
    */
    function transferByPartition(bytes32 partition, address to, uint256 value, bytes calldata data) external override returns (bytes32){
        return _transferByPartition(partition, msg.sender, msg.sender, to, value, data, "");
    }

    /**
    * @dev Transfer tokens from a specific partition through an operator.
    * @param partition Name of the partition.
    * @param from Token holder.
    * @param to Token recipient.
    * @param value Number of tokens to transfer.
    * @param data Information attached to the transfer. [CAN CONTAIN THE DESTINATION PARTITION]
    * @param operatorData Information attached to the transfer, by the operator.
    * @return Destination partition.
    */
    function operatorTransferByPartition( bytes32 partition, address from,  address to,  uint256 value, bytes calldata data,  bytes calldata operatorData) 
    external override  returns (bytes32) {
        //We want to check if the msg.sender is an authorized operator for `from`
        //(msg.sender == from OR msg.sender is authorized by from OR msg.sender is a controller if this token is controlable)
        //OR
        //We want to check if msg.sender is an `allowed` operator/spender for `from`
        require(_isOperatorForPartition(partition, msg.sender, from)
        || (value <= _allowedByPartition[partition][from][msg.sender]), "53"); // 0x53	insufficient allowance

        if(_allowedByPartition[partition][from][msg.sender] >= value) {
            _allowedByPartition[partition][from][msg.sender] = _allowedByPartition[partition][from][msg.sender] - value;
        } 
        else {
            _allowedByPartition[partition][from][msg.sender] = 0;
        }

        return _transferByPartition(partition, msg.sender, from, to, value, data, operatorData);
    }
    

    /**
    // checked
    * @dev Transfer tokens from default partitions.
    * Function used for ERC20 retrocompatibility.
    * @param operator The address performing the transfer.
    * @param from Token holder.
    * @param to Token recipient.
    * @param value Number of tokens to transfer.
    * @param data Information attached to the transfer, and intended for the token holder ('from') [CAN CONTAIN THE DESTINATION PARTITION].
    */
    function _transferByDefaultPartitions(address operator, address from,  address to, uint256 value, bytes memory data) internal {
        require(_defaultPartitions.length != 0, "55"); // // 0x55	funds locked (lockup period)

        uint256 _remainingValue = value;
        uint256 _localBalance;

        for (uint i = 0; i < _defaultPartitions.length; i++) {
            _localBalance = _balanceOfByPartition[from][_defaultPartitions[i]];
            if(_remainingValue <= _localBalance) {
                _transferByPartition(_defaultPartitions[i], operator, from, to, _remainingValue, data, "");
                _remainingValue = 0;
                break;
            } 
            else if (_localBalance != 0) {
                _transferByPartition(_defaultPartitions[i], operator, from, to, _localBalance, data, "");
                _remainingValue = _remainingValue - _localBalance;
            }
        }

        require(_remainingValue == 0, "52"); // 0x52	insufficient balance
    }

    /**
    // Checked
    * @dev Transfer tokens from a specific partition.
    * @param fromPartition Partition of the tokens to transfer.
    * @param operator The address performing the transfer.
    * @param from Token holder.
    * @param to Token recipient.
    * @param value Number of tokens to transfer.
    * @param data Information attached to the transfer. [CAN CONTAIN THE DESTINATION PARTITION] 
    * @param operatorData Information attached to the transfer, by the operator (if any).
    * @return Destination partition.
    */
    function _transferByPartition(bytes32 fromPartition, address operator, address from, address to,
        uint256 value, bytes memory data, bytes memory operatorData) internal returns (bytes32){

        require(_balanceOfByPartition[from][fromPartition] >= value, "52"); // 0x52	insufficient balance

        bytes32 toPartition = fromPartition;

        if(operatorData.length != 0 && data.length >= 64) {
            toPartition = _getDestinationPartition(fromPartition, data);
        }

        _removeTokenFromPartition(from, fromPartition, value);
    
        _transfer(from, to, value);
    
        _addTokenToPartition(to, toPartition, value);

        emit TransferByPartition(fromPartition, operator, from, to, value, data, operatorData);

        if(toPartition != fromPartition) {
            emit ChangedPartition(fromPartition, toPartition, value);
        }

        return toPartition;
    }


    /**
    * @dev Retrieve the destination partition from the 'data' field.
    * By convention, a partition change is requested ONLY when 'data' starts
    * with the flag: 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    * When the flag is detected, the destination tranche is extracted from the
    * 32 bytes following the flag.
    * @param fromPartition Partition of the tokens to transfer.
    * @param data Information attached to the transfer. [CAN CONTAIN THE DESTINATION PARTITION]
    * @return toPartition Destination partition.
    */
    function _getDestinationPartition(bytes32 fromPartition, bytes memory data) internal pure returns(bytes32 toPartition) {
        bytes32 changePartitionFlag = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
        bytes32 flag;
        assembly {
            flag := mload(add(data, 32))
        }

        if(flag == changePartitionFlag) {
            assembly {
                toPartition := mload(add(data, 64))
            }
        } 

        else {
            toPartition = fromPartition;
        }
    }


    /**
    * @dev Remove a token from a specific partition.
    * @param from Token holder.
    * @param partition Name of the partition.
    * @param value Number of tokens to transfer. 
    */
    function _removeTokenFromPartition(address from, bytes32 partition, uint256 value) internal {
        _balanceOfByPartition[from][partition] = _balanceOfByPartition[from][partition] - value;
        _totalSupplyByPartition[partition] = _totalSupplyByPartition[partition] - value;

        // If the total supply is zero, finds and deletes the partition.
        if(_totalSupplyByPartition[partition] == 0) {
            uint256 index1 = _indexOfTotalPartitions[partition];
            require(index1 > 0, "50"); // 0x50	transfer failure

            // move the last item into the index being vacated
            bytes32 lastValue = _totalPartitions[_totalPartitions.length - 1];
            _totalPartitions[index1 - 1] = lastValue; // adjust for 1-based indexing
            _indexOfTotalPartitions[lastValue] = index1;

            //_totalPartitions.length -= 1;
            _totalPartitions.pop();
            _indexOfTotalPartitions[partition] = 0;
        }

        // If the balance of the TokenHolder's partition is zero, finds and deletes the partition.
        if(_balanceOfByPartition[from][partition] == 0) {
            uint256 index2 = _indexOfPartitionsOf[from][partition];
            require(index2 > 0, "50"); // 0x50	transfer failure

            // move the last item into the index being vacated
            bytes32 lastValue = _partitionsOf[from][_partitionsOf[from].length - 1];
            _partitionsOf[from][index2 - 1] = lastValue;  // adjust for 1-based indexing
            _indexOfPartitionsOf[from][lastValue] = index2;

            //_partitionsOf[from].length -= 1;
            _partitionsOf[from].pop();
            _indexOfPartitionsOf[from][partition] = 0;
        }
    }


    // Controller Operation 
    /**
    //checked
    * @dev Know if the token can be controlled by operators.
    * If a token returns 'false' for 'isControllable()'' then it MUST always return 'false' in the future.
    * @return bool 'true' if the token can still be controlled by operators, 'false' if it can't anymore.
    */
    function isControllable() external override view returns (bool) {
        return _isControllable;
    }
   
    /**
    // checked
    * @dev Definitely renounce the possibility to control tokens on behalf of tokenHolders.
    * Once set to false, '_isControllable' can never be set to 'true' again.
    */
    function renounceControl() external onlyOwner {
        _isControllable = false;
    }


    // Operator Management
    //checked
    /**
    * @dev Set a third party operator address as an operator of 'msg.sender' to transfer
    * and redeem tokens on its behalf.
    * @param operator Address to set as an operator for 'msg.sender'.
    */
    function authorizeOperator(address operator) external override {
        require(operator != msg.sender);
        
        _authorizedOperator[operator][msg.sender] = true;

        emit AuthorizedOperator(operator, msg.sender);
    }

    /**
    // checked
    * @dev Remove the right of the operator address to be an operator for 'msg.sender'
    * and to transfer and redeem tokens on its behalf.
    * @param operator Address to rescind as an operator for 'msg.sender'.
    */
    function revokeOperator(address operator) external override {
        require(operator != msg.sender);

        _authorizedOperator[operator][msg.sender] = false;

        emit RevokedOperator(operator, msg.sender);
    }

    /**
    // checked
    * @dev Set 'operator' as an operator for 'msg.sender' for a given partition.
    * @param partition Name of the partition.
    * @param operator Address to set as an operator for 'msg.sender'.
    */
    function authorizeOperatorByPartition(bytes32 partition, address operator) external override {
        _authorizedOperatorByPartition[msg.sender][partition][operator] = true;

        emit AuthorizedOperatorByPartition(partition, operator, msg.sender);
    }

    /**
    //checked
    * @dev Remove the right of the operator address to be an operator on a given
    * partition for 'msg.sender' and to transfer and redeem tokens on its behalf.
    * @param partition Name of the partition.
    * @param operator Address to rescind as an operator on given partition for 'msg.sender'.
    */
    function revokeOperatorByPartition(bytes32 partition, address operator) external override {
        _authorizedOperatorByPartition[msg.sender][partition][operator] = false;

        emit RevokedOperatorByPartition(partition, operator, msg.sender);
    }
    

    //Token Issuance 
    /**
    // checked
    * @dev Know if new tokens can be issued in the future.
    * @return bool 'true' if tokens can still be issued by the issuer, 'false' if they can't anymore.
    */
    function isIssuable() external override view returns (bool) {
        return _isIssuable;
    }

    /**
    // checked
    * @dev Definitely renounce the possibility to issue new tokens.
    * Once set to false, '_isIssuable' can never be set to 'true' again.
    */
    function renounceIssuance() external onlyOwner {
        _isIssuable = false;
    }

    /**
    // checked
    * @dev Issue tokens from default partition.
    * @param tokenHolder Address for which we want to issue tokens.
    * @param value Number of tokens issued.
    * @param data Information attached to the issuance, by the issuer.
    */
    function issue(address tokenHolder, uint256 value, bytes calldata data) external override onlyMinter isIssuableToken
    {
        require(_defaultPartitions.length != 0, "55"); // 0x55	funds locked (lockup period)

        _issueByPartition(_defaultPartitions[0], msg.sender, tokenHolder, value, data);
    }

    /**
    // checked
    * @dev Issue tokens from a specific partition.
    * @param partition Name of the partition.
    * @param tokenHolder Address for which we want to issue tokens.
    * @param value Number of tokens issued.
    * @param data Information attached to the issuance, by the issuer.
    */
    function issueByPartition(bytes32 partition, address tokenHolder, uint256 value, bytes calldata data) external override onlyMinter isIssuableToken
    {
        _issueByPartition(partition, msg.sender, tokenHolder, value, data);
    }    


    /**
    // checked
    * @dev Issue tokens from a specific partition.
    * @param toPartition Name of the partition.
    * @param operator The address performing the issuance.
    * @param to Token recipient.
    * @param value Number of tokens to issue.
    * @param data Information attached to the issuance.
    */
    function _issueByPartition(bytes32 toPartition, address operator, address to, uint256 value, bytes calldata data) internal
    {
        _mint(to, value);

        _addTokenToPartition(to, toPartition, value);

        emit Issued(operator, to, value, data);
        emit IssuedByPartition(toPartition, operator, to, value, data, "");
    }


    /**
    * @dev Add a token to a specific partition.
    * @param to Token recipient.
    * @param partition Name of the partition.
    * @param value Number of tokens to transfer.
    */
    function _addTokenToPartition(address to, bytes32 partition, uint256 value) internal {
        if(value != 0) {
            if (_indexOfPartitionsOf[to][partition] == 0) {
                _partitionsOf[to].push(partition);
                _indexOfPartitionsOf[to][partition] = _partitionsOf[to].length;
            }
            _balanceOfByPartition[to][partition] = _balanceOfByPartition[to][partition] + value;


            // add partition to total partition list
            if (_indexOfTotalPartitions[partition] == 0) {
                _totalPartitions.push(partition);
                _indexOfTotalPartitions[partition] = _totalPartitions.length;
            }
            _totalSupplyByPartition[partition] = _totalSupplyByPartition[partition] + value;
        }
    }


    // Token controllers 
    /**
    // checked
    * @dev Get the list of controllers as defined by the token contract.
    * @return List of addresses of all the controllers.
    */
    function controllers() external view returns (address[] memory) {
        return _controllers;
    }

    /**
    // checked
    * @dev Get controllers for a given partition.
    * @param partition Name of the partition.
    * @return Array of controllers for partition.
    */
    function controllersByPartition(bytes32 partition) external view returns (address[] memory) {
        return _controllersByPartition[partition];
    }

    /**
    // checked
    * @dev Set list of token controllers.
    * @param operators Controller addresses.
    */
    function setControllers(address[] memory operators) external onlyOwner {
        _setControllers(operators);
    }


    /**
    // checked
    * @dev Set list of token controllers.
    * @param operators Controller addresses.
    */
    function _setControllers(address[] memory operators) internal {
        for (uint i = 0; i < _controllers.length; i++){
            _isController[_controllers[i]] = false;
        }
        for (uint j = 0; j < operators.length; j++){
            _isController[operators[j]] = true;
        }
        _controllers = operators;
    }

    /**
    // checked
    * @dev Set list of token partition controllers.
    * @param partition Name of the partition.
    * @param operators Controller addresses.
    */
    function setPartitionControllers(bytes32 partition, address[] calldata operators) external onlyOwner {
       for (uint i = 0; i < _controllersByPartition[partition].length; i++){
            _isControllerByPartition[partition][_controllersByPartition[partition][i]] = false;
        }
        for (uint j = 0; j < operators.length; j++){
            _isControllerByPartition[partition][operators[j]] = true;
        }
        _controllersByPartition[partition] = operators;
    }


    //Token Redemption 
    /**
    * @dev Indicate whether the operator address is an operator of the tokenHolder address.
    * @param operator Address which may be an operator of 'tokenHolder'.
    * @param tokenHolder Address of a token holder which may have the 'operator' address as an operator.
    * @return 'true' if 'operator' is an operator of 'tokenHolder' and 'false' otherwise.
    */
    function _isOperator(address operator, address tokenHolder) internal view returns (bool) {
        return (operator == tokenHolder
        || _authorizedOperator[operator][tokenHolder]
        || (_isControllable && _isController[operator]));
    }

    /**
    * @dev Indicate whether the operator address is an operator of the tokenHolder
    * address for the given partition.
    * @param partition Name of the partition.
    * @param operator Address which may be an operator of tokenHolder for the given partition.
    * @param tokenHolder Address of a token holder which may have the operator address as an operator for the given partition.
    * @return 'true' if 'operator' is an operator of 'tokenHolder' for partition 'partition' and 'false' otherwise.
    */
    function _isOperatorForPartition(bytes32 partition, address operator, address tokenHolder) internal view returns (bool) {
        return (_isOperator(operator, tokenHolder)
        || _authorizedOperatorByPartition[tokenHolder][partition][operator]
        || (_isControllable && _isControllerByPartition[partition][operator]));
    }


    // Operator Information 
    /**
    * @dev Indicate whether the operator address is an operator of the tokenHolder address.
    * @param operator Address which may be an operator of tokenHolder.
    * @param tokenHolder Address of a token holder which may have the operator address as an operator.
    * @return 'true' if operator is an operator of 'tokenHolder' and 'false' otherwise.
    */
    function isOperator(address operator, address tokenHolder) external override view returns (bool) {
        return _isOperator(operator, tokenHolder);
    }
    
    /**
    * @dev Indicate whether the operator address is an operator of the tokenHolder
    * address for the given partition.
    * @param partition Name of the partition.
    * @param operator Address which may be an operator of tokenHolder for the given partition.
    * @param tokenHolder Address of a token holder which may have the operator address as an operator for the given partition.
    * @return 'true' if 'operator' is an operator of 'tokenHolder' for partition 'partition' and 'false' otherwise.
    */
    function isOperatorForPartition(bytes32 partition, address operator, address tokenHolder) external override view returns (bool) {
        return _isOperatorForPartition(partition, operator, tokenHolder);
    }


    /**
    * @dev Redeem the amount of tokens from the address 'msg.sender'.
    * @param value Number of tokens to redeem.
    * @param data Information attached to the redemption, by the token holder.
    */
    function redeem(uint256 value, bytes calldata data) external override
    {
        _redeemByDefaultPartitions(msg.sender, msg.sender, value, data);
    }

    /**
    * @dev Redeem the amount of tokens on behalf of the address from.
    * @param from Token holder whose tokens will be redeemed (or address(0) to set from to msg.sender).
    * @param value Number of tokens to redeem.
    * @param data Information attached to the redemption.
    */
    function redeemFrom(address from, uint256 value, bytes calldata data) external override virtual
    {
        require(_isOperator(msg.sender, from), "53"); // 0x53	insufficient allowance

        address spender = _msgSender();
        _spendAllowance(from, spender, value);

        _redeemByDefaultPartitions(msg.sender, from, value, data);
    }
    
    /**
    * @dev Redeem tokens of a specific partition.
    * @param partition Name of the partition.
    * @param value Number of tokens redeemed.
    * @param data Information attached to the redemption, by the redeemer.
    */
    function redeemByPartition(bytes32 partition, uint256 value, bytes calldata data) external override {
        _redeemByPartition(partition, msg.sender, msg.sender, value, data, "");
    }

    /**
    * @dev Redeem tokens of a specific partition.
    * @param partition Name of the partition.
    * @param tokenHolder Address for which we want to redeem tokens.
    * @param value Number of tokens redeemed
    * @param operatorData Information attached to the redemption, by the operator.
    */
    function operatorRedeemByPartition(bytes32 partition, address tokenHolder, uint256 value, bytes calldata operatorData) external override {
        require(_isOperatorForPartition(partition, msg.sender, tokenHolder) || value <= _allowedByPartition[partition][tokenHolder][msg.sender], "58"); // 0x58	invalid operator (transfer agent)

        if(_allowedByPartition[partition][tokenHolder][msg.sender] >= value) {
            _allowedByPartition[partition][tokenHolder][msg.sender] = _allowedByPartition[partition][tokenHolder][msg.sender] - value;
        } 
        else {
            _allowedByPartition[partition][tokenHolder][msg.sender] = 0;
        }

        _redeemByPartition(partition, msg.sender, tokenHolder, value, "", operatorData);
    }

    /**
    * @dev Perform the token redemption.
    * @param operator The address performing the redemption.
    * @param from Token holder whose tokens will be redeemed.
    * @param value Number of tokens to redeem.
    * @param data Information attached to the redemption.
    */
    function _redeem(address operator, address from, uint256 value, bytes memory data)  internal 
    {  
        require(from != address(0), "56"); // 0x56	invalid sender
        require(balanceOf(from) >= value, "52"); // 0x52	insufficient balance

        _update(from, address(this), value);
        emit Redeemed(operator, from, value, data);
    }

    /**
    * @dev Redeem tokens of a specific partition.
    * @param fromPartition Name of the partition.
    * @param operator The address performing the redemption.
    * @param from Token holder whose tokens will be redeemed.
    * @param value Number of tokens to redeem.
    * @param data Information attached to the redemption.
    * @param operatorData Information attached to the redemption, by the operator (if any).
    */
    function _redeemByPartition(bytes32 fromPartition, address operator, address from, uint256 value, bytes memory data,  bytes memory operatorData) internal{
        require(_balanceOfByPartition[from][fromPartition] >= value, "52"); // 0x52	insufficient balance

        _removeTokenFromPartition(from, fromPartition, value);
        _redeem(operator, from, value, data);

        emit RedeemedByPartition(fromPartition, operator, from, value, operatorData);
    }

    /**
    * @dev Redeem tokens from a default partitions.
    * @param operator The address performing the redeem.
    * @param from Token holder.
    * @param value Number of tokens to redeem.
    * @param data Information attached to the redemption.
    */
    function _redeemByDefaultPartitions(address operator, address from, uint256 value, bytes memory data) internal{
        require(_defaultPartitions.length != 0, "55"); // 0x55	funds locked (lockup period)

        uint256 _remainingValue = value;
        uint256 _localBalance;

        for (uint i = 0; i < _defaultPartitions.length; i++) {
            _localBalance = _balanceOfByPartition[from][_defaultPartitions[i]];
            if(_remainingValue <= _localBalance) {
                _redeemByPartition(_defaultPartitions[i], operator, from, _remainingValue, data, "");
                _remainingValue = 0;
                break;
            } 
            else {
                _redeemByPartition(_defaultPartitions[i], operator, from, _localBalance, data, "");
                _remainingValue = _remainingValue - _localBalance;
            }
        }
        require(_remainingValue == 0, "52"); // 0x52	insufficient balance
    }


    /**
    // checked
    * @dev Withdraw tokens from default partitions.
    * @param to Token recipient.
    * @param value Number of tokens to transfer.
    */
    function withdrawToken(address to, uint256 value) external onlyOwner() {
        _transfer(address(this), to, value);
    }
}


