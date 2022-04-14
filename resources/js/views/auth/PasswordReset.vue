<template>
  <div class="w-80 page-content">
    <div class="page-single-content">
      <div class="card-body p-6">
        <div class="row">
          <div class="col-md-8 mx-auto d-block">
            <div class="password-reset">
              <form @submit.prevent="passwordReset">
                <h1 class="mb-2">{{ $t("forgot_password.title") }}</h1>
                <p class="text-muted">{{ $t("forgot_password.page_title") }}</p>
                <div class="input-group mb-4">
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
                    type="email"
                    class="form-control form-control-lg"
                    v-model="email"
                    :placeholder="$t('forgot_password.placeholder')"
                  />
                </div>
                <div class="form-group">
                  <label class="custom-control custom-checkbox">
                    <input
                      type="checkbox"
                      class="custom-control-input"
                      v-model="terms"
                    />
                    <span class="custom-control-label"
                      >{{ $t("forgot_password.agree") }}
                      <a href="#">{{ $t("forgot_password.terms") }}</a></span
                    >
                  </label>
                </div>
                <div class="row">
                  <div class="col-12">
                    <button
                      type="submit"
                      class="btn btn-lg btn-primary btn-block px-4"
                    >
                      <i
                        v-if="loadingPage == false"
                        class="fe fe-arrow-right"
                      ></i>
                      <span v-if="loadingPage == false">{{
                        $t("forgot_password.reset_password")
                      }}</span>
                      <clip-loader :loading="loadingPage"></clip-loader>
                    </button>
                  </div>
                </div>
              </form>
              <div class="pt-4">
                <div class="font-weight-normal fs-16">
                  {{ $t("forgot_password.resend.name") }}
                  <span
                    class="btn-link font-weight-normal resend"
                    @click="resendEmail"
                    >{{ $t("forgot_password.resend.back") }}</span
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import Auth from "./../../services/auth";
import Ls from "./../../services/ls";
import ClipLoader from "vue-spinner/src/ClipLoader.vue";
export default {
  data() {
    return {
      email: "",
      loadingPage: false,
      terms: true,
    };
  },
  mounted() {
    this.loadingPage = false;
  },
  components: {
    ClipLoader,
  },
  methods: {
    passwordReset() {
      this.loadingPage = true;
      let resetPasswordData = {
        email: this.email,
      };
      let locale = Ls.get("countryLang");
      Auth.passwordReset(resetPasswordData, locale).then((res) => {
        this.loadingPage = false;
      });
    },
    resendEmail() {
      if (this.email != "") {
        let resendEmailData = {
          first_name: Ls.get("First Name"),
          last_name: Ls.get("Last Name"),
          email: this.email,
        };
        let locale = Ls.get("countryLang");
        Auth.resendEmailVerification(resendEmailData, locale).then((res) => {});
      }
    },
  },
};
</script>
<style scoped>
.password-reset {
  margin-top: 30px;
}
.password-reset h3 {
  color: white;
  text-align: center;
}
.password-reset button {
  margin-top: 25px;
}
.resend {
  cursor: pointer;
}
</style>
<style>
.toast-success {
  /* background-color: #51a351; */
  background-color: #51a351 !important;
}
.toast-info {
  background-color: #2f96b4;
}
.toast-error {
  background-color: #bd362f !important;
}
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
.v-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
}
.current .iti-flag {
  margin-right: 5px;
}
</style>