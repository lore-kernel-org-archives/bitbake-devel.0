Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
	[209.85.220.65])
	by mail.openembedded.org (Postfix) with ESMTP id 66D6A7706C
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:41:05 +0000 (UTC)
Received: by mail-pa0-f65.google.com with SMTP id i5so15298444pag.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=i/bC15Zs3JvccXSeEUBXo1mRCDxXEpP8GlHWqVZXPIU=;
	b=LhiH+5+VRULEMV7MHKdy8EjDq7+lDVtmhRQah7xnsAljbzzb2QtJA9W/mfqe+yCbHO
	kZKl3OCpdTDiSRSf/xSF6ROdhhifE/eKlsy15J4F7Sc8tYInm5XgoxLL4Wf60h+yIhzL
	k53aesW8LcuzC/7294vV2sIXh97ZTgA4p2RrflceVNXL0PCXau431UaJjAk6HZZiudDz
	PO25WOHJj30FD5zaxVdQlKsrGZxGBww1eB4GnOyLjJEvY1ZIBVVYMucYRnxdD3TXXB1z
	ZoI86sWUEn1mc0IqvGh5V1k8jIcsgfXrX1IqLVldQQcOmcBPzkkVL0Rsv4uOz4jHze/p
	lOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=i/bC15Zs3JvccXSeEUBXo1mRCDxXEpP8GlHWqVZXPIU=;
	b=LYomLgpwBEYtdn+C1SJS8uqAXqauipAgHmj0suZGlAb3Prtspn8PU155YXgx5aycyp
	lQik3UkZxlqLtiVQzbT0xiSISGZGVmpMSS75FvYtCix/yd9lZY7MvVZRUpKUi5zgrBQO
	Qz3p50c8bNiDFRTgYJHDsgRsVNIu6jEUHr0doK/ZgszfmdOh8KezbyXoVKaYNFX01Qx2
	D7JAJytsxog/f7SBGoCrxQoqvUsvEOj8LzJ/KslVw5jRx9JzY33b3U7TnmgDX9L6sOMH
	O72b5s3oPSIMoljnq/yPSd3kWz6Nb7JArrRQnsWO6jO5bGolwQOuZSOI6ID4smfRtzn2
	ZtVw==
X-Gm-Message-State: AOPr4FW4L2KfFh21z0xRx+0q+DKGEfaWGR9gLWbEwrlS1p2m6aImIiF79gX8bwUuiIOOAA==
X-Received: by 10.66.132.37 with SMTP id or5mr39024093pab.144.1462045266326;
	Sat, 30 Apr 2016 12:41:06 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	d78sm33226530pfb.59.2016.04.30.12.41.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:41:04 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:40:57 -0700
Message-Id: <4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1462041562.git.chris_larson@mentor.com>
References: <cover.1462041562.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [RFC master][PATCH 1/4] bb.utils: add load_plugins from scriptutils
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
X-List-Received-Date: Sat, 30 Apr 2016 19:41:06 -0000

From: Christopher Larson <chris_larson@mentor.com>

Imported as of oe-core 184a256.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/utils.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 3544bbe..92f1b60 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -27,6 +27,7 @@ import bb
 import bb.msg
 import multiprocessing
 import fcntl
+import imp
 import subprocess
 import glob
 import fnmatch
@@ -1451,3 +1452,23 @@ def export_proxies(d):
                 exported = True
 
     return exported
+
+
+def load_plugins(logger, plugins, pluginpath):
+    def load_plugin(name):
+        logger.debug('Loading plugin %s' % name)
+        fp, pathname, description = imp.find_module(name, [pluginpath])
+        try:
+            return imp.load_module(name, fp, pathname, description)
+        finally:
+            if fp:
+                fp.close()
+
+    logger.debug('Loading plugins from %s...' % pluginpath)
+    for fn in glob.glob(os.path.join(pluginpath, '*.py')):
+        name = os.path.splitext(os.path.basename(fn))[0]
+        if name != '__init__':
+            plugin = load_plugin(name)
+            if hasattr(plugin, 'plugin_init'):
+                plugin.plugin_init(plugins)
+            plugins.append(plugin)
-- 
2.8.0


