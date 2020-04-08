This document will highlight the steps needed to deploy Classroom successfully. You would need an Azure account, as well as certain subscriptions depending on the choices you choose.

1. Register a new OAuth Application [here](https://github.com/settings/applications/new). Use any placeholder value for your-web-app-name, as we will return to edit this later in Step 5.

| Field | Value | 
|--|--|
| Application Name | (User's choice) |
| Homepage URL | https://<your-web-app-name>.azurewebsites.net |
| Application Callback URL | https://<your-web-app-name>.azurewebsites.net/auth/github/callback |

![image.png](/docs/images/1-oauth.png)

![image.png](/docs/images/2-oauth2.png)

2. Click on the one-click deploy button in the repository

![image.png](/docs/images/3-azurebutton.png)

3. Clicking on the button will bring you to the Azure Resource Manager portal, where you can configure the settings for your Classroom.

![2.png](/docs/images/4-portal.png)

4. Choose the settings that you wish to have for your deployment.  If **unfamiliar** with the settings, simply go with the **default** values already chosen. We recommend going with the default value for the web app name, as a unique value is required. (Refer to NOTE section below for more details). The table below highlights important fields to take note of.

| Name | Value |
|--|--|
| GITHUB_CLIENT_ID | Obtain from Step 1, also accessible at https://github.com/settings/developers under "OAuth Apps" within the specific OAuth App Created |
| GITHUB_CLIENT_SECRET | Obtain from Step 1, also accessible at https://github.com/settings/developers under "OAuth Apps" within the specific OAuth App Created |
| NON_STAFF_GITHUB_ADMIN_IDS | Obtain from https://api.github.com/users/your_username , replacing "your_username" with your GitHub Username. Look for the 'id' field|
| Administrator Login | User's Choice|
| Administrator Password | User's Choice, between 8 and 128 characters long, containing characters from 3 of the following categories: English uppercase letters, English lowercase letters, numbers (0 through 9), and non-alphanumeric characters (!, $, #, %, etc.)|
| Web App Name |User's choice which has to be unique; Default value is recommended |

5. Open a new tab and navigate back to the OAuth Application created in Step 1. Edit the value for your-web-app-name to the one you have used in Step 4.

6. Go back to the ARM Portal and finish choosing your settings, and the resources will be created for you. This refers to a Database instance, a Redis instance, and an App Service instance.

7. Upon confirmation, you would be redirected to the [Azure portal](https://portal.azure.com/) where you can access your resources. Look out for the notification in the top right, which shows the deployment progress. 

![image.png](/docs/images/5-inprogress.png)

8. Wait for the deployment to succeed (approx. 20 mins). Click on "Go to Resource Group" to find the deployed resources.

![image.png](/docs/images/6-successful.png)

9. Select the resource that is of type "App Service" that has just been created. If not found, click on the resource of type "App Service Plan", navigate to the tab "Apps" and click on the top entry.

![image.png](/docs/images/7-resourcegroup.png)

![image.png](/docs/images/8-appservice.png)

10. In the left side-bar, locate "Overview", click on it and press Browse. This makes the App Service load up the Docker image.
![image.png](/docs/images/9-appservice.png)

11. In the left side-bar, locate "Container Settings" under the tab "Settings". Click on "Container Settings". The image source is "Docker Hub".

12. Wait for the setup to complete. This process usually takes a while (c. 10 minutes, depending on different conditions). You would know the process is done by checking the logs has completed on this page.

![image.png](/docs/images/10-logs.png)

13. Remove Startup File and save changes.

![image.png](/docs/images/11-startupfile.png)

14. Go to Overview and restart the App Service.

![image.png](/docs/images/12-restart.png)

15. Everything is now done!

---

TO UPDATE:

To update your Classroom instance if the GitHub Classroom repository has been updated, simply restart the App Service instance.

---
NOTE:

If your-web-app-name chosen is not unique, the deployment will fail. Azure does not allow for name validation checks in the template portal, so there is always a risk of users choosing a non-unique name, especially if choosing ones themselves. If so, delete all the resources created, and start over.
