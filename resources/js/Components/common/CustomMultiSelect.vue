<template>
    <div>
        <label class="typo__label">{{ label }}</label>
        <multiselect
            v-model="localValue"
            :options="formattedOptions"
            :multiple="isMultiple"
            :close-on-select="!isMultiple"
            :clear-on-select="!isMultiple"
            :preserve-search="true"
            :placeholder="placeholder"
            :label="useLabel"
            :track-by="useTrackBy"
            :preselect-first="false"
            :searchable="true"
            :internal-search="false"
            :loading="isLoading"
            @search-change="handleSearch"
        >
            <!-- Custom Selection Template -->
            <template #selection="{ values, search, isOpen }">
                <span class="multiselect__single" v-if="!isMultiple && values.length && !isOpen">
                    {{ values[0][useLabel] || values[0] }}
                </span>
                <span class="multiselect__single" v-else-if="isMultiple && values.length && !isOpen">
                    {{ values.length }} options selected
                </span>
            </template>

            <!-- No Results Template -->
            <template #noResult>
                <span>No results found for your search.</span>
            </template>
        </multiselect>
    </div>
</template>

<script>
import Multiselect from "vue-multiselect";
import axios from "axios"; // Assuming you're using Axios for HTTP requests

export default {
    name: "CustomMultiSelect",
    components: {
        Multiselect,
    },
    props: {
        options: {
            type: Array,
            required: false,
            default: () => [],
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
        searchUrl: {
            type: String,
            required: false,
            default: "",
        },
        searchField: {
            type: String,
            required: false,
            default: "query",
        },
    },
    data() {
        return {
            localValue: this.modelValue,
            asyncOptions: [], // Options loaded from the API
            isLoading: false, // Loading state for async search
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
            return this.asyncOptions.length > 0 ? this.asyncOptions : this.options;
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
    methods: {
        async handleSearch(query) {
            if (!this.searchUrl) return;
            if (!query) {
                this.asyncOptions = [];
                return;
            }

            this.isLoading = true;
            try {
                const params = { [this.searchField]: query };
                const response = await axios.get(this.searchUrl, { params });
                this.asyncOptions = response.data; // Ensure your API response matches the expected format
            } catch (error) {
                console.error("Error fetching search results:", error);
                this.asyncOptions = [];
            } finally {
                this.isLoading = false;
            }
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
