---
title: Configure your domain name for hosted Discourse
name: configure-your-domain-name-for-hosted-discourse
subsection: essentials
---

So you've selected a hosted Discourse plan. Lucky you!

The very first step is to point your domain name `forum.example.com` to our hosting.

- You will need to edit the DNS records for your domain name, `example.com`.

- In most cases, the DNS is controlled from the same place where you originally purchased the `example.com` domain from.

- Log into your name registrar and find your DNS control panel.

-  In the DNS control panel, CNAME `forum` to point at `hosted-vh1.discourse.org`. If you will be adding SSL to enable https support, point the CNAME to `hosted-vh2.discourse.org`.

- Wait for the change to propagate and we'll take care of the rest.

This page provides a list of detailed instructions for many of the major Domain Name providers. Select your provider from the list below to get detailed instructions for how to CNAME your domain.

If you cannot find your provider or are still having trouble configuring your CNAME records, contact us at `team@discourse.org`.

### GoDaddy.com

1.  Log in to your account at <a href="http://godaddy.com/">www.godaddy.com</a> by clicking the **My Account** tab.
1.  Under the **Domains** drop down, find the domain you're using for your service.
1.  Select your domain by clicking on the link that appears in the **Domain Name** column of the table of domains. The Settings, DNS Zone File, and Contacts tabs appear with the Settings tab selected by default.
1.  Click the **DNS Zone File** tab.
1.  Above the **CNAME (Alias)** section, click **Add Record**. A new row appears in the CName (Alias) table.
1.  In the new row that appears, enter the following information:
    *   **Host:** Enter the subdomain name for the alias assignment. For example, if you chose `www.example.com` as your host address, type `www`
    *   **Points to:** Enter `hosted-vh1.discourse.org`
    *   **TTL:** Select how long the server should cache the information.
1.  Click **Save**.


### DynECT Managed DNS


1.  Log in to your account at <a href="https://manage.dynect.net/">https://manage.dynect.net/</a>.
1.  Click on **Manage Domain.**
1.  Click **Add New Node.**
1.  Enter the the address for your Discourse service and click **OK**. For example, if you chose `www.example.com` as the address, you should enter `www.example.com`.
1.  Click **Add New Record** and then choose **CNAME** from the drop-down menu.
1.  Set your TTL (Time To Live) if desired and then add the full path to Discourse's server. Example: if you chose `www.example.com` you should enter `www.example.com.hosted-vh1.discourse.org`.
1.  Click **Publish Now**.


### IX Web Hosting


1.  Log in to your account at <a href="https://manage.ixwebhosting.com/">IX Web Hosting</a>.
1.  Click **Manage** below the **Hosting Account** section.
1.  On the left side, click the domain you'd like to use with Discourse.
1.  Next to **DNS Configuration**, click **EDIT**.
1.  Click **Add DNS CNAME Record**.
1.  Under **Name**, enter only the part of your website address that you designated for your Discourse Service. For example, if you picked `www.example.com` as your address, just enter `www` as the entry under Name.
1.  Enter `hosted-vh1.discourse.org` under **Data**.
1.  Click **Submit**.


### 1and1


1.  Log in to your account at <a href="https://admin.1and1.com/">https://admin.1and1.com</a>
1.  If it's not already selected, click the **Administration** tab.
1.  Click **Domains**. The Domain Overview page appears.
1.  From the **New** drop-down menu, select **Create Subdomain**. (If you've already created a subdomain for your website's address, skip to step six.)
1.  Enter the prefix of the address for your Discourse service, and click **OK**. Example: if you chose `www.example.com` you should enter `www`.
1.  Check the box next to the subdomain.
1.  From the **DNS** menu, select **Edit DNS Settings**.
1.  Click the radio button next to **CNAME**.
1.  Next to **Alias**, enter `hosted-vh1.discourse.org`
1.  Click **OK**.


### EveryDNS.net


1.  Log in to your account at <a href="http://www.everydns.net/">EveryDNS.net</a>.
1.  On the left side, click the domain you'd like to use with Discourse.
1.  Since EveryDNS.net is your hosting service, and not your domain registrar, be sure that your domain points to EveryDNS.net's nameservers. This will allow your CNAME record configuration to take effect.
1.  Below **Add a Record:**, you can create your CNAME record.
1.  Next to Fully **Qualified Domain Name**, enter only the part of your website address that you designated for your Discourse service. For example, if you picked `www.example.com` as your website's address, just enter `www` as the entry next to Fully Qualified Domain Name.
1.  Select **CNAME** as the **Record Type**.
1.  Enter `hosted-vh1.discourse.org` as the **Record Value**.
1.  Click **Add Record**.


### Yahoo! Small Business


1.  Log in to your account at <a href="http://smallbusiness.yahoo.com/services">smallbusiness.yahoo.com</a>.
1.  Click **Domain Control Panel** below the domain you'd like to use with Discourse.
1.  Click **Manage Advanced DNS Settings**.
1.  Click **Add Record**.
1.  In the **Source** field, enter the part of the address you chose for your website using Discourse. For example, if you chose `www.example.com`, enter `www` in the **Source** field.
1.  Enter `hosted-vh1.discourse.org` in the **Destination** field.
1.  Click **Submit**.


### No-IP


1.  Log in to your account at <a href="http://www.no-ip.com/">No-IP</a>.
1.  On the left side, click **Host/Redirects**.
1.  Click **Manage** underneath **Host/Redirects**.
1.  Click **Add** for a new entry, or click **Modify** and skip to step six for an existing entry.
1.  Enter the part of the address that you picked for Discourse as the host name, and select your domain name. For example, if you entered `www.example.com` as your address, enter `www` as the host name.
1.  Select **DNS alias CNAME** at the host type.
1.  Enter `hosted-vh1.discourse.org` as the **Target Host** and click **Modify**.


### DNS Park


1.  Log in to your account at <a href="https://www.dnspark.net/">DNS Park</a>.
1.  On the left side, click **DNS Hosting**.
1.  Click the domain you'd like to use with Discourse.
1.  Since DNS Park is your hosting service, and not your domain registrar, be sure that your domain points to DNS Park's nameservers. This will allow your CNAME record configuration to take effect.
1.  Click **Alias Records**.
1.  Under **Host Name**, enter only the part of your website address that you designated for Discourse. If you picked `www.example.com` as your website's address, enter `www`.
1.  Enter `hosted-vh1.discourse.org` under **Destination Name**.
1.  Click **Add Alias**.


### eNom


1.  Log in to your account at <a href="http://www.enom.com/">www.enom.com</a>.
1.  From the drop-down menu at the **Domains** tab, select **My Domain**. You'll be directed to the **Manage Domains** page.
1.  Click the domain that you'd like to use with Discourse.
1.  Click **Host Settings**.
1.  To add a CNAME record, click **NEW ROW**. If you've already created a CNAME record for the address, simply edit the existing CNAME record.
1.  Enter the part of the address that you want to use with Discourse. For example, if you entered `www.example.com` as your address, enter `www`
1.  Enter `hosted-vh1.discourse.org` for the **host name**.
1.  Click **Save**.


### Network Solutions


1.  Log in to your account at <a href="http://www.networksolutions.com/">www.networksolutions.com</a>.
1.  In the left navigation bar, open the **nsWebAddress (Domains)** menu by clicking the **+ icon**.
1.  Click **Manage Domain Names**.
1.  On the Domain Details page for the domain you're using with Discourse, select the **Designated DNS** radio button to the right of **Change domain to point to**. (If you've already configured advanced DNS settings, click **Edit** next to **Advanced DNS Settings**.)
1.  Click the **Apply Changes** button.
1.  Under the **Advanced DNS Manager** heading, click **Manage Advanced DNS Records**.
1.  Under the **Host Aliases (CNAME Records)** heading, click **Add/Edit**.
1.  In the **Alias** box, enter your custom URL prefix (such as www).
1.  Select the radio button to the left of the **Other Host** box.
1.  Enter `hosted-vh1.discourse.org` in the **Other Host** box.
1.  Click **Continue**.
1.  Review your changes and click **Save Changes** to create the CNAME record.


### MyDomain.com


1.  Log in to your account at  <a href="http://www.mydomain.com/login/">MyDomain.com</a>.
1.  Click on the **My Services** tab.
1.  Under **Manage My Services**, click on **Manage Services**.
1.  Go to **Domain Overview**.
1.  Click on **Domain Administration**.
1.  Select the domain you're using with Discourse.
1.  Click the **DNS** tab, and select **DNS Records**.
1.  Click **Add New DNS record**.
1.  From the drop-down menu, select **CNAME**, and click **Next**.
1.  Enter your custom URL prefix (such as www), and then enter `hosted-vh1.discourse.org`
1.  Click **Finish**.


### Domain Direct


1.  Go to <a href="http://www.domaindirect.com/">domaindirect.com</a>.
1.  Click **my account**, and log in to your domain.
1.  On the **Domain** tab, click **Advanced Settings**.
1.  Click **Edit Zone File**. Note: Do not delete the A record for `*.domain.com` and  `domain.com`, or you will have problems later.
1. Under **CNAME**, create an entry for the part of the address that you want to use with Discourse. For example, if you are using `www.example.com` as your address, enter `www`.
1.  Point this CNAME record to `hosted-vh1.discourse.org`


### gandi.net


1.  Log in to your account at <a href="http://gandi.net/">gandi.net</a>.
1.  Click the **Administration** tab, and then click the **control panel** link.
1.  Click the domain you want to manage, and go to **Technical Settings**.
1.  Click **Manage DNS zone file**.
1. Click **Add an entry**, and for each field, do the following:
    1.  **Name:** Enter your custom URL prefix (such as www).
    1.  **Type:** Select CNAME.
    1.  **Value:** Enter `hosted-vh1.discourse.org.`, making sure to include a trailing dot (.) at the end of the value.
    1.  Click **Submit**.
1. <p>You should be back to the list of entries. Click **Submit Changes**</p>


### eurodns.com

1.  Log in to your account at <a href="http://eurodns.com/">eurodns.com</a>.
1.  Click **My Domains** in the **My Domains** menu on the left side of the page. A table listing your domains should appear.
1.  Click the **DNS** column on the row of the domain you wish to change. The DNS records for your domain should now be displayed.
1.  From the **Add...** drop-down menu of the **HOST NAME** table, choose **Host Alias**, and click the **Add** button next to it.
1.  In the **Alias:** field, add the name you chose for your service Discourse. For example, if you chose `www.example.com` as your address, enter `www`.
1.  Enter `hosted-vh1.discourse.org` in the **Host Name** field.
1.  Click the **Save Settings** button.


### Register.com


1.  Log in to your account at <a href="http://www.register.com/">register.com</a>.
1.  Under the **My Accounts** tab, click the domain that you're using with Discourse.
1.  Scroll down to the **Advanced Technical Settings** heading, and click **Edit Domain Aliases Records**.
1.  In the box to the left of your domain name, enter your URL prefix (such as www).
1.  Enter `hosted-vh1.discourse.org` in the **points to** box.
1.  Click **Continue**.
1.  Review your changes, and click **Continue** to create the CNAME record.


### myhosting.com


1.  Go to <a href="http://myhosting.com/">http://myhosting.com</a>.
1.  Click on the **Account** link at the top of the page.
1.  Log in with your **Domain Name** and **Password**.
1.  Click on the **Domain Name** tab.
1.  Click **DNS Management** in the left-hand pane.
1.  Click the **Manage DNS button**.
1.  Add an **ALIAS (CNAME) RECORD** by doing the following in the **ZONE SERVER** area:


### NameCheap


1.  Log in to your account at <a href="http://www.namecheap.com/myaccount/login-only.aspx">http://www.namecheap.com/myaccount/login-only.aspx</a>
1.  Click on **Your Domain/Products** in the right hand sidebar
1.  Click on the domain you are using under the main **Your Domains** heading
1.  Click on **URL Forwarding** under the **Host Management** tab on the left
1.  Enter `hosted-vh1.discourse.org` into the IP Address/URL column for both @ and www as a CNAME
1.  Click **Save Changes.**

(this page was [adapted from Fastly](https://docs.fastly.com/guides/getting-started/cname-instructions-for-most-providers) with permission.)

### Google Domains


1.  Log in to your account at <a href="https://domains.google.com">domains.google.com</a>.
1.  Click the domain that you're using with Discourse.
1.  Click on the  **Advanced** tab, and scroll to **Custom resource records** section.
1.  In the box to the left of your domain name, enter your URL prefix (such as www).
1.  Enter `hosted-vh1.discourse.org` in the **points to** box.
1.  Click **Add**.
