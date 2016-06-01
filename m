Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BB4C377299
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb48L007485; Wed, 1 Jun 2016 13:37:05 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HbCqgim5Gxj6; Wed,  1 Jun 2016 13:37:05 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxBI007454
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000oC-Bp; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:31 +0100
Message-Id: <1464784607-2985-12-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 12/28] toaster: fix imports to work for python 3
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:12 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Some APIs have been moved to other modules in python 3:
 getstatusoutput: moved from commands to subproces
 urlopen: moved from urllib2 to urllib.request
 urlparse: moved from urlparse to urllib.parse

Made the imports work for both python versions by
catching ImportError and importing APIs from different
modules.

[YOCTO #9584]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py           |  1 -
 lib/toaster/orm/models.py | 16 ++++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 138da44..8f75871 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -41,7 +41,6 @@ from subprocess import getstatusoutput
 from contextlib import contextmanager
 from ctypes import cdll
 
-
 logger = logging.getLogger("BitBake.Util")
 python_extensions = [e for e, _, _ in imp.get_suffixes()]
 
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 88967a2..9183b0c 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1147,18 +1147,26 @@ class LayerIndexLayerSource(LayerSource):
         assert self.apiurl is not None
         from django.db import transaction, connection
 
-        import urllib2, urlparse, json
+        import json
         import os
+
+        try:
+            from urllib.request import urlopen, URLError
+            from urllib.parse import urlparse
+        except ImportError:
+            from urllib2 import urlopen, URLError
+            from urlparse import urlparse
+
         proxy_settings = os.environ.get("http_proxy", None)
         oe_core_layer = 'openembedded-core'
 
         def _get_json_response(apiurl = self.apiurl):
-            _parsedurl = urlparse.urlparse(apiurl)
+            _parsedurl = urlparse(apiurl)
             path = _parsedurl.path
 
             try:
-                res = urllib2.urlopen(apiurl)
-            except urllib2.URLError as e:
+                res = urlopen(apiurl)
+            except URLError as e:
                 raise Exception("Failed to read %s: %s" % (path, e.reason))
 
             return json.loads(res.read())
-- 
2.5.0


