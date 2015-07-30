Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id CDFC4764A0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 16:25:32 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 30 Jul 2015 09:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="738931517"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 30 Jul 2015 09:25:33 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 55E3B6A4005;
	Thu, 30 Jul 2015 09:24:47 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 19:25:11 +0300
Message-Id: <d2929c8264a347ea4b468a28c260ba908cdda258.1438271912.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
References: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438271912.git.ed.bartosh@linux.intel.com>
References: <cover.1438271912.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 03/11] toaster tests: gitignore and use absolute path for log file
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 30 Jul 2015 16:25:34 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

gitignore the cache directory created by the http client

the log file for tests is already set up as an absolute path,
so no need to recompute the path

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 .gitignore                      | 3 +++
 lib/toaster/contrib/tts/recv.py | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 5adf4d1..8ca4b5d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,3 +12,6 @@ venv/
 doc/bitbake-user-manual/bitbake-user-manual.html
 doc/bitbake-user-manual/bitbake-user-manual.pdf
 doc/bitbake-user-manual/bitbake-user-manual.tgz
+lib/toaster/contrib/tts/backlog.txt
+lib/toaster/contrib/tts/log/*
+lib/toaster/contrib/tts/.cache/*
diff --git a/lib/toaster/contrib/tts/recv.py b/lib/toaster/contrib/tts/recv.py
index 2faf8d0..07efdac 100755
--- a/lib/toaster/contrib/tts/recv.py
+++ b/lib/toaster/contrib/tts/recv.py
@@ -25,7 +25,7 @@
 # |[full/path]/recv.py
 
 from __future__ import print_function
-import sys, os, config, shellutils
+import sys, config, shellutils
 
 from email.parser import Parser
 
@@ -46,7 +46,7 @@ def main():
     subject_parts = subject.split()
     if "[review-request]" in subject_parts:
         task_name = subject_parts[subject_parts.index("[review-request]") + 1]
-        with open(os.path.join(os.path.dirname(__file__), config.BACKLOGFILE), "a") as fout:
+        with open(config.BACKLOGFILE, "a") as fout:
             line = "%s|%s\n" % (task_name, config.TASKS.PENDING)
             fout.write(line)
 
-- 
2.1.4


