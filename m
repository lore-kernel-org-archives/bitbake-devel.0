Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
	[209.85.221.53])
	by mail.openembedded.org (Postfix) with ESMTP id 2477F79C03
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 09:22:51 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id 63-v6so32777746wra.11
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=aZdXim9WY2qauDEG5jf13ypgwNYXftzXsEEzxkjE+5M=;
	b=TDCwHBuODtQJ/wCCFRmi67NPOtwgA0n6so8k4Cczy9Kg4rFjhFkHHz6jT8hPPbyac0
	t0IayM0096Eeqfiy78C1jFUjEXBFnX2VDUgWsC1VmobIlk5Ghh6mRW9R6Abu2h5nE4DO
	kOgadNg6hynassRQ//4nI5r1BSusHrvruJV7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=aZdXim9WY2qauDEG5jf13ypgwNYXftzXsEEzxkjE+5M=;
	b=M7K0mb1jD4dx3TaQ627Oxv/QsU7narYk/pQ2i2A+fzKYJFh5oPbVkWii04ru85f8a/
	D2t2tn8ff9Gdamby8HAbpGTOkSQuKtSmRvHFinFhDutnnxqanOIxWA3bKF0SiN7kGxiO
	NOeVHEpIKFeULOA4X3bimnw93c2Vbcp7mj+XGmyi/RKvd8Gtx00iiYZBm/HfHuirVvKE
	ZEi0KuZO4eLvJ/g6QjPwRsea/jLPsFzKEj3LNZSgtdKCGshhwiRPQNIWsZfv9g1VQAgx
	10GSKqJ3W8UZViTFL/7QmGYe5CQsVy8M0NRiLmfI8IVyMOx3Awz+RZg/orV9YhtbWaF9
	gUag==
X-Gm-Message-State: ABuFfoiP2E+GJXtn27UOPCiH+tQUfgi82R6+Ygox/lGbFNwLWPupS1ce
	Z+qTLenXq3BgQMLOfsKendnciHTzak4=
X-Google-Smtp-Source: ACcGV60DqgU8biDR8/ElHmuj9az5VvWm7olci1mHe831KPE/TcyvOsq/SHy728A1Gm11D4CynAEIGQ==
X-Received: by 2002:adf:ff46:: with SMTP id u6-v6mr5807672wrs.7.1539854572161; 
	Thu, 18 Oct 2018 02:22:52 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x17-v6sm17666494wrs.84.2018.10.18.02.22.50
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 02:22:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Oct 2018 10:22:43 +0100
Message-Id: <20181018092246.1445-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
References: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 4/7] data/data_smart: Allow getVarFlag to return the variable parser object
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
X-List-Received-Date: Thu, 18 Oct 2018 09:22:52 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py       | 11 +++++------
 lib/bb/data_smart.py | 18 +++++++++++++-----
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 80a7879cb6..e2700077c3 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -283,14 +283,12 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
     try:
         if key[-1] == ']':
             vf = key[:-1].split('[')
-            value = d.getVarFlag(vf[0], vf[1], False)
-            parser = d.expandWithRefs(value, key)
+            value, parser = d.getVarFlag(vf[0], vf[1], False, retparser=True)
             deps |= parser.references
             deps = deps | (keys & parser.execs)
             return deps, value
         varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "exports", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
         vardeps = varflags.get("vardeps")
-        value = d.getVarFlag(key, "_content", False)
 
         def handle_contains(value, contains, d):
             newvalue = ""
@@ -310,9 +308,10 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             return value + newvalue
 
         if "vardepvalue" in varflags:
-           value = varflags.get("vardepvalue")
+            value = varflags.get("vardepvalue")
         elif varflags.get("func"):
             if varflags.get("python"):
+                value = d.getVarFlag(key, "_content", False)
                 parser = bb.codeparser.PythonParser(key, logger)
                 if value and "\t" in value:
                     logger.warning("Variable %s contains tabs, please remove these (%s)" % (key, d.getVar("FILE")))
@@ -321,7 +320,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 deps = deps | (keys & parser.execs)
                 value = handle_contains(value, parser.contains, d)
             else:
-                parsedvar = d.expandWithRefs(value, key)
+                value, parsedvar = d.getVarFlag(key, "_content", False, retparser=True)
                 parser = bb.codeparser.ShellParser(key, logger)
                 parser.parse_shell(parsedvar.value)
                 deps = deps | shelldeps
@@ -337,7 +336,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             if "exports" in varflags:
                 deps = deps | set(varflags["exports"].split())
         else:
-            parser = d.expandWithRefs(value, key)
+            value, parser = d.getVarFlag(key, "_content", False, retparser=True)
             deps |= parser.references
             deps = deps | (keys & parser.execs)
             value = handle_contains(value, parser.contains, d)
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index ecc71bd644..4ad0567c9a 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -722,7 +722,7 @@ class DataSmart(MutableMapping):
                 self.dict["__exportlist"]["_content"] = set()
             self.dict["__exportlist"]["_content"].add(var)
 
-    def getVarFlag(self, var, flag, expand=True, noweakdefault=False, parsing=False):
+    def getVarFlag(self, var, flag, expand=True, noweakdefault=False, parsing=False, retparser=False):
         if flag == "_content":
             cachename = var
         else:
@@ -798,9 +798,11 @@ class DataSmart(MutableMapping):
                 if match:
                     value = r + value
 
+        parser = None
+        if expand or retparser:
+            parser = self.expandWithRefs(value, cachename)
         if expand:
-            self.expand_cache[cachename] = self.expandWithRefs(value, cachename)
-            value = self.expand_cache[cachename].value
+            value = parser.value
 
         if value and flag == "_content" and local_var is not None and "_remove" in local_var and not parsing:
             removes = []
@@ -818,8 +820,14 @@ class DataSmart(MutableMapping):
                 filtered = filter(lambda v: v not in removes,
                                   __whitespace_split__.split(value))
                 value = "".join(filtered)
-                if expand and cachename in self.expand_cache:
-                    self.expand_cache[cachename].value = value
+                if parser:
+                    parser.value = value
+
+        if parser:
+            self.expand_cache[cachename] = parser
+
+        if retparser:
+            return value, parser
 
         return value
 
-- 
2.17.1


