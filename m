Return-Path: <fabien.proriol@jdsu.com>
X-Greylist: delayed 461 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 28 Jul 2015 15:22:01 UTC
Received: from ks.kazoe.org (ks.kazoe.org [91.121.82.209])
	by mail.openembedded.org (Postfix) with ESMTP id 4910476312
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 15:22:01 +0000 (UTC)
From: fabien.proriol@jdsu.com
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Jul 2015 17:10:11 +0200
Message-Id: <1438096211-13663-1-git-send-email-fabien.proriol@jdsu.com>
X-Mailer: git-send-email 2.3.6
X-Mailman-Approved-At: Fri, 31 Jul 2015 09:42:10 +0000
Cc: Fabien Proriol <fabien.proriol@jdsu.com>
Subject: [PATCH] Display Runned Task in verbose mode
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
X-List-Received-Date: Tue, 28 Jul 2015 15:22:01 -0000

From: Fabien Proriol <fabien.proriol@jdsu.com>

It can be usefull to list task order with
bitbake -n -v <recipe>
---
 bitbake/lib/bb/ui/knotty.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 2bee242..2a6f175 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -467,6 +467,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     tasktype = 'noexec task'
                 else:
                     tasktype = 'task'
+                logger.verbose("Task: %s %s"%(event.taskfile.split("/")[-1], event.taskname))
                 logger.info("Running %s %s of %s (ID: %s, %s)",
                             tasktype,
                             event.stats.completed + event.stats.active +
-- 
2.3.6

