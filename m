Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id EB166770B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:17 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id 191so64803560wmq.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=lnVRPqpksZNcmnmo32F1VjoNtH5uYbFurCYqyi1bPbs=;
	b=ywpFA8zsHKKOMUN0kwQ32tKmFwrOKLSzDxGMDqZnKut8jV5qu40z+51oyrFBExlKDN
	qv5BjBkm8Sm6Hr+jv2jdAjsowLUNEvbFS0/YLM1gnz2ejl4ozamzt2wcNoledTtoIqpO
	5sevJ8VGWcYUJAuHEVxxOrD4wCH+FYeEQdeL6+xJo0YVGZQQ7a5p8uJFSTEoV1lbAstB
	OL8Eqmdxlqz9rUlPrxbbWzGAyLr14E+shmhPJapxdwKMoMaYmwl//4PyGWYJ4JOQhjQX
	mg7jak2fkDuYsqqe3TbCOsJ/JhJco1zoZCrXRbLslm8JeTQZJvtALCqQ6W4W7puETfWS
	dfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=lnVRPqpksZNcmnmo32F1VjoNtH5uYbFurCYqyi1bPbs=;
	b=m8pyDaWiJuHxsftXVmQ4rmNYATYD7J95Tb8SaTc+D8pNXeS5tdaHtNWSbb3XLFpUYq
	C1/oTOzCm808damH+oZ/Y2PWcQvZzAwzfxLct6fsjgxwpMTJstUeEZLyuaEHIR9L2IRD
	zh+ZxsI+vKSjicDlpNuWl0IEPTQpRw0UTUhWBtKZdWYtqX8MGBS6jeZeaBEqIInyvsCL
	H/u/0OR+XgvVTLqpagaFvXz022olkJAtfw+AGq4hXOkFr9In4p7ZnKIyHhtTETQ6wEg8
	o6fbgn3Pu2ihmdnBo3eWXB1OD65zP0hiaH+4UkadcQv4Xs8lqaU/zU7f599WqhzeJ0NM
	PGZw==
X-Gm-Message-State: AD7BkJJ/UjZ8mgtVFmFfPyUdD2/u+DjQc4cNkrc7s1AUFiENMbsk+9uQspL2m2cLKcnUSsep
X-Received: by 10.194.2.210 with SMTP id 18mr11511250wjw.55.1459961237832;
	Wed, 06 Apr 2016 09:47:17 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.16
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:17 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:20 +0100
Message-Id: <11ed2d4f03f316c5b8bb8118d3201d680a579174.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 10/38] toaster: add brbe parameter to triggerBuild
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

Called triggerBuild with brbe parameter instead of adding TOASTER_BRBE
variable to the database and fetching it in triggerBuild.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py         | 2 +-
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 1ccdd24..e588924 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -256,7 +256,7 @@ class LocalhostBEController(BuildEnvironmentController):
         return open(os.path.join(self.be.builddir, "toaster_server.log"), "r").read()
 
 
-    def triggerBuild(self, bitbake, layers, variables, targets):
+    def triggerBuild(self, bitbake, layers, variables, targets, brbe):
         # set up the build environment with the needed layers
         self.setLayers(bitbake, layers, targets)
 
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 0bd5d08..8ba836e 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -49,15 +49,13 @@ class Command(NoArgsCommand):
 
             logger.debug("runbuilds: starting build %s, environment %s" % (str(br).decode('utf-8'), bec.be))
 
-            # write the build identification variable
-            BRVariable.objects.create(req = br, name="TOASTER_BRBE", value="%d:%d" % (br.pk, bec.be.pk))
-
             # let the build request know where it is being executed
             br.environment = bec.be
             br.save()
 
             # this triggers an async build
-            bec.triggerBuild(br.brbitbake, br.brlayer_set.all(), br.brvariable_set.all(), br.brtarget_set.all())
+            bec.triggerBuild(br.brbitbake, br.brlayer_set.all(), br.brvariable_set.all(),
+                             br.brtarget_set.all(), "%d:%d" % (br.pk, bec.be.pk))
 
         except Exception as e:
             logger.error("runbuilds: Error launching build %s" % e)
-- 
2.1.4


