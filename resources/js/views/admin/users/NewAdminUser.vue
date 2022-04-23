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
      <h3 class="page-title">新增管理员</h3>
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">系统管理</a>
        </li>
        <li class="breadcrumb-item active">新增管理员</li>
      </ol>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <div class="card">
          <div class="card-header">
            <h6>新增管理员</h6>
          </div>
          <div class="card-body">
            <div class="edit-personal-profile">
              <b-form @submit.stop.prevent="addNewMember">
                <div class="user-name-edit">
                  <b-form-group
                    id="name-input-group"
                    label="真实姓名"
                    label-for="name-input"
                  >
                    <b-form-input
                      id="name-input"
                      name="name-input"
                      v-model="addMemberData.name"
                      v-validate="{ required: true, min: 3 }"
                      :state="validateState('name-input')"
                      aria-describedby="name-input-live-feedback"
                      data-vv-as="Name"
                    ></b-form-input>

                    <b-form-invalid-feedback id="name-input-live-feedback">{{
                      veeErrors.first("name-input")
                    }}</b-form-invalid-feedback>
                  </b-form-group>
                </div>

                <div class="username-edit">
                  <b-form-group
                    id="username-input-group"
                    label="用户名"
                    label-for="username-input"
                  >
                    <b-form-input
                      id="username-input"
                      name="username-input"
                      v-model="addMemberData.username"
                      v-validate="{ required: true, min: 3 }"
                      :state="validateState('username-input')"
                      aria-describedby="username-input-live-feedback"
                      data-vv-as="User Name"
                    ></b-form-input>

                    <b-form-invalid-feedback
                      id="username-input-live-feedback"
                      >{{
                        veeErrors.first("username-input")
                      }}</b-form-invalid-feedback
                    >
                  </b-form-group>
                </div>

                <div class="password-edit">
                  <b-form-group
                    id="new-password-input-group"
                    label="密码"
                    label-for="new-password-input"
                  >
                    <b-form-input
                      id="new-password-input"
                      name="new-password-input"
                      v-model="addMemberData.password"
                      v-validate="{ required: true, min: 6 }"
                      :state="validateState('new-password-input')"
                      aria-describedby="new-password-input-live-feedback"
                      data-vv-as="New Password"
                      type="password"
                      ref="new-password-input"
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
                    label="确认密码"
                    label-for="confirm-password-input"
                  >
                    <b-form-input
                      id="confirm-password-input"
                      name="confirm-password-input"
                      v-model="addMemberData.password_confirmation"
                      v-validate="'required|confirmed:new-password-input'"
                      :state="validateState('confirm-password-input')"
                      aria-describedby="confirm-password-input-live-feedback"
                      data-vv-as="new-password-input"
                      type="password"
                    ></b-form-input>

                    <b-form-invalid-feedback
                      id="confirm-password-input-live-feedback"
                      >{{
                        veeErrors.first("confirm-password-input")
                      }}</b-form-invalid-feedback
                    >
                  </b-form-group>
                </div>

                <div class="user-gender-role-edit">
                  <b-form-group
                    id="gender-input-group"
                    label="性別"
                    label-for="gender-input"
                  >
                    <b-form-select
                      id="gender-input"
                      name="gender-input"
                      v-model="addMemberData.gender"
                      v-validate="{ required: true }"
                      :state="validateState('gender-input')"
                      aria-describedby="gender-input-live-feedback"
                      data-vv-as="Gender"
                      :options="genders"
                    ></b-form-select>

                    <b-form-invalid-feedback id="gender-input-live-feedback">{{
                      veeErrors.first("gender-input")
                    }}</b-form-invalid-feedback>
                  </b-form-group>

                  <b-form-group
                    id="role-input-group"
                    label="角色"
                    label-for="role-input"
                  >
                    <b-form-select
                      id="role-input"
                      name="role-input"
                      v-model="addMemberData.role"
                      v-validate="{ required: true }"
                      :state="validateState('role-input')"
                      aria-describedby="role-input-live-feedback"
                      data-vv-as="Role"
                      :options="roles"
                    ></b-form-select>

                    <b-form-invalid-feedback id="role-input-live-feedback">{{
                      veeErrors.first("role-input")
                    }}</b-form-invalid-feedback>
                  </b-form-group>
                </div>

                <div class="id-serial-edit">
                  <b-form-group
                    id="id-input-group"
                    label="身份证号码"
                    label-for="id-input"
                  >
                    <b-form-input
                      id="id-input"
                      name="id-input"
                      v-model="addMemberData.id_number"
                      v-validate="{ required: true, min: 5 }"
                      :state="validateState('id-input')"
                      aria-describedby="id-input-live-feedback"
                      data-vv-as="ID Number"
                    ></b-form-input>

                    <b-form-invalid-feedback id="id-input-live-feedback">{{
                      veeErrors.first("id-input")
                    }}</b-form-invalid-feedback>
                  </b-form-group>

                  <!-- <b-form-group
                    id="serial-input-group"
                    label="序列号"
                    label-for="serial-input"
                  >
                    <b-form-input
                      id="serial-input"
                      name="serial-input"
                      v-model="addMemberData.serial_number"
                      v-validate="{ required: true }"
                      :state="validateState('serial-input')"
                      aria-describedby="serial-input-live-feedback"
                      data-vv-as="Serial Number"
                    ></b-form-input>

                    <b-form-invalid-feedback id="serial-input-live-feedback">{{
                      veeErrors.first("serial-input")
                    }}</b-form-invalid-feedback>
                  </b-form-group> -->
                </div>

                <div class="validiaty_period-edit">
                  <b-form-group
                    id="vp-input-group"
                    label="有效期"
                    label-for="vp-input"
                  >
                    <b-form-datepicker
                      id="vp-input"
                      name="vp-input"
                      :state="validateState('vp-input')"
                      v-validate="{ required: true }"
                      v-model="addMemberData.validity_period"
                      locale="zh"
                      :start-weekday="weekday"
                      :show-decade-nav="showDecadeNav"
                      :hide-header="hideHeader"
                      aria-describedby="vp-input-live-feedback"
                      data-vv-as="Validity Period"
                    ></b-form-datepicker>
                    <b-form-invalid-feedback id="vp-input-live-feedback">{{
                      veeErrors.first("vp-input")
                    }}</b-form-invalid-feedback>
                  </b-form-group>
                </div>

                <div class="company-region-edit">
                  <b-form-group
                    id="company-input-group"
                    label="公司"
                    label-for="company-input"
                    v-if="addMemberData.role == 'regional_admin'"
                  >
                    <b-form-input
                      id="company-input"
                      name="company-input"
                      v-model="addMemberData.company"
                      v-validate="{ required: true }"
                      :state="validateState('company-input')"
                      aria-describedby="company-input-live-feedback"
                      data-vv-as="Company"
                    ></b-form-input>

                    <b-form-invalid-feedback id="company-input-live-feedback">{{
                      veeErrors.first("company-input")
                    }}</b-form-invalid-feedback>
                  </b-form-group>

                  <b-form-group
                    id="region-input-group"
                    label="地区"
                    label-for="region-input"
                    v-if="addMemberData.role == 'regional_admin'"
                  >
                    <b-form-select
                      id="region-input"
                      name="region-input"
                      v-model="addMemberData.region"
                      v-validate="{ required: true }"
                      :state="validateState('region-input')"
                      aria-describedby="region-input-live-feedback"
                      data-vv-as="Region"
                      :options="regions"
                    ></b-form-select>

                    <b-form-invalid-feedback id="region-input-live-feedback">{{
                      veeErrors.first("region-input")
                    }}</b-form-invalid-feedback>
                  </b-form-group>
                </div>

                <div class="verification-health-edit">
                  <b-form-group
                    id="health-input-group"
                    label="健康状况"
                    label-for="health-input"
                  >
                    <b-form-select
                      id="health-input"
                      name="health-input"
                      v-model="addMemberData.health_status"
                      v-validate="{ required: true }"
                      :state="validateState('health-input')"
                      aria-describedby="health-input-live-feedback"
                      data-vv-as="Health Status"
                      :options="healthStatues"
                    ></b-form-select>

                    <b-form-invalid-feedback id="health-input-live-feedback">{{
                      veeErrors.first("health-input")
                    }}</b-form-invalid-feedback>
                  </b-form-group>
                </div>

                <div class="submit-reset">
                  <b-button class="user-info-submit" type="submit">
                    <span v-if="loadingPage == false">确认</span>
                    <clip-loader :loading="loadingPage"></clip-loader>
                  </b-button>
                </div>
              </b-form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <sweet-modal ref="success_modal" icon="success">
      {{ addMemberData.role }} 创建成功！
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
      addMemberData: {
        name: "",
        password: "",
        password_confirmation: "",
        email: "",
        gender: "male",
        role: "regional_admin",
        region: "...",
        id_number: "...",
        serial_number: "...",
        validity_period: "",
        company: "...",
        health_status: "normal",
      },
      genders: [
        { value: "male", text: "男" },
        { value: "female", text: "女" },
      ],
      roles: [],
      healthStatues: [
        { value: "bad", text: "不健康" },
        { value: "normal", text: "普通的" },
        { value: "good", text: "健康" },
      ],
      regions: [],
      weekday: 0,
      weekdays: [
        { value: 0, text: "Sunday" },
        { value: 1, text: "Monday" },
        { value: 6, text: "Saturday" },
      ],
      showDecadeNav: false,
      hideHeader: false,
      loadingPage: false,
    };
  },
  created() {
    this.user_role = Ls.get("Role");
    if (this.user_role == "admin") {
      this.roles = [
        { value: "regional_admin", text: "区域管理员" },
        { value: "admin", text: "系统总管理员" },
      ];
    } else if (this.user_role == "regional_admin") {
      this.roles = [{ value: "regional_admin", text: "区域管理员" }];
    }
    var today = new Date();
    var date =
      today.getFullYear() +
      "-" +
      (today.getMonth() + 1) +
      "-" +
      today.getDate();
    this.addMemberData.validity_period = date;
    this.getAllRegions().then((res) => {
      this.regions = res.map((region) => {
        return {
          value: region.name,
          text: region.name,
        };
      });
    });
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
  methods: {
    getAllRegions() {
      let regions = Auth.getAllRegions().then((res) => {
        return res.data;
      });
      return regions;
    },
    addNewMember() {
      this.$validator.validateAll().then(async (result) => {
        if (!result) {
          return;
        }
        this.loadingPage = true;
        let response = await axios.post("/api/email-exist", {
          username: this.addMemberData.username,
        });
        if (response.data == false) {
          toastr["error"]("用户名已经存在", "输入另一个用户名");
          this.loadingPage = false;
        } else {
          Auth.addNewMemberRegister(this.addMemberData)
            .then((res) => {
              if (res) {
                this.loadingPage = false;
                this.$refs.success_modal.open();
              }
            })
            .catch((error) => {
              console.log("eror => ", error);
              this.loadingPage = false;
            });
        }
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
.id-serial-edit,
.user-gender-role-edit,
.company-region-edit {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: space-between;
}
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