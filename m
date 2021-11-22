Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0EEC433F5
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 02:25:08 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web10.1441.1637547896753547701
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Nov 2021 18:25:07 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.43, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="320933711"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="320933711"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:25:07 -0800
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="588848716"
Received: from kkleong1-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.239.135])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:25:06 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 8/8] cooker: Fix task-depends.dot for multiconfig
 targets
Date: Mon, 22 Nov 2021 10:24:49 +0800
Message-Id: 
 <0d3a46619da95260b5d0bbcc148660d8f6a707d0.1637547674.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637547674.git.anuj.mittal@intel.com>
References: <cover.1637547674.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Nov 2021 02:25:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13092

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
index e2a5dc43..c946800a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -815,7 +815,9 @@ class BBCooker:
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


