<template>
    <MainLayout title="Update Order">
        <div class="page-content">
            <!--breadcrumb-->
            <BreadCrumb :title="'Update Order'" :links="breadcrumbLinks" />
            <!--end breadcrumb-->
            <div class="card">
                <div class="card-body p-4">
                    <div class="form-body mt-4">
                        <form @submit.prevent="submit">
                            <div class="row">
                                <!-- Left Section -->
                                <div class="col-lg-8">
                                    <div class="border border-3 p-4 rounded">
                                        <!-- Status Dropdown -->
                                        <div class="mb-3">
                                            <label for="statusSelect" class="form-label">Status</label>
                                            <select v-model="form.status" class="form-select" id="statusSelect">
                                                <option value="" disabled>Select a status</option>
                                                <option value="Pending">Pending</option>
                                                <option value="Processing">Processing</option>
                                                <option value="Tufting">Tufting</option>
                                                <option value="Binding">Binding</option>
                                                <option value="Delivered">Delivered</option>
                                                <option value="Cancelled">Cancelled</option>
                                            </select>
                                            <span v-if="form.errors.status" class="text-danger">
                                                {{ form.errors.status }}
                                            </span>
                                        </div>
                                        <!-- Client Dropdown -->
                                        <div class="mb-3">
                                            <label for="clientSelect" class="form-label">Client</label>
                                            <select v-model="form.client_id" class="form-select" id="clientSelect">
                                                <option value="" disabled>Select a client</option>
                                                <option v-for="client in clients?.data" :key="client?.id"
                                                    :value="client?.id">
                                                    {{ client.name }}
                                                </option>
                                            </select>
                                            <span v-if="form.errors.client_id" class="text-danger">
                                                {{ form.errors.client_id }}
                                            </span>
                                        </div>

                                        <!-- Rug Dropdown -->
                                        <div class="mb-3">
                                            <label for="rugSelect" class="form-label">Rug</label>
                                            <select v-model="form.rug_id" @change="updateRugSizes" class="form-select"
                                                id="rugSelect">
                                                <option value="" disabled>Select a rug</option>
                                                <option v-for="rug in rugs?.data" :key="rug?.id" :value="rug?.id">
                                                    {{ rug.name }}
                                                </option>
                                            </select>
                                            <span v-if="form.errors.rug_id" class="text-danger">
                                                {{ form.errors.rug_id }}
                                            </span>
                                        </div>

                                        <!-- Rug Size Dropdown -->
                                        <div v-if="rugSizes.length > 0" class="mb-3">
                                            <label for="rugSizeSelect" class="form-label">Rug Size</label>
                                            <select v-model="form.size_id" class="form-select" id="rugSizeSelect">
                                                <option value="" disabled>Select a size</option>
                                                <option v-for="size in rugSizes" :key="size.id" :value="size.id">
                                                    {{ size.width }}cm x {{ size.length }}cm
                                                </option>
                                            </select>
                                            <span v-if="form.errors.size_id" class="text-danger">
                                                {{ form.errors.size_id }}
                                            </span>
                                        </div>

                                        <!-- Color Palette -->
                                        <div class="mb-3">
                                            <ColorMultipleSelect id="colorPalette" label="Color Palette"
                                            v-model="form.color_palet" :error-message="form.errors.color_palet" />
                                        </div>

                                        <!-- Image Upload -->
                                        <div class="mb-3">
                                            <label for="imageUpload" class="form-label">Upload Image</label>
                                            <input type="file" class="form-control" id="imageUpload"
                                                @change="onImageChange">
                                            <span v-if="form.errors.image" class="text-danger">{{ form.errors.image
                                                }}</span>
                                            <!-- Preview -->
                                            <div v-if="imagePreview" class="mt-3">
                                                <img :src="imagePreview" alt="Image Preview" class="img-thumbnail"
                                                    style="max-height: 200px;">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Right Section -->
                                <div class="col-lg-4">
                                    <div class="border border-3 p-4 rounded">
                                        <!-- Delivery Date -->
                                        <div class="mb-3">
                                            <label for="deliveryDate" class="form-label">Delivery Date</label>
                                            <input v-model="form.delivery_date" type="date" class="form-control"
                                                id="deliveryDate" />
                                            <span v-if="form.errors.delivery_date" class="text-danger">
                                                {{ form.errors.delivery_date }}
                                            </span>
                                        </div>

                                        <!-- Total Price -->
                                        <div class="mb-3">
                                            <label for="totalPrice" class="form-label">Total Price</label>
                                            <input v-model="form.total_price" type="number" class="form-control"
                                                id="totalPrice" placeholder="Enter total price" />
                                            <span v-if="form.errors.total_price" class="text-danger">
                                                {{ form.errors.total_price }}
                                            </span>
                                        </div>

                                        <!-- Description -->
                                        <div class="mb-3">
                                            <label for="orderDescription" class="form-label">Description</label>
                                            <textarea v-model="form.description" id="orderDescription" rows="4"
                                                class="form-control"></textarea>
                                            <span v-if="form.errors.description" class="text-danger">
                                                {{ form.errors.description }}
                                            </span>
                                        </div>

                                        <div class="d-grid">
                                            <button type="submit" class="btn btn-primary">
                                                Update Order
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </MainLayout>
</template>

<script>
import MainLayout from '@/Layouts/MainLayout.vue';
import BreadCrumb from '@/Components/common/BreadCrumb.vue';
import { useForm } from '@inertiajs/vue3';
import ColorMultipleSelect from '@/Components/common/ColorMultipleSelect.vue';

export default {
    components: {
        BreadCrumb,
        MainLayout,
        ColorMultipleSelect,
    },
    props: {
        rugs: Array,
        clients: Array,
        order: Object,
    },
    data() {
        return {
            form: useForm({
                rug_id: this.order.data?.rug_id || '',
                client_id: this.order.data?.client_id || '',
                size_id: this.order.data?.size_id || '',
                total_price: this.order.data?.total_price || '',
                color_palet: this.order.data?.color_palet || [''],
                delivery_date: this.order.data?.delivery_date || '',
                description: this.order.data?.description || '',
                image: null,
                status: this.order.data?.status || '',
            }),
            imagePreview: this.order.data?.image_url ? '/storage/' + this.order.data.image_url : null,
            breadcrumbLinks: [
                { name: 'Home', url: 'javascript:;', icon: 'bx bx-home-alt' },
                { name: 'Orders', url: '/orders', icon: 'lni lni-cart' },
                { name: 'Update', url: 'javascript:;', icon: '' },
            ],
            rugSizes: this.order.data?.rug?.sizes || [],
        };
    },
    methods: {
        addColor() {
            this.form.color_palet.push('');
        },
        removeColor(index) {
            this.form.color_palet.splice(index, 1);
        },
        updateRugSizes() {
            const selectedRug = this.rugs?.data.find(rug => rug.id === this.form.rug_id);
            this.rugSizes = selectedRug ? selectedRug.sizes : [];
            this.form.size_id = '';
            this.form.total_price = selectedRug?.approx_cost || 0;
        },
        submit() {
            this.form.put(route('orders.update', { id: this.order.data.id }), {
                onFinish: () => {
                    this.form.reset();
                    this.imagePreview = null;
                },
            });
        },

        onImageChange(event) {
            const file = event.target.files[0];
            if (file) {
                this.form.image = file;
                this.imagePreview = URL.createObjectURL(file);
            }
        },
    },
};
</script>
