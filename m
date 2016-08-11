Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id A5B4E771C3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Aug 2016 03:37:34 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 10 Aug 2016 20:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,503,1464678000"; d="scan'208";a="863452257"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.171.53])
	by orsmga003.jf.intel.com with ESMTP; 10 Aug 2016 20:37:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Aug 2016 15:36:58 +1200
Message-Id: <d8fa29c6ba6321c8d0362e807e53bd33a243a8c4.1470886482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1470886482.git.paul.eggleton@linux.intel.com>
References: <cover.1470886482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1470886482.git.paul.eggleton@linux.intel.com>
References: <cover.1470886482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/4] knotty: fix task progress bar not starting at 0%
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
X-List-Received-Date: Thu, 11 Aug 2016 03:37:36 -0000

If we have the task number here we need to subtract 1 to get the number
of tasks completed.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/knotty.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 1723a72..f89f7b3 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -260,13 +260,16 @@ class TerminalFilter(object):
                 content = "No currently running tasks (%s of %s)" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
             else:
                 content = "Currently %2s running tasks (%s of %s)" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
-            maxtask = self.helper.tasknumber_total + 1
+            maxtask = self.helper.tasknumber_total
             if not self.main_progress or self.main_progress.maxval != maxtask:
                 widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
                 self.main_progress = BBProgress("Running tasks", maxtask, widgets=widgets)
                 self.main_progress.start(False)
             self.main_progress.setmessage(content)
-            self.main_progress.update(self.helper.tasknumber_current)
+            progress = self.helper.tasknumber_current - 1
+            if progress < 0:
+                progress = 0
+            self.main_progress.update(progress)
             print('')
         lines = 1 + int(len(content) / (self.columns + 1))
         if not self.quiet:
-- 
2.5.5


