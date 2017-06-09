Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id C12A378297
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Jun 2017 13:35:27 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Jun 2017 06:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,317,1493708400"; d="scan'208";a="1180388547"
Received: from therfet-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.41.2])
	by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2017 06:35:26 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Jun 2017 15:34:43 +0200
Message-Id: <0d1c9d13726e3a56367fa46c148b56f7cda9c5eb.1497014984.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1497014984.git.paul.eggleton@linux.intel.com>
References: <cover.1497014984.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/4] cookerdata: fix variable history not showing in bitbake -e with memres
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
X-List-Received-Date: Fri, 09 Jun 2017 13:35:27 -0000

CookerConfiguration sets the "tracking" option to True when -e is
specified in order to have history tracking enabled in the datastore
so that we can show variable history (which isn't enabled by default for
performance reasons), however in memory resident mode this wasn't doing
anything because it was happening on the UI side only. We do have a
mechanism for updating the cooker configuration in the server, but the
tracking option wasn't being included in the list of options we updated,
so we just need to add this option to fix the issue.

Fixes [YOCTO #10730].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cookerdata.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 722d860..6b850d3 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -76,7 +76,7 @@ class ConfigParameters(object):
         for o in ["abort", "tryaltconfigs", "force", "invalidate_stamp", 
                   "verbose", "debug", "dry_run", "dump_signatures", 
                   "debug_domains", "extra_assume_provided", "profile",
-                  "prefile", "postfile"]:
+                  "prefile", "postfile", "tracking"]:
             options[o] = getattr(self.options, o)
 
         ret, error = server.runCommand(["updateConfig", options, environment])
-- 
2.9.4


