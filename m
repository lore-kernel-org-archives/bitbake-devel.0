Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 4351376FED
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 22:33:33 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so52468169pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 15:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=37pebFvPlJsxJu0uxjVN1UqugJRK5BCiEtyMp02E8Qc=;
	b=XgR/R8VllXsqLmmwza4YKI6jJS8MwlX4Sn5lsnMYceUD7nUesmmTCiNWG5yuJFY2eF
	FEDoQZpPwrwa+r82gjAnek/73pfesg0ZKF/glMAn7scbH2DqYM2Yoo/KTWiNE3z1MB5x
	47Iois+mlO5rYK9M42qT2aThbAJYYSUuBtCQ23bKbQZTQcnbGzoN0kH07aCnkWc9BoBR
	syQQsuTO1vWYNDnWGoD6rfGLvgWEXomj0ZdM/tAzbpaR9SSptXjVP2dZhlyJ1Y72aVY+
	fP/eOf6mgdI72Yvlt0x4Ks6LJVxUTiu37TRhtFidZIrps+9F8F2vhC5NdNvTAECwzvOM
	o89Q==
X-Received: by 10.66.164.230 with SMTP id yt6mr39763174pab.149.1443047613597; 
	Wed, 23 Sep 2015 15:33:33 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	qg2sm9796764pbb.80.2015.09.23.15.33.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 23 Sep 2015 15:33:33 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Sep 2015 15:34:57 -0700
Message-Id: <796df633be6bbfdb54d43d4056a2dd1520243f21.1443047547.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <de438abaff89a94027ae465a62dd4c0ce79ee208.1443047547.git.avery.brian@gmail.com>
References: <de438abaff89a94027ae465a62dd4c0ce79ee208.1443047547.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443047547.git.avery.brian@gmail.com>
References: <cover.1443047547.git.avery.brian@gmail.com>
Subject: [PATCH 5/6] toaster: make clone directory name unique
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
X-List-Received-Date: Wed, 23 Sep 2015 22:33:33 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Changed naming scheme for clone directory. Used full git url and branch to
make it unique. This should fix the issue with using the same git
repository, but different protocols, e.g. git://some.git.repo and
http://some.git.repo.

[YOCTO #8101]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index c22d41b..f826ad6 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -179,14 +179,9 @@ class LocalhostBEController(BuildEnvironmentController):
         logger.debug("localhostbecontroller: Stopped bitbake server")
 
     def getGitCloneDirectory(self, url, branch):
-        """ Utility that returns the last component of a git path as directory
-        """
-        components = re.split(r'[:\.\/]', url)
-        base = components[-2] if components[-1] == "git" else components[-1]
-
+        """Construct unique clone directory name out of url and branch."""
         if branch != "HEAD":
-            return "_%s_%s.toaster_cloned" % (base, branch)
-
+            return "_%s_%s.toaster_cloned" % (re.sub('[:/]', '_', url), branch)
 
         # word of attention; this is a localhost-specific issue; only on the localhost we expect to have "HEAD" releases
         # which _ALWAYS_ means the current poky checkout
-- 
1.9.1


