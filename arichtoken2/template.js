var initialSupply = %INI%; // Initial Supply
var arichtokenContract = web3.eth.contract(%ABI%);
var arichtoken = arichtokenContract.new(
   initialSupply,
   {
     from: web3.eth.accounts[0],
     data: '0x%DATA%', 
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + 
                     ' transactionHash: ' + contract.transactionHash);
    }
 })
