Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 5F288764B6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 16:25:42 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 30 Jul 2015 09:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="758532520"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2015 09:25:43 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id BD99B6A4087;
	Thu, 30 Jul 2015 09:24:56 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 19:25:17 +0300
Message-Id: <048f666ea18ddf1248f17d066a743f8dd3c1993d.1438271912.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
References: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438271912.git.ed.bartosh@linux.intel.com>
References: <cover.1438271912.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 09/11] toaster: tts: make sure to import data
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
X-List-Received-Date: Thu, 30 Jul 2015 16:25:43 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Importing data from the layer index should be part of the setup
because otherwise we have no reliable database configuration.

This patch selects the first option for importing the database
configuration file.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/contrib/tts/tests.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/contrib/tts/tests.py b/lib/toaster/contrib/tts/tests.py
index 8d19647..9acef46 100644
--- a/lib/toaster/contrib/tts/tests.py
+++ b/lib/toaster/contrib/tts/tests.py
@@ -62,11 +62,12 @@ class TestHTML5Compliance(unittest.TestCase):
         self.cleanup_database = False
         os.chdir(self.crtdir)
         if not os.path.exists(os.path.join(self.crtdir, "toaster.sqlite")):
-            self.cleanup_database = False
+            self.cleanup_database = True
             run_shell_cmd("%s/bitbake/lib/toaster/manage.py syncdb --noinput" % config.TESTDIR)
             run_shell_cmd("%s/bitbake/lib/toaster/manage.py migrate orm" % config.TESTDIR)
             run_shell_cmd("%s/bitbake/lib/toaster/manage.py migrate bldcontrol" % config.TESTDIR)
             run_shell_cmd("%s/bitbake/lib/toaster/manage.py loadconf %s/meta-yocto/conf/toasterconf.json" % (config.TESTDIR, config.TESTDIR))
+            run_shell_cmd("%s/bitbake/lib/toaster/manage.py lsupdates" % config.TESTDIR)
 
             setup = pexpect.spawn("%s/bitbake/lib/toaster/manage.py checksettings" % config.TESTDIR)
             setup.logfile = sys.stdout
-- 
2.1.4


