<template>
  <div class="Login">
    <p v-if="this.$store.state.Connected">Connected</p>
    <div class="centered-container" v-if="!this.$store.state.Connected">
      <p>Enter your mail :</p>
      <b-form-input placeholder="Mail" v-model="MailData" type="mail"></b-form-input>
      <p>Enter your Password :</p>
      <b-form-input
        placeholder="Password"
        v-model="PassData"
        type="password"
      ></b-form-input>
      <br />
      <b-button variant="info" @click="checkPassord">Login</b-button>
      <b-alert v-model="ShowLoginAlert" variant="danger" dismissible>
        Wrong mail or Password !
      </b-alert>
      <br />
      <br />
      <b-button variant="info" @click="RedirectSignIn">Sign in</b-button>
      <b-alert v-model="ShowConnected" variant="success" dismissible>
        Connected!
      </b-alert>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      MailData: "",
      PassData: "",
      ShowLoginAlert: false,
      ShowConnected: false,
      loginData: {
        username: "",
        password: "",
      },
    };
  },
  methods: {
    checkPassord() {
      this.loginData.username = this.MailData;
      this.loginData.password = this.PassData;
      axios
        .post("http://localhost:3000/login", this.loginData)
        .then((responce) => {
          console.log(responce.status);
          if (responce.status === 200) {
            this.ShowConnectedFaild = true;
            this.$router.push("/");
          }
          if (responce.status === 401) this.ShowLoginAlert = true;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    RedirectSignIn() {
      this.$router.push("/sign-in");
    },
  },
};
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
