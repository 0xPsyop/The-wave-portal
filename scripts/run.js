
const main = async() => {
	
	const waveContractfactory = await hre.ethers.getContractFactory('WavePortal');
	const waveContract  = await waveContractfactory.deploy({
    value: hre.ethers.utils.parseEther('0.1'),
    });
	await waveContract.deployed();

	console.log("contract deployed to :", waveContract.address);

	let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);

	console.log('Contract balance:',hre.ethers.utils.formatEther(contractBalance));

	

	let waveCount;
	waveCount = await waveContract.getTotalWaves();
	console.log(waveCount.toNumber());

	let waved = await waveContract.wave("the first wave");
	await waved.wait();
    

	contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log('Contract balance:', hre.ethers.utils.formatEther(contractBalance));


	waveCount = await waveContract.getTotalWaves();
    
     console.log(waveCount);
}

const runMain = async() => {
	try{
		await main();
		process.exit(0);
	} catch(err){
		console.log(err);
		process.exit(1);
	}
}

runMain();