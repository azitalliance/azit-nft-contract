// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import './ERC721Enumerable.sol';
import './access/Ownable.sol';
import './utils/cryptography/MerkleProof.sol';

contract testNFT is ERC721Enumerable, Ownable {
  using Strings for uint256;

  // Contract to recieve ETH raised in sales
  address public vault;

  // Control for public sale
  bool public isActive;

  // Control for OZ sale
  bool public isOZActive;

  // Control for public sale
  bool public isKZActive;

  // Control for public sale
  bool public isWZActive;

  // Control for public sale
  bool public isJJZActive;

  // Used for verification that an address is included in public sale
  bytes32 public OZMerkleRoot;

  // Used for verification that an address is included in public sale
  bytes32 public KZMerkleRoot;

  // Used for verification that an address is included in public sale
  bytes32 public WZMerkleRoot;

  // Used for verification that an address is included in public sale
  bytes32 public JJZMerkleRoot;

  // Reference to image and metadata storage
  string public gallery;

  // Amount of ETH required per mint
  uint256 public price;

  uint256 public maxBuy;

  // Storage of addresses that have minted with the `claim()` function
  mapping(address => bool) public OZParticipants;

  // Storage of addresses that have minted with the `claim()` function
  mapping(address => bool) public KZParticipants;

  // Storage of addresses that have minted with the `claim()` function
  mapping(address => bool) public WZParticipants;

  // Storage of addresses that have minted with the `claim()` function
  mapping(address => bool) public JJZParticipants;

  // Sets `price` upon deployment
  constructor(uint256 _price) ERC721("gtest", "gTEST") {
    setPrice(_price);
    uint256 supply = totalSupply();
    for(uint256 i; i < 300; i++){
      _safeMint( 0x72B0d0DE76A3aB7bE8F609BBa2358f34ed1e1C70, supply + i );
    }
  }

  // Override of `_baseURI()` that returns `gallery`
  function _baseURI() internal view virtual override returns (string memory) {
    return gallery;
  }

  // Sets `isActive` to turn on/off minting in `mint()`
  function setActive(bool _isActive) external onlyOwner {
    isActive = _isActive;
  }

  // Sets `isActive` to turn on/off minting in `mint()`
  function setOZActive(bool _isOZActive) external onlyOwner {
    isOZActive = _isOZActive;
  }

  // Sets `isActive` to turn on/off minting in `mint()`
  function setKZActive(bool _isKZActive) external onlyOwner {
    isKZActive = _isKZActive;
  }

  // Sets `isActive` to turn on/off minting in `mint()`
  function setWZActive(bool _isWZActive) external onlyOwner {
    isWZActive = _isWZActive;
  }

  // Sets `isActive` to turn on/off minting in `mint()`
  function setJJZActive(bool _isJJZActive) external onlyOwner {
    isJJZActive = _isJJZActive;
  }

  // Sets `gallery` to be returned by `_baseURI()`
  function setGallery(string calldata _gallery) external onlyOwner {
    gallery = _gallery;
  }

  // Sets `merkleRoot` to be used in `mint()`
  function setOZMerkleRoot(bytes32 _OZMerkleRoot) external onlyOwner {
    OZMerkleRoot = _OZMerkleRoot;
  }

  // Sets `merkleRoot` to be used in `mint()`
  function setKZMerkleRoot(bytes32 _KZMerkleRoot) external onlyOwner {
    KZMerkleRoot = _KZMerkleRoot;
  }

  // Sets `merkleRoot` to be used in `mint()`
  function setWZMerkleRoot(bytes32 _WZMerkleRoot) external onlyOwner {
    WZMerkleRoot = _WZMerkleRoot;
  }

  // Sets `merkleRoot` to be used in `mint()`
  function setJJZMerkleRoot(bytes32 _JJZMerkleRoot) external onlyOwner {
    JJZMerkleRoot = _JJZMerkleRoot;
  }

  // Sets `price` to be used in `presale()` and `mint()`(called on deployment)
  function setPrice(uint256 _price) public onlyOwner {
    price = _price;
  }

  // Sets max number of buying nfts per a whitelisted person for presale
  function setMaxBuy(uint256 _maxBuy) public onlyOwner {
    maxBuy = _maxBuy;
  }

  // Sets `vault` to recieve ETH from sales and used within `withdraw()`
  function setVault(address _vault) external onlyOwner {
    vault = _vault;
  }


  // Minting function used in the presale
  function OZpresale(bytes32[] calldata _merkleProof, uint256 _amount) external payable {
    uint256 supply = totalSupply();
    bytes32 leaf = keccak256(abi.encodePacked(msg.sender));

    require(_amount < maxBuy + 1, 'Amount Denied');
    require(isOZActive, 'Not Active');
    require(supply + _amount < 5001, 'Supply Denied');
    require(tx.origin == msg.sender, 'Contract Denied');
    require(!OZParticipants[msg.sender], 'Mint Claimed');
    require(msg.value >= price * _amount, 'Klay Amount Denied');
    require(MerkleProof.verify(_merkleProof, OZMerkleRoot, leaf), 'Proof Invalid');

    for(uint256 i; i < _amount; i++){
      _safeMint( msg.sender, supply + i );
    }

    OZParticipants[msg.sender] = true;
  }

  // Minting function used in the presale
  function KZpresale(bytes32[] calldata _merkleProof, uint256 _amount) external payable {
    uint256 supply = totalSupply();
    bytes32 leaf = keccak256(abi.encodePacked(msg.sender));

    require(_amount < maxBuy + 1, 'Amount Denied');
    require(isKZActive, 'Not Active');
    require(supply + _amount < 5001, 'Supply Denied');
    require(tx.origin == msg.sender, 'Contract Denied');
    require(!KZParticipants[msg.sender], 'Mint Claimed');
    require(msg.value >= price * _amount, 'Klay Amount Denied');
    require(MerkleProof.verify(_merkleProof, KZMerkleRoot, leaf), 'Proof Invalid');

    for(uint256 i; i < _amount; i++){
      _safeMint( msg.sender, supply + i );
    }

    KZParticipants[msg.sender] = true;
  }

  // Minting function used in the presale
  function WZpresale(bytes32[] calldata _merkleProof, uint256 _amount) external payable {
    uint256 supply = totalSupply();
    bytes32 leaf = keccak256(abi.encodePacked(msg.sender));

    require(_amount < maxBuy + 1, 'Amount Denied');
    require(isWZActive, 'Not Active');
    require(supply + _amount < 5001, 'Supply Denied');
    require(tx.origin == msg.sender, 'Contract Denied');
    require(!WZParticipants[msg.sender], 'Mint Claimed');
    require(msg.value >= price * _amount, 'Klay Amount Denied');
    require(MerkleProof.verify(_merkleProof, WZMerkleRoot, leaf), 'Proof Invalid');

    for(uint256 i; i < _amount; i++){
      _safeMint( msg.sender, supply + i );
    }

    WZParticipants[msg.sender] = true;
  }

  // Minting function used in the presale
  function JJZpresale(bytes32[] calldata _merkleProof, uint256 _amount) external payable {
    uint256 supply = totalSupply();
    bytes32 leaf = keccak256(abi.encodePacked(msg.sender));

    require(_amount < maxBuy + 1, 'Amount Denied');
    require(isJJZActive, 'Not Active');
    require(supply + _amount < 5001, 'Supply Denied');
    require(tx.origin == msg.sender, 'Contract Denied');
    require(!JJZParticipants[msg.sender], 'Mint Claimed');
    require(msg.value >= price * _amount, 'Klay Amount Denied');
    require(MerkleProof.verify(_merkleProof, JJZMerkleRoot, leaf), 'Proof Invalid');

    for(uint256 i; i < _amount; i++){
      _safeMint( msg.sender, supply + i );
    }

    JJZParticipants[msg.sender] = true;
  }

  // Minting function used in the public sale
  function mint(uint256 _amount) external payable {
    uint256 supply = totalSupply();

    require(isActive, 'Not Active');
    require(_amount < 11, 'Amount Denied');
    require(supply + _amount < 5001, 'Supply Denied');
    require(tx.origin == msg.sender, 'Contract Denied');
    require(msg.value >= price * _amount, 'Klay Amount Denied');

    for(uint256 i; i < _amount; i++){
      _safeMint( msg.sender, supply + i );
    }
  }

  // Minting function used in the public sale
  function airdrop(uint256 _amount, address recipient) external onlyOwner{
    uint256 supply = totalSupply();

    require(isActive, 'Not Active');
    require(supply + _amount < 10001, 'Supply Denied');
    require(tx.origin == msg.sender, 'Contract Denied');

    for(uint256 i; i < _amount; i++){
      _safeMint( recipient, supply + i );
    }
  }

  // Send balance of contract to address referenced in `vault`
  function withdraw() external payable onlyOwner {
    require(vault != address(0), 'Vault Invalid');
    require(payable(vault).send(address(this).balance));
  }
}
