Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 80EE477153
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:23 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id v188so29618060wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=ZYDyoWeB7IbGsht7sriVZ1yNJ4bzWYtBuWADM98zC3A=;
	b=APBxV4mt3HNBELQmUzCF8uDDKSrhI9E8/XJtioxFeIX2soJIteniaApB53Dbo5QGNN
	S/jdTPtADGhrGwfvsCXQVLe/wXjhkrkXr5oVkbpUXWSTvB9qZwOh9sy1dOjQNfM3mmx8
	MrSkGEGL33GpHDRR2+ZSTJSxFruJZwNzSeQfgJzyKWVp/EHB2C2YDUBshuX1zv7im4P7
	CH4Yfa0V/4HckVascWcn9oNiP93xWBIdpOYfWKih9vyT7vowAywQMbcLOoYJ3BKp6V8Y
	qoNDyMZFXy6w82W3nhDQyooKWWSlbRMZcAiFMy96suzxx/dCv66tF6zZSTTf7gxY4o1B
	q/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ZYDyoWeB7IbGsht7sriVZ1yNJ4bzWYtBuWADM98zC3A=;
	b=hHqvRgv/fQyfbMSCQEAbkpfzehn0csLH05jjgZsmLOnbRLn9wn2skDx7SWzjKQevwG
	7QteNoFqVxNqF1InkPhjlckbkb2dH0e1VvOh4/U+rS08eUThXPUPt/4fZICueZJFGQif
	FJt6Sib/OqAi7fsfCnyxPqtuI41CWnaYkQPnuoWJfg9jadRNFY90R/c4nLFepg2B2PYG
	eAPRw6bHtTrtdRkZpnXuYLnA3YEjIP3eWPPtem6yFJYCUiV4oGcr9I3+d7+MmQEsobQz
	8UNqis117lhwlXW8k5c7ENi1NrtMneO3JK7NHvSfPKxHVITAvsAjnj5NfI8J0IvWA3oI
	tueg==
X-Gm-Message-State: AD7BkJJyou3E4gmiUAILvZRyRUfuwyWhvDdl+NzuKWasZXv5ISwsOKlSUH3SiIBz+q9LcNzD
X-Received: by 10.28.61.8 with SMTP id k8mr25586356wma.7.1459961244070;
	Wed, 06 Apr 2016 09:47:24 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.23
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:23 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:27 +0100
Message-Id: <be871202a00a9c13b1f46e2a38a3e4e1fb5883ae.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 17/38] toaster: use bash explicitly
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:24 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Toaster can't run builds on Ubuntu as default /bin/sh points
to dash there. The reason is that oe-init-build-env can't
be sourced under dash for various reasons. It can be fixed
or work arounded, but it wouldn't fix builds for older releases.
Explicitly using bash to start builds should fix the issue.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 6d7f433..73c5f1f 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -258,7 +258,8 @@ class LocalhostBEController(BuildEnvironmentController):
         builddir = '%s-toaster-%d' % (self.be.builddir, bitbake.req.project.id)
         oe_init = os.path.join(self.pokydirname, 'oe-init-build-env')
         # init build environment
-        self._shellcmd('source %s %s' % (oe_init, builddir), self.be.sourcedir)
+        self._shellcmd("bash -c 'source %s %s'" % (oe_init, builddir),
+                       self.be.sourcedir)
 
         # update bblayers.conf
         bblconfpath = os.path.join(builddir, "conf/bblayers.conf")
@@ -286,9 +287,9 @@ class LocalhostBEController(BuildEnvironmentController):
 
         # run bitbake server from the clone
         bitbake = os.path.join(self.pokydirname, 'bitbake', 'bin', 'bitbake')
-        self._shellcmd('source %s %s; BITBAKE_UI="" %s --read %s '
-                       '--server-only -t xmlrpc -B 0.0.0.0:0' % (oe_init, builddir,
-                       bitbake, confpath), self.be.sourcedir)
+        self._shellcmd('bash -c \"source %s %s; BITBAKE_UI="" %s --read %s '
+                       '--server-only -t xmlrpc -B 0.0.0.0:0\"' % (oe_init,
+                       builddir, bitbake, confpath), self.be.sourcedir)
 
         # read port number from bitbake.lock
         self.be.bbport = ""
@@ -319,9 +320,9 @@ class LocalhostBEController(BuildEnvironmentController):
 
         # run build with local bitbake. stop the server after the build.
         log = os.path.join(builddir, 'toaster_ui.log')
-        self._shellcmd(['(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:-1" '
+        self._shellcmd(['bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:-1" '
                         '../bitbake/bin/bitbake %s -u toasterui >>%s 2>&1;'
-                        'BITBAKE_UI="" BBSERVER=0.0.0.0:-1 %s -m)&' \
+                        'BITBAKE_UI="" BBSERVER=0.0.0.0:-1 %s -m)&\"' \
                         % (brbe, bbtargets, log, bitbake)], builddir,
                         nowait=True)
 
-- 
2.1.4


