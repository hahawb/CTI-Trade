const StorageContract = artifacts.require("StorageContract");

contract("StorageContract", (accounts) => {
  let storageContract;

  beforeEach(async () => {
    storageContract = await StorageContract.new();
  });

  it("should calculate Gas Used and Gas Cost for Data Upload", async () => {
    const cid = web3.utils.fromAscii("1234567890");
    const ctiMetadata = "Sample Metadata";
    const checksum = web3.utils.fromAscii("abcdef123456");
    const grouping = "Group A";
    const price = 100;
    const reputationRequirement = 50;

    // 调用 addData 函数并记录 Gas Used
    const tx = await storageContract.addData(
      cid,
      ctiMetadata,
      checksum,
      grouping,
      price,
      reputationRequirement,
      { from: accounts[0] }
    );
    const gasUsed = tx.receipt.gasUsed;

    // 获取 Gas Price
    const gasPrice = await web3.eth.getGasPrice();

    // 计算 Gas Cost
    const gasCost = gasUsed * gasPrice;

    console.log("Gas Used for Data Upload: " + gasUsed);
    console.log("Gas Cost for Data Upload (ETH): " + web3.utils.fromWei(gasCost.toString(), "ether"));
  });

  it("should calculate Gas Used and Gas Cost for Data Query", async () => {
    const keyword = "Sample"; // 模拟查询关键词

    // 估算 searchDataByKeyword 函数的 gas 使用量
    const gasEstimate = await storageContract.searchDataByKeyword.estimateGas(keyword);

    // 获取 Gas Price
    const gasPrice = await web3.eth.getGasPrice();

    // 计算 Gas Cost
    const gasCost = gasEstimate * gasPrice;

    console.log("Gas Used for Data Query: " + gasEstimate);
    console.log("Gas Cost for Data Query (ETH): " + web3.utils.fromWei(gasCost.toString(), "ether"));
});
});
