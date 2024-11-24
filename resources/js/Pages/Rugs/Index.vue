<template>
    <MainLayout title="Dashboard">
        <div class="page-content">
            <!--breadcrumb-->
            <BreadCrumb :title="'Clients'" :links="breadcrumbLinks">
                <template v-slot:right>
                    <CustomButton width="100" :height="'40'" :isOutlined="true" :disabled="effectiveLoading"
                        @click="navigateCreateRug" :backgroundColor="'white'" :title="'Create'" :borderRadius="'40px'"
                        :icon="'plus'" />

                </template>
            </Breadcrumb>

            <!--end breadcrumb-->

            <div class="card">
                <div class="card-body">

                    <CustomDataTable :filterableColumns="filters" :columns="columns" :apiEndpoint="'/rugs/all'">
                        <template v-slot:type="{ row }">
                            <div class="badge rounded-pill bg-light p-2 text-uppercase px-3"><i
                                    class="bx bxs-circle align-middle me-1"></i>
                                {{ row.type }}
                            </div>
                            <!-- actions -->

                        </template>
                        <template v-slot:approx_cost="{ row }">
                            <MoneyDisplay :value="row.approx_cost" />
                            <!-- actions -->
                        </template>
                        <template v-slot:approx_production_cost="{ row }">
                            <MoneyDisplay :value="row.approx_production_cost" />
                            <!-- actions -->
                        </template>

                        <template v-slot:actions="{ row }">
                            <div class="d-flex order-actions">
                                <a href="#" @click="selectRug(row)" class="" data-bs-toggle="modal"
                                    data-bs-target="#viewRugDetailModal"><i class="lni lni-eye"></i></a>

                                <a href="#" @click="editRug(row)" class="ms-3"><i class="bx bxs-edit "></i></a>
                                <a href="javascript:;" @click="deleteRug(row)" class="ms-3"><i
                                        class="bx bxs-trash"></i></a>
                            </div>
                        </template>
                    </CustomDataTable>

                </div>
            </div>
        </div>

        <!-- <template v-if="selectedRug">
        </template> -->

        <ViewRugModal :rug="selectedRug" />

    </MainLayout>
</template>


<script>
import MainLayout from '@/Layouts/MainLayout.vue';
import BreadCrumb from '@/Components/common/BreadCrumb.vue';
import MoneyDisplay from '@/Components/common/MoneyDisplay.vue';
import CustomButton from '@/Components/common/CustomButton.vue';
import CustomDataTable from '@/Components/Tables/CustomDataTable.vue';
import { Link, router, useForm } from '@inertiajs/vue3'    // Add this line
import ViewRugModal from '@/Components/Rugs/ViewRugModal.vue';


export default {
    components: {
        BreadCrumb,
        MainLayout,
        CustomDataTable,
        CustomButton,
        MoneyDisplay,
        ViewRugModal
    },
    data() {
        return {
            selectedRug: null,
            breadcrumbLinks: [
                { name: 'Home', url: 'javascript:;', icon: 'bx bx-home-alt' },
                { name: 'Rugs', url: 'javascript:;', icon: '' }
            ],
            columns: [
                { label: 'Name', key: 'name' },
                { label: 'Type', key: 'type' },
                { label: 'Production Cost', key: 'approx_production_cost' },
                { label: 'Cost', key: 'approx_cost' },
                { label: 'Actions', key: 'actions' },
            ],
            filters:
                [
                    { label: 'Name', key: 'name' },
                    { label: 'Type', key: 'type' },
                    { label: 'Cost', key: 'approx_cost' }
                ]
        };
    },

    methods: {
        navigateCreateRug() {
            router.visit('/rugs/create')
        },

        editRug(rug) {
            router.visit(`/rugs/edit/${rug.id}`)
        },

        //submit delete rug
        deleteRug(rug) {
            // Add delete rug logic here

            const deleteRugForm = useForm({});
            deleteRugForm.delete(route('rugs.delete', rug.id), {
                onFinish: () => {
                },
            });
        },

        selectRug(rug) {
            this.selectedRug = rug;
        }
    }
}
</script>
