//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LirnV1 is Initializable, ERC1155Upgradeable, OwnableUpgradeable {
    uint256 public constant Quiz1 = 1; //not needed

    string public LirnNFT;

    mapping(address => mapping(uint256 => uint256)) public supplyBalance;

    //constructor() ERC1155(LirnNFT) {

    // }

    function initialize() external initializer {
        LirnNFT = "ipfs://QmPLT5TzcnDEML9jHfrcip7trFLokN7yAPGnpfBYxx3T6F/";
        __ERC1155_init(LirnNFT);
        __Ownable_init();
    }

    function mintQuiz(address _adr, uint256 _quiz) external {
        // removed onlyOwner for demo
        require(supplyBalance[_adr][_quiz] < 1, "Already owns this Quiz NFT");
        _mint(_adr, _quiz, 1, "");
        supplyBalance[msg.sender][_quiz] += 1;
    }

    function burnToken(address _adr, uint256 _id) external onlyOwner {
        _burn(_adr, _id, 1);
        supplyBalance[msg.sender][_id] -= 1;
    }

    function name() public pure returns (string memory) {
        return "Lirn Onboard";
    }

    function symbol() public pure returns (string memory) {
        return "Lirn";
    }

    // URI overide for number schemes
    function uri(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(LirnNFT, Strings.toString(_tokenId), ".json")
            );
    }

    //Make Nontranferable
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
        // Ignore transfers during minting
        if (from == address(0)) {
            return;
        }
        require(to == address(0), "Cannot transfer knowledge fam");
    }

    //onlyOwner
    function updateURI(string memory _uri) external onlyOwner {
        LirnNFT = _uri;
    }
}
