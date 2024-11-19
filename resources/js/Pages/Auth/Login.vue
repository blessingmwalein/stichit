<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AuthenticationCard from '@/Components/AuthenticationCard.vue';
import AuthenticationCardLogo from '@/Components/AuthenticationCardLogo.vue';
import Checkbox from '@/Components/Checkbox.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import AuthLayout from '@/Layouts/AuthLayout.vue';
import CustomButton from '@/Components/common/CustomButton.vue';

defineProps({
    canResetPassword: Boolean,
    status: String,
});

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.transform(data => ({
        ...data,
        remember: form.remember ? 'on' : '',
    })).post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};
</script>

<template>
    <AuthLayout :image="'/assets/logos/loginbanner.jpg'" :title="'Stitcht Nest Inc'"
        :subtitle="'Please fill the below details to login'">
        <div class="form-body">
            <form class="row g-3" @submit.prevent="submit">
                <div class="col-12">
                    <label for="inputEmailAddress" class="form-label">Email</label>
                    <input v-model="form.email" type="email" class="form-control" id="inputEmailAddress" placeholder="">
                    <InputError class="mt-2" :message="form.errors.email" />

                </div>
                <div class="col-12">
                    <label for="inputChoosePassword" class="form-label">Password</label>
                    <div class="input-group" id="show_hide_password">
                        <input type="password" v-model="form.password" class="form-control border-end-0"
                            id="inputChoosePassword" placeholder="Enter Password"> <a href="javascript:;"
                            class="input-group-text"><i class="bx bx-hide"></i></a>
                    </div>
                    <InputError class="mt-2" :message="form.errors.password" />

                </div>
                <div class="col-md-6">
                    <div class="form-check form-switch">
                        <Checkbox v-model:checked="form.remember" name="remember" />

                        <label class="form-check-label" for="flexSwitchCheckChecked">Remember Me</label>
                    </div>
                </div>
                <div class="col-md-6 text-end">
                    <Link v-if="canResetPassword" :href="route('password.request')"
                        class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                    Forgot your password?
                    </Link>
                </div>
                <div class="col-12">
                    <div class="d-grid">
                        <CustomButton :isLoading="form.processing" :height="'60'" :isOutlined="true"
                            :backgroundColor="'#232522'" :title="'Login'" />
                    </div>
                </div>
                <div class="col-12">
                    <div class="text-center">
                        <p class="mb-0">Don't have an account yet?
                            <Link v-if="canResetPassword" :href="route('register')"
                                class="underline text-sm hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Sign up here
                            </Link>
                        </p>
                    </div>
                </div>
            </form>
        </div>
        <div class="login-separater text-center mb-5"> <span>OR SIGN IN WITH</span>
            <hr>
        </div>
        <div class="list-inline contacts-social text-center">
            <a href="javascript:;" class="list-inline-item bg-light text-white border-0 rounded-3"><i
                    class="bx bxl-facebook"></i></a>
            <a href="javascript:;" class="list-inline-item bg-light text-white border-0 rounded-3"><i
                    class="bx bxl-twitter"></i></a>
            <a href="javascript:;" class="list-inline-item bg-light text-white border-0 rounded-3"><i
                    class="bx bxl-google"></i></a>
            <a href="javascript:;" class="list-inline-item bg-light text-white border-0 rounded-3"><i
                    class="bx bxl-linkedin"></i></a>
        </div>
    </AuthLayout>
</template>
<style scoped>
.form-control {
    padding: 15px;
    border-radius: 10px;
}
</style>
