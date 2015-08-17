Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 5ABE4767F6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:43 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564806"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:24 +0100
Message-Id: <6787744a9276dde53645c8f3110d18828a0430c7.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 09/13] cooker: drop appendlist
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
X-List-Received-Date: Mon, 17 Aug 2015 11:12:43 -0000

Now we have the bbappends list and all users have been converted over to
use it, we don't need this anymore.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5452deb..6dc9f19 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1654,7 +1654,6 @@ class CookerExit(bb.event.Event):
 
 class CookerCollectFiles(object):
     def __init__(self, priorities):
-        self.appendlist = {}
         self.bbappends = []
         self.bbfile_config_priorities = priorities
 
@@ -1750,10 +1749,6 @@ class CookerCollectFiles(object):
         for f in bbappend:
             base = os.path.basename(f).replace('.bbappend', '.bb')
             self.bbappends.append((base, f))
-            if not base in self.appendlist:
-               self.appendlist[base] = []
-            if f not in self.appendlist[base]:
-                self.appendlist[base].append(f)
 
         # Find overlayed recipes
         # bbfiles will be in priority order which makes this easy
-- 
2.1.0


