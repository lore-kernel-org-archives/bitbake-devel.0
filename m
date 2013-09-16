Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 8E46B60F86
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:54:03 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM87O1029322; Mon, 16 Sep 2013 23:08:11 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gM_xK0XtdiLV; Mon, 16 Sep 2013 23:08:11 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM853l029306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:07 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjs-0002Zy-7s; Mon, 16 Sep 2013 22:53:48 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:29 +0100
Message-Id: <1379368413-9808-12-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 12/16] data: Optimise build_dependencies a little
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
X-List-Received-Date: Mon, 16 Sep 2013 21:54:04 -0000

Instead of multiple calls to getVarFlag, make one call to getVarFlags, only expanding
the flags that need to be expanded. This improves performance.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index ecac66c..876f6ca 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -287,18 +287,19 @@ def update_data(d):
 
 def build_dependencies(key, keys, shelldeps, vardepvals, d):
     deps = set()
-    vardeps = d.getVarFlag(key, "vardeps", True)
     try:
         if key[-1] == ']':
             vf = key[:-1].split('[')
             value = d.getVarFlag(vf[0], vf[1], False)
         else:
             value = d.getVar(key, False)
+        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude"]) or {}
+        vardeps = varflags.get("vardeps")
 
-        if key in vardepvals:
-           value =  d.getVarFlag(key, "vardepvalue", True)
-        elif d.getVarFlag(key, "func"):
-            if d.getVarFlag(key, "python"):
+        if "vardepvalue" in varflags:
+           value = varflags.get("vardepvalue")
+        elif varflags.get("func"):
+            if varflags.get("python"):
                 parsedvar = d.expandWithRefs(value, key)
                 parser = bb.codeparser.PythonParser(key, logger)
                 if parsedvar.value and "\t" in parsedvar.value:
@@ -323,16 +324,14 @@ def build_dependencies(key, keys, shelldeps, vardepvals, d):
         varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS', True)
         if varflagsexcl:
             varfdeps = []
-            varflags = d.getVarFlags(key)
-            if varflags:
-                for f in varflags:
-                    if f not in varflagsexcl:
-                        varfdeps.append('%s[%s]' % (key, f))
+            for f in varflags:
+                if f not in varflagsexcl:
+                    varfdeps.append('%s[%s]' % (key, f))
             if varfdeps:
                 deps |= set(varfdeps)
 
         deps |= set((vardeps or "").split())
-        deps -= set((d.getVarFlag(key, "vardepsexclude", True) or "").split())
+        deps -= set(varflags.get("vardepsexclude", "").split())
     except Exception as e:
         raise bb.data_smart.ExpansionError(key, None, e)
     return deps, value
-- 
1.8.1.2


