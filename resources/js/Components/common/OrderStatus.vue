<template>
    <span :class="badgeClass" class="badge">
      {{ status }}
    </span>
  </template>

  <script>
  export default {
    name: "Badge",
    props: {
      status: {
        type: String,
        required: true,
      },
    },
    computed: {
      badgeClass() {
        switch (this.status) {
          case "Pending":
            return "bg-warning text-dark"; // Yellow background
          case "Processing":
            return "bg-info text-white"; // Light blue background
          case "Tufting":
            return "bg-primary text-white"; // Blue background
          case "Binding":
            return "bg-secondary text-white"; // Gray background
          case "Delivered":
            return "bg-success text-white"; // Green background
          case "Cancelled":
            return "bg-danger text-white"; // Red background
          default:
            return "bg-light text-dark"; // Default style
        }
      },
    },
  };
  </script>

  <style scoped>
  .badge {
    padding: 0.5rem 1rem;
    border-radius: 1rem; /* Rounded corners */
    font-size: 0.9rem;
    font-weight: bold;
    text-transform: capitalize; /* Make first letter uppercase */
  }
  </style>
