Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SCbsf-0006UT-AE
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 21:16:33 +0200
Received: by ggcy3 with SMTP id y3so217953ggc.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Mar 2012 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=DIO+ixYSTAAN/k78BPLuQKZ9jOlROWldQZdAMuwCj+0=;
	b=ByCSaPXEmlINaJge0/j2YUz16vVNJ+I3OjLg5bcmMTEldq8KtyeH2/9tHTvBvP4vFt
	eLBfulPlF/b1gxxMkGBSJraH6fXpYsKyhDhekNpgZjx84Czfw9UcGLhfoHyE098tDHzN
	Zrc+QmdGOBBUmqmvm0fwnT5TTBXT9vKBwG4exJomI6U084nFn8qyXXE/pGWoT4cJuVoi
	aRjJU3j5krIreZg0C5Hkp2dg0bCNMcueI7t04KLhW1ZChWX/5TC0CXluwo8YNXpZs6Tw
	TfNdEVsS5MJf4PtaAc+zqk8yyR/sjpRn+RU+/txSjenlpA2RvQrplmLEXc6lM/sRm57J
	RU4w==
Received: by 10.60.25.162 with SMTP id d2mr35808990oeg.30.1332875251455;
	Tue, 27 Mar 2012 12:07:31 -0700 (PDT)
Received: from localhost.localdomain (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPS id c6sm532090oec.13.2012.03.27.12.07.29
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 27 Mar 2012 12:07:30 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Mar 2012 14:07:23 -0500
Message-Id: <1332875243-16798-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.7.7
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] bb.build: use relative log links, not absolute
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
X-List-Received-Date: Tue, 27 Mar 2012 19:16:33 -0000

From: Christopher Larson <chris_larson@mentor.com>

Using symlinks to absolute paths isn't gaining us anything, and can cause
problems in situations such as automated build systems when they try to
resolve the link, depending on the mechanism used to pull the build artifacts
(e.g. nfs).

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/build.py |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 736ba24..95f1dcf 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -291,12 +291,13 @@ def _exec_task(fn, task, d, quieterr):
 
     bb.utils.mkdirhier(tempdir)
     loglink = os.path.join(tempdir, 'log.{0}'.format(task))
-    logfn = os.path.join(tempdir, 'log.{0}.{1}'.format(task, os.getpid()))
+    logbase = 'log.{0}.{1}'.format(task, os.getpid())
+    logfn = os.path.join(tempdir, logbase)
     if loglink:
         bb.utils.remove(loglink)
 
         try:
-           os.symlink(logfn, loglink)
+           os.symlink(logbase, loglink)
         except OSError:
            pass
 
-- 
1.7.7



