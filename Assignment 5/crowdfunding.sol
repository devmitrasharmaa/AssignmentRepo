// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    
    struct Campaign {
        address payable creator;
        uint goalAmount;
        uint deadline;
        uint totalContributed;
        bool finalized;
        mapping(address => uint) contributions;
    }
    
    mapping(uint => Campaign) public campaigns;
    uint public campaignCount;
    
    event CampaignCreated(uint campaignId, address creator, uint goalAmount, uint deadline);
    event ContributionMade(uint campaignId, address contributor, uint amount);
    event CampaignFinalized(uint campaignId, bool successful);
    
    // Create a new campaign with a goal amount and a deadline.
    function createCampaign(uint _goalAmount, uint _durationInDays) public {
        campaignCount++;
        Campaign storage newCampaign = campaigns[campaignCount];
        newCampaign.creator = payable(msg.sender);
        newCampaign.goalAmount = _goalAmount;
        newCampaign.deadline = block.timestamp + (_durationInDays * 1 days);
        newCampaign.finalized = false;
        
        emit CampaignCreated(campaignCount, msg.sender, _goalAmount, newCampaign.deadline);
    }
    
    // Contribute funds to a campaign.
    function contribute(uint _campaignId) public payable {
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp <= campaign.deadline, "Campaign has ended.");
        require(msg.value > 0, "Contribution must be greater than zero.");
        
        campaign.totalContributed += msg.value;
        campaign.contributions[msg.sender] += msg.value;
        
        emit ContributionMade(_campaignId, msg.sender, msg.value);
    }
    
    // Finalize the campaign once the deadline has passed.
    function finalizeCampaign(uint _campaignId) public {
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp > campaign.deadline, "Campaign is still ongoing.");
        require(!campaign.finalized, "Campaign is already finalized.");
        
        if (campaign.totalContributed >= campaign.goalAmount) {
            // If the goal is met, transfer funds to the creator.
            campaign.creator.transfer(campaign.totalContributed);
            emit CampaignFinalized(_campaignId, true);
        } else {
            // If the goal is not met, allow contributors to withdraw their funds.
            emit CampaignFinalized(_campaignId, false);
        }
        
        campaign.finalized = true;
    }
    
    // Allow contributors to withdraw their funds if the campaign failed.
    function withdrawContribution(uint _campaignId) public {
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp > campaign.deadline, "Campaign is still ongoing.");
        require(!campaign.finalized || campaign.totalContributed < campaign.goalAmount, "Campaign was successful.");
        
        uint contributedAmount = campaign.contributions[msg.sender];
        require(contributedAmount > 0, "You have no contributions to withdraw.");
        
        campaign.contributions[msg.sender] = 0;
        payable(msg.sender).transfer(contributedAmount);
    }
}
