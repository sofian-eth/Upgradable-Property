// SPDX-License-Identifier: MIT

pragma solidity 0.8.5;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NFT is ERC721Enumerable, Ownable {
  using Strings for uint256;

  string public baseURI;
  string public baseExtension = ".json";
  //uint256 public cost = 0.05 ether;
  uint256 public maxSupply;
  uint256 public availableTokens;
  IERC20 public paymentToken;
  //uint256 public maxMintAmount = 20;
  bool public paused = false;

  mapping(uint256 => uint256) public tokenPrices;

  constructor(
    string memory _name,
    string memory _symbol,
    address _token,
    string memory _initBaseURI
  ) ERC721(_name, _symbol) {
    setBaseURI(_initBaseURI);
    //mint(msg.sender, 20);
    paymentToken = IERC20(_token);
    maxSupply = 200;
    availableTokens = maxSupply;

    for (uint256 i = 1; i <= 100; i++) {
      setTokenPrice(i, 10000000);
    }
    
    for (uint256 i = 101; i <= 150; i++) {
      setTokenPrice(i, 15000000);
    }
    
    for (uint256 i = 151; i <= 200; i++) {
      setTokenPrice(i, 20000000);
    }
  }

  // internal
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  // public
  function mint(address _to, uint256 _mintAmount) public payable {
    uint256 supply = totalSupply();
    require(!paused);
    require(_mintAmount > 0);
    // require(_mintAmount <= maxMintAmount);
    require(supply + _mintAmount <= maxSupply);

    for (uint256 i = 1; i <= _mintAmount; i++) {
      _safeMint(_to, supply + i);
    }
  }

  function purchaseToken(uint256 tokenId) public {
    require(tokenId > 0 && tokenId <= maxSupply, "Invalid token ID");
    require(tokenPrices[tokenId] > 0, "Token not available for purchase");
    require(availableTokens > 0, "NFT's sold out");

    uint256 tokenPrice = tokenPrices[tokenId];

    paymentToken.transferFrom(msg.sender, address(this), tokenPrice);
    _safeMint(msg.sender, tokenId);
    //_mint(msg.sender, tokenId);
    availableTokens -= 1;
    tokenPrices[tokenId] = 0; // Set the price to 0 to mark it as sold
    }

  function walletOfOwner(address _owner)
    public
    view
    returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
        : "";
  }

  //only owner
  // function setCost(uint256 _newCost) public onlyOwner {
  //   cost = _newCost;
  // }

  function setTokenPrice(uint256 tokenId, uint256 price) public onlyOwner {
      require(tokenId > 0 && tokenId <= maxSupply, "Invalid token ID");
      tokenPrices[tokenId] = price;
  }

  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;
  }

  function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
    baseExtension = _newBaseExtension;
  }

  function pause(bool _state) public onlyOwner {
    paused = _state;
  }

  function withdraw() public payable onlyOwner {
    (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
  }

  function withdrawTokens() public onlyOwner {
    paymentToken.transfer(owner(), paymentToken.balanceOf(address(this)));
  }
}