<template>
    <div class="Login">
      <div class="centered-container">
        <p>Enter your mail :</p>
        <b-form-input placeholder="Mail" v-model="MailData" type="mail"></b-form-input>
        <p>Enter your Password :</p>
        <b-form-input placeholder="Password" v-model="PassData" type="password"></b-form-input>
        <br/>
        <b-button variant="info" @click="checkPassord">Login</b-button>
        <b-alert v-model="ShowLoginAlert" variant="danger" dismissible>
          Wrong mail or Password !
        </b-alert>
        <br/>
        <br/>
        <b-button variant="info" @click="RedirectSignIn">Sign in</b-button>
      </div>
    </div>
  </template>

  <script>
  export default {
    data() {
      return {
        MailData: '',
        PassData: '',
        ShowLoginAlert: false,
      }
    },
    methods: {
      checkPassord () {
        if (this.MailData != 'test@mail.com' && this.PassData != 'toto') {
          this.ShowLoginAlert = true;
        }
      },
      RedirectSignIn () {
        this.$router.push('/sign-in');
      },
    },
  }
  </script>

  <style scoped>
  .Login {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 50vh;
  }

  .centered-container {
    max-width: 1000px;
    text-align: center;
  }
  </style>
