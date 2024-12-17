<template>
    <div>
        <label class="typo__label">{{ label }}</label>
        <multiselect v-model="localValue" :options="formattedOptions" :multiple="isMultiple"
            :close-on-select="!isMultiple" :clear-on-select="!isMultiple" :preserve-search="true"
            :placeholder="placeholder" :label="useLabel" :track-by="useTrackBy" :preselect-first="false">
            <!-- Custom Selection Template -->
            <template #selection="{ values, search, isOpen }">
                <span class="multiselect__single" v-if="!isMultiple && values.length && !isOpen">
                    {{ values[0][useLabel] || values[0] }}
                </span>
                <span class="multiselect__single" v-else-if="isMultiple && values.length && !isOpen">
                    {{ values.length }} options selected
                </span>
            </template>
        </multiselect>
    </div>
</template>

<script>
import Multiselect from "vue-multiselect";

export default {
    name: "CustomMultiSelect",
    components: {
        Multiselect,
    },
    props: {
        options: {
            type: Array,
            required: true,
        },
        label: {
            type: String,
            default: "Select Options",
        },
        modelValue: {
            type: [Array, Object, String, Number],
            default: () => [],
        },
        isMultiple: {
            type: Boolean,
            default: true,
        },
        placeholder: {
            type: String,
            default: "Pick some",
        },
    },
    data() {
        return {
            localValue: this.modelValue,
        };
    },
    computed: {
        isSimple() {
            return (
                this.options.length > 0 &&
                (typeof this.options[0] === "string" || typeof this.options[0] === "number")
            );
        },
        formattedOptions() {
            if (this.isSimple) {
                return this.options.map((item) => ({ label: item, value: item }));
            }
            return this.options;
        },
        useLabel() {
            return this.isSimple ? "label" : "name";
        },
        useTrackBy() {
            return this.isSimple ? "value" : "id";
        },
    },
    watch: {
        modelValue(newVal) {
            this.localValue = newVal;
        },
        localValue(newVal) {
            const emitValue = this.isMultiple
                ? newVal.map((item) =>
                    this.isSimple ? item : item.value || item
                )
                : this.isSimple
                    ? newVal
                    : newVal?.value || newVal;
            this.$emit("update:modelValue", emitValue);
        },
    },
};
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
<style>
.multiselect {
    margin-top: 5px;
}
</style>
