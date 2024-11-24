<template>
    <MainLayout title="Dashboard">
        <div class="page-content">
            <!--breadcrumb-->
            <BreadCrumb :title="'Clients'" :links="breadcrumbLinks">
                <template v-slot:right>
                    <CustomButton width="100" :height="'40'" :isOutlined="true" :disabled="effectiveLoading"
                        @click="navigateCreateClient" :backgroundColor="'white'" :title="'Create'"
                        :borderRadius="'40px'" :icon="'plus'" />

                </template>
            </Breadcrumb>

            <!--end breadcrumb-->

            <div class="card">
                <div class="card-body">

                    <CustomDataTable :filterableColumns="filters" :columns="columns" :apiEndpoint="'/client/all'">
                        <template v-slot:phone_number="{ row }">
                            <div class="badge rounded-pill bg-light p-2 text-uppercase px-3"><i
                                    class="bx bxs-circle align-middle me-1"></i>
                                {{ row.phone_number }}
                            </div>
                            <!-- actions -->

                        </template>

                        <template v-slot:actions="{ row }">
                            <div class="d-flex order-actions">
                                <a href="#" @click="editCient(row)" class=""><i class="bx bxs-edit"></i></a>
                                <a href="javascript:;" @click="deleteClient(row)" class="ms-3"><i
                                        class="bx bxs-trash"></i></a>
                            </div>
                        </template>
                    </CustomDataTable>

                </div>
            </div>
        </div>
    </MainLayout>
</template>


<script>
import MainLayout from '@/Layouts/MainLayout.vue';
import BreadCrumb from '@/Components/common/BreadCrumb.vue';
import CustomButton from '@/Components/common/CustomButton.vue';
import CustomDataTable from '@/Components/Tables/CustomDataTable.vue';
import { Link, router, useForm } from '@inertiajs/vue3'    // Add this line


export default {
    components: {
        BreadCrumb,
        MainLayout,
        CustomDataTable,
        CustomButton
    },
    data() {
        return {
            breadcrumbLinks: [
                { name: 'Home', url: 'javascript:;', icon: 'bx bx-home-alt' },
                { name: 'Clients', url: 'javascript:;', icon: '' }
            ],
            columns: [
                { label: 'Name', key: 'name' },
                { label: 'Email', key: 'email' },
                { label: 'Phone', key: 'phone_number' },
                { label: 'Gender', key: 'gender' },
                { label: 'Address', key: 'address' },
                { label: 'City', key: 'city' },
                { label: 'Actions', key: 'actions' },
            ],
            filters:
                [
                    { label: 'Name', key: 'name' },
                    { label: 'Email', key: 'email' },
                    { label: 'Phone', key: 'phone_number' }
                ]
        };
    },

    methods: {
        navigateCreateClient() {
            router.visit('/client/create')
        },

        editCient(client) {
            router.visit(`/client/edit/${client.id}`)
        },

        //submit delete client
        deleteClient(client) {
            // Add delete client logic here

            const deleteClientForm = useForm({});
            deleteClientForm.delete(route('clients.delete', client.id), {
                onFinish: () => {

                },
            });

        }



    }
}
</script>
