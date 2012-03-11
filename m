Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S6k0X-0008Aa-Ac for bitbake-devel@lists.openembedded.org;
	Sun, 11 Mar 2012 15:44:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2BEZhE6003367
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Mar 2012 14:35:43 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 03246-01 for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Mar 2012 14:35:38 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2BEZaW8003361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Mar 2012 14:35:37 GMT
Message-ID: <1331476536.15192.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 11 Mar 2012 14:35:36 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] codeparser: Compute extra cache components on the fly rather than later
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
X-List-Received-Date: Sun, 11 Mar 2012 14:44:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

In the initial implementation there was a reluctance on my part to
generate incremental cache components on the fly since it would lead
to some duplicate code.

We are now seeing problems where each thread reading in the saved cache
file causes significant overhead and can make the process appear to hang
on a many core build, particularly when the cache file is large.

This patch changes the code to maintain the delta in a separate dict
right from the start. The code duplication isn't too bad and could be
mitigated in other ways if it becomes an issue.

[YOCTO #2039 partial]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/codeparser.py |   41 ++++++++++++++++++++---------------------
 1 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 2590e5c..04a34f9 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -34,6 +34,9 @@ def check_indent(codestr):
 
 pythonparsecache = {}
 shellparsecache = {}
+pythonparsecacheextras = {}
+shellparsecacheextras = {}
+
 
 def parser_cachefile(d):
     cachedir = (d.getVar("PERSISTENT_DIR", True) or
@@ -86,22 +89,8 @@ def parser_cache_save(d):
             i = i + 1
             continue
 
-        try:
-            p = pickle.Unpickler(file(cachefile, "rb"))
-            data, version = p.load()
-        except (IOError, EOFError, ValueError):
-            data, version = None, None
-
-        if version != PARSERCACHE_VERSION:
-            shellcache = shellparsecache
-            pythoncache = pythonparsecache
-        else:
-            for h in pythonparsecache:
-                if h not in data[0]:
-                    pythoncache[h] = pythonparsecache[h]
-            for h in shellparsecache:
-                if h not in data[1]:
-                    shellcache[h] = shellparsecache[h]
+        shellcache = shellparsecacheextras
+        pythoncache = pythonparsecacheextras
 
         p = pickle.Pickler(file(cachefile + "-" + str(i), "wb"), -1)
         p.dump([[pythoncache, shellcache], PARSERCACHE_VERSION])
@@ -230,6 +219,12 @@ class PythonParser():
             self.execs = pythonparsecache[h]["execs"]
             return
 
+        if h in pythonparsecacheextras:
+            self.references = pythonparsecacheextras[h]["refs"]
+            self.execs = pythonparsecacheextras[h]["execs"]
+            return
+
+
         code = compile(check_indent(str(node)), "<string>", "exec",
                        ast.PyCF_ONLY_AST)
 
@@ -240,9 +235,9 @@ class PythonParser():
         self.references.update(self.var_references)
         self.references.update(self.var_execs)
 
-        pythonparsecache[h] = {}
-        pythonparsecache[h]["refs"] = self.references
-        pythonparsecache[h]["execs"] = self.execs
+        pythonparsecacheextras[h] = {}
+        pythonparsecacheextras[h]["refs"] = self.references
+        pythonparsecacheextras[h]["execs"] = self.execs
 
 class ShellParser():
     def __init__(self, name, log):
@@ -264,6 +259,10 @@ class ShellParser():
             self.execs = shellparsecache[h]["execs"]
             return self.execs
 
+        if h in shellparsecacheextras:
+            self.execs = shellparsecacheextras[h]["execs"]
+            return self.execs
+
         try:
             tokens, _ = pyshyacc.parse(value, eof=True, debug=False)
         except pyshlex.NeedMore:
@@ -273,8 +272,8 @@ class ShellParser():
             self.process_tokens(token)
         self.execs = set(cmd for cmd in self.allexecs if cmd not in self.funcdefs)
 
-        shellparsecache[h] = {}
-        shellparsecache[h]["execs"] = self.execs
+        shellparsecacheextras[h] = {}
+        shellparsecacheextras[h]["execs"] = self.execs
 
         return self.execs
 




