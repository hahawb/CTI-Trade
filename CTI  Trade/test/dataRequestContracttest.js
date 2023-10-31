const DataRequestContract = artifacts.require("DataRequestContract");

contract("DataRequestContract", (accounts) => {
  let dataRequestContract;

  beforeEach(async () => {
    dataRequestContract = await DataRequestContract.new(12345); // 传入 requestDataId
  });

  it("should calculate Gas Used and Gas Cost for Request", async () => {
    const tx = await dataRequestContract.setResponseContract(accounts[1]);
    const gasUsed = tx.receipt.gasUsed;

    const gasPrice = await web3.eth.getGasPrice();
    const gasCost = gasUsed * gasPrice;

    // 将 gas cost 转换为以太币单位（Ether）
    const gasCostInEther = web3.utils.fromWei(gasCost.toString(), 'ether');

    console.log("Gas Used for Request: ", gasUsed);
    console.log("Gas Cost for Request (ETH): ", gasCostInEther);
  });
});
