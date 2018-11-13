Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id E9D616C24B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 22:59:43 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id l9so2287946wrt.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=gzrRG+YcjmwwF1T/ARJlZzGCvicg+0p8DvhDeqmq5Bk=;
	b=LpJcUnsnqSXGF+DMJfe4JJMwX8vU5YElArxDvRR/1fP6cqO44z/PnK5+eQ8CjpaGsu
	4jdEdWH7OzvzKMfSXeywM2iPUrVXbzIVoSPa3Z4NHmnVeo9k9h+RwzmOz5F/iC7jyEiC
	29z+CjMRRQ+KLCvHjMv9iCdXpIETANwae0HNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=gzrRG+YcjmwwF1T/ARJlZzGCvicg+0p8DvhDeqmq5Bk=;
	b=RQD/zoiMPBNWLUIwV+pYK7dqJO7czbQwkTvUiTJXOsAokBTQK4Qs//M0pnv9tduIw2
	wuFZOmDo7iaKBefsmq7fg0rnc2JKMRJE7dcDadpBxXpvwpe5bUf5YX7EaGAdBQtBtveo
	6/PJ6uGwOTNOFhzX8LmLXhP8h0//6E1tQ6npqtzSQhbB32hFmGNO1omVVu5u8OI8pFjz
	6MEbG4sgSyQgD3dlVw3RXRDCYd37M71qS7C2lCemvBlcdAXmo0GN9PqjhyzonZLd1FeW
	yIh48cB2JI2mHZpsir1veA+dEsu4FtIUhNcT8kio1hk3CgPOqHfdUa5ukQrCrlCL+oqn
	TESw==
X-Gm-Message-State: AGRZ1gISg0KcAgEfenz2WcPMstT39ztdL9P1NN7/niDg4lpXERtL9/bt
	lgY5IP2BlAZsGdIaWVUMgo86YnIh6uk=
X-Google-Smtp-Source: AJdET5fj0DwvShuYrbDjX1J6V1qwj7/xoQXtbGNzRpfDw+qIb5bl+SAyF1rclVVv6DrBqp01/pfUBQ==
X-Received: by 2002:adf:ea82:: with SMTP id
	s2-v6mr6393206wrm.180.1542149984157; 
	Tue, 13 Nov 2018 14:59:44 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	6-v6sm10334217wmg.19.2018.11.13.14.59.43
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Nov 2018 14:59:43 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Nov 2018 22:59:41 +0000
Message-Id: <20181113225942.17780-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 1/2] utils: Avoid warnings about deprecated imp module
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
X-List-Received-Date: Tue, 13 Nov 2018 22:59:44 -0000

The imp module is deprecated, port the code over to use importlib.

bitbake/lib/bb/utils.py:30: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 73b6cb423b..1cadbc5bcd 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -27,7 +27,7 @@ import bb
 import bb.msg
 import multiprocessing
 import fcntl
-import imp
+import importlib
 import itertools
 import subprocess
 import glob
@@ -43,7 +43,7 @@ from contextlib import contextmanager
 from ctypes import cdll
 
 logger = logging.getLogger("BitBake.Util")
-python_extensions = [e for e, _, _ in imp.get_suffixes()]
+python_extensions = importlib.machinery.all_suffixes()
 
 
 def clean_context():
@@ -1544,12 +1544,9 @@ def export_proxies(d):
 def load_plugins(logger, plugins, pluginpath):
     def load_plugin(name):
         logger.debug(1, 'Loading plugin %s' % name)
-        fp, pathname, description = imp.find_module(name, [pluginpath])
-        try:
-            return imp.load_module(name, fp, pathname, description)
-        finally:
-            if fp:
-                fp.close()
+        spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath] )
+        if spec:
+            return spec.loader.load_module()
 
     logger.debug(1, 'Loading plugins from %s...' % pluginpath)
 
-- 
2.17.1


