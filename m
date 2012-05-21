Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SWcHh-0002x0-5i
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 May 2012 01:45:05 +0200
Received: by pbbrq2 with SMTP id rq2so6664392pbb.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2012 16:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer;
	bh=r2MP+gp+oxcShzuM6uNNIsdx1tb8VTaPhBCcX+Bo6Z8=;
	b=boMWmigBF8uNn7vp5sP/ncXm+rztWFJqhhyXw5td9SYMHNnRAw4KGU4RdR4WLo1Myd
	s7sozqAXqIIUa1GM0Mw1ZptxlNPNHTDx5hnl4S4ZmEcyPpj4hGr+xQo8Gigj35D+IPcn
	Q3oUtW32HaPnshTmsMoXmFZSilrYQIwOBkjFXTGzJpnCEZdP+0zc0b6Hw/6bNvBFMCF2
	yadt5/LYE5hmeeKP9gbHxl63ooAJtB6qMVozng6EmLHdyNufLhzt3O1gHRS3o1mmZtrK
	C6oQX+ooeYRA7nOQR2Sp0l99Xfh3J+I2vbqSBOk5jkHkeZQpjcsvfRImJLGPLUnbyprw
	UbZQ==
Received: by 10.68.132.101 with SMTP id ot5mr9472977pbb.91.1337643296453;
	Mon, 21 May 2012 16:34:56 -0700 (PDT)
Received: from localhost.localdomain (ip68-110-79-242.ph.ph.cox.net.
	[68.110.79.242])
	by mx.google.com with ESMTPS id mt9sm24582499pbb.14.2012.05.21.16.34.54
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 21 May 2012 16:34:55 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 May 2012 16:34:49 -0700
Message-Id: <1337643289-21368-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.7.10.2
Subject: [PATCH] fetch2: quote/unquote url paths
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 21 May 2012 23:45:05 -0000

This ensures we can handle things like %-encoded characters in the path
portion of urls.

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 lib/bb/fetch2/__init__.py |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e3ac4d2..dba8797 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -28,6 +28,7 @@ from __future__ import absolute_import
 from __future__ import print_function
 import os, re
 import logging
+import urllib
 import bb.persist_data, bb.utils
 from bb import data
 
@@ -147,14 +148,14 @@ def decodeurl(url):
             s1, s2 = s.split('=')
             p[s1] = s2
 
-    return (type, host, path, user, pswd, p)
+    return type, host, urllib.unquote(path), user, pswd, p
 
 def encodeurl(decoded):
     """Encodes a URL from tokens (scheme, network location, path,
     user, password, parameters).
     """
 
-    (type, host, path, user, pswd, p) = decoded
+    type, host, path, user, pswd, p = decoded
 
     if not path:
         raise MissingParameterError('path', "encoded from the data %s" % str(decoded))
@@ -168,7 +169,7 @@ def encodeurl(decoded):
         url += "@"
     if host and type != "file":
         url += "%s" % host
-    url += "%s" % path
+    url += "%s" % urllib.quote(path)
     if p:
         for parm in p:
             url += ";%s=%s" % (parm, p[parm])
-- 
1.7.10.2



