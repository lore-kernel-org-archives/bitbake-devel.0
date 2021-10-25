Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9876C433FE
	for <webhook@archiver.kernel.org>; Mon, 25 Oct 2021 14:16:08 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web10.32590.1635171363549075253
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 07:16:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="209759048"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="209759048"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:06 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="634754757"
Received: from syong7-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.249.78.45])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:05 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 3/9] tests/runqueue: Ensure hashserv exits before
 deleting files
Date: Mon, 25 Oct 2021 22:15:50 +0800
Message-Id: 
 <ec6dacced4196aa00c4be7ec320a49a0a3942a22.1635171215.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635171215.git.anuj.mittal@intel.com>
References: <cover.1635171215.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Oct 2021 14:16:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12820

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We've seen races where the socket may be gone but the server is still writing
out it's database. Handle that case too to avoid cleanup tracebacks.

[YOCTO #14440]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b9e4fb843cb9d3a4d4404af093a781fab5520465)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/tests/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 3d51779d6..4f335b8f1 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -361,7 +361,7 @@ class RunQueueTests(unittest.TestCase):
 
     def shutdown(self, tempdir):
         # Wait for the hashserve socket to disappear else we'll see races with the tempdir cleanup
-        while os.path.exists(tempdir + "/hashserve.sock"):
+        while (os.path.exists(tempdir + "/hashserve.sock") or os.path.exists(tempdir + "cache/hashserv.db-wal")):
             time.sleep(0.5)
 
 
-- 
2.31.1


