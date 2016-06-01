Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5A7B9773BE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb3BF007479; Wed, 1 Jun 2016 13:37:08 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DrZvRg3r_ljd; Wed,  1 Jun 2016 13:37:08 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxYW007469
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000pU-Jx; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:46 +0100
Message-Id: <1464784607-2985-27-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 27/28] toaster: fix urllib imports
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:14 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Some functions have been moved from urllib to urllib.parse
in python 3. Modifying the code to import unquote, urlencode and
unquote_plus from urllib.parse if import from urllib fails should
make it working on both python 2 and python 3.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/toastergui/views.py   | 9 ++++++---
 lib/toaster/toastergui/widgets.py | 6 +++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 8e920f0..0510897 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -200,16 +200,19 @@ def _verify_parameters(g, mandatory_parameters):
     return None
 
 def _redirect_parameters(view, g, mandatory_parameters, *args, **kwargs):
-    import urllib
+    try:
+        from urllib import unquote, urlencode
+    except ImportError:
+        from urllib.parse import unquote, urlencode
     url = reverse(view, kwargs=kwargs)
     params = {}
     for i in g:
         params[i] = g[i]
     for i in mandatory_parameters:
         if not i in params:
-            params[i] = urllib.unquote(str(mandatory_parameters[i]))
+            params[i] = unquote(str(mandatory_parameters[i]))
 
-    return redirect(url + "?%s" % urllib.urlencode(params), permanent = False, **kwargs)
+    return redirect(url + "?%s" % urlencode(params), permanent = False, **kwargs)
 
 class RedirectException(Exception):
     def __init__(self, view, g, mandatory_parameters, *args, **kwargs):
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 19850fb..551c33c 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -38,7 +38,11 @@ import json
 import collections
 import operator
 import re
-import urllib
+
+try:
+    from urllib import unquote_plus
+except ImportError:
+    from urllib.parse import unquote_plus
 
 import logging
 logger = logging.getLogger("toaster")
-- 
2.5.0


