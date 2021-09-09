Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web10.1721.1631150740998903355
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Sep 2021 18:25:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="281660554"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="281660554"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 18:25:42 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="431575293"
Received: from mshovon-mobl.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.213.138.179])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 18:25:40 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 1/1] server: Fix early parsing errors preventing zombie bitbake
Date: Thu,  9 Sep 2021 09:25:33 +0800
Message-Id: <75ac16973baf1980bf3cf3c1ffac80018c732042.1631150635.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631150635.git.anuj.mittal@intel.com>
References: <cover.1631150635.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Watt <JPEWhacker@gmail.com>

If the client process never sends cooker data, the server timeout will
be 0.0, not None. This will prevent the server from exiting, as it is
waiting for a new client. In particular, the client will disconnect with
a bad "INHERIT" line, such as:

    INHERIT += "this-class-does-not-exist"

Instead of checking explicitly for None, check for a false value, which
means either 0.0 or None.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 13e2855bff6a6ead6dbd33c5be4b988aafcd4afa)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 155e8d131..a0955722e 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -147,7 +147,7 @@ class ProcessServer():
                 conn = newconnections.pop(-1)
                 fds.append(conn)
                 self.controllersock = conn
-            elif self.timeout is None and not ready:
+            elif not self.timeout and not ready:
                 serverlog("No timeout, exiting.")
                 self.quit = True
 
-- 
2.31.1

