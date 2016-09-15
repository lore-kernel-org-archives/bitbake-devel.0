Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id DFA6D771EA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 11:20:52 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 15 Sep 2016 04:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,339,1470726000"; d="scan'208";a="1040295505"
Received: from lvernat-mobl7.ger.corp.intel.com (HELO
	mqz-osx-suse64.fi.intel.com) ([10.252.23.81])
	by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2016 04:20:53 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Sep 2016 14:20:50 +0300
Message-Id: <1473938450-12696-3-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1473938450-12696-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1473938450-12696-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 2/2] cookerdata: allow multiple passes of config re-parsing
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
X-List-Received-Date: Thu, 15 Sep 2016 11:20:53 -0000

[YOCTO #10188]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/cookerdata.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 07425ce..9e88f95 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -270,9 +270,16 @@ class CookerDataBuilder(object):
 
             bb.event.fire(bb.event.ConfigParsed(), self.data)
 
-            if self.data.getVar("BB_INVALIDCONF", False) is True:
+            reparse_cnt = 0
+            while self.data.getVar("BB_INVALIDCONF", False) is True:
+                if reparse_cnt > 20:
+                    logger.error("Configuration has been re-parsed over 20 times, "
+                                 "breaking out of the loop...")
+                    raise Exception("Too deep config re-parse loop. Check locations where "
+                                    "BB_INVALIDCONF is being set (ConfigParsed event handlers)")
                 self.data.setVar("BB_INVALIDCONF", False)
                 self.data = self.parseConfigurationFiles(self.prefiles, self.postfiles)
+                reparse_cnt += 1
                 bb.event.fire(bb.event.ConfigParsed(), self.data)
 
             bb.parse.init_parser(self.data)
-- 
2.6.6


