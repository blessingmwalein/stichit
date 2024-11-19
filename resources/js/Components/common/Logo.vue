<script setup>
//width and heigh props set default valuu to 80
defineProps({
    width: {
        type: Number,
        default: 80
    },
    height: {
        type: Number,
        default: 80
    }
});

</script>

<template>
    <img src="/assets/logos/STICHIT-01.png" :width="width" :height="height" alt="" />

</template>
