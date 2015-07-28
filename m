Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id A4F80763FA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 14:24:50 +0000 (UTC)
Received: by wicmv11 with SMTP id mv11so181882258wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 07:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=FRxI+4Xs3zTcncneYrRlk9WZm1qbJ5lI/Q6aW3BXQCA=;
	b=HcFrmAZHiceJjrQ6gHQ7IbQxj7QbVN3Q/gOf+Bb2bHRxljgLPHMlMaHb0TynQlHO5J
	LeFgiL7fS6oWp+RKVwWHtYsfzH121G8brs3CD+jDNXnD/xsHA3AKGygTZeJTSaLWrvKN
	b1D8eaZJHNmMV6E1T17O/wGIukCvSI3M/WrBqRh1Xv/csi+Zkcbc5OegE56oQLzxTkpw
	cbV/z7WybjLJWGEJCi+vZnceJdAfSP8GTgu3+ffLA0uE7qHltqgiIklJHHRFnvgoTJ1/
	LUba7jpZqF8vXQ6rik1jl/+i9UCWO1YfHbWgKOjvUXA51ljJMRj8UdOed5y8fCfJWmgu
	acRw==
X-Gm-Message-State: ALoCoQnOIdSkEc9bycTn6zVWRdQNu3YjadXlhKLVnfSXtZ2zXCnBByl/I/ssgHBt6uJfqPEECXLt
X-Received: by 10.194.108.5 with SMTP id hg5mr70341053wjb.25.1438093490266;
	Tue, 28 Jul 2015 07:24:50 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	w8sm33543802wja.15.2015.07.28.07.24.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 Jul 2015 07:24:49 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 67422561E1D; Tue, 28 Jul 2015 15:24:46 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Jul 2015 15:24:44 +0100
Message-Id: <be9dfa3a8a161141b4af0d4a9d02a39313f8030a.1438093379.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <964caf5c2f9ce47f17d85d9bcfa2321f8e9ab6fb.1438093379.git.alexandru.damian@intel.com>
References: <964caf5c2f9ce47f17d85d9bcfa2321f8e9ab6fb.1438093379.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1438093379.git.alexandru.damian@intel.com>
References: <cover.1438093379.git.alexandru.damian@intel.com>
Subject: [PATCH 5/6] bitbake: toaster: Uncomment logging messages
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
X-List-Received-Date: Tue, 28 Jul 2015 14:24:52 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Uncommented debug and warning messages in _shellcmd method of
LocalhostBEController as they seem to be useful for debugging.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index c0774a3..231a7d3 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -54,7 +54,7 @@ class LocalhostBEController(BuildEnvironmentController):
         if cwd is None:
             cwd = self.be.sourcedir
 
-        #logger.debug("lbc_shellcmmd: (%s) %s" % (cwd, command))
+        logger.debug("lbc_shellcmmd: (%s) %s" % (cwd, command))
         p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
         (out,err) = p.communicate()
         p.wait()
@@ -63,10 +63,10 @@ class LocalhostBEController(BuildEnvironmentController):
                 err = "command: %s \n%s" % (command, out)
             else:
                 err = "command: %s \n%s" % (command, err)
-            #logger.warn("localhostbecontroller: shellcmd error %s" % err)
+            logger.warn("localhostbecontroller: shellcmd error %s" % err)
             raise ShellCmdException(err)
         else:
-            #logger.debug("localhostbecontroller: shellcmd success")
+            logger.debug("localhostbecontroller: shellcmd success")
             return out
 
     def _setupBE(self):
-- 
1.9.1


