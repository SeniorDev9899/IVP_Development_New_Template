<template>
  <div class="w-80 page-content">
    <div class="page-single-content">
      <div class="card-body p-6">
        <div class="row">
          <div class="col-md-8 mx-auto d-block">
            <div class="password-reset">
              <h3>{{ $t("reset_password.title") }}</h3>
              <div class="form-group">
                <b-form @submit.stop.prevent="passwordReset">
                  <b-form-group
                    id="new-password-input-group"
                    :label="$t('reset_password.new_password')"
                    label-for="new-password-input"
                  >
                    <b-form-input
                      id="new-password-input"
                      name="new-password-input"
                      v-model="user_new_password"
                      v-validate="{ required: true, min: 6 }"
                      :state="validateState('new-password-input')"
                      aria-describedby="new-password-input-live-feedback"
                      data-vv-as="New Password"
                      type="password"
                    ></b-form-input>

                    <b-form-invalid-feedback
                      id="new-password-input-live-feedback"
                      >{{
                        veeErrors.first("new-password-input")
                      }}</b-form-invalid-feedback
                    >
                  </b-form-group>

                  <b-form-group
                    id="confirm-password-input-group"
                    :label="$t('reset_password.confirm_password')"
                    label-for="confirm-password-input"
                  >
                    <b-form-input
                      id="confirm-password-input"
                      name="confirm-password-input"
                      v-model="user_confirm_password"
                      v-validate="{ required: true }"
                      :state="validateState('confirm-password-input')"
                      aria-describedby="confirm-password-input-live-feedback"
                      data-vv-as="confirm-password"
                      type="password"
                    ></b-form-input>

                    <b-form-invalid-feedback
                      id="confirm-password-input-live-feedback"
                      >{{
                        veeErrors.first("confirm-password-input")
                      }}</b-form-invalid-feedback
                    >
                  </b-form-group>
                  <div class="submit-user-password-change">
                    <b-button class="user-info-submit" type="submit">
                      <span v-if="loadingPage == false">{{
                        $t("reset_password.password_reset")
                      }}</span>
                      <clip-loader :loading="loadingPage"></clip-loader>
                    </b-button>
                  </div>
                </b-form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import ClipLoader from "vue-spinner/src/ClipLoader.vue";
export default {
  data() {
    return {
      user_current_password: "",
      user_new_password: "",
      user_confirm_password: "",
      user_id: "",
      loadingPage: false,
    };
  },
  created() {
    this.user_id = this.$route.query.user_id;
    this.loadingPage = false;
  },
  components: {
    ClipLoader,
  },
  methods: {
    passwordReset() {
      let exist = this;
      exist.loadingPage = true;
      this.$validator.validateAll().then((result) => {
        if (!result) {
          return;
        }
        let formData = {
          current_password: this.user_current_password,
          new_password: this.user_new_password,
          confirm_password: this.user_confirm_password,
        };

        axios
          .post(`/api/auth/user/updatePassword/${this.user_id}`, formData)
          .then(function (res) {
            exist.loadingPage = false;
            if (res.data == 1) {
              if (exist.$i18n.locale == "en") {
                window.toastr["success"](
                  "Your password has been changed successfully!",
                  "Success"
                );
              } else if (exist.$i18n.locale == "ch") {
                window.toastr["success"]("你已經成功更改密碼！", "成功");
              }
              exist.$router.push("/login");
            } else if (res.data == 2) {
              if (exist.$i18n.locale == "en") {
                window.toastr["error"](
                  "Please confirm new password again",
                  "Error"
                );
              } else if (exist.$i18n.locale == "ch") {
                window.toastr["error"]("請再次確認新密碼", "錯誤");
              }
            }
          });
      });
    },
    validateState(ref) {
      if (
        this.veeFields[ref] &&
        (this.veeFields[ref].dirty || this.veeFields[ref].validated)
      ) {
        return !this.veeErrors.has(ref);
      }
      return null;
    },
  },
};
</script>
<style scoped>
.password-reset {
  margin-top: 30px;
}
.password-reset h3 {
  color: #5d6164;
  text-align: center;
  font-weight: 700;
}
.password-reset button {
  margin-top: 25px;
}
.user-info-submit {
  margin-right: 20px;
  background-color: #ffde00;
  border-color: #ffde00;
  color: #5c5959;
  width: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.submit-user-password-change {
  display: flex;
  align-items: center;
  justify-content: center;
}
.v-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
<style>
.current .iti-flag {
  margin-right: 5px;
}
</style>