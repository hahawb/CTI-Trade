const DataRequestContract = artifacts.require("DataRequestContract"); // 替换为您的合同名称

contract("DataRequestContract", (accounts) => {
  let acceptInstance;
  let rejectInstance;
  const requester = accounts[0];
  const dataProvider = accounts[1];

  before(async () => {
    acceptInstance = await DataRequestContract.new(dataProvider, { from: requester });
    rejectInstance = await DataRequestContract.new(dataProvider, { from: requester });
  });

  it("should accept a request and measure gas consumption", async () => {
    const responseDataCID = web3.utils.soliditySha3("your_response_data");
    const responseHash = web3.utils.soliditySha3("your_response_hash");

    const tx = await acceptInstance.receiveResponse(responseDataCID, responseHash, { from: dataProvider });
    const gasUsed = tx.receipt.gasUsed;
    const gasPrice = await web3.eth.getGasPrice();
    const gasCostWei = gasUsed * gasPrice;
    const gasCostEther = web3.utils.fromWei(gasCostWei.toString(), "ether");
    console.log(`Accept Request - Gas Used: ${gasUsed}, Gas Cost (Ether): ${gasCostEther}`);
  });

  it("should reject a request and measure gas consumption", async () => {
    const tx = await rejectInstance.rejectResponse({ from: dataProvider });
    const gasUsed = tx.receipt.gasUsed;
    const gasPrice = await web3.eth.getGasPrice();
    const gasCostWei = gasUsed * gasPrice;
    const gasCostEther = web3.utils.fromWei(gasCostWei.toString(), "ether");
    console.log(`Reject Request - Gas Used: ${gasUsed}, Gas Cost (Ether): ${gasCostEther}`);
  });
});
