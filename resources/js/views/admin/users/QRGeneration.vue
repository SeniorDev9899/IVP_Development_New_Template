<template>
  <div class="card">
    <div class="card-body position_relative">
      <div class="download">
        <span
          @click="downloadInfo"
          v-tooltip="{
            content: tooltip_text,
            placement: position + '-center',
            delay: {
              show: 200,
              hide: 300,
            },
            classes: ['info'],
          }"
          ><i class="fa fa-download" aria-hidden="true"></i
        ></span>
      </div>
      <div id="myQRCode" ref="printMe">
        <h1>身份信息识别卡</h1>
        <div class="qr-container">
          <vue-qr
            :logoSrc="src_sub"
            :text="qr_text_sub"
            :size="qr_size_sub"
            backgroundColor="white"
            :logoMargin="logo_margin"
            :logoCornerRadius="logo_radius"
            :dotScale="dot_scale"
            :correctLevel="correct_level"
            :colorDark="color_dark"
            :colorLight="color_light"
          ></vue-qr>
        </div>
        <p class="user_name">
          <span>{{ name_sub }}</span>
        </p>
        <div class="user_info">
          <div>
            <span class="title">编号 :</span>
            <p class="serial_number">{{ user_serial_number_sub }}</p>
          </div>
          <div>
            <span class="title">单位 :</span>
            <p class="company_name">{{ user_company_sub }}</p>
          </div>
          <div>
            <span class="title">有效期 :</span>
            <p class="validity_period">{{ user_validity_period_sub }}</p>
          </div>
        </div>
        <div class="bottom">信息来源：公安部安信工作证&养老协会</div>
      </div>
    </div>
  </div>
</template>

<script>
import VueQr from "vue-qr";
var _global =
  typeof window === "object" && window.window === window
    ? window
    : typeof self === "object" && self.self === self
    ? self
    : typeof global === "object" && global.global === global
    ? global
    : this;

export default {
  props: [
    "src",
    "qr_text",
    "qr_size",
    "name",
    "user_serial_number",
    "user_company",
    "user_validity_period",
  ],
  data() {
    return {
      src_sub: "",
      qr_text_sub: "",
      qr_size_sub: "",
      name_sub: "",
      user_serial_number_sub: "",
      user_company_sub: "",
      user_validity_period_sub: "",
      logo_margin: 10,
      logo_radius: 5,
      dot_scale: 0.8,
      correct_level: 2,
      color_dark: "rgb(38 129 223)",
      color_light: "white",
      output: null,
      tooltip_text: "下载身份证",
      position: "top",
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
    name: function (newVal, oldVal) {
      this.name_sub = newVal;
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
    this.name_sub = this.name;
    this.user_serial_number_sub = this.user_serial_number;
    this.user_company_sub = this.user_company;
    this.user_validity_period_sub = this.user_validity_period;
  },
  methods: {
    async downloadInfo() {
      const el = this.$refs.printMe;
      const options = {
        type: "dataURL",
      };
      this.output = await this.$html2canvas(el, options);
      fetch(this.output)
        .then((res) => res.blob())
        .then((blob) => this.saveAs(blob, "Identity_Card.jpg"));
    },
    saveAs(blob, name, opts) {
      var URL = _global.URL || _global.webkitURL;
      var a = document.createElement("a");
      name = name || blob.name || "download";

      a.download = name;
      a.rel = "noopener"; // tabnabbing

      // TODO: detect chrome extensions & packaged apps
      // a.target = '_blank'

      if (typeof blob === "string") {
        const exist = this;
        // Support regular links
        a.href = blob;
        if (a.origin !== location.origin) {
          exist.corsEnabled(a.href)
            ? exist.download(blob, name, opts)
            : exist.click(a, (a.target = "_blank"));
        } else {
          exist.click(a);
        }
      } else {
        const exist = this;
        // Support blobs
        a.href = URL.createObjectURL(blob);
        setTimeout(function () {
          URL.revokeObjectURL(a.href);
        }, 4e4); // 40s
        setTimeout(function () {
          exist.click(a);
        }, 0);
      }
    },
    corsEnabled(url) {
      var xhr = new XMLHttpRequest();
      // use sync to avoid popup blocker
      xhr.open("HEAD", url, false);
      xhr.send();
      return xhr.status >= 200 && xhr.status <= 299;
    },
    download(url, name, opts) {
      var xhr = new XMLHttpRequest();
      xhr.open("GET", url);
      xhr.responseType = "blob";
      xhr.onload = function () {
        saveAs(xhr.response, name, opts);
      };
      xhr.onerror = function () {
        console.error("could not download file");
      };
      xhr.send();
    },
    click(node) {
      try {
        node.dispatchEvent(new MouseEvent("click"));
      } catch (e) {
        var evt = document.createEvent("MouseEvents");
        evt.initMouseEvent(
          "click",
          true,
          true,
          window,
          0,
          0,
          0,
          80,
          20,
          false,
          false,
          false,
          false,
          0,
          null
        );
        node.dispatchEvent(evt);
      }
    },
  },
};
</script>

<style scoped>
.position_relative {
  position: relative;
}
.position_relative .download {
  position: absolute;
  right: 35px;
  top: 10px;
}
.download i {
  font-size: 20px;
  color: rgb(121 207 140);
  cursor: pointer;
}
.download i:hover {
  color: rgb(135 235 72);
}
#myQRCode {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-direction: column;
  border: 1px solid black;
  padding-top: 15px;
  max-width: 500px;
  margin: 0px auto;
  border-radius: 70px;
  height: 825px;
  padding: 30px;
  background-color: rgb(247 248 249);
}
#myQRCode h1 {
  margin-bottom: 10px;
  margin-top: 20px;
  font-weight: 600;
}
.qr-container {
  max-width: 85%;
}
.user_name {
  margin-top: 15px;
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
  max-width: 85%;
}
.user_info div {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: row;
}
.user_info div p {
  margin: 0px !important;
  font-size: 22px;
  font-weight: 700;
}
.user_info .title {
  font-size: 25px;
  font-weight: 600;
  margin-right: 30px;
  text-align: center;
}
.bottom {
  max-width: 100%;
  font-size: 20px;
  margin-top: 35px;
  margin-bottom: 15px;
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