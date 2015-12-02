Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 95E7E60667
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:39 +0000 (UTC)
Received: by padhx2 with SMTP id hx2so47138367pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=a7Ly4MvzeZUqqYWN8zzrFPpLjxnLKllcystkWalJHKM=;
	b=goocngxapa3lb9NWp7rEJQuW3+AT+39kARobHYUJzhGtCgG5+3JzKMSG9Y3ICgJ28g
	u4ID+PjLrzNo4v5SEj76ntJ3SMn7vMex6/wiWkJhfNSUZkEHuSD34IW42CtXRHFDG+ms
	KQLLV8Xo27M54JBFWSnC0OqtZDK7H20VgsyXoYQHO8yxNId6iTfabkyc+e7wyjzYbJVt
	Xu6CS4WRYyhkbNXMC+xLRVQEw5YkJxuXKsJi01nTrrXLVj45ovLpRFXtv7xjR2puZ3UO
	gungTS7c/PHK+eJs6n66zbRmWbluTeafnEQ3FjW6sm6IvOEHWcH1f0/+4nWYviP6VcKc
	PuFQ==
X-Received: by 10.98.80.20 with SMTP id e20mr6442666pfb.23.1449079180071;
	Wed, 02 Dec 2015 09:59:40 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:39 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:40 -0800
Message-Id: <5451e0ae7a91b5cc40b567af5ad092b89a296af3.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 08/30] toaster: make runbuilds to loop
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:39 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Made runbuilds to loop to avoid having a loop in shell code and
initialize heavy Django init machinery every second.

Ignored exceptions to prevent exiting a loop.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 5243a50..48dc618 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -5,6 +5,7 @@ from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdExcep
 from bldcontrol.models import BuildRequest, BuildEnvironment, BRError, BRVariable
 import os
 import logging
+import time
 
 logger = logging.getLogger("ToasterScheduler")
 
@@ -128,6 +129,12 @@ class Command(NoArgsCommand):
 
 
     def handle_noargs(self, **options):
-        self.cleanup()
-        self.archive()
-        self.schedule()
+        while True:
+            try:
+                self.cleanup()
+                self.archive()
+                self.schedule()
+            except:
+                pass
+
+            time.sleep(1)
-- 
1.9.1


