<template>
    <div class="d-flex align-items-center text-white">
      <div class="avatar">
        <span class="avatar-initials">
          {{ getInitials(name) }}
        </span>
      </div>
      {{ name }}
    </div>
  </template>

  <script>
  export default {
    props: {
      name: {
        type: String,
        required: true,
      },
    },
    methods: {
      getInitials(name) {
        const nameParts = name?.split(" ");
        const initials = nameParts?.map(part => part.charAt(0).toUpperCase()).join('');
        return initials;
      },
    },
  };
  </script>

  <style scoped>
  .chip {
    display: flex;
    align-items: center;
    padding: 8px 16px;
    border-radius: 20px;
    font-size: 16px;
  }

  .avatar {
    display: inline-block;
    width: 40px;
    height: 40px;
    margin-right: 8px;
    border-radius: 50%;
    background-color: #4CAF50; /* Customize this background color */
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .avatar-initials {
    color: white;
    font-weight: bold;
    font-size: 16px;
  }

  .bg-light {
    background-color: #f5f5f5;
  }

  .text-dark {
    color: #333;
  }
  </style>
