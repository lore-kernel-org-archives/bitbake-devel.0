Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E5FC4332F
	for <webhook@archiver.kernel.org>; Tue, 26 Oct 2021 14:27:57 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web09.12829.1635258475416242829
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Oct 2021 07:27:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="290757104"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800";
   d="scan'208";a="290757104"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 07:08:02 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800";
   d="scan'208";a="497352133"
Received: from wandsuan-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.215.231.17])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 07:08:01 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 1/2] tests/runqueue: Ensure hashserv exits before
 deleting files
Date: Tue, 26 Oct 2021 22:06:46 +0800
Message-Id: 
 <9978675f3ff8c5147c805e0846c86cdc8798da69.1635256061.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635256061.git.anuj.mittal@intel.com>
References: <cover.1635256061.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Oct 2021 14:27:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12831

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


