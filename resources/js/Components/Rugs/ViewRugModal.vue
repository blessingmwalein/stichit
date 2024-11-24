<template>
    <div class="modal fade" id="viewRugDetailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">{{ rug?.name }}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Rug Information List -->
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item bg-transparent text-white">
                            <i class="bx bx-cart-alt font-18 align-middle me-1"></i>
                            Type: {{ rug?.type }}
                        </li>
                        <li class="list-group-item bg-transparent text-white">
                            <i class="bx bx-dollar font-18 align-middle me-1"></i>
                            Approximate Production Cost: <MoneyDisplay :value="rug?.approx_production_cost" />
                        </li>
                        <li class="list-group-item bg-transparent text-white">
                            <i class="bx bx-dollar-circle font-18 align-middle me-1"></i>
                            Approximate Cost: <MoneyDisplay :value="rug?.approx_cost" />
                        </li>
                        <li class="list-group-item bg-transparent text-white">
                            <i class="bx bx-calendar font-18 align-middle me-1"></i>
                            Created At: <DateDisplay :date="rug?.created_at" />
                        </li>
                    </ul>

                    <!-- Display Rug Sizes -->
                    <div class="mt-3">
                        <h6 class="text-white">Sizes:</h6>
                        <div class="d-flex flex-wrap">
                            <!-- Loop over sizes and display as scaled containers -->
                            <div v-for="size in rug?.sizes" :key="size.id" class="me-2 mb-2">
                                <div class="size-container" :style="{
                                    width: size.width * 2 + 'px',  /* Scale width */
                                    height: size.length * 2 + 'px'  /* Scale height */
                                }">
                                    <div class="size-label text-center text-white">
                                        {{ size.width }} x {{ size.length }} cm
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import DateDisplay from '../common/DateDisplay.vue';
import MoneyDisplay from '../common/MoneyDisplay.vue';

export default {
    props: {
        rug: Object,
    },
    components: {
        DateDisplay,
        MoneyDisplay,
    }
}
</script>

<style scoped>
.size-container {
    background-color: #2c3e50;
    border-radius: 8px;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    margin: 10px;
}

.size-label {
    position: absolute;
    color: #fff;
    font-weight: bold;
}
</style>
