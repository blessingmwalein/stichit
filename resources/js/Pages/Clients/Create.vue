<template>
    <MainLayout title="Dashboard">
        <div class="page-content">
            <!--breadcrumb-->
            <BreadCrumb :title="'Client'" :links="breadcrumbLinks" />

            <!--end breadcrumb-->
            <div class="card">
                <div class="card-body p-4">
                    <div class="form-body mt-4">
                        <form @submit.prevent="submit">
                            <div class="row">
                                <div class="col-lg-8">
                                    <div class="border border-3 p-4 rounded">
                                        <div class="mb-3">
                                            <label for="inputName" class="form-label">Full Name</label>
                                            <input v-model="form.name" type="text" class="form-control" id="inputName"
                                                placeholder="Enter full name" />
                                            <span v-if="form.errors.name" class="text-danger">
                                                {{ form.errors.name }}
                                            </span>
                                        </div>
                                        <div class="mb-3">
                                            <label for="inputEmail" class="form-label">Email</label>
                                            <input v-model="form.email" type="email" class="form-control"
                                                id="inputEmail" placeholder="Enter email" />
                                            <span v-if="form.errors.email" class="text-danger">
                                                {{ form.errors.email }}
                                            </span>
                                        </div>
                                        <div class="mb-3">
                                            <label for="inputGender" class="form-label">Gender</label>
                                            <select v-model="form.gender" class="form-select" id="inputGender">
                                                <option value="" disabled>Select gender</option>
                                                <option value="male">Male</option>
                                                <option value="female">Female</option>
                                            </select>
                                            <span v-if="form.errors.gender" class="text-danger">
                                                {{ form.errors.gender }}
                                            </span>
                                        </div>
                                        <div class="mb-3">
                                            <label for="inputPhoneNumber" class="form-label">Phone Number</label>
                                            <input v-model="form.phone_number" type="tel" class="form-control"
                                                id="inputPhoneNumber" placeholder="Enter phone number" />
                                            <span v-if="form.errors.phone_number" class="text-danger">
                                                {{ form.errors.phone_number }}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="border border-3 p-4 rounded">
                                        <div class="mb-3">
                                            <label for="inputAddress" class="form-label">Address</label>
                                            <!-- <input v-model="form.address" type="text" class="form-control"
                                                id="inputAddress" placeholder="Enter address" /> -->

                                            <textarea class="form-control" v-model="form.address"
                                                id="inputProductDescription" rows="4"></textarea>
                                            <span v-if="form.errors.address" class="text-danger">
                                                {{ form.errors.address }}
                                            </span>
                                        </div>
                                        <div class="mb-3">
                                            <label for="inputCity" class="form-label">City</label>
                                            <input v-model="form.city" type="text" class="form-control" id="inputCity"
                                                placeholder="Enter city" />
                                            <span v-if="form.errors.city" class="text-danger">
                                                {{ form.errors.city }}
                                            </span>
                                        </div>
                                        <div class="d-grid">
                                            <button type="submit" class="btn btn-primary">
                                                Save Client
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

export default {
    components: {
        BreadCrumb,
        MainLayout,
    },
    data() {
        return {
            form: useForm({
                name: '',
                email: '',
                gender: '',
                phone_number: '',
                address: '',
                city: '',
            }),
            breadcrumbLinks: [
                { name: 'Home', url: 'javascript:;', icon: 'bx bx-home-alt' },
                { name: 'Clients', url: 'javascript:;', icon: 'bx bx-user' },
                { name: 'Create', url: 'javascript:;', icon: '' },
            ],
        };
    },
    methods: {
        submit() {
            this.form.post(route('clients.store'), {
                onFinish: () => {
                    this.form.reset();
                },
            });
        },
    },
};
</script>
