Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1SX0l3-0000qa-KG
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 03:53:02 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4N1gpRp022300
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 May 2012 18:42:51 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Tue, 22 May 2012 18:42:50 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 22 May 2012 20:46:30 -0500
Message-ID: <1337737597-5964-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1337714416.git.mark.hatle@windriver.com>
References: <cover.1337714416.git.mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 1/3] build.py: Add a log to capture task execution order
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
X-List-Received-Date: Wed, 23 May 2012 01:53:02 -0000
Content-Type: text/plain

The new log.task_order contains an ordered list of the tasks as they
were executed in any given recipe.  The format of the lines is
<task> <pid>: <log file>

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/build.py |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 95f1dcf..4f06b15 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -290,8 +290,22 @@ def _exec_task(fn, task, d, quieterr):
         bb.fatal("T variable not set, unable to build")
 
     bb.utils.mkdirhier(tempdir)
-    loglink = os.path.join(tempdir, 'log.{0}'.format(task))
+
+    # Determine the logfile to generate
     logbase = 'log.{0}.{1}'.format(task, os.getpid())
+
+    # Document the order of the tasks...
+    logorder = os.path.join(tempdir, 'log.task_order')
+    try:
+        logorderfile = file(logorder, 'a')
+    except OSError:
+        logger.exception("Opening log file '%s'", logorder)
+        pass
+    logorderfile.write('{0} ({1}): {2}\n'.format(task, os.getpid(), logbase))
+    logorderfile.close()
+
+    # Setup the courtesy link to the logfn
+    loglink = os.path.join(tempdir, 'log.{0}'.format(task))
     logfn = os.path.join(tempdir, logbase)
     if loglink:
         bb.utils.remove(loglink)
-- 
1.7.3.4



