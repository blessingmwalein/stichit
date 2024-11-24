<template>
    <MainLayout title="Create Rug">
        <div class="page-content">
            <!-- Breadcrumb -->
            <BreadCrumb :title="'Rug'" :links="breadcrumbLinks" />

            <!-- Form Card -->
            <div class="card">
                <div class="card-body p-4">
                    <div class="form-body mt-4">
                        <form @submit.prevent="submit">
                            <div class="row">
                                <!-- Rug Details -->
                                <div class="col-lg-8">
                                    <div class="border border-3 p-4 rounded">
                                        <div class="mb-3">
                                            <label for="rugName" class="form-label">Rug Name</label>
                                            <input v-model="form.name" type="text" class="form-control" id="rugName"
                                                placeholder="Enter rug name" />
                                            <span v-if="form.errors.name" class="text-danger">
                                                {{ form.errors.name }}
                                            </span>
                                        </div>
                                        <div class="mb-3">
                                            <label for="rugType" class="form-label">Rug Type</label>
                                            <select v-model="form.type" class="form-select" id="rugType">
                                                <option value="" disabled>Select rug type</option>
                                                <option value="small">Small</option>
                                                <option value="medium">Medium</option>
                                                <option value="large">Large</option>
                                            </select>
                                            <span v-if="form.errors.type" class="text-danger">
                                                {{ form.errors.type }}
                                            </span>
                                        </div>
                                        <div class="mb-3">
                                            <label for="productionCost" class="form-label">Production Cost</label>
                                            <input v-model="form.approx_production_cost" type="number"
                                                class="form-control" id="productionCost"
                                                placeholder="Enter production cost" />
                                            <span v-if="form.errors.approx_production_cost" class="text-danger">
                                                {{ form.errors.approx_production_cost }}
                                            </span>
                                        </div>
                                        <div class="mb-3">
                                            <label for="approxCost" class="form-label">Approximate Cost</label>
                                            <input v-model="form.approx_cost" type="number" class="form-control"
                                                id="approxCost" placeholder="Enter approximate cost" />
                                            <span v-if="form.errors.approx_cost" class="text-danger">
                                                {{ form.errors.approx_cost }}
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Rug Sizes -->
                                <div class="col-lg-4">
                                    <div class="border border-3 p-4 rounded">
                                        <label class="form-label">Rug Sizes</label>
                                        <div v-for="(size, index) in form.sizes" :key="index" class="mb-3">
                                            <div class="row g-2 align-items-center">
                                                <div class="col-10">
                                                    <select v-model="form.sizes[index]" class="form-select">
                                                        <option value="" disabled>Select a size</option>
                                                        <option v-for="presetSize in presetSizes" :key="presetSize.id"
                                                            :value="presetSize.id">
                                                            {{ presetSize.width }}cm x {{ presetSize.length }}cm
                                                        </option>
                                                    </select>
                                                    <span v-if="form.errors[`sizes.${index}`]" class="text-danger">
                                                        {{ form.errors[`sizes.${index}`] }}
                                                    </span>
                                                </div>
                                                <div class="col-2">
                                                    <button type="button" class="btn btn-danger btn-sm"
                                                        @click="removeSize(index)">
                                                        &times;
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="button" class="btn btn-secondary btn-sm mt-2" @click="addSize">
                                            Add Size
                                        </button>
                                    </div>
                                    <div class="d-grid mt-4">
                                        <button type="submit" class="btn btn-primary">
                                            Save Rug
                                        </button>
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

export default {
    props: {
        sizes: Array, // Predefined sizes passed from the backend
    },
    components: {
        BreadCrumb,
        MainLayout,
    },
    data() {
        return {
            form: useForm({
                name: '',
                type: '',
                approx_production_cost: '',
                approx_cost: '',
                sizes: [], // Start with an empty array
            }),
            breadcrumbLinks: [
                { name: 'Home', url: 'javascript:;', icon: 'bx bx-home-alt' },
                { name: 'Rugs', url: '/rugs', icon: 'bx bx-layer' },
                { name: 'Create', url: 'javascript:;', icon: '' },
            ],
            presetSizes: this.sizes, // Initialize from prop
        };
    },
    methods: {
        addSize() {
            this.form.sizes.push(''); // Add an empty ID slot
        },
        removeSize(index) {
            this.form.sizes.splice(index, 1);
        },
        submit() {
            this.form.post(route('rugs.store'), {
                onFinish: () => {
                    // this.form.reset();
                },
            });
        },
    },
};
</script>
