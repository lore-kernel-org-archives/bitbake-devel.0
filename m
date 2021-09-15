Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mx.groups.io with SMTP id smtpd.web11.3973.1631747984007383249
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Sep 2021 16:19:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.151, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202605380"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="202605380"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="434303218"
Received: from chgan-mobl.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:49 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 5/5] build: Catch and error upon circular task references
Date: Thu, 16 Sep 2021 07:19:38 +0800
Message-Id: <bbbddfd913012c5d4e1015a4131e894749df9f90.1631747835.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631747835.git.anuj.mittal@intel.com>
References: <cover.1631747835.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If there are circular task references, error on them rather than show
a recursion error. A simple reproducer is:

"""
do_packageswu () {
       :
}

addtask do_packageswu after do_image_complete before do_image_qa
"""

into image_types.bbclass. There is code in runqueue to detect these but
we never get that far with the current codebase.

[YOCTO #13140]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 339d4d6be515a71311b81fb9e99742af0d8a5130)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/build.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index b2715fc53..24ce327c5 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -1025,6 +1025,8 @@ def tasksbetween(task_start, task_end, d):
     def follow_chain(task, endtask, chain=None):
         if not chain:
             chain = []
+        if task in chain:
+            bb.fatal("Circular task dependencies as %s depends on itself via the chain %s" % (task, " -> ".join(chain)))
         chain.append(task)
         for othertask in tasks:
             if othertask == task:
-- 
2.31.1

