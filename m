Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 9A8E076312
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 14:24:47 +0000 (UTC)
Received: by wibxm9 with SMTP id xm9so163381034wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 07:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=i/mIAUENTH2HfI81Qhj9RsWnLtBPCcWwrvm4QvBq/AY=;
	b=GhBh/dbQR1hEJ/gD4nls45A2/LB8q6cqgNDCnPq257HK7ngI31CUB5dv1+b2pzSh7h
	Mf2v0nTsoNWflSPVHXuG9tHuWvwAQgrTs7npR0eOO6CNctv9bSoZ/KZGQxemiqOXkZU7
	Rqfxk1JmgMrYomXn65jhBW0ZEoXgno156YxT5sC5zrmr/R2IU1k02aE/WDnoSfBGI0en
	65vHuLZtHHEFUJGQzAPRKM0Yy3RGxmuKVMi1Ta3ULq+c1KfOmhpT+0qtpByEZ7iUlDTA
	/PhLuRF3+oNC/BI5PgzUkjFLFICsXXhbQ4bzYq/ePJyuWPyt3SNShwdrphI4mwlAsUsC
	kOiw==
X-Gm-Message-State: ALoCoQmfJSckA2q7GzlabhUVreE1cS+kEwxInilamfEJtxC0syRfQcvfMhyDkknE0IEptzA9pwz3
X-Received: by 10.180.72.35 with SMTP id a3mr33143841wiv.21.1438093486233;
	Tue, 28 Jul 2015 07:24:46 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	kb1sm11455573wjc.24.2015.07.28.07.24.44
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 Jul 2015 07:24:45 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 64E4B561E12; Tue, 28 Jul 2015 15:24:46 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Jul 2015 15:24:43 +0100
Message-Id: <d8c41c2db0b1bf4832c623072d626d647bcb40cc.1438093379.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <964caf5c2f9ce47f17d85d9bcfa2321f8e9ab6fb.1438093379.git.alexandru.damian@intel.com>
References: <964caf5c2f9ce47f17d85d9bcfa2321f8e9ab6fb.1438093379.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1438093379.git.alexandru.damian@intel.com>
References: <cover.1438093379.git.alexandru.damian@intel.com>
Subject: [PATCH 4/6] bitbake: toaster: get rid of _createdirpath function
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
X-List-Received-Date: Tue, 28 Jul 2015 14:24:48 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Replaced call of recursive _createdirpath method with simpler
call of os.makedirs.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 3e16837..c0774a3 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -69,21 +69,16 @@ class LocalhostBEController(BuildEnvironmentController):
             #logger.debug("localhostbecontroller: shellcmd success")
             return out
 
-    def _createdirpath(self, path):
-        from os.path import dirname as DN
-        if path == "":
-            raise Exception("Invalid path creation specified.")
-        if not os.path.exists(DN(path)):
-            self._createdirpath(DN(path))
-        if not os.path.exists(path):
-            os.mkdir(path, 0755)
-
     def _setupBE(self):
         assert self.pokydirname and os.path.exists(self.pokydirname)
-        self._createdirpath(self.be.builddir)
-        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.pokydirname, self.be.builddir))
+        path = self.be.builddir
+        if not path:
+            raise Exception("Invalid path creation specified.")
+        if not os.path.exists(path):
+            os.makedirs(path, 0755)
+        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.pokydirname, path))
         # delete the templateconf.cfg; it may come from an unsupported layer configuration
-        os.remove(os.path.join(self.be.builddir, "conf/templateconf.cfg"))
+        os.remove(os.path.join(path, "conf/templateconf.cfg"))
 
 
     def writeConfFile(self, file_name, variable_list = None, raw = None):
-- 
1.9.1


