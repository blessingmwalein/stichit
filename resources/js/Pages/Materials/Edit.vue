<template>
    <MainLayout title="Update Material">
        <div class="page-content">
            <!--breadcrumb-->
            <BreadCrumb :title="'Update Material'" :links="breadcrumbLinks" />
            <!--end breadcrumb-->
            <div class="card">
                <div class="card-body p-4">
                    <div class="form-body mt-4">
                        <form @submit.prevent="submit">
                            <div class="row">
                                <!-- Left Section -->
                                <div class="col-lg-8">
                                    <div class="border border-3 p-4 rounded">
                                        <!-- Name -->
                                        <div class="mb-3">
                                            <label for="name" class="form-label">Name</label>
                                            <input v-model="form.name" type="text" class="form-control" id="name"
                                                placeholder="Enter material name" />
                                            <span v-if="form.errors.name" class="text-danger">
                                                {{ form.errors.name }}
                                            </span>
                                        </div>

                                        <!-- Material Type -->
                                        <div class="mb-3">
                                            <!-- <label for="materialType" class="form-label">Material Type</label> -->
                                            <CustomMultiSelect :options="materialTypes" :isMultiple="false"
                                                :bind-column="'id'" label="Select Material Type"
                                                placeholder="Choose material type" v-model="form.material_type_id" />
                                            <span v-if="form.errors.material_type_id" class="text-danger">
                                                {{ form.errors.material_type_id }}
                                            </span>
                                        </div>

                                        <!-- Unit -->
                                        <div class="mb-3">
                                            <!-- <label for="unit" class="form-label">Unit</label> -->
                                            <CustomMultiSelect :options="units" :isMultiple="false" label="Select Unit"
                                                placeholder="Choose a unit" v-model="form.unit" />
                                            <span v-if="form.errors.unit" class="text-danger">
                                                {{ form.errors.unit }}
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Right Section -->
                                <div class="col-lg-4">
                                    <div class="border border-3 p-4 rounded">
                                        <!-- Price Per Unit -->
                                        <div class="mb-3">
                                            <!-- <label for="pricePerUnit" class="form-label">Price Per Unit</label>
                                            <!-- <input v-model="form.price_per_unit" type="number" class="form-control"
                                                id="pricePerUnit" placeholder="Enter price per unit" min="0" /> --> 
                                            <MoneyTextField v-model="form.price_per_unit" id="product-price"
                                                label="Product Price"
                                                :currency-options="{ currency: 'USD', locale: 'en-US' }"
                                                :disabled="false" :error="form.errors.price_per_unit" />
                                            <!-- <span v-if="form.errors.price_per_unit" class="text-danger">
                                                {{ form.errors.price_per_unit }}
                                            </span> -->
                                        </div>

                                        <!-- Brand -->
                                        <div class="mb-3">
                                            <!-- <label for="brand" class="form-label">Brand</label> -->
                                            <CustomMultiSelect :options="brands" :isMultiple="false"
                                                label="Select Brand" placeholder="Choose one or more brands"
                                                v-model="form.brand" />
                                            <span v-if="form.errors.brand" class="text-danger">
                                                {{ form.errors.brand }}
                                            </span>
                                        </div>


                                        <!-- Submit Button -->
                                        <div class="d-grid">
                                            <button type="submit" class="btn btn-primary">
                                                Save Material
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
import CustomMultiSelect from "@/Components/common/CustomMultiSelect.vue";
import MoneyTextField from '@/Components/common/TextFields/MoneyTextField.vue';

export default {
    components: {
        BreadCrumb,
        MainLayout,
        CustomMultiSelect,
        MoneyTextField,
    },
    props: {
        materialTypes: Array, // Material types from the backend
        material: Object
    },
    data() {
        return {
            form: useForm({
                name: this.material?.data?.name || "",
                material_type_id: this.material?.data?.material_type_id || "",
                price_per_unit: this.material?.data?.price_per_unit || "",
                unit: this.material?.data?.unit || "",
                brand: this.material?.data?.brand || "",
            }),
            units: ["Cm", "Meters", "Kgs", "Litres", "Gramms"],
            brands: ["Stylecraft", "Charity", "Pullskein", "Gluedevil", "Other"],
            imagePreview: this.material?.data?.image_url ? '/storage/' + this.material?.data.image_url : null,
            breadcrumbLinks: [
                { name: 'Home', url: 'javascript:;', icon: 'bx bx-home-alt' },
                { name: 'Orders', url: '/orders', icon: 'lni lni-cart' },
                { name: 'Update', url: 'javascript:;', icon: '' },
            ],
            rugSizes: this.material?.data?.rug?.sizes || [],
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
            this.form.put(route('materials.update', { id: this.material.data.id }), {
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
