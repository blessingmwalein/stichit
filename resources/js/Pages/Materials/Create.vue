<template>
    <MainLayout title="Create Material">
        <div class="page-content">
            <!-- Breadcrumb -->
            <BreadCrumb :title="'Create Material'" :links="breadcrumbLinks" />

            <!-- Card -->
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
                                            <label for="pricePerUnit" class="form-label">Price Per Unit</label>
                                            <input v-model="form.price_per_unit" type="number" class="form-control"
                                                id="pricePerUnit" placeholder="Enter price per unit" min="0" />
                                            <span v-if="form.errors.price_per_unit" class="text-danger">
                                                {{ form.errors.price_per_unit }}
                                            </span>
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
import MainLayout from "@/Layouts/MainLayout.vue";
import BreadCrumb from "@/Components/common/BreadCrumb.vue";
import CustomMultiSelect from "@/Components/common/CustomMultiSelect.vue";
import { useForm } from "@inertiajs/vue3";

export default {
    components: {
        BreadCrumb,
        MainLayout,
        CustomMultiSelect,
    },
    props: {
        materialTypes: Array, // Material types from the backend
    },
    data() {
        return {
            form: useForm({
                name: "",
                material_type_id: "",
                price_per_unit: "",
                unit: "",
                brand: "",
            }),
            breadcrumbLinks: [
                { name: "Home", url: "javascript:;", icon: "bx bx-home-alt" },
                { name: "Materials", url: "/materials", icon: "lni lni-cart" },
                { name: "Create", url: "javascript:;", icon: "" },
            ],
            // Units for the unit dropdown
            units: ["Cm", "Meters", "Kgs", "Litres", "Gramms"],
            brands: ["Stylecraft", "Charity", "Pullskein", "Gluedevil", "Other"],
        };
    },
    methods: {
        submit() {
            this.form.post(route("materials.store"), {
                onFinish: () => {
                    this.form.reset();
                },
            });
        },
    },
};
</script>
