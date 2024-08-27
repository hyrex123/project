pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTDiplomas is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Structure to store diploma details
    struct Diploma {
        string studentName;
        string courseName;
        string institutionName;
        uint256 dateOfIssue;
    }

    // Mapping from token ID to diploma details
    mapping(uint256 => Diploma) private diplomas;

    constructor() ERC721("NFT Diplomas", "NFTD") {}

    // Function to issue a new diploma
    function issueDiploma(
        address recipient,
        string memory studentName,
        string memory courseName,
        string memory institutionName
    ) public onlyOwner returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);

        diplomas[newItemId] = Diploma({
            studentName: studentName,
            courseName: courseName,
            institutionName: institutionName,
            dateOfIssue: block.timestamp
        });

        return newItemId;
    }

    // Function to view diploma details
    function viewDiploma(uint256 tokenId)
        public
        view
        returns (
            string memory studentName,
            string memory courseName,
            string memory institutionName,
            uint256 dateOfIssue
        )
    {
        require(_exists(tokenId), "ERC721Metadata: Query for nonexistent token");

        Diploma memory diploma = diplomas[tokenId];
        return (
            diploma.studentName,
            diploma.courseName,
            diploma.institutionName,
            diploma.dateOfIssue
        );
    }
}
