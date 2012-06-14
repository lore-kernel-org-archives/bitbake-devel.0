Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1Sf0be-0006Cd-VL
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 05:20:23 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5E39jsm009202
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jun 2012 20:09:45 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 13 Jun 2012 20:09:44 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 13 Jun 2012 22:09:38 -0500
Message-ID: <1339643381-23026-2-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339643381-23026-1-git-send-email-jason.wessel@windriver.com>
References: <1339643381-23026-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/4] fetch2: Fix missing output from stderr in fetcher logs
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
X-List-Received-Date: Thu, 14 Jun 2012 03:20:23 -0000
Content-Type: text/plain

There are actually two problems to fix

1) The exception for bb.process.ExecutionError must be processed first
   because it is a derived from the bb.process.CmdError class and
   we never reach the ExecutionError otherwise.

2) The stderr needs to be printed as well as stdout to determine
   the root cause of a fetch failure.

The example I have is that I got a log that looked like:

--
ERROR: Function failed: Network access disabled through
  BB_NO_NETWORK but access requested with command
   /usr/bin/env wget -t 5 -nv --passive-ftp --no-check-certificate -P
   /localds 'http://downloads.yoctoproject.org/[...CLIPPED...] url None)
--

That really didn't tell me much, but with this patch I get error above
plus the following:

--
STDERR: /net/[...CLIPPED...]kernel-tools.git: Read-only file system
--

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/fetch2/__init__.py |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 83050e4..324eef2 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -437,11 +437,10 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
         success = True
     except bb.process.NotFoundError as e:
         error_message = "Fetch command %s" % (e.command)
+    except bb.process.ExecutionError as e:
+        error_message = "Fetch command %s failed with exit code %s, output:\nSTDOUT: %s\nSTDERR: %s" % (e.command, e.exitcode, e.stdout, e.stderr)
     except bb.process.CmdError as e:
         error_message = "Fetch command %s could not be run:\n%s" % (e.command, e.msg)
-    except bb.process.ExecutionError as e:
-        error_message = "Fetch command %s failed with exit code %s, output:\n%s" % (e.command, e.exitcode, e.stderr)
-
     if not success:
         for f in cleanup:
             try:
-- 
1.7.10



