const market = artifacts.require("MainMarket");
module.exports = function(deployer) {
  deployer.deploy(market);
};