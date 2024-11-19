<script setup>
defineProps({
    message: String,
});
</script>

<template>
    <div v-show="message">
        <div class="error-feedback">
            {{ message }}
        </div>
    </div>
</template>

<style scoped>
.error-feedback {
    color: red;
    font-size: 14px;
}
</style>
