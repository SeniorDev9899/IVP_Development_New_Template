<template>
  <div
    id="all-users"
    :class="
      user_role == 'practitioner' || toggle == true
        ? 'role_practitioner'
        : 'main-content'
    "
  >
    <div class="page-header">
      <h3 class="page-title">{{ $t("settings.region_man") }}</h3>
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">{{ $t("settings.sys_man") }}</a>
        </li>
        <li class="breadcrumb-item active">{{ $t("settings.region_man") }}</li>
      </ol>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <div class="card">
          <div class="card-header">
            <h6>{{ $t("settings.new_region") }}</h6>
          </div>
          <div class="card-body">
            <div class="edit-personal-profile">
              <b-form @submit.stop.prevent="addNewRegion">
                <div class="region-name-edit">
                  <b-form-group
                    id="new-region-name-input"
                    :label="$t('register.region_name')"
                    label-for="new-region-name-input"
                  >
                    <b-form-input
                      id="new-region-name-input"
                      name="new-region-name-input"
                      v-model="newRegionName"
                      v-validate="{ required: true, min: 3 }"
                      :state="validateState('new-region-name-input')"
                      aria-describedby="new-region-name-input-live-feedback"
                      data-vv-as="Region Name"
                    ></b-form-input>

                    <b-form-invalid-feedback
                      id="new-region-name-input-live-feedback"
                      >{{
                        veeErrors.first("new-region-name-input")
                      }}</b-form-invalid-feedback
                    >
                  </b-form-group>
                </div>

                <div class="submit-reset">
                  <b-button class="user-info-submit" type="submit">
                    <span v-if="loadingPage == false">{{
                      $t("settings.create")
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
    <sweet-modal ref="success_modal_region" icon="success">
      {{ $t("users.addRegion.new") }} {{ newRegionName }}
      {{ $t("users.addRegion.added") }}
    </sweet-modal>
  </div>
</template>

<script>
import ClipLoader from "vue-spinner/src/ClipLoader.vue";
import { SweetModal, SweetModalTab } from "sweet-modal-vue";
import Ls from "./../../../services/ls.js";
import Auth from "./../../../services/auth.js";
export default {
  props: ["toggle"],
  data() {
    return {
      user_role: "",
      newRegionName: "",
      loadingPage: false,
    };
  },
  created() {
    this.user_role = Ls.get("Role");
    if (this.user_role == "admin") {
      this.roles = [
        { value: "practitioner", text: "Practitioner" },
        { value: "regional_admin", text: "Regional Admin" },
        { value: "admin", text: "System Admin" },
      ];
    } else if (this.user_role == "regional_admin") {
      this.roles = [
        { value: "practitioner", text: "Practitioner" },
        { value: "regional_admin", text: "Regional Admin" },
      ];
    }
    this.loadingPage = false;
  },
  install(Vue, options) {
    Vue.component("SweetModal", SweetModal);
    Vue.component("SweetModalTab", SweetModalTab);
  },
  components: {
    SweetModal,
    SweetModalTab,
    ClipLoader,
  },
  computed: {
    locale() {
      if (this.$i18n.locale == "en") {
        return "en-US";
      } else if (this.$i18n.locale == "ch") {
        return "zh";
      }
    },
  },
  methods: {
    addNewRegion() {
      this.$validator.validateAll().then((result) => {
        if (!result) {
          return;
        }
        this.loadingPage = true;
        let regionInfo = {
          region_name: this.newRegionName,
        };
        Auth.addNewRegionToDB(regionInfo).then((res) => {
          this.loadingPage = false;
          this.$refs.success_modal_region.open();
          this.$emit("addNewRegion", {
            lang: this.$i18n.locale,
            role: this.user_role,
          });
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
.role_practitioner {
  padding: 35px 30px 0px 105px;
  min-height: calc(100% - 90px);
}
.edit-personal-profile {
  background-color: rgb(240 246 247);
  padding: 10px;
}
.region-name-edit #new-region-name-input {
  width: 100%;
}
.submit-reset {
  display: flex;
  align-items: center;
  justify-content: right;
  flex-direction: row;
  margin-top: 30px;
}
.user-info-submit {
  margin-right: 20px;
  background-color: #ffde00;
  border-color: #ffde00;
  color: #5c5959;
}
</style>