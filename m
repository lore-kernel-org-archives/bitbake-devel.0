Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D46CC433FE
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 02:24:59 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web10.1441.1637547896753547701
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Nov 2021 18:24:58 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.43, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="320933687"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="320933687"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:24:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="588848664"
Received: from kkleong1-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.239.135])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:24:57 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 2/8] bitbake: correct deprecation warning in process.py
Date: Mon, 22 Nov 2021 10:24:43 +0800
Message-Id: 
 <4ce36c7ffbe518051f1a2b1979f58498d3c217e3.1637547674.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637547674.git.anuj.mittal@intel.com>
References: <cover.1637547674.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Nov 2021 02:24:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13086

From: Alexander Kanavin <alex.kanavin@gmail.com>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit aff52fe21a0b27f6302555c1e52a864550eb46ce)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 07bb785a..fcdce197 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -659,7 +659,7 @@ class BBUIEventQueue:
         self.reader = ConnectionReader(readfd)
 
         self.t = threading.Thread()
-        self.t.setDaemon(True)
+        self.t.daemon = True
         self.t.run = self.startCallbackHandler
         self.t.start()
 
-- 
2.33.1


