Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 4B655770B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:19 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id l6so73370638wml.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=cYg4jJxxgaKRkVlL8YWSOE5fP/QiQVwUOEiXWtAZ1j0=;
	b=I9lbzLXZiYLaxWhy24rri6zrB6N+pHByIY4PoFnuDg4W7X45JQyM3JBDgDaPr+u52k
	Eu9JMnLAS1rGPO09MjAKCIy/aAxcUTxYkk2H0v3i9s4k8zJWPHiofkGOQr3XKoPgSPYP
	fpjA0dZUNL9zndE5vYcEy3K9I5VSL5BnBE/REiyh0StTg6nX7+lKQ/0WJQ45Cg229g2w
	1ftshrARY0zQaTtxWRws/kbiI3jroNxJg3ODcJlgPISLaYq1z4uVieZtpVJilAiaDmto
	9v2beR8D5KfQTymghHbIgI2tA5IUzBhLbcSfUTo0LKymAV+GLLP6XXltlV5BQTf7JXZc
	dbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=cYg4jJxxgaKRkVlL8YWSOE5fP/QiQVwUOEiXWtAZ1j0=;
	b=P3xhIV/KZ3FdoaLbTKUrcdUP/YczbZiNRZ53iGNwCkMJhxyeju7WjG78q6IqrDrt5c
	qMnZ+H7TMasb5BFZtF9o2NShmiAQ6JzYLzLViQWk/KCA+2+bPJdNy3zZmJdLyV323hId
	BujUz3h3/L9R8lcW2ei8/dXz7irRqeobmGJtD7dHnmwuUi3SbQv/VPVHNs+qbp49yCzv
	Pj5b0xwQDI16GLgcl1f+MpMTQsPzldxTWOWy/i37II8xKSMh1xf0W/bPtnEV0DEJIcB1
	CfkBZCovS1Y8FvqsxPpfoJPwxOuatDF54EvGWlMIf+d96xNrSluTrp81m9wKtnnx4rWS
	Z3wQ==
X-Gm-Message-State: AD7BkJKkRMDyhTP+GQywJk/gfDkNZKYWsmrG4cyrACOf+tBa2TvFNNzoYjA9RvGOFF7YeG9X
X-Received: by 10.194.246.137 with SMTP id xw9mr663153wjc.172.1459961239860;
	Wed, 06 Apr 2016 09:47:19 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.18
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:19 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:22 +0100
Message-Id: <3cdce635f9d8d10aaa1ed5ac82f75a09868210d7.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 12/38] toaster: reimplement triggerBuild
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:19 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Reimplemented triggerBuild method to support one build directory
per project:
 - start bitbake server from the cloned repository
 - don't run observer
 - run bitbake build directly instead of triggering it
   through xmlrpc

[YOCTO #7880]
[YOCTO #9058]
[YOCTO #8958]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 102 ++++++++++++++++--------
 1 file changed, 67 insertions(+), 35 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 0a2e41d..2e3aa37 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -250,44 +250,76 @@ class LocalhostBEController(BuildEnvironmentController):
 
 
     def triggerBuild(self, bitbake, layers, variables, targets, brbe):
-        # set up the build environment with the needed layers
-        self.setLayers(bitbake, layers, targets)
+        layers = self.setLayers(bitbake, layers, targets)
+
+        # init build environment from the clone
+        builddir = '%s-toaster-%d' % (self.be.builddir, bitbake.req.project.id)
+        oe_init = os.path.join(self.pokydirname, 'oe-init-build-env')
+        # init build environment
+        self._shellcmd('source %s %s' % (oe_init, builddir), self.be.sourcedir)
+
+        # update bblayers.conf
+        bblconfpath = os.path.join(builddir, "conf/bblayers.conf")
+        conflines = open(bblconfpath, "r").readlines()
+        skip = False
+        with open(bblconfpath, 'w') as bblayers:
+            for line in conflines:
+                if line.startswith("# line added by toaster"):
+                    skip = True
+                    continue
+                if skip:
+                    skip = False
+                else:
+                    bblayers.write(line)
+
+            bblayers.write('# line added by toaster build control\n'
+                           'BBLAYERS = "%s"' % ' '.join(layers))
 
         # write configuration file
-        filepath = os.path.join(self.be.builddir, "conf/toaster.conf")
-        with open(filepath, 'w') as conf:
+        confpath = os.path.join(builddir, 'conf/toaster.conf')
+        with open(confpath, 'w') as conf:
             for var in variables:
                 conf.write('%s="%s"\n' % (var.name, var.value))
             conf.write('INHERIT+="toaster buildhistory"')
 
-        # get the bb server running with the build req id and build env id
-        bbctrl = self.getBBController()
-
-        # set variables; TOASTER_BRBE is not set on the server, as this
-        # causes events from command-line builds to be attached to the last
-        # Toaster-triggered build; instead, TOASTER_BRBE is fired as an event so
-        # that toasterui can set it on the buildinfohelper;
-        # see https://bugzilla.yoctoproject.org/show_bug.cgi?id=9021
-        for var in variables:
-            if var.name == 'TOASTER_BRBE':
-                bbctrl.triggerEvent('bb.event.MetadataEvent("SetBRBE", "%s")' \
-                                     % var.value)
-            else:
-                bbctrl.setVariable(var.name, var.value)
-
-        # Add 'toaster' and 'buildhistory' to INHERIT variable
-        inherit = {item.strip() for item in bbctrl.getVariable('INHERIT').split()}
-        inherit = inherit.union(["toaster", "buildhistory"])
-        bbctrl.setVariable('INHERIT', ' '.join(inherit))
-
-        # trigger the build command
-        task = reduce(lambda x, y: x if len(y)== 0 else y, map(lambda y: y.task, targets))
-        if len(task) == 0:
-            task = None
-
-        bbctrl.build(list(map(lambda x:x.target, targets)), task)
-
-        logger.debug("localhostbecontroller: Build launched, exiting. Follow build logs at %s/toaster_ui.log" % self.be.builddir)
-
-        # disconnect from the server
-        bbctrl.disconnect()
+        # run bitbake server from the clone
+        bitbake = os.path.join(self.pokydirname, 'bitbake', 'bin', 'bitbake')
+        self._shellcmd('source %s %s; BITBAKE_UI="" %s --read %s '
+                       '--server-only -t xmlrpc -B 0.0.0.0:0' % (oe_init, builddir,
+                       bitbake, confpath), self.be.sourcedir)
+
+        # read port number from bitbake.lock
+        self.be.bbport = ""
+        bblock = os.path.join(builddir, 'bitbake.lock')
+        with open(bblock) as fplock:
+            for line in fplock:
+                if ":" in line:
+                    self.be.bbport = line.split(":")[-1].strip()
+                    logger.debug("localhostbecontroller: bitbake port %s", self.be.bbport)
+                    break
+
+        if not self.be.bbport:
+            raise BuildSetupException("localhostbecontroller: can't read bitbake port from %s" % bblock)
+
+        self.be.bbaddress = "localhost"
+        self.be.bbstate = BuildEnvironment.SERVER_STARTED
+        self.be.lock = BuildEnvironment.LOCK_RUNNING
+        self.be.save()
+
+        bbtargets = ''
+        for target in targets:
+            task = target.task
+            if task:
+                if not task.startswith('do_'):
+                    task = 'do_' + task
+                task = ':%s' % task
+            bbtargets += '%s%s ' % (target.target, task)
+
+        # run build with local bitbake
+        log = os.path.join(builddir, 'toaster_ui.log')
+        self._shellcmd('TOASTER_BRBE="%s" BBSERVER="0.0.0.0:-1" '
+                       '../bitbake/bin/bitbake %s -u toasterui '
+                       '>>%s 2>&1 &' % (brbe, bbtargets, log), builddir)
+
+        logger.debug('localhostbecontroller: Build launched, exiting. '
+                     'Follow build logs at %s' % log)
-- 
2.1.4


