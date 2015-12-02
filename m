Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 9EAFB60616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:54 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so47011343pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=jvALBnL5tje4FgOUIiui1mNr4c4R6P4bskSpyvm7a40=;
	b=arcggh7KrELd2pE+rLJvvImWwCs635Vy1meIKz5z4DMvprjsLPXWf2C93/3e0/zVO1
	VGG9wbBFFm7HqDkl/kZN4h8FgIGQ49xeWuaqSlF3uzPDZbGC8HsktNOfuxi+WsfFxMXv
	u//IG5QQwiOnx1WPV7PrnNqs+ZpbkkNqGKTSnGLvavcPX41EIXaskaxhELwYvBMrghcB
	4lAavqxMueQ+aQrdXDU6zvnzf8AK5/vhIa5YB6n29r8307AZUBeLwcJHRJ3heD9+eP6m
	NZSCzpy+A7nmNIhBkeFQ2FKlmeLaXgyQkuBSqxf1mMunq76EtljrU86OXPtoD600A2KJ
	CgtQ==
X-Received: by 10.98.2.213 with SMTP id 204mr6545493pfc.9.1449079195716;
	Wed, 02 Dec 2015 09:59:55 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:54 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:53 -0800
Message-Id: <9a1e35d12668292269a3d8ab2120b73a3bb175ac.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 21/30] toaster: implement BitbakeController.getVariable
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:54 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added new API to get value of bitbake variable from bitbake server.
The API will be used to update INHERIT variable instead of writing
it to the toaster configuration files.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/bbcontroller.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 3d98ad7..ba00931 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -52,6 +52,9 @@ class BitbakeController(object):
     def setVariable(self, name, value):
         return self._runCommand(["setVariable", name, value])
 
+    def getVariable(self, name):
+        return self._runCommand(["getVariable", name])
+
     def build(self, targets, task = None):
         if task is None:
             task = "build"
-- 
1.9.1


