Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SXV3K-0004FN-Ja for bitbake-devel@lists.openembedded.org;
	Thu, 24 May 2012 12:13:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4OA3iuB022342
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 11:03:44 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 21875-03 for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 11:03:39 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4OA3YFY022335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 11:03:34 +0100
Message-ID: <1337853813.8248.107.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 May 2012 11:03:33 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] BBHandler: Tweak some data store access methods to the preferred syntax
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
X-List-Received-Date: Thu, 24 May 2012 10:13:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 815bce1..625a2a2 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -69,7 +69,7 @@ def supports(fn, d):
     return os.path.splitext(fn)[-1] in [".bb", ".bbclass", ".inc"]
 
 def inherit(files, fn, lineno, d):
-    __inherit_cache = data.getVar('__inherit_cache', d) or []
+    __inherit_cache = d.getVar('__inherit_cache') or []
     files = d.expand(files).split()
     for file in files:
         if not os.path.isabs(file) and not file.endswith(".bbclass"):
@@ -80,7 +80,7 @@ def inherit(files, fn, lineno, d):
             __inherit_cache.append( file )
             data.setVar('__inherit_cache', __inherit_cache, d)
             include(fn, file, lineno, d, "inherit")
-            __inherit_cache = data.getVar('__inherit_cache', d) or []
+            __inherit_cache = d.getVar('__inherit_cache') or []
 
 def get_statements(filename, absolute_filename, base_name):
     global cached_statements
@@ -126,13 +126,13 @@ def handle(fn, d, include):
     if ext == ".bbclass":
         __classname__ = root
         classes.append(__classname__)
-        __inherit_cache = data.getVar('__inherit_cache', d) or []
+        __inherit_cache = d.getVar('__inherit_cache') or []
         if not fn in __inherit_cache:
             __inherit_cache.append(fn)
             data.setVar('__inherit_cache', __inherit_cache, d)
 
     if include != 0:
-        oldfile = data.getVar('FILE', d)
+        oldfile = d.getVar('FILE')
     else:
         oldfile = None
 




