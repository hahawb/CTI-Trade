const ReputationSystem = artifacts.require("ReputationSystem");

contract("ReputationSystem", (accounts) => {
    const consumer = accounts[0];

    it("should upload review and measure gas cost", async () => {
        const reputationSystemInstance = await ReputationSystem.new(consumer);

        const DQ = 8; // Example Data Quality score
        const OT = 9; // Example On-Time Delivery score
        const DS = 7; // Example Data Security score
        const DI = 6; // Example Data Integrity score
        const comments = "Great service and high-quality data.";

        const tx = await reputationSystemInstance.uploadReview(DQ, OT, DS, DI, comments, { from: consumer });

        // 获取 gas used 和 gas cost
        const gasUsed = new web3.utils.BN(tx.receipt.gasUsed);
        const gasPrice = new web3.utils.BN(await web3.eth.getGasPrice());
        const gasCost = web3.utils.fromWei(gasUsed.mul(gasPrice), "ether");

        // 打印 gas used 和 gas cost
        console.log("Gas Used:", gasUsed.toString());
        console.log("Gas Cost (ether):", gasCost);

        // 添加断言以验证您的测试条件
        assert.equal(true, true); // 替换为您的实际断言条件
    });
});
