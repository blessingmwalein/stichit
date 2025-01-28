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


                                        <!-- Material Type -->
                                        <div class="mb-3">
                                            <!-- <label for="materialType" class="form-label">Material Type</label> -->
                                            <CustomMultiSelect :display-column="'name'" :bind-column="'id'"
                                                searchUrl="/materials/all" searchField="name" :isMultiple="false"
                                                label="Select Material" placeholder="Choose material type"
                                                v-model="form.material_id" />
                                            <span v-if="form.errors.material_id" class="text-danger">
                                                {{ form.errors.material_id }}
                                            </span>
                                        </div>

                                        <!-- desciption -->
                                        <div class="mb-3">
                                            <label for="desciption" class="form-label">Description</label>
                                            <textarea v-model="form.desciption" rows="4" class="form-control"
                                                id="desciption" placeholder="Enter description"></textarea>
                                            <span v-if="form.errors.desciption" class="text-danger">
                                                {{ form.errors.desciption }}
                                            </span>

                                        </div>


                                    </div>
                                </div>

                                <!-- Right Section -->
                                <div class="col-lg-4">
                                    <div class="border border-3 p-4 rounded">
                                        <!-- Price Per Unit -->
                                        <div class="mb-3">
                                            <label for="quantity" class="form-label">Quantity</label>
                                            <input v-model="form.quantity" type="number" class="form-control"
                                                id="quantity" placeholder="0.00" min="0" />
                                            <span v-if="form.errors.quantity" class="text-danger">
                                                {{ form.errors.quantity }}
                                            </span>
                                        </div>

                                        <!-- Brand -->
                                        <div class="mb-3">
                                            <!-- price per unit -->
                                            <label for="price_pr_unit" class="form-label">Price Per Unit</label>
                                            <input v-model="form.total_unit" type="number" class="form-control"
                                                id="price_pr_unit" placeholder="0.00" min="0" />
                                            <span v-if="form.errors.total_unit" class="text-danger">
                                                {{ form.errors.total_unit }}
                                            </span>
                                        </div>



                                        <!-- Submit Button -->
                                        <div class="d-grid">
                                            <button type="submit" class="btn btn-primary">
                                                Update Stock
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
                desciption: "",
                material_id: "",
                total_unit: 0,
                quantity: 0,
            }),
            breadcrumbLinks: [
                { name: "Home", url: "javascript:;", icon: "bx bx-home-alt" },
                { name: "Available Materials", url: "/available-materials", icon: "lni lni-cart" },
                { name: "Create", url: "javascript:;", icon: "" },
            ],

        };
    },
    methods: {
        submit() {

            this.form.post(route("available-materials.store"), {

                onSuccess: () => {
                    this.form.reset();
                    //navigate to the available materials page
                    // this.$inertia.visit("available-materials");
                },
            });
        },
    },
};
</script>
