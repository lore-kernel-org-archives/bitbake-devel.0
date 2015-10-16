Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 2CDA077144
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 16:37:29 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 16 Oct 2015 09:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,689,1437462000"; d="scan'208";a="582249861"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 16 Oct 2015 09:11:53 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 76AAD6A4005;
	Fri, 16 Oct 2015 09:10:53 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Oct 2015 19:11:49 +0300
Message-Id: <1445011909-18371-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] cooker: preserve pre-post configs
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
X-List-Received-Date: Fri, 16 Oct 2015 16:37:32 -0000

Additional config files passed to bitbake server with --read and
--postread options are rewritten by client bitbake even if
it doesn't use those options.

This is a show stopper for toaster as toaster command line
builds are based on the assumption that server is aware of
toster configs, provided by --postread option.

This behaviour is fixed by preserving values of --read and
--postread options when bitbake server starts and restoring
them if client bitbake doesn't explicitly specify them.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py     | 5 +++++
 bitbake/lib/bb/cookerdata.py | 2 ++
 bitbake/lib/bb/main.py       | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index a416d2e..276e42e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -531,6 +531,11 @@ class BBCooker:
         for o in options:
             if o in ['prefile', 'postfile']:
                 clean = False
+                server_val = getattr(self.configuration, "%s_server" % o)
+                if not options[o] and server_val:
+                    # restore value provided on server start
+                    setattr(self.configuration, o, server_val)
+                    continue
             setattr(self.configuration, o, options[o])
         for k in bb.utils.approved_variables():
             if k in environment and k not in self.configuration.env:
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index a3fa552..671c0cb 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -129,6 +129,8 @@ class CookerConfiguration(object):
         self.extra_assume_provided = []
         self.prefile = []
         self.postfile = []
+        self.prefile_server = []
+        self.postfile_server = []
         self.debug = 0
         self.cmd = None
         self.abort = True
diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 8762f72..c8530fc 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -383,6 +383,13 @@ def bitbake_main(configParams, configuration):
         # Collect the feature set for the UI
         featureset = getattr(ui_module, "featureSet", [])
 
+    if configParams.server_only:
+        for param in ('prefile', 'postfile'):
+            value = getattr(configParams, param)
+            if value:
+                setattr(configuration, "%s_server" % param, value)
+                param = "%s_server" % param
+
     if not configParams.remote_server:
         # we start a server with a given configuration
         server = start_server(servermodule, configParams, configuration, featureset)
-- 
2.1.4


