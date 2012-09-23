Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TFppF-00034A-9J
	for bitbake-devel@lists.openembedded.org;
	Sun, 23 Sep 2012 19:18:37 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 23 Sep 2012 10:05:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,470,1344236400"; d="scan'208";a="148102839"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.252])
	by AZSMGA002.ch.intel.com with ESMTP; 23 Sep 2012 10:05:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 23 Sep 2012 18:05:35 +0100
Message-Id: <1348419936-13985-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 1/2] fetch2: make fetch failure errors more readable
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
X-List-Received-Date: Sun, 23 Sep 2012 17:18:37 -0000

Most of the time we don't need to see the fetch command; the fetch log
includes the command as a debug message in any case, so omit it. Also
adjust the way command output is printed (we don't need stderr/stdout
labelled, and print "no output" instead of "output:\nNone" when there is
no output.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 37f7d75..1acb0a4 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -471,7 +471,13 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
     except bb.process.NotFoundError as e:
         error_message = "Fetch command %s" % (e.command)
     except bb.process.ExecutionError as e:
-        error_message = "Fetch command %s failed with exit code %s, output:\nSTDOUT: %s\nSTDERR: %s" % (e.command, e.exitcode, e.stdout, e.stderr)
+        if e.stdout:
+            output = "output:\n%s\n%s" % (e.stdout, e.stderr)
+        elif e.stderr:
+            output = "output:\n%s" % e.stderr
+        else:
+            output = "no output"
+        error_message = "Fetch command failed with exit code %s, %s" % (e.exitcode, output)
     except bb.process.CmdError as e:
         error_message = "Fetch command %s could not be run:\n%s" % (e.command, e.msg)
     if not success:
-- 
1.7.9.5



