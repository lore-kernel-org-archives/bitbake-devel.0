Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8A1C35274
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 21:41:43 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.3132.1702935697318672992
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Dec 2023 13:41:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=gfQPnl1V;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7A5899C33AF
	for <bitbake-devel@lists.openembedded.org>; Mon, 18 Dec 2023 16:41:36 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id hRi-7xneynaG; Mon, 18 Dec 2023 16:41:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 71E5C9C354C;
	Mon, 18 Dec 2023 16:41:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 71E5C9C354C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702935695; bh=AopWfjuf8sYkTQnoMB94O2L59Tmn0BqezqPO76GJecA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=gfQPnl1VuF28XaDzO7R/x98qSg+Ph5aeilBi8paTPz/cIW6hri+VLBMdCbl+UDUcC
	 vDpv4+Eetzx1TcAceSC3yDZldqWUb3lUf4UNdZl7idUYt3lGQ+h1TtGdJD2c6Ow4jR
	 OiM7+ki4YGl8jePTHHKj6h5fKqr25VP7+jUeSO/w3pb6+ZGaWLcWTD5pqjEktz0Ali
	 sPLGmExfHVQ9IGVC3cJXBkgh0gfDBH9Pe1UzrIa6Ulokv7ZuNxPRpHS0jKGFc7wzEt
	 DUKPBbY7peJGbZB/4NJgfotDq84LSiFm7cihpqJ4j4+PLesmXhT+KUXtBKVRqW/UuS
	 oVCX/ZNfgsu7g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id dRg57SyebE9u; Mon, 18 Dec 2023 16:41:35 -0500 (EST)
Received: from jedi.. (unknown [105.66.132.133])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id ADC549C33AF;
	Mon, 18 Dec 2023 16:41:31 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] toaster/test: Bug-fix test_functional_basic, delay driver actions
Date: Mon, 18 Dec 2023 22:41:22 +0100
Message-Id: <20231218214122.616407-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Dec 2023 21:41:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15694

The errors causing faileds on functional_basic are d=C3=BB to the delay b=
etween actions,
increase between driver actions.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_functional_basic.py | 76 +++++++++----------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/=
toaster/tests/functional/test_functional_basic.py
index e48f13b0..47f7452e 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
-import re, time
+import re
 from django.urls import reverse
 import pytest
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
@@ -26,7 +26,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.driver.find_element(By.ID, "new-project-name").send_keys(pr=
oject_name)
         self.driver.find_element(By.ID, 'projectversion').click()
         self.driver.find_element(By.ID, "create-project-button").click()
-        element =3D self.wait_until_visible('#project-created-notificati=
on')
+        element =3D self.wait_until_visible('#project-created-notificati=
on', poll=3D10)
         self.assertTrue(self.element_exists('#project-created-notificati=
on'),'Project creation notification not shown')
         self.assertTrue(project_name in element.text,
                         "New project name not in new project notificatio=
n")
@@ -36,52 +36,52 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
  #  testcase (1515)
     def test_verify_left_bar_menu(self):
         self.get(reverse('all-projects'))
-        self.wait_until_visible('#projectstable')
+        self.wait_until_visible('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav')
+        self.wait_until_visible('#config-nav', poll=3D10)
         self.assertTrue(self.element_exists('#config-nav'),'Configuratio=
n Tab does not exist')
         project_URL=3Dself.get_URL()
         self.driver.find_element(By.XPATH, '//a[@href=3D"'+project_URL+'=
"]').click()
-        self.wait_until_visible('#config-nav')
+        self.wait_until_visible('#config-nav', poll=3D10)
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'customimages/"'+"]").click()
-            self.wait_until_visible('#config-nav')
+            self.wait_until_visible('#config-nav', poll=3D10)
             self.assertTrue(re.search("Custom images",self.driver.find_e=
lement(By.XPATH, "//div[@class=3D'col-md-10']").text),'Custom images info=
rmation is not loading properly')
         except:
             self.fail(msg=3D'No Custom images tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'images/"'+"]").click()
-            self.wait_until_visible('#config-nav')
+            self.wait_until_visible('#config-nav', poll=3D10)
             self.assertTrue(re.search("Compatible image recipes",self.dr=
iver.find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Com=
patible image recipes information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible image tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'softwarerecipes/"'+"]").click()
-            self.wait_until_visible('#config-nav')
+            self.wait_until_visible('#config-nav', poll=3D10)
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
-            self.wait_until_visible('#config-nav')
+            self.wait_until_visible('#config-nav', poll=3D10)
             self.assertTrue(re.search("Compatible machines",self.driver.=
find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Compatib=
le machine information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible machines tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'layers/"'+"]").click()
-            self.wait_until_visible('#config-nav')
+            self.wait_until_visible('#config-nav', poll=3D10)
             self.assertTrue(re.search("Compatible layers",self.driver.fi=
nd_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Compatible=
 layer information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible layers tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'configuration"'+"]").click()
-            self.wait_until_visible('#config-nav')
+            self.wait_until_visible('#config-nav', poll=3D10)
             self.assertTrue(re.search("Bitbake variables",self.driver.fi=
nd_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Bitbake va=
riables information is not loading properly')
         except:
             self.fail(msg=3D'No Bitbake variables tab available')
@@ -89,18 +89,18 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1516)
     def test_review_configuration_information(self):
         self.get('')
-        self.wait_until_visible('#global-nav')
+        self.wait_until_visible('#global-nav', poll=3D10)
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable')
+        self.wait_until_visible('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         project_URL=3Dself.get_URL()
-        self.wait_until_visible('#config-nav')
+        self.wait_until_visible('#config-nav', poll=3D10)
         try:
            self.assertTrue(self.element_exists('#machine-section'),'Mach=
ine section for the project configuration page does not exist')
            self.assertTrue(re.search("qemux86-64",self.driver.find_eleme=
nt(By.XPATH, "//span[@id=3D'project-machine-name']").text),'The machine t=
ype is not assigned')
            self.driver.find_element(By.XPATH, "//span[@id=3D'change-mach=
ine-toggle']").click()
-           self.wait_until_visible('#select-machine-form')
-           self.wait_until_visible('#cancel-machine-change')
+           self.wait_until_visible('#select-machine-form', poll=3D10)
+           self.wait_until_visible('#cancel-machine-change', poll=3D10)
            self.driver.find_element(By.XPATH, "//form[@id=3D'select-mach=
ine-form']/a[@id=3D'cancel-machine-change']").click()
         except:
            self.fail(msg=3D'The machine information is wrong in the conf=
iguration page')
@@ -135,18 +135,18 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
 #   testcase (1517)
     def test_verify_machine_information(self):
         self.get('')
-        self.wait_until_visible('#global-nav')
+        self.wait_until_visible('#global-nav', poll=3D10)
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable')
+        self.wait_until_visible('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav')
+        self.wait_until_visible('#config-nav', poll=3D10)
=20
         try:
             self.assertTrue(self.element_exists('#machine-section'),'Mac=
hine section for the project configuration page does not exist')
             self.assertTrue(re.search("qemux86-64",self.driver.find_elem=
ent(By.ID, "project-machine-name").text),'The machine type is not assigne=
d')
             self.driver.find_element(By.ID, "change-machine-toggle").cli=
ck()
-            self.wait_until_visible('#select-machine-form')
-            self.wait_until_visible('#cancel-machine-change')
+            self.wait_until_visible('#select-machine-form', poll=3D10)
+            self.wait_until_visible('#cancel-machine-change', poll=3D10)
             self.driver.find_element(By.ID, "cancel-machine-change").cli=
ck()
         except:
             self.fail(msg=3D'The machine information is wrong in the con=
figuration page')
@@ -154,16 +154,16 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
 #   testcase (1518)
     def test_verify_most_built_recipes_information(self):
         self.get('')
-        self.wait_until_visible('#global-nav')
+        self.wait_until_visible('#global-nav', poll=3D10)
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable')
+        self.wait_until_visible('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav')
+        self.wait_until_visible('#config-nav', poll=3D10)
         project_URL=3Dself.get_URL()
         try:
             self.assertTrue(re.search("You haven't built any recipes yet=
",self.driver.find_element(By.ID, "no-most-built").text),'Default message=
 of no builds is not present')
             self.driver.find_element(By.XPATH, "//div[@id=3D'no-most-bui=
lt']/p/a[@href=3D"+'"'+project_URL+'images/"'+"]").click()
-            self.wait_until_visible('#config-nav')
+            self.wait_until_visible('#config-nav', poll=3D10)
             self.assertTrue(re.search("Compatible image recipes",self.dr=
iver.find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Cho=
ose a recipe to build link  is not working  properly')
         except:
             self.fail(msg=3D'No Most built information in project detail=
 page')
@@ -171,11 +171,11 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
 #   testcase (1519)
     def test_verify_project_release_information(self):
         self.get('')
-        self.wait_until_visible('#global-nav')
+        self.wait_until_visible('#global-nav', poll=3D10)
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable')
+        self.wait_until_visible('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav')
+        self.wait_until_visible('#config-nav', poll=3D10)
=20
         try:
             self.assertTrue(re.search("Yocto Project master",self.driver=
.find_element(By.ID, "project-release-title").text),'The project release =
is not defined')
@@ -185,11 +185,11 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
 #   testcase (1520)
     def test_verify_layer_information(self):
         self.get('')
-        self.wait_until_visible('#global-nav')
+        self.wait_until_visible('#global-nav', poll=3D10)
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable')
+        self.wait_until_visible('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav')
+        self.wait_until_visible('#config-nav', poll=3D10)
         project_URL=3Dself.get_URL()
         try:
            self.driver.find_element(By.XPATH, "//div[@id=3D'layer-contai=
ner']")
@@ -217,19 +217,19 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
 #   testcase (1521)
     def test_verify_project_detail_links(self):
         self.get('')
-        self.wait_until_visible('#global-nav')
+        self.wait_until_visible('#global-nav', poll=3D10)
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable')
+        self.wait_until_visible('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav')
+        self.wait_until_visible('#config-nav', poll=3D10)
         project_URL=3Dself.get_URL()
         self.driver.find_element(By.XPATH, "//div[@id=3D'project-topbar'=
]/ul[@class=3D'nav nav-tabs']/li[@id=3D'topbar-configuration-tab']/a[@hre=
f=3D"+'"'+project_URL+'"'+"]").click()
-        self.wait_until_visible('#config-nav')
+        self.wait_until_visible('#config-nav', poll=3D10)
         self.assertTrue(re.search("Configuration",self.driver.find_eleme=
nt(By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs']/l=
i[@id=3D'topbar-configuration-tab']/a[@href=3D"+'"'+project_URL+'"'+"]").=
text), 'Configuration tab in project topbar is misspelled')
=20
         try:
             self.driver.find_element(By.XPATH, "//div[@id=3D'project-top=
bar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'builds/=
"'+"]").click()
-            self.wait_until_visible('#project-topbar')
+            self.wait_until_visible('#project-topbar', poll=3D10)
             self.assertTrue(re.search("Builds",self.driver.find_element(=
By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs']/li/a=
[@href=3D"+'"'+project_URL+'builds/"'+"]").text), 'Builds tab in project =
topbar is misspelled')
             self.driver.find_element(By.XPATH, "//div[@id=3D'empty-state=
-projectbuildstable']")
         except:
@@ -237,7 +237,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
=20
         try:
             self.driver.find_element(By.XPATH, "//div[@id=3D'project-top=
bar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'importl=
ayer"'+"]").click()
-            self.wait_until_visible('#project-topbar')
+            self.wait_until_visible('#project-topbar', poll=3D10)
             self.assertTrue(re.search("Import layer",self.driver.find_el=
ement(By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs'=
]/li/a[@href=3D"+'"'+project_URL+'importlayer"'+"]").text), 'Import layer=
 tab in project topbar is misspelled')
             self.driver.find_element(By.XPATH, "//fieldset[@id=3D'repo-s=
elect']")
             self.driver.find_element(By.XPATH, "//fieldset[@id=3D'git-re=
po']")
@@ -246,7 +246,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
=20
         try:
             self.driver.find_element(By.XPATH, "//div[@id=3D'project-top=
bar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'newcust=
omimage/"'+"]").click()
-            self.wait_until_visible('#project-topbar')
+            self.wait_until_visible('#project-topbar', poll=3D10)
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


