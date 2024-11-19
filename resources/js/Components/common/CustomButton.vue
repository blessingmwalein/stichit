<script setup>
import { defineProps, computed } from 'vue';

const props = defineProps({
    width: {
        type: [Number, String],
        default: 'auto',
    },
    height: {
        type: [Number, String],
        default: 'auto',
    },
    purpose: {
        type: String,
        default: 'submit',
    },
    type: {
        type: String,
        default: 'primary',
        validator: (value) => ['primary', 'secondary', 'success', 'danger', 'warning', 'info', 'light', 'dark'].includes(value),
    },
    backgroundColor: {
        type: String,
        default: '',
    },
    textColor: {
        type: String,
        default: '#fff',
    },
    borderRadius: {
        type: String,
        default: '10px',
    },
    isOutlined: {
        type: Boolean,
        default: false,
    },
    icon: {
        type: String,
        default: '',
    },
    isLoading: {
        type: Boolean,
        default: false,
    },
    loaderSize: {
        type: Number,
        default: 16,
    },
    disabled: {
        type: Boolean,
        default: false,
    },
    title: {
        type: String,
        default: 'Button',
    },
});

// Computed style for dynamic background, outline, text size, icon, and loader color
const buttonStyle = computed(() => {
    const width = props.width === 'auto' ? '100%' : `${props.width}px`;
    const height = props.height === 'auto' ? '40px' : `${props.height}px`; // Adjusted to a fixed height
    const fontSize = props.height === 'auto' ? '1.25rem' : `${props.height * 0.35}px`; // Adjusted font size for better readability
    const primaryColor = props.isOutlined ? (props.backgroundColor || `var(--bs-${props.type})`) : props.textColor;

    return {
        width,
        height,
        backgroundColor: props.isOutlined ? 'transparent' : props.backgroundColor || `var(--bs-${props.type})`,
        color: primaryColor,
        borderColor: props.backgroundColor || `var(--bs-${props.type})`,
        borderRadius: props.borderRadius,
        fontSize, // Updated font size calculation
    };
});

// Style for icon and loader
const iconStyle = computed(() => ({
    color: props.isOutlined ? (props.backgroundColor || `var(--bs-${props.type})`) : props.textColor,
    fontSize: props.height === 'auto' ? '1.5rem' : `${props.height * 0.4}px`, // Adjust icon size relative to button height
}));

const loaderStyle = computed(() => ({
    width: `${props.loaderSize}px`,
    height: `${props.loaderSize}px`,
    color: props.isOutlined ? (props.backgroundColor || `var(--bs-${props.type})`) : props.textColor,
}));
</script>

<template>
    <button
        :type="purpose"
        :class="['btn', `btn-${type}`, { 'btn-outline': isOutlined, ' align-items-center justify-content-center': icon || isLoading }]"
        :style="buttonStyle"
        :disabled="disabled || isLoading"
    >
        <!-- Optional Icon -->
        <span v-if="icon && !isLoading" :class="`me-2 bx bx-${icon}`" :style="iconStyle"></span>

        <!-- Loader Spinner when Loading -->
        <span v-if="isLoading" class="spinner-border spinner-border-sm" role="status" :style="loaderStyle"></span>

        <!-- Button Text Slot -->
        <span v-if="!isLoading" class="text-base">
            <slot>{{ title }}</slot>
        </span>
    </button>
</template>

<style scoped>
.btn {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0.25em 1.5em; /* Adjusted padding for smaller height */
    font-weight: normal;
    min-width: 0;
}

.btn-outline {
    border: 2px solid;
}

.spinner-border {
    color: currentColor;
}

.d-flex {
    display: flex;
}

.align-items-center {
    align-items: center;
}

.justify-content-center {
    justify-content: center;
}

/* Optional extra space between icon and text */
.me-2 {
    margin-right: 0.5rem; /* Adjust this value as needed */
}
</style>
