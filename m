Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 2B7FD60616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:55 +0000 (UTC)
Received: by pabfh17 with SMTP id fh17so48544799pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=OcqmiApQ4iKW/oTDFWpLVHOBaF3fhLDut4EZCu32znE=;
	b=HKBEsmHOin8iB9aJff7OXCn1UTrQAdboInqLvuAY6X4IiwT7UUZf5Tskhnk554YFwy
	VBhUn/SvaTnnk04apUFlyeZPoiKJQfi6OjHEIXzjJ5WJLZwI5AQGDre+ffhgagmLw5sN
	BEhQRAWwOQHH3o5Y7ga02QvTakJ5gDWaFOHeS9hueAuioATwJ/4DkIKwaXggEEJUwJFT
	RT28i6pWPqevxagaVrSxWHR/YaDodoIhkAL6VSxLzKYGQK4kozQx04PiQXs0BKh1Ro/J
	t9ggLD+e4M97mKCC5jFZG3vuWlvznyL+an0r0VYNNs7jIEF/RpjV2fRsjTPqxfqBtGBB
	gn2g==
X-Received: by 10.98.16.200 with SMTP id 69mr6528136pfq.98.1449079196862;
	Wed, 02 Dec 2015 09:59:56 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:55 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:54 -0800
Message-Id: <1a5e587b7c69c9b0dc74412c3c4db33acc256ea2.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 22/30] toaster: set varibales on bitbake server
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:56 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Set project variables using connection to bitbake server
instead of writing them to toaster configuration files.

This is a way to avoid rewriting configuration files before
and after every build, triggered by toaster UI.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 19afb1a..efba73e 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -291,12 +291,19 @@ class LocalhostBEController(BuildEnvironmentController):
     def triggerBuild(self, bitbake, layers, variables, targets):
         # set up the buid environment with the needed layers
         self.setLayers(bitbake, layers, targets)
-        self.writeConfFile("conf/toaster-pre.conf", variables)
-        self.writeConfFile("conf/toaster.conf", raw = "INHERIT+=\"toaster buildhistory\"")
 
         # get the bb server running with the build req id and build env id
         bbctrl = self.getBBController()
 
+        # set variables
+        for var in variables:
+            bbctrl.setVariable(var.name, var.value)
+
+        # Add 'toaster' and 'buildhistory' to INHERIT variable
+        inherit = {item.strip() for item in bbctrl.getVariable('INHERIT').split()}
+        inherit = inherit.union(["toaster", "buildhistory"])
+        bbctrl.setVariable('INHERIT', ' '.join(inherit))
+
         # trigger the build command
         task = reduce(lambda x, y: x if len(y)== 0 else y, map(lambda y: y.task, targets))
         if len(task) == 0:
-- 
1.9.1


