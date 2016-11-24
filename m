Return-Path: <michael.g.wood@intel.com>
Received: from mail-wj0-f180.google.com (mail-wj0-f180.google.com
	[209.85.210.180])
	by mail.openembedded.org (Postfix) with ESMTP id 4B8F271B60
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:26 +0000 (UTC)
Received: by mail-wj0-f180.google.com with SMTP id mp19so31054511wjc.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=XLmQ8dPTwq6yGAMBFCqecd+bSHwqG+JsLT8vckEzGXE=;
	b=FwnX40GCWw5cJdwj7r9V3TQoAK866QXTUox1mEDDdA6HmIyY4OHCQVdUTXQ1h4vTIS
	9fz5mLgjY7rjgwsmEHHteceW4TVPkr9R7HoXyBWNP37+vaemS4Fe/mlz+pHV3FDzI4Zu
	FJsYpnTCvb0iyqoUx0kVLomRD2KSuAe/sNrEEi37pIkoClvFK3HmVzao78Cp/QHMP+Eb
	3j+ab8hL4G1idedtDKfTwHS3xo7e97RAKQBwBzbhHpHn/NDI6loFzjpsaMNu6TfpkysD
	jLI3Bs254F+fmNncHq9lKZm93M6AdOiwEh9D92UMV/2WkJXpdL1PfUQ7zLvRCpqzQ9l2
	s07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=XLmQ8dPTwq6yGAMBFCqecd+bSHwqG+JsLT8vckEzGXE=;
	b=Z8f2PnqJwOJHRDkslcliZgmVi8kAP8nPNwqJMZUHHNuUhViRqRuSX2JFRQ53KWv/aq
	WpDTu248q4MQpee+dKPGzjnCDlEDpUYs2iLFdrhgQNVrpdraJC6D6c7if7TVg/J7XGi4
	2nGRbsllBfwwisNyKylFPwZcrTOJAfALrM6biDfd97447FD3AAbznfG9+HGPfS0c4vsv
	AIh1IBArNMoHNg/RGiEC1pCyBiXMa26CScF47dwB/bJWOXo/fJ9RVn+sFsFJ+2jTV6VH
	ZOFf1GXfh8KmiNGne1dfyYqxJ2Cq2r3UUSrnSik1+YABnsvmZAvMyI51HAOK/Z6hpaHp
	iPRw==
X-Gm-Message-State: AKaTC01k+yFGS8bjgVqKzbF9ztRD+OqyrML7sjgmFb3lw/oMlm/FwOXPhnL14sImLqCa1W1a
X-Received: by 10.194.124.100 with SMTP id mh4mr2000848wjb.154.1479986427792; 
	Thu, 24 Nov 2016 03:20:27 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:27 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:19:58 +0000
Message-Id: <1479986406-4657-8-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 07/15] toaster: localhostbecontroller accept custom init script for build
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:27 -0000

From: Sujith H <sujith.h@gmail.com>

When passed variable CUSTOM_BUILD_INIT_SCRIPT to toaster
setting, it would be nice to use it. Else toaster
can use oe-init script. This gives an oppurtunity to
use customized build init scritps.

Signed-off-by: Sujith H <sujith.h@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index e5f7c98..3896a82 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -27,7 +27,7 @@ import shutil
 from django.db import transaction
 from django.db.models import Q
 from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget, BRBitbake
-from orm.models import CustomImageRecipe, Layer, Layer_Version, ProjectLayer
+from orm.models import CustomImageRecipe, Layer, Layer_Version, ProjectLayer, ToasterSetting
 import subprocess
 
 from toastermain import settings
@@ -277,7 +277,12 @@ class LocalhostBEController(BuildEnvironmentController):
         builddir = '%s-toaster-%d' % (self.be.builddir, bitbake.req.project.id)
         oe_init = os.path.join(self.pokydirname, 'oe-init-build-env')
         # init build environment
-        self._shellcmd("bash -c 'source %s %s'" % (oe_init, builddir),
+        try:
+            custom_script = ToasterSetting.objects.get(name="CUSTOM_BUILD_INIT_SCRIPT").value
+            custom_script = custom_script.replace("%BUILDDIR%" ,builddir)
+            self._shellcmd("bash -c 'source %s'" % (custom_script))
+        except ToasterSetting.DoesNotExist:
+            self._shellcmd("bash -c 'source %s %s'" % (oe_init, builddir),
                        self.be.sourcedir)
 
         # update bblayers.conf
-- 
2.7.4


