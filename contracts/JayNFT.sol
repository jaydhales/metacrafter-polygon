// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "ERC721A/ERC721A.sol";

contract JayNFT is ERC721A {
    uint8 public constant maxSupply = 5;
    string[5] private prompts = [
        "Behold Embercrest, the Fire Dragon, born of flames that dance upon its scales like liquid fire. Against a canvas of twilight, this dragon's incandescent presence illuminates the dreamscape, radiating warmth and passion, a symbol of untamed energy and fierce determination.",
        "Tidecaller, the Water Dragon, gracefully navigates a world of serene oceans and shimmering tides. Its scales ripple with opalescent hues, reflecting the moon's tender embrace. In the tranquil depths of this dreamy landscape, Tidecaller embodies fluidity, adaptability, and the boundless mysteries of the deep.",
        "Within the heart of lush, verdant landscapes, Earthforge emerges, adorned with crystalline scales and moss-covered grandeur. A guardian of ancient secrets and unyielding strength, this Earth Dragon embodies resilience, stability, and the nurturing embrace of nature's enduring power.",
        "Aetherweave, the Air Dragon, dances amidst swirling currents of iridescent hues. Its ethereal form traverses endless skies, embodying freedom, agility, and the whispers of dreams carried on the breeze. A wisp of enchantment, Aetherweave embodies the boundless expanse of the heavens.",
        "Ethereal Nexus, the Ether Dragon, transcends elemental boundaries, a convergence of cosmic energies amidst a dreamscape of celestial wonders. Its ever-shifting form embodies the essence of possibility, where imagination intertwines with the fabric of reality, inviting dreamers to explore the infinite realms of creativity."
    ];

    constructor() ERC721A("JayNFT", "JAY") {}

    function mint(address to, uint256 quantity) external {
        require(to != address(0), "JayNFT: Cannot mint to the zero address");
        require(totalSupply() + quantity <= maxSupply, "JayNFT: Cannot mint more than maxSupply");
        _safeMint(to, quantity);
    }

    function promptDescription(uint256 tokenId) public view returns (string memory) {
        return prompts[tokenId - 1];
    }

    function _startTokenId() internal view virtual override returns (uint256) {
        return 1;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "ipfs://QmdRnGGUicXJSsfz1xJKQDCKgtfF53JcUbticRe5DYA6mN/";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (!_exists(tokenId)) revert URIQueryForNonexistentToken();

        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, _toString(tokenId), ".json")) : "";
    }
}
