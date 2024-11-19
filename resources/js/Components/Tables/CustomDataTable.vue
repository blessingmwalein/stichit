<template>
    <div>
        <!-- Filter Section -->
        <div class="d-lg-flex align-items-center mb-4 gap-3">
            <!-- Loop through the filterable columns and create input fields -->
            <div v-for="(column, index) in filterableColumns" :key="index" class="position-relative flex-grow-1">
                <input v-model="filters[column.key]" type="text" class="form-control ps-5 radius-30"
                    :placeholder="'Search ' + column.label" />
            </div>

            <!-- Search Button aligned to the far right -->
            <div class="ms-auto">
                <CustomButton width="90" :height="'38'" :isOutlined="true" :disabled="effectiveLoading"
                    @click="applyFilters" :backgroundColor="'white'" :title="'Search'" :borderRadius="'40px'"
                    :icon="'search'" />
            </div>
        </div>

        <!-- Table Section -->
        <div class="table-responsive">
            <div v-if="effectiveLoading" class="text-center my-3">
                <div class="spinner-border text-white" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>

            <table v-else-if="tableData.length > 0" class="table">
                <thead>
                    <tr>
                        <th v-for="(column, index) in columns" :key="index">
                            {{ column.label }}
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(row, rowIndex) in tableData" :key="rowIndex">
                        <td v-for="(column, colIndex) in columns" :key="colIndex">
                            <slot :name="column.key" :row="row" :column="column">
                                {{ row[column.key] }} <!-- Fallback to default text if no slot -->
                            </slot>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- Empty Data Widget -->
            <div v-else class="text-center my-3">
                <p class="text-muted">No data available.</p>
            </div>

            <!-- Pagination -->
            <div v-if="meta && tableData.length > 0" class="d-flex justify-content-between align-items-center mt-3">
                <CustomButton width="80" :height="'40'" :isOutlined="true" :disabled="!links.prev || effectiveLoading"
                    @click="fetchPage(meta.current_page - 1)" :backgroundColor="'white'" :title="'Previous'" />
                <span>Page {{ meta.current_page }} of {{ meta.last_page }}</span>
                <CustomButton width="80" :height="'40'" :isOutlined="true" :disabled="!links.next || effectiveLoading"
                    @click="fetchPage(meta.current_page + 1)" :backgroundColor="'white'" :title="'Next'" />
            </div>
        </div>
    </div>
</template>


<script>
import CustomButton from '../common/CustomButton.vue';

export default {
    components: {
        CustomButton,
    },
    props: {
        columns: { type: Array, required: true }, // Define column names and keys
        apiEndpoint: { type: String, required: true }, // API endpoint for fetching data
        isLoading: { type: Boolean, default: false }, // Allow parent to control loading state
        filterableColumns: { type: Array, default: () => [] }, // Columns that can be filtered
    },
    data() {
        return {
            tableData: [], // Table rows
            meta: null, // Pagination metadata
            links: null, // Pagination links
            filters: {}, // Filters for the columns
            internalLoading: false, // Internal loading state for fetching
        };
    },
    computed: {
        effectiveLoading() {
            return this.isLoading || this.internalLoading;
        },
    },
    methods: {
        // Fetch page data with optional filters
        async fetchPage(page = 1) {
            this.internalLoading = true;

            try {
                // Build query parameters with filters
                const filterParams = Object.keys(this.filters).reduce((acc, key) => {
                    if (this.filters[key]) {
                        acc[key] = this.filters[key];
                    }
                    return acc;
                }, {});

                // Add pagination to query parameters
                const params = { page, ...filterParams };

                // Use Axios (Inertia.js) to fetch data with filters
                const response = await axios.get(`${this.apiEndpoint}`, { params });

                // Destructure the response to get the necessary parts
                const { success, message, response: data } = response.data;

                if (success) {
                    // Update the table data and meta information
                    this.tableData = data.data;
                    this.meta = data.meta;

                    // Update the links for pagination
                    this.links = {
                        prev: data.meta.current_page > 1,
                        next: data.meta.current_page < data.meta.last_page,
                    };

                    // Optionally, emit an event for data fetched
                    this.$emit('data-fetched', data);
                } else {
                    console.error("Error: ", message);
                    this.$emit('fetch-error', message); // Notify about an error if needed
                }
            } catch (error) {
                console.error("Error fetching data:", error);
                this.$emit('fetch-error', error); // Notify about the error
            } finally {
                this.internalLoading = false;
            }
        },

        // Apply filters and fetch data with new filter parameters
        applyFilters() {
            this.fetchPage(1); // Reset to first page when filters are applied
        },
    },
    mounted() {
        this.fetchPage(); // Initial fetch when the component mounts
    },
};
</script>
