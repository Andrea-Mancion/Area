<template>
    <div class="ActionReaction">
        <div class="centered-containe">
            <p>Welcome to the action/reaction view !</p>

            <b-button variant="info">Create an Action</b-button>
            <br />
            <br />
            <b-button variant="info">Create an Reaction</b-button>
        </div>
    </div>
</template>

<style scoped>
.ActionReaction {
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