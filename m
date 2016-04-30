Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id DC039770D8
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:41:07 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id r187so17981288pfr.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=msqtRLM6kr2qoSgMKYmJrcoxVXqvexzRf2gt45MHiNE=;
	b=h9/oIXt6+AvDk4gaI2f2X3rJ//k9EIHwMsIR9qpWLJhHMjm4ffqb5BXrBWxh8SIXqm
	2I5pSMZZRnYG2N4edRPvLLLbxW0PleFhjAAEpRByJ2M3KIqxSuJLodE88JyjJAWygYIM
	SY48V2/SrXJ9kUEp80H/KJVDivjzo3vUsrtcWwKFcyVradCGHhGv1BiAk6L0elIskGv9
	P0tnxwCtNiFxeA5cozSh3dZZ2OR+qS4ExsEoCBg1WKDEuE6Xx+H+wcSPQ7fgm4lnvIIU
	y6yhKJ3dxH1zzLuLgD1WHpHSV7ubVSlJH2hhHK6yNooSopOJMdtiO1QUVFIMMiwdAu2S
	1s6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=msqtRLM6kr2qoSgMKYmJrcoxVXqvexzRf2gt45MHiNE=;
	b=dOilfkeDev3GChJtpPtTyi8WkZIkVptUhEucTvvdgO8dqqLr5lKaBv5Z86VSNHDcZ1
	Yod71NazAHwjtNdSOoKWgaxunW6Pn0WiQ215aczKzdMe0HeYJw0vkMhmGvOFBiOTbGO7
	csC9I1+qEJ3PLWDNdb06CPirS9XA4s8f2coGfYpPo52SrMMThprLM2c9MSCAgLhjDwAW
	O1bkk9hVBoCwJsc8q5cCK37vHPp5RPfvnWwyyv3YzGEN0DU9Qwnmbu6ROYGxub3H4hnz
	v2A0DBfGlsxWLh2kLskYlxshR+1fAfQmMFHyOwigdu9kbF/PtNQTY3qx4GSZt12QVOHT
	nJfg==
X-Gm-Message-State: AOPr4FWeRGE/IWot3NcAfGZ8xm071UY0MegYtLN4khqBtO2F4OdwhEa0/9f8KGITZMOXOg==
X-Received: by 10.98.25.15 with SMTP id 15mr39172662pfz.60.1462045268204;
	Sat, 30 Apr 2016 12:41:08 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	d78sm33226530pfb.59.2016.04.30.12.41.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:41:06 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:40:58 -0700
Message-Id: <c763bea8d9e94057fa180f4d127ae2c8ffe6857b.1462041562.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
References: <4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
In-Reply-To: <cover.1462041562.git.chris_larson@mentor.com>
References: <cover.1462041562.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [RFC master][PATCH 2/4] bb.utils: use imp.get_suffixes for load_plugins
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
X-List-Received-Date: Sat, 30 Apr 2016 19:41:08 -0000

From: Christopher Larson <chris_larson@mentor.com>

Rather than hardcoding .py, use python's knowledge of its file extensions.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/utils.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 92f1b60..c54ff5b 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -28,6 +28,7 @@ import bb.msg
 import multiprocessing
 import fcntl
 import imp
+import itertools
 import subprocess
 import glob
 import fnmatch
@@ -41,6 +42,8 @@ from ctypes import cdll
 
 
 logger = logging.getLogger("BitBake.Util")
+python_extensions = [e for e, _, _ in imp.get_suffixes()]
+
 
 def clean_context():
     return {
@@ -1465,8 +1468,12 @@ def load_plugins(logger, plugins, pluginpath):
                 fp.close()
 
     logger.debug('Loading plugins from %s...' % pluginpath)
-    for fn in glob.glob(os.path.join(pluginpath, '*.py')):
-        name = os.path.splitext(os.path.basename(fn))[0]
+
+    expanded = (glob.glob(os.path.join(pluginpath, '*' + ext))
+                for ext in python_extensions)
+    files = itertools.chain.from_iterable(expanded)
+    names = set(os.path.splitext(os.path.basename(fn))[0] for fn in files)
+    for name in names:
         if name != '__init__':
             plugin = load_plugin(name)
             if hasattr(plugin, 'plugin_init'):
-- 
2.8.0


