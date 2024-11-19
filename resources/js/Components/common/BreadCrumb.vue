<template>
    <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
        <div class="breadcrumb-title pe-3">{{ title }}</div>
        <div class="ps-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 p-0">
                    <li v-for="(link, index) in links" :key="index" class="breadcrumb-item"
                        :class="{ active: index === links.length - 1 }">
                        <a v-if="index !== links.length - 1" :href="link.url"><i :class="link.icon"></i></a>
                        <span v-else>{{ link.name }}</span>
                    </li>
                </ol>
            </nav>
        </div>
        <div class="ms-auto">
            <slot name=right></slot>
        </div>
    </div>
</template>

<script>
export default {
    name: 'Breadcrumb',
    props: {
        title: {
            type: String,
            required: true
        },
        links: {
            type: Array,
            required: true,
            validator: function (value) {
                return value.every(link => 'name' in link && 'url' in link && 'icon' in link);
            }
        }
    }
}
</script>

<style scoped>
/* Add any custom styles here */
</style>
