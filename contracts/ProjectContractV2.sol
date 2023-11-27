//SPDX-License-Identifier: MIT

pragma solidity 0.8.5;
//import "@openzeppelin/contracts/utils/math/SafeMath.sol";
//import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
//import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "./ProjectContract.sol";

contract ProjectContractV2 is ProjectContract{


    // function increaseTokenSupply(uint256 _number) external onlyAdmin {
    //     maxSupply += _number;
    //     // totalarea = totaltokens;
    //     // circulationsupply += _number * (10 ** 18);
    //     // mintTokens(_number);
    // }

    function toggleAirdrop() external onlyAdmin {
        require(tokensAirdropped, "Tokens not airdropped yet");
        tokensAirdropped = false;
    }

}

    // function mintTokens(uint256 _num) internal {
    //     _mint(msg.sender, _num * (10 ** 18));
    // }

    //add all these functions in base contract
    //add airdrop functionality

    // function updateRoundDate(string memory _name, uint256 _startDate, uint256 _endDate) external onlyAdmin {
    //     ProjectTimeLock timelock = ProjectTimeLock(timelockcontractaddress);
    //     timelock.updateDate(_name, _startDate, _endDate);
    // }

    // function updateRoundSupply(string memory _name, uint256 _tokens) external onlyAdmin returns (bool success) {
    //     require(_tokens <= circulationsupply);
    //     ProjectTimeLock timelock = ProjectTimeLock(timelockcontractaddress);
    //     balances[daowallet] = balances[daowallet] - _tokens;
    //     circulationsupply = circulationsupply - _tokens;
    //     timelock.updateSupply(_name, _tokens);
    //     emit lockfunds(_name, _tokens);

    //     return true;
    // }

    // function burnTokens(uint256 _amount) external {
    //     _burn(msg.sender, _amount);
    // }

    //add 3 more functions
    //increases supply of existing round whose supply was done mistakenly✅
    //can update start/end date of rounds. can enter new dates✅
    //decrease/burn supply.✅

    //add all these functions in base contract✅
    //add airdrop functionality✅
//}

// Timelock contract //
/*
contract ProjectTimeLock {
    struct Vestingperiod {
        uint256 totalsupply;
        uint256 starttime;
        uint256 endtime;
        address owneraddress;
    }

    address public maincontract;
    ProjectContractV2 c;

    // mapping for vesting stages

    mapping(string => Vestingperiod) public vestingstages;

    constructor(address _maincontract) {
        c = ProjectContractV2(_maincontract);
        maincontract = _maincontract;
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

    function withdrawltokens(string memory _name)
        public
        payable
        onlymaincontract
        returns (bool success)
    {
        require(vestingstages[_name].starttime <= block.timestamp);
        uint256 amount = vestingstages[_name].totalsupply;
        vestingstages[_name].totalsupply = 0;
        c.deposittimelock(amount);
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
*/