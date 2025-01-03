<template>
    <div>
        <label v-if="label" :for="id" class="textfield-label">{{ label }}</label>
        <input
            :id="id"
            ref="inputRef"
            v-model="localFormattedValue"
            type="text"
            class="form-control"
            :name="name"
            :disabled="disabled"
            v-bind="$attrs"
            :class="['textfield-input', inputClass]"
            @blur="handleBlur"
        />
        <small v-if="error" class="text-danger">{{ error }}</small>
    </div>
</template>

<script lang="ts" setup>
import { ref, watch } from "vue";
import { useCurrencyInput } from "vue-currency-input";

const props = defineProps({
    modelValue: {
        type: [Number, String],
        required: false,
        default: null,
    },
    id: {
        type: String,
        required: false,
        default: "money-textfield",
    },
    name: {
        type: String,
        required: false,
        default: "",
    },
    label: {
        type: String,
        required: false,
        default: "",
    },
    disabled: {
        type: Boolean,
        required: false,
        default: false,
    },
    currencyOptions: {
        type: Object,
        required: false,
        default: () => ({
            currency: "USD",
            locale: "en-US",
        }),
    },
    inputClass: {
        type: String,
        required: false,
        default: "",
    },
    error: {
        type: String,
        required: false,
        default: "",
    },
});

const emit = defineEmits(["update:modelValue", "blur", "change"]);

const { formattedValue, inputRef, numberValue, setValue } = useCurrencyInput(
    props.currencyOptions
);

const localFormattedValue = ref(formattedValue.value);

// Sync formatted value with the parent-provided `modelValue`
watch(
    () => props.modelValue,
    (newValue) => {
        if (numberValue.value !== newValue) {
            setValue(newValue);
            localFormattedValue.value = formattedValue.value; // Update local formatted value
        }
    },
    { immediate: true }
);

// Sync local value with `numberValue` and emit changes
watch(
    () => numberValue.value,
    (newValue) => {
        emit("update:modelValue", newValue);
        emit("change", newValue); // Emit change event for the parent
    }
);

// Handle blur event
const handleBlur = () => {
    emit("blur", numberValue.value);
};
</script>

<style scoped>
.textfield-label {
    display: block;
    margin-bottom: 4px;
    font-weight: bold;
}

.textfield-error {
    display: block;
    margin-top: 4px;
    color: red;
    font-size: 0.875rem;
}
</style>
