<template>
    <div>
        <p>Welcome to the sign in vieww !</p>
        <p>Enter Your name :</p>
        <b-form-input placeholder="Text" v-model="Name" type="Text"></b-form-input>
        <p>Enter your mail :</p>
        <b-form-input placeholder="Mail" v-model="MailData" type="mail"></b-form-input>
        <p>Verif your mail :</p>
        <b-form-input placeholder="Mail" v-model="MailDataVerif" type="mail"></b-form-input>
        <b-alert v-model="ShowMailAlert" variant="danger" dismissible>
            The emails are not identical !
        </b-alert>
        <p>Enter your Password :</p>
        <b-form-input placeholder="Password" v-model="PassData" type="password"></b-form-input>
        <p>Verif your Password :</p>
        <b-form-input placeholder="Password" v-model="PassDataVerif" type="password"></b-form-input>
        <b-alert v-model="ShowPassAlert" variant="danger" dismissible>
            The password are not identical !
        </b-alert>
        <br>
        <b-button @click="VerifRegister" variant="info">Register</b-button>
    </div>
</template>

<script>
export default {
    data() {
        return {
            MailData: '',
            MailDataVerif: '',
            PassData: '',
            PassDataVerif: '',
            Name: '',
            ShowMailAlert: false,
            ShowPassAlert: false,
        }
    },
    methods: {
        VerifRegister () {
            if (this.MailData != this.MailDataVerif)
                this.ShowMailAlert = true;
            if (this.PassData != this.PassDataVerif)
                this.ShowPassAlert = true;
        },
        RedirectSignIn () {
            this.$router.push('/sign-in');
        },
    },
}
</script>