Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 70FAB6B109
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 16:44:37 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 04 Oct 2013 09:44:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1034,1371106800"; d="scan'208";a="414098031"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.164])
	by orsmga002.jf.intel.com with ESMTP; 04 Oct 2013 09:44:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Oct 2013 17:44:25 +0100
Message-Id: <6b322934d5cc34601098dc935400e0e8a6e7df1e.1380904913.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1380904913.git.paul.eggleton@linux.intel.com>
References: <cover.1380904913.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1380904913.git.paul.eggleton@linux.intel.com>
References: <cover.1380904913.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/4] bitbake-diffsigs: handle if task name is specified without do_ prefix
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
X-List-Received-Date: Fri, 04 Oct 2013 16:44:37 -0000

Warn the user and adjust the task name automatically if the -t option
is specified with a task name that doesn't start with do_ (e.g.
"configure" instead of "do_configure").

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-diffsigs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index 3ce70da..6e4c44a 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -39,6 +39,10 @@ def find_compare_task(bbhandler, pn, taskname):
         logger.error('Metadata does not support finding signature data files')
         sys.exit(1)
 
+    if not taskname.startswith('do_'):
+        logger.warn('Invalid task name "%s" - assuming you meant "do_%s"' % (taskname, taskname))
+        taskname = 'do_%s' % taskname
+
     filedates = bb.siggen.find_siginfo(pn, taskname, None, bbhandler.config_data)
     latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-2:]
     if not latestfiles:
-- 
1.8.1.2


