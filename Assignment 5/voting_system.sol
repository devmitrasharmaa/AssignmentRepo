// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {

    struct Proposal {
        string description;
        uint voteCount;
    }

    struct Voter {
        bool hasVoted;
        uint votedProposalId;
    }

    Proposal[] public proposals;
    mapping(address => Voter) public voters;

    event ProposalCreated(uint proposalId, string description);
    event Voted(address voter, uint proposalId);
    event WinningProposal(uint proposalId, string description, uint voteCount);

    // Create a new proposal with a description.
    function createProposal(string memory _description) public {
        proposals.push(Proposal({
            description: _description,
            voteCount: 0
        }));
        emit ProposalCreated(proposals.length - 1, _description);
    }

    // Vote for a proposal by its ID.
    function vote(uint _proposalId) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.hasVoted, "You have already voted.");
        require(_proposalId < proposals.length, "Proposal does not exist.");

        sender.hasVoted = true;
        sender.votedProposalId = _proposalId;

        proposals[_proposalId].voteCount += 1;
        emit Voted(msg.sender, _proposalId);
    }

    // Get the proposal with the most votes.
    function getWinningProposal() public view returns (uint winningProposalId, string memory description, uint voteCount) {
        uint highestVoteCount = 0;

        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > highestVoteCount) {
                highestVoteCount = proposals[i].voteCount;
                winningProposalId = i;
            }
        }
        description = proposals[winningProposalId].description;
        voteCount = proposals[winningProposalId].voteCount;
    }

    // Emit an event to announce the winning proposal.
    function announceWinner() public {
        (uint winningProposalId, string memory description, uint voteCount) = getWinningProposal();
        emit WinningProposal(winningProposalId, description, voteCount);
    }
}
