Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 528A575CF1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Aug 2016 03:37:37 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 10 Aug 2016 20:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,503,1464678000"; d="scan'208";a="863452259"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.171.53])
	by orsmga003.jf.intel.com with ESMTP; 10 Aug 2016 20:37:36 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Aug 2016 15:36:59 +1200
Message-Id: <197644053d8df3b883ee0f7b59f4cb868e633f6d.1470886482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1470886482.git.paul.eggleton@linux.intel.com>
References: <cover.1470886482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1470886482.git.paul.eggleton@linux.intel.com>
References: <cover.1470886482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/4] knotty: don't show number of running tasks in quiet mode
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
X-List-Received-Date: Thu, 11 Aug 2016 03:37:37 -0000

There's not a whole lot of point showing how many tasks are running when
we're in quiet mode, it just looks a bit strange particularly when it's
not running any tasks.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/knotty.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index f89f7b3..b30135b 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -256,7 +256,9 @@ class TerminalFilter(object):
             content = "Waiting for %s running tasks to finish:" % len(activetasks)
             print(content)
         else:
-            if not len(activetasks):
+            if self.quiet:
+                content = "Running tasks (%s of %s)" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
+            elif not len(activetasks):
                 content = "No currently running tasks (%s of %s)" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
             else:
                 content = "Currently %2s running tasks (%s of %s)" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
-- 
2.5.5


