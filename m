Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D641DC52D11
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 17:24:34 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.79994.1674753870449273750
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 09:24:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UTtd2pSo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso3678202wmn.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 09:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kycU9REhlsC6MyuottgoA8G/AS9abZ9cxtmetu8B+0=;
        b=UTtd2pSobcYE0EFIRVZ82GEJuFvTfZXeglhyOadCp8uRARkzL3NpK/wGz27eSLmpcK
         4q6duW5NFAoMXLk8v6dU0IMos4VEf2gK9uA2IY0jBm63YSzgTPp1JNx84mioJnwgOb1i
         Gx1E1OEXrRW242OUrYluw37P/Ma6jMhAEfsf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kycU9REhlsC6MyuottgoA8G/AS9abZ9cxtmetu8B+0=;
        b=JDEJHNDUPZvB9PtQmtSVTbHEHPtzpk/4GohWWcW4eySkUqG1IYOJH2zfw2II44i5XX
         3/4/OCF3fYjpZ6B4i7NNDl7/FEdJShhuZWJ56KNKDh1EJEfm1/vAVAagyPMA9eTEih00
         JA5mFhJ1K16IOGA5wcrJKX39IJFPSd43MOkPm/sUp1YD7/nG52VyOeWxGpnUZvKF/+Jq
         VoLRoDVh4ea/sOKHriXRtSQDnvC0vdlH27jvcIpS+y5EEkyDEogzswh57j9w/t9KKh76
         984plnHc/Z0n0FDV/zY0TNXyDtxz/8uRMNL2KS8dHOl09JqOlqdeL7pJRWn9wKfzumJ9
         2lhg==
X-Gm-Message-State: AFqh2kqecsxm+Kw/vdJMO+wOpTjgr9GP2rLEbG349EiO6owl2ehvRF9J
	hPsYGk0vRqCjep24TSBRuj4le0tZoiWMrsFX
X-Google-Smtp-Source: AMrXdXutBFEsNKI1hWUOtdbhJhqfCMZx/KSl6DLnjQpG0mY1y/4wyEOl3hZ3B42x7TjfBPSLknQPyg==
X-Received: by 2002:a05:600c:1d8a:b0:3db:f0a:cfa1 with SMTP id p10-20020a05600c1d8a00b003db0f0acfa1mr32862938wms.9.1674753868682;
        Thu, 26 Jan 2023 09:24:28 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:f2d7:e330:f537:35d8])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003dc1300eab0sm5958336wmq.33.2023.01.26.09.24.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:24:28 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cache/codeparser: Switch to a new BB_CACHEDIR variable for cache location
Date: Thu, 26 Jan 2023 17:24:27 +0000
Message-Id: <20230126172427.2528212-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 17:24:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14354

Currently the codeparser cache is set from CACHE, which is typically in
bitbake.conf which means we can't read/write any cache until it is found/read.
We may well have python expressions to parse before that happens.
The net result is suboptimal functioning of the codeparser cache since it will
often be invalidated by data that is never written.

This patch changes the codeparser and filechecksum caches to use BB_CACHE as
their setting and defaults it to ${TOPDIR}/cache.

The patch doesn't change where the "persistent" data such as prserver and
hash-equiavalance resides (PERSISTENT_DIR) or where the metadata parsing
cache resists (still currently CACHE). I've left those for a later patch.

The patch does ensure data parsed by the core datastore parsing calls is
written back since this is now much more useful after this change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py           | 7 +++----
 lib/bb/codeparser.py      | 8 ++++----
 lib/bb/cooker.py          | 2 +-
 lib/bb/cookerdata.py      | 9 ++++++++-
 lib/bb/fetch2/__init__.py | 2 +-
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 8db4e47674..b309775bb9 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -838,11 +838,10 @@ class MultiProcessCache(object):
         self.cachedata = self.create_cachedata()
         self.cachedata_extras = self.create_cachedata()
 
-    def init_cache(self, d, cache_file_name=None):
-        cachedir = (d.getVar("PERSISTENT_DIR") or
-                    d.getVar("CACHE"))
-        if cachedir in [None, '']:
+    def init_cache(self, cachedir, cache_file_name=None):
+        if not cachedir:
             return
+
         bb.utils.mkdirhier(cachedir)
         self.cachefile = os.path.join(cachedir,
                                       cache_file_name or self.__class__.cache_file_name)
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index ecae7b0808..d6b8102585 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -184,12 +184,12 @@ class CodeParserCache(MultiProcessCache):
         self.shellcachelines[h] = cacheline
         return cacheline
 
-    def init_cache(self, d):
+    def init_cache(self, cachedir):
         # Check if we already have the caches
         if self.pythoncache:
             return
 
-        MultiProcessCache.init_cache(self, d)
+        MultiProcessCache.init_cache(self, cachedir)
 
         # cachedata gets re-assigned in the parent
         self.pythoncache = self.cachedata[0]
@@ -201,8 +201,8 @@ class CodeParserCache(MultiProcessCache):
 
 codeparsercache = CodeParserCache()
 
-def parser_cache_init(d):
-    codeparsercache.init_cache(d)
+def parser_cache_init(cachedir):
+    codeparsercache.init_cache(cachedir)
 
 def parser_cache_save():
     codeparsercache.save_extras()
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 527f6a0421..042cec71ae 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2271,7 +2271,7 @@ class CookerParser(object):
             if hasattr(process, "close"):
                 process.close()
 
-
+        bb.codeparser.parser_cache_save()
         bb.codeparser.parser_cache_savemerge()
         bb.cache.SiggenRecipeInfo.reset()
         bb.fetch.fetcher_parse_done()
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index c6b5658d75..1658bee93c 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -271,7 +271,6 @@ class CookerDataBuilder(object):
             if self.data.getVar("BB_WORKERCONTEXT", False) is None and not worker:
                 bb.fetch.fetcher_init(self.data)
             bb.parse.init_parser(self.data)
-            bb.codeparser.parser_cache_init(self.data)
 
             bb.event.fire(bb.event.ConfigParsed(), self.data)
 
@@ -370,6 +369,11 @@ class CookerDataBuilder(object):
             data.setVar("TOPDIR", os.path.dirname(os.path.dirname(layerconf)))
             data = parse_config_file(layerconf, data)
 
+            if not data.getVar("BB_CACHEDIR"):
+                data.setVar("BB_CACHEDIR", "${TOPDIR}/cache")
+
+            bb.codeparser.parser_cache_init(data.getVar("BB_CACHEDIR"))
+
             layers = (data.getVar('BBLAYERS') or "").split()
             broken_layers = []
 
@@ -473,6 +477,9 @@ class CookerDataBuilder(object):
 
         if not data.getVar("TOPDIR"):
             data.setVar("TOPDIR", os.path.abspath(os.getcwd()))
+        if not data.getVar("BB_CACHEDIR"):
+            data.setVar("BB_CACHEDIR", "${TOPDIR}/cache")
+        bb.codeparser.parser_cache_init(data.getVar("BB_CACHEDIR"))
 
         data = parse_config_file(os.path.join("conf", "bitbake.conf"), data)
 
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b1cd6b25c2..5a7a6024d1 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -518,7 +518,7 @@ def fetcher_init(d):
     else:
         raise FetchError("Invalid SRCREV cache policy of: %s" % srcrev_policy)
 
-    _checksum_cache.init_cache(d)
+    _checksum_cache.init_cache(d.getVar("BB_CACHEDIR"))
 
     for m in methods:
         if hasattr(m, "init"):
-- 
2.37.2


