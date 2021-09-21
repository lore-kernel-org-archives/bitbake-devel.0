Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web11.4953.1632213334869589697
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Sep 2021 01:35:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210390186"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="210390186"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="701611427"
Received: from marsalan-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.172])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:29 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [hardknott][PATCH 5/8] cooker/process: Fix typos in exiting message
Date: Tue, 21 Sep 2021 16:35:13 +0800
Message-Id: <bbccee0c5bd9503131c96327f1b727522990cf9b.1632212181.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632212181.git.anuj.mittal@intel.com>
References: <cover.1632212181.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Jansa <Martin.Jansa@gmail.com>

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1ff1ea3880d293b14ce0fc65e3bc4c938d587a2f)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 bin/bitbake-worker       | 2 +-
 lib/bb/cooker.py         | 2 +-
 lib/bb/server/process.py | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 7765b9368..7d982f90b 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -517,5 +517,5 @@ except BaseException as e:
 worker_thread_exit = True
 worker_thread.join()
 
-workerlog_write("exitting")
+workerlog_write("exiting")
 sys.exit(0)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f2beea2d3..89f1fad08 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -382,7 +382,7 @@ class BBCooker:
         try:
             self.prhost = prserv.serv.auto_start(self.data)
         except prserv.serv.PRServiceConfigError as e:
-            bb.fatal("Unable to start PR Server, exitting")
+            bb.fatal("Unable to start PR Server, exiting")
 
         if self.data.getVar("BB_HASHSERVE") == "auto":
             # Create a new hash server bound to a unix domain socket
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index a0955722e..07bb785a1 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -471,7 +471,7 @@ class BitBakeServer(object):
             try:
                 r = ready.get()
             except EOFError:
-                # Trap the child exitting/closing the pipe and error out
+                # Trap the child exiting/closing the pipe and error out
                 r = None
         if not r or r[0] != "r":
             ready.close()
-- 
2.31.1

