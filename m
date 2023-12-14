Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6832C41535
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 22:08:52 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.41362.1702591730621350721
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Dec 2023 14:08:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=RsQS3FmR;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0278E9C40CA
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 17:08:50 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id LjdQc9DBSt7e; Thu, 14 Dec 2023 17:08:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0803B9C40F5;
	Thu, 14 Dec 2023 17:08:49 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0803B9C40F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702591729; bh=8z/JCjGiQE23CMuro8C6VFlhZ2hmAYtLmEoV/5F5ido=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=RsQS3FmRGyxiqu99IT5XVaUBZPP2mnqUUl/yd7bxOKLNi7cdLC/oVexKZd8IwqMyx
	 7T3/XvvouBqbu39rbfTtvViM67j/TUgKySd9tdweetPNqwG+Caga6qTJaZgfxEUJ2R
	 FhimNjjB2/mMWruUy4AtRQRx38JYTR4xmXVCDqer66PACG6BF9ex6WZ+IHXEGzPwra
	 YFrIJnGiidkwX0nSpChRC8rWwAsh1WKmI4q8kW2lay+0Q8SOqOOdrxDSqIPkcFNPxP
	 Na1q3F7xEA2MnrpFJkuJVcIrHuTQiQisNMstF3AOvh1udAT9BTKJDgEuH99K1wCYAX
	 uP9YhMMXkEdBw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id K4Dkmu09tCsz; Thu, 14 Dec 2023 17:08:48 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1DB4A9C40F3;
	Thu, 14 Dec 2023 17:08:47 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 4/6] toaster/test: Removed all time.sleep occurrence
Date: Thu, 14 Dec 2023 23:08:37 +0100
Message-Id: <20231214220839.598125-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214220839.598125-1-alassane.yattara@savoirfairelinux.com>
References: <20231214220839.598125-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 22:08:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15673

Use wait_until_visible instead of time.sleep to delay driver actions
Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_functional_basic.py | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/=
toaster/tests/functional/test_functional_basic.py
index dcd84c3f..5d7a86bb 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -15,7 +15,7 @@ from orm.models import Project
 from selenium.webdriver.common.by import By
=20
=20
-@pytest.mark.order("last")
+@pytest.mark.order("second_to_last")
 class FuntionalTestBasic(SeleniumFunctionalTestCase):
=20
 #   testcase (1514)
@@ -26,7 +26,6 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.driver.find_element(By.ID, "new-project-name").send_keys(pr=
oject_name)
         self.driver.find_element(By.ID, 'projectversion').click()
         self.driver.find_element(By.ID, "create-project-button").click()
-        time.sleep(2)
         element =3D self.wait_until_visible('#project-created-notificati=
on')
         self.assertTrue(self.element_exists('#project-created-notificati=
on'),'Project creation notification not shown')
         self.assertTrue(project_name in element.text,
@@ -39,45 +38,50 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.get(reverse('all-projects'))
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        time.sleep(2)
+        self.wait_until_visible('#config-nav')
         self.assertTrue(self.element_exists('#config-nav'),'Configuratio=
n Tab does not exist')
         project_URL=3Dself.get_URL()
         self.driver.find_element(By.XPATH, '//a[@href=3D"'+project_URL+'=
"]').click()
-        time.sleep(2)
+        self.wait_until_visible('#config-nav')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'customimages/"'+"]").click()
-            time.sleep(2)
+            self.wait_until_visible('#config-nav')
             self.assertTrue(re.search("Custom images",self.driver.find_e=
lement(By.XPATH, "//div[@class=3D'col-md-10']").text),'Custom images info=
rmation is not loading properly')
         except:
             self.fail(msg=3D'No Custom images tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'images/"'+"]").click()
+            self.wait_until_visible('#config-nav')
             self.assertTrue(re.search("Compatible image recipes",self.dr=
iver.find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Com=
patible image recipes information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible image tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'softwarerecipes/"'+"]").click()
+            self.wait_until_visible('#config-nav')
             self.assertTrue(re.search("Compatible software recipes",self=
.driver.find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The =
Compatible software recipe information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible software recipe tab available=
')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'machines/"'+"]").click()
+            self.wait_until_visible('#config-nav')
             self.assertTrue(re.search("Compatible machines",self.driver.=
find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Compatib=
le machine information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible machines tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'layers/"'+"]").click()
+            self.wait_until_visible('#config-nav')
             self.assertTrue(re.search("Compatible layers",self.driver.fi=
nd_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Compatible=
 layer information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible layers tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'configuration"'+"]").click()
+            self.wait_until_visible('#config-nav')
             self.assertTrue(re.search("Bitbake variables",self.driver.fi=
nd_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Bitbake va=
riables information is not loading properly')
         except:
             self.fail(msg=3D'No Bitbake variables tab available')
@@ -86,16 +90,14 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
     def test_review_configuration_information(self):
         self.get('')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        time.sleep(2)
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         project_URL=3Dself.get_URL()
-        time.sleep(2)
+        self.wait_until_visible('#config-nav')
         try:
            self.assertTrue(self.element_exists('#machine-section'),'Mach=
ine section for the project configuration page does not exist')
            self.assertTrue(re.search("qemux86-64",self.driver.find_eleme=
nt(By.XPATH, "//span[@id=3D'project-machine-name']").text),'The machine t=
ype is not assigned')
            self.driver.find_element(By.XPATH, "//span[@id=3D'change-mach=
ine-toggle']").click()
-           time.sleep(2)
            self.wait_until_visible('#select-machine-form')
            self.wait_until_visible('#cancel-machine-change')
            self.driver.find_element(By.XPATH, "//form[@id=3D'select-mach=
ine-form']/a[@id=3D'cancel-machine-change']").click()
@@ -133,16 +135,14 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
     def test_verify_machine_information(self):
         self.get('')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        time.sleep(2)
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        time.sleep(2)
+        self.wait_until_visible('#config-nav')
=20
         try:
             self.assertTrue(self.element_exists('#machine-section'),'Mac=
hine section for the project configuration page does not exist')
             self.assertTrue(re.search("qemux86-64",self.driver.find_elem=
ent(By.ID, "project-machine-name").text),'The machine type is not assigne=
d')
             self.driver.find_element(By.ID, "change-machine-toggle").cli=
ck()
-            time.sleep(2)
             self.wait_until_visible('#select-machine-form')
             self.wait_until_visible('#cancel-machine-change')
             self.driver.find_element(By.ID, "cancel-machine-change").cli=
ck()
@@ -153,15 +153,14 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
     def test_verify_most_built_recipes_information(self):
         self.get('')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        time.sleep(2)
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
+        self.wait_until_visible('#config-nav')
         project_URL=3Dself.get_URL()
-        time.sleep(2)
         try:
             self.assertTrue(re.search("You haven't built any recipes yet=
",self.driver.find_element(By.ID, "no-most-built").text),'Default message=
 of no builds is not present')
             self.driver.find_element(By.XPATH, "//div[@id=3D'no-most-bui=
lt']/p/a[@href=3D"+'"'+project_URL+'images/"'+"]").click()
-            time.sleep(2)
+            self.wait_until_visible('#config-nav')
             self.assertTrue(re.search("Compatible image recipes",self.dr=
iver.find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Cho=
ose a recipe to build link  is not working  properly')
         except:
             self.fail(msg=3D'No Most built information in project detail=
 page')
@@ -170,10 +169,9 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase)=
:
     def test_verify_project_release_information(self):
         self.get('')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        time.sleep(2)
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        time.sleep(2)
+        self.wait_until_visible('#config-nav')
=20
         try:
             self.assertTrue(re.search("Yocto Project master",self.driver=
.find_element(By.ID, "project-release-title").text),'The project release =
is not defined')
@@ -186,8 +184,8 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
+        self.wait_until_visible('#config-nav')
         project_URL=3Dself.get_URL()
-        time.sleep(2)
         try:
            self.driver.find_element(By.XPATH, "//div[@id=3D'layer-contai=
ner']")
            self.assertTrue(re.search("3",self.driver.find_element(By.ID,=
 "project-layers-count").text),'There should be 3 layers listed in the la=
yer count')
@@ -215,16 +213,17 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
     def test_verify_project_detail_links(self):
         self.get('')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        time.sleep(2)
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
+        self.wait_until_visible('#config-nav')
         project_URL=3Dself.get_URL()
-        time.sleep(2)
         self.driver.find_element(By.XPATH, "//div[@id=3D'project-topbar'=
]/ul[@class=3D'nav nav-tabs']/li[@id=3D'topbar-configuration-tab']/a[@hre=
f=3D"+'"'+project_URL+'"'+"]").click()
+        self.wait_until_visible('#config-nav')
         self.assertTrue(re.search("Configuration",self.driver.find_eleme=
nt(By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs']/l=
i[@id=3D'topbar-configuration-tab']/a[@href=3D"+'"'+project_URL+'"'+"]").=
text), 'Configuration tab in project topbar is misspelled')
=20
         try:
             self.driver.find_element(By.XPATH, "//div[@id=3D'project-top=
bar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'builds/=
"'+"]").click()
+            self.wait_until_visible('#project-topbar')
             self.assertTrue(re.search("Builds",self.driver.find_element(=
By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs']/li/a=
[@href=3D"+'"'+project_URL+'builds/"'+"]").text), 'Builds tab in project =
topbar is misspelled')
             self.driver.find_element(By.XPATH, "//div[@id=3D'empty-state=
-projectbuildstable']")
         except:
@@ -232,6 +231,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
=20
         try:
             self.driver.find_element(By.XPATH, "//div[@id=3D'project-top=
bar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'importl=
ayer"'+"]").click()
+            self.wait_until_visible('#project-topbar')
             self.assertTrue(re.search("Import layer",self.driver.find_el=
ement(By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs'=
]/li/a[@href=3D"+'"'+project_URL+'importlayer"'+"]").text), 'Import layer=
 tab in project topbar is misspelled')
             self.driver.find_element(By.XPATH, "//fieldset[@id=3D'repo-s=
elect']")
             self.driver.find_element(By.XPATH, "//fieldset[@id=3D'git-re=
po']")
@@ -240,6 +240,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
=20
         try:
             self.driver.find_element(By.XPATH, "//div[@id=3D'project-top=
bar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'newcust=
omimage/"'+"]").click()
+            self.wait_until_visible('#project-topbar')
             self.assertTrue(re.search("New custom image",self.driver.fin=
d_element(By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-t=
abs']/li/a[@href=3D"+'"'+project_URL+'newcustomimage/"'+"]").text), 'New =
custom image tab in project topbar is misspelled')
             self.assertTrue(re.search("Select the image recipe you want =
to customise",self.driver.find_element(By.XPATH, "//div[@class=3D'col-md-=
12']/h2").text),'The new custom image tab is not loading correctly')
         except:
--=20
2.34.1


