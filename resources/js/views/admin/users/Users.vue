<template>
  <div
    id="all-users"
    :class="
      user_role == 'practitioner' || toggle == true
        ? 'role_practitioner'
        : 'main-content'
    "
  >
    <!-- Users Page Header  -->

    <div class="page-header">
      <h3 class="page-title">{{ $t("users.users") }}</h3>
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">{{ $t("users.home") }}</a>
        </li>
        <li class="breadcrumb-item active">{{ $t("users.users") }}</li>
      </ol>

      <!-- User Actions for Add New Member, Add New Role, Delete All Users -->

      <div class="page-actions">
        <!-- Action for Add New Region Name  -->

        <!-- Action for Add New Region Name  -->

        <!-- <button class="btn btn-danger" @click="deleteAllUser">
          <i class="icon-fa icon-fa-trash" /> {{ $t("users.delete") }}
        </button> -->
      </div>

      <!-- Users Actions for Add New Member, Add New Role, Delete All Users  -->
    </div>

    <!-- Users Page Header  -->

    <div class="row">
      <div class="col-sm-12">
        <div class="card">
          <div class="card-header">
            <h6>{{ $t("users.all_users") }}</h6>
            <div class="card-actions" />
          </div>
          <div class="card-body">
            <!-- Users Query Conditions Group  -->

            <div class="query-group">
              <b-form-select
                id="gender-input"
                name="gender-input"
                v-model="member_gender"
                :options="memberGenders"
                @change="changeMemberProperty"
              ></b-form-select>
              <b-form-select
                id="verification-result-input"
                name="verification-result-input"
                v-model="member_verification_result"
                :options="verificationResults"
                @change="changeMemberProperty"
              ></b-form-select>
              <b-form-select
                id="health-status-input"
                name="health-status-input"
                v-model="member_health_status"
                :options="healthStatues"
                @change="changeMemberProperty"
              ></b-form-select>
              <b-form-select
                id="company-input"
                name="company-input"
                v-model="member_company"
                :options="companies"
                @change="changeMemberProperty"
              ></b-form-select>
              <b-form-select
                id="region-input"
                name="region-input"
                v-model="member_region"
                :options="regions"
                @change="changeMemberProperty"
              ></b-form-select>
              <b-form-input
                id="serial-input_query"
                name="serial-input"
                v-model="member_serial"
                :placeholder="serial_placeholder"
                data-vv-as="Serial Number"
                @change="changeMemberProperty"
              ></b-form-input>
            </div>

            <!-- Users Query Conditions Group  -->

            <table-component
              :data="getUsers"
              sort-by="full_name"
              sort-order="desc"
              table-class="table"
              ref="table"
            >
              <table-column
                show="full_name"
                :label="$t('users.table.full_name')"
              >
                <template slot-scope="row">
                  <div class="user-profile-name">
                    <span>{{ row.first_name }}</span>
                    <span>{{ row.last_name }}</span>
                  </div>
                </template>
              </table-column>
              <table-column
                :sortable="false"
                :filterable="false"
                :label="$t('users.table.user_avatar')"
              >
                <template slot-scope="row">
                  <div class="user-profile-avatar">
                    <img :src="row.user_avatar" />
                  </div>
                </template>
              </table-column>
              <table-column :label="$t('users.table.gender')">
                <template slot-scope="row">
                  <div class="user-gender">
                    <span v-if="row.gender == 'male'">{{
                      $t("users.male")
                    }}</span>
                    <span v-if="row.gender == 'female'">{{
                      $t("users.female")
                    }}</span>
                  </div>
                </template>
              </table-column>
              <table-column :label="$t('users.table.email')">
                <template slot-scope="row">
                  <div class="user-email">
                    <div v-if="row.email_verification_status == 0">
                      <span>{{ row.email }}</span
                      ><i
                        class="fa fa-exclamation-triangle"
                        aria-hidden="true"
                        v-tooltip="{
                          content: tooltipText,
                          placement: position + '-center',
                          delay: {
                            show: 200,
                            hide: 300,
                          },
                          classes: ['info'],
                        }"
                      ></i>
                    </div>
                    <div v-if="row.email_verification_status == 1">
                      {{ row.email }}
                    </div>
                  </div>
                </template>
              </table-column>
              <table-column :label="$t('users.table.role')">
                <template slot-scope="row">
                  <div class="user-role">
                    <span v-if="row.role == 'practitioner'">{{
                      $t("users.practitioner")
                    }}</span>
                    <span v-if="row.role == 'regional_admin'">{{
                      $t("users.regional_admin")
                    }}</span>
                    <span v-if="row.role == 'admin'">{{
                      $t("users.admin")
                    }}</span>
                  </div>
                </template>
              </table-column>
              <table-column
                show="id_number"
                :label="$t('users.table.id_number')"
              />
              <table-column
                show="serial_number"
                :label="$t('users.table.serial_number')"
              />
              <table-column
                show="validity_period"
                :label="$t('users.table.validity_period')"
              />
              <table-column show="company" :label="$t('users.table.company')" />
              <table-column show="region" :label="$t('users.table.region')" />
              <table-column
                show="verification_result"
                :label="$t('users.table.verification_result')"
              >
                <template slot-scope="row">
                  <div class="user-verification-status">
                    <span v-if="row.verification_result == 'nonactivated'">{{
                      $t("users.nonactivated")
                    }}</span>
                    <span v-if="row.verification_result == 'processing'">{{
                      $t("users.processing")
                    }}</span>
                    <span v-if="row.verification_result == 'activated'">{{
                      $t("users.activated")
                    }}</span>
                  </div>
                </template>
              </table-column>
              <table-column :label="$t('users.table.health_status')">
                <template slot-scope="row">
                  <div class="user-health-status">
                    <span v-if="row.health_status == 'bad'">{{
                      $t("users.bad")
                    }}</span>
                    <span v-if="row.health_status == 'normal'">{{
                      $t("users.normal")
                    }}</span>
                    <span v-if="row.health_status == 'good'">{{
                      $t("users.good")
                    }}</span>
                  </div>
                </template>
              </table-column>
              <table-column :sortable="false" :filterable="false" label="">
                <template slot-scope="row">
                  <div class="table__actions">
                    <router-link :to="'/admin/users/profile/' + row.id">
                      <a class="btn btn-default btn-sm">
                        <i class="icon-fa icon-fa-edit" />
                        {{ $t("users.table.action.edit") }}
                      </a>
                    </router-link>
                    <a
                      class="btn btn-default btn-sm"
                      data-delete
                      data-confirmation="notie"
                      @click="deleteUser(row.id)"
                    >
                      <i class="icon-fa icon-fa-trash" />
                      {{ $t("users.table.action.delete") }}
                    </a>
                  </div>
                </template>
              </table-column>
            </table-component>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { TableComponent, TableColumn } from "vue-table-component";
import Ls from "./../../../services/ls.js";
import Auth from "./../../../services/auth.js";
export default {
  props: ["toggle", "lang", "emittedRegionAdd"],
  components: {
    TableComponent,
    TableColumn,
  },
  data() {
    return {
      page_number: "",
      users: [],
      user_role: "",
      user_id: "",
      user_region: "",
      save: false,
      keys: [
        "first_name",
        "last_name",
        "email",
        "role",
        "gender",
        "id_number",
        "serial_number",
        "company",
        "region",
        "health_status",
      ],
      memberGenders: null,
      member_gender: "",
      verificationResults: null,
      member_verification_result: "",
      healthStatues: null,
      member_health_status: "",
      member_company: "",
      member_region: "",
      serial_placeholder: "",
      member_serial: "",
      companies: null,
      availableRegions: [],
      regions: null,
      tooltipText: null,
      position: "top",
    };
  },
  watch: {
    lang: function (newVal, oldVal) {
      let role = Ls.get("Role");
      let region_name = Ls.get("Region Name");
      if (newVal == "en") {
        let lang = "en";
        this.setRegionWithLangRole(lang, role, region_name);
      } else if (newVal == "ch") {
        let lang = "ch";
        this.setRegionWithLangRole(lang, role, region_name);
      }
    },
    emittedRegionAdd: function (newVal, oldVal) {
      if (newVal != "") {
        let parsedObject = JSON.parse(newVal);
        if (parsedObject.lang == "en") {
          let lang = "en";
          let role = parsedObject.role;
          let regionName = Ls.get("Region Name");
          this.setRegionWithLangRole(lang, role, regionName);
        }
      }
    },
  },
  created() {
    this.user_id = Ls.get("user_id");
    this.user_role = Ls.get("Role");
    this.user_region = Ls.get("Region Name");
    if (this.$i18n.locale == "en") {
      let lang = "en";
      this.setRegionWithLangRole(lang, this.user_role, this.user_region);
    } else if (this.$i18n.locale == "ch") {
      let lang = "ch";
      this.setRegionWithLangRole(lang, this.user_role, this.user_region);
    }
  },
  methods: {
    setRegionWithLangRole(lang, role, region = "") {
      this.getAllRegions().then((res) => {
        if (role == "admin") {
          this.availableRegions = res;
        } else if (role == "regional_admin") {
          this.availableRegions = res.filter((item) => item.name == region);
        }
        if (this.availableRegions.length != 0) {
          if (lang == "en") {
            this.setEn();
          } else if (lang == "ch") {
            this.setCh();
          }
        }
      });
    },
    getAllRegions() {
      let regions = Auth.getAllRegions().then((res) => {
        return res.data;
      });
      return regions;
    },
    async getUsers({ page, filter, sort }) {
      this.page_number = page;
      try {
        var response;
        if (this.user_role == "admin") {
          response = await axios.get(`/api/admin/users/get?page=${page}`);
        } else if (this.user_role == "regional_admin") {
          response = await axios.get(
            `/api/admin/users/get/${this.user_region}?page=${page}`
          );
        }
        const avatarResponse = await axios.get("/api/admin/user/avatar/getAll");
        var pagination_data = [];
        let exist = this;
        response.data.data.forEach((user_item, i) => {
          if (
            user_item.id != this.user_id &&
            user_item.role != this.user_role
          ) {
            exist.save = false;
            avatarResponse.data.forEach((avatar_item, j) => {
              let data = user_item;
              if (user_item.id == avatar_item.user_id) {
                exist.save = true;
                data["user_avatar"] = avatar_item.path;
                pagination_data.unshift(data);
              }
            });
            if (exist.save == false) {
              let data = user_item;
              data["user_avatar"] = "/assets/img/default-user-avatar.jpg";
              pagination_data.unshift(data);
            }
          }
        });
        var return_data = [];
        if (filter) {
          pagination_data.forEach((item, index) => {
            exist.keys.forEach((key) => {
              if (item[key].includes(filter)) {
                return_data.push(item);
              }
            });
          });
          return_data = exist.removeDuplicates(return_data);
        } else {
          return_data = pagination_data;
        }
        if (sort) {
          if (sort.order == "desc") {
            if (sort.fieldName == "full_name") {
              return_data.sort(exist.dynamicSortDesc("first_name"));
            } else {
              return_data.sort(exist.dynamicSortDesc(sort.fieldName));
            }
          } else if (sort.order == "asc") {
            if (sort.fieldName == "full_name") {
              return_data.sort(exist.dynamicSortAsc("first_name"));
            } else {
              return_data.sort(exist.dynamicSortAsc(sort.fieldName));
            }
          }
        }
        let filteringData = return_data;
        if (exist.member_gender !== "") {
          let genderedData = [];
          filteringData.forEach((item, index) => {
            if (item["gender"] == exist.member_gender) {
              genderedData.push(item);
            }
          });
          filteringData = genderedData;
        }
        if (exist.member_verification_result !== "") {
          let verifiedData = [];
          filteringData.forEach((item, index) => {
            if (
              item["verification_result"] == exist.member_verification_result
            ) {
              verifiedData.push(item);
            }
          });
          filteringData = verifiedData;
        }
        if (exist.member_health_status !== "") {
          let healthedData = [];
          filteringData.forEach((item, index) => {
            if (item["health_status"] == exist.member_health_status) {
              healthedData.push(item);
            }
          });
          filteringData = healthedData;
        }
        if (exist.member_company !== "") {
          let companiedData = [];
          filteringData.forEach((item, index) => {
            if (item["company"] == exist.member_company) {
              companiedData.push(item);
            }
          });
          filteringData = companiedData;
        }
        if (exist.member_region !== "") {
          let regionalData = [];
          filteringData.forEach((item, index) => {
            if (item["region"] == exist.member_region) {
              regionalData.push(item);
            }
          });
          filteringData = regionalData;
        }
        if (exist.member_serial != "") {
          filteringData = filteringData.filter(
            (item) => item.serial_number == exist.member_serial
          );
        }
        return {
          data: filteringData,
          pagination: {
            totalPages: response.data.last_page,
            currentPage: page,
            count: response.data.to,
          },
        };
      } catch (error) {
        if (error) {
          window.toastr["error"]("There was an error", "Error");
        }
      }
    },
    deleteUser(id) {
      let self = this;
      if (self.$i18n.locale == "en") {
        window.notie.confirm({
          text: "Are you sure to delete this user?",
          cancelCallback: function () {
            window.toastr["info"]("Cancel");
          },
          submitCallback: function () {
            self.deleteUserData(id);
          },
        });
      } else if (self.$i18n.locale == "ch") {
        window.notie.confirm({
          text: "您確定要刪除此用戶嗎？",
          cancelCallback: function () {
            window.toastr["info"]("取消");
          },
          submitCallback: function () {
            self.deleteUserData(id);
          },
        });
      }
    },
    async deleteUserData(id) {
      try {
        let response = await window.axios.delete("/api/admin/users/" + id);
        this.users = response.data;
        this.$refs.table.refresh();
        if (this.$i18n.locale == "en") {
          window.toastr["success"]("User Deleted", "Success");
        } else if (this.$i18n.locale == "ch") {
          window.toastr["success"]("用戶已刪除", "成功");
        }
      } catch (error) {
        if (error) {
          if (this.$i18n.locale == "en") {
            window.toastr["error"]("There was an error", "Error");
          } else if (this.$i18n.locale == "ch") {
            window.toastr["error"]("有一個錯誤", "錯誤");
          }
        }
      }
    },
    deleteAllUser() {
      let self = this;
      if (self.$i18n.locale == "en") {
        window.notie.confirm({
          text: "Are you sure to delete all members ?",
          cancelCallback: function () {
            window.toastr["info"]("Cancel");
          },
          submitCallback: function () {
            self.deleteAllUserData();
          },
        });
      } else if (self.$i18n.locale == "ch") {
        window.notie.confirm({
          text: "您確定要刪除所有成員嗎？",
          cancelCallback: function () {
            window.toastr["info"]("取消");
          },
          submitCallback: function () {
            self.deleteAllUserData();
          },
        });
      }
    },
    async deleteAllUserData() {
      try {
        let response = await window.axios.delete("api/admin/users/all");
        if (this.$i18n.locale == "en") {
          window.toastr["success"]("All Users Deleted", "Success");
        } else if (this.$i18n.locale == "ch") {
          window.toastr["success"]("已刪除所有用戶", "成功");
        }
      } catch (error) {
        if (error) {
          if (this.$i18n.locale == "en") {
            window.toastr["error"]("There was an error", "Error");
          } else if (this.$i18n.locale == "ch") {
            window.toastr["error"]("有一個錯誤", "錯誤");
          }
        }
      }
    },
    removeDuplicates(arr) {
      return arr.filter((item, index) => arr.indexOf(item) === index);
    },
    dynamicSortDesc(property) {
      var sortOrder = 1;
      if (property[0] === "-") {
        sortOrder = -1;
        property = property.substr(1);
      }
      return function (a, b) {
        /* next line works with strings and numbers,
         * and you may want to customize it to your needs
         */
        var result =
          a[property] < b[property] ? -1 : a[property] > b[property] ? 1 : 0;
        return result * sortOrder;
      };
    },
    dynamicSortAsc(property) {
      var sortOrder = 1;
      if (property[0] === "-") {
        sortOrder = -1;
        property = property.substr(1);
      }
      return function (a, b) {
        /* next line works with strings and numbers,
         * and you may want to customize it to your needs
         */
        var result =
          a[property] < b[property] ? 1 : a[property] > b[property] ? -1 : 0;
        return result * sortOrder;
      };
    },
    changeMemberProperty(e) {
      this.$refs.table.refresh();
    },
    setRegions(lang) {
      let exist = this;
      if (lang == "en") {
        exist.regions = [{ value: "", text: "Select Region" }];
      } else {
        exist.regions = [{ value: "", text: "選擇地區" }];
      }
      exist.availableRegions.forEach((region) => {
        exist.regions.push({
          value: region.name,
          text: region.name,
        });
      });
    },
    setEn() {
      this.memberGenders = [
        { value: "", text: "Select Gender" },
        { value: "male", text: "Male" },
        { value: "female", text: "Female" },
      ];
      this.verificationResults = [
        { value: "", text: "Select Verification Result" },
        { value: "nonactivated", text: "Not Activated" },
        { value: "processing", text: "Processing" },
        { value: "activated", text: "Activated" },
      ];
      this.healthStatues = [
        { value: "", text: "Select Health Status" },
        { value: "good", text: "Good" },
        { value: "normal", text: "Normal" },
        { value: "bad", text: "Bad" },
      ];
      this.companies = [
        { value: "", text: "Select Company" },
        { value: "...", text: "..." },
        { value: "...", text: "..." },
        { value: "...", text: "..." },
      ];
      this.serial_placeholder = "Input Serial Number";
      this.setRegions("en");
      this.tooltipText = "Not verified yet";
    },
    setCh() {
      this.memberGenders = [
        { value: "", text: "選擇性別" },
        { value: "male", text: "男性" },
        { value: "female", text: "女性" },
      ];
      this.verificationResults = [
        { value: "", text: "選擇驗證結果" },
        { value: "nonactivated", text: "沒有激活" },
        { value: "processing", text: "加工" },
        { value: "activated", text: "活性" },
      ];
      this.healthStatues = [
        { value: "", text: "選擇健康狀況" },
        { value: "good", text: "好的" },
        { value: "normal", text: "普通的" },
        { value: "bad", text: "壞的" },
      ];
      this.companies = [
        { value: "", text: "選擇公司" },
        { value: "...", text: "..." },
        { value: "...", text: "..." },
        { value: "...", text: "..." },
      ];
      this.serial_placeholder = "輸入序列號";
      this.setRegions("ch");
      this.tooltipText = "尚未驗證";
    },
  },
};
</script>
<style scoped>
#all-users {
  transition: ease 0.3s all;
}
.role_practitioner {
  padding: 35px 15px 0px 105px;
  min-height: calc(100% - 90px);
}
.user-profile-avatar {
  width: 40px;
  height: 40px;
  margin: 0px auto;
}
.user-profile-avatar img {
  width: 100%;
  border-radius: 10px;
  height: 100%;
}
.member-add-first-last-name {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
}
.member-add-first-last-name .form-group {
  width: 48%;
  margin-top: 20px;
}
.form-group {
  width: 100%;
  margin-top: 20px;
}
.name-form {
  margin: 0px;
}
.margin-top-0 {
  margin-top: 0px !important;
}
.role-form {
  margin-top: 20px;
}
.new-member-btns {
  display: flex;
  align-items: center;
  justify-content: space-around;
  width: 100%;
}
.margin_bottom_10 {
  margin-bottom: 10px;
}
.user-email div {
  display: flex;
  align-items: center;
  justify-content: center;
}
.user-email div span {
  margin-right: 10px;
}
.user-email i {
  color: rgb(255 177 0);
  font-size: 15px;
  cursor: pointer;
}
#serial-input_query {
  max-width: 15% !important;
  margin-top: 10px;
}
</style>

<style>
.modal-title {
  color: #5c5959;
}
.modal-header,
.modal-footer {
  background-color: #ffde00 !important;
}
.modal-footer {
  display: none !important;
}
.close {
  color: #5c5959 !important;
}
.member-form .row {
  width: 100%;
  margin: 0px !important;
}
.member-form .form-group {
  margin-bottom: 0px !important;
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
.member-submit-margin {
  margin-top: 20px;
}
.query-group {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  margin: 15px 0px;
}
.query-group select {
  max-width: 15%;
  margin: 10px 0px 0px;
}
</style>