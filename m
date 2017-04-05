Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id B650577AC7
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Apr 2017 22:27:52 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v35MRrpK024140
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 5 Apr 2017 15:27:53 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.216.91) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 5 Apr 2017 15:27:52 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 5 Apr 2017 15:18:20 -0700
Message-ID: <735fba0573a2adfd6e167e8abe092565dbed9fc5.1491430559.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1491430559.git.David.Reyna@windriver.com>
References: <cover.1491430559.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.216.91]
Subject: [PATCH 1/1] toaster:test:Create selenium tests for project dashboard page
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 05 Apr 2017 22:27:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: David Reyna <David.Reyna@windriver.com>

Added 7 new testcases that verify the UI interface and elements of the project detail page.
This testcases can be found on testopia in the links:

Verifies that the project is created and that you get redirected to the configuration page
https://bugzilla.yoctoproject.org/tr_show_case.cgi?case_id=1514

Verifies that the left side bar menu, all links are clickable and they show on the UI
https://bugzilla.yoctoproject.org/tr_show_case.cgi?case_id=1515

Verifies that after creating a project the default project configuration is created
https://bugzilla.yoctoproject.org/tr_show_case.cgi?case_id=1516

Verifies that the default machine is set, once creating the project
https://bugzilla.yoctoproject.org/tr_show_case.cgi?case_id=1517

Verifies the built recipes information of the project detail page
https://bugzilla.yoctoproject.org/tr_show_case.cgi?case_id=1518

Verifies the default release information of the project
https://bugzilla.yoctoproject.org/tr_show_case.cgi?case_id=1519

Verifies that the default layers are assigned to the project
https://bugzilla.yoctoproject.org/tr_show_case.cgi?case_id=1520

Verifies that the links to the Configuration, Builds, Import layer and New Custom Image are present and work.

[YOCTO #9808]

Signed-off-by: Libertad Cruz <libertad.cruz@intel.com>
Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/tests/builds/buildtest.py              | 110 +++++-----
 lib/toaster/tests/functional/__init__.py           |   0
 lib/toaster/tests/functional/functional_helpers.py | 122 +++++++++++
 .../tests/functional/test_functional_basic.py      | 243 +++++++++++++++++++++
 4 files changed, 421 insertions(+), 54 deletions(-)
 create mode 100644 bitbake/lib/toaster/tests/functional/__init__.py
 create mode 100644 bitbake/lib/toaster/tests/functional/functional_helpers.py
 create mode 100644 bitbake/lib/toaster/tests/functional/test_functional_basic.py

diff --git a/lib/toaster/tests/builds/buildtest.py b/lib/toaster/tests/builds/buildtest.py
index bf147f0..5a56a11 100644
--- a/lib/toaster/tests/builds/buildtest.py
+++ b/lib/toaster/tests/builds/buildtest.py
@@ -41,6 +41,61 @@ logger = logging.getLogger("toaster")
 # want to wrap everything in a database transaction as an external process
 # (bitbake needs access to the database)
 
+def load_build_environment():
+    call_command('loaddata', 'settings.xml', app_label="orm")
+    call_command('loaddata', 'poky.xml', app_label="orm")
+
+    current_builddir = os.environ.get("BUILDDIR")
+    if current_builddir:
+        BuildTest.BUILDDIR = current_builddir
+    else:
+        # Setup a builddir based on default layout
+        # bitbake inside openebedded-core
+        oe_init_build_env_path = os.path.join(
+            os.path.dirname(os.path.abspath(__file__)),
+            os.pardir,
+            os.pardir,
+            os.pardir,
+            os.pardir,
+            os.pardir,
+            'oe-init-build-env'
+        )
+        if not os.path.exists(oe_init_build_env_path):
+            raise Exception("We had no BUILDDIR set and couldn't "
+                            "find oe-init-build-env to set this up "
+                            "ourselves please run oe-init-build-env "
+                            "before running these tests")
+
+        oe_init_build_env_path = os.path.realpath(oe_init_build_env_path)
+        cmd = "bash -c 'source oe-init-build-env %s'" % BuildTest.BUILDDIR
+        p = subprocess.Popen(
+            cmd,
+            cwd=os.path.dirname(oe_init_build_env_path),
+            shell=True,
+            stdout=subprocess.PIPE,
+            stderr=subprocess.PIPE)
+
+        output, err = p.communicate()
+        p.wait()
+
+        logger.info("oe-init-build-env %s %s" % (output, err))
+
+        os.environ['BUILDDIR'] = BuildTest.BUILDDIR
+
+    # Setup the path to bitbake we know where to find this
+    bitbake_path = os.path.join(
+        os.path.dirname(os.path.abspath(__file__)),
+        os.pardir,
+        os.pardir,
+        os.pardir,
+        os.pardir,
+        'bin',
+        'bitbake')
+    if not os.path.exists(bitbake_path):
+        raise Exception("Could not find bitbake at the expected path %s"
+                        % bitbake_path)
+
+    os.environ['BBBASEDIR'] = bitbake_path
 
 class BuildTest(unittest.TestCase):
 
@@ -59,60 +114,7 @@ class BuildTest(unittest.TestCase):
         if built:
             return built
 
-        call_command('loaddata', 'settings.xml', app_label="orm")
-        call_command('loaddata', 'poky.xml', app_label="orm")
-
-        current_builddir = os.environ.get("BUILDDIR")
-        if current_builddir:
-            BuildTest.BUILDDIR = current_builddir
-        else:
-            # Setup a builddir based on default layout
-            # bitbake inside openebedded-core
-            oe_init_build_env_path = os.path.join(
-                os.path.dirname(os.path.abspath(__file__)),
-                os.pardir,
-                os.pardir,
-                os.pardir,
-                os.pardir,
-                os.pardir,
-                'oe-init-build-env'
-            )
-            if not os.path.exists(oe_init_build_env_path):
-                raise Exception("We had no BUILDDIR set and couldn't "
-                                "find oe-init-build-env to set this up "
-                                "ourselves please run oe-init-build-env "
-                                "before running these tests")
-
-            oe_init_build_env_path = os.path.realpath(oe_init_build_env_path)
-            cmd = "bash -c 'source oe-init-build-env %s'" % BuildTest.BUILDDIR
-            p = subprocess.Popen(
-                cmd,
-                cwd=os.path.dirname(oe_init_build_env_path),
-                shell=True,
-                stdout=subprocess.PIPE,
-                stderr=subprocess.PIPE)
-
-            output, err = p.communicate()
-            p.wait()
-
-            logger.info("oe-init-build-env %s %s" % (output, err))
-
-            os.environ['BUILDDIR'] = BuildTest.BUILDDIR
-
-        # Setup the path to bitbake we know where to find this
-        bitbake_path = os.path.join(
-            os.path.dirname(os.path.abspath(__file__)),
-            os.pardir,
-            os.pardir,
-            os.pardir,
-            os.pardir,
-            'bin',
-            'bitbake')
-        if not os.path.exists(bitbake_path):
-            raise Exception("Could not find bitbake at the expected path %s"
-                            % bitbake_path)
-
-        os.environ['BBBASEDIR'] = bitbake_path
+        load_build_environment()
 
         BuildEnvironment.objects.get_or_create(
             betype=BuildEnvironment.TYPE_LOCAL,
diff --git a/lib/toaster/tests/functional/__init__.py b/lib/toaster/tests/functional/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toaster/tests/functional/functional_helpers.py
new file mode 100644
index 0000000..486078a
--- /dev/null
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -0,0 +1,122 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster functional tests implementation
+#
+# Copyright (C) 2017 Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import os
+import logging
+import subprocess
+import signal
+import time
+import re
+
+from tests.browser.selenium_helpers_base import SeleniumTestCaseBase
+from tests.builds.buildtest import load_build_environment
+
+logger = logging.getLogger("toaster")
+
+class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
+    wait_toaster_time = 5
+
+    @classmethod
+    def setUpClass(cls):
+        # So that the buildinfo helper uses the test database'
+        if os.environ.get('DJANGO_SETTINGS_MODULE', '') != \
+            'toastermain.settings_test':
+            raise RuntimeError("Please initialise django with the tests settings:  " \
+                "DJANGO_SETTINGS_MODULE='toastermain.settings_test'")
+
+        load_build_environment()
+
+        # start toaster
+        cmd = "bash -c 'source toaster start'"
+        p = subprocess.Popen(
+            cmd,
+            cwd=os.environ.get("BUILDDIR"),
+            shell=True)
+        if p.wait() != 0:
+            raise RuntimeError("Can't initialize toaster")
+
+        super(SeleniumFunctionalTestCase, cls).setUpClass()
+        cls.live_server_url = 'http://localhost:8000/'
+
+    @classmethod
+    def tearDownClass(cls):
+        super(SeleniumFunctionalTestCase, cls).tearDownClass()
+
+        # XXX: source toaster stop gets blocked, to review why?
+        # from now send SIGTERM by hand
+        time.sleep(cls.wait_toaster_time)
+        builddir = os.environ.get("BUILDDIR")
+
+        with open(os.path.join(builddir, '.toastermain.pid'), 'r') as f:
+            toastermain_pid = int(f.read())
+            os.kill(toastermain_pid, signal.SIGTERM)
+        with open(os.path.join(builddir, '.runbuilds.pid'), 'r') as f:
+            runbuilds_pid = int(f.read())
+            os.kill(runbuilds_pid, signal.SIGTERM)
+
+
+    def get_URL(self):
+         rc=self.get_page_source()
+         project_url=re.search("(projectPageUrl\s:\s\")(.*)(\",)",rc)
+         return project_url.group(2)
+
+
+    def find_element_by_link_text_in_table(self, table_id, link_text):
+        """
+        Assume there're multiple suitable "find_element_by_link_text".
+        In this circumstance we need to specify "table".
+        """
+        try:
+            table_element = self.get_table_element(table_id)
+            element = table_element.find_element_by_link_text(link_text)
+        except NoSuchElementException as e:
+            print('no element found')
+            raise
+        return element
+
+    def get_table_element(self, table_id, *coordinate):
+        if len(coordinate) == 0:
+#return whole-table element
+            element_xpath = "//*[@id='" + table_id + "']"
+            try:
+                element = self.driver.find_element_by_xpath(element_xpath)
+            except NoSuchElementException as e:
+                raise
+            return element
+        row = coordinate[0]
+
+        if len(coordinate) == 1:
+#return whole-row element
+            element_xpath = "//*[@id='" + table_id + "']/tbody/tr[" + str(row) + "]"
+            try:
+                element = self.driver.find_element_by_xpath(element_xpath)
+            except NoSuchElementException as e:
+                return False
+            return element
+#now we are looking for an element with specified X and Y
+        column = coordinate[1]
+
+        element_xpath = "//*[@id='" + table_id + "']/tbody/tr[" + str(row) + "]/td[" + str(column) + "]"
+        try:
+            element = self.driver.find_element_by_xpath(element_xpath)
+        except NoSuchElementException as e:
+            return False
+        return element
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/toaster/tests/functional/test_functional_basic.py
new file mode 100644
index 0000000..cfa2b0f
--- /dev/null
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -0,0 +1,243 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster functional tests implementation
+#
+# Copyright (C) 2017 Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import time
+import re
+from tests.functional.functional_helpers import SeleniumFunctionalTestCase
+from orm.models import Project
+
+class FuntionalTestBasic(SeleniumFunctionalTestCase):
+
+#   testcase (1514)
+    def test_create_slenium_project(self):
+        project_name = 'selenium-project'
+        self.get('')
+        self.driver.find_element_by_link_text("To start building, create your first Toaster project").click()
+        self.driver.find_element_by_id("new-project-name").send_keys(project_name)
+        self.driver.find_element_by_id('projectversion').click()
+        self.driver.find_element_by_id("create-project-button").click()
+        element = self.wait_until_visible('#project-created-notification')
+        self.assertTrue(self.element_exists('#project-created-notification'),'Project creation notification not shown')
+        self.assertTrue(project_name in element.text,
+                        "New project name not in new project notification")
+        self.assertTrue(Project.objects.filter(name=project_name).count(),
+                        "New project not found in database")
+
+ #  testcase (1515)
+    def test_verify_left_bar_menu(self):
+        self.get('')
+        self.wait_until_visible('#projectstable')
+        self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
+        self.assertTrue(self.element_exists('#config-nav'),'Configuration Tab does not exist')
+        project_URL=self.get_URL()
+        self.driver.find_element_by_xpath('//a[@href="'+project_URL+'"]').click()
+
+        try:
+            self.driver.find_element_by_xpath("//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'customimages/"'+"]").click()
+            self.assertTrue(re.search("Custom images",self.driver.find_element_by_xpath("//div[@class='col-md-10']").text),'Custom images information is not loading properly')
+        except:
+            self.fail(msg='No Custom images tab available')
+
+        try:
+            self.driver.find_element_by_xpath("//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'images/"'+"]").click()
+            self.assertTrue(re.search("Compatible image recipes",self.driver.find_element_by_xpath("//div[@class='col-md-10']").text),'The Compatible image recipes information is not loading properly')
+        except:
+            self.fail(msg='No Compatible image tab available')
+
+        try:
+            self.driver.find_element_by_xpath("//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'softwarerecipes/"'+"]").click()
+            self.assertTrue(re.search("Compatible software recipes",self.driver.find_element_by_xpath("//div[@class='col-md-10']").text),'The Compatible software recipe information is not loading properly')
+        except:
+            self.fail(msg='No Compatible software recipe tab available')
+
+        try:
+            self.driver.find_element_by_xpath("//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'machines/"'+"]").click()
+            self.assertTrue(re.search("Compatible machines",self.driver.find_element_by_xpath("//div[@class='col-md-10']").text),'The Compatible machine information is not loading properly')
+        except:
+            self.fail(msg='No Compatible machines tab available')
+
+        try:
+            self.driver.find_element_by_xpath("//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'layers/"'+"]").click()
+            self.assertTrue(re.search("Compatible layers",self.driver.find_element_by_xpath("//div[@class='col-md-10']").text),'The Compatible layer information is not loading properly')
+        except:
+            self.fail(msg='No Compatible layers tab available')
+
+        try:
+            self.driver.find_element_by_xpath("//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'configuration"'+"]").click()
+            self.assertTrue(re.search("Bitbake variables",self.driver.find_element_by_xpath("//div[@class='col-md-10']").text),'The Bitbake variables information is not loading properly')
+        except:
+            self.fail(msg='No Bitbake variables tab available')
+
+#   testcase (1516)
+    def test_review_configuration_information(self):
+        self.get('')
+        self.driver.find_element_by_xpath("//div[@id='global-nav']/ul/li/a[@href="+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.wait_until_visible('#projectstable')
+        self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
+        project_URL=self.get_URL()
+
+        try:
+           self.assertTrue(self.element_exists('#machine-section'),'Machine section for the project configuration page does not exist')
+           self.assertTrue(re.search("qemux86",self.driver.find_element_by_xpath("//span[@id='project-machine-name']").text),'The machine type is not assigned')
+           self.driver.find_element_by_xpath("//span[@id='change-machine-toggle']").click()
+           self.wait_until_visible('#select-machine-form')
+           self.wait_until_visible('#cancel-machine-change')
+           self.driver.find_element_by_xpath("//form[@id='select-machine-form']/a[@id='cancel-machine-change']").click()
+        except:
+           self.fail(msg='The machine information is wrong in the configuration page')
+
+        try:
+           self.driver.find_element_by_id('no-most-built')
+        except:
+           self.fail(msg='No Most built information in project detail page')
+
+        try:
+           self.assertTrue(re.search("Yocto Project master",self.driver.find_element_by_xpath("//span[@id='project-release-title']").text),'The project release is not defined')
+        except:
+           self.fail(msg='No project release title information in project detail page')
+
+        try:
+           self.driver.find_element_by_xpath("//div[@id='layer-container']")
+           self.assertTrue(re.search("3",self.driver.find_element_by_id("project-layers-count").text),'There should be 3 layers listed in the layer count')
+           layer_list = self.driver.find_element_by_id("layers-in-project-list")
+           layers = layer_list.find_elements_by_tag_name("li")
+           for layer in layers:
+               if re.match ("openembedded-core",layer.text):
+                    print ("openembedded-core layer is a default layer in the project configuration")
+               elif re.match ("meta-poky",layer.text):
+                  print ("meta-poky layer is a default layer in the project configuration")
+               elif re.match ("meta-yocto-bsp",layer.text):
+                  print ("meta-yocto-bsp is a default layer in the project configuratoin")
+               else:
+                  self.fail(msg='default layers are missing from the project configuration')
+        except:
+           self.fail(msg='No Layer information in project detail page')
+
+#   testcase (1517)
+    def test_verify_machine_information(self):
+        self.get('')
+        self.driver.find_element_by_xpath("//div[@id='global-nav']/ul/li/a[@href="+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.wait_until_visible('#projectstable')
+        self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
+
+        try:
+            self.assertTrue(self.element_exists('#machine-section'),'Machine section for the project configuration page does not exist')
+            self.assertTrue(re.search("qemux86",self.driver.find_element_by_id("project-machine-name").text),'The machine type is not assigned')
+            self.driver.find_element_by_id("change-machine-toggle").click()
+            self.wait_until_visible('#select-machine-form')
+            self.wait_until_visible('#cancel-machine-change')
+            self.driver.find_element_by_id("cancel-machine-change").click()
+        except:
+            self.fail(msg='The machine information is wrong in the configuration page')
+
+#   testcase (1518)
+    def test_verify_most_built_recipes_information(self):
+        self.get('')
+        self.driver.find_element_by_xpath("//div[@id='global-nav']/ul/li/a[@href="+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.wait_until_visible('#projectstable')
+        self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
+        project_URL=self.get_URL()
+
+        try:
+            self.assertTrue(re.search("You haven't built any recipes yet",self.driver.find_element_by_id("no-most-built").text),'Default message of no builds is not present')
+            self.driver.find_element_by_xpath("//div[@id='no-most-built']/p/a[@href="+'"'+project_URL+'images/"'+"]").click()
+            self.assertTrue(re.search("Compatible image recipes",self.driver.find_element_by_xpath("//div[@class='col-md-10']").text),'The Choose a recipe to build link  is not working  properly')
+        except:
+            self.fail(msg='No Most built information in project detail page')
+
+#   testcase (1519)
+    def test_verify_project_release_information(self):
+        self.get('')
+        self.driver.find_element_by_xpath("//div[@id='global-nav']/ul/li/a[@href="+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.wait_until_visible('#projectstable')
+        self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
+
+        try:
+            self.assertTrue(re.search("Yocto Project master",self.driver.find_element_by_id("project-release-title").text),'The project release is not defined')
+        except:
+            self.fail(msg='No project release title information in project detail page')
+
+#   testcase (1520)
+    def test_verify_layer_information(self):
+        self.get('')
+        self.driver.find_element_by_xpath("//div[@id='global-nav']/ul/li/a[@href="+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.wait_until_visible('#projectstable')
+        self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
+        project_URL=self.get_URL()
+
+        try:
+           self.driver.find_element_by_xpath("//div[@id='layer-container']")
+           self.assertTrue(re.search("3",self.driver.find_element_by_id("project-layers-count").text),'There should be 3 layers listed in the layer count')
+           layer_list = self.driver.find_element_by_id("layers-in-project-list")
+           layers = layer_list.find_elements_by_tag_name("li")
+
+           for layer in layers:
+               if re.match ("openembedded-core",layer.text):
+                    print ("openembedded-core layer is a default layer in the project configuration")
+               elif re.match ("meta-poky",layer.text):
+                  print ("meta-poky layer is a default layer in the project configuration")
+               elif re.match ("meta-yocto-bsp",layer.text):
+                  print ("meta-yocto-bsp is a default layer in the project configuratoin")
+               else:
+                  self.fail(msg='default layers are missing from the project configuration')
+
+           self.driver.find_element_by_xpath("//input[@id='layer-add-input']")
+           self.driver.find_element_by_xpath("//button[@id='add-layer-btn']")
+           self.driver.find_element_by_xpath("//div[@id='layer-container']/form[@class='form-inline']/p/a[@id='view-compatible-layers']")
+           self.driver.find_element_by_xpath("//div[@id='layer-container']/form[@class='form-inline']/p/a[@href="+'"'+project_URL+'importlayer"'+"]")
+        except:
+            self.fail(msg='No Layer information in project detail page')
+
+#   testcase (1521)
+    def test_verify_project_detail_links(self):
+        self.get('')
+        self.driver.find_element_by_xpath("//div[@id='global-nav']/ul/li/a[@href="+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.wait_until_visible('#projectstable')
+        self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
+        project_URL=self.get_URL()
+
+        self.driver.find_element_by_xpath("//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li[@id='topbar-configuration-tab']/a[@href="+'"'+project_URL+'"'+"]").click()
+        self.assertTrue(re.search("Configuration",self.driver.find_element_by_xpath("//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li[@id='topbar-configuration-tab']/a[@href="+'"'+project_URL+'"'+"]").text), 'Configuration tab in project topbar is misspelled')
+
+        try:
+            self.driver.find_element_by_xpath("//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'builds/"'+"]").click()
+            self.assertTrue(re.search("Builds",self.driver.find_element_by_xpath("//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'builds/"'+"]").text), 'Builds tab in project topbar is misspelled')
+            self.driver.find_element_by_xpath("//div[@id='empty-state-projectbuildstable']")
+        except:
+            self.fail(msg='Builds tab information is not present')
+
+        try:
+            self.driver.find_element_by_xpath("//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'importlayer"'+"]").click()
+            self.assertTrue(re.search("Import layer",self.driver.find_element_by_xpath("//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'importlayer"'+"]").text), 'Import layer tab in project topbar is misspelled')
+            self.driver.find_element_by_xpath("//fieldset[@id='repo-select']")
+            self.driver.find_element_by_xpath("//fieldset[@id='git-repo']")
+        except:
+            self.fail(msg='Import layer tab not loading properly')
+
+        try:
+            self.driver.find_element_by_xpath("//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'newcustomimage/"'+"]").click()
+            self.assertTrue(re.search("New custom image",self.driver.find_element_by_xpath("//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'newcustomimage/"'+"]").text), 'New custom image tab in project topbar is misspelled')
+            self.assertTrue(re.search("Select the image recipe you want to customise",self.driver.find_element_by_xpath("//div[@class='col-md-12']/h2").text),'The new custom image tab is not loading correctly')
+        except:
+            self.fail(msg='New custom image tab not loading properly')
+
+
+
-- 
1.9.1


