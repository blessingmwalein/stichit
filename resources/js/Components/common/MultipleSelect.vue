<template>
    <div>
      <label class="typo__label">{{ label }}</label>
      <multiselect
        v-model="localValue"
        :options="formattedOptions"
        :multiple="true"
        :close-on-select="false"
        :clear-on-select="false"
        :preserve-search="true"
        placeholder="Pick some"
        :label="useLabel"
        :track-by="useLabel"
        :preselect-first="true"
      >
        <template #selection="{ values, search, isOpen }">
          <span
            class="multiselect__single"
            v-if="values.length"
            v-show="!isOpen"
          >
            {{ values.length }} options selected
          </span>
        </template>
      </multiselect>
      <pre class="language-json"><code>{{ localValue }}</code></pre>
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
      // The options passed to the component
      options: {
        type: Array,
        required: true,
      },
      // Label for the select input
      label: {
        type: String,
        default: "Select Options",
      },
      // v-model binding
      modelValue: {
        type: Array,
        default: () => [],
      },
    },
    data() {
      return {
        // Local value for v-model syncing
        localValue: this.modelValue,
      };
    },
    computed: {
      // Determine if the options are simple strings/numbers or objects
      isSimple() {
        return (
          this.options.length > 0 &&
          (typeof this.options[0] === "string" ||
            typeof this.options[0] === "number")
        );
      },
      // Compute the options in the format suitable for Multiselect
      formattedOptions() {
        if (this.isSimple) {
          return this.options.map((item) => ({ label: item, value: item }));
        }
        return this.options;
      },
      // Label field for the multiselect
      useLabel() {
        return this.isSimple ? "label" : "name";
      },
    },
    watch: {
      // Sync prop value changes with local data
      modelValue(newVal) {
        this.localValue = newVal;
      },
      // Emit local changes back to the parent
      localValue(newVal) {
        this.$emit("update:modelValue", newVal);
      },
    },
  };
  </script>

  <style>
  /* Add any custom styles here */
  </style>
