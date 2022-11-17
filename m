Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58794C433FE
	for <webhook@archiver.kernel.org>; Thu, 17 Nov 2022 15:29:34 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.19021.1668698973650117050
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Nov 2022 07:29:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=H4tYWGog;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id bs21so4432633wrb.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Nov 2022 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDAPxJhxCKkySoQH7dMKP5S43JiG7QFk+vO3o+fR/mE=;
        b=H4tYWGogYP31G10X6GO1sBVdQ2aU5GjlkDfljKW14lvuFKLXVv2OMp9MePiPezrV9g
         NBf7+neWbMkA8rUKwWI51rdSgRy7DbBTHPJt4nnWY8n5d1Rf45Cn88n0chVhx0FOJHHV
         Q/37/uH6kui0/8O3RXjL9jZ1lXi7+Dbkj9nRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDAPxJhxCKkySoQH7dMKP5S43JiG7QFk+vO3o+fR/mE=;
        b=kgb828+CpafY0SCGdnpee+gZZQMOXVYwFTIHfFwyYmN0cEPM0AxxBXqfWwhyxHMsaQ
         6Lu46gJr5dm3w3Vn1XplratKRevdiz072q7MDl8A4/MKOl1UteVwHW0ISwFerV4TueBh
         2Ntbco3nppSNO1bHQgXQuxjmm7YIaH/J69IvH8/K98AIv+RVXLqVtgNRVzMf5pVSnQnJ
         +ZCynvc3avtoZ0rAJj7HB/SDpydrZp3HwAL4BZnJ4CyZbMgKqO8tNuUYhrqwrkJ0cTGn
         UtHWOlrres0YBncOsb5LSuQjJv+NVRKZKmHVNH6mHP1z2odx6Bzfm8DWXDbDWw2vbdn1
         0Crg==
X-Gm-Message-State: ANoB5pkAsNVgakwfg4m+X8A0wm69pPaS6yXNMpN7u55WrflGcRf/IG+a
	yZf+31mH4SZ3BLFxjWXuCK+tMnA0rXC4zw==
X-Google-Smtp-Source: AA0mqf5QO+ITW1DzhGg4jGwr+COAH2rF0jBpfhehcuUB5xbX02vzFZdPonHjz4r7d4EoDDZC62EjaA==
X-Received: by 2002:adf:e7cd:0:b0:236:960f:161d with SMTP id e13-20020adfe7cd000000b00236960f161dmr1886273wrn.376.1668698971530;
        Thu, 17 Nov 2022 07:29:31 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:76d7:bdc9:5165:906c])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d604d000000b00236695ff94fsm1254306wrt.34.2022.11.17.07.29.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 07:29:31 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] cache: Drop support for not saving the cache file
Date: Thu, 17 Nov 2022 15:29:28 +0000
Message-Id: <20221117152928.2738113-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117152928.2738113-1-richard.purdie@linuxfoundation.org>
References: <20221117152928.2738113-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Nov 2022 15:29:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14090

We don't test not using the cache and I'm not aware of anyone using this, it
would be hard to with modern bitbake.

Drop the conditional code and simply error if CACHE isn't set.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 22ed3e80be..cb6cf21727 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -309,20 +309,12 @@ class Cache(object):
         self.filelist_regex = re.compile(r'(?:(?<=:True)|(?<=:False))\s+')
 
         if self.cachedir in [None, '']:
-            self.has_cache = False
-            self.logger.info("Not using a cache. "
-                             "Set CACHE = <directory> to enable.")
-            return
-
-        self.has_cache = True
+            bb.fatal("Please ensure CACHE is set to the cache directory for BitBake to use")
 
     def getCacheFile(self, cachefile):
         return getCacheFile(self.cachedir, cachefile, self.mc, self.data_hash)
 
     def prepare_cache(self, progress):
-        if not self.has_cache:
-            return 0
-
         loaded = 0
 
         self.cachefile = self.getCacheFile("bb_cache.dat")
@@ -361,9 +353,6 @@ class Cache(object):
         return loaded
 
     def cachesize(self):
-        if not self.has_cache:
-            return 0
-
         cachesize = 0
         for cache_class in self.caches_array:
             cachefile = self.getCacheFile(cache_class.cachefile)
@@ -472,10 +461,6 @@ class Cache(object):
         """
         if fn not in self.checked:
             self.cacheValidUpdate(fn, appends)
-
-        # Is cache enabled?
-        if not self.has_cache:
-            return False
         if fn in self.clean:
             return True
         return False
@@ -485,10 +470,6 @@ class Cache(object):
         Is the cache valid for fn?
         Make thorough (slower) checks including timestamps.
         """
-        # Is cache enabled?
-        if not self.has_cache:
-            return False
-
         self.checked.add(fn)
 
         # File isn't in depends_cache
@@ -595,10 +576,6 @@ class Cache(object):
         Save the cache
         Called from the parser when complete (or exiting)
         """
-
-        if not self.has_cache:
-            return
-
         if self.cacheclean:
             self.logger.debug2("Cache is clean, not saving.")
             return
@@ -641,9 +618,6 @@ class Cache(object):
             if watcher:
                 watcher(info_array[0].file_depends)
 
-        if not self.has_cache:
-            return
-
         if (info_array[0].skipped or 'SRCREVINACTION' not in info_array[0].pv) and not info_array[0].nocache:
             if parsed:
                 self.cacheclean = False
-- 
2.34.1


