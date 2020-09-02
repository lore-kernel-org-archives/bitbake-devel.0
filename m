Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 by mx.groups.io with SMTP id smtpd.web10.17334.1599077426980584968
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2020 13:10:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: kernel.crashing.org, ip: 76.164.61.194, mailfrom: mark.hatle@kernel.crashing.org)
Received: from lons-builder.int.hatle.net ([192.168.0.2])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 082KAMVU004412
	for <bitbake-devel@lists.openembedded.org>; Wed, 2 Sep 2020 15:10:24 -0500
From: "Mark Hatle" <mark.hatle@kernel.crashing.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] process.py: Handle SystemExit exception to eliminate backtrace
Date: Wed,  2 Sep 2020 15:10:22 -0500
Message-Id: <20200902201022.157850-1-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1

With an invalid layer, the desired error output should be:

  ERROR: The following layer directories do not exist:
  ERROR:    /this_path_does_not_exist
  ERROR: Please check BBLAYERS in .../build-invalid-layer/conf/bblayers.conf

Instead we were met with a backtrace:

Traceback (most recent call last):
  File "/scratch1/fray/xilinx/poky/bitbake/bin/bitbake", line 36, in <module>
    cookerdata.CookerConfiguration()))
...
  File "/scratch1/fray/xilinx/poky/bitbake/lib/bb/cookerdata.py", line 267, in parseBaseConfiguration
    self.data = self.parseConfigurationFiles(self.prefiles, self.postfiles)
  File "/scratch1/fray/xilinx/poky/bitbake/lib/bb/cookerdata.py", line 358, in parseConfigurationFiles
    sys.exit(1)
SystemExit: 1

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 8699765a31..c972fe567d 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -368,7 +368,7 @@ class ServerCommunicator():
         ret, exc = self.recv.get()
         # Should probably turn all exceptions in exc back into exceptions?
         # For now, at least handle BBHandledException
-        if exc and "BBHandledException" in exc:
+        if exc and ("BBHandledException" in exc or "SystemExit" in exc):
             raise bb.BBHandledException()
         return ret, exc
 
-- 
2.17.1

