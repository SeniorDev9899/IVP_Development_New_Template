<template>
  <div class="card">
    <div class="card-body">
      <div id="myQRCode">
        <h1>{{ $t("profile.identity_card_name") }}</h1>
        <vue-qr
          :logoSrc="src_sub"
          :text="qr_text_sub"
          :size="qr_size_sub"
        ></vue-qr>
        <p class="user_name">
          <span>{{ user_first_name_sub }}</span>
          <span>{{ user_last_name_sub }}</span>
        </p>
        <div class="user_info">
          <div>
            <span class="title">{{ $t("profile.serial_number") }} :</span>
            <p class="serial_number">{{ user_serial_number_sub }}</p>
          </div>
          <div>
            <span class="title">{{ $t("profile.company") }} :</span>
            <p class="company_name">{{ user_company_sub }}</p>
          </div>
          <div>
            <span class="title">{{ $t("profile.validity_period") }} :</span>
            <p class="validity_period">{{ user_validity_period_sub }}</p>
          </div>
        </div>
        <div class="bottom">{{ $t("profile.bottom_text") }}</div>
      </div>
    </div>
  </div>
</template>

<script>
import VueQr from "vue-qr";
export default {
  props: [
    "src",
    "qr_text",
    "qr_size",
    "user_first_name",
    "user_last_name",
    "user_serial_number",
    "user_company",
    "user_validity_period",
  ],
  data() {
    return {
      src_sub: "",
      qr_text_sub: "",
      qr_size_sub: "",
      user_first_name_sub: "",
      user_last_name_sub: "",
      user_serial_number_sub: "",
      user_company_sub: "",
      user_validity_period_sub: "",
    };
  },
  watch: {
    src: function (newVal, oldVal) {
      this.src_sub = newVal;
    },
    qr_text: function (newVal, oldval) {
      this.qr_text_sub = newVal;
    },
    qr_size: function (newVal, oldVal) {
      this.qr_size_sub = newVal;
    },
    user_first_name: function (newVal, oldVal) {
      this.user_first_name_sub = newVal;
    },
    user_last_name: function (newVal, oldVal) {
      this.user_last_name_sub = newVal;
    },
    user_serial_number: function (newVal, oldVal) {
      this.user_serial_number_sub = newVal;
    },
    user_company: function (newVal, oldVal) {
      this.user_company_sub = newVal;
    },
    user_validity_period: function (newVal, oldVal) {
      this.user_validity_period_sub = newVal;
    },
  },
  components: {
    VueQr,
  },
  created() {
    this.src_sub = this.src;
    this.qr_text_sub = this.qr_text;
    this.qr_size_sub = this.qr_size;
    this.user_first_name_sub = this.user_first_name;
    this.user_last_name_sub = this.user_last_name;
    this.user_serial_number_sub = this.user_last_name;
    this.user_company_sub = this.user_company;
    this.user_validity_period_sub = this.user_validity_period;
  },
};
</script>

<style scoped>
#myQRCode {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-direction: column;
  border: 1px solid black;
  padding-top: 15px;
  max-width: 553px;
  margin: 0px auto;
  border-radius: 70px;
  height: 940px;
  padding: 30px;
}
#myQRCode h1 {
  margin-bottom: 10px;
  margin-top: 20px;
  font-weight: 600;
}
.user_name {
  font-size: 30px;
  font-weight: 700;
  margin-bottom: 30px;
}
.user_name span {
  margin-right: 10px;
}
.user_info {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  max-width: 100%;
}
.user_info div {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: row;
}
.user_info div p {
  margin: 0px !important;
  font-size: 25px;
  font-weight: 700;
}
.user_info .title {
  font-size: 25px;
  font-weight: 600;
  margin-right: 30px;
  text-align: center;
}
@media only screen and (max-width: 550px) {
  .user_info .title {
    font-size: 20px !important;
  }
  .user_info .company_name {
    font-size: 20px !important;
  }
  .bottom {
    font-size: 15px !important;
  }
}
@media only screen and (max-width: 600px) {
  #myQRCode h1 {
    font-size: 35px !important;
  }
}
</style>