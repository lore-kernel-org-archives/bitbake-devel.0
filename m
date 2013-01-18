Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TwAe0-0002Hw-2r for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 13:02:02 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IBkaPc008508
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2013 11:46:36 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05510-01 for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2013 11:46:32 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IBkU7j008501
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2013 11:46:31 GMT
Message-ID: <1358509590.27799.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 18 Jan 2013 11:46:30 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] BBHandler/data: Standardise some setVar access formats
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
X-List-Received-Date: Fri, 18 Jan 2013 12:02:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 478a482..2c3e905 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -158,7 +158,7 @@ def expandKeys(alterdata, readdata = None):
 
     for key in todolist:
         ekey = todolist[key]
-        renameVar(key, ekey, alterdata)
+        alterdata.renameVar(key, ekey)
 
 def inheritFromOS(d, savedenv, permitted):
     """Inherit variables from the initial environment."""
@@ -166,9 +166,9 @@ def inheritFromOS(d, savedenv, permitted):
     for s in savedenv.keys():
         if s in permitted:
             try:
-                setVar(s, getVar(s, savedenv, True), d)
+                d.setVar(s, getVar(s, savedenv, True))
                 if s in exportlist:
-                    setVarFlag(s, "export", True, d)
+                    d.setVarFlag(s, "export", True)
             except TypeError:
                 pass
 
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 58049bd..88ad039 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -84,7 +84,7 @@ def inherit(files, fn, lineno, d):
         if not file in __inherit_cache:
             logger.log(logging.DEBUG -1, "BB %s:%d: inheriting %s", fn, lineno, file)
             __inherit_cache.append( file )
-            data.setVar('__inherit_cache', __inherit_cache, d)
+            d.setVar('__inherit_cache', __inherit_cache)
             include(fn, file, lineno, d, "inherit")
             __inherit_cache = d.getVar('__inherit_cache') or []
 
@@ -134,7 +134,7 @@ def handle(fn, d, include):
         __inherit_cache = d.getVar('__inherit_cache') or []
         if not fn in __inherit_cache:
             __inherit_cache.append(fn)
-            data.setVar('__inherit_cache', __inherit_cache, d)
+            d.setVar('__inherit_cache', __inherit_cache)
 
     if include != 0:
         oldfile = d.getVar('FILE')
@@ -151,7 +151,7 @@ def handle(fn, d, include):
 
     # DONE WITH PARSING... time to evaluate
     if ext != ".bbclass":
-        data.setVar('FILE', abs_fn, d)
+        d.setVar('FILE', abs_fn)
 
     try:
         statements.eval(d)




