Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
	[209.85.192.182])
	by mail.openembedded.org (Postfix) with ESMTP id 1F0426FFAB
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:57 +0000 (UTC)
Received: by pfu207 with SMTP id 207so1135374pfu.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=jzWSe/l+DmxAzOXmLSNpFj7zb2iG9KU5Yk3h6dUE+Ek=;
	b=LaGNJhnMD8YokRlCH/uAE6uiWcEcjgpGRWkKD+Op1G2+pRHf0bhzpJ0bdpvao1Ttar
	UNK9m8vbm6ur/4oj9cipK9ZAoTVdwnfgFYrsfL6XMQjyP+1t4SYh2HAUrlKMEvb9lRnA
	F8XHhN1JHjw/bPChKpm4t81wIEaccUP3PqJHqAho93VMdz6j7zY1ADwNP7LJq7J7+spy
	4tZ4BdhkaOyKwdRa4/uMs0jX51QDKT/W7zgpwJH1Y+iffYIJETfpwDCFCI36pJCPFKJ6
	+zJAbeY0WIsB4X5oLKufkdCTPAqU4s8fhhauxzheZ0KcfVhdojDX/IASkpP3bvW5Htxn
	OnXA==
X-Received: by 10.98.65.2 with SMTP id o2mr6481315pfa.99.1449079198556;
	Wed, 02 Dec 2015 09:59:58 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:57 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:55 -0800
Message-Id: <bf45f61e6343382ce2c5b10cf4a50c2d20e6f141.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 23/30] toaster: remove writeConfFile API
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:59 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This API is not used anymore as toaster doesn't write variables
to configuration files anymore. It sets variables through its
connection to bitbake server.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/bbcontroller.py          |  6 ------
 lib/toaster/bldcontrol/localhostbecontroller.py | 11 -----------
 2 files changed, 17 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index ba00931..8b99318 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -130,12 +130,6 @@ class BuildEnvironmentController(object):
         bblayerconffile.write("# line added by toaster build control\nBBLAYERS = \"" + " ".join(layerlist) + "\"")
         bblayerconffile.close()
 
-
-    def writeConfFile(self, variable_list = None, raw = None):
-        """ Writes a configuration file in the build directory. Override with buildenv-specific implementation. """
-        raise Exception("FIXME: Must override to actually write a configuration file")
-
-
     def startBBServer(self):
         """ Starts a  BB server with Toaster toasterui set up to record the builds, an no controlling UI.
             After this method executes, self.be bbaddress/bbport MUST point to a running and free server,
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index efba73e..92d9ac5 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -70,17 +70,6 @@ class LocalhostBEController(BuildEnvironmentController):
             logger.debug("localhostbecontroller: shellcmd success")
             return out
 
-
-    def writeConfFile(self, file_name, variable_list = None, raw = None):
-        filepath = os.path.join(self.be.builddir, file_name)
-        with open(filepath, "w") as conffile:
-            if variable_list is not None:
-                for i in variable_list:
-                    conffile.write("%s=\"%s\"\n" % (i.name, i.value))
-            if raw is not None:
-                conffile.write(raw)
-
-
     def startBBServer(self):
         assert self.pokydirname and os.path.exists(self.pokydirname)
         assert self.islayerset
-- 
1.9.1


