<template>
   <div class="flex w-full gap-3">
      <div class="basis-1/4">
        
      <!-- img -->
      <img
          :src="require('@/assets/img/1.jpg')"
          alt=""
          class="w-16 rounded-full"
        />
      </div>
      
      <!-- name -->
      <div class="basis-2/4">
        <p class="text-[20px] xl:text-[24px] font-semibold text-[#131736] dark:text-white">Moses</p>
        <p class="text-[12px] xl:text-[14px] font-medium xl:font-semibold text-[#A0A2AE] dark:text-white">
         Investor
          <span class="text-bright-sun">
            Pro
            <i class="ri-add-line align-middle"></i>
          </span>
        </p>
      </div>
      
      <!-- Github -->
      <div class="basis-1/4 flex justify-end self-center">
        <a href="#"  class="hover:cursor-pointer">
          <i class="ri-github-line text-[32px] text-light-indigo"></i>
        </a>
      </div>
    </div>
</template>

<script>
export default {

}
</script>

<style>

</style>
