Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id DF89079BEC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 09:22:50 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id d2-v6so32831801wro.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=2OEf11jKhzsdMMAa77R3t0CbV5pE8D47mP6+6cjxXhk=;
	b=djYSuq4GeASUMyQRd6+GYBckFlVC2lu8diuK1ZIR8vxnPLcAM9WSoBlEOATeLI7IMG
	X2S75zyc7GdQWXje8USxUiU2QLg2Q+g8WAGjZTtSLa3lYJn9UCRD5iU4MA6pgnCSDfyA
	ZcbiFXJ0yN5/Pfpngw9CiUi+vjgzkpys+KE1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=2OEf11jKhzsdMMAa77R3t0CbV5pE8D47mP6+6cjxXhk=;
	b=gu4Ejd/22/Y+KcW/uMYAJ4fY084zpWyQ0dRL+nMgqLamJU0lR3HZhX6vjgd/K6l2xO
	nzAN+HbqpjdYexa0BTNJR7oaJVjgWKtqzNpaK3xF+ou989Axl0LoIIj0a1DbC2MFlFhL
	1YYZAJUJN6MLwl5zlNFVygsRAmKyIF/x7e+rVUPysGihwhY4TIO2obYLMPIxGuLAy79o
	8chhNltV66hM7m2N/i01f8C8G7WQKv21RLNUb6pTPLKDygpQ9xqfp0e02PTRERIlAPSa
	AAtOBbOgaIYNl1G1gPV5difZEra5yXhKKImsSElKNIvFa7hb47+8/uTG3Pp3w0SwCcv/
	CG4A==
X-Gm-Message-State: ABuFfohaR1sDjvvVA3hCi9K41FV52f9UBT989TY+wDom7ph1Vfqmd6kZ
	FZutgBWHOaa/KrpY3bMbu3ceDfFuo8c=
X-Google-Smtp-Source: ACcGV60ZeBPW1yvWm0DqqS0uiqL34oSJvt7yCwU8J4dLQnwFVypOY7MBRs+YwHU0gdx5JrKXrISYKg==
X-Received: by 2002:adf:aa90:: with SMTP id
	h16-v6mr26544753wrc.216.1539854570949; 
	Thu, 18 Oct 2018 02:22:50 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x17-v6sm17666494wrs.84.2018.10.18.02.22.49
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 02:22:50 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Oct 2018 10:22:42 +0100
Message-Id: <20181018092246.1445-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
References: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 3/7] data_smart: Fix expand_cache and _remove operator interaction issues
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
X-List-Received-Date: Thu, 18 Oct 2018 09:22:51 -0000

The contents of the expand_cache is meant to match the return value of
getVarFlag() but the implementation was mostly in expandWithRefs(). If
an incorrect key was passed to expandWithRefs(), or a variable was only
partially expanded with no remove processing, the cache could become
corrupted.

Move the code to getVarFlag making the data lifecycle very clear, meaning
other calls to expandWithRefs() cannot corrupt the cache.

The expand_cache reset code needs to be moved ahead of any remote data
connectors too, since the expand_cache is now on the local side of the
connection.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 50 ++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 7b2c0a8943..ecc71bd644 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -105,11 +105,7 @@ class VariableParse:
             if self.varname and key:
                 if self.varname == key:
                     raise Exception("variable %s references itself!" % self.varname)
-            if key in self.d.expand_cache:
-                varparse = self.d.expand_cache[key]
-                var = varparse.value
-            else:
-                var = self.d.getVarFlag(key, "_content")
+            var = self.d.getVarFlag(key, "_content")
             self.references.add(key)
             if var is not None:
                 return var
@@ -412,9 +408,6 @@ class DataSmart(MutableMapping):
         if not isinstance(s, str): # sanity check
             return VariableParse(varname, self, s)
 
-        if varname and varname in self.expand_cache:
-            return self.expand_cache[varname]
-
         varparse = VariableParse(varname, self)
 
         while s.find('${') != -1:
@@ -438,9 +431,6 @@ class DataSmart(MutableMapping):
 
         varparse.value = s
 
-        if varname:
-            self.expand_cache[varname] = varparse
-
         return varparse
 
     def expand(self, s, varname = None):
@@ -509,6 +499,7 @@ class DataSmart(MutableMapping):
 
     def setVar(self, var, value, **loginfo):
         #print("var=" + str(var) + "  val=" + str(value))
+        self.expand_cache = {}
         parsing=False
         if 'parsing' in loginfo:
             parsing=True
@@ -521,7 +512,7 @@ class DataSmart(MutableMapping):
 
         if 'op' not in loginfo:
             loginfo['op'] = "set"
-        self.expand_cache = {}
+
         match  = __setvar_regexp__.match(var)
         if match and match.group("keyword") in __setvar_keyword__:
             base = match.group('base')
@@ -672,6 +663,7 @@ class DataSmart(MutableMapping):
         self.setVar(var + "_prepend", value, ignore=True, parsing=True)
 
     def delVar(self, var, **loginfo):
+        self.expand_cache = {}
         if '_remote_data' in self.dict:
             connector = self.dict["_remote_data"]["_content"]
             res = connector.delVar(var)
@@ -681,7 +673,6 @@ class DataSmart(MutableMapping):
         loginfo['detail'] = ""
         loginfo['op'] = 'del'
         self.varhistory.record(**loginfo)
-        self.expand_cache = {}
         self.dict[var] = {}
         if var in self.overridedata:
             del self.overridedata[var]
@@ -704,13 +695,13 @@ class DataSmart(MutableMapping):
                          override = None
 
     def setVarFlag(self, var, flag, value, **loginfo):
+        self.expand_cache = {}
         if '_remote_data' in self.dict:
             connector = self.dict["_remote_data"]["_content"]
             res = connector.setVarFlag(var, flag, value)
             if not res:
                 return
 
-        self.expand_cache = {}
         if 'op' not in loginfo:
             loginfo['op'] = "set"
         loginfo['flag'] = flag
@@ -732,6 +723,17 @@ class DataSmart(MutableMapping):
             self.dict["__exportlist"]["_content"].add(var)
 
     def getVarFlag(self, var, flag, expand=True, noweakdefault=False, parsing=False):
+        if flag == "_content":
+            cachename = var
+        else:
+            if not flag:
+                bb.warn("Calling getVarFlag with flag unset is invalid")
+                return None
+            cachename = var + "[" + flag + "]"
+
+        if expand and cachename in self.expand_cache:
+            return self.expand_cache[cachename].value
+
         local_var, overridedata = self._findVar(var)
         value = None
         if flag == "_content" and overridedata is not None and not parsing:
@@ -796,14 +798,9 @@ class DataSmart(MutableMapping):
                 if match:
                     value = r + value
 
-        if expand and value:
-            # Only getvar (flag == _content) hits the expand cache
-            cachename = None
-            if flag == "_content":
-                cachename = var
-            else:
-                cachename = var + "[" + flag + "]"
-            value = self.expand(value, cachename)
+        if expand:
+            self.expand_cache[cachename] = self.expandWithRefs(value, cachename)
+            value = self.expand_cache[cachename].value
 
         if value and flag == "_content" and local_var is not None and "_remove" in local_var and not parsing:
             removes = []
@@ -821,20 +818,19 @@ class DataSmart(MutableMapping):
                 filtered = filter(lambda v: v not in removes,
                                   __whitespace_split__.split(value))
                 value = "".join(filtered)
-                if expand and var in self.expand_cache:
-                    # We need to ensure the expand cache has the correct value
-                    # flag == "_content" here
-                    self.expand_cache[var].value = value
+                if expand and cachename in self.expand_cache:
+                    self.expand_cache[cachename].value = value
+
         return value
 
     def delVarFlag(self, var, flag, **loginfo):
+        self.expand_cache = {}
         if '_remote_data' in self.dict:
             connector = self.dict["_remote_data"]["_content"]
             res = connector.delVarFlag(var, flag)
             if not res:
                 return
 
-        self.expand_cache = {}
         local_var, _ = self._findVar(var)
         if not local_var:
             return
-- 
2.17.1


