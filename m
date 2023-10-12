Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AFACDB482
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 17:42:43 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.18960.1697132561096200727
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 10:42:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=joCWrU6Z;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 614809C2A80
	for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 13:42:40 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VYmwx5a0sILR; Thu, 12 Oct 2023 13:42:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B20CF9C2CD3;
	Thu, 12 Oct 2023 13:42:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B20CF9C2CD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697132558; bh=SLykfg4YiOWNLMqWyYQ/6sUKweEBma3/8UUHofpF/ZI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=joCWrU6ZNLP3GuRzHXOj0Iyc6qhrZyF2CNIMruwcu5u0DQgJ8zksg/VdW30BIDkjF
	 T0CSkwIuVnD2d9bt5eOEZ33M9x3rEMmIgseQE/jz5CPPu+ygp/jSICXdvwuDpC9Tkh
	 HP13h1THrImnea6hmaRnFp02nL4LNittEovedb7E86GAQYd7HvwcC7pCrMoCPNaaDH
	 6hN6eFUBP70u/dVIQxIjQ3kJS+TLxhODf3ocAFu3Tceuyf60RhyIj5RS6zuDH+pO3+
	 +6X1OaeyiptpJsCl5wsMOTTTjDNEYWFWvvOMoAXp3wf97XChBAHiZ4r4Tj05ekYogx
	 Z4dRN+ZlnAjpw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7_MO0PuKWQO0; Thu, 12 Oct 2023 13:42:38 -0400 (EDT)
Received: from savoirfairelinux.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 8EFAD9C2CC2;
	Thu, 12 Oct 2023 13:42:38 -0400 (EDT)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [PATCH 3/3] toaster: fixed functional test
Date: Thu, 12 Oct 2023 13:42:19 -0400
Message-Id: <20231012174219.62435-3-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012174219.62435-1-marlon.rodriguez-garcia@savoirfairelinux.com>
References: <20231012174219.62435-1-marlon.rodriguez-garcia@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 17:42:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15216

Updated functional test file to fix url access and added waiting time aft=
er click operations
to allow following elements to be available for tests, this will needed t=
o be revisited
when autobuilder is ready

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 .../tests/functional/test_functional_basic.py | 33 +++++++++++++------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/=
toaster/tests/functional/test_functional_basic.py
index 067ad99a..b0def544 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -7,7 +7,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
-import re
+import re, time
+from django.urls import reverse
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from orm.models import Project
 from selenium.webdriver.common.by import By
@@ -17,11 +18,11 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1514)
     def test_create_slenium_project(self):
         project_name =3D 'selenium-project'
-        self.get('')
-        self.driver.find_element(By.LINK_TEXT, "To start building, creat=
e your first Toaster project").click()
+        self.get(reverse('newproject'))
         self.driver.find_element(By.ID, "new-project-name").send_keys(pr=
oject_name)
         self.driver.find_element(By.ID, 'projectversion').click()
         self.driver.find_element(By.ID, "create-project-button").click()
+        time.sleep(2)
         element =3D self.wait_until_visible('#project-created-notificati=
on')
         self.assertTrue(self.element_exists('#project-created-notificati=
on'),'Project creation notification not shown')
         self.assertTrue(project_name in element.text,
@@ -31,15 +32,18 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
=20
  #  testcase (1515)
     def test_verify_left_bar_menu(self):
-        self.get('')
+        self.get(reverse('all-projects'))
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
+        time.sleep(2)
         self.assertTrue(self.element_exists('#config-nav'),'Configuratio=
n Tab does not exist')
         project_URL=3Dself.get_URL()
         self.driver.find_element(By.XPATH, '//a[@href=3D"'+project_URL+'=
"]').click()
+        time.sleep(2)
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'customimages/"'+"]").click()
+            time.sleep(2)
             self.assertTrue(re.search("Custom images",self.driver.find_e=
lement(By.XPATH, "//div[@class=3D'col-md-10']").text),'Custom images info=
rmation is not loading properly')
         except:
             self.fail(msg=3D'No Custom images tab available')
@@ -78,14 +82,16 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
     def test_review_configuration_information(self):
         self.get('')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
+        time.sleep(2)
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         project_URL=3Dself.get_URL()
-
+        time.sleep(2)
         try:
            self.assertTrue(self.element_exists('#machine-section'),'Mach=
ine section for the project configuration page does not exist')
            self.assertTrue(re.search("qemux86",self.driver.find_element(=
By.XPATH, "//span[@id=3D'project-machine-name']").text),'The machine type=
 is not assigned')
            self.driver.find_element(By.XPATH, "//span[@id=3D'change-mach=
ine-toggle']").click()
+           time.sleep(2)
            self.wait_until_visible('#select-machine-form')
            self.wait_until_visible('#cancel-machine-change')
            self.driver.find_element(By.XPATH, "//form[@id=3D'select-mach=
ine-form']/a[@id=3D'cancel-machine-change']").click()
@@ -123,13 +129,16 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
     def test_verify_machine_information(self):
         self.get('')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
+        time.sleep(2)
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
+        time.sleep(2)
=20
         try:
             self.assertTrue(self.element_exists('#machine-section'),'Mac=
hine section for the project configuration page does not exist')
             self.assertTrue(re.search("qemux86",self.driver.find_element=
(By.ID, "project-machine-name").text),'The machine type is not assigned')
             self.driver.find_element(By.ID, "change-machine-toggle").cli=
ck()
+            time.sleep(2)
             self.wait_until_visible('#select-machine-form')
             self.wait_until_visible('#cancel-machine-change')
             self.driver.find_element(By.ID, "cancel-machine-change").cli=
ck()
@@ -140,14 +149,15 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
     def test_verify_most_built_recipes_information(self):
         self.get('')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-
+        time.sleep(2)
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         project_URL=3Dself.get_URL()
-
+        time.sleep(2)
         try:
             self.assertTrue(re.search("You haven't built any recipes yet=
",self.driver.find_element(By.ID, "no-most-built").text),'Default message=
 of no builds is not present')
             self.driver.find_element(By.XPATH, "//div[@id=3D'no-most-bui=
lt']/p/a[@href=3D"+'"'+project_URL+'images/"'+"]").click()
+            time.sleep(2)
             self.assertTrue(re.search("Compatible image recipes",self.dr=
iver.find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Cho=
ose a recipe to build link  is not working  properly')
         except:
             self.fail(msg=3D'No Most built information in project detail=
 page')
@@ -156,8 +166,10 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase)=
:
     def test_verify_project_release_information(self):
         self.get('')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
+        time.sleep(2)
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
+        time.sleep(2)
=20
         try:
             self.assertTrue(re.search("Yocto Project master",self.driver=
.find_element(By.ID, "project-release-title").text),'The project release =
is not defined')
@@ -171,12 +183,12 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         project_URL=3Dself.get_URL()
-
+        time.sleep(2)
         try:
            self.driver.find_element(By.XPATH, "//div[@id=3D'layer-contai=
ner']")
            self.assertTrue(re.search("3",self.driver.find_element(By.ID,=
 "project-layers-count").text),'There should be 3 layers listed in the la=
yer count')
            layer_list =3D self.driver.find_element(By.ID, "layers-in-pro=
ject-list")
-           layers =3D layer_list.find_element(By.TAG_NAME, "li")
+           layers =3D layer_list.find_elements(By.TAG_NAME, "li")
=20
            for layer in layers:
                if re.match ("openembedded-core",layer.text):
@@ -199,10 +211,11 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
     def test_verify_project_detail_links(self):
         self.get('')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
+        time.sleep(2)
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         project_URL=3Dself.get_URL()
-
+        time.sleep(2)
         self.driver.find_element(By.XPATH, "//div[@id=3D'project-topbar'=
]/ul[@class=3D'nav nav-tabs']/li[@id=3D'topbar-configuration-tab']/a[@hre=
f=3D"+'"'+project_URL+'"'+"]").click()
         self.assertTrue(re.search("Configuration",self.driver.find_eleme=
nt(By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs']/l=
i[@id=3D'topbar-configuration-tab']/a[@href=3D"+'"'+project_URL+'"'+"]").=
text), 'Configuration tab in project topbar is misspelled')
=20
--=20
2.34.1


