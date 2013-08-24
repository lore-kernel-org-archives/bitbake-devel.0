Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id C877E61013
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Aug 2013 14:54:07 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7OF690d019276; Sat, 24 Aug 2013 16:06:10 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZRyVbDv3dQIg; Sat, 24 Aug 2013 16:06:09 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7OF66XA019262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sat, 24 Aug 2013 16:06:08 +0100
Message-ID: <1377356035.6762.193.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 24 Aug 2013 15:53:55 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH v2] data_smart: Add _remove operator
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
X-List-Received-Date: Sat, 24 Aug 2013 14:54:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There are long standing complaints about the fact its very difficult
to remove a portion of a variable. The immediate request is for a -=
and =- operator. The trouble is that += and =+ are "immediate"
operators and are applied straight away. Most people would expect
-= and =- to be deferred to have the effect most people desire and
therefore implementing -= and =- would just make the situation more
confusing.

This deferred operation is much more similar to the override syntax
which happens at data store finalisation. The _remove operator is
therefore in keeping with the _append and _prepend operations.

This code is loosely based on a patch from Peter Seebach although it
has been rewritten to be simpler, more efficient and avoid some
potential bugs.

The code currently only works on space delimited variables, which
are by far the most commom type. If bitbake is ehanced to support
types natively in future, we can adjust this code to adapt to that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index dfa9afe..3fb88a9 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -38,8 +38,8 @@ from bb.COW  import COWDictBase
 
 logger = logging.getLogger("BitBake.Data")
 
-__setvar_keyword__ = ["_append", "_prepend"]
-__setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend)(_(?P<add>.*))?$')
+__setvar_keyword__ = ["_append", "_prepend", "_remove"]
+__setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>.*))?$')
 __expand_var_regexp__ = re.compile(r"\${[^{}]+}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
 
@@ -357,7 +357,8 @@ class DataSmart(MutableMapping):
 
         #
         # First we apply all overrides
-        # Then  we will handle _append and _prepend
+        # Then we will handle _append and _prepend and store the _remove
+        # information for later.
         #
 
         # We only want to report finalization once per variable overridden.
@@ -392,7 +393,7 @@ class DataSmart(MutableMapping):
                 except Exception:
                     logger.info("Untracked delVar")
 
-        # now on to the appends and prepends
+        # now on to the appends and prepends, and stashing the removes
         for op in __setvar_keyword__:
             if op in self._special_values:
                 appends = self._special_values[op] or []
@@ -415,6 +416,10 @@ class DataSmart(MutableMapping):
                         elif op == "_prepend":
                             sval = a + (self.getVar(append, False) or "")
                             self.setVar(append, sval)
+                        elif op == "_remove":
+                            removes = self.getVarFlag(append, "_removeactive", False) or []
+                            removes.append(a)
+                            self.setVarFlag(append, "_removeactive", removes, ignore=True)
 
                     # We save overrides that may be applied at some later stage
                     if keep:
@@ -519,7 +524,7 @@ class DataSmart(MutableMapping):
             self.varhistory.record(**loginfo)
             self.setVar(newkey, val, ignore=True)
 
-        for i in ('_append', '_prepend'):
+        for i in (__setvar_keyword__):
             src = self.getVarFlag(key, i)
             if src is None:
                 continue
@@ -583,6 +588,14 @@ class DataSmart(MutableMapping):
                 value = copy.copy(local_var["defaultval"])
         if expand and value:
             value = self.expand(value, None)
+        if value and flag == "_content" and local_var and "_removeactive" in local_var:
+            for i in local_var["_removeactive"]:
+                if " " + i + " " in value:
+                    value = value.replace(" " + i + " ", " ")
+                if value.startswith(i + " "):
+                    value = value[len(i + " "):]
+                if value.endswith(" " + i):
+                    value = value[:-len(" " + i)]
         return value
 
     def delVarFlag(self, var, flag, **loginfo):



