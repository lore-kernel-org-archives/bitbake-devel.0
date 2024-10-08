Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE08CEF16B
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 12:36:41 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.8082.1728390992228153475
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 05:36:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FeyXEkyu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so49035055e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728390990; x=1728995790; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAKcmVglXg2xDwPEWF78KIe3J10S7NGW5+tqJS5IPG0=;
        b=FeyXEkyunw1c9QzUZZHaA+OCVgxgW9lkoWy0uVJgDHPo57JBXWeKAtUFDxfX7gowdO
         hXJ8bheVwiJgG0/YfH6o2+XxmABVDKd9X4LR1hGnUJ0W6wCCDb/OtqGfJSRJDNEYlV2C
         QdLV46yBh1qH5ofHzBMnlePj1VB31Mro+lz9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390990; x=1728995790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAKcmVglXg2xDwPEWF78KIe3J10S7NGW5+tqJS5IPG0=;
        b=pyWzoLRSxsaer/fvTSi+syWyMcemkpEP14be9KE0mnZuABYOje7UovVFUxMH5u0pm2
         GAHcH1kSGcE+ksduUsnjCL9gI+dyZtU8+9cSOciDQln1x68/64CNLHwjlguB61jGvdTl
         jXx5oB285qDP1jTtQkq5otsmd2sJM8z3xq7ghAKlHXIxge5pm97NRMYLAb2WuaixCQSp
         BSksMrLz5V5P0qZhzkKqAJLd6w+4PKQLgYseBNjow24uCH9ktUQ7O2DmLy20MHJfp1ET
         8i5ibCby+A0cVjtu4g9t7HtnfYqyqNXsU5PoGS4yEthK4LAwmLDCqxZyys1xbadublnT
         PXuA==
X-Gm-Message-State: AOJu0Yx0TZtvPzr59F0RbIZXKMuE14ymyrTeNN8Mwp/ZdmwCJqtOj/Ao
	UL4H+HbRlnKK/vm0OzyxxTbLSvtjT4drL8G522pUCeMe1IwC0kwd/59Lr4v82+anc8NWWZzzEeh
	d
X-Google-Smtp-Source: AGHT+IF0sIqYS3Xq0GQ8w1QAhzYtICbWbSgnvVGsmCwg4RsXWxTOK+hmQy5vrI6+UICl/xy+dCFu7A==
X-Received: by 2002:a05:600c:b8d:b0:42f:7639:d88d with SMTP id 5b1f17b1804b1-42f85af56f9mr88024905e9.35.1728390990227;
        Tue, 08 Oct 2024 05:36:30 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f9a:5ae5:8636:3d57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a47esm8019492f8f.28.2024.10.08.05.36.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:36:29 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/8] checksum/fetch2: Switch from persist_data to a standard cache file
Date: Tue,  8 Oct 2024 13:36:22 +0100
Message-ID: <20241008123627.252307-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 12:36:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16656

The sqlite connection handling is causing problems with python 3.13. The
connection can be closed at gc time which causing warnings and those
can appear at 'random' points and break output, causing weird failures
in different tinfoil tools and other tests.

Using sqlite as an IPC was never a great idea so drop that usage entirely
and just use the standard cache mechanism we already have for other
situations.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py           | 10 ++++++++++
 lib/bb/checksum.py        | 25 +++++++++++++++++++++++++
 lib/bb/cookerdata.py      |  5 +++--
 lib/bb/fetch2/__init__.py | 33 ++++++++++++++++++++-------------
 4 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 958652e0e3..ec7b023fc7 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -847,6 +847,16 @@ class MultiProcessCache(object):
         data = [{}]
         return data
 
+    def clear_cache(self):
+        if not self.cachefile:
+            bb.fatal("Can't clear invalid cachefile")
+
+        self.cachedata = self.create_cachedata()
+        self.cachedata_extras = self.create_cachedata()
+        with bb.utils.fileslocked([self.cachefile + ".lock"]):
+            bb.utils.remove(self.cachefile)
+            bb.utils.remove(self.cachefile + "-*")
+
     def save_extras(self):
         if not self.cachefile:
             return
diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 557793d366..3fb39a303e 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -142,3 +142,28 @@ class FileChecksumCache(MultiProcessCache):
 
         checksums.sort(key=operator.itemgetter(1))
         return checksums
+
+class RevisionsCache(MultiProcessCache):
+    cache_file_name = "local_srcrevisions.dat"
+    CACHE_VERSION = 1
+
+    def __init__(self):
+        MultiProcessCache.__init__(self)
+
+    def get_revs(self):
+        return self.cachedata[0]
+
+    def get_rev(self, k):
+        if k in self.cachedata_extras[0]:
+            return self.cachedata_extras[0][k]
+        if k in self.cachedata[0]:
+            return self.cachedata[0][k]
+        return None
+
+    def set_rev(self, k, v):
+        self.cachedata[0][k] = v
+        self.cachedata_extras[0][k] = v
+
+    def merge_data(self, source, dest):
+        for h in source[0]:
+            dest[0][h] = source[0][h]
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 3ad5cf3dd0..1f447d30c2 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -1,3 +1,4 @@
+
 #
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
@@ -267,8 +268,8 @@ class CookerDataBuilder(object):
         try:
             self.data = self.parseConfigurationFiles(self.prefiles, self.postfiles)
 
-            if self.data.getVar("BB_WORKERCONTEXT", False) is None and not worker:
-                bb.fetch.fetcher_init(self.data)
+            servercontext = self.data.getVar("BB_WORKERCONTEXT", False) is None and not worker
+            bb.fetch.fetcher_init(self.data, servercontext)
             bb.parse.init_parser(self.data)
 
             bb.event.fire(bb.event.ConfigParsed(), self.data)
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b194a79be9..add742bfad 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -23,13 +23,14 @@ import collections
 import subprocess
 import pickle
 import errno
-import bb.persist_data, bb.utils
+import bb.utils
 import bb.checksum
 import bb.process
 import bb.event
 
 __version__ = "2"
 _checksum_cache = bb.checksum.FileChecksumCache()
+_revisions_cache = bb.checksum.RevisionsCache()
 
 logger = logging.getLogger("BitBake.Fetcher")
 
@@ -493,18 +494,23 @@ methods = []
 urldata_cache = {}
 saved_headrevs = {}
 
-def fetcher_init(d):
+def fetcher_init(d, servercontext=True):
     """
     Called to initialize the fetchers once the configuration data is known.
     Calls before this must not hit the cache.
     """
 
-    revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
+    _checksum_cache.init_cache(d.getVar("BB_CACHEDIR"))
+    _revisions_cache.init_cache(d.getVar("BB_CACHEDIR"))
+
+    if not servercontext:
+        return
+
     try:
         # fetcher_init is called multiple times, so make sure we only save the
         # revs the first time it is called.
         if not bb.fetch2.saved_headrevs:
-            bb.fetch2.saved_headrevs = dict(revs)
+            bb.fetch2.saved_headrevs = _revisions_cache.get_revs()
     except:
         pass
 
@@ -514,11 +520,10 @@ def fetcher_init(d):
         logger.debug("Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
     elif srcrev_policy == "clear":
         logger.debug("Clearing SRCREV cache due to cache policy of: %s", srcrev_policy)
-        revs.clear()
+        _revisions_cache.clear_cache()
     else:
         raise FetchError("Invalid SRCREV cache policy of: %s" % srcrev_policy)
 
-    _checksum_cache.init_cache(d.getVar("BB_CACHEDIR"))
 
     for m in methods:
         if hasattr(m, "init"):
@@ -526,9 +531,11 @@ def fetcher_init(d):
 
 def fetcher_parse_save():
     _checksum_cache.save_extras()
+    _revisions_cache.save_extras()
 
 def fetcher_parse_done():
     _checksum_cache.save_merge()
+    _revisions_cache.save_merge()
 
 def fetcher_compare_revisions(d):
     """
@@ -536,7 +543,7 @@ def fetcher_compare_revisions(d):
     when bitbake was started and return true if they have changed.
     """
 
-    headrevs = dict(bb.persist_data.persist('BB_URI_HEADREVS', d))
+    headrevs = _revisions_cache.get_revs()
     return headrevs != bb.fetch2.saved_headrevs
 
 def mirror_from_string(data):
@@ -1662,13 +1669,13 @@ class FetchMethod(object):
         if not hasattr(self, "_latest_revision"):
             raise ParameterError("The fetcher for this URL does not support _latest_revision", ud.url)
 
-        revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
         key = self.generate_revision_key(ud, d, name)
-        try:
-            return revs[key]
-        except KeyError:
-            revs[key] = rev = self._latest_revision(ud, d, name)
-            return rev
+
+        rev = _revisions_cache.get_rev(key)
+        if rev is None:
+            rev = self._latest_revision(ud, d, name)
+            _revisions_cache.set_rev(key, rev)
+        return rev
 
     def sortable_revision(self, ud, d, name):
         latest_rev = self._build_revision(ud, d, name)

