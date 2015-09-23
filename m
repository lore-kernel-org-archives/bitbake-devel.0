Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 57B0676AC5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 22:33:31 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so53259913pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=B2xHTs00nxT5PJ6ICSwzAfZbQZaOfGo+dYfPBPlXPc0=;
	b=NiJ7JkEoMyPMneOVQBAh9QpSbMxD0MqGwsdjeJJBmtv60wvc70oMSMa3d8ONtRoC/v
	n2xAPks+Q/+a+Zlb2Sq00bIhSlKedTWB6Tnkh8AhvPbglEXDnp6WhDelUpaQKZ5qFu5r
	/tdHDy63Z1riVRCupvhYvj7oRFHPEjWZ4Q5dnYfX2/Ssgh8IfdYh8xAiiaq00l+/ZYtV
	rjthZddXFRuQm4hEAkfWKkiiy7knF8lRY5yR+vGJPiqkEweFSnXpM+Jb4p6E5vq5fgV0
	eO/o+e6am5kLPSVC9x8Isy0JLbdd/TT85YO6gCbGMGwbfdNH+9vrHYzh97RW/QrFjcoU
	Gmcg==
X-Received: by 10.66.221.170 with SMTP id qf10mr39204174pac.134.1443047611936; 
	Wed, 23 Sep 2015 15:33:31 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	qg2sm9796764pbb.80.2015.09.23.15.33.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 23 Sep 2015 15:33:31 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Sep 2015 15:34:55 -0700
Message-Id: <b4d1c8357a64c0086bcbe91d572d3c7893711323.1443047547.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <de438abaff89a94027ae465a62dd4c0ce79ee208.1443047547.git.avery.brian@gmail.com>
References: <de438abaff89a94027ae465a62dd4c0ce79ee208.1443047547.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443047547.git.avery.brian@gmail.com>
References: <cover.1443047547.git.avery.brian@gmail.com>
Subject: [PATCH 3/6] toaster: fix bug in resetting git repository
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
X-List-Received-Date: Wed, 23 Sep 2015 22:33:32 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

git reset --hard should be given either commit id or
origin/<ref name> to work properly. Without this fix git will
complain that origin/<commit id> does not exist.

[YOCTO #7505]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 42be4af..0c34957 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -266,7 +266,8 @@ class LocalhostBEController(BuildEnvironmentController):
             # branch magic name "HEAD" will inhibit checkout
             if commit != "HEAD":
                 logger.debug("localhostbecontroller: checking out commit %s to %s " % (commit, localdirname))
-                self._shellcmd('git fetch --all && git reset --hard "origin/%s"' % commit, localdirname)
+                ref = commit if re.match('^[a-fA-F0-9]+$', commit) else 'origin/%s' % commit
+                self._shellcmd('git fetch --all && git reset --hard "%s"' % ref, localdirname)
 
             # take the localdirname as poky dir if we can find the oe-init-build-env
             if self.pokydirname is None and os.path.exists(os.path.join(localdirname, "oe-init-build-env")):
-- 
1.9.1


