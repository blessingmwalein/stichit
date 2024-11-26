<template>
    <MainLayout title="Dashboard">
        <div class="page-content">
            <!--breadcrumb-->
            <BreadCrumb :title="'Clients'" :links="breadcrumbLinks">
                <template v-slot:right>
                    <CustomButton width="100" :height="'40'" :isOutlined="true" :disabled="effectiveLoading"
                        @click="navigateCreateOrder" :backgroundColor="'white'" :title="'Create'" :borderRadius="'40px'"
                        :icon="'plus'" />

                </template>
            </Breadcrumb>

            <!--end breadcrumb-->

            <div class="card">
                <div class="card-body">
                    <CustomDataTable :filterableColumns="filters" :columns="columns" :apiEndpoint="'/orders/all'">
                        <template v-slot:client_name="{ row }">
                            <UserDisplay :name="row.client_name" />
                            <!-- actions -->
                        </template>
                        <template v-slot:status="{ row }">
                            <OrderStatus :status="row.status" />
                            <!-- actions -->
                        </template>
                        <template v-slot:rug="{ row }">
                            <!-- rug name and approx cost in column -->
                            <div class="flex">
                                <div class="me-2">{{ row.rug.name }}</div>
                                <div class="me-2">{{ row.size.length }}cm x {{ row.size.width }}cm</div>

                            </div>

                        </template>
                        <template v-slot:total_price="{ row }">
                            <MoneyDisplay :value="row.total_price" />
                        </template>

                        <template v-slot:color_palet="{ row }">
                            <ColorPalet :colorPalette="row.color_palet" />
                        </template>

                        <template v-slot:actions="{ row }">
                            <div class="d-flex order-actions">
                                <a href="#" @click="selectRug(row)" class="" data-bs-toggle="modal"
                                data-bs-target="#viewOrderDetailModal"><i class="lni lni-eye"></i></a>
                                <a href="#" @click="editCient(row)" class="ms-3"><i class="bx bxs-edit"></i></a>
                                <a href="javascript:;" @click="deleteClient(row)" class="ms-3"><i
                                        class="bx bxs-trash"></i></a>
                            </div>
                        </template>
                    </CustomDataTable>

                </div>
            </div>
        </div>

        <ViewOrderModal :order="selectedOrder" />
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
        ViewOrderModal
    },
    data() {
        return {
            breadcrumbLinks: [
                { name: 'Home', url: 'javascript:;', icon: 'bx bx-home-alt' },
                { name: 'Client', url: 'order/accounts', icon: '' },
                { name: 'Orders', url: 'javascript:;', icon: '' }
            ],
            columns: [
                { label: 'Client', key: 'client_name' },
                { label: 'Total Price', key: 'total_price' },
                { label: 'Colors', key: 'color_palet' },
                { label: 'Status', key: 'status' },
                { label: 'Rug', key: 'rug' },
                { label: 'Actions', key: 'actions' },
            ],
            selectedOrder: null,
            filters:
                [
                    { label: 'Name', key: 'name' },
                    { label: 'Email', key: 'email' },
                    { label: 'Status', key: 'status' }
                ]
        };
    },

    methods: {
        navigateCreateOrder() {
            router.visit('/orders/create')
        },

        selectRug(order) {
            this.selectedOrder = order;
        },

        editCient(order) {
            router.visit(`/orders/edit/${order.id}`)
        },

        //submit delete order
        deleteClient(order) {
            // Add delete order logic here

            const deleteOrderForm = useForm({});
            deleteOrderForm.delete(route('orders.delete', order.id), {
                onFinish: () => {
                },
            });
        }
    }
}
</script>
