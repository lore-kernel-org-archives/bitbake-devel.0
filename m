Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mx.groups.io with SMTP id smtpd.web11.3973.1631747984007383249
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Sep 2021 16:19:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.151, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202605369"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="202605369"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:48 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="434303210"
Received: from chgan-mobl.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:47 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 3/5] cooker: Allow upstream for local hash equivalence server
Date: Thu, 16 Sep 2021 07:19:36 +0800
Message-Id: <e437f9032991884cb5da7a17298bb2d652e27419.1631747835.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631747835.git.anuj.mittal@intel.com>
References: <cover.1631747835.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Watt <jpewhacker@gmail.com>

The hash equivalence server has had the option to support a read-only
upstream server for some time now when launched as a standalone program,
but there was no way to set the upstream when using a locally started
server. Add a new variable called BB_HASHSERVE_UPSTREAM that can be used
to specify an upstream server when a local hash equivalence server is
used (e.g. BB_HASHSERVE is "auto")

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 250fa17f1391ff1ee01ab9b51d2a4f9aa35c1d1e)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cooker.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 39e10e613..f2beea2d3 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -389,7 +389,12 @@ class BBCooker:
             if not self.hashserv:
                 dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
                 self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
-                self.hashserv = hashserv.create_server(self.hashservaddr, dbfile, sync=False)
+                self.hashserv = hashserv.create_server(
+                    self.hashservaddr,
+                    dbfile,
+                    sync=False,
+                    upstream=self.data.getVar("BB_HASHSERVE_UPSTREAM") or None,
+                )
                 self.hashserv.process = multiprocessing.Process(target=self.hashserv.serve_forever)
                 self.hashserv.process.start()
             self.data.setVar("BB_HASHSERVE", self.hashservaddr)
-- 
2.31.1

