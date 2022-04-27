<template>
  <div class="page-profile" :class="myClass">
    <!-- Page Header  -->

    <div class="page-header">
      <h3 class="page-title">用户资料</h3>
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">员工管理</a>
        </li>
        <li class="breadcrumb-item">
          <a href="/admin/users/all">用户资料</a>
        </li>
        <li class="breadcrumb-item active">
          {{ name }}
        </li>
      </ol>
    </div>

    <!-- Notification According to the Email Verificaiton -->

    <div v-if="user_role == 'practitioner'" class="row member-verification">
      <button
        class="btn btn-warning btn-rounded"
        @click="startMemberVerification"
      >
        <div class="verification-icon">
          <i class="fa-solid fa-user-check"></i>
        </div>
        <span>開始驗證</span>
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
            <span>编辑个人资料</span>
          </template>

          <!-- User Information -->

          <UserInfo
            v-if="originalData"
            :current_user_id="current_user_id"
            :user_id="user_id"
            :user_picture="user_picture"
            :name="name"
            :username="user_name"
            :user_gender="user_gender"
            :current_user_role="current_user_role"
            :user_role="user_role"
            :user_id_number="user_id_number"
            :user_serial_number="user_serial_number"
            :user_validity_period="user_validity_period"
            :user_company="user_company"
            :user_region="user_region"
            :user_health_status="user_health_status"
            :tooltipText="tooltipText"
            :remarkInfo="remark_file_path"
            :comments="user_comments"
            @userAvatarChange="onUserAvatarChange"
            @produceQR="onProduceQR"
            @updateKeepUserInfo="onUpdateKeepUserInfo"
            @downloadFile="onDownloadFile"
          />
        </b-tab>
        <b-tab>
          <template #title>
            <span><i class="fa fa-qrcode" aria-hidden="true"></i></span>
            <span>身份信息识别卡</span>
          </template>

          <!-- QR Code Generation -->

          <QRGeneration
            v-if="qrText"
            :src="src2"
            :qr_text="qrText"
            :qr_size="qrSize"
            :name="name"
            :user_serial_number="user_serial_number"
            :user_company="user_company"
            :user_validity_period="user_validity_period"
          />
        </b-tab>
        <b-tab>
          <template #title>
            <span><i class="fa fa-comment" aria-hidden="true"></i></span>
            <span>历史记录</span>
          </template>
          <div class="card">
            <div class="card-body padding-remark-50">
              <div class="user-remark_info">
                <h1>用户信息历史记录</h1>
                <table-component
                  :data="getRemarkInformation"
                  table-class="table"
                  ref="remark_table"
                  sort-by="time"
                  sort-order="asc"
                >
                  <table-column label="ID">
                    <template slot-scope="row">
                      <div class="user-profile-id">
                        <span>{{ row.id }}</span>
                      </div>
                    </template>
                  </table-column>
                  <table-column label="变更内容">
                    <template slot-scope="row">
                      <div class="user-profile-name">
                        <span>{{ row.parsedInfo.type }}</span>
                      </div>
                    </template>
                  </table-column>
                  <table-column
                    :sortable="false"
                    :filterable="false"
                    label="类别"
                  >
                    <template>
                      <div class="remark_type">更新</div>
                    </template>
                  </table-column>
                  <table-column label="结果">
                    <template slot-scope="row">
                      <div class="user-gender">
                        <span>{{ row.parsedInfo.result }}</span>
                      </div>
                    </template>
                  </table-column>
                  <table-column label="时间戳">
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
import fileDownload from "js-file-download";
import UserInfo from "./UserInfo.vue";
import QRGeneration from "./QRGeneration.vue";
import { Tabs, Tab } from "vue-tabs-component";
import Ls from "./../../../services/ls.js";
export default {
  props: ["toggle"],
  data() {
    return {
      user_id: "",
      name: "",
      user_name: "",
      user_gender: "",
      user_role: "practitioner",
      user_id_number: "",
      user_serial_number: "",
      user_company: "",
      user_region: "",
      user_picture: "/assets/img/default-user-avatar.jpg",
      user_health_status: "",
      user_verification_status: "",
      user_validity_period: "",
      user_remark_file: "",
      user_comments: "",
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
      current_user_id: "",
      qrSize: 500,
      qrText: null,
      src2: "/assets/img/default-user-avatar.jpg",
      originalData: null,
      keys: ["type", "result", "time"],
      remark_file_path: "",
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
  },
  created() {
    this.user_id = this.$route.params.id;
    this.current_user_id = Ls.get("user_id");
    this.current_user_role = Ls.get("Role");
    this.fetchUserInfo(this.user_id);
    this.setCh();
    this.qrText = JSON.stringify({
      name: this.name,
      username: this.user_name,
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
                id: index + 1,
                parsedInfo: parsedItem,
              });
            }
          });
        }
        let exist = this;
        let return_data = [];
        if (filter) {
          remarkInfos.forEach((item, index) => {
            exist.keys.forEach((key) => {
              if (item.parsedInfo[key] != "") {
                if (item.parsedInfo[key].toString().includes(filter)) {
                  return_data.push(item);
                }
              }
            });
          });
          return_data = exist.removeDuplicates(return_data);
        } else {
          return_data = remarkInfos;
        }
        return_data = return_data.filter(
          (item, index) => index >= (page - 1) * 10 && index < page * 10
        );

        return {
          data: return_data,
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
    removeDuplicates(arr) {
      return arr.filter((item, index) => arr.indexOf(item) === index);
    },
    async fetchUserInfo(id) {
      try {
        const response = await axios.get(`/api/admin/user/get/${id}`);
        this.name = response.data.user_info[0].name;
        this.user_name = response.data.user_info[0].username;
        this.user_gender = response.data.user_info[0].gender;
        this.user_role = response.data.user_info[0].role;
        this.user_id_number = response.data.user_info[0].id_number;
        this.user_serial_number = response.data.user_info[0].serial_number;
        this.user_company = response.data.user_info[0].company;
        this.user_region = response.data.user_info[0].region;
        if (response.data.user_info[0].remark_file !== "...") {
          this.remark_file_path = response.data.user_info[0].remark_file;
        }
        if (response.data.user_info[0].comments !== "...") {
          this.user_comments = response.data.user_info[0].comments;
        }
        if (
          response.data.user_avatar.length !== 0 &&
          response.data.user_avatar[0] != ""
        ) {
          this.user_picture = response.data.user_avatar[0];
          this.src2 = response.data.user_avatar[0];
        } else {
          this.user_picture = "/assets/img/default-user-avatar.jpg";
          this.src2 = "/assets/img/default-user-avatar.jpg";
        }
        this.user_health_status = response.data.user_info[0].health_status;
        if (this.user_role == "practitioner") {
          this.user_verification_status =
            response.data.user_info[0].verification_result;
          if (this.user_verification_status == "nonactivated") {
            window.toastr["info"]("您的身份尚未验证...");
          } else if (this.user_verification_status == "processing") {
            window.toastr["info"]("您的身份正在驗證中...");
          } else if (this.user_verification_status == "activated") {
            window.toastr["info"]("您的身份已通過驗證...");
          }
        }
        this.user_validity_period = response.data.user_info[0].validity_period;
        this.user_remark_information =
          response.data.user_info[0].remark_information;

        this.originalData = {
          name: this.name,
          username: this.user_name,
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
            window.toastr["success"]("用户头像已更改！", "成功");
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
      this.name = userInfo.name;
      this.user_serial_number = userInfo.serial_number;
      this.user_company = userInfo.company;
      this.user_validity_period = userInfo.validity_period;
    },
    startMemberVerification() {
      this.$router.push("/admin/users/verification/" + this.user_id);
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
    downloadFile(url, filename) {
      axios
        .get(url, {
          responseType: "blob",
        })
        .then((res) => {
          fileDownload(res.data, filename);
        });
    },
    onDownloadFile(fileName, filePath) {
      this.downloadFile("http://43.135.48.73" + filePath, fileName);
    },
    // "http://43.135.48.73"
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
