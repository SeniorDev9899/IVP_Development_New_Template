<template>
  <div class="page-style1 page-style2 light-mode default-sidebar">
    <div class="language-select">
      <vue-country-code
        @onSelect="onSelect"
        :dropdownOptions="{
          disabledDialCode: true,
        }"
        :onlyCountries="['cn', 'us']"
        :defaultCountry="getCountry"
      >
      </vue-country-code>
    </div>
    <div class="d-md-flex">
      <div class="w-40 bg-style h-100vh page-style">
        <div class="page-content">
          <div class="page-single-content">
            <div>
              <img
                src="/assets/assets/images/brand/logo.png"
                alt="img"
                class="header-brand-img mb-5"
              />
              <span class="header-brand-title">{{ $t("title") }}</span>
            </div>
            <div class="card-body text-white py-5 px-8 text-center">
              <img
                src="/assets/assets/images/png/1.png"
                alt="img"
                class="w-100 mx-auto text-center"
              />
            </div>
          </div>
        </div>
      </div>
      <div class="w-80 page-content">
        <div class="page-single-content">
          <div class="card-body p-6">
            <div class="row">
              <div class="col-md-8 mx-auto d-block">
                <div class="password-reset">
                  <h1 style="text-align: center">
                    {{ $t("emailVerification.title") }}
                  </h1>
                  <div>
                    <div class="context">
                      <p>
                        {{ $t("emailVerification.sent") }}
                        <span style="font-weight: bold">{{
                          getRegisteredEmail
                        }}</span>
                      </p>
                      <p>{{ $t("emailVerification.continue") }}</p>
                      <span>{{ $t("emailVerification.context") }} </span>
                    </div>
                    <div class="resend_verification">
                      <button
                        class="btn btn-primary btn-block"
                        @click="resendEmail"
                      >
                        <span v-if="loadingPage == false">{{
                          $t("emailVerification.resend")
                        }}</span>
                        <clip-loader :loading="loadingPage"></clip-loader>
                      </button>
                    </div>
                    <div class="back-to-signin">
                      <router-link to="/login">{{
                        $t("emailVerification.backToSignIn")
                      }}</router-link>
                    </div>
                  </div>
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
      loadingPage: false,
    };
  },
  mounted() {
    this.loadingPage = false;
  },
  components: {
    ClipLoader,
  },
  computed: {
    getCountry() {
      if (Ls.get("countryLang") != null) {
        return Ls.get("countryLang");
      } else {
        return "CN";
      }
    },
    getRegisteredEmail() {
      return Ls.get("Email");
    },
  },
  methods: {
    onSelect({ name, iso2, dialCode }) {
      if (iso2.toString() == "US") {
        this.$i18n.locale = "en";
        Ls.set("countryLang", iso2.toString());
      } else if (iso2.toString() == "CN") {
        this.$i18n.locale = "ch";
        Ls.set("countryLang", iso2.toString());
      }
    },
    resendEmail() {
      this.loadingPage = true;
      let resendEmailData = {
        first_name: Ls.get("First Name"),
        last_name: Ls.get("Last Name"),
        email: Ls.get("Email"),
      };
      let locale = Ls.get("countryLang");
      Auth.resendEmailVerification(resendEmailData, locale).then((res) => {
        this.loadingPage = false;
      });
    },
  },
};
</script>

<style scoped>
.login-page .logo-main img {
  height: auto;
  width: 120px;
}
.login-page .login-box {
  color: #fff;
  padding: 20px;
  width: 100%;
  max-width: 600px;
}
.login-page .login-box h1 {
  color: white;
  text-align: center;
}
.language-select {
  position: absolute;
  top: 15px;
  right: 190px;
}
.header-brand-title {
  position: absolute;
  top: 33px;
  left: 110px;
  font-size: 20px;
  color: rgb(249 243 243);
  font-weight: 700;
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
.dropdown-list {
  width: 180px !important;
}
.context {
  margin: 0px auto;
  max-width: 510px;
  text-align: center;
  margin-top: 35px;
  margin-bottom: 40px;
}
.context p {
  font-size: 20px;
}
.back-to-signin {
  text-align: center;
  margin-top: 30px;
}
.v-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
}
.vue-country-select {
  position: relative;
  top: 12px !important;
  border: 1px !important;
  box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 8px rgb(102 175 233 / 60%);
}
.vue-country-select .dropdown {
  -webkit-transition: 0.5s ease all;
  transition: 0.5s ease all;
}
.current .iti-flag {
  margin-right: 5px;
}
.vue-country-select:hover {
  border: 1px !important;
  border-radius: 3px;
}
.vue-country-select .dropdown:hover {
  background-color: rgb(105 154 233) !important;
  border-radius: 3px;
}
.vue-country-select .dropdown-list {
  z-index: 6 !important;
}
</style>
