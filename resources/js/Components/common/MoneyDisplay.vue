<template>
    <span>{{ formattedValue }}</span>
  </template>

  <script>
  export default {
    props: {
      value: {
        type: [Number, String],
        required: true
      }
    },
    computed: {
      formattedValue() {
        // Convert the value to a float and format it to USD
        const numberValue = parseFloat(this.value);
        return isNaN(numberValue)
          ? "$0.00"
          : new Intl.NumberFormat("en-US", {
              style: "currency",
              currency: "USD"
            }).format(numberValue);
      }
    }
  };
  </script>
