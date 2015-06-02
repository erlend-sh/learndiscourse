---
title: How to CAS authenticate
name: how-to-cas-authenticate
---

So this is pretty minimal implementation with some assumptions.
Assumptions:

 - all user email addresses are in one domain.
 - nothing funky is going on with the cas server.  No weird ports or non default paths.

There are three settings and all need to be set.  

 1. enable_cas_logins: "Enable CAS authentication"
 2. cas_hostname: "Hostname for cas server"
 3. cas_domainname: "Domain name generated email addresses for cas server"

Here's how to do it

1. Turn it on, set `enable_cas_logins` to true

2. Set where cas redirects to.  **cas.school.edu** and **cas.school.edu/cas** will both work.  All the URL's will get built based on this.  If your CAS server is funky this is were it will break.

3. An email address needs to be set for the user.  It is created by adding the username from CAS to the domain name.  If there are other needs let me know.  This is what we do but like other schools I am sure that we are idiosyncratic with it. 

It should now show up in the login panel.