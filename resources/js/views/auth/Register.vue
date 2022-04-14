<template>
  <div class="w-80 page-content">
    <div class="page-single-content">
      <div class="card-body p-6">
        <div class="row">
          <div class="col-md-8 mx-auto d-block">
            <h1 class="mb-2">{{ $t("register.register") }}</h1>
            <p class="text-muted">{{ $t("register.register_title") }}</p>
            <hr class="divider my-6" />
            <form @submit.prevent="validateBeforeSubmit">
              <div
                class="input-group mb-3"
                :class="[
                  'form-group name-form',
                  { 'is-invalid': $v.registerData.first_name.$error },
                ]"
              >
                <span class="input-group-addon"
                  ><svg
                    class="svg-icon"
                    xmlns="http://www.w3.org/2000/svg"
                    height="24"
                    viewBox="0 0 24 24"
                    width="24"
                  >
                    <path d="M0 0h24v24H0V0z" fill="none" />
                    <path
                      d="M12 16c-2.69 0-5.77 1.28-6 2h12c-.2-.71-3.3-2-6-2z"
                      opacity=".3"
                    />
                    <circle cx="12" cy="8" opacity=".3" r="2" />
                    <path
                      d="M12 14c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4zm-6 4c.22-.72 3.31-2 6-2 2.7 0 5.8 1.29 6 2H6zm6-6c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0-6c1.1 0 2 .9 2 2s-.9 2-2 2-2-.9-2-2 .9-2 2-2z"
                    />
                  </svg>
                </span>
                <input
                  :class="{
                    'is-invalid': $v.registerData.first_name.$error,
                    'form-group--loading': $v.registerData.first_name.$pending,
                  }"
                  v-model.lazy="registerData.first_name"
                  class="form-control"
                  :placeholder="$t('register.placeholder.input_first_name')"
                  type="text"
                  id="signup-fist-name"
                  @change="$v.registerData.first_name.$touch()"
                />
                <span
                  v-if="!$v.registerData.first_name.required"
                  class="invalid-feedback"
                >
                  {{ $t("register.validation.first_name_required") }}
                </span>
                <span
                  v-if="!$v.registerData.first_name.minLength"
                  class="invalid-feedback"
                >
                  {{ $t("register.validation.first_name_least") }}
                  {{ $v.registerData.first_name.$params.minLength.min }}
                  {{ $t("register.validation.letters") }}.
                </span>
              </div>
              <div
                class="input-group mb-4"
                :class="[
                  'form-group name-form',
                  { 'is-invalid': $v.registerData.last_name.$error },
                ]"
              >
                <span class="input-group-addon"
                  ><svg
                    class="svg-icon"
                    xmlns="http://www.w3.org/2000/svg"
                    height="24"
                    viewBox="0 0 24 24"
                    width="24"
                  >
                    <path d="M0 0h24v24H0V0z" fill="none" />
                    <path
                      d="M12 16c-2.69 0-5.77 1.28-6 2h12c-.2-.71-3.3-2-6-2z"
                      opacity=".3"
                    />
                    <circle cx="12" cy="8" opacity=".3" r="2" />
                    <path
                      d="M12 14c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4zm-6 4c.22-.72 3.31-2 6-2 2.7 0 5.8 1.29 6 2H6zm6-6c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0-6c1.1 0 2 .9 2 2s-.9 2-2 2-2-.9-2-2 .9-2 2-2z"
                    />
                  </svg>
                </span>
                <input
                  :class="{
                    'is-invalid': $v.registerData.last_name.$error,
                    'form-group--loading': $v.registerData.last_name.$pending,
                  }"
                  v-model.lazy="registerData.last_name"
                  class="form-control"
                  :placeholder="$t('register.placeholder.input_last_name')"
                  type="text"
                  id="signup-last-name"
                  @change="$v.registerData.last_name.$touch()"
                />
                <span
                  v-if="!$v.registerData.last_name.required"
                  class="invalid-feedback"
                >
                  {{ $t("register.validation.last_name_required") }}
                </span>
                <span
                  v-if="!$v.registerData.last_name.minLength"
                  class="invalid-feedback"
                >
                  {{ $t("register.validation.last_name_least") }}
                  {{ $v.registerData.last_name.$params.minLength.min }}
                  {{ $t("register.validation.letters") }}.
                </span>
              </div>
              <div
                class="input-group mb-4"
                :class="[
                  'form-group',
                  { 'is-invalid': $v.registerData.email.$error },
                ]"
              >
                <span class="input-group-addon"
                  ><svg
                    class="svg-icon"
                    xmlns="http://www.w3.org/2000/svg"
                    height="24"
                    viewBox="0 0 24 24"
                    width="24"
                  >
                    <path d="M0 0h24v24H0V0z" fill="none" />
                    <path
                      d="M20 8l-8 5-8-5v10h16zm0-2H4l8 4.99z"
                      opacity=".3"
                    />
                    <path
                      d="M4 20h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2zM20 6l-8 4.99L4 6h16zM4 8l8 5 8-5v10H4V8z"
                    />
                  </svg>
                </span>
                <input
                  :class="{
                    'is-invalid': $v.registerData.email.$error,
                    'form-group--loading': $v.registerData.email.$pending,
                  }"
                  v-model.trim.lazy="registerData.email"
                  class="form-control"
                  :placeholder="$t('register.placeholder.input_email')"
                  type="email"
                  id="signup-email"
                  @change="$v.registerData.email.$touch()"
                />
                <span
                  v-if="!$v.registerData.email.required"
                  class="invalid-feedback"
                >
                  {{ $t("register.validation.email_required") }}
                </span>
                <span
                  v-if="!$v.registerData.email.email"
                  class="invalid-feedback"
                >
                  {{ $t("register.validation.email_verify") }}.
                </span>
                <span
                  v-if="!$v.registerData.email.isUnique"
                  class="invalid-feedback"
                >
                  {{ $t("register.validation.email_already") }}.
                </span>
              </div>
              <div
                class="input-group mb-4"
                :class="[
                  'form-group',
                  { 'is-invalid': $v.registerData.password.$error },
                ]"
              >
                <span class="input-group-addon"
                  ><svg
                    class="svg-icon"
                    xmlns="http://www.w3.org/2000/svg"
                    height="24"
                    viewBox="0 0 24 24"
                    width="24"
                  >
                    <g fill="none">
                      <path d="M0 0h24v24H0V0z" />
                      <path d="M0 0h24v24H0V0z" opacity=".87" />
                    </g>
                    <path
                      d="M6 20h12V10H6v10zm6-7c1.1 0 2 .9 2 2s-.9 2-2 2-2-.9-2-2 .9-2 2-2z"
                      opacity=".3"
                    />
                    <path
                      d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zM9 6c0-1.66 1.34-3 3-3s3 1.34 3 3v2H9V6zm9 14H6V10h12v10zm-6-3c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2z"
                    />
                  </svg>
                </span>
                <input
                  :class="{ 'is-invalid': $v.registerData.password.$error }"
                  v-model.trim="registerData.password"
                  class="form-control"
                  :placeholder="$t('register.placeholder.input_password')"
                  type="password"
                  id="signup-password"
                  @change="$v.registerData.password.$touch()"
                />
                <span
                  v-if="!$v.registerData.password.required"
                  class="invalid-feedback"
                >
                  {{ $t("register.validation.password_required") }}.
                </span>
                <span
                  v-if="!$v.registerData.password.minLength"
                  class="invalid-feedback"
                >
                  {{ $t("register.validation.password_least") }}
                  {{ $v.registerData.password.$params.minLength.min }}
                  {{ $t("register.validation.letters") }}.
                </span>
              </div>
              <div
                class="input-group mb-4"
                :class="[
                  'form-group',
                  {
                    'is-invalid': $v.registerData.password_confirmation.$error,
                  },
                ]"
              >
                <span class="input-group-addon"
                  ><svg
                    class="svg-icon"
                    xmlns="http://www.w3.org/2000/svg"
                    height="24"
                    viewBox="0 0 24 24"
                    width="24"
                  >
                    <g fill="none">
                      <path d="M0 0h24v24H0V0z" />
                      <path d="M0 0h24v24H0V0z" opacity=".87" />
                    </g>
                    <path
                      d="M6 20h12V10H6v10zm6-7c1.1 0 2 .9 2 2s-.9 2-2 2-2-.9-2-2 .9-2 2-2z"
                      opacity=".3"
                    />
                    <path
                      d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zM9 6c0-1.66 1.34-3 3-3s3 1.34 3 3v2H9V6zm9 14H6V10h12v10zm-6-3c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2z"
                    />
                  </svg>
                </span>
                <input
                  :class="{
                    'is-invalid': $v.registerData.password_confirmation.$error,
                  }"
                  v-model.trim="registerData.password_confirmation"
                  class="form-control"
                  :placeholder="$t('register.placeholder.retype_password')"
                  id="signup-confirm-password"
                  type="password"
                  @change="$v.registerData.password_confirmation.$touch()"
                />
                <span
                  v-if="!$v.registerData.password_confirmation.sameAsPassword"
                  class="invalid-feedback"
                >
                  {{ $t("register.validation.password_identical") }}
                </span>
              </div>
              <div class="form-group">
                <label for="gender">{{ $t("register.gender") }}</label>
                <div
                  class="form-group margin-top-0"
                  :class="{ 'is-invalid': $v.registerData.gender.$error }"
                >
                  <div
                    class="form-check form-check-inline"
                    :class="{
                      'is-invalid': $v.registerData.gender.$error,
                    }"
                  >
                    <input
                      class="form-check-input"
                      type="radio"
                      name="gender"
                      v-model="registerData.gender"
                      id="gender1"
                      value="male"
                    />
                    <label class="form-check-label" for="gender1">{{
                      $t("register.male")
                    }}</label>
                  </div>
                  <div
                    class="form-check form-check-inline"
                    :class="{
                      'is-invalid': $v.registerData.gender.$error,
                    }"
                  >
                    <input
                      class="form-check-input"
                      type="radio"
                      name="gender"
                      v-model="registerData.gender"
                      id="gender2"
                      value="female"
                    />
                    <label class="form-check-label" for="gender2">{{
                      $t("register.female")
                    }}</label>
                  </div>
                  <div
                    v-if="$v.registerData.gender.$error"
                    class="invalid-feedback"
                  >
                    <span v-if="!$v.registerData.gender.required">{{
                      $t("register.valiation.gender_required")
                    }}</span>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <div
                  class="form-group margin-top-0"
                  :class="{ 'is-invalid': $v.registerData.terms.$error }"
                >
                  <div
                    class="form-check form-check-inline"
                    :class="{
                      'is-invalid': $v.registerData.terms.$error,
                    }"
                  >
                    <label class="custom-control custom-checkbox">
                      <input
                        type="checkbox"
                        class="custom-control-input"
                        v-model="registerData.terms"
                      />
                      <span class="custom-control-label"
                        >{{ $t("register.agree") }}
                        <a href="#" class="btn-link">{{
                          $t("register.terms")
                        }}</a></span
                      >
                    </label>
                  </div>
                  <div
                    v-if="$v.registerData.terms.$error"
                    class="invalid-feedback terms_conditions"
                  >
                    <span v-if="!$v.registerData.terms.required">{{
                      $t("register.validation.terms_condition_required")
                    }}</span>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-12">
                  <button
                    type="submit"
                    class="btn btn-lg btn-primary btn-block px-4 btn_sub"
                  >
                    <span v-if="loadingPage == false"
                      ><i class="fe fe-arrow-right"></i
                      >{{ $t("register.createAccount") }}</span
                    >
                    <clip-loader :loading="loadingPage"></clip-loader>
                  </button>
                </div>
              </div>
              <div class="pt-4">
                <div class="ivp-to-login font-weight-normal fs-16">
                  <span>{{ $t("register.already_account") }}</span>
                  <router-link
                    to="/login"
                    class="btn-link font-weight-normal"
                    >{{ $t("register.sign_in") }}</router-link
                  >
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import Auth from "../../services/auth";
import { required, minLength, email, sameAs } from "vuelidate/lib/validators";
import ClipLoader from "vue-spinner/src/ClipLoader.vue";

export default {
  name: "register",
  data() {
    return {
      registerData: {
        first_name: "Alex",
        last_name: "Rossi",
        email: "",
        password: "",
        password_confirmation: "",
        gender: "male",
        terms: true,
      },
      loadingPage: false,
      validateCaptcha: false,
    };
  },
  mounted() {
    this.loadingPage = false;
  },
  validations: {
    registerData: {
      first_name: {
        required,
        minLength: minLength(3),
      },
      last_name: {
        required,
        minLength: minLength(3),
      },
      password: {
        required,
        minLength: minLength(6),
      },
      password_confirmation: {
        sameAsPassword: sameAs("password"),
      },
      email: {
        required,
        email,
        async isUnique(value) {
          // standalone validator ideally should not assume a field is required
          if (value === "") return true;

          // simulate async call, fail for all logins with even length
          let response = await window.axios.post("/api/email-exist", {
            email: value,
          });
          return response.data;
        },
      },
      gender: {
        required,
      },
      terms: {
        required,
      },
    },
  },
  components: {
    ClipLoader,
  },
  methods: {
    validateBeforeSubmit() {
      this.$v.$touch();
      if (!this.$v.$error) {
        this.loadingPage = true;
        this.register(this.$i18n.locale);
      }
    },
    register(locale) {
      Auth.register(this.registerData, locale).then((res) => {
        if (res) {
          this.loadingPage = false;
          this.$router.push("/email_verification");
        }
      });
    },
  },
};
</script>

<style scoped>
.form-group {
  position: relative;
  margin-top: 30px;
}
.form-group label {
  margin: 0px;
  margin-bottom: 5px;
}
.login-page .login-box .form-control {
  margin: 0px;
}
.ivp-to-login {
  margin-top: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.ivp-to-login span {
  margin-right: 10px;
}
.invalid-feedback {
  position: absolute;
  top: 47px;
  text-align: center;
}
.btn-login {
  margin-top: 15px;
}
.margin-top-0 {
  margin-top: 0px;
  display: flex;
  align-items: center;
}
.margin-top-0 label {
  margin: 0px !important;
}
.margin-top-0 div {
  margin-right: 5px;
}
.user-registration-first-last-name {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 30px;
}
.user-registration-first-last-name .form-group {
  width: 48%;
}
.terms_conditions {
  top: 20px !important;
}
.name-form {
  margin: 0px;
}
.v-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
}
.input-group {
  margin-top: 35px;
}
.btn_sub {
  margin-top: 10px;
}
</style>
