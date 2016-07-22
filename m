Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 749EB6067D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 12:19:10 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 22 Jul 2016 05:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,404,1464678000"; d="scan'208";a="1000482175"
Received: from lwong9-mobl4.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.176.13])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2016 05:19:07 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Jul 2016 00:18:38 +1200
Message-Id: <51cd1588337573a020adae6ddecbfcd81ccd1abe.1469189882.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1469189882.git.paul.eggleton@linux.intel.com>
References: <cover.1469189882.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1469189882.git.paul.eggleton@linux.intel.com>
References: <cover.1469189882.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] knotty: don't display ETA for tasks with progress
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
X-List-Received-Date: Fri, 22 Jul 2016 12:19:11 -0000

It turns out that progress information we can extract from a task is
rarely apportioned closely enough to the time taken for the ETA to be
accurate, so showing it is going to be misleading most of the time for
anything but the most basic of examples. Let's just remove it and avoid
misleading (or worse, annoying) the user.

Fixes [YOCTO #9986].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index b92334b..1723a72 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -245,7 +245,7 @@ class TerminalFilter(object):
                         pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2)
                         pbar.bouncing = True
                     else:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100)
+                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4)
                         pbar.bouncing = False
                     activetasks[t]["progressbar"] = pbar
                 tasks.append((pbar, progress, rate, start_time))
-- 
2.5.5


