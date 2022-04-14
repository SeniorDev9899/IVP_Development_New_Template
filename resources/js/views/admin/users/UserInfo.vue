<template>
  <div class="row">
    <div class="col-sm-12">
      <div class="card">
        <div class="card-body">
          <tabs class="tabs-default">
            <div class="row">
              <div class="col-sm-2">
                <div class="avatar-container">
                  <img
                    :src="user_picture_sub"
                    alt="Admin Avatar"
                    class="img-fluid"
                  />
                  <form
                    @submit="changeUserAvatar"
                    enctype="multipart/form-data"
                  >
                    <input
                      id="user-avatar"
                      type="file"
                      accept="image/png, image/gif, image/jpeg"
                      class="form-control"
                      v-on:change="onChange"
                      style="display: none"
                    />
                    <button
                      type="submit"
                      class="btn btn-primary btn-block"
                      style="display: none"
                    ></button>
                    <button
                      @click="changeAvatarOccurr"
                      v-tooltip="{
                        content: tooltipText_sub,
                        placement: position + '-center',
                        delay: {
                          show: 200,
                          hide: 300,
                        },
                        classes: ['info'],
                      }"
                      class="user-avatar-change"
                    ></button>
                  </form>
                </div>
                <div class="personal-info"></div>
              </div>
              <div class="col-sm-10">
                <h2>{{ $t("profile.edit_profile") }}</h2>
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
                          v-model="first_name_sub"
                          v-validate="{ required: true, min: 3 }"
                          :state="validateState('first-name-input')"
                          aria-describedby="first-name-input-live-feedback"
                          data-vv-as="First Name"
                          @change="onUpdate('first_name', first_name_sub)"
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
                          v-model="last_name_sub"
                          v-validate="{ required: true, min: 3 }"
                          :state="validateState('last-name-input')"
                          aria-describedby="last-name-input-live-feedback"
                          data-vv-as="Last Name"
                          @change="onUpdate('last_name', last_name_sub)"
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
                          v-model="user_email_sub"
                          v-validate="{ required: true, min: 3 }"
                          :state="validateState('email-input')"
                          aria-describedby="email-input-live-feedback"
                          data-vv-as="Email"
                          @change="onUpdate('email', user_email_sub)"
                        ></b-form-input>

                        <b-form-invalid-feedback
                          id="email-input-live-feedback"
                          >{{
                            veeErrors.first("email-input")
                          }}</b-form-invalid-feedback
                        >
                      </b-form-group>
                    </div>

                    <div class="user-gender-role-edit">
                      <b-form-group
                        id="gender-input-group"
                        :label="$t('profile.gender')"
                        label-for="gender-input"
                      >
                        <b-form-select
                          id="gender-input"
                          name="gender-input"
                          v-model="user_gender_sub"
                          v-validate="{ required: true }"
                          :state="validateState('gender-input')"
                          aria-describedby="gender-input-live-feedback"
                          data-vv-as="Gender"
                          :options="genders"
                          @change="onUpdate('gender', user_gender_sub)"
                        ></b-form-select>

                        <b-form-invalid-feedback
                          id="gender-input-live-feedback"
                          >{{
                            veeErrors.first("gender-input")
                          }}</b-form-invalid-feedback
                        >
                      </b-form-group>

                      <b-form-group
                        id="role-input-group"
                        :label="$t('profile.role')"
                        label-for="role-input"
                        :class="
                          current_user_role == 'practitioner'
                            ? 'visibility_hidden'
                            : 'visibility_show'
                        "
                      >
                        <b-form-select
                          id="role-input"
                          name="role-input"
                          v-model="user_role_sub"
                          v-validate="{ required: true }"
                          :state="validateState('role-input')"
                          aria-describedby="role-input-live-feedback"
                          data-vv-as="Role"
                          :options="roles"
                          @change="onUpdate('role', user_role)"
                        ></b-form-select>

                        <b-form-invalid-feedback
                          id="role-input-live-feedback"
                          >{{
                            veeErrors.first("role-input")
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
                          v-model="user_id_number_sub"
                          v-validate="{ required: true }"
                          :state="validateState('id-input')"
                          aria-describedby="id-input-live-feedback"
                          data-vv-as="ID Number"
                          @change="onUpdate('id_number', user_id_number_sub)"
                        ></b-form-input>

                        <b-form-invalid-feedback id="id-input-live-feedback">{{
                          veeErrors.first("id-input")
                        }}</b-form-invalid-feedback>
                      </b-form-group>

                      <b-form-group
                        id="serial-input-group"
                        :label="$t('profile.serial_number')"
                        label-for="serial-input"
                      >
                        <b-form-input
                          id="serial-input"
                          name="serial-input"
                          v-model="user_serial_number_sub"
                          v-validate="{ required: true }"
                          :state="validateState('serial-input')"
                          aria-describedby="serial-input-live-feedback"
                          data-vv-as="Serial Number"
                          @change="
                            onUpdate('serial_number', user_serial_number_sub)
                          "
                        ></b-form-input>

                        <b-form-invalid-feedback
                          id="serial-input-live-feedback"
                          >{{
                            veeErrors.first("serial-input")
                          }}</b-form-invalid-feedback
                        >
                      </b-form-group>
                    </div>

                    <div class="validiaty_period-edit">
                      <b-form-group
                        id="vp-input-group"
                        :label="$t('profile.validity_period')"
                        label-for="vp-input"
                        :class="
                          current_user_role == 'practitioner'
                            ? 'display_none'
                            : 'display_block'
                        "
                      >
                        <b-form-datepicker
                          id="vp-input"
                          name="vp-input"
                          :state="validateState('vp-input')"
                          v-validate="{ required: true }"
                          v-model="user_validity_period_sub"
                          :locale="locale"
                          :start-weekday="weekday"
                          :show-decade-nav="showDecadeNav"
                          :hide-header="hideHeader"
                          aria-describedby="vp-input-live-feedback"
                          data-vv-as="Validity Period"
                          @input="
                            onUpdate(
                              'validity_period',
                              user_validity_period_sub
                            )
                          "
                        ></b-form-datepicker>
                        <b-form-invalid-feedback id="vp-input-live-feedback">{{
                          veeErrors.first("vp-input")
                        }}</b-form-invalid-feedback>
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
                          v-model="user_company_sub"
                          v-validate="{ required: true }"
                          :state="validateState('company-input')"
                          aria-describedby="company-input-live-feedback"
                          data-vv-as="Company"
                          @change="onUpdate('company', user_company_sub)"
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
                          user_role_sub != 'admin'
                            ? 'visibility_show'
                            : 'visibility_hidden'
                        "
                      >
                        <b-form-select
                          id="region-input"
                          name="region-input"
                          v-model="user_region_sub"
                          v-validate="{ required: true }"
                          :state="validateState('region-input')"
                          aria-describedby="region-input-live-feedback"
                          data-vv-as="Region"
                          :options="regions"
                          @change="onUpdate('region', user_region_sub)"
                        ></b-form-select>

                        <b-form-invalid-feedback
                          id="region-input-live-feedback"
                          >{{
                            veeErrors.first("region-input")
                          }}</b-form-invalid-feedback
                        >
                      </b-form-group>
                    </div>

                    <div class="verification-health-edit">
                      <b-form-group
                        id="health-input-group"
                        :label="$t('profile.health_status')"
                        label-for="health-input"
                      >
                        <b-form-select
                          id="health-input"
                          name="health-input"
                          v-model="user_health_status_sub"
                          v-validate="{ required: true }"
                          :state="validateState('health-input')"
                          aria-describedby="health-input-live-feedback"
                          data-vv-as="Health Status"
                          :options="healthStatues"
                          @change="
                            onUpdate('health_status', user_health_status_sub)
                          "
                        ></b-form-select>

                        <b-form-invalid-feedback
                          id="health-input-live-feedback"
                          >{{
                            veeErrors.first("health-input")
                          }}</b-form-invalid-feedback
                        >
                      </b-form-group>
                    </div>

                    <div class="submit-reset">
                      <b-button class="user-info-submit" type="submit">
                        <span v-if="loadingPage == false">{{
                          $t("profile.save")
                        }}</span>
                        <clip-loader :loading="loadingPage"></clip-loader>
                      </b-button>
                    </div>
                  </b-form>
                </div>
                <h2 style="margin-top: 40px">
                  {{ $t("profile.update_password") }}
                </h2>
                <div class="edit-personal-password">
                  <b-form @submit.stop.prevent="changePassword">
                    <b-form-group
                      id="current-password-input-group"
                      :label="$t('profile.current_password')"
                      label-for="current-password-input"
                    >
                      <b-form-input
                        id="current-password-input"
                        name="current-password-input"
                        v-model="user_current_password"
                        v-validate="{ required: true }"
                        :state="
                          validateStateForPasswordChange(
                            'current-password-input'
                          )
                        "
                        aria-describedby="current-password-input-live-feedback"
                        data-vv-as="Current Password"
                        type="password"
                      ></b-form-input>

                      <b-form-invalid-feedback
                        id="current-password-input-live-feedback"
                        >{{
                          veeErrors.first("current-password-input")
                        }}</b-form-invalid-feedback
                      >
                    </b-form-group>

                    <b-form-group
                      id="new-password-input-group"
                      :label="$t('profile.new_password')"
                      label-for="new-password-input"
                    >
                      <b-form-input
                        id="new-password-input"
                        name="new-password-input"
                        v-model="user_new_password"
                        v-validate="{ required: true, min: 6 }"
                        :state="
                          validateStateForPasswordChange('new-password-input')
                        "
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
                      :label="$t('profile.confirm_password')"
                      label-for="confirm-password-input"
                    >
                      <b-form-input
                        id="confirm-password-input"
                        name="confirm-password-input"
                        v-model="user_confirm_password"
                        v-validate="{ required: true }"
                        :state="
                          validateStateForPasswordChange(
                            'confirm-password-input'
                          )
                        "
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
                        <span v-if="loadingPagePass == false">{{
                          $t("profile.save")
                        }}</span>
                        <clip-loader :loading="loadingPagePass"></clip-loader>
                      </b-button>
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
</template>

<script>
import Datepicker from "vuejs-datepicker";
import ClipLoader from "vue-spinner/src/ClipLoader.vue";
import Ls from "./../../../services/ls.js";
import { Tabs, Tab } from "vue-tabs-component";
import Auth from "./../../../services/auth.js";
export default {
  props: [
    "user_id",
    "user_picture",
    "user_first_name",
    "user_last_name",
    "user_email",
    "user_gender",
    "current_user_role",
    "user_role",
    "user_id_number",
    "user_serial_number",
    "user_validity_period",
    "user_company",
    "user_region",
    "user_health_status",
    "current_user_verification_status",
    "tooltipText",
    "current_user_id",
  ],
  watch: {
    user_id: function (newVal, oldVal) {
      this.user_id_sub = newVal;
    },
    tooltipText: function (newVal, oldVal) {
      this.tooltipText_sub = newVal;
    },
    user_picture: function (newVal, oldval) {
      this.user_picture_sub = newVal;
    },
    user_first_name: function (newVal, oldVal) {
      this.first_name_sub = newVal;
    },
    user_last_name: function (newVal, oldVal) {
      this.last_name_sub = newVal;
    },
    user_email: function (newVal, oldVal) {
      this.user_email_sub = newVal;
    },
    user_gender: function (newVal, oldVal) {
      this.user_gender_sub = newVal;
    },
    user_role: function (newVal, oldVal) {
      this.user_role_sub = newVal;
    },
    user_id_number: function (newVal, oldVal) {
      this.user_id_number_sub = newVal;
    },
    user_serial_number: function (newVal, oldVal) {
      this.user_serial_number_sub = newVal;
    },
    user_validity_period: function (newVal, oldVal) {
      this.user_validity_period_sub = newVal;
    },
    user_company: function (newVal, oldVal) {
      this.user_company_sub = newVal;
    },
    user_region: function (newVal, oldVal) {
      this.user_region_sub = newVal;
    },
    user_health_status: function (newVal, oldVal) {
      this.user_health_status_sub = newVal;
    },
  },
  data() {
    return {
      user_picture_sub: "",
      position: "bottom",
      first_name_sub: "",
      last_name_sub: "",
      user_email_sub: "",
      user_gender_sub: "",
      user_role_sub: "",
      user_id_number_sub: "",
      user_serial_number_sub: "",
      user_validity_period_sub: "",
      user_company_sub: "",
      user_region_sub: "",
      current_user_verification_status_sub: "",
      tooltipText_sub: null,
      user_id_sub: "",
      current_user_id_sub: "",
      originalData: null,
      keepUserInfo: "",
      roles: [
        { value: "practitioner", text: "Practitioner" },
        { value: "regional_admin", text: "Regional Admin" },
        { value: "admin", text: "System Admin" },
      ],
      regions: [],
      healthStatues: [
        { value: "bad", text: "Bad" },
        { value: "normal", text: "Normal" },
        { value: "good", text: "Good" },
      ],
      genders: [
        { value: "male", text: "Male" },
        { value: "female", text: "Female" },
      ],
      loadingPage: false,
      loadingPagePass: false,
      user_current_password: "......",
      user_new_password: "......",
      user_confirm_password: "......",
      img: "",
      weekday: 0,
      weekdays: [
        { value: 0, text: "Sunday" },
        { value: 1, text: "Monday" },
        { value: 6, text: "Saturday" },
      ],
      showDecadeNav: false,
      hideHeader: false,
    };
  },
  components: {
    tabs: Tabs,
    tab: Tab,
    ClipLoader,
    Datepicker,
  },
  created() {
    this.user_id_sub = this.user_id;
    this.current_user_id_sub = this.current_user_id;
    this.user_picture_sub = this.user_picture;
    this.first_name_sub = this.user_first_name;
    this.last_name_sub = this.user_last_name;
    this.user_email_sub = this.user_email;
    this.user_gender_sub = this.user_gender;
    this.user_role_sub = this.user_role;
    this.user_id_number_sub = this.user_id_number;
    this.user_serial_number_sub = this.user_serial_number;
    if (this.user_validity_period != "...") {
      this.user_validity_period_sub = this.user_validity_period;
    } else {
      var today = new Date();
      var date =
        today.getFullYear() +
        "-" +
        (today.getMonth() + 1) +
        "-" +
        today.getDate();
      this.user_validity_period_sub = date;
    }
    this.user_company_sub = this.user_company;
    this.user_region_sub = this.user_region;
    this.user_health_status_sub = this.user_health_status;
    this.current_user_verification_status_sub =
      this.current_user_verification_status;
    this.tooltipText_sub = this.tooltipText;
    this.loadingPage = false;

    this.originalData = {
      first_name: this.first_name_sub,
      last_name: this.last_name_sub,
      email: this.user_email_sub,
      gender: this.user_gender_sub,
      role: this.user_role_sub,
      id_number: this.user_id_number_sub,
      serial_number: this.user_serial_number_sub,
      company: this.user_company_sub,
      region: this.user_region_sub,
      picture: this.user_picture_sub,
      health_status: this.user_health_status_sub,
      verification_status: this.current_user_verification_status_sub,
      validity_period: this.user_validity_period_sub,
    };
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
    locale() {
      if (this.$i18n.locale == "en") {
        return "en-US";
      } else if (this.$i18n.locale == "ch") {
        return "zh";
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
    onChange(e) {
      this.img = e.target.files[0];
      if (this.img !== "") {
        this.changeUserAvatar(e);
      }
    },
    setUserAvatar(path) {
      this.user_picture_sub = path;
      this.$emit("userAvatarChange", this.user_picture_sub);
    },
    changeUserAvatar(e) {
      let exist = this;
      e.preventDefault();
      const config = {
        headers: {
          "content-type": "multipart/form-data",
        },
      };
      let formData = new FormData();
      formData.append("user_img", this.img);
      formData.append("user_id", this.user_id_sub);
      if (formData.getAll("user_img")[0] !== "") {
        axios
          .post("/api/admin/user/changeUserAvatar", formData, config)
          .then(function (res) {
            if (Array.isArray(res.data) && res.data.length !== 0) {
              Ls.set("user_avatar", res.data[0].path);
              exist.setUserAvatar(res.data[0].path);
            } else {
              Ls.set("user_avatar", res.data.path);
              exist.setUserAvatar(res.data.path);
            }
            if (exist.$i18n.locale == "en") {
              window.toastr["success"](
                "The user avatar has been changed!",
                "Success"
              );
            } else if (exist.$i18n.locale == "ch") {
              window.toastr["success"]("用戶頭像已更改！", "成功");
            }
          });
      }
      this.img = "";
    },
    changeAvatarOccurr() {
      document.getElementById("user-avatar").click();
    },
    onSubmit() {
      let exist = this;
      exist.loadingPage = true;
      this.$validator.validateAll().then((result) => {
        if (!result) {
          return;
        }

        let formData = {
          first_name: exist.first_name_sub,
          last_name: exist.last_name_sub,
          email: exist.user_email_sub,
          role: exist.user_role_sub,
          gender: exist.user_gender_sub,
          id_number: exist.user_id_number_sub,
          serial_number: exist.user_serial_number_sub,
          validity_period: exist.user_validity_period_sub,
          company: exist.user_company_sub,
          region: exist.user_region_sub,
          health_status: exist.user_health_status_sub,
        };

        this.originalData.first_name = formData.first_name;
        this.originalData.last_name = formData.last_name;
        this.originalData.email = formData.email;
        this.originalData.gender = formData.gender;
        this.originalData.role = formData.role;
        this.originalData.id_number = formData.id_number;
        this.originalData.serial_number = formData.serial_number;
        this.originalData.company = formData.company;
        this.originalData.region = formData.region;
        this.originalData.health_status = formData.health_status;
        this.originalData.validity_period = formData.validity_period;

        axios
          .post(`/api/admin/user/edit/${exist.user_id_sub}`, formData)
          .then(function (res) {
            exist.loadingPage = false;
            let qr_text = JSON.stringify({
              first_name: exist.first_name_sub,
              last_name: exist.last_name_sub,
              email: exist.user_email_sub,
              role: exist.user_role_sub,
              id_number: exist.user_id_number_sub,
              serial_number: exist.user_serial_number_sub,
              company: exist.user_company_sub,
              region: exist.user_region_sub,
              health_status: exist.user_health_status_sub,
              validity_period: exist.user_validity_period_sub,
            });
            exist.$emit("produceQR", qr_text);
            if (exist.user_id_sub == exist.current_user_id_sub) {
              Ls.set("First Name", res.data[0].first_name);
              Ls.set("Last Name", res.data[0].last_name);
              Ls.set("Email", res.data[0].email);
              Ls.set("Role", res.data[0].role);
              Ls.set("Gender", res.data[0].gender);
            }
            if (exist.$i18n.locale == "en") {
              window.toastr["success"](
                "Your personal information has been changed!",
                "Success"
              );
            } else if (exist.$i18n.locale == "ch") {
              window.toastr["success"]("您的個人信息已被更改！", "成功");
            }
          });
      });
      if (exist.keepUserInfo != "") {
        exist.submitKeepInfo();
      }
    },
    produceKeepInfo(type, value) {
      var today = new Date();
      var date =
        today.getFullYear() +
        "-" +
        (today.getMonth() + 1) +
        "-" +
        today.getDate();
      var time =
        today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
      let info = {
        time: date + " " + time,
        type: type,
        result: value,
      };
      let strInfo = JSON.stringify(info);
      if (this.keepUserInfo == "") {
        this.keepUserInfo = strInfo;
      } else {
        let parseArray = this.keepUserInfo.split("/");
        let keep = parseArray;
        parseArray.forEach((item, index) => {
          if (item != "") {
            let parsedItem = JSON.parse(item);
            if (parsedItem.type == type) {
              keep.splice(index, 1);
            }
          }
        });
        this.keepUserInfo = "";
        keep.forEach((item) => {
          if (this.keepUserInfo == "") {
            this.keepUserInfo = item;
          } else {
            this.keepUserInfo += "/" + item;
          }
        });
        this.keepUserInfo += "/" + strInfo;
      }
    },
    onUpdate(type, value) {
      if (value != this.originalData[`${type}`]) {
        this.produceKeepInfo(type, value);
      } else if (value == this.originalData[`${type}`]) {
        let parseArray = this.keepUserInfo.split("/");
        let keep = parseArray;
        parseArray.forEach((item, index) => {
          if (item != "") {
            let parsedItem = JSON.parse(item);
            if (parsedItem.type == type) {
              keep.splice(index, 1);
            }
          }
        });
        this.keepUserInfo = "";
        keep.forEach((item) => {
          if (this.keepUserInfo == "") {
            this.keepUserInfo = item;
          } else {
            this.keepUserInfo += "/" + item;
          }
        });
      }
    },
    submitKeepInfo() {
      Auth.keepRemarkInformation(this.user_id_sub, {
        info: this.keepUserInfo,
      }).then((res) => {
        this.keepUserInfo = "";
        this.$emit("updateKeepUserInfo", this.user_id_sub);
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
    validateStateForPasswordChange(ref) {
      if (
        this.veeFields[ref] &&
        (this.veeFields[ref].dirty || this.veeFields[ref].validated)
      ) {
        return !this.veeErrors.has(ref);
      }
      return null;
    },
    changePassword() {
      let exist = this;
      exist.loadingPagePass = true;
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
          .post(`/api/admin/user/updatePassword/${this.user_id_sub}`, formData)
          .then(function (res) {
            exist.loadingPagePass = false;
            if (res.data == 1) {
              exist.produceKeepInfo("password", formData.new_password);
              if (exist.keepUserInfo != "") {
                exist.submitKeepInfo();
              }
              if (exist.$i18n.locale == "en") {
                window.toastr["success"](
                  "Your password has been changed successfully!",
                  "Success"
                );
              } else if (exist.$i18n.locale == "ch") {
                window.toastr["success"]("你已經成功更改密碼！", "成功");
              }
            } else if (res.data == 3) {
              if (exist.$i18n.locale == "en") {
                window.toastr["error"](
                  "Your current password is not correct",
                  "Error"
                );
              } else if (exist.$i18n.locale == "ch") {
                window.toastr["error"]("您當前的密碼不正確", "錯誤");
              }
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
    doSomethingInParentComponentFunction(e) {
      console.log("Selected => ", e);
    },
    datepickerOpenedFunction(e) {
      console.log("Opened => ", e);
    },
    datepickerClosedFunction(e) {
      console.log("Closed => ", e);
    },
  },
};
</script>

<style scoped>
.avatar-container {
  width: 100%;
  position: relative;
  max-width: 330px;
  height: 225px;
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
.personal-info {
  margin-top: 30px;
  padding: 0px 5px;
}
.edit-personal-profile,
.edit-personal-password {
  background-color: rgb(240 246 247);
  padding: 10px;
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
.id-serial-edit #id-input-group,
.id-serial-edit #serial-input-group,
.company-region-edit #region-input-group,
.company-region-edit #company-input-group {
  width: 48%;
}
.submit-reset {
  display: flex;
  align-items: center;
  justify-content: left;
  flex-direction: row;
  margin-top: 30px;
}
.user-info-submit {
  margin-right: 20px;
  background-color: #ffde00;
  border-color: #ffde00;
  color: #5c5959;
}
.display_block {
  display: block;
}
.display_none {
  display: none;
}
.visibility_show {
  visibility: visible;
}
.visibility_hidden {
  visibility: hidden;
}
</style>

<style>
.v-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
