Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 415C26FFE8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Sep 2016 09:14:59 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 23 Sep 2016 02:15:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,381,1470726000"; d="scan'208";a="1060907187"
Received: from yleow-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.155.25])
	by fmsmga002.fm.intel.com with ESMTP; 23 Sep 2016 02:14:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2016 21:14:32 +1200
Message-Id: <2f910d6a290d7c9436bb739704b9e2b904073e9f.1474622057.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1474622057.git.paul.eggleton@linux.intel.com>
References: <cover.1474622057.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1474622057.git.paul.eggleton@linux.intel.com>
References: <cover.1474622057.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] knotty: ensure progress bar output is accounted for in display
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
X-List-Received-Date: Fri, 23 Sep 2016 09:15:01 -0000

When calculating how many lines we'd printed we weren't properly taking
the progress bars into account, with the result that sometimes if the
last line printed on the terminal wrapped to the next line (which is
possible) we backed up less lines than we should have.

Additionally, we should always print a newline after updating the
progress bar - there's no need to check if there wasn't output (there
always will be courtesy of our overridden _need_update()) and we now
allow the line to wrap so we don't need to check the other condition
either.

Hopefully this will fix [YOCTO #10046].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/knotty.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index a1856ec..1ae5a11 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -271,7 +271,7 @@ class TerminalFilter(object):
             progress = self.helper.tasknumber_current - 1
             if progress < 0:
                 progress = 0
-            self.main_progress.update(progress)
+            content = self.main_progress.update(progress)
             print('')
         lines = 1 + int(len(content) / (self.columns + 1))
         if not self.quiet:
@@ -285,11 +285,10 @@ class TerminalFilter(object):
                     pbar.setmessage('%s:%s' % (tasknum, pbar.msg.split(':', 1)[1]))
                     if progress > -1:
                         pbar.setextra(rate)
-                        output = pbar.update(progress)
+                        content = pbar.update(progress)
                     else:
-                        output = pbar.update(1)
-                    if not output or (len(output) <= pbar.term_width):
-                        print('')
+                        content = pbar.update(1)
+                    print('')
                 else:
                     content = "%s: %s" % (tasknum, task)
                     print(content)
-- 
2.5.5


