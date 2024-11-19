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

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    terms: false,
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <AuthLayout :image="'/assets/logos/loginbanner.jpg'" :title="'Stitcht Nest Inc'"
        :subtitle="'Please fill the below details to register'">
        <div class="form-body ">
            <form class="row g-3" @submit.prevent="submit">
                <!-- Name Field -->
                <div class="col-12">
                    <label for="name" class="form-label">Name</label>
                    <input v-model="form.name" type="text" class="form-control" id="name" placeholder="John Doe">
                    <InputError class="mt-2" :message="form.errors.name" />
                </div>

                <!-- Email Field -->
                <div class="col-12">
                    <label for="email" class="form-label">Email</label>
                    <input v-model="form.email" type="email" class="form-control" id="email" placeholder="jhon@example.com">
                    <InputError class="mt-2" :message="form.errors.email" />
                </div>

                <!-- Password Field -->
                <div class="col-12">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group" id="show_hide_password">
                        <input v-model="form.password" type="password" class="form-control border-end-0" id="password" placeholder="Enter Password">
                        <a href="javascript:;" class="input-group-text"><i class="bx bx-hide"></i></a>
                    </div>
                    <InputError class="mt-2" :message="form.errors.password" />
                </div>

                <!-- Confirm Password Field -->
                <div class="col-12">
                    <label for="password_confirmation" class="form-label">Confirm Password</label>
                    <div class="input-group" id="show_hide_password">
                        <input v-model="form.password_confirmation" type="password" class="form-control border-end-0" id="password_confirmation" placeholder="Confirm Password">
                        <a href="javascript:;" class="input-group-text"><i class="bx bx-hide"></i></a>
                    </div>
                    <InputError class="mt-2" :message="form.errors.password_confirmation" />
                </div>

                <!-- Terms and Conditions -->
                <div v-if="$page.props.jetstream.hasTermsAndPrivacyPolicyFeature" class="col-12">
                    <div class="form-check form-switch">
                        <Checkbox v-model:checked="form.terms" name="terms" />
                        <label class="form-check-label" for="terms">I agree to the <a target="_blank" :href="route('terms.show')" class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md">Terms of Service</a> and <a target="_blank" :href="route('policy.show')" class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md">Privacy Policy</a></label>
                    </div>
                    <InputError class="mt-2" :message="form.errors.terms" />
                </div>

                <!-- Register Button -->
                <div class="col-12">
                    <div class="d-grid">
                        <CustomButton :isLoading="form.processing" :height="'60'" :isOutlined="true" :backgroundColor="'#232522'" :title="'Register'" />
                    </div>
                </div>

                <!-- Login Link -->
                <div class="col-12">
                    <div class="text-center">
                        <p class="mb-0">Already have an account?
                            <Link :href="route('login')" class="text-primary">Login here</Link>
                        </p>
                    </div>
                </div>
            </form>
        </div>

        <div class="login-separater text-center mb-5">
            <span>OR REGISTER WITH</span>
            <hr>
        </div>

        <div class="list-inline contacts-social text-center">
            <a href="javascript:;" class="list-inline-item bg-light text-white border-0 rounded-3"><i class="bx bxl-facebook"></i></a>
            <a href="javascript:;" class="list-inline-item bg-light text-white border-0 rounded-3"><i class="bx bxl-twitter"></i></a>
            <a href="javascript:;" class="list-inline-item bg-light text-white border-0 rounded-3"><i class="bx bxl-google"></i></a>
            <a href="javascript:;" class="list-inline-item bg-light text-white border-0 rounded-3"><i class="bx bxl-linkedin"></i></a>
        </div>
    </AuthLayout>
</template>

<style scoped>
.form-control {
    padding: 15px;
    border-radius: 10px;
}


</style>
