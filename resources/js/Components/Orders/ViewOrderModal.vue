<template>
    <div class="modal fade" id="viewOrderDetailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">

                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Order Details Section -->
                    <section>
                        <h6 class="text-white mb-3">Order Details</h6>
                        <ul class="list-group list-group-flush grid-container">
                            <li class="list-group-item bg-transparent text-white grid-item">
                                <div class="d-flex align-items-center">
                                    <i class="bx bx-cart-alt font-18 align-middle me-1"></i>
                                    <div class="field-label">Rug Type</div>
                                </div>
                                <div class="field-value">{{ order?.rug?.type }}</div>
                            </li>
                            <li class="list-group-item bg-transparent text-white grid-item">
                                <div class="d-flex align-items-center">
                                    <i class="bx bx-dollar font-18 align-middle me-1"></i>
                                    <div class="field-label">Production Cost</div>
                                </div>

                                <div class="field-value">
                                    <MoneyDisplay :value="order?.rug?.approx_production_cost" />
                                </div>
                            </li>
                            <li class="list-group-item bg-transparent text-white grid-item">
                                <div class="d-flex align-items-center">

                                    <i class="bx bx-dollar-circle font-18 align-middle me-1"></i>
                                    <div class="field-label">Tota Price</div>
                                </div>
                                <div class="field-value">
                                    <MoneyDisplay :value="order?.total_price" />
                                </div>
                            </li>
                            <li class="list-group-item bg-transparent text-white grid-item">
                                <div class="d-flex align-items-center">

                                    <i class="bx bx-calendar font-18 align-middle me-1"></i>
                                    <div class="field-label">Order Created At</div>
                                </div>
                                <div class="field-value">
                                    <DateDisplay :date="order?.created_at" />
                                </div>
                            </li>
                            <li class="list-group-item bg-transparent text-white grid-item">
                                <div class="d-flex align-items-center">

                                    <i class="bx bx-calendar-check font-18 align-middle me-1"></i>
                                    <div class="field-label">Delivery Date</div>
                                </div>
                                <div class="field-value">
                                    <DateDisplay :date="order?.delivery_date" />
                                </div>
                            </li>
                            <li class="list-group-item bg-transparent text-white grid-item">
                                <div class="d-flex align-items-center">

                                    <i class="bx bx-description font-18 align-middle me-1"></i>
                                    <div class="field-label">Description</div>
                                </div>
                                <div class="field-value">{{ order?.description }}</div>
                            </li>
                            <li class="list-group-item bg-transparent text-white grid-item">
                                <div class="d-flex align-items-center">

                                    <i class="bx bx-check-circle font-18 align-middle me-1"></i>
                                    <div class="field-label">Status</div>
                                </div>
                                <div class="field-value">
                                    <OrderStatus :status="order?.status" />
                                </div>
                            </li>
                        </ul>
                    </section>

                    <!-- Client Information Section -->
                    <section class="mt-4">
                        <h6 class="text-white mb-3">Client Information</h6>
                        <ul class="list-group list-group-flush grid-container">
                            <li class="list-group-item bg-transparent text-white grid-item">
                                <div class="d-flex align-items-center">

                                    <i class="bx bx-user font-18 align-middle me-1"></i>
                                    <div class="field-label">Client Name</div>
                                </div>
                                <div class="field-value">
                                    <UserDisplay :name="order?.client_name" />
                                </div>

                            </li>
                            <li class="list-group-item bg-transparent text-white grid-item">
                                <div class="d-flex align-items-center">

                                    <i class="bx bx-envelope font-18 align-middle me-1"></i>
                                    <div class="field-label">Email</div>
                                </div>
                                <div class="field-value">{{ order?.email }}</div>
                            </li>
                        </ul>
                    </section>

                    <div class="d-flex justify-content-between">
                        <div class="w-50">
                            <!-- Rug Sizes Section -->
                            <section class="mt-4">
                                <h6 class="text-white mb-3">Rug Size</h6>
                                <div class="d-flex flex-wrap">
                                    <div class="me-2 mb-2 grid-item">
                                        <div class="size-container" :style="{
                                            width: order?.size.width * 2 + 'px',  /* Scale width */
                                            height: order?.size.length * 2 + 'px'  /* Scale height */
                                        }">
                                            <div class="size-label text-center text-white">
                                                {{ order?.size.width }} x {{ order?.size.length }} cm
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <!-- Color Palette Section -->
                            <section class="mt-4">
                                <h6 class="text-white mb-3">Color Palette</h6>
                                <div class="d-flex flex-wrap">
                                    <div v-for="color in order?.color_palet" :key="color"
                                        class="color-swatch me-2 grid-item" :style="{ backgroundColor: color }">
                                        <div class="color-label text-center text-white">
                                            {{ color }}
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                        <section class="mt-4">
                            <h6 class="text-white mb-3">Order Image</h6>
                            <img :src="`/storage/${order?.image_url}`" alt="Order Image" class="img-fluid grid-item" />
                        </section>
                    </div>

                    <!-- Order Image Section -->


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
import OrderStatus from '../common/OrderStatus.vue';
import UserDisplay from '../common/UserDisplay.vue';


export default {
    props: {
        order: Object,
    },
    components: {
        DateDisplay,
        MoneyDisplay,
        OrderStatus,
        UserDisplay,
    },
    methods: {
        // Format date to a more user-friendly format
        formatDate(date) {
            const d = new Date(date);
            return d.toLocaleDateString(); // Format as MM/DD/YYYY
        }
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
    font-weight: normal;
}

.color-swatch {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.color-label {
    color: white;
    font-size: 12px;
    font-weight: normal;
}

img {
    /* max-width: 100%; */
    border-radius: 8px;
    /* 50% width and height */
    width: 70%;
    height: 70%;
}

/* Styling for labels and values */
.field-label {
    font-weight: normal;
    font-size: 14px;
    color: #bbb;
}

.field-value {
    font-size: 16px;
    color: white;
}

/* Grid Styles */
.grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 16px;
}

.grid-item {
    background-color: #444;
    border-radius: 8px;
    padding: 10px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
}
</style>
