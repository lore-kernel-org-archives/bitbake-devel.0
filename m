Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A5EF578151
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 19:04:59 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Jun 2017 12:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,311,1493708400"; d="scan'208";a="865610503"
Received: from nippert-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.38.12])
	by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2017 12:05:00 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Jun 2017 21:04:16 +0200
Message-Id: <17a9d9b7ac782a82ebe518ba724b7f531c111ca3.1496862217.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1496862217.git.paul.eggleton@linux.intel.com>
References: <cover.1496862217.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] tinfoil: fix duplication of log messages
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
X-List-Received-Date: Wed, 07 Jun 2017 19:05:01 -0000

Adding an additional logger in setup_bitbake() interacts poorly with the
logger we have added by default in tinfoil's constructor, with the
result that messages may be doubled or even tripled in tinfoil-using
scripts. Disable adding this one when calling setup_bitbake() from
tinfoil to avoid this problem.

Part of the fix for [YOCTO #11275].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/main.py    | 4 ++--
 lib/bb/tinfoil.py | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 8c948c2..29e3911 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -477,10 +477,10 @@ def bitbake_main(configParams, configuration):
 
     return 1
 
-def setup_bitbake(configParams, configuration, extrafeatures=None):
+def setup_bitbake(configParams, configuration, extrafeatures=None, setup_logging=True):
     # Ensure logging messages get sent to the UI as events
     handler = bb.event.LogHandler()
-    if not configParams.status_only:
+    if setup_logging and not configParams.status_only:
         # In status only mode there are no logs and no UI
         logger.addHandler(handler)
 
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 563c0c4..fb0da62 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -245,7 +245,8 @@ class Tinfoil:
 
         server, self.server_connection, ui_module = setup_bitbake(config_params,
                             cookerconfig,
-                            extrafeatures)
+                            extrafeatures,
+                            setup_logging=False)
 
         self.ui_module = ui_module
 
-- 
2.9.4


