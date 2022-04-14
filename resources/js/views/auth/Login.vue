<template>
  <div class="w-80 page-content">
    <div class="page-single-content">
      <div class="card-body p-6">
        <div class="row">
          <div class="col-md-8 mx-auto d-block">
            <div class="">
              <h1 class="mb-2">{{ $t("login.login") }}</h1>
              <p class="text-muted">{{ $t("login.login_title") }}</p>
            </div>
            <hr class="divider my-6" />
            <form
              v-if="loadingEnable == false"
              @submit.prevent="validateBeforeSubmit"
            >
              <div
                class="input-group mb-3"
                :class="[
                  'form-group',
                  { 'is-invalid': $v.loginData.email.$error },
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
                    /></svg
                ></span>
                <input
                  :class="{ 'is-invalid': $v.loginData.email.$error }"
                  v-model.trim="loginData.email"
                  class="form-control"
                  :placeholder="$t('login.placeholder.enter_email')"
                  type="email"
                  id="login-email"
                  @input="$v.loginData.email.$touch()"
                />
                <span
                  v-if="!$v.loginData.email.required"
                  class="invalid-feedback"
                >
                  {{ $t("login.validation.email_required") }}
                </span>
                <span v-if="!$v.loginData.email.email" class="invalid-feedback">
                  {{ $t("login.validation.email_valid") }}
                </span>
              </div>
              <div
                class="input-group mb-4"
                :class="[
                  'form-group',
                  { 'is-invalid': $v.loginData.password.$error },
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
                    /></svg
                ></span>
                <input
                  :class="{ 'is-invalid': $v.loginData.password.$error }"
                  v-model.trim="loginData.password"
                  class="form-control"
                  :placeholder="$t('login.placeholder.enter_password')"
                  type="password"
                  id="login-password"
                  @input="$v.loginData.password.$touch()"
                />
                <span
                  v-if="!$v.loginData.password.required"
                  class="invalid-feedback"
                >
                  {{ $t("login.validation.password_required") }}
                </span>
                <span
                  v-if="!$v.loginData.password.minLength"
                  class="invalid-feedback"
                >
                  {{ $t("login.validation.password_least") }}
                  {{ $v.loginData.password.$params.minLength.min }}
                  {{ $t("login.validation.letters") }}.
                </span>
              </div>
              <div class="other-actions row">
                <div class="col-sm-6">
                  <div class="checkbox">
                    <label class="c-input c-checkbox">
                      <input
                        v-model="loginData.remember"
                        type="checkbox"
                        name="remember"
                      />
                      <span class="c-indicator" />
                      {{ $t("login.remember_me") }}
                    </label>
                  </div>
                </div>
                <div class="col-sm-6 text-sm-right">
                  <a href="/password/password-reset" class="forgot-link">
                    {{ $t("login.forgot_password") }}
                  </a>
                </div>

                <div class="col-12">
                  <button type="submit" class="btn btn-primary btn-block">
                    <i class="fe fe-arrow-right"></i>{{ $t("login.login") }}
                  </button>
                </div>
              </div>

              <div class="pt-4">
                <div class="font-weight-normal fs-16">
                  <span>{{ $t("login.new_here") }}</span>
                  <router-link
                    to="/register"
                    class="btn-link font-weight-normal"
                    >{{ $t("login.create_account") }}</router-link
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
import { required, minLength, email } from "vuelidate/lib/validators";
import Auth from "../../services/auth";
import Ls from "./../../services/ls.js";

export default {
  data() {
    return {
      loginData: {
        email: "admin@laraspace.in",
        password: "admin@123",
        remember: true,
      },
      validateCaptcha: false,
      loadingEnable: false,
    };
  },
  validations: {
    loginData: {
      password: {
        required,
        minLength: minLength(6),
      },
      email: {
        required,
        email,
      },
    },
  },
  methods: {
    validateBeforeSubmit() {
      this.$v.$touch();

      if (!this.$v.$error) {
        this.submitLogin();
      }
    },
    submitLogin() {
      this.login(this.$i18n.locale);
    },
    login(locale) {
      Auth.login(this.loginData, locale).then((res) => {
        if (res) {
          this.loadingEnable = true;
          this.$emit("loadingTrue", this.loadingEnable);
          if (Ls.get("Role") == "admin" || Ls.get("Role") == "regional_admin") {
            this.$router.push("/admin/users/all");
          } else if (Ls.get("Role") == "practitioner") {
            let user_id = Ls.get("user_id");
            this.$router.push("/admin/users/profile/" + user_id);
          }
        }
      });
    },
  },
  created() {
    const queries = this.$route.query;
    if (queries) {
      let email_verification_status = queries.email_verification;
      let verified_email = queries.email;
      if (email_verification_status == "true") {
        let updateData = {
          verification: 1,
          verified_email: verified_email,
        };
        Auth.updateUserEmailVerificationStatus(updateData).then((res) => {
          if (Ls.get("Email") == verified_email) {
            Ls.set("email_verification_status", 1);
          }
        });
      }
    } else {
      let emailVerificationStatus = Ls.get("email_verification_status");
      if (emailVerificationStatus == 0) {
        if (Ls.get("countryLang") == "US") {
          window.toastr["info"](
            "Your Email has not been verified yet. Please verify email."
          );
        } else if (Ls.get("countryLang") == "CN") {
          window.toastr["info"]("您的電子郵件尚未經過驗證。 請驗證電子郵件。");
        }
      }
    }

    if (Ls.get("Email") !== null) {
      var email = Ls.get("Email");
      this.loginData.email = email;
    }
    if (Ls.get("auth.token") !== null) {
      if (Ls.get("Role") == "practitioner") {
        let user_id = Ls.get("user_id");
        this.$router.push("/admin/users/profile/" + user_id);
      } else {
        this.$router.push("/admin/users/all");
      }
    }

    this.loadingEnable = false;
  },
};
</script>

<style scoped>
.form-group {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 40px;
  position: relative;
}
.form-group label {
  margin: 0px;
  margin-right: 10px;
  width: 90px;
}
.login-page .login-box .form-control {
  margin: 0px;
}
.ivp-to-register {
  margin-top: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.ivp-to-register span {
  margin-right: 10px;
}
.invalid-feedback {
  position: absolute;
  top: 45px;
  text-align: center;
}
.login-page .login-box .other-actions {
  margin-top: 40px;
}
</style>
<style>
.btn-theme {
  color: #212529;
  background-color: #ffde00;
  border-color: #ffde00;
  -o-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.15),
    0 1px 1px rgba(0, 0, 0, 0.075);
  -ms-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.15),
    0 1px 1px rgba(0, 0, 0, 0.075);
  -webkit-box-shadow: inset 0 1px 0 rgb(255 255 255 / 15%),
    0 1px 1px rgb(0 0 0 / 8%);
  box-shadow: inset 0 1px 0 rgb(255 255 255 / 15%), 0 1px 1px rgb(0 0 0 / 8%);
}
.login-label {
  display: flex;
  align-items: center;
  justify-content: center;
  height: calc(1.5em + 0.75rem + 2px);
  background-color: white;
  border-radius: 5px 0px 0px 5px;
  padding-left: 5px;
  padding-right: 5px;
  position: relative;
  left: 5px;
  width: 60px !important;
  border-right: 1px black solid;
  margin: 0px !important;
}
.login-label i {
  font-size: 24px;
  color: #585459;
}
</style>
