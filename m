Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web11.4953.1632213334869589697
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Sep 2021 01:35:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210390188"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="210390188"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="701611433"
Received: from marsalan-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.172])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:30 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [hardknott][PATCH 6/8] bitbake-worker: Improve error handling
Date: Tue, 21 Sep 2021 16:35:14 +0800
Message-Id: <bba14ded214579b22e86c40691b3015e74a294d3.1632212181.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632212181.git.anuj.mittal@intel.com>
References: <cover.1632212181.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If bitbake-worker fails, return an error code showing that. Also
make the thread cleanup code explict in a finally clause as it would
otherwise hang.

[YOCTO #14393]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7e0af70fb53fb13f824ca954b8cc1dffee730233)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 bin/bitbake-worker | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 7d982f90b..3ca8c1853 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -513,9 +513,11 @@ except BaseException as e:
         import traceback
         sys.stderr.write(traceback.format_exc())
         sys.stderr.write(str(e))
-
-worker_thread_exit = True
-worker_thread.join()
+finally:
+    worker_thread_exit = True
+    worker_thread.join()
 
 workerlog_write("exiting")
+if not normalexit:
+    sys.exit(1)
 sys.exit(0)
-- 
2.31.1

