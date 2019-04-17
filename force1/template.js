var forcecontract = '%ADDR%'; // Initial Supply
var forceExploitContract = web3.eth.contract(%ABI%);
var forceExploit = forceExploitContract.new(
   forcecontract,
   {
     from: web3.eth.accounts[3],
     data: '0x%DATA%', 
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + 
                     ' transactionHash: ' + contract.transactionHash);
    }
 })
