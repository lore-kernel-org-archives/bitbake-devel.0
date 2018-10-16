Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	by mail.openembedded.org (Postfix) with ESMTP id 0AE35745D1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Oct 2018 19:27:16 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id y16so26902434wrw.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Oct 2018 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=58JsduQpFTOZTKYGHnpKq+rF8sM8o9DC1Qb6MyoRoCc=;
	b=PR+w9015Uk4P+Vi/kWr2+wLAc4LxBrjVQy6vDg2L8Nfr1QJu+/8iv8D1JoKQVg5aJg
	vgqIvljH8LLpdxFNTZ6OBBr5fZtxFmE9GdwCwfDkUEmk2cgCbsbCNsnwJ5rcZ6Uqj0si
	8pH48Z8pxvVm++2wUunCrQLCsaqUxW3zvxp7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=58JsduQpFTOZTKYGHnpKq+rF8sM8o9DC1Qb6MyoRoCc=;
	b=KyiTF13Ei43FZTLM2D1nYSKDB4DfF11eBm6grJWrQta9PIzLj1I5pyKuZ4SAI4Q2ZG
	dzEbqcMqtO4YHQxjFIXMdm+i/yQZQbF2RgVvotJk6ssfnfEOZgeSSyzdaLDPQaneHJ8Z
	tXIG7RbUI0Hx4awTGlPpOraMN476731qXstwcMVBIe+gDviVIkYuYCkNuaaizfZpKQzI
	ZK6Y2vXcvHCS1uKTsooQwuNh2Q4APpg6Tv9JrYoBh9Ui3CvfWFVYLYsMd+7fLsV3tz2f
	tvQvwP5uNmAIjNYds+nHq3QHyiFCmWyNfQLGm/qmJBxmD25IgjQR8Sr9TgSHtSviIZ+h
	S15g==
X-Gm-Message-State: ABuFfohqx6hxSrWicNvSu8F8W4IGacdTrcjpAQF9XYR0r/QwLe++O0E7
	MhtVvT08XGKBfQvd6opZCVDiitFV0WI=
X-Google-Smtp-Source: ACcGV61dArZo0RTAgQwUiNa3gZlhrRvO7PBYpw6rcwfgZQ5Ik8ih2NYEOjVSFycjqPoDJjO1hRBpsA==
X-Received: by 2002:a5d:46d2:: with SMTP id
	g18-v6mr19462401wrs.185.1539718037336; 
	Tue, 16 Oct 2018 12:27:17 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j2-v6sm11979148wrw.29.2018.10.16.12.27.15
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Oct 2018 12:27:16 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 16 Oct 2018 20:27:09 +0100
Message-Id: <20181016192709.15771-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016192709.15771-1-richard.purdie@linuxfoundation.org>
References: <20181016192709.15771-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 3/3] data: Ensure task checksums account for remove data
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
X-List-Received-Date: Tue, 16 Oct 2018 19:27:17 -0000

Currently remove operations are not being accounted for in the task
checksums. This is a fairly serious oversight and needs to be fixed.

To do so, we need internal data from getVarFlag combined with the
expanded variable data so that only "active" remove operators are
accounted for in the task checksum.

This code adds in an internal hook to get the data and accounts
for the operator in the task checksum when the removal is active.

[YOCTO #12913]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py       | 16 +++++++++++++++-
 lib/bb/data_smart.py |  7 +++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 80a7879cb6..55ba7b1329 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -290,7 +290,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             return deps, value
         varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "exports", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
         vardeps = varflags.get("vardeps")
-        value = d.getVarFlag(key, "_content", False)
+        value, removes = d.getVarFlag(key, "_content", False, retremoves=True)
 
         def handle_contains(value, contains, d):
             newvalue = ""
@@ -309,6 +309,16 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 return newvalue
             return value + newvalue
 
+        def handle_remove(value, deps, expandedval, removes, d):
+            activeremoves = []
+            for r in removes:
+                r2 = d.expandWithRefs(r, None)
+                if r2.value in expandedval.split():
+                    value += "\n_remove of %s(%s)" % (r, r2.value)
+                    deps |= r2.references
+                    deps = deps | (keys & r2.execs)
+            return value
+
         if "vardepvalue" in varflags:
            value = varflags.get("vardepvalue")
         elif varflags.get("func"):
@@ -328,6 +338,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 deps = deps | parsedvar.references
                 deps = deps | (keys & parser.execs) | (keys & parsedvar.execs)
                 value = handle_contains(value, parsedvar.contains, d)
+                if removes:
+                    value = handle_remove(value, deps, parser.value, removes, d)
             if vardeps is None:
                 parser.log.flush()
             if "prefuncs" in varflags:
@@ -341,6 +353,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             deps |= parser.references
             deps = deps | (keys & parser.execs)
             value = handle_contains(value, parser.contains, d)
+            if removes:
+                value = handle_remove(value, deps, parser.value, removes, d)
 
         if "vardepvalueexclude" in varflags:
             exclude = varflags.get("vardepvalueexclude")
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 0a8488ca1b..60ea6755ee 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -731,7 +731,7 @@ class DataSmart(MutableMapping):
                 self.dict["__exportlist"]["_content"] = set()
             self.dict["__exportlist"]["_content"].add(var)
 
-    def getVarFlag(self, var, flag, expand=True, noweakdefault=False, parsing=False):
+    def getVarFlag(self, var, flag, expand=True, noweakdefault=False, parsing=False, retremoves=False):
         local_var, overridedata = self._findVar(var)
         value = None
         if flag == "_content" and overridedata is not None and not parsing:
@@ -805,8 +805,8 @@ class DataSmart(MutableMapping):
                 cachename = var + "[" + flag + "]"
             value = self.expand(value, cachename)
 
+        removes = []
         if value and flag == "_content" and local_var is not None and "_remove" in local_var:
-            removes = []
             self.need_overrides()
             for (r, o) in local_var["_remove"]:
                 match = True
@@ -825,6 +825,9 @@ class DataSmart(MutableMapping):
                     # We need to ensure the expand cache has the correct value
                     # flag == "_content" here
                     self.expand_cache[var].value = value
+
+        if retremoves:
+            return value, removes
         return value
 
     def delVarFlag(self, var, flag, **loginfo):
-- 
2.17.1


