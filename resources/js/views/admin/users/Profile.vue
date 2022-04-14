<template>
  <div class="page-profile" :class="myClass">
    <!-- Page Header  -->

    <div class="page-header">
      <h3 class="page-title">{{ $t("profile.user_profile") }}</h3>
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">{{ $t("profile.home") }}</a>
        </li>
        <li class="breadcrumb-item">
          <a href="/admin/users/all">{{ $t("profile.users") }}</a>
        </li>
        <li class="breadcrumb-item active">
          {{ user_first_name }} {{ user_last_name }}
        </li>
      </ol>
    </div>

    <!-- Notification According to the Email Verificaiton -->

    <div
      v-if="current_user_verification_status == 'nonactivated'"
      class="row member-verification"
    >
      <button
        class="btn btn-warning btn-rounded"
        @click="startMemberVerification"
      >
        <div class="verification-icon">
          <i class="fa-solid fa-user-check"></i>
        </div>
        <span>{{ $t("profile.start_verification") }}</span>
      </button>
    </div>

    <div>
      <b-tabs
        active-nav-item-class="text-uppercase text-warning"
        content-class="mt-3"
      >
        <b-tab active>
          <template #title>
            <span><i class="fa fa-user" aria-hidden="true"></i></span>
            <span>{{ $t("profile.edit_profile") }}</span>
          </template>

          <!-- User Information -->

          <UserInfo
            v-if="originalData"
            :current_user_id="current_user_id"
            :user_id="user_id"
            :user_picture="user_picture"
            :user_first_name="user_first_name"
            :user_last_name="user_last_name"
            :user_email="user_email"
            :user_gender="user_gender"
            :current_user_role="current_user_role"
            :user_role="user_role"
            :user_id_number="user_id_number"
            :user_serial_number="user_serial_number"
            :user_validity_period="user_validity_period"
            :user_company="user_company"
            :user_region="user_region"
            :user_health_status="user_health_status"
            :current_user_verification_status="current_user_verification_status"
            :tooltipText="tooltipText"
            @userAvatarChange="onUserAvatarChange"
            @produceQR="onProduceQR"
            @updateKeepUserInfo="onUpdateKeepUserInfo"
          />
        </b-tab>
        <b-tab>
          <template #title>
            <span><i class="fa fa-qrcode" aria-hidden="true"></i></span>
            <span>{{ $t("profile.qr_code") }}</span>
          </template>

          <!-- QR Code Generation -->

          <QRGeneration
            v-if="qrText"
            :src="src2"
            :qr_text="qrText"
            :qr_size="qrSize"
            :user_first_name="user_first_name"
            :user_last_name="user_last_name"
            :user_serial_number="user_serial_number"
            :user_company="user_company"
            :user_validity_period="user_validity_period"
          />
        </b-tab>
        <b-tab>
          <template #title>
            <span><i class="fa fa-comment" aria-hidden="true"></i></span>
            <span>{{ $t("profile.remark_info") }}</span>
          </template>
          <div class="card">
            <div class="card-body padding-remark-50">
              <div class="user-remark_info">
                <h1>
                  {{ $t("profile.remark.title") }}
                </h1>
                <table-component
                  :data="getRemarkInformation"
                  table-class="table"
                  ref="remark_table"
                  sort-by="time"
                  sort-order="asc"
                >
                  <table-column :label="$t('profile.remark.user_property')">
                    <template slot-scope="row">
                      <div class="user-profile-name">
                        <span>{{ row.parsedInfo.type }}</span>
                      </div>
                    </template>
                  </table-column>
                  <table-column
                    :sortable="false"
                    :filterable="false"
                    :label="$t('profile.remark.type')"
                  >
                    <template>
                      <div class="remark_type">
                        {{ $t("profile.remark.update") }}
                      </div>
                    </template>
                  </table-column>
                  <table-column :label="$t('profile.remark.result')">
                    <template slot-scope="row">
                      <div class="user-gender">
                        <span>{{ row.parsedInfo.result }}</span>
                      </div>
                    </template>
                  </table-column>
                  <table-column :label="$t('profile.remark.time')">
                    <template slot-scope="row">
                      <div class="user-email">
                        <span>{{ row.parsedInfo.time }}</span>
                      </div>
                    </template>
                  </table-column>
                </table-component>
              </div>
            </div>
          </div>
        </b-tab>
      </b-tabs>
    </div>
  </div>
</template>
<script>
import { TableComponent, TableColumn } from "vue-table-component";
import UserInfo from "./UserInfo.vue";
import QRGeneration from "./QRGeneration.vue";
import { Tabs, Tab } from "vue-tabs-component";
import Ls from "./../../../services/ls.js";
export default {
  props: ["toggle", "lang"],
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
      user_validity_period: "",
      img: "",
      tooltipText: null,
      genders: [
        { value: "male", text: "Male" },
        { value: "female", text: "Female" },
      ],
      verifications: [
        { value: "nonactivated", text: "Not Activated" },
        { value: "processing", text: "Processing" },
        { value: "activated", text: "Activated" },
      ],
      user_remark_information: "",
      current_user_role: "",
      current_user_verification_status: "",
      current_user_id: "",
      qrSize: 500,
      qrText: null,
      src2: "",
      originalData: null,
    };
  },
  components: {
    TableComponent,
    TableColumn,
    tabs: Tabs,
    tab: Tab,
    UserInfo,
    QRGeneration,
  },
  watch: {
    "$route.params.id": function (id) {
      this.user_id = id;
      this.fetchUserInfo(id);
      this.$refs.remark_table.refresh();
    },
    lang: function (newVal, oldVal) {
      if (newVal == "en") {
        this.setEn();
      } else if (newVal == "ch") {
        this.setCh();
      }
    },
  },
  created() {
    this.user_id = this.$route.params.id;
    this.current_user_id = Ls.get("user_id");
    this.current_user_role = Ls.get("Role");
    this.user_picture = "/assets/img/default-user-avatar.jpg";
    this.src2 = "/assets/img/default-user-avatar.jpg";
    this.fetchUserInfo(this.user_id);
    if (this.$i18n.locale == "en") {
      this.setEn();
    } else if (this.$i18n.locale == "ch") {
      this.setCh();
    }
    this.qrText = JSON.stringify({
      first_name: this.user_first_name,
      last_name: this.user_last_name,
      email: this.user_email,
      role: this.user_role,
      id_number: this.user_id_number,
      serial_number: this.user_serial_number,
      company: this.user_company,
      region: this.user_region,
      health_status: this.user_health_status,
      validity_period: this.user_validity_period,
    });
    window.addEventListener("resize", this.onResize);
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.onResize);
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
    async getRemarkInformation({ page, filter, sort }) {
      try {
        let response = await axios.get(
          `/api/admin/user/get/keepInfo/${this.user_id}`
        );
        this.user_remark_information = response.data.keep_info;
        let remarkInfos = [];
        let total_pages;
        if (this.user_remark_information) {
          let parsed = this.user_remark_information.split("/");
          total_pages = Math.ceil(parsed.length / 10);
          parsed.forEach((item, index) => {
            if (item != "") {
              let parsedItem = JSON.parse(item);
              remarkInfos.push({
                id: index,
                parsedInfo: parsedItem,
              });
            }
          });
        }
        remarkInfos = remarkInfos.filter(
          (item, index) => index >= (page - 1) * 10 && index < page * 10
        );

        return {
          data: remarkInfos,
          pagination: {
            totalPages: total_pages,
            currentPage: page,
            count: page * 10,
          },
        };
      } catch (error) {
        console.log("Error => ", error);
      }
    },
    async fetchUserInfo(id) {
      try {
        const response = await axios.get(`/api/admin/user/get/${id}`);
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
          this.src2 = response.data.user_avatar[0];
        }
        this.user_health_status = response.data.user_info[0].health_status;
        if (id == Ls.get("user_id")) {
          this.current_user_verification_status =
            response.data.user_info[0].verification_result;
          if (this.current_user_verification_status == "nonactivated") {
            if (this.$i18n.locale == "en") {
              window.toastr["info"]("Your Identity has not been verified...");
            } else if (this.$i18n.locale == "ch") {
              window.toastr["info"]("您的身份尚未驗證...");
            }
          } else if (this.current_user_verification_status == "processing") {
            if (this.$i18n.locale == "en") {
              window.toastr["info"](
                "Your Identity is on the processing of verification now..."
              );
            } else if (this.$i18n.locale == "ch") {
              window.toastr["info"]("您的身份正在驗證中...");
            }
          } else if (this.current_user_verification_status == "activated") {
            if (this.$i18n.locale == "en") {
              window.toastr["info"](
                "Your Identity has already been verified..."
              );
            } else if (this.$i18n.locale == "ch") {
              window.toastr["info"]("您的身份已通過驗證...");
            }
          }
        }
        this.user_validity_period = response.data.user_info[0].validity_period;
        this.user_remark_information =
          response.data.user_info[0].remark_information;

        this.originalData = {
          first_name: this.user_first_name,
          last_name: this.user_last_name,
          email: this.user_email,
          gender: this.user_gender,
          role: this.user_role,
          id_number: this.user_id_number,
          serial_number: this.user_serial_number,
          company: this.user_company,
          region: this.user_region,
          picture: this.user_picture,
          health_status: this.user_health_status,
          verification_status: this.current_user_verification_status,
          validity_period: this.user_validity_period,
        };
        return "Fetched Successfully!";
      } catch (error) {
        if (error) {
          window.toastr["error"]("There was an error", "Error");
        }
      }
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
      formData.append("user_id", this.user_id);
      if (formData.getAll("user_img")[0] !== "") {
        for (const value of formData.values()) {
        }
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
    onUserAvatarChange(path) {
      this.user_picture = path;
      this.src2 = path;
      if (
        this.current_user_role == "practitioner" ||
        this.user_id == Ls.get("user_id")
      ) {
        this.$emit("userAvatarChange", this.user_picture);
      }
    },
    onProduceQR(qrtext) {
      this.qrText = qrtext;
      let userInfo = JSON.parse(qrtext);
      this.user_first_name = userInfo.first_name;
      this.user_last_name = userInfo.last_name;
      this.user_serial_number = userInfo.serial_number;
      this.user_company = userInfo.company;
      this.user_validity_period = userInfo.validity_period;
    },
    startMemberVerification() {
      this.$router.push("/admin/users/verification/" + this.current_user_id);
    },
    setEn() {
      this.tooltipText = "Change your avatar";
    },
    setCh() {
      this.tooltipText = "更改您的頭像";
    },
    onResize() {
      if (window.innerWidth < 600) {
        this.qrSize = 300;
      }
      if (window.innerWidth >= 600 && window.innerWidth < 900) {
        this.qrSize = 400;
      }
      if (window.innerWidth >= 900) {
        this.qrSize = 500;
      }
    },
    async onUpdateKeepUserInfo(id) {
      this.$refs.remark_table.refresh();
    },
  },
};
</script>

<style scoped>
.page-profile {
  transition: ease 0.3s all;
}
.practitioner_content {
  padding: 35px 30px 0px 40px;
  min-height: calc(100% - 90px);
}
.role_practitioner {
  padding: 35px 30px 0px 105px;
  min-height: calc(100% - 90px);
}
.user-info-reset {
  background-color: #007bff;
  border-color: #007bff;
  color: white;
}
.visibility_hidden {
  visibility: hidden;
}
.visibility_show {
  visibility: visible;
}
.member-verification {
  justify-content: flex-end;
  padding-bottom: 20px;
  padding-right: 20px;
}
.member-verification button {
  background-color: #ffde00 !important;
  border-color: #ffde00 !important;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0px !important;
}
.member-verification button span {
  padding: 5px 15px 5px 10px;
}
.verification-icon {
  padding-left: 15px;
  padding-right: 10px;
  padding-top: 5px;
  padding-bottom: 5px;
  border-right: 1px solid;
}
.qrcode-img {
  max-width: 100%;
}

.bottom {
  margin-top: 40px;
  font-size: 20px;
  font-weight: 600;
  text-align: center;
}
.display_block {
  display: block;
}
.display_none {
  display: none;
}
.padding-remark-50 {
  padding: 50px !important;
}
.user-remark_info {
  border-top: 1px solid black;
}
.user-remark_info h1 {
  padding: 30px 0px;
}
</style>
<style>
@media only screen and (min-width: 900px) {
  .qrcode {
    width: 500px !important;
    height: 500px !important;
  }
}
@media only screen and (max-width: 899px) {
  .qrcode {
    width: 400px !important;
    height: 400px !important;
  }
}
@media only screen and (max-width: 600px) {
  .qrcode {
    width: 300px !important;
    height: 300px !important;
  }
}
.v-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
}
.nav-tabs .nav-link:hover {
  color: #6b6f80 !important;
}
.nav-tabs .active {
  border: 1px solid #dee2e6 !important;
  border-bottom: 0px !important;
}
</style>
