<template>
  <div class="page-profile" :class="myClass">
    <div class="page-header">
      <h3 class="page-title">{{ $t("verification.title") }}</h3>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <div class="card">
          <div class="card-body">
            <tabs class="tabs-default">
              <div class="row">
                <div class="col-sm-3">
                  <div class="avatar-container">
                    <vue-photo-zoom-pro
                      :url="user_picture"
                      :high-url="user_picture"
                    >
                    </vue-photo-zoom-pro>
                  </div>
                </div>
                <div class="col-sm-9">
                  <h2>{{ $t("verification.verification_info") }}</h2>
                  <div class="edit-personal-profile">
                    <b-form @submit.stop.prevent="onSubmit">
                      <div class="user-name-edit">
                        <b-form-group
                          id="first-name-input-group"
                          :label="$t('profile.first_name')"
                          label-for="first-name-input"
                        >
                          <b-form-input
                            id="first-name-input"
                            name="first-name-input"
                            v-model="user_first_name"
                            v-validate="{ required: true, min: 3 }"
                            :state="validateState('first-name-input')"
                            aria-describedby="first-name-input-live-feedback"
                            data-vv-as="Name"
                          ></b-form-input>

                          <b-form-invalid-feedback
                            id="first-name-input-live-feedback"
                            >{{
                              veeErrors.first("first-name-input")
                            }}</b-form-invalid-feedback
                          >
                        </b-form-group>

                        <b-form-group
                          id="last-name-input-group"
                          :label="$t('profile.last_name')"
                          label-for="last-name-input"
                        >
                          <b-form-input
                            id="last-name-input"
                            name="last-name-input"
                            v-model="user_last_name"
                            v-validate="{ required: true, min: 3 }"
                            :state="validateState('last-name-input')"
                            aria-describedby="last-name-input-live-feedback"
                            data-vv-as="Name"
                          ></b-form-input>

                          <b-form-invalid-feedback
                            id="last-name-input-live-feedback"
                            >{{
                              veeErrors.first("last-name-input")
                            }}</b-form-invalid-feedback
                          >
                        </b-form-group>
                      </div>

                      <div class="email-edit">
                        <b-form-group
                          id="email-input-group"
                          :label="$t('profile.email')"
                          label-for="email-input"
                        >
                          <b-form-input
                            id="email-input"
                            name="email-input"
                            v-model="user_email"
                            v-validate="{ required: true, min: 3 }"
                            :state="validateState('email-input')"
                            aria-describedby="email-input-live-feedback"
                            data-vv-as="Name"
                          ></b-form-input>

                          <b-form-invalid-feedback
                            id="email-input-live-feedback"
                            >{{
                              veeErrors.first("email-input")
                            }}</b-form-invalid-feedback
                          >
                        </b-form-group>
                      </div>

                      <div class="id-serial-edit">
                        <b-form-group
                          id="id-input-group"
                          :label="$t('profile.id_number')"
                          label-for="id-input"
                        >
                          <b-form-input
                            id="id-input"
                            name="id-input"
                            v-model="user_id_number"
                            v-validate="{ required: true }"
                            :state="validateState('id-input')"
                            aria-describedby="id-input-live-feedback"
                            data-vv-as="ID Number"
                          ></b-form-input>

                          <b-form-invalid-feedback
                            id="id-input-live-feedback"
                            >{{
                              veeErrors.first("id-input")
                            }}</b-form-invalid-feedback
                          >
                        </b-form-group>
                      </div>

                      <div class="company-region-edit">
                        <b-form-group
                          id="company-input-group"
                          :label="$t('profile.company')"
                          label-for="company-input"
                        >
                          <b-form-input
                            id="company-input"
                            name="company-input"
                            v-model="user_company"
                            v-validate="{ required: true }"
                            :state="validateState('company-input')"
                            aria-describedby="company-input-live-feedback"
                            data-vv-as="Company"
                          ></b-form-input>

                          <b-form-invalid-feedback
                            id="company-input-live-feedback"
                            >{{
                              veeErrors.first("company-input")
                            }}</b-form-invalid-feedback
                          >
                        </b-form-group>

                        <b-form-group
                          id="region-input-group"
                          :label="$t('profile.region')"
                          label-for="region-input"
                          :class="
                            user_role != 'admin'
                              ? 'visibility_show'
                              : 'visibility_hidden'
                          "
                        >
                          <b-form-select
                            id="region-input"
                            name="region-input"
                            v-model="user_region"
                            v-validate="{ required: true }"
                            :state="validateState('region-input')"
                            aria-describedby="region-input-live-feedback"
                            data-vv-as="Region"
                            :options="regions"
                          ></b-form-select>

                          <b-form-invalid-feedback
                            id="region-input-live-feedback"
                            >{{
                              veeErrors.first("region-input")
                            }}</b-form-invalid-feedback
                          >
                        </b-form-group>
                      </div>

                      <div class="submit-reset">
                        <b-button class="user-info-submit" type="submit">{{
                          $t("verification.verify")
                        }}</b-button>
                      </div>
                    </b-form>
                  </div>
                </div>
              </div>
            </tabs>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import VuePhotoZoomPro from "vue-photo-zoom-pro";
import "vue-photo-zoom-pro/dist/style/vue-photo-zoom-pro.css";
import { Tabs, Tab } from "vue-tabs-component";
import Ls from "./../../../services/ls.js";
import Auth from "./../../../services/auth.js";
export default {
  props: ["toggle"],
  data() {
    return {
      user_id: "",
      user_first_name: "",
      user_last_name: "",
      user_email: "",
      user_gender: "",
      user_role: "practitioner",
      user_id_number: "",
      user_serial_number: "",
      user_company: "",
      user_region: "",
      user_picture: "/assets/img/default-user-avatar.jpg",
      user_health_status: "",
      user_verification_result: "",
      user_validity_period: "",
      roles: [
        { value: "practitioner", text: "Practitioner" },
        { value: "regional_admin", text: "Regional Admin" },
        { value: "admin", text: "System Admin" },
      ],
      regions: [],
    };
  },
  components: {
    tabs: Tabs,
    tab: Tab,
    VuePhotoZoomPro,
  },
  async created() {
    this.user_id = this.$route.params.id;
    this.current_user_role = Ls.get("Role");
    this.user_picture = "/assets/img/default-user-avatar.jpg";
    try {
      const response = await axios.get(`/api/admin/user/get/${this.user_id}`);
      this.user_first_name = response.data.user_info[0].first_name;
      this.user_last_name = response.data.user_info[0].last_name;
      this.user_email = response.data.user_info[0].email;
      this.user_gender = response.data.user_info[0].gender;
      this.user_role = response.data.user_info[0].role;
      this.user_id_number = response.data.user_info[0].id_number;
      this.user_serial_number = response.data.user_info[0].serial_number;
      this.user_company = response.data.user_info[0].company;
      this.user_region = response.data.user_info[0].region;
      if (response.data.user_avatar.length !== 0) {
        this.user_picture = response.data.user_avatar[0];
      }
      this.user_health_status = response.data.user_info[0].health_status;
      this.user_verification_result =
        response.data.user_info[0].verification_result;
      this.user_validity_period = response.data.user_info[0].validity_period;
    } catch (error) {
      let exist = this;
      if (error) {
        if (exist.$i18n.locale == "en") {
          window.toastr["error"]("There was an error", "Error");
        } else if (exist.$i18n.locale == "ch") {
          window.toastr["error"]("有一个错误", "错误");
        }
      }
    }
    this.getAllRegions().then((res) => {
      this.regions = res.map((region) => {
        return {
          value: region.name,
          text: region.name,
        };
      });
    });
  },
  computed: {
    myClass() {
      if (this.current_user_role == "practitioner") {
        return "practitioner_content";
      } else if (
        this.current_user_role == "admin" ||
        this.current_user_role == "regional_admin"
      ) {
        if (this.toggle == true) {
          return "role_practitioner";
        } else if (this.toggle == false) {
          return "main-content";
        }
      }
    },
  },
  methods: {
    getAllRegions() {
      let regions = Auth.getAllRegions().then((res) => {
        return res.data;
      });
      return regions;
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
    resetForm() {
      this.user_first_name = "";
      this.user_last_name = "";
      this.user_email = "";
      this.user_gender = "male";
      this.user_role = "practitioner";
      this.user_id_number = "...";
      this.user_serial_number = "...";
      this.user_company = "...";
      this.user_region = "...";
      this.user_health_status = "normal";
      this.user_verification_result = "nonactivated";

      this.$nextTick(() => {
        this.$validator.reset();
      });
    },
    onSubmit() {
      this.$validator.validateAll().then((result) => {
        if (!result) {
          return;
        }

        let formData = {
          first_name: this.user_first_name,
          last_name: this.user_last_name,
          email: this.user_email,
          role: this.user_role,
          gender: this.user_gender,
          id_number: this.user_id_number,
          serial_number: this.user_serial_number,
          company: this.user_company,
          region: this.user_region,
          health_status: this.user_health_status,
        };

        // axios
        //   .post(`/api/admin/user/edit/${this.user_id}`, formData)
        //   .then(function (res) {
        //     Ls.set("First Name", res.data[0].first_name);
        //     Ls.set("Last Name", res.data[0].last_name);
        //     Ls.set("Email", res.data[0].email);
        //     Ls.set("Role", res.data[0].role);
        //     Ls.set("Gender", res.data[0].gender);
        //     window.toastr["success"](
        //       "Your personal information has been changed!",
        //       "Success"
        //     );
        //   });
        if (this.$i18n.locale == "en") {
          window.toastr["success"](
            "Your personal information has been verified successfully!",
            "Success"
          );
        } else if (this.$i18n.locale == "ch") {
          window.toastr["success"]("您的个人信息已成功验证！", "成功");
        }
      });
    },
  },
};
</script>

<style scoped>
.practitioner_content {
  padding: 35px 30px 0px 40px;
  min-height: calc(100% - 90px);
}
.page-profile {
  transition: ease 0.3s all;
}
.role_practitioner {
  padding: 35px 15px 0px 105px;
  min-height: calc(100% - 90px);
}
.avatar-container {
  width: 100%;
  position: relative;
  max-width: 330px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.avatar-container .user-avatar-change {
  position: absolute;
  top: 0px;
  left: 0px;
  height: 100%;
  width: 100%;
  background-color: transparent;
  border-color: transparent;
}
.avatar-container img {
  width: 100%;
  height: 100%;
}
.user-name-edit,
.id-serial-edit,
.user-gender-role-edit,
.company-region-edit {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: space-between;
}
.user-name-edit #first-name-input-group,
.user-name-edit #last-name-input-group,
.user-gender-role-edit #gender-input-group,
.user-gender-role-edit #role-input-group,
.id-serial-edit #serial-input-group,
.company-region-edit #region-input-group,
.company-region-edit #company-input-group {
  width: 48%;
}
.id-serial-edit #id-input-group {
  width: 100%;
}
.submit-reset {
  display: flex;
  align-items: center;
  justify-content: right;
  flex-direction: row;
  margin-top: 15px;
}
.user-info-submit {
  margin-right: 20px;
  background-color: #ffde00;
  border-color: #ffde00;
  color: #5c5959;
}
.user-info-reset {
  background-color: #007bff;
  border-color: #007bff;
  color: white;
}
.edit-personal-profile {
  background-color: rgb(240 246 247);
  padding: 10px;
}
.edit-personal-profile {
  margin-top: 30px;
}
.visibility_hidden {
  visibility: hidden;
}
.visibility_show {
  visibility: visible;
}
</style>
<style>
.img-zoom {
  height: 100% !important;
  width: 100% !important;
}
.vh--outer {
  width: 100% !important;
}
.vh--outer .vh--holder {
  width: 100% !important;
}
.vh--outer .vh--holder picture {
  width: 100% !important;
}
.vh--flex {
  display: block !important;
}
.vh--message {
  padding: 5px !important;
  position: absolute !important;
  left: 15px !important;
  width: 85% !important;
}
.vh--message span {
  display: inline-block !important;
  position: relative !important;
  top: 3px !important;
}
.vue-photo-zoom-pro {
  width: 100%;
}
</style>