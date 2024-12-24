<template>
    <MainLayout title="Dashboard">
        <div class="page-content">
            <!--breadcrumb-->
            <BreadCrumb :title="'Available'" :links="breadcrumbLinks">
                <template v-slot:right>
                    <CustomButton width="100" :height="'40'" :isOutlined="true" :disabled="effectiveLoading"
                        @click="navigateCreateMaterial" :backgroundColor="'white'" :title="'Create'"
                        :borderRadius="'40px'" :icon="'plus'" />

                </template>
            </Breadcrumb>

            <!--end breadcrumb-->

            <div class="card">
                <div class="card-body">
                    <CustomDataTable :filterableColumns="filters" :columns="columns"
                        :apiEndpoint="'/available-materials/all'">


                        <template v-slot:name="{ row }">
                            <!-- rug name and approx cost in column -->
                            <div class="flex">
                                <div class="me-2">{{ row.material_type_name }}</div>
                                <div class="me-2">{{ row.desciption }}</div>
                            </div>
                        </template>
                        <template v-slot:material_unit_price="{ row }">
                            <MoneyDisplay :value="row.material_unit_price" />
                        </template>
                        <template v-slot:total_unit="{ row }">
                            <MoneyDisplay :value="row.total_unit" />
                        </template>
                        <template v-slot:created_at="{ row }">
                            <DateDisplay :date="row.created_at" />
                        </template>
                        <template v-slot:quantity="{ row }">
                            <div class="flex flex">
                                <div class="me-2">{{ row.quantity }} {{ row.material_unit }}</div>

                            </div>
                        </template>


                        <template v-slot:actions="{ row }">
                            <div class="d-flex material-actions">
                                <a href="#" @click="selectMaterial(row)" class="" data-bs-toggle="modal"
                                    data-bs-target="#viewMaterialModal"><i class="lni lni-eye"></i></a>
                                <a href="#" @click="editMaterial(row)" class="ms-3"><i class="bx bxs-edit"></i></a>
                                <a href="javascript:;" @click="deleteMaterial(row)" class="ms-3"><i
                                        class="bx bxs-trash"></i></a>
                            </div>
                        </template>
                    </CustomDataTable>
                </div>
            </div>
        </div>

        <ViewOrderModal :material="selectedMaterial" />
    </MainLayout>
</template>


<script>
import MainLayout from '@/Layouts/MainLayout.vue';
import BreadCrumb from '@/Components/common/BreadCrumb.vue';
import CustomButton from '@/Components/common/CustomButton.vue';
import CustomDataTable from '@/Components/Tables/CustomDataTable.vue';
import { Link, router, useForm } from '@inertiajs/vue3'    // Add this line
import OrderStatus from '@/Components/common/OrderStatus.vue';
import MoneyDisplay from '@/Components/common/MoneyDisplay.vue';
import ColorPalet from '@/Components/common/ColorPalet.vue';
import UserDisplay from '@/Components/common/UserDisplay.vue';
import ViewOrderModal from '@/Components/Orders/ViewOrderModal.vue';
import DateDisplay from '@/Components/common/DateDisplay.vue';


export default {
    components: {
        BreadCrumb,
        MainLayout,
        CustomDataTable,
        CustomButton,
        OrderStatus,
        MoneyDisplay,
        ColorPalet,
        UserDisplay,
        ViewOrderModal,
        DateDisplay
    },
    data() {
        return {
            breadcrumbLinks: [
                { name: 'Home', url: 'javascript:;', icon: 'bx bx-home-alt' },
                { name: 'Materials', url: 'material/accounts', icon: '' }
            ],
            columns: [
                { label: 'Name', key: 'name' },
                { label: 'Quantity', key: 'quantity' },
                { label: 'Unit Price', key: 'material_unit_price' },
                { label: 'Total Price', key: 'total_unit' },
                // { label: 'Unit', key: 'material_unit' },
                { label: 'Created At', key: 'created_at' },
                { label: 'Actions', key: 'actions' },
            ],
            selectedMaterial: null,
            filters:
                [
                    { label: 'Desciption', key: 'name' },
                    { label: 'Material', key: 'material_type' },
                    { label: 'Total Price', key: 'total_unit' },
                    { label: 'Unit', key: 'material_unit' },
                ]
        };
    },

    methods: {
        navigateCreateMaterial() {
            router.visit('/available-materials/create')
        },

        selectMaterial(material) {
            this.selectedMaterial = material;
        },

        editMaterial(material) {
            router.visit(`/available-materials/edit/${material.id}`)
        },

        //submit delete material
        deleteMaterial(material) {
            // Add delete material logic here
            const deleteMaterialForm = useForm({});
            deleteMaterialForm.delete(route('available-materials.delete', material.id), {
                onFinish: () => {
                },
            });
        }
    }
}
</script>
