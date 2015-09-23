Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id 1BD2F76417
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 22:33:30 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so52544920pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=e9tPQttA3s9twDcmXKiqLHWa5JKafVHDEgCUAHNXsVI=;
	b=F5x6BuLb/OKGDRzhMOaMKvZrHDh+7+/MLPviSjKJli7mzPxPwNWJjCG2O+RVzk0i4z
	4X0lO8XYf9YdptF8aMa8p55T0jotZ6pPrVOAab4zSFtB8jabtH6HzN3729iuUUHWW+dj
	plfLGjx7sGEpEJH9XWZDbfDO0K3LqOcszkfUpis2XQhHZbIFx4rV62o488KCKMJavNPp
	F+wNJfpMHSF1O1fbOAeWv9x37l3q50TcMiMYRzpsgzIaTFbUvmSdflCSuZgs1/KPzaVR
	/K9iBrzOJrFo8Fb6m1SXof60J/Q7Llxzl+UxkLkrWcrXYcr/J43qI/wOLJZ9Ty/MEb16
	0EDg==
X-Received: by 10.66.220.2 with SMTP id ps2mr39627164pac.128.1443047611140;
	Wed, 23 Sep 2015 15:33:31 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	qg2sm9796764pbb.80.2015.09.23.15.33.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 23 Sep 2015 15:33:30 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Sep 2015 15:34:54 -0700
Message-Id: <69f00abf5b02e416ff25c66f7d05508500b6998c.1443047547.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <de438abaff89a94027ae465a62dd4c0ce79ee208.1443047547.git.avery.brian@gmail.com>
References: <de438abaff89a94027ae465a62dd4c0ce79ee208.1443047547.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443047547.git.avery.brian@gmail.com>
References: <cover.1443047547.git.avery.brian@gmail.com>
Subject: [PATCH 2/6] toaster: use git reset --hard instead of rebase
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

Replaced 'git checkout <ref> && git rebase' with 'git reset --hard' as
with git checkout repository ends up with detached HEAD. Rebase makes
things even worse as it can cause conflicts. git reset --hard resets
repository to the required state in a most straightforward and
reliable way.

[YOCTO #7505]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 3d2f8b0..42be4af 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -266,7 +266,7 @@ class LocalhostBEController(BuildEnvironmentController):
             # branch magic name "HEAD" will inhibit checkout
             if commit != "HEAD":
                 logger.debug("localhostbecontroller: checking out commit %s to %s " % (commit, localdirname))
-                self._shellcmd("git fetch --all && git checkout \"%s\" && git rebase \"origin/%s\"" % (commit, commit) , localdirname)
+                self._shellcmd('git fetch --all && git reset --hard "origin/%s"' % commit, localdirname)
 
             # take the localdirname as poky dir if we can find the oe-init-build-env
             if self.pokydirname is None and os.path.exists(os.path.join(localdirname, "oe-init-build-env")):
-- 
1.9.1


