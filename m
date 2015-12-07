Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 305EE60124
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Dec 2015 15:53:22 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga101.fm.intel.com with ESMTP; 07 Dec 2015 07:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,395,1444719600"; 
   d="scan'208";a="8948914"
Received: from jamullin-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.98])
	by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2015 07:53:03 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Dec 2015 15:53:00 +0000
Message-Id: <f7697e87ed7575741fc89926d924a6bdb1956920.1449503378.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1449503378.git.elliot.smith@intel.com>
References: <cover.1449503378.git.elliot.smith@intel.com>
Cc: Mihail Stanciu <stanciux.mihail@intel.com>
Subject: [PATCH 1/2] toaster: tests Automated build-mode backend tests
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
X-List-Received-Date: Mon, 07 Dec 2015 15:53:23 -0000

From: Mihail Stanciu <stanciux.mihail@intel.com>

Add tests to check various backend scenarios that
require UI interaction.

Add necessary files for above tests (the sqlite file
and the default config json).

Signed-off-by: Mihail Stanciu <stanciux.mihail@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../contrib/tts/toasteruitest/toaster.sqlite       |   1 +
 .../tts/toasteruitest/toaster_automation_test.py   | 383 ++++++++++++++++++++-
 .../contrib/tts/toasteruitest/toasterconf.json     |   1 +
 3 files changed, 384 insertions(+), 1 deletion(-)
 create mode 120000 bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite
 create mode 120000 bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json

diff --git a/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite b/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite
new file mode 120000
index 0000000..656b8e8
--- /dev/null
+++ b/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite
@@ -0,0 +1 @@
+../../../../../../toaster.sqlite
\ No newline at end of file
diff --git a/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py b/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
index 8be9ce2..3d3ebd8 100755
--- a/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
+++ b/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
@@ -23,13 +23,14 @@
 # step 2 - 3 needs to be run manually
 
 import unittest, time, re, sys, getopt, os, logging, string, errno, exceptions
-import shutil, argparse, ConfigParser, platform
+import shutil, argparse, ConfigParser, platform, json
 from selenium import webdriver
 from selenium.common.exceptions import NoSuchElementException
 from selenium import selenium
 from selenium.webdriver.common.by import By
 from selenium.webdriver.common.keys import Keys
 from selenium.webdriver.support.ui import Select
+import sqlite3 as sqlite
 
 
 ###########################################
@@ -1814,3 +1815,383 @@ class toaster_cases(toaster_cases_base):
         if not self.is_text_present("Toaster Manual"):
             self.assertFalse(True, msg=("please check [Toaster manual] link on page"))
 
+####################################################################################################
+# Starting backend tests ###########################################################################
+####################################################################################################
+
+        ##############
+        #  CASE 1066 #
+        ##############
+    def test_1066(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select count(name) from orm_project a, auth_user b where a.user_id = b.id and b.username='_anonuser';"
+        cursor.execute(query)
+        data = cursor.fetchone()
+        self.failUnless(data >= 1)
+
+
+        ##############
+        #  CASE 1071 #
+        ##############
+    def test_1071(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select name from orm_release;"
+        cursor.execute(query)
+        data = cursor.fetchall()
+        for i in range(0,4):
+            data[i] = data[i][0]
+        data.sort()
+        print data
+        json_parse = json.loads(open('toasterconf.json').read())
+        json_data = []
+        for i in range (0,4):
+            json_data.append(json_parse['releases'][i]['name'])
+        json_data.sort()
+        print json_data
+        self.failUnless(data == json_data)
+
+        ##############
+        #  CASE 1072 #
+        ##############
+    def test_1072(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select value from orm_toastersetting where name like 'DEFCONF%';"
+        cursor.execute(query)
+        data = cursor.fetchall()
+        for i in range(0,6):
+            data[i] = data[i][0]
+        print data
+        json_parse = json.loads(open('toasterconf.json').read())
+        json_data=json_parse['config']
+        json_data = json_data.values()
+        print json_data
+        self.failUnless(data == json_data)
+
+
+        ##############
+        #  CASE 1074 #
+        ##############
+    def test_1074(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select name from orm_layersource;"
+        cursor.execute(query)
+        data = cursor.fetchall()
+        for i in range(0,3):
+            data[i] = data[i][0]
+        print data
+        json_parse = json.loads(open('toasterconf.json').read())
+        json_data = []
+        for i in range(0,3):
+            json_data.append(json_parse['layersources'][i]['name'])
+        print json_data
+        self.failUnless(set(data) == set(json_data))
+
+        ##############
+        #  CASE 1075 #
+        ##############
+    def test_1075(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select value from orm_toastersetting where name like 'DEFAULT_RELEASE';"
+        cursor.execute(query)
+        data = cursor.fetchall()
+        data = data[0][0]
+        print data
+        json_parse = json.loads(open('toasterconf.json').read())
+        json_data = json_parse['defaultrelease']
+        print json_data
+        self.failUnless(set(data) == set(json_data))
+
+        ##############
+        #  CASE 1076 #
+        ##############
+    def test_1076(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+
+        print 'Checking branches for "Local Yocto Project"'
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select name from orm_branch where layer_source_id=1;"
+        cursor.execute(query)
+        data = cursor.fetchall()
+        for i in range(0,4):
+            data[i] = data[i][0]
+        print data
+        json_parse = json.loads(open('toasterconf.json').read())
+        json_data = json_parse['layersources'][0]['branches']
+        print json_data
+        self.failUnless(set(data) == set(json_data))
+
+        print 'Checking branches for "OpenEmbedded"'
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select name from orm_branch where layer_source_id=2;"
+        cursor.execute(query)
+        data = cursor.fetchall()
+        for i in range(0,3):
+            data[i] = data[i][0]
+        print data
+        json_parse = json.loads(open('toasterconf.json').read())
+        json_data = json_parse['layersources'][1]['branches']
+        print json_data
+        self.failUnless(set(data) == set(json_data))
+
+        print 'Checking branches for "Imported layers"'
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select name from orm_branch where layer_source_id=3;"
+        cursor.execute(query)
+        data = cursor.fetchall()
+        for i in range(0,4):
+            data[i] = data[i][0]
+        print data
+        json_parse = json.loads(open('toasterconf.json').read())
+        json_data = json_parse['layersources'][2]['branches']
+        print json_data
+        self.failUnless(set(data) == set(json_data))
+
+
+        ##############
+        #  CASE 1077 #
+        ##############
+    def test_1077(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select name from orm_bitbakeversion;"
+        cursor.execute(query)
+        data = cursor.fetchall()
+        for i in range(0,4):
+            data[i] = data[i][0]
+        print data
+        json_parse = json.loads(open('toasterconf.json').read())
+        json_data = []
+        for i in range(0,4):
+            json_data.append(json_parse['bitbake'][i]['name'])
+        print json_data
+        self.failUnless(set(data) == set(json_data))
+
+        ##############
+        #  CASE 1083 #
+        ##############
+    def test_1083(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        self.driver.maximize_window()
+        self.driver.get(self.base_url)
+        self.driver.find_element_by_id("new-project-button").click()
+        self.driver.find_element_by_id("new-project-name").send_keys("new-test-project")
+        self.driver.find_element_by_id("create-project-button").click()
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select count(name) from orm_project where name = 'new-test-project';"
+        cursor.execute(query)
+        data = cursor.fetchone()
+        print 'data: %s' % data
+        self.failUnless(data >= 1)
+
+        ##############
+        #  CASE 1084 #
+        ##############
+    def test_1084(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        self.driver.maximize_window()
+        self.driver.get(self.base_url)
+        self.driver.find_element_by_id("new-project-button").click()
+        self.driver.find_element_by_id("new-project-name").send_keys("new-default-project")
+        self.driver.find_element_by_id("create-project-button").click()
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select a.name from orm_release a, orm_project b where a.id = b.release_id and b.name = 'new-default-project' limit 1;"
+        cursor.execute(query)
+        db_data = str(cursor.fetchone()[0])
+        json_parse = json.loads(open('toasterconf.json').read())
+        json_data = str(json_parse['defaultrelease'])
+        self.failUnless(db_data == json_data)
+
+        ##############
+        #  CASE 1088 #
+        ##############
+    def test_1088(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        self.driver.maximize_window()
+        self.driver.get(self.base_url)
+        self.driver.find_element_by_css_selector("a[href='/toastergui/projects/']").click()
+        self.driver.find_element_by_link_text('new-default-project').click()
+        self.driver.find_element_by_id('project-change-form-toggle').click()
+        self.driver.find_element_by_id('project-name-change-input').clear()
+        self.driver.find_element_by_id('project-name-change-input').send_keys('new-name')
+        self.driver.find_element_by_id('project-name-change-btn').click()
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select count(name) from orm_project where name = 'new-name';"
+        cursor.execute(query)
+        data = cursor.fetchone()[0]
+        self.failUnless(data == 1)
+        #reseting project name
+        self.driver.find_element_by_id('project-change-form-toggle').click()
+        self.driver.find_element_by_id('project-name-change-input').clear()
+        self.driver.find_element_by_id('project-name-change-input').send_keys('new-default-project')
+        self.driver.find_element_by_id('project-name-change-btn').click()
+
+
+        ##############
+        #  CASE 1089 #
+        ##############
+    def test_1089(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        self.driver.maximize_window()
+        self.driver.get(self.base_url)
+        self.driver.find_element_by_css_selector("a[href='/toastergui/projects/']").click()
+        self.driver.find_element_by_link_text('new-default-project').click()
+        self.driver.find_element_by_id('change-machine-toggle').click()
+        self.driver.find_element_by_id('machine-change-input').clear()
+        self.driver.find_element_by_id('machine-change-input').send_keys('qemuarm64')
+        self.driver.find_element_by_id('machine-change-input').send_keys(Keys.RETURN)
+        self.driver.find_element_by_id('machine-change-btn').click()
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select count(id) from orm_projectvariable where name like 'machine' and value like 'qemuarm64';"
+        cursor.execute(query)
+        data = cursor.fetchone()[0]
+        self.failUnless(data == 1)
+        #resetting machine to default value
+        self.driver.find_element_by_id('change-machine-toggle').click()
+        self.driver.find_element_by_id('machine-change-input').clear()
+        self.driver.find_element_by_id('machine-change-input').send_keys('qemux86')
+        self.driver.find_element_by_id('machine-change-input').send_keys(Keys.RETURN)
+        self.driver.find_element_by_id('machine-change-btn').click()
+
+        ##############
+        #  CASE 1090 #
+        ##############
+    def test_1090(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select username from auth_user where is_superuser = 1;"
+        cursor.execute(query)
+        data = cursor.fetchall()
+        try:
+            data = data[0]
+        except:
+            pass
+        print data
+        self.failUnless(data == 'toaster_admin')
+
+        ##############
+        #  CASE 1091 #
+        ##############
+    def test_1091(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        self.driver.maximize_window()
+        self.driver.get(self.base_url)
+        self.driver.find_element_by_css_selector("a[href='/toastergui/projects/']").click()
+        self.driver.find_element_by_link_text('new-default-project').click()
+        self.driver.find_element_by_id('release-change-toggle').click()
+        dropdown = self.driver.find_element_by_css_selector('select')
+        for option in dropdown.find_elements_by_tag_name('option'):
+            if option.text == 'Local Yocto Project':
+                option.click()
+        self.driver.find_element_by_id('change-release-btn').click()
+        #wait for the changes to register in the DB
+        time.sleep(1)
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select count(*) from orm_layer_version a, orm_projectlayer b, orm_project c where a.\"commit\"=\"HEAD\" and a.id = b.layercommit_id and b.project_id=c.id and c.name='new-default-project';"
+        cursor.execute(query)
+        data = cursor.fetchone()[0]
+        #resetting release to default
+        self.driver.find_element_by_id('release-change-toggle').click()
+        dropdown = self.driver.find_element_by_css_selector('select')
+        for option in dropdown.find_elements_by_tag_name('option'):
+            if option.text == 'Yocto Project master':
+                option.click()
+        self.driver.find_element_by_id('change-release-btn').click()
+        #wait for the changes to register in the DB
+        time.sleep(1)
+        self.failUnless(data == 3)
+
+        ##############
+        #  CASE 1092 #
+        ##############
+    def test_1092(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        self.driver.maximize_window()
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select a.name, a.value from orm_projectvariable a, orm_project b where a.project_id = b.id and b.name = 'new-default-project';"
+        cursor.execute(query)
+        data = dict(cursor.fetchall())
+        print data
+        default_values = {u'IMAGE_INSTALL_append': u'', u'PACKAGE_CLASSES': u'package_rpm', u'MACHINE': u'qemux86', u'SDKMACHINE': u'x86_64', u'DISTRO': u'poky', u'IMAGE_FSTYPES': u'ext3 jffs2 tar.bz2'}
+        self.failUnless(data == default_values)
+
+        ##############
+        #  CASE 1093 #
+        ##############
+    def test_1093(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+
+        #get initial values
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select layercommit_id from orm_projectlayer a, orm_project b where a.project_id=b.id and b.name='new-default-project';"
+        cursor.execute(query)
+        data_initial = cursor.fetchall()
+        print data_initial
+
+        self.driver.maximize_window()
+        self.driver.get('localhost:8000')#self.base_url)
+        self.driver.find_element_by_css_selector("a[href='/toastergui/projects/']").click()
+        self.driver.find_element_by_link_text('new-default-project').click()
+        self.driver.find_element_by_id('release-change-toggle').click()
+        dropdown = self.driver.find_element_by_css_selector('select')
+        for option in dropdown.find_elements_by_tag_name('option'):
+            if option.text == 'Local Yocto Project':
+                option.click()
+        self.driver.find_element_by_id('change-release-btn').click()
+        #wait for the changes to register in the DB
+        time.sleep(1)
+
+        #get changed values
+        con=sqlite.connect('toaster.sqlite')
+        cursor = con.cursor()
+        query = "select layercommit_id from orm_projectlayer a, orm_project b where a.project_id=b.id and b.name='new-default-project';"
+        cursor.execute(query)
+        data_changed = cursor.fetchall()
+        print data_changed
+
+        #resetting release to default
+        self.driver.find_element_by_id('release-change-toggle').click()
+        dropdown = self.driver.find_element_by_css_selector('select')
+        for option in dropdown.find_elements_by_tag_name('option'):
+            if option.text == 'Yocto Project master':
+                option.click()
+        self.driver.find_element_by_id('change-release-btn').click()
+        #wait for the changes to register in the DB
+        time.sleep(1)
+        self.failUnless(data_initial != data_changed)
diff --git a/lib/toaster/contrib/tts/toasteruitest/toasterconf.json b/lib/toaster/contrib/tts/toasteruitest/toasterconf.json
new file mode 120000
index 0000000..9b33bcc
--- /dev/null
+++ b/lib/toaster/contrib/tts/toasteruitest/toasterconf.json
@@ -0,0 +1 @@
+../../../../../../meta-yocto/conf/toasterconf.json
\ No newline at end of file
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


