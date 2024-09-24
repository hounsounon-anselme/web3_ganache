async function main() {
  const NoisyCoordinates = await ethers.getContractFactory("NoisyCoordinates");
  const instance = await NoisyCoordinates.deploy();

  console.log("NoisyCoordinates deployed to:", instance.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

