import Ls from './ls'

export default {
  async checkOnlineUsers() {
    try {
      let response = await axios.get("/api/auth/checkOnlineUsers");
      return response;
    } catch (error) {
      console.log("Error => ", error.message);
    }
  },
  async login(loginData) {
    try {
      let response = await axios.post('/api/auth/login', loginData)
      Ls.set('auth.token', response.data.token.token)
      Ls.set('user_id', response.data.user_data[0].id)
      Ls.set('Name', response.data.user_data[0].name)
      Ls.set('User Name', response.data.user_data[0].username)
      Ls.set('Role', response.data.user_data[0].role)
      Ls.set('Region Name', response.data.user_data[0].region);
      Ls.set('Gender', response.data.user_data[0].gender);
      Ls.set('email_verification_status', response.data.user_data[0].email_verification_status);
      Ls.set('User Region ID', response.data.user_region_id);
      toastr['success']("登录！", "成功")
      return response.data.token.token
    } catch (error) {
      if (error.response.status === 401) {
        toastr['error']("无效证件", "错误")
      } else {
        // Something happened in setting up the request that triggered an Error
        console.log('Error', error.message)
      }
    }
  },

  async register(registerData, locale) {
    try {
      let response = await axios.post('/api/auth/register', registerData)
      if (locale == "en") {
        toastr['success']('A new ' + response.data.role + ' has been registered!', 'Success')
      } else if (locale == "ch") {
        toastr['success']('一個新的' + response.data.role + '已註冊！', '成功')
      }
      Ls.set('Name', response.data.name)
      Ls.set('User Name', response.data.username)
      Ls.set('Role', response.data.role)
      Ls.set('Gender', response.data.gender)
      Ls.set('Registered_User', true)
      Ls.set('email_verification_status', response.data.email_verification_status)
      return response.data
    } catch (error) {
      if (locale == "en") {
        toastr['error']('Error Occurred in registered!', 'Error')
      } else if (locale == "ch") {
        toastr['error']('註冊時發生错误！', '错误')
      }
    }
  },

  async addNewMemberRegister(registerData) {
    try {
      let response = await axios.post('/api/auth/new/register', registerData)
      return response.data
    } catch (error) {
      toastr['error']('Error Occurred in registered!', 'Error')
    }
  },

  async updateUserEmailVerificationStatus(updateData) {
    try {
      let response = await axios.post('/api/auth/update/verification', updateData);
      return response;
    } catch (error) {
      console.log("Error => ", error);
    }
  },

  async resendEmailVerification(data, locale) {
    try {
      let response = await axios.post('/api/auth/resend/verification', data);
      if (locale == "US") {
        toastr['success']('Email has been sent to your address successfully!', 'Success')
      } else if (locale == "CN") {
        toastr['success']('用户名已成功發送到您的地址！', '成功')
      }
      return response;
    } catch (error) {
      console.log("Error => ", error);
    }
  },

  async passwordReset(data, locale) {
    try {
      let response = await axios.post('/api/auth/password/reset', data);
      if (locale == "US") {
        toastr['success']('Email has been sent successfully! Please check email for password reset.', 'Success')
      } else if (locale == "CN") {
        toastr['success']('用户名已經發送成功！ 請檢查用户名以重置密码。', '成功')
      }
      return response;
    } catch (error) {
      console.log("Error => ", error);
    }
  },

  async keepRemarkInformation(id, keepInfo) {
    try {
      let response = await axios.post(`/api/admin/user/keep/${id}`, keepInfo);
      return response;
    } catch (error) {
      console.log("Error => ", error);
    }
  },

  async addNewRegionToDB(info) {
    try {
      let response = await axios.post('/api/admin/region/add/new', info);
      return response;
    } catch (error) {
      console.log("Error => ", error);
    }
  },

  async addNewCompanyToDB(info) {
    try {
      let response = await axios.post('/api/admin/region/company/add/new', info);
      return response;
    } catch (error) {
      console.log("Error => ", error);
    }
  },

  async getAllRegions() {
    try {
      let response = await axios.get('/api/admin/region/get/all');
      return response;
    } catch (error) {
      console.log("error => ", error);
    }
  },

  async setOffline(user_id) {
    try {
      let response = await axios.get(`/api/auth/setOffline/${user_id}`);
      return response;
    } catch (error) {
      console.log("Error => ", error.message);
    }
  },

  async logout() {
    try {
      await axios.get('/api/auth/logout')

      Ls.remove('user_id')
      Ls.remove('auth.token')
      Ls.remove('Name')
      Ls.remove('User Name')
      Ls.remove('Role')
      Ls.remove('Gender')
      Ls.remove('user_avatar')
      Ls.remove('Registered_User')
      Ls.remove('Region Name')
      Ls.remove("email_verification_status")
      Ls.remove("User Region ID")
      toastr['success']('登出！', '成功')
    } catch (error) {
      console.log('Error', error.message)
    }
  },

  async check() {
    let response = await axios.get('/api/auth/check')

    return !!response.data.authenticated
  }
}
