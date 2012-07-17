Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jeffrey.honig@windriver.com>) id 1SqyC1-0003pM-OF
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Jul 2012 05:11:22 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q6H0n0LN011378
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Jul 2012 17:49:00 -0700 (PDT)
Received: from jch-schlepp.wrs.com (172.25.32.253) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Mon, 16 Jul 2012 17:48:58 -0700
Received: from schlepp.honig.net (schlepp.honig.net [127.0.0.1])	by
	jch-schlepp.wrs.com (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q6H0mvIm009187	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
	verify=NOT)	for <bitbake-devel@lists.openembedded.org>; Mon, 16 Jul 2012
	20:48:57 -0400
Received: (from jch@localhost)	by schlepp.honig.net (8.14.4/8.14.4/Submit) id
	q6H0mvsv009186	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Jul 2012 20:48:57 -0400
From: Jeffrey C Honig <jeffrey.honig@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 16 Jul 2012 20:48:57 -0400
Message-ID: <1342486137-9149-1-git-send-email-jeffrey.honig@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
Subject: [PATCH] siggen.py: Insure .siginfo files writes into shared sstate cache are atomic
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
X-List-Received-Date: Tue, 17 Jul 2012 03:11:22 -0000
Content-Type: text/plain

   Use tempfile.mkstemp to create a temporary file in the sstate dir and move it
   into place after closing.  The previous code would fail in the chmod() if two
   users were running jobs that touched the same signature file.

Signed-off-by: Jeffrey C Honig <jeffrey.honig@windriver.com>
---
 lib/bb/siggen.py |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index edd98fc..02a4268 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -2,6 +2,7 @@ import hashlib
 import logging
 import os
 import re
+import tempfile
 import bb.data
 
 logger = logging.getLogger('BitBake.SigGen')
@@ -236,10 +237,20 @@ class SignatureGeneratorBasic(SignatureGenerator):
         if taint:
             data['taint'] = taint
 
-        with open(sigfile, "wb") as f:
-            p = pickle.Pickler(f, -1)
-            p.dump(data)
-        os.chmod(sigfile, 0664)
+        fd, tmpfile = tempfile.mkstemp(dir=os.path.dirname(sigfile), prefix="sigtask.")
+        try:
+            with os.fdopen(fd, "wb") as stream:
+                p = pickle.dump(data, stream, -1)
+                stream.flush()
+                os.fsync(fd)
+            os.chmod(tmpfile, 0664)
+            os.rename(tmpfile, sigfile)
+        except (OSError, IOError), err:
+            try:
+                os.unlink(tmpfile)
+            except OSError:
+                pass
+            raise err
 
     def dump_sigs(self, dataCache):
         for fn in self.taskdeps:
-- 
1.7.5.4



