Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06897C433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Oct 2021 14:27:58 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web12.12891.1635258476591288549
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Oct 2021 07:27:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="290757115"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800";
   d="scan'208";a="290757115"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 07:08:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800";
   d="scan'208";a="497352141"
Received: from wandsuan-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.215.231.17])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 07:08:02 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 2/2] bitbake-worker: Add debug when unpickle fails
Date: Tue, 26 Oct 2021 22:06:47 +0800
Message-Id: 
 <11ec2a2cc27263a0ed24aaa33fc39752c68afcb0.1635256061.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635256061.git.anuj.mittal@intel.com>
References: <cover.1635256061.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Oct 2021 14:27:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12832

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We occasionally see bitbake-worker failing and from the logs, an unpickle error
occurs. Add more debug so we can further debug this next time it fails.

[YOCTO #14595]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit fe8105cc06beca8240b76ea366a1eff5aa9c5412)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 bin/bitbake-worker | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 6a12e1fed..7fde68876 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -417,7 +417,11 @@ class BitbakeWorker(object):
         if self.queue.startswith(b"<" + item + b">"):
             index = self.queue.find(b"</" + item + b">")
             while index != -1:
-                func(self.queue[(len(item) + 2):index])
+                try:
+                    func(self.queue[(len(item) + 2):index])
+                except pickle.UnpicklingError:
+                    workerlog_write("Unable to unpickle data: %s\n" % ":".join("{:02x}".format(c) for c in self.queue))
+                    raise
                 self.queue = self.queue[(index + len(item) + 3):]
                 index = self.queue.find(b"</" + item + b">")
 
-- 
2.31.1


