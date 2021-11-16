Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAF6C433FE
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 16:27:51 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by mx.groups.io with SMTP id smtpd.web09.313.1637080070688926670
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Nov 2021 08:27:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.20, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220936600"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800";
   d="scan'208";a="220936600"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 08:27:16 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800";
   d="scan'208";a="506500497"
Received: from mmohdso1-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.237.91])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 08:27:13 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 4/4] cooker: Fix task-depends.dot for multiconfig
 targets
Date: Wed, 17 Nov 2021 00:27:00 +0800
Message-Id: 
 <c1938abf51b57938a21948bb414ad0467e4368d9.1637079892.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637079892.git.anuj.mittal@intel.com>
References: <cover.1637079892.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 16:27:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13063

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The right hand side of dependencies in the task dependency file generated
by bitbake -g was missing multiconfig prefixes, corrupting the data. Fix
this.

[YOCTO #14621]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1d5ca721040c5e39aefa11219f62710de6587701)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cooker.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c032762f..3688aa08 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -814,7 +814,9 @@ class BBCooker:
             for dep in rq.rqdata.runtaskentries[tid].depends:
                 (depmc, depfn, _, deptaskfn) = bb.runqueue.split_tid_mcfn(dep)
                 deppn = self.recipecaches[depmc].pkg_fn[deptaskfn]
-                depend_tree["tdepends"][dotname].append("%s.%s" % (deppn, bb.runqueue.taskname_from_tid(dep)))
+                if depmc:
+                    depmc = "mc:" + depmc + ":"
+                depend_tree["tdepends"][dotname].append("%s%s.%s" % (depmc, deppn, bb.runqueue.taskname_from_tid(dep)))
             if taskfn not in seen_fns:
                 seen_fns.append(taskfn)
                 packages = []
-- 
2.33.1


