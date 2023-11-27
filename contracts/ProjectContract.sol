//SPDX-License-Identifier: MIT

pragma solidity 0.8.5;
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";

contract ProjectContract is Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, OwnableUpgradeable {
    // uint256 public totalarea;
    uint256 public maxSupply;
    // uint256 public totaltokens;
    // uint256 public circulationsupply;
    uint256 private circulationsupply;
    uint256 private existingTokens;
    //string public name;
    //string public symbol;
    uint8 private _decimals;

    address public daowallet;
    address public timelockcontractaddress;
    address public projectWallet;
    // project wallet address. all unlocked tokens go there.✅

    bool public tokensAirdropped;
  
    mapping(address => bool) admins;
    // mapping(address => uint256) public balances;

    //event Transfer(address indexed from, address indexed to, uint256 value);
    event withdraw(address indexed from, uint256 amount);
    event unlockedfunds(string);
    event lockfunds(string, uint256);
/*
    constructor() {
        _disableInitializers();
    }
*/
    function initialize(string memory _name, string memory _symbol, uint8 decimal, uint256 _supply) initializer public {
        __ERC20_init(_name, _symbol); // already hardcoded, need to provide name, symbol, supply while deploying
        //need to handle transfer upto 4 decimal places
        //_mint(msg.sender, 10000000000000000000000000);

        __ERC20Burnable_init();
        __Ownable_init();

        _decimals = decimal;

        admins[msg.sender] = true;
        tokensAirdropped = false;
        //decimals = 18;
        maxSupply = _supply * (10 ** decimal);
        // totaltokens = totalarea;
        circulationsupply = 0;
        //circulationsupply = totaltokens;
        //name = DAO;
        //symbol = DAO;
       
        daowallet = msg.sender;
        // balances[daowallet] = circulationsupply;

        //  Fire up timelock contract

        timelockcontract();
    }

    /*
    function initialize(uint256 _totalarea,
    string memory _name,
    string memory _symbol,
    uint8 _divisions) public initializer {
        admins[msg.sender] = true;
        decimals = _divisions;
        totalarea = _totalarea * (uint256(10) ** _divisions);
        totaltokens = totalarea;
        circulationsupply = totaltokens;
        name = _name;
        symbol = _symbol;
       
        daowallet = msg.sender;
        balances[daowallet] = circulationsupply;

        //  Fire up timelock contract

        timelockcontract();
    }
    */
/*
    constructor(
        uint256 _totalarea,
        string memory _name,
        string memory _symbol,
        uint8 _divisions
    ) {
        admins[msg.sender] = true;
        decimals = _divisions;
        totalarea = _totalarea * (uint256(10) ** _divisions);
        totaltokens = totalarea;
        circulationsupply = totaltokens;
        name = _name;
        symbol = _symbol;
       
        daowallet = msg.sender;
        balances[daowallet] = circulationsupply;

        //  Fire up timelock contract

        timelockcontract();
    }
*/
    function timelockcontract() internal {
        // sending parent contract address to timelock contract so that functions of timelock contract can only be called by parent contract.
        ProjectTimeLock timelock = new ProjectTimeLock(address(this));

        // storing timelock contract address in parent contract for documentation purposes.
        timelockcontractaddress = address(timelock);
    }

    function addAdmin(address _adminAddress) external  {
        admins[_adminAddress] = true;
    }

    function removeAdmin(address _adminAddress) external onlyAdmin {
        admins[_adminAddress] = false;
    }

    function updateProjectwalletAddress(address _projectWallet) external onlyAdmin {
        projectWallet = _projectWallet;
    }

    function increaseTokenSupply(uint256 _number) external onlyAdmin {
        maxSupply += _number;
        // totalarea = totaltokens;
        // circulationsupply += _number * (10 ** 18);
        // mintTokens(_number);
    }

    function adminTransferFrom(
        address from,
        address to,
        uint256 amount
    ) public onlyAdmin returns (bool) {
        _transfer(from, to, amount);
        return true;
    }

    // function handleOperations(
    //     address _from, 
    //     address _to, 
    //     uint256 _amount
    // ) internal {
    //     balances[_from] = balances[_from] - _amount;
    //     balances[_to] = balances[_to] + _amount;
    // }

    //make internal function that handles + and - operations of transfer and transferFrom✅


    /* Transfer tokens from one investor to another (sell process) */
    // function transferFrom(
    //     address _from,
    //     address _to,
    //     uint256 _amount
    // ) public virtual override onlyAdmin returns (bool) {
    //     require(_from != address(0), "ERC20: transfer from the zero address");
    //     require(_to != address(0), "ERC20: transfer to the zero address");
    //     require(balances[_from] >= _amount);
    //     handleOperations(_from, _to, _amount);
    //     // balances[_from] = balances[_from].sub(_amount);
    //     // balances[_to] = balances[_to].add(_amount);
    //     // balances[_from] = balances[_from]-amount;
    //     // balances[_to] = balances[_to]+ amount;
    //     emit Transfer(_from, _to, _amount);
    //     return true;
    // }

    /* Function to issue tokens to new investors */

    // function transfer(address _to, uint256 _amount)
    //     public onlyAdmin virtual override returns (bool)
    // {
    //     //require(_from != address(0), "ERC20: transfer from the zero address");
    //     require(_to != address(0), "ERC20: transfer to the zero address");
    //     require(balances[msg.sender] >= _amount);
    //     handleOperations(msg.sender, _to, _amount);
    //     // balances[msg.sender] = balances[msg.sender].sub(_amount);
    //     // balances[_to]= balances[_to].add(_amount);
    //     emit Transfer(msg.sender, _to, _amount);
    //     return true;
    // }

    /* Liquidate tokens from investors.	*/

    // function withdrawl(address _from, uint256 _amount) public onlyAdmin {
    //     require(balances[_from] >= _amount);
    //     balances[_from] = balances[_from] - _amount;
    //     circulationsupply = circulationsupply - _amount;
    //     // balances[_from] = balances[_from].sub(_amount);
    //     // circulationsupply = circulationsupply.sub(_amount);
    //     emit withdraw(_from, _amount);
    // }

    /*  Function to lock tokens */

    function developmentRounds(
        string memory _name,
        uint256 _tokens,
        uint256 _starttime,
        uint256 _endtime
    ) public onlyAdmin returns (bool success) {
        require(maxSupply >= _tokens + existingTokens, "exceeds max supply");
        ProjectTimeLock timelock = ProjectTimeLock(timelockcontractaddress);
        existingTokens += _tokens;
        _mint(timelockcontractaddress, _tokens);
        // balances[daowallet] = balances[daowallet] - _tokens;
        // circulationsupply = circulationsupply - _tokens;
        // balances[daowallet] = balances[daowallet].sub(_tokens);
        // circulationsupply = circulationsupply.sub(_tokens);
        timelock.depositaddress(_name, _tokens, _starttime, _endtime);
        emit lockfunds(_name, _tokens);
        return true;
    }

    /* Function to release tokens */

    function releasefunds(string memory _name) public onlyAdmin {
        ProjectTimeLock timelock = ProjectTimeLock(timelockcontractaddress);
        timelock.withdrawltokens(_name, projectWallet);
        emit unlockedfunds(_name);
    }

    function deposittimelock(uint256 _amount) public childcontract {
        // balances[projectWallet] = balances[projectWallet] + _amount;
        // balances[daowallet] = balances[daowallet] + _amount;
        circulationsupply = circulationsupply + _amount;
        // balances[daowallet] = balances[daowallet].add(_amount);
        // circulationsupply = circulationsupply.add(_amount);
    }

    /* Get vesting details of locked tokens. */

    function getvestingdetails(string memory _name)
        public
        view
        returns (
            uint256,
            uint256,
            uint256,
            address
        )
    {
        ProjectTimeLock timelock = ProjectTimeLock(timelockcontractaddress);
        return timelock.getvestingdetails(_name);
    }

    function updateRoundDate(string memory _name, uint256 _startDate, uint256 _endDate) external onlyAdmin {
        ProjectTimeLock timelock = ProjectTimeLock(timelockcontractaddress);
        timelock.updateDate(_name, _startDate, _endDate);
    }

//take a look into the following function.
    function updateRoundSupply(string memory _name, uint256 _tokens) external onlyAdmin returns (bool success) {
        require(maxSupply >= _tokens + existingTokens, "exceeds max supply");
        ProjectTimeLock timelock = ProjectTimeLock(timelockcontractaddress);
        // balances[daowallet] = balances[daowallet] - _tokens;
        // circulationsupply = circulationsupply - _tokens;
        existingTokens += _tokens;
        _mint(timelockcontractaddress, _tokens); 
        timelock.updateSupply(_name, _tokens);
        emit lockfunds(_name, _tokens);

        return true;
    }

    function airdrop(address[] memory _recipients, uint256[] memory _amount) external onlyAdmin {
        require(!tokensAirdropped, "Tokens already airdropped");
        require(_recipients.length == _amount.length, "Arrays length mismatch");
        //check for the tokens to be minted < total supply

        tokensAirdropped = true; //to prevent re-entrancy

        for (uint i = 0; i < _recipients.length; ++i) {
            _mint(_recipients[i], _amount[i]);
            circulationsupply += _amount[i];
            existingTokens += _amount[i];
        }
    }

    // fix transfer and transferFrom function.✅
    // handle the condition of totalsupply in airdrop.✅
    // ask about withdrawl function.✅

    /* Fetch balance of user	*/

    /*

    function balanceOf(address _address) public view returns (uint256) {
        return balances[_address];
    }

    /* fetch total tokens		*/

    // function totalSupply() public view returns (uint256) {
    //     return totalarea;
    // }

    /* if conditions for admin purposes.
     */

    // function maxSupply() public view returns (uint256) {
    //     return maxSupply;
    // }

    // function circulationSupply() public view returns (uint256) {
    //     return circulationsupply;
    // }

    function totalSupply() public view virtual override returns (uint256) {
        return circulationsupply;
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }


    modifier onlyAdmin() {
        require(admins[msg.sender]);
        _;
    }

    modifier childcontract() {
        require(msg.sender == timelockcontractaddress);
        _;
    }

    // modifier airdropOnce() {
    //     require(tokensAirdropped == false, "Tokens already airdropped");
    //     _;
    // }
}

// Timelock contract //

contract ProjectTimeLock {
    struct Vestingperiod {
        uint256 totalsupply;
        uint256 starttime;
        uint256 endtime;
        address owneraddress;
    }

    IERC20Upgradeable public token;
    address public maincontract;
    ProjectContract c;

    // mapping for vesting stages

    mapping(string => Vestingperiod) public vestingstages;

    constructor(address _maincontract) {
        c = ProjectContract(_maincontract);
        maincontract = _maincontract;
        token = IERC20Upgradeable(_maincontract);
    }

    function depositaddress(
        string memory name,
        uint256 _tokensupply,
        uint256 _starttime,
        uint256 _endtime
    ) public onlymaincontract returns (bool success) {
        vestingstages[name] = Vestingperiod(
            _tokensupply,
            _starttime,
            _endtime,
            msg.sender
        );
        return true;
    }

    function updateDate(string memory _name, uint256 _startTime, uint256 _endTime) public onlymaincontract returns (bool success) {
        require(_startTime >= block.timestamp, "Start time cannot be before current time");
        require(_endTime >= block.timestamp, "End time cannot be before current time");
        require(_endTime > _startTime, "Start time cannot be greater than End time");
        vestingstages[_name].starttime = _startTime;
        vestingstages[_name].endtime = _endTime;

        return true;
    }

    function updateSupply(string memory _name, uint256 _supply) public onlymaincontract returns (bool success) {
        vestingstages[_name].totalsupply += _supply;

        return true;
    }

    function withdrawltokens(string memory _name, address _projectWallet)
        public
        payable
        onlymaincontract
        returns (bool success)
    {
        require(vestingstages[_name].starttime <= block.timestamp, "current date is before start date");
        uint256 amount = vestingstages[_name].totalsupply;
        vestingstages[_name].totalsupply = 0;
        c.deposittimelock(amount);
        token.transfer(_projectWallet, amount);
        return true;
    }

    function getvestingdetails(string memory _name)
        public
        view
        returns (
            uint256,
            uint256,
            uint256,
            address
        )
    {
        return (
            vestingstages[_name].totalsupply,
            vestingstages[_name].starttime,
            vestingstages[_name].endtime,
            vestingstages[_name].owneraddress
        );
    }

    modifier onlymaincontract() {
        require(maincontract == msg.sender);
        _;
    }
}

//add interface
//bitwise or for calling functions