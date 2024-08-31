const fs = require("fs");
const {questions} = require("./toast.utilities");

function saveNewUser(userId, jsonUserData) {
    let newUser = {userId: userId, collaborators: []};
    jsonUserData.users.push(newUser);
    const jsonString = JSON.stringify(jsonUserData, null, 4);

    fs.writeFile('users.json', jsonString, 'utf8', (err) => {
        if (err) {
            console.error('Error during the addition of the new user to the file:', err);
        } else {
            console.log('New user successfully added!');
        }
    });
    return newUser;
}

function updateMap(interaction, index, gamma, smellValues) {
    let userSmell = smellValues.get(interaction.user.id);
    if (userSmell === undefined) {
        userSmell = new Map();
        smellValues.set(interaction.user.id, userSmell);
    }

    let prevValue = userSmell.get(questions[index].smell) || 0;
    let value = gamma[interaction.customId].value * questions[index].norm_weight + prevValue;
    userSmell.set(questions[index].smell, value);
}

function saveNewCollaborator(userId, name, surname, id, jsonUserData) {
    let user = jsonUserData.users.find((el) => {
        return el.userId === userId
    });

    let collaborator = {name: name, surname: surname, collaboratorId: id};

    user.collaborators.push(collaborator);
    const jsonString = JSON.stringify(jsonUserData, null, 4);

    fs.writeFile('users.json', jsonString, 'utf8', (err) => {
        if (err) {
            console.error('Error during the addition of the new user to the file:', err);
        } else {
            console.log('New user successfully added!');
        }
    });
}

function deleteCollaborator(userId, collaboratorId, jsonUserData) {

        // Find the user
        const user = jsonUserData.users.find(user => user.userId === userId);

        if (!user) {
            console.error('User not found');
            return;
        }

        // Find the index of the collaborator to delete
        const collaboratorIndex = user.collaborators.findIndex(collab => collab.collaboratorId === collaboratorId);

        if (collaboratorIndex === -1) {
            console.error('Collaborator not found');
            return;
        }

        // Remove the collaborator from the array
        user.collaborators.splice(collaboratorIndex, 1);

        // Convert the updated data back to JSON string
        const updatedJsonString = JSON.stringify(jsonUserData, null, 4);

        // Write the updated JSON back to the file
        fs.writeFile('users.json', updatedJsonString, 'utf8', (writeErr) => {
            if (writeErr) {
                console.error('Error writing file:', writeErr);
            } else {
                console.log('Collaborator successfully deleted!');
            }
        });

}

module.exports.saveNewUser = saveNewUser;
module.exports.updateMap = updateMap;
module.exports.saveNewCollaborator = saveNewCollaborator;
module.exports.deleteCollaborator = deleteCollaborator;
