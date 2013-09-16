Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 1B66260F86
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:54:03 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM884Q029330; Mon, 16 Sep 2013 23:08:12 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vHue_mM6sauA; Mon, 16 Sep 2013 23:08:12 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM86tO029308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:07 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjs-0002a8-ER; Mon, 16 Sep 2013 22:53:48 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:31 +0100
Message-Id: <1379368413-9808-14-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 14/16] data: Optimise flag exclusion list handling
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

Move the variable lookup to the outer loop for performance, replacing
a now unneeded parameter (after the previous changes).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 49bb5e9..349fcfe 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -285,7 +285,7 @@ def update_data(d):
     """Performs final steps upon the datastore, including application of overrides"""
     d.finalize(parent = True)
 
-def build_dependencies(key, keys, shelldeps, vardepvals, d):
+def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
     deps = set()
     try:
         if key[-1] == ']':
@@ -324,7 +324,6 @@ def build_dependencies(key, keys, shelldeps, vardepvals, d):
             deps = deps | (keys & parser.execs)
 
         # Add varflags, assuming an exclusion list is set
-        varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS', True)
         if varflagsexcl:
             varfdeps = []
             for f in varflags:
@@ -345,14 +344,14 @@ def generate_dependencies(d):
 
     keys = set(key for key in d if not key.startswith("__"))
     shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export") and not d.getVarFlag(key, "unexport"))
-    vardepvals = set(key for key in keys if d.getVarFlag(key, "vardepvalue"))
+    varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS', True)
 
     deps = {}
     values = {}
 
     tasklist = d.getVar('__BBTASKS') or []
     for task in tasklist:
-        deps[task], values[task] = build_dependencies(task, keys, shelldeps, vardepvals, d)
+        deps[task], values[task] = build_dependencies(task, keys, shelldeps, varflagsexcl, d)
         newdeps = deps[task]
         seen = set()
         while newdeps:
@@ -361,7 +360,7 @@ def generate_dependencies(d):
             newdeps = set()
             for dep in nextdeps:
                 if dep not in deps:
-                    deps[dep], values[dep] = build_dependencies(dep, keys, shelldeps, vardepvals, d)
+                    deps[dep], values[dep] = build_dependencies(dep, keys, shelldeps, varflagsexcl, d)
                 newdeps |=  deps[dep]
             newdeps -= seen
         #print "For %s: %s" % (task, str(deps[task]))
-- 
1.8.1.2


