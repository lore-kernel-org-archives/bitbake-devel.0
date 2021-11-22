Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E18AC433F5
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 02:25:02 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web10.1441.1637547896753547701
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Nov 2021 18:25:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.43, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="320933698"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="320933698"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:25:01 -0800
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="588848673"
Received: from kkleong1-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.239.135])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:25:00 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 4/8] hashserv: let asyncio discover the running loop
Date: Mon, 22 Nov 2021 10:24:45 +0800
Message-Id: 
 <a072d225bf3fe5fd2f81a44867f7cf9629b6dddd.1637547674.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637547674.git.anuj.mittal@intel.com>
References: <cover.1637547674.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Nov 2021 02:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13088

From: Justin Bronder <jsbronder@cold-front.org>

>From 3.10 documentation [1]:
    Deprecated since version 3.8, removed in version 3.10: The loop
    parameter. This function has been implicitly getting the current
    running loop since 3.7

This is fixed in master as a side-effect of
cf9bc0310b0092bf52b61057405aeb51c86ba137 which is more intrusive but
likewise drops the loop parameter.

1. https://docs.python.org/3/library/asyncio-stream.html#asyncio.open_connection

Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 74a1e71b1e677a482fdedc685a71a1798ad63920)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/hashserv/server.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index a0dc0c17..df0fa0a0 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -521,7 +521,7 @@ class Server(object):
 
     def start_tcp_server(self, host, port):
         self.server = self.loop.run_until_complete(
-            asyncio.start_server(self.handle_client, host, port, loop=self.loop)
+            asyncio.start_server(self.handle_client, host, port)
         )
 
         for s in self.server.sockets:
@@ -546,7 +546,7 @@ class Server(object):
             # Work around path length limits in AF_UNIX
             os.chdir(os.path.dirname(path))
             self.server = self.loop.run_until_complete(
-                asyncio.start_unix_server(self.handle_client, os.path.basename(path), loop=self.loop)
+                asyncio.start_unix_server(self.handle_client, os.path.basename(path))
             )
         finally:
             os.chdir(cwd)
-- 
2.33.1


