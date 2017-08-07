Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 7BE6C60107
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Aug 2017 09:59:57 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Aug 2017 02:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,337,1498546800"; d="scan'208";a="134560547"
Received: from peggleto-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.43.222])
	by orsmga005.jf.intel.com with ESMTP; 07 Aug 2017 02:59:58 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Aug 2017 11:59:33 +0200
Message-Id: <60ca31e09597ec71f71b29dc91db8d3c95783fe1.1502099961.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1502099961.git.paul.eggleton@linux.intel.com>
References: <cover.1502099961.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] Revert "tinfoil: fix duplication of log messages"
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
X-List-Received-Date: Mon, 07 Aug 2017 09:59:57 -0000

In combination with the recent server reworking, this change actually
prevents messages sent from tasks from being logged properly. This will
of course give us the duplicated messages back, and I really hate to do
that effectively a second time, but that's better than seeing no error
at all in the case of a failure - we'll have to find the proper way of
avoiding the duplication that doesn't result in some messages going
missing.

This reverts commit 8a5bae76f91f2411187c638a42fa3c762052cf11.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/main.py    | 4 ++--
 lib/bb/tinfoil.py | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 431f6f4..c51c6f2 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -394,10 +394,10 @@ def bitbake_main(configParams, configuration):
 
     return 1
 
-def setup_bitbake(configParams, configuration, extrafeatures=None, setup_logging=True):
+def setup_bitbake(configParams, configuration, extrafeatures=None):
     # Ensure logging messages get sent to the UI as events
     handler = bb.event.LogHandler()
-    if setup_logging and not configParams.status_only:
+    if not configParams.status_only:
         # In status only mode there are no logs and no UI
         logger.addHandler(handler)
 
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index e246b3d..cd0587e 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -383,8 +383,7 @@ class Tinfoil:
 
         self.server_connection, ui_module = setup_bitbake(config_params,
                             cookerconfig,
-                            extrafeatures,
-                            setup_logging=False)
+                            extrafeatures)
 
         self.ui_module = ui_module
 
-- 
2.9.4


