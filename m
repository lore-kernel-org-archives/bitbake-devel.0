Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 39AA86D378
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 15:58:46 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Nov 2013 08:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="428337428"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.91])
	by orsmga002.jf.intel.com with ESMTP; 01 Nov 2013 08:58:44 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Nov 2013 15:58:29 +0000
Message-Id: <e1bd6d695679702a128cd8746fbb3d2ea50d97bb.1383321482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/8] cooker: add data to the dependency tree dump
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
X-List-Received-Date: Fri, 01 Nov 2013 15:58:46 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Toaster needes to record extra data that needs to
be moved at the time of the dependency tree dump.

This data includes:
* layer priorities for recording in the layer section
* the inherit list for each PN which allows to determine
the type of the PN (regular package, image, etc).

This patch adds this data to the dependency tree dump.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b504f45..ccc6858 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -511,6 +511,7 @@ class BBCooker:
         depend_tree["packages"] = {}
         depend_tree["rdepends-pkg"] = {}
         depend_tree["rrecs-pkg"] = {}
+        depend_tree["layer-priorities"] = self.recipecache.bbfile_config_priorities
 
         for task in xrange(len(rq.rqdata.runq_fnid)):
             taskname = rq.rqdata.runq_task[task]
@@ -522,6 +523,7 @@ class BBCooker:
                 depend_tree["pn"][pn] = {}
                 depend_tree["pn"][pn]["filename"] = fn
                 depend_tree["pn"][pn]["version"] = version
+                depend_tree["pn"][pn]["inherits"] = self.recipecache.inherits.get(fn, None)
 
                 # if we have extra caches, list all attributes they bring in
                 extra_info = []
-- 
1.8.1.2


