<script setup>
import { ref } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import ApplicationMark from '@/Components/ApplicationMark.vue';
import Banner from '@/Components/Banner.vue';
import Dropdown from '@/Components/Dropdown.vue';
import DropdownLink from '@/Components/DropdownLink.vue';
import NavLink from '@/Components/NavLink.vue';
import ResponsiveNavLink from '@/Components/ResponsiveNavLink.vue';
import Logo from '@/Components/common/Logo.vue';

defineProps({
    title: String,
    subtitle: String,
    image: String,
});
</script>

<template>
    <div class="wrapper">
        <div class="section-authentication-cover">
            <div class="row g-0">
                <!-- Left container with full image -->
                <div class="col-12 col-xl-7 col-xxl-8 d-none d-xl-flex">
                    <div class="card bg-transparent border-0 rounded-0 mb-0 w-100 h-100">
                        <div class="card-body p-0">
                            <img :src="image" class="img-fluid w-100 h-100 object-fit-cover" alt="" />
                        </div>
                    </div>
                </div>

                <!-- Right container with form -->
                <div class="col-12 col-xl-5 col-xxl-4 bg-light d-flex align-items-center justify-content-center">
                    <div class="card rounded-0 shadow-none shadow-none bg-transparent mb-0 border border-dark">
                        <div class="card-body p-sm-5">
                            <div class="text-center mb-3">
                                <Logo :width="100" :height="100" />
                            </div>
                            <div class="text-center mb-4">
                                <h5 class="">{{ title }}</h5>
                                <p class="mb-0 ">{{ subtitle }}</p>
                            </div>
                            <slot />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

