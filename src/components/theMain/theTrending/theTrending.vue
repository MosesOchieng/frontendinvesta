<template>
  <div class="flex flex-col w-full mt-12">
    <!--========== Head ==========-->
    <div class="flex justify-between">
      <h1 class="text-[#131736] dark:text-white text-[32px] font-semibold">Market Place</h1>

      <div
        class="flex items-center rounded-xl px-5 hover:cursor-pointer transition ease-in-out hover:bg-[#7b62ff26] dark:hover:bg-[#272856] duration-300"
      >
        <p class="text-light-slat-Blue text-[16px] font-semibold">
          All DAO's
        </p>
        <div class="px-2 py-1 border border-[#EAEBEE] dark:border-none dark:bg-[#272856] rounded-full ml-2">
          <p class="text-light-slat-Blue text-[14px]">+32</p>
        </div>
      </div>
    </div>

    <!--========== Slider ==========-->
    <div class="flex flex-nowrap gap-8 mt-4 pb-2 overflow-x-auto w-full">
      <swiper
        :slidesPerView="3"
        :spaceBetween="30"
        :freeMode="true"
        :modules="modules"
        class="mySwiper"
      >
        <swiper-slide
          class="group min-w-[295px] h-[350px] rounded-xl overflow-hidden flex flex-col"
          v-for="(slide, index) in sliders"
          :key="index"
        >
          <slider :slide="slide" />
        </swiper-slide>
      </swiper>
    </div>
  </div>
</template>

<script>
import { computed } from "vue";
import { useStore } from "vuex";
import slider from "./UI/slider-item.vue";

import { Swiper, SwiperSlide } from "swiper/vue";

// Import Swiper styles
import "swiper/css";

import "swiper/css/free-mode";

// import required modules
import { FreeMode } from "swiper";

export default {
  components: { slider, Swiper, SwiperSlide },
  setup() {
    const store = useStore();

    const sliders = computed(() => store.getters.sliders);

    return { sliders, modules: [FreeMode] };
  },
};
</script>

<style>
.swiper-slide {
  flex-shrink: unset;
  overflow: visible !important;
}
</style>
