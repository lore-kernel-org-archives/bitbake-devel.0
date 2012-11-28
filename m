Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TdoRA-00049L-Bm for bitbake-devel@lists.openembedded.org;
	Wed, 28 Nov 2012 21:40:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qASKQR4U017484;
	Wed, 28 Nov 2012 20:26:27 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 16956-05; Wed, 28 Nov 2012 20:26:23 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qASKQGKV017478
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Nov 2012 20:26:17 GMT
Message-ID: <1354134376.15992.5.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 28 Nov 2012 20:26:16 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "Eggleton, Paul" <paul.eggleton@intel.com>
Subject: [PATCH] build.py: Preserve sigdata files in the stamps directory
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 28 Nov 2012 20:40:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Leaving the sigdata files around can aid debugging and doesn't harm
anything. This is the easiest way to allow this to happen.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 8ff7fb2..f9f0a65 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -29,6 +29,7 @@ import os
 import sys
 import logging
 import shlex
+import glob
 import bb
 import bb.msg
 import bb.process
@@ -504,8 +505,12 @@ def make_stamp(task, d, file_name = None):
     """
     cleanmask = stamp_cleanmask_internal(task, d, file_name)
     for mask in cleanmask:
-        bb.utils.remove(mask)
-
+        # Preserve sigdata files in the stamps directory
+        for name in glob.glob(mask):
+            if name.find("sigdata") != -1:
+                continue
+            os.unlink(name)
+    
     stamp = stamp_internal(task, d, file_name)
     # Remove the file and recreate to force timestamp
     # change on broken NFS filesystems




