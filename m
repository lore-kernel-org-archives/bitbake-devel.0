Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D692C47074
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 15:10:57 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.150605.1703862648843780350
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Dec 2023 07:10:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=HvDcpG7x;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B149F9C354C
	for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 10:10:47 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id xJCBOukt1Uxe; Fri, 29 Dec 2023 10:10:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A05D39C27A2;
	Fri, 29 Dec 2023 10:10:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com A05D39C27A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1703862646; bh=TO32D7SFVkQ/w8LKp7FlQs5SCxm8Kp4TL+fLfXMRanQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=HvDcpG7xL1Jy5Sfgb9HV8ESX0ZzfuBB433yTCj7oGJj9BgXcwhqOP22HeTPSKZE4g
	 R02XxBEBQ5xz4DQ0jxdI/qqxtECvIF6fgFU9LlhuN2eA+LBlxukh5sXikk/mUWZK6c
	 cdI3XV6Z2HQGEvJPY+mN0d67P+saMR9i01rkjtO3ViWzM0X/ilDERDdtjvX8Z2vtP7
	 1fMq+0VspszkElz91rs17Mh8iMBULvwQIVu8KPut2x1Y2f1tKr6NUHbjrrbgTnCquh
	 4YOlvkdAvOxuUgN1GL5nTMImhQbHYUbZWg0hSzx4XyB0JP1Hit2ko/cvJT4kMEyEaY
	 5bEgWD2xyon8w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 9OCnSiypAKtG; Fri, 29 Dec 2023 10:10:46 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id BA1E29C14F4;
	Fri, 29 Dec 2023 10:10:45 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/4] toaster/test: bug-fix An element matching "#projectstable" should be visible
Date: Fri, 29 Dec 2023 16:10:21 +0100
Message-Id: <20231229151024.43476-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 15:10:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15721

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/selenium_helpers_base.py    |  2 +
 .../tests/functional/test_functional_basic.py | 87 ++++++++++---------
 2 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toa=
ster/tests/browser/selenium_helpers_base.py
index 13806624..562fedec 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -206,6 +206,8 @@ class SeleniumTestCaseBase(unittest.TestCase):
         is_present =3D lambda driver: self.find(selector)
         msg =3D 'An element matching "%s" should be on the page' % selec=
tor
         element =3D Wait(self.driver, poll=3Dpoll).until(is_present, msg=
)
+        if poll > 2:
+            time.sleep(poll)  # element need more delay to be present
         return element
=20
     def wait_until_visible(self, selector, poll=3D1):
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/=
toaster/tests/functional/test_functional_basic.py
index 47f7452e..e4070fbb 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -14,15 +14,27 @@ from tests.functional.functional_helpers import Selen=
iumFunctionalTestCase
 from orm.models import Project
 from selenium.webdriver.common.by import By
=20
+from tests.functional.utils import get_projectId_from_url
=20
+
+@pytest.mark.django_db
 @pytest.mark.order("second_to_last")
 class FuntionalTestBasic(SeleniumFunctionalTestCase):
+    """Basic functional tests for Toaster"""
+    project_id =3D None
+
+    def setUp(self):
+        super(FuntionalTestBasic, self).setUp()
+        if not FuntionalTestBasic.project_id:
+            self._create_slenium_project()
+            current_url =3D self.driver.current_url
+            FuntionalTestBasic.project_id =3D get_projectId_from_url(cur=
rent_url)
=20
 #   testcase (1514)
-    @pytest.mark.django_db
-    def test_create_slenium_project(self):
+    def _create_slenium_project(self):
         project_name =3D 'selenium-project'
         self.get(reverse('newproject'))
+        self.wait_until_visible('#new-project-name', poll=3D3)
         self.driver.find_element(By.ID, "new-project-name").send_keys(pr=
oject_name)
         self.driver.find_element(By.ID, 'projectversion').click()
         self.driver.find_element(By.ID, "create-project-button").click()
@@ -32,69 +44,68 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
                         "New project name not in new project notificatio=
n")
         self.assertTrue(Project.objects.filter(name=3Dproject_name).coun=
t(),
                         "New project not found in database")
+        return Project.objects.last().id
=20
  #  testcase (1515)
     def test_verify_left_bar_menu(self):
         self.get(reverse('all-projects'))
-        self.wait_until_visible('#projectstable', poll=3D10)
+        self.wait_until_present('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav', poll=3D10)
+        self.wait_until_present('#config-nav', poll=3D10)
         self.assertTrue(self.element_exists('#config-nav'),'Configuratio=
n Tab does not exist')
         project_URL=3Dself.get_URL()
         self.driver.find_element(By.XPATH, '//a[@href=3D"'+project_URL+'=
"]').click()
-        self.wait_until_visible('#config-nav', poll=3D10)
+        self.wait_until_present('#config-nav', poll=3D10)
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'customimages/"'+"]").click()
-            self.wait_until_visible('#config-nav', poll=3D10)
+            self.wait_until_present('#config-nav', poll=3D10)
             self.assertTrue(re.search("Custom images",self.driver.find_e=
lement(By.XPATH, "//div[@class=3D'col-md-10']").text),'Custom images info=
rmation is not loading properly')
         except:
             self.fail(msg=3D'No Custom images tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'images/"'+"]").click()
-            self.wait_until_visible('#config-nav', poll=3D10)
+            self.wait_until_present('#config-nav', poll=3D10)
             self.assertTrue(re.search("Compatible image recipes",self.dr=
iver.find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Com=
patible image recipes information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible image tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'softwarerecipes/"'+"]").click()
-            self.wait_until_visible('#config-nav', poll=3D10)
+            self.wait_until_present('#config-nav', poll=3D10)
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
-            self.wait_until_visible('#config-nav', poll=3D10)
+            self.wait_until_present('#config-nav', poll=3D10)
             self.assertTrue(re.search("Compatible machines",self.driver.=
find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Compatib=
le machine information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible machines tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'layers/"'+"]").click()
-            self.wait_until_visible('#config-nav', poll=3D10)
+            self.wait_until_present('#config-nav', poll=3D10)
             self.assertTrue(re.search("Compatible layers",self.driver.fi=
nd_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Compatible=
 layer information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible layers tab available')
=20
         try:
             self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'configuration"'+"]").click()
-            self.wait_until_visible('#config-nav', poll=3D10)
+            self.wait_until_present('#config-nav', poll=3D10)
             self.assertTrue(re.search("Bitbake variables",self.driver.fi=
nd_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Bitbake va=
riables information is not loading properly')
         except:
             self.fail(msg=3D'No Bitbake variables tab available')
=20
 #   testcase (1516)
     def test_review_configuration_information(self):
-        self.get('')
-        self.wait_until_visible('#global-nav', poll=3D10)
-        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable', poll=3D10)
+        self.get(reverse('all-projects'))
+        self.wait_until_present('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         project_URL=3Dself.get_URL()
-        self.wait_until_visible('#config-nav', poll=3D10)
+        self.wait_until_present('#config-nav', poll=3D10)
         try:
            self.assertTrue(self.element_exists('#machine-section'),'Mach=
ine section for the project configuration page does not exist')
            self.assertTrue(re.search("qemux86-64",self.driver.find_eleme=
nt(By.XPATH, "//span[@id=3D'project-machine-name']").text),'The machine t=
ype is not assigned')
@@ -134,12 +145,10 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
=20
 #   testcase (1517)
     def test_verify_machine_information(self):
-        self.get('')
-        self.wait_until_visible('#global-nav', poll=3D10)
-        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable', poll=3D10)
+        self.get(reverse('all-projects'))
+        self.wait_until_present('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav', poll=3D10)
+        self.wait_until_present('#config-nav', poll=3D10)
=20
         try:
             self.assertTrue(self.element_exists('#machine-section'),'Mac=
hine section for the project configuration page does not exist')
@@ -153,29 +162,25 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
=20
 #   testcase (1518)
     def test_verify_most_built_recipes_information(self):
-        self.get('')
-        self.wait_until_visible('#global-nav', poll=3D10)
-        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable', poll=3D10)
+        self.get(reverse('all-projects'))
+        self.wait_until_present('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav', poll=3D10)
+        self.wait_until_present('#config-nav', poll=3D10)
         project_URL=3Dself.get_URL()
         try:
             self.assertTrue(re.search("You haven't built any recipes yet=
",self.driver.find_element(By.ID, "no-most-built").text),'Default message=
 of no builds is not present')
             self.driver.find_element(By.XPATH, "//div[@id=3D'no-most-bui=
lt']/p/a[@href=3D"+'"'+project_URL+'images/"'+"]").click()
-            self.wait_until_visible('#config-nav', poll=3D10)
+            self.wait_until_present('#config-nav', poll=3D10)
             self.assertTrue(re.search("Compatible image recipes",self.dr=
iver.find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Cho=
ose a recipe to build link  is not working  properly')
         except:
             self.fail(msg=3D'No Most built information in project detail=
 page')
=20
 #   testcase (1519)
     def test_verify_project_release_information(self):
-        self.get('')
-        self.wait_until_visible('#global-nav', poll=3D10)
-        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable', poll=3D10)
+        self.get(reverse('all-projects'))
+        self.wait_until_present('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav', poll=3D10)
+        self.wait_until_present('#config-nav', poll=3D10)
=20
         try:
             self.assertTrue(re.search("Yocto Project master",self.driver=
.find_element(By.ID, "project-release-title").text),'The project release =
is not defined')
@@ -184,12 +189,10 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
=20
 #   testcase (1520)
     def test_verify_layer_information(self):
-        self.get('')
-        self.wait_until_visible('#global-nav', poll=3D10)
-        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable', poll=3D10)
+        self.get(reverse('all-projects'))
+        self.wait_until_present('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav', poll=3D10)
+        self.wait_until_present('#config-nav', poll=3D10)
         project_URL=3Dself.get_URL()
         try:
            self.driver.find_element(By.XPATH, "//div[@id=3D'layer-contai=
ner']")
@@ -216,15 +219,13 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
=20
 #   testcase (1521)
     def test_verify_project_detail_links(self):
-        self.get('')
-        self.wait_until_visible('#global-nav', poll=3D10)
-        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
-        self.wait_until_visible('#projectstable', poll=3D10)
+        self.get(reverse('all-projects'))
+        self.wait_until_present('#projectstable', poll=3D10)
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
-        self.wait_until_visible('#config-nav', poll=3D10)
+        self.wait_until_present('#config-nav', poll=3D10)
         project_URL=3Dself.get_URL()
         self.driver.find_element(By.XPATH, "//div[@id=3D'project-topbar'=
]/ul[@class=3D'nav nav-tabs']/li[@id=3D'topbar-configuration-tab']/a[@hre=
f=3D"+'"'+project_URL+'"'+"]").click()
-        self.wait_until_visible('#config-nav', poll=3D10)
+        self.wait_until_present('#config-nav', poll=3D10)
         self.assertTrue(re.search("Configuration",self.driver.find_eleme=
nt(By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs']/l=
i[@id=3D'topbar-configuration-tab']/a[@href=3D"+'"'+project_URL+'"'+"]").=
text), 'Configuration tab in project topbar is misspelled')
=20
         try:
--=20
2.34.1


