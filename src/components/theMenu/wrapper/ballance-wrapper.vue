<template>
  <div
     class="w-full h-auto mt-6 py-8 flex flex-col text-center rounded-3xl relative bg-white shadow-lg dark:shadow-none dark:bg-light-slat-Blue"
   >
     <p class="text-[12px] xl:text-[14px] font-semibold text-[#A1A2AF] dark:text-melrose">Your Balance</p>
     <p class="text-[30px] xl:text-[34px] font-semibold mt-4 z-10 dark:text-white">
       Escrow Balance: {{ escrowBalance }} ETH
     </p>
     <p>Message: {{ message }}</p>
     <div class="flex justify-center mt-3 z-10">
       <img
         :src="require('@/assets/img/logos_ethereum.svg')"
         alt=""
         class="w-[10px]"
       />
       <p class="text-[15px] font-semibold ml-2 text-[#A1A2AF] dark:text-melrose">ETH</p>
     </div>
     <img
       :src="require('@/assets/img/Stastistic-white-mode.png')"
       alt=""
       class="w-[80%] self-center -mt-5"
       :class="darkMode ? 'hidden' : 'block'"
     />
     <img
       :src="require('@/assets/img/Stastistic.png')"
       alt=""
       class="w-[80%] self-center -mt-5"
       :class="darkMode ? 'block' : 'hidden'"
     />
     <img
       :src="require('@/assets/img/Stastistic-bg.png')"
       alt=""
       class="w-[320px] absolute"
       :class="darkMode ? 'block' : 'hidden'"
     />

     <div
       class="w-[80%] h-14 flex justify-center gap-1 xl:gap-0 xl:justify-between items-center px-5 mt-5 self-center rounded-full border-2 border-[#F1F3F6] dark:border-none dark:bg-light-indigo hover:cursor-pointer"
     >
       <div
         class="hidden xl:flex justify-center items-center w-6 h-6 rounded-full bg-[#5AE6BC] dark:bg-bright-sun"
       >
         <i
           class="ri-add-line text-xl align-middle dark:text-light-slat-Blue"
         ></i>
       </div>
       <p class="text-[12px] font-medium xl:text-[16px] xl:font-semibold ml-3 dark:text-white text-center"  @click="topUp">
         Top Up Balance
       </p>

       <i class="ri-arrow-right-s-line text-xl dark:text-white"></i>
     </div>
   </div>
</template>

<script>
import { computed } from "vue";
import { useStore } from "vuex";
import Web3 from 'web3';
import ContractABI from './ContractAbi.json';

export default {
 setup() {
   const store = useStore();
   const darkMode = computed(() => store.getters.darkMode);

   return {
     darkMode,
   };
 },
 data() {
   return {
     contractAddress: '0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8',
     web3: null,
     contract: null,
     account: null,
     balance: 0,
     message: '',
     escrowBalance: 0,
   };
 },
 async created() {
   await this.loadWeb3();
   await this.loadContract();
   await this.loadAccount();
   await this.loadBalance();
   await this.loadEscrowBalance(); // Load escrow balance here
 },
 methods: {
   async loadWeb3() {
     if (typeof window.ethereum !== 'undefined') {
       this.web3 = new Web3(window.ethereum);
       try {
         // Request account access if needed
         await window.ethereum.request({ method: 'eth_requestAccounts' });
       } catch (error) {
         console.error('User denied account access');
       }
     } else {
       console.error('No web3 provider detected');
     }
   },
   async loadContract() {
     // Load contract instance using this.web3 and ContractABI
     if (!this.web3) {
       console.error('Web3 is not initialized');
       return;
     }
     this.contract = new this.web3.eth.Contract(ContractABI, this.contractAddress);
   },
   async loadAccount() {
     // Load user's Ethereum account
     const accounts = await this.web3.eth.getAccounts();
     this.account = accounts[0];
   },
   async loadBalance() {
     // Load user's balance
     const balanceWei = await this.web3.eth.getBalance(this.account);
     this.balance = this.web3.utils.fromWei(balanceWei, 'ether');
   },
   async loadEscrowBalance() {
     try {
       // Load user's escrow balance using the contract
       const escrowBalanceWei = await this.contract.methods.balances(this.account).call();
       this.escrowBalance = this.web3.utils.fromWei(escrowBalanceWei, 'ether');
     } catch (error) {
       console.error('Error:', error);
     }
   },
   async topUp() {
     try {
       // Top up the balance using the contract
       // ...
     } catch (error) {
       this.message = 'Error occurred while topping up';
       console.error('Error:', error);
     }
   },
   // Other methods for deposit, withdraw, release
 },
};
</script>

<style>
/* Your styles here */
</style>