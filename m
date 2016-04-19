Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id D101160616
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 16:14:29 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga104.fm.intel.com with ESMTP; 19 Apr 2016 09:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,506,1455004800"; d="scan'208";a="948494233"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2016 09:14:30 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 7450D6A4006;
	Tue, 19 Apr 2016 10:02:07 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 16:54:39 +0300
Message-Id: <1461074079-8890-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bitbake: main: fix processing of BBEVENTLOG
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
X-List-Received-Date: Tue, 19 Apr 2016 16:14:30 -0000

Fixed typo that caused incorrect processing of BBEVENTLOG
environment variable. Even if variable is set it was igrnored
by bitbake.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/main.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index a28c751..e302173 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -247,7 +247,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         if "BBTOKEN" in os.environ:
             options.xmlrpctoken = os.environ["BBTOKEN"]
 
-        if "BBEVENTLOG" is os.environ:
+        if "BBEVENTLOG" in os.environ:
             options.writeeventlog = os.environ["BBEVENTLOG"]
 
         # fill in proper log name if not supplied
-- 
2.1.4


