import Ls from './ls'

export default {
  async login(loginData, locale) {
    try {
      let response = await axios.post('/api/auth/login', loginData)
      Ls.set('auth.token', response.data.token.token)
      Ls.set('user_id', response.data.user_data[0].id)
      Ls.set('First Name', response.data.user_data[0].first_name)
      Ls.set('Last Name', response.data.user_data[0].last_name)
      Ls.set('Email', response.data.user_data[0].email)
      Ls.set('Role', response.data.user_data[0].role)
      Ls.set('Region Name', response.data.user_data[0].region);
      Ls.set('Gender', response.data.user_data[0].gender);
      Ls.set('email_verification_status', response.data.user_data[0].email_verification_status);
      if (locale == "ch") {
        toastr['success']("登錄！", "成功")
      } else if (locale == "en") {
        toastr['success']("Logged In!", "Success")
      }
      return response.data.token.token
    } catch (error) {
      if (error.response.status === 401) {
        if (locale == "ch") {
          toastr['error']("無效證件", "錯誤")
        } else if (locale == "en") {
          toastr['error']('Invalid Credentials', 'Error')
        }
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
      Ls.set('First Name', response.data.first_name)
      Ls.set('Last Name', response.data.last_name)
      Ls.set('Email', response.data.email)
      Ls.set('Role', response.data.role)
      Ls.set('Gender', response.data.gender)
      Ls.set('Registered_User', true)
      Ls.set('email_verification_status', response.data.email_verification_status)
      return response.data
    } catch (error) {
      if (locale == "en") {
        toastr['error']('Error Occurred in registered!', 'Error')
      } else if (locale == "ch") {
        toastr['error']('註冊時發生錯誤！', '錯誤')
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
        toastr['success']('電子郵件已成功發送到您的地址！', '成功')
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
        toastr['success']('電子郵件已經發送成功！ 請檢查電子郵件以重置密碼。', '成功')
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

  async getAllRegions() {
    try {
      let response = await axios.get('/api/admin/region/get/all');
      return response;
    } catch (error) {
      console.log("error => ", error);
    }
  },

  async logout(locale) {
    try {
      await axios.get('/api/auth/logout')

      Ls.remove('user_id')
      Ls.remove('auth.token')
      Ls.remove('First Name')
      Ls.remove('Last Name')
      Ls.remove('Email')
      Ls.remove('Role')
      Ls.remove('Gender')
      Ls.remove('user_avatar')
      Ls.remove('Registered_User')
      Ls.remove('Region Name')
      Ls.remove("countryLang")
      Ls.remove("email_verification_status")
      if (locale == "en") {
        toastr['success']('Logged out!', 'Success')
      } else if (locale == "ch") {
        toastr['success']('登出！', '成功')
      }
    } catch (error) {
      console.log('Error', error.message)
    }
  },

  async check() {
    let response = await axios.get('/api/auth/check')

    return !!response.data.authenticated
  }
}
