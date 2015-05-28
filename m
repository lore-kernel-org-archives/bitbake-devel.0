Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 02B0D73236
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:18:24 +0000 (UTC)
Received: by wifw1 with SMTP id w1so64174653wif.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=jfS9aocE1S1V52Q8Ii3d3z8Y0IFVJSAAedIZmxk/EJY=;
	b=K6CXybQB1WMsLiFWF2uyX9it1TRFeqJyHzW6CKeIdNs7cYnhWdHGPjI0dKDq9jtm5M
	lNiM23HLivAyVZNSniFUN9bUEfNlcqHjVGibz9Oj0TBJWsgn+5p00LLsp+JeGw4iPuyg
	WPTcOT9BpYFLZlaRQKEmPUsVHwhNXWLdhZ+NmdnewTKQvjIYadV9zm3DxPmGYXqkgSD0
	MW/8dWssXbjzNTS4T0bv/yGCRQA8vaCtLunFM1FvzTVGRFcnyA+UslW9EkcvvAbcKU0i
	cKmbPU+LDfliuzQl32XQhATOT9e0T2S2DfZ9xfpFEyFy95GM6gj8ktj5ipnlSUCf4FoA
	mAmQ==
X-Gm-Message-State: ALoCoQnqHh8ZDFikeIp27zuwzj0C1akKvNatfnrPV78dXEab0amRJL/b24ycpZfSpA/irSkviiLN
X-Received: by 10.180.86.168 with SMTP id q8mr59902590wiz.80.1432822705085;
	Thu, 28 May 2015 07:18:25 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fs9sm3561744wjc.34.2015.05.28.07.18.23
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:18:24 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D77EB5613E5; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:15 +0100
Message-Id: <9b3ac73a1b305a47c1da6898a48da4ddd9da3b33.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 21/22] toaster tests: enable url check test
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
X-List-Received-Date: Thu, 28 May 2015 14:18:24 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Integrate the HTML5 validation as a test instead of
calling a separate script. This enables us to get the
HTML5 validation report as part of patch-level
testing.

gitignore the cache directory created by the http client

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/contrib/tts/config.py   | 21 ++++++++++++++
 lib/toaster/contrib/tts/runner.py   |  2 +-
 lib/toaster/contrib/tts/tests.py    | 55 +++++++++++++++++++++++++++++++++++--
 lib/toaster/contrib/tts/urlcheck.py | 41 +++++++++++++--------------
 4 files changed, 94 insertions(+), 25 deletions(-)

diff --git a/lib/toaster/contrib/tts/config.py b/lib/toaster/contrib/tts/config.py
index a4ea8cf..c0e0536 100644
--- a/lib/toaster/contrib/tts/config.py
+++ b/lib/toaster/contrib/tts/config.py
@@ -22,6 +22,7 @@
 # everything that would be a global variable goes here
 
 import os, sys, logging
+import socket
 
 LOGDIR = "log"
 SETTINGS_FILE = os.path.join(os.path.dirname(__file__), "settings.json")
@@ -29,6 +30,26 @@ TEST_DIR_NAME = "tts_testdir"
 
 OWN_PID = os.getpid()
 
+W3C_VALIDATOR = "http://icarus.local/w3c-validator/check?doctype=HTML5&uri="
+
+#TODO assign port dynamically
+TOASTER_PORT=56789
+
+#we parse the w3c URL to know where to connect
+
+import urlparse
+
+def get_public_ip():
+    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+    p = urlparse.urlparse("http://icarus.local/w3c-validator/check?doctype=HTML5&uri=")
+    s.connect(( p.netloc, 80 if p.port is None else p.port))
+    hn = s.getsockname()[0]
+    s.close()
+    return hn
+
+TOASTER_BASEURL="http://%s:%d/" % (get_public_ip(), TOASTER_PORT)
+
+
 OWN_EMAIL_ADDRESS = "Toaster Testing Framework <alexandru.damian@intel.com>"
 REPORT_EMAIL_ADDRESS = "alexandru.damian@intel.com"
 
diff --git a/lib/toaster/contrib/tts/runner.py b/lib/toaster/contrib/tts/runner.py
index f55c493..e7e4dd2 100755
--- a/lib/toaster/contrib/tts/runner.py
+++ b/lib/toaster/contrib/tts/runner.py
@@ -181,7 +181,7 @@ if __name__ == "__main__":
     no_failures = 1
     try:
         if options.testdir is not None and os.path.exists(options.testdir):
-            testdir = options.testdir
+            testdir = os.path.abspath(options.testdir)
             config.logger.info("No checkout, using %s" % testdir)
         else:
             need_cleanup = True
diff --git a/lib/toaster/contrib/tts/tests.py b/lib/toaster/contrib/tts/tests.py
index 2e630db..15a9a87 100644
--- a/lib/toaster/contrib/tts/tests.py
+++ b/lib/toaster/contrib/tts/tests.py
@@ -26,6 +26,9 @@
 import unittest
 from shellutils import *
 
+import pexpect
+import sys, os, signal, time
+
 class TestPyCompilable(unittest.TestCase):
     ''' Verifies that all Python files are syntactically correct '''
     def test_compile_file(self):
@@ -44,14 +47,62 @@ class TestPySystemStart(unittest.TestCase):
 
     def test_start_interactive_mode(self):
         try:
-            run_shell_cmd("bash -c 'source %s/oe-init-build-env && source toaster start webport=56789 && source toaster stop'" % config.testdir, config.testdir)
+            run_shell_cmd("bash -c 'source %s/oe-init-build-env && source toaster start webport=%d && source toaster stop'" % (config.testdir, config.TOASTER_PORT), config.testdir)
         except ShellCmdException as e:
             self.fail("Failed starting interactive mode: %s" % (e))
 
     def test_start_managed_mode(self):
         try:
-            run_shell_cmd("./poky/bitbake/bin/toaster webport=56789 & sleep 10 && curl http://localhost:56789/ && kill -2 %1")
+            run_shell_cmd("%s/bitbake/bin/toaster webport=%d nobrowser & sleep 10 && curl http://localhost:%d/ && kill -2 %1" % (config.testdir, config.TOASTER_PORT, config.TOASTER_PORT), config.testdir)
             pass
         except ShellCmdException as e:
             self.fail("Failed starting managed mode: %s" % (e))
 
+class TestHTML5Compliance(unittest.TestCase):
+    def setUp(self):
+        self.origdir = os.getcwd()
+        self.crtdir = os.path.dirname(config.testdir)
+        os.chdir(self.crtdir)
+        if not os.path.exists(os.path.join(self.crtdir, "toaster.sqlite")):
+            run_shell_cmd("%s/bitbake/lib/toaster/manage.py syncdb --noinput" % config.testdir)
+            run_shell_cmd("%s/bitbake/lib/toaster/manage.py migrate orm" % config.testdir)
+            run_shell_cmd("%s/bitbake/lib/toaster/manage.py migrate bldcontrol" % config.testdir)
+            run_shell_cmd("%s/bitbake/lib/toaster/manage.py loadconf %s/meta-yocto/conf/toasterconf.json" % (config.testdir, config.testdir))
+
+            setup = pexpect.spawn("%s/bitbake/lib/toaster/manage.py checksettings" % config.testdir)
+            setup.logfile = sys.stdout
+            setup.expect(r".*or type the full path to a different directory: ")
+            setup.sendline('')
+            setup.sendline('')
+            setup.expect(r".*or type the full path to a different directory: ")
+            setup.sendline('')
+            setup.expect(r"Enter your option: ")
+            setup.sendline('0')
+
+        self.child = pexpect.spawn("%s/bitbake/bin/toaster webport=%d nobrowser" % (config.testdir, config.TOASTER_PORT))
+        self.child.logfile=sys.stdout
+        self.child.expect("Toaster is now running. You can stop it with Ctrl-C")
+
+    def test_html5_compliance(self):
+        import urllist, urlcheck
+        results = {}
+        for url in urllist.URLS:
+            results[url] = urlcheck.validate_html5(config.TOASTER_BASEURL + url)
+
+        failed = []
+        for url in results:
+            if results[url][1] != 0:
+                failed.append((url, results[url]))
+
+
+        self.assertTrue(len(failed)== 0, "Not all URLs validate: \n%s " % "\n".join(map(lambda x: "".join(str(x)),failed)))
+
+        #(config.TOASTER_BASEURL + url, status, errors, warnings))
+
+    def tearDown(self):
+        while self.child.isalive():
+            self.child.kill(signal.SIGINT)
+            time.sleep(1)
+        os.chdir(self.origdir)
+#        if os.path.exists(os.path.join(self.crtdir, "toaster.sqlite")):
+#            os.remove(os.path.join(self.crtdir, "toaster.sqlite"))
diff --git a/lib/toaster/contrib/tts/urlcheck.py b/lib/toaster/contrib/tts/urlcheck.py
index a94af50..86d7caa 100644
--- a/lib/toaster/contrib/tts/urlcheck.py
+++ b/lib/toaster/contrib/tts/urlcheck.py
@@ -7,38 +7,35 @@ import time
 import config
 import urllist
 
-# TODO: spawn server here
-BASEURL="http://localhost:8000/"
-
-#def print_browserlog(url):
-#    driver = webdriver.Firefox()
-#    driver.get(url)
-#    body = driver.find_element_by_tag_name("body")
-#    body.send_keys(Keys.CONTROL + 't')
-#    for i in driver.get_log('browser'):
-#        print(i)
-#    driver.close()
-
 
 # TODO: turn to a test
-def validate_html(url):
+def validate_html5(url):
     h = httplib2.Http(".cache")
+    status = "Failed"
+    errors = -1
+    warnings = -1
+
     # TODO: the w3c-validator must be a configurable setting
-    urlrequest = "http://icarus.local/w3c-validator/check?doctype=HTML5&uri="+url
+    urlrequest = config.W3C_VALIDATOR+url
     try:
         resp, content = h.request(urlrequest, "HEAD")
-        if resp['x-w3c-validator-status'] == "Abort":
-            config.logger.error("FAILed call %s" % url)
-        else:
-            config.logger.error("url %s is %s\terrors %s warnings %s (check at %s)" % (url, resp['x-w3c-validator-status'], resp['x-w3c-validator-errors'], resp['x-w3c-validator-warnings'], urlrequest))
+        if resp['x-w3c-validator-status'] != "Abort":
+            status = resp['x-w3c-validator-status']
+            errors = int(resp['x-w3c-validator-errors'])
+            warnings = int(resp['x-w3c-validator-warnings'])
     except Exception as e:
         config.logger.warn("Failed validation call: %s" % e.__str__())
-
-    print("done %s" % url)
+    return (status, errors, warnings)
 
 if __name__ == "__main__":
+    print("Testing %s with %s" % (config.TOASTER_BASEURL, config.W3C_VALIDATOR))
+
+    def print_validation(url):
+        status, errors, warnings = validate_html5(url)
+        config.logger.error("url %s is %s\terrors %s warnings %s (check at %s)" % (url, status, errors, warnings, config.W3C_VALIDATOR+url))
+
     if len(sys.argv) > 1:
-        validate_html(sys.argv[1])
+        print_validation(sys.argv[1])
     else:
         for url in urllist.URLS:
-            validate_html(BASEURL+url)
+            print_validation(config.TOASTER_BASEURL+url)
-- 
1.9.1


