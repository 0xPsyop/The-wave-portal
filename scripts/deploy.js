
const main = async() => {


  const token = await hre.ethers.getContractFactory('WavePortal');
  const portal = await token.deploy({
    value: hre.ethers.utils.parseEther('0.001'),
  });
  await portal.deployed();

  console.log('WavePortal address: ', portal.address);
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