<template>
    <div>
        <label class="typo__label">{{ label }}</label>
        <multiselect v-model="localValue" :options="formattedOptions" :multiple="isMultiple"
            :close-on-select="!isMultiple" :clear-on-select="!isMultiple" :preserve-search="true"
            :placeholder="placeholder" :label="!isListOfStrings ? displayColumn : ''"
            :track-by="!isListOfStrings ? bindColumn : ''" :preselect-first="false" :searchable="true"
            :internal-search="!searchUrl" :loading="isLoading" @search-change="handleSearch">

            <!-- Custom Option Template -->
            <template #option="{ option }">
                <slot name="option" :option="option">
                    <span>{{ isListOfStrings ? option : option[displayColumn] }}</span>
                </slot>
            </template>

            <!-- Custom Selection Template -->
            <template #selection="{ values, isOpen }">
                <span class="multiselect__single" v-if="!isMultiple && values.length && !isOpen">
                    {{ isListOfStrings ? values[0] : values[0]?.[displayColumn] }}
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
import axios from "axios";

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
        displayColumn: {
            type: String,
            default: "name",
        },
        bindColumn: {
            type: String,
            default: "id",
        },
    },
    data() {
        return {
            localValue: this.modelValue,
            asyncOptions: [],
            isLoading: false,
        };
    },
    computed: {
        isListOfStrings() {
            return this.options.length > 0 && typeof this.options[0] === "string";
        },
        formattedOptions() {
            return this.asyncOptions.length > 0 ? this.asyncOptions : this.options;
        },
    },
    watch: {
        modelValue: {
            immediate: true,
            handler(newVal) {
                this.localValue = this.isMultiple
                    ? this.formatSelected(newVal)
                    : this.formatSelected([newVal])[0] || null;
            },
        },
        localValue(newVal) {
            const emitValue = this.isMultiple
                ? newVal.map((item) => (this.isListOfStrings ? item : item[this.bindColumn]))
                : this.isListOfStrings
                    ? newVal
                    : newVal?.[this.bindColumn] || newVal;

            this.$emit("update:modelValue", emitValue);

            if (!this.isMultiple && newVal) {
                this.asyncOptions = [];
            }
        },
    },
    methods: {
        formatSelected(values) {
            if (!Array.isArray(values)) return [];
            return values.map((val) => {
                if (this.isListOfStrings) return val;
                const match = this.formattedOptions.find(
                    (option) => option[this.bindColumn] === (val?.[this.bindColumn] || val)
                );
                return match || val;
            });
        },
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

                this.asyncOptions = [];
                this.$nextTick(() => {
                    this.asyncOptions = response.data.response.data;
                });
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

.multiselect__tags {
    border: 1px solid rgb(255 255 255 / 15%) !important;
    background-color: rgb(0 0 0 / 15%) !important;
}

.multiselect__input,
.multiselect__single {
    background-color: rgb(0 0 0 / 15%) !important;
    color: white !important;
}
</style>
