Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B95AC3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 13:48:41 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.15449.1721310513836850710
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jul 2024 06:48:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=fYSK/rYh;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.181, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb1c69e936so5749995ad.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jul 2024 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1721310513; x=1721915313; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ld0zt/CSf9EJLjb6YExPdy5mJRwll5miJWZfo3I0b7U=;
        b=fYSK/rYhJ08pA8fXFLGhRKU2ax0y3K5oJ35JNhdfrggzVJH8peNNCekXTUKcSV9Rtr
         rx2hmb1DKq7Txp6M1lF0x5fDERcrYLIRzARWA7IkIRebcJRc2JkqPx5tThr9Y2Hnqkl1
         3QHdlH/wP9aS48H9ApEnsFV2Us1pWaoztoVrXjM029KJTIPqzIj0yBK1JT23+4/WQ5E/
         Mg6JC9hOWGlyF3dl8FVaF6dEpUSXbbzv04GwSRvWK8I3FHVv+xgvs0OVFWV+aX0HfmEX
         keGJtpgmDxk+slOzrcE9HAsAJlfX4//wkMvKb4HwsM5DDeEph8VtT7VYh2l3Yb5qhBQE
         DOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721310513; x=1721915313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ld0zt/CSf9EJLjb6YExPdy5mJRwll5miJWZfo3I0b7U=;
        b=UgnCPQivFYrtfihhNnvKrn9f1XkU0N2ERYCDTl+CXt31TvhIjRDHYpQdYjDQTGiR9r
         JrCdb9RVo2NaUv9ozflGKFmdjP9zyegTHtlMU5xTTf1T4omjFtWCXAiy5AveiAwH3yLD
         4khyIJIlZEQ0AFe9V5VAKNjn9XRX2YKVUWRMSvkHJXSZXjuD1zlw+51KRaiZxubfII4g
         fc0hqbGVY7Cj+pAfV+n87uItqwdwtJg7kquBmycrkSppi7M+5XKzgEIaB64BvEbZ/UWj
         +PsdyMSmLOcmGaSWA/eoq5zZxFQ5XrrOcXeGQIwH/6pjkvLccY4SYm9xu5OW/Z61d5Hl
         Bsag==
X-Gm-Message-State: AOJu0YwaWIRR9n6647nqvRSteCJAMmLO4tUy3bWzVmb/qpSZNUbBgWNH
	HkU8HPGpCYireaaCIT6nUa+qylSe7oledSw8ZR4ON8jFiSWrXCn3Psk3AawJzfl1Lx2y8j4aYEB
	f
X-Google-Smtp-Source: AGHT+IGX3Rr+TJztPEBkAmwk37igbjI4d7uB3kHq5Z3E39TWQ40lJ8J2lm7Brd8lWUQtlk+lJpsMEA==
X-Received: by 2002:a17:90a:b117:b0:2c9:6cf4:8453 with SMTP id 98e67ed59e1d1-2cb52930af9mr3670073a91.31.1721310512961;
        Thu, 18 Jul 2024 06:48:32 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77a33ee9sm671269a91.24.2024.07.18.06.48.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 06:48:32 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/2] codeparser/data: Ensure module function contents changing is accounted for
Date: Thu, 18 Jul 2024 06:48:26 -0700
Message-Id: <4bf332ccac283ca3440e81d8c781fcc23fe10b98.1721310419.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721310419.git.steve@sakoman.com>
References: <cover.1721310419.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jul 2024 13:48:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16424

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Currently, if a pylib function changes contents, the taskhash remains
unchanged since we assume the functions have stable output. This is
probably a poor assumption so take the code of the function into account
in the taskhashes. This avoids certain frustrating build failures we've
been seeing in automated testing.

To make this work we have to add an extra entry to the python code parsing
cache so that we can store the hashed function contents for efficiency as
in the python module case, that isn't used as the key to the cache.

The cache version changes since we're adding data to the cache.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b2c3438ebe62793ebabe2c282534893908d520b4)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/codeparser.py | 28 +++++++++++++++++-----------
 lib/bb/data.py       |  2 +-
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 2e8b7ced3..0b2890cf8 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -82,14 +82,14 @@ def add_module_functions(fn, functions, namespace):
             if e in functions:
                 execs.remove(e)
                 execs.add(namespace + "." + e)
-        modulecode_deps[name] = [parser.references.copy(), execs, parser.var_execs.copy(), parser.contains.copy()]
+        modulecode_deps[name] = [parser.references.copy(), execs, parser.var_execs.copy(), parser.contains.copy(), parser.extra]
         #bb.warn("%s: %s\nRefs:%s Execs: %s %s %s" % (name, fn, parser.references, parser.execs, parser.var_execs, parser.contains))
 
 def update_module_dependencies(d):
     for mod in modulecode_deps:
         excludes = set((d.getVarFlag(mod, "vardepsexclude") or "").split())
         if excludes:
-            modulecode_deps[mod] = [modulecode_deps[mod][0] - excludes, modulecode_deps[mod][1] - excludes, modulecode_deps[mod][2] - excludes, modulecode_deps[mod][3]]
+            modulecode_deps[mod] = [modulecode_deps[mod][0] - excludes, modulecode_deps[mod][1] - excludes, modulecode_deps[mod][2] - excludes, modulecode_deps[mod][3], modulecode_deps[mod][4]]
 
 # A custom getstate/setstate using tuples is actually worth 15% cachesize by
 # avoiding duplication of the attribute names!
@@ -112,21 +112,22 @@ class SetCache(object):
 codecache = SetCache()
 
 class pythonCacheLine(object):
-    def __init__(self, refs, execs, contains):
+    def __init__(self, refs, execs, contains, extra):
         self.refs = codecache.internSet(refs)
         self.execs = codecache.internSet(execs)
         self.contains = {}
         for c in contains:
             self.contains[c] = codecache.internSet(contains[c])
+        self.extra = extra
 
     def __getstate__(self):
-        return (self.refs, self.execs, self.contains)
+        return (self.refs, self.execs, self.contains, self.extra)
 
     def __setstate__(self, state):
-        (refs, execs, contains) = state
-        self.__init__(refs, execs, contains)
+        (refs, execs, contains, extra) = state
+        self.__init__(refs, execs, contains, extra)
     def __hash__(self):
-        l = (hash(self.refs), hash(self.execs))
+        l = (hash(self.refs), hash(self.execs), hash(self.extra))
         for c in sorted(self.contains.keys()):
             l = l + (c, hash(self.contains[c]))
         return hash(l)
@@ -155,7 +156,7 @@ class CodeParserCache(MultiProcessCache):
     # so that an existing cache gets invalidated. Additionally you'll need
     # to increment __cache_version__ in cache.py in order to ensure that old
     # recipe caches don't trigger "Taskhash mismatch" errors.
-    CACHE_VERSION = 11
+    CACHE_VERSION = 12
 
     def __init__(self):
         MultiProcessCache.__init__(self)
@@ -169,8 +170,8 @@ class CodeParserCache(MultiProcessCache):
         self.pythoncachelines = {}
         self.shellcachelines = {}
 
-    def newPythonCacheLine(self, refs, execs, contains):
-        cacheline = pythonCacheLine(refs, execs, contains)
+    def newPythonCacheLine(self, refs, execs, contains, extra):
+        cacheline = pythonCacheLine(refs, execs, contains, extra)
         h = hash(cacheline)
         if h in self.pythoncachelines:
             return self.pythoncachelines[h]
@@ -338,6 +339,7 @@ class PythonParser():
             self.contains = {}
             for i in codeparsercache.pythoncache[h].contains:
                 self.contains[i] = set(codeparsercache.pythoncache[h].contains[i])
+            self.extra = codeparsercache.pythoncache[h].extra
             return
 
         if h in codeparsercache.pythoncacheextras:
@@ -346,6 +348,7 @@ class PythonParser():
             self.contains = {}
             for i in codeparsercache.pythoncacheextras[h].contains:
                 self.contains[i] = set(codeparsercache.pythoncacheextras[h].contains[i])
+            self.extra = codeparsercache.pythoncacheextras[h].extra
             return
 
         if fixedhash and not node:
@@ -364,8 +367,11 @@ class PythonParser():
                 self.visit_Call(n)
 
         self.execs.update(self.var_execs)
+        self.extra = None
+        if fixedhash:
+            self.extra = bbhash(str(node))
 
-        codeparsercache.pythoncacheextras[h] = codeparsercache.newPythonCacheLine(self.references, self.execs, self.contains)
+        codeparsercache.pythoncacheextras[h] = codeparsercache.newPythonCacheLine(self.references, self.execs, self.contains, self.extra)
 
 class ShellParser():
     def __init__(self, name, log):
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 505f42950..f672a8445 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -293,7 +293,7 @@ def build_dependencies(key, keys, mod_funcs, shelldeps, varflagsexcl, ignored_va
         if key in mod_funcs:
             exclusions = set()
             moddep = bb.codeparser.modulecode_deps[key]
-            value = handle_contains("", moddep[3], exclusions, d)
+            value = handle_contains(moddep[4], moddep[3], exclusions, d)
             return frozenset((moddep[0] | keys & moddep[1]) - ignored_vars), value
 
         if key[-1] == ']':
-- 
2.34.1


