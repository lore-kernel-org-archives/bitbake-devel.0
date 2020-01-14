Return-Path: <frazer.clews@codethink.co.uk>
X-Greylist: delayed 331 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 14 Jan 2020 14:46:20 UTC
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk
	[78.40.148.184])
	by mail.openembedded.org (Postfix) with ESMTP id E331A7FBE2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jan 2020 14:46:20 +0000 (UTC)
Received: from [167.98.27.226] (helo=localhost.co.uk)
	by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1irNSW-0004um-VW; Tue, 14 Jan 2020 14:46:21 +0000
From: frazer.clews@codethink.co.uk
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jan 2020 14:46:06 +0000
Message-Id: <20200114144606.163629-1-frazer.clews@codethink.co.uk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 14 Jan 2020 22:30:13 +0000
Subject: [PATCH] replaced deprecated method warn() with warning()
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
X-List-Received-Date: Tue, 14 Jan 2020 14:46:21 -0000
Content-Transfer-Encoding: 8bit

From: Frazer Clews <frazer.clews@codethink.co.uk>

Removed the deprecated methods as it will only cause problems later on,
and since warn() just calls warning(), it shouldn't change anything

Signed-off-by: Frazer Clews <frazer.clews@codethink.co.uk>
---
 lib/bb/cooker.py                                        | 2 +-
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b74affa7..911805a6 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1788,7 +1788,7 @@ class CookerCollectFiles(object):
                 # When constructing an older style single regex, it's possible for BBMASK
                 # to end up beginning with '|', which matches and masks _everything_.
                 if mask.startswith("|"):
-                    collectlog.warn("BBMASK contains regular expression beginning with '|', fixing: %s" % mask)
+                    collectlog.warning("BBMASK contains regular expression beginning with '|', fixing: %s" % mask)
                     mask = mask[1:]
                 try:
                     re.compile(mask)
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 50ec4098..19f659ec 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -168,17 +168,17 @@ class Command(BaseCommand):
         try:
             self.cleanup()
         except Exception as e:
-            logger.warn("runbuilds: cleanup exception %s" % str(e))
+            logger.warning("runbuilds: cleanup exception %s" % str(e))
 
         try:
             self.archive()
         except Exception as e:
-            logger.warn("runbuilds: archive exception %s" % str(e))
+            logger.warning("runbuilds: archive exception %s" % str(e))
 
         try:
             self.schedule()
         except Exception as e:
-            logger.warn("runbuilds: schedule exception %s" % str(e))
+            logger.warning("runbuilds: schedule exception %s" % str(e))
 
     def handle(self, **options):
         pidfile_path = os.path.join(os.environ.get("BUILDDIR", "."),
-- 
2.24.1


