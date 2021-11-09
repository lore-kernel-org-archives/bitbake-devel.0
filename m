Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583E6C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 14:51:10 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web08.13166.1636469469017479708
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 06:51:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="293287565"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800";
   d="scan'208";a="293287565"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 06:50:45 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800";
   d="scan'208";a="588760057"
Received: from chinboon-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.215.234.207])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 06:50:44 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 7/7] runqueue: Fix runall option handling
Date: Tue,  9 Nov 2021 22:50:28 +0800
Message-Id: 
 <6dda448b508cd1726c45213a1488de9ae65420d0.1636469164.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1636469164.git.anuj.mittal@intel.com>
References: <cover.1636469164.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 14:51:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12980

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The previous fix for runall option handling had a small bug in it, it
didn't clear the originally processed task list which meant it was running
too many tasks. Fix this so the list is reset and rebuild correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 87c9e120897ed04dfc64d4752fc602f9bfcb8645)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/runqueue.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 3300bb4f9..cd10da8b3 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -933,6 +933,7 @@ class RunQueueData:
             for tid in list(self.runtaskentries.keys()):
                 if tid not in runq_build:
                    reduced_tasklist.remove(tid)
+            runq_build = {}
 
             for task in self.cooker.configuration.runall:
                 if not task.startswith("do_"):
-- 
2.31.1


