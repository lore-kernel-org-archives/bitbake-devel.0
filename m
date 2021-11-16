Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DCAC433FE
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 03:32:52 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web12.5172.1637033566840862534
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Nov 2021 19:32:51 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.88, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="257369176"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="257369176"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:51 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="506232247"
Received: from jli90-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.214.145.204])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:49 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 5/8] cooker: check if upstream hash equivalence server
 is available
Date: Tue, 16 Nov 2021 11:32:34 +0800
Message-Id: 
 <e03ec0f26ff969919fc5413981172817a1c052eb.1637033341.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637033341.git.anuj.mittal@intel.com>
References: <cover.1637033341.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 03:32:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13053

From: Jose Quaresma <quaresma.jose@gmail.com>

When the user specify an invalid upstream hash equivalence server in
BB_HASHSERVE_UPSTREAM notify the user that we can't connect the server.

Signed-off-by: Jose Quaresma <quaresma.jose@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit be45aeb9a84f30c28711e87e2d2a4a86320a8d94)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cooker.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 89f1fad0..b041d2a0 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -388,12 +388,22 @@ class BBCooker:
             # Create a new hash server bound to a unix domain socket
             if not self.hashserv:
                 dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
+                upstream = self.data.getVar("BB_HASHSERVE_UPSTREAM") or None
+                if upstream:
+                    import socket
+                    try:
+                        sock = socket.create_connection(upstream.split(":"), 5)
+                        sock.close()
+                    except socket.error as e:
+                        bb.warn("BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash equivalence server at '%s': %s" 
+                                 % (upstream, repr(e)))
+
                 self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
                 self.hashserv = hashserv.create_server(
                     self.hashservaddr,
                     dbfile,
                     sync=False,
-                    upstream=self.data.getVar("BB_HASHSERVE_UPSTREAM") or None,
+                    upstream=upstream,
                 )
                 self.hashserv.process = multiprocessing.Process(target=self.hashserv.serve_forever)
                 self.hashserv.process.start()
-- 
2.33.1


