Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id E42EB771BD
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:28 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id l6so73376042wml.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=1KthnYCL14HElQbE9GW8QHN9K5X1mOvIANjtLkLbvYI=;
	b=KIEJUHTLLzM2ssBXL8y9RyZVX+FDONTHMUndiU0u0bwG7pMg7ULBZDeJhxbxmR4X05
	u1kdfaL0EqK+epTittPhlILhLl4xTUMyWWpP6qs/m83PMQtPHjNO30v9/ZUiF3YOwmUm
	HcH32pBUHdBP0Jjr8IrCPD3a6OtLS4ze6YAOJUqJI/2q5VZilaD8Q6lw99n4+hjCR37B
	itZE/o8GrF47Ro849opV9zxFG12Ch5VeontMSr5+cyfVez5ptVkCMjXoGtn/7CkOtS+9
	8slajx5+779NTvuSPpnhMtT0U2VBOaSiUygDpNA2+MapGv59DBrhun8GIhAsCei95h/i
	HPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=1KthnYCL14HElQbE9GW8QHN9K5X1mOvIANjtLkLbvYI=;
	b=LZ/IqUzax47OBj98uJhf0iMxWnvUsAEFrocUTQ6vqP68qOcHNe4qPhZ53B/PD0UZU7
	hA1yUETFlqN2OQA3gHo/ZT/tRaS1NXS5/zX/SYZbbN1jUGlPthlr8RH2EDSnAZPloCxR
	8IB6bAC/q8TcxwfPLSihNdQ6sqPZzfpdiajj/DN8iHOHVj4CcfrUwnk81WFFyyOP9VqU
	4OTb6kD9KCq3lt62C0HXUU5p2JtTPV0vXn5pQHdXYf7bEBHl1rEr0J4T13ejJUHP0kE9
	Swqpe4EuturkBYd1mldx0ZQnhiKa/0uIZINcZPbIvvt218ny7DgWNM12k6MKrcpf6DdG
	dJJg==
X-Gm-Message-State: AD7BkJIOAA1HPKgtCc/cZpbSwqt3yMp4nQTs3mR0NpUfXWKyKx4701wTDrkXV7B/Cnkr22+t
X-Received: by 10.194.216.40 with SMTP id on8mr33231937wjc.40.1459961249147;
	Wed, 06 Apr 2016 09:47:29 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.28
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:28 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:33 +0100
Message-Id: <6218afe5672b5cec22dce0605965ce28cca11374.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 23/38] toaster: update BuildEnvironmentController and BitbakeController
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:30 -0000

From: Sujith H <sujith.h@gmail.com>

Remove getBBController function from BuildEnvironmentController.
The constructor of BitbakeController is updated appropriately so that
call can be made to connect to running server.
The call to startBBServer is removed from bbcontroller and  handledin
localhostbecontroller.

[YOCTO #6787]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py          | 26 ++++---------------------
 lib/toaster/bldcontrol/localhostbecontroller.py |  2 +-
 2 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 0f7b66d..d09ac17 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -37,11 +37,12 @@ class BitbakeController(object):
         It is outside the scope of this class on how the server is started and aquired
     """
 
-    def __init__(self, connection):
-        self.connection = connection
+    def __init__(self, be):
+        self.connection = bb.server.xmlrpc._create_server(be.bbaddress,
+                                                          int(be.bbport))[0]
 
     def _runCommand(self, command):
-        result, error = self.connection.connection.runCommand(command)
+        result, error = self.connection.runCommand(command)
         if error:
             raise Exception(error)
         return result
@@ -122,25 +123,6 @@ class BuildEnvironmentController(object):
         """
         raise NotImplementedError("FIXME: Must override setLayers")
 
-
-    def getBBController(self):
-        """ returns a BitbakeController to an already started server; this is the point where the server
-            starts if needed; or reconnects to the server if we can
-        """
-        if not self.connection:
-            self.be.lock = BuildEnvironment.LOCK_RUNNING
-            self.be.save()
-
-        server = bb.server.xmlrpc.BitBakeXMLRPCClient()
-        server.initServer()
-        server.saveConnectionDetails("%s:%s" % (self.be.bbaddress, self.be.bbport))
-        self.connection = server.establishConnection([])
-
-        self.be.bbtoken = self.connection.transport.connection_token
-        self.be.save()
-
-        return BitbakeController(self.connection)
-
     def getArtifact(self, path):
         """ This call returns an artifact identified by the 'path'. How 'path' is interpreted as
             up to the implementing BEC. The return MUST be a REST URL where a GET will actually return
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 73c5f1f..d23634f 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -32,7 +32,7 @@ import subprocess
 
 from toastermain import settings
 
-from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException
+from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, BitbakeController
 
 import logging
 logger = logging.getLogger("toaster")
-- 
2.1.4


