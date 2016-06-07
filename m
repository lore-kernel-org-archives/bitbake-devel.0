Return-Path: <mariano.lopez@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BA73E605B3
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jun 2016 20:32:45 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP; 07 Jun 2016 13:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,435,1459839600"; d="scan'208";a="117788833"
Received: from yctb01.ostc.intel.com (HELO yctb01.otcr.intel.com)
	([10.54.69.55])
	by fmsmga004.fm.intel.com with ESMTP; 07 Jun 2016 13:32:45 -0700
From: mariano.lopez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Jun 2016 12:27:39 +0000
Message-Id: <1465302459-38277-1-git-send-email-mariano.lopez@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH] lib/bb/main.py: Fix use of BBPOSTCONF and BBPRECONF
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
X-List-Received-Date: Tue, 07 Jun 2016 20:32:45 -0000

From: Mariano Lopez <mariano.lopez@linux.intel.com>

The functionality of BBPOSTCONF and BBPRECONF was added in
commit 21b314d4d1e5b8fbeb4cc57006f0a110f0b3aa8f but there
was a typo in the variable name that raises an exception
in bitbake.

[YOCTO #9235]

Signed-off-by: Mariano Lopez <mariano.lopez@linux.intel.com>
---
 bitbake/lib/bb/main.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index b296ef8..283f29b 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -281,10 +281,10 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
         # use configuration files from environment variables
         if "BBPRECONF" in os.environ:
-            option.prefile.append(os.environ["BBPRECONF"])
+            options.prefile.append(os.environ["BBPRECONF"])
 
         if "BBPOSTCONF" in os.environ:
-            option.postfile.append(os.environ["BBPOSTCONF"])
+            options.postfile.append(os.environ["BBPOSTCONF"])
 
         # fill in proper log name if not supplied
         if options.writeeventlog is not None and len(options.writeeventlog) == 0:
-- 
2.6.6


