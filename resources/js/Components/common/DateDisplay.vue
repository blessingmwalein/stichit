<template>
    <span>{{ formattedDate }}</span>
  </template>

  <script>
  export default {
    props: {
      date: {
        type: String,
        required: true,
      },
    },
    computed: {
      formattedDate() {
        if (!this.date) return '';
        const dateObj = new Date(this.date); // Convert string to Date object
        const options = { day: 'numeric', month: 'long', year: 'numeric' }; // Formatting options
        return dateObj.toLocaleDateString('en-US', options); // Format the date
      },
    },
  };
  </script>
