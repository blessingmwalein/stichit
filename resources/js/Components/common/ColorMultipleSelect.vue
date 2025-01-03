<template>
    <div>
        <label :for="id" class="form-label">{{ label }}</label>
        <Multiselect v-model="selectedColors" :options="defaultColors" :multiple="true"
            :close-on-select="false" placeholder="Select or add colors" tag-placeholder="Add custom color" label="name"
            track-by="value" taggable @tag="addCustomColor" />
        <span v-if="errorMessage" class="text-danger">{{ errorMessage }}</span>
    </div>
</template>

<script>
import Multiselect from 'vue-multiselect';

export default {
    components: { Multiselect },
    props: {
        id: {
            type: String,
            required: true,
        },
        label: {
            type: String,
            default: 'Select Colors',
        },
        errorMessage: {
            type: String,
            default: '',
        },
        modelValue: {
            type: Array,
            default: () => [],
        },
    },
    data() {
        return {
            defaultColors: [
                { name: 'Red', value: 'red' },
                { name: 'Blue', value: 'blue' },
                { name: 'Green', value: 'green' },
                { name: 'Yellow', value: 'yellow' },
                { name: 'Orange', value: 'orange' },
                { name: 'Purple', value: 'purple' },
                { name: 'Black', value: 'black' },
                { name: 'White', value: 'white' },
                { name: 'Gray', value: 'gray' },
            ],
            selectedColors: this.modelValue.map(value =>
                this.defaultColors?.find(color => color.value === value) || { name: value, value }
            ),
        };
    },
    watch: {
        selectedColors(newVal) {
            const colorValues = newVal.map(color => color.value); // Extract color values (strings)
            this.$emit('update:modelValue', colorValues);
        },
    },
    methods: {
        addCustomColor(newColor) {
            const customColor = { name: newColor, value: newColor };
            this.defaultColors.push(customColor);
            return customColor;
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
