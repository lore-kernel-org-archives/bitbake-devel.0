Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id DA0C377002
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 22:33:33 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so52468454pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=akkndhcViaMOobifSyesqL4BTh5iEY96o7K70bSD+v0=;
	b=XbDSN7sxcpVcB8F8A/pxN3qag06GeBtqIb8y1OBGKJ3NR+nrjY7yKDHOAKzceLrMjM
	qx+QIgl0eqjD+yPOTESxp7JiQYBKs8xuZWvZ8ojGll/kYHJxU7Bb92FR6mbO7337EeYg
	BlqT01Arc4qtnATJ3Iiq60k2SAWZHfwsRi6VZwtleh5sthWNJPyhTMr/QR7kT1Suc28Y
	9f0GAunvysaSYYWDZytxUtCLSgKgmQPAq/Bpce0T7Oan0JZFworsflYr0Yg0lPyc6AJI
	3WqsgBfdP+wPdioAbjwCRa25hO9bfPUpy742l76M+ThGEbIEWFya1daYjzkv3im3gMON
	oVmA==
X-Received: by 10.66.240.37 with SMTP id vx5mr40000146pac.76.1443047614451;
	Wed, 23 Sep 2015 15:33:34 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	qg2sm9796764pbb.80.2015.09.23.15.33.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 23 Sep 2015 15:33:33 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Sep 2015 15:34:58 -0700
Message-Id: <75201911f45406a830da7302dcf5b420b2d16455.1443047547.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <de438abaff89a94027ae465a62dd4c0ce79ee208.1443047547.git.avery.brian@gmail.com>
References: <de438abaff89a94027ae465a62dd4c0ce79ee208.1443047547.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443047547.git.avery.brian@gmail.com>
References: <cover.1443047547.git.avery.brian@gmail.com>
Subject: [PATCH 6/6] toaster: move clones into subdirectory
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
X-List-Received-Date: Wed, 23 Sep 2015 22:33:34 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

By default Toaster clones layers to the same level where
poky clone is. This can look messy if a lot of layers are
used for Toaster builds.

Moving them into _toaster_clones/ subdirectory should make
directory structure looking cleaner. It also safer to isolate
toaster clones from what user might create.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index f826ad6..d3528e8 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -181,7 +181,7 @@ class LocalhostBEController(BuildEnvironmentController):
     def getGitCloneDirectory(self, url, branch):
         """Construct unique clone directory name out of url and branch."""
         if branch != "HEAD":
-            return "_%s_%s.toaster_cloned" % (re.sub('[:/]', '_', url), branch)
+            return "_toaster_clones/_%s_%s" % (re.sub('[:/]', '_', url), branch)
 
         # word of attention; this is a localhost-specific issue; only on the localhost we expect to have "HEAD" releases
         # which _ALWAYS_ means the current poky checkout
-- 
1.9.1


