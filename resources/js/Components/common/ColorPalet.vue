<template>
    <div class="color-dots">
      <span
        v-for="(color, index) in colorPalette"
        :key="index"
        :style="{ backgroundColor: color }"
        class="color-dot"
      ></span>
    </div>
  </template>

  <script>
  export default {
    name: 'ColorPalette',
    props: {
      colorPalette: {
        type: Array,
        required: true,
      },
    },

    mounted() {
      console.log(this.colorPalette.length);
    },
  };
  </script>

  <style scoped>
  .color-dots {
    display: flex;
    gap: 5px; /* Space between dots */
    align-items: center;
  }

  .color-dot {
    width: 16px; /* Size of the dot */
    height: 16px; /* Size of the dot */
    border-radius: 50%; /* Make it a circle */
    border: 1px solid #ddd; /* Optional border */
  }
  </style>
