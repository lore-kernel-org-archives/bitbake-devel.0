Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>) id 1SW84T-0002gf-9L
	for bitbake-devel@lists.openembedded.org;
	Sun, 20 May 2012 17:29:25 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id q4KFJEMj014972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 May 2012 17:19:15 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1SW7ub-00055Q-Kb; Sun, 20 May 2012 17:19:13 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 20 May 2012 17:19:11 +0200
Message-Id: <1337527151-3526-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
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
Subject: [PATCH] bitbake: support $BITBAKE_UI environment
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
X-List-Received-Date: Sun, 20 May 2012 15:29:25 -0000

Patch adds support for a $BITBAKE_UI environment variable which allows
to configure the preferred user interface. Although an '-u' option
(which will override the environment variable) exists already, it was
required to specify this option on every invocation of bitbake.

Because user interface is instanciated very early in the program it is
not possible to use bitbake.conf for setting up a default.  An
environment variable (which acts in a similar category like $PAGER or
$EDITOR) is a simple way for configuring the default.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 bin/bitbake   |    9 +++++----
 doc/bitbake.1 |    6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 420e69d..478ac06 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -56,10 +56,11 @@ class BBConfiguration(object):
 
 
 def get_ui(config):
-    if config.ui:
-        interface = config.ui
-    else:
-        interface = 'knotty'
+    if not config.ui:
+        # modify 'ui' attribute because it is also read by cooker
+        config.ui = os.environ.get('BITBAKE_UI', 'knotty')
+
+    interface = config.ui
 
     try:
         # Dynamically load the UI based on the ui name. Although we
diff --git a/doc/bitbake.1 b/doc/bitbake.1
index aa09620..d9d3902 100644
--- a/doc/bitbake.1
+++ b/doc/bitbake.1
@@ -103,7 +103,13 @@ Show debug logging for the specified logging domains
 .TP
 .B \-P, \-\-profile
 profile the command and print a report
+
+.SH ENVIRONMENT VARIABLES
+bitbake uses the following environment variables to control its
+operation:
 .TP
+.B BITBAKE_UI
+The bitbake user interface; overridden by the \fB-u\fP commandline option.
 
 .SH AUTHORS
 BitBake was written by 
-- 
1.7.7.6



