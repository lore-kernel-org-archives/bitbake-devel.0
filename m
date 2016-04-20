Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 592CE60119
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Apr 2016 09:51:22 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga102.fm.intel.com with ESMTP; 20 Apr 2016 02:51:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,509,1455004800"; d="scan'208";a="958880478"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 20 Apr 2016 02:51:23 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 98A826A4002;
	Wed, 20 Apr 2016 03:39:00 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Apr 2016 10:31:28 +0300
Message-Id: <1461137489-14968-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1461076236-9289-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1461076236-9289-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH 1/2] bitbake: main: add 2 environment variables
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
X-List-Received-Date: Wed, 20 Apr 2016 09:51:24 -0000

Bitbake uses set of environment variables to set command line
options, e.g. seeting BBTOKEN variable has the same effect
as using --token command line option.

Added new environment variables BBPRECONF and BBPOSTCONF that
are equivalents of --read and --postread command line options.
They can be used by high level scripts to append or prepend
configuration files to conf/local.conf

[YOCTO #9235]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/main.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index e302173..08ecdda 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -250,6 +250,12 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         if "BBEVENTLOG" in os.environ:
             options.writeeventlog = os.environ["BBEVENTLOG"]
 
+        if "BBPRECONF" in os.environ:
+            option.prefile.append(os.environ["BBPRECONF"])
+
+        if "BBPOSTCONF" in os.environ:
+            option.postfile.append(os.environ["BBPOSTCONF"])
+
         # fill in proper log name if not supplied
         if options.writeeventlog is not None and len(options.writeeventlog) == 0:
             import datetime
-- 
2.1.4


