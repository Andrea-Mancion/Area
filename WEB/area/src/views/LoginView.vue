<template>
    <div class="Login">
        <p>Enter yout mail :</p>
        <b-form-input placeholder="Mail" v-model="MailData" type="mail"></b-form-input>
        <p>Enter yout Password :</p>
        <b-form-input placeholder="Password" v-model="PassData" type="password"></b-form-input>
        <br/>
        <b-button variant="info" @click="checkPassord">Login</b-button>
        <b-alert v-model="ShowLoginAlert" variant="danger" dismissible>
            Wrong mail or Password !
        </b-alert>
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
    },
}
</script>
