Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>) id 1SW86G-0002kX-TP
	for bitbake-devel@lists.openembedded.org;
	Sun, 20 May 2012 17:31:17 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id q4KFL8HG015189
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 May 2012 17:21:09 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1SW7wS-0001Bf-NE; Sun, 20 May 2012 17:21:08 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 20 May 2012 17:21:07 +0200
Message-Id: <1337527267-2196-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 1.7.7.6
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 0.995
X-Spam-Score: -5.3
X-Spam-Level: -----
X-Spam-Tests: AWL,BAYES_00,SPF_NEUTRAL,T_RP_MATCHES_RCVD,DSPAM_INNOCENT
X-Scanned-By: MIMEDefang 2.73
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH] bitbake: added -j option
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
X-List-Received-Date: Sun, 20 May 2012 15:31:17 -0000

This patch adds an -j option which overrides/sets BB_NUMBER_THREADS.
For some use cases like '-c fetchall' it might be useful to modify
temporarily the number of parallel running tasks without editing
bitbake.conf.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 bin/bitbake      |    4 ++++
 doc/bitbake.1    |    4 ++++
 lib/bb/cooker.py |    7 +++++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 478ac06..b29fae9 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -171,6 +171,10 @@ Default BBFILES are the .bb files in the current directory.""")
 
     parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
                action = "store", dest = "bind", default = False)
+
+    parser.add_option("-j", "--jobs", help = "The number of threads BitBake should run at once",
+                      action = "store", dest = "number_threads", default = None)
+
     options, args = parser.parse_args(sys.argv)
 
     configuration = BBConfiguration(options)
diff --git a/doc/bitbake.1 b/doc/bitbake.1
index d9d3902..d1f1a40 100644
--- a/doc/bitbake.1
+++ b/doc/bitbake.1
@@ -103,6 +103,10 @@ Show debug logging for the specified logging domains
 .TP
 .B \-P, \-\-profile
 profile the command and print a report
+.TP
+.B \-j\fR [\fIjobs\fR], \fB\-\-jobs\fR[=\fIjobs\fR]
+The number of threads BitBake should run at once.  This option
+overrides the \fI${BB_NUMBER_THREADS}\fR configuration variable.
 
 .SH ENVIRONMENT VARIABLES
 bitbake uses the following environment variables to control its
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 123d0c1..a1e2347 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -142,6 +142,13 @@ class BBCooker:
         self.configuration.data = None
         self.loadConfigurationData()
 
+        if self.configuration.number_threads != None:
+            num = int(self.configuration.number_threads)
+            if num == 0:
+                num = multiprocessing.cpu_count()
+
+            self.configuration.data.setVar("BB_NUMBER_THREADS", str(num))
+
         # Take a lock so only one copy of bitbake can run against a given build
         # directory at a time
         lockfile = self.configuration.data.expand("${TOPDIR}/bitbake.lock")
-- 
1.7.7.6



