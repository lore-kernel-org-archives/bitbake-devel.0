Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id F16E4772BC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 00:49:51 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 22 Feb 2016 16:49:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,487,1449561600"; d="scan'208";a="751272785"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.35])
	by orsmga003.jf.intel.com with ESMTP; 22 Feb 2016 16:49:52 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 18:51:57 -0600
Message-Id: <1456188718-13755-8-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
References: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: alexandru.c.georgescu@intel.com, stanciux.mihail@intel.com
Subject: [[RFC][PATCH] 7/8] toaster/tests: Add README, TODO and requeriments.
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
X-List-Received-Date: Tue, 23 Feb 2016 00:49:52 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/toaster/tests/README       | 64 ++++++++++++++++++++++++++++++++++++++++++
 lib/toaster/tests/TODO         | 13 +++++++++
 toaster-tests-requirements.txt |  5 ++++
 3 files changed, 82 insertions(+)
 create mode 100644 lib/toaster/tests/README
 create mode 100644 lib/toaster/tests/TODO
 create mode 100644 toaster-tests-requirements.txt

diff --git a/lib/toaster/tests/README b/lib/toaster/tests/README
new file mode 100644
index 0000000..a41db2f
--- /dev/null
+++ b/lib/toaster/tests/README
@@ -0,0 +1,64 @@
+= Toaster tests =
+
+== Host requirements ==
+
+All the test components REQUIRE bash as your default shell, you
+need to review if /bin/sh points to bash because some problems are
+detected when use dash.
+
+=== Toaster ===
+
+- virtualenv for python
+- pip for python
+
+=== Toaster UI ===
+
+- firefox web browser for use selenium
+- firefox selenium addon, for install download latest from [1].
+- vncserver (optional)
+
+[1] http://release.seleniumhq.org/selenium-ide/
+
+=== Debian INSTALL ===
+
+# apt-get install iceweasel python-virtualenv python-pip
+
+Optional:
+
+# apt-get install vnc4server
+
+== Setup ==
+
+For run any of the tests scripts you need to setup virtualenv and install
+requirements with pip.
+
+$ cd /home/user/pokydir
+$ source oe-init-build-env build
+$ virtualenv venv
+$ source venv/bin/activate
+$ pip install -r toaster-requirements.txt
+$ pip install -r toaster-tests-requirements.txt
+
+== Toaster test ==
+
+For run toaster you need to start a toaster instance and then use toaster-test
+program, it can take sometime because it setup a toaster instance and run
+testsuite over it.
+
+For start/stop a toaster instance a helper exists and need to be called with
+the path to the poky directory.
+
+$ cd /home/user/pokydir
+$ source oe-init-build-env build
+$ source venv/bin/activate
+$ ../bitbake/lib/toaster/tests/helpers.py -a start -d /home/user/pokydir -b build
+$ toaster-test --run-all-tests
+$ ../bitbake/lib/toaster/tests/helpers.py -a stop -d /home/user/pokydir -b build
+
+Optional: Toaster test suite uses selenium and spawn Firefox web browser for
+run the tests, if you are in a development machine may be is a good idea to
+start vncserver and set DISPLAY before run to don't interfer with your tasks,
+example:
+
+$ vncserver :10
+$ export DISPLAY=:10
diff --git a/lib/toaster/tests/TODO b/lib/toaster/tests/TODO
new file mode 100644
index 0000000..9c7e47c
--- /dev/null
+++ b/lib/toaster/tests/TODO
@@ -0,0 +1,13 @@
+setup.py:
+
+    - Improve logic of timeout now have a fixed time,
+      will be better to ask toaster instance about the
+      state of image building.
+
+ui.py:
+    - Class toaster_cases_base review and move common code
+      to ToasterTestCase.
+    - Class toaster_cases split into ToasterUITestCases (< 1000)
+      and ToasterBackendTestCases (> 1000).
+    - Class toaster_cases fix current tests to match Toaster in
+      master (css id's update)
diff --git a/toaster-tests-requirements.txt b/toaster-tests-requirements.txt
new file mode 100644
index 0000000..90eeda4
--- /dev/null
+++ b/toaster-tests-requirements.txt
@@ -0,0 +1,5 @@
+# helpers, for stop force
+proc
+
+# ui, general
+selenium
-- 
2.1.4


