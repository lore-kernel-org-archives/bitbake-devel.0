Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E3DC43217
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 12:21:34 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.6371.1668601288742599971
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Nov 2022 04:21:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TWS07NRa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id z14so29468157wrn.7
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Nov 2022 04:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbQYkP3NwOHXzDWb+uA5nYZvNwEXbNLkSXm0gN44v9k=;
        b=TWS07NRaEzNZzXx+qPMiSljlgLxAneI7ESrnfgKEuJ9Cs6H1/zw8gUS5aOYWbI38we
         MNRPhhRmSy+g2AaS1vNGYqJ6b7mIu9KWviN0q9OCpeiL5ajnZye8ukJxMsRuVt13Tkbd
         jboE+VrLaSibh5uNKMBd++Ga/MkJM57DkeUkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbQYkP3NwOHXzDWb+uA5nYZvNwEXbNLkSXm0gN44v9k=;
        b=LhtdBQ83MCQ9WxCR2uOc/S/9CmHolKAp2JIgTtbhzpBDh7Sc4qy0Uj4dlFJOtkkTAu
         B9fEKh9BGEw0matrmZ0FzlRpalLDiDS3LOTVMvnFh2F4wzhvbhUkj2puV3UT9jL2ovmm
         HV2f2uE/7VYUXBwASwo4pCbl9INUP97CUmgOnwQlxHQuYWe1uRVfJ3Qw8XjnANnqLYuy
         2BHx6g2seIh3WY75SO/5nkP+kl92rg3B+19zIjAZPbnycEvRm1/Hl4yMpVbSYpGL1LnZ
         vZArGTtI38M6RgJI1WpEdTIuq8NMB3BmZJLSIjh4W0YEOtmHqx6lsXMFTeoh3PsNy/uk
         qhcA==
X-Gm-Message-State: ANoB5pnQe1fvnA4FCwSoPPYO7qnKfY3Sm3F0eWFDkR0Fedt1tBYstYO7
	dL6w5iS4vaq8OgjRvw8j86xUGNJHAfejEw==
X-Google-Smtp-Source: AA0mqf6a2Ojib96CoirAiQNhbEmN4AveyLHQHyjc5VsxfKCh2NJtG3u7YUy4rBIg6a76bERTs9uRqA==
X-Received: by 2002:a05:6000:12cf:b0:236:6e75:dc37 with SMTP id l15-20020a05600012cf00b002366e75dc37mr12839332wrx.504.1668601286447;
        Wed, 16 Nov 2022 04:21:26 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6779:84d:e47:6803])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4fc5000000b0022cd96b3ba6sm17510604wrw.90.2022.11.16.04.21.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:21:25 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cache: Drop broken/unused code
Date: Wed, 16 Nov 2022 12:21:24 +0000
Message-Id: <20221116122125.2564989-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Nov 2022 12:21:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14086

Some parts of functions in Cache() were broken and unused, there was
also a totally unused function. This was historical as a result of the
cooker parsing process needing to handle cached entries in the main
thread but parsing actions in seperate processes.

Document the way it works, update the function name to be clear about
what it now does and drop the old code which was unused.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py  | 54 +++++++++++++++---------------------------------
 lib/bb/cooker.py |  4 ++--
 2 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 4d715e911d..22ca6f56e6 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -280,7 +280,11 @@ def variant2virtual(realfn, variant):
         return "mc:" + elems[1] + ":" + realfn
     return "virtual:" + variant + ":" + realfn
 
-
+#
+# Cooker calls cacheValid on its recipe list, then either calls loadCached
+# from it's main thread or parse from separate processes to generate an up to
+# date cache
+#
 class Cache(object):
     """
     BitBake Cache implementation
@@ -447,43 +451,19 @@ class Cache(object):
 
         return infos
 
-    def load(self, filename, appends):
+    def loadCached(self, filename, appends):
         """Obtain the recipe information for the specified filename,
-        using cached values if available, otherwise parsing.
-
-        Note that if it does parse to obtain the info, it will not
-        automatically add the information to the cache or to your
-        CacheData.  Use the add or add_info method to do so after
-        running this, or use loadData instead."""
-        cached = self.cacheValid(filename, appends)
-        if cached:
-            infos = []
-            # info_array item is a list of [CoreRecipeInfo, XXXRecipeInfo]
-            info_array = self.depends_cache[filename]
-            for variant in info_array[0].variants:
-                virtualfn = variant2virtual(filename, variant)
-                infos.append((virtualfn, self.depends_cache[virtualfn]))
-        else:
-            return self.parse(filename, appends, configdata, self.caches_array)
-
-        return cached, infos
-
-    def loadData(self, fn, appends, cacheData):
-        """Load the recipe info for the specified filename,
-        parsing and adding to the cache if necessary, and adding
-        the recipe information to the supplied CacheData instance."""
-        skipped, virtuals = 0, 0
-
-        cached, infos = self.load(fn, appends)
-        for virtualfn, info_array in infos:
-            if info_array[0].skipped:
-                self.logger.debug("Skipping %s: %s", virtualfn, info_array[0].skipreason)
-                skipped += 1
-            else:
-                self.add_info(virtualfn, info_array, cacheData, not cached)
-                virtuals += 1
-
-        return cached, skipped, virtuals
+        using cached values.
+        """
+
+        infos = []
+        # info_array item is a list of [CoreRecipeInfo, XXXRecipeInfo]
+        info_array = self.depends_cache[filename]
+        for variant in info_array[0].variants:
+            virtualfn = variant2virtual(filename, variant)
+            infos.append((virtualfn, self.depends_cache[virtualfn]))
+
+        return infos
 
     def cacheValid(self, fn, appends):
         """
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1af29f217d..5a5ba7fb70 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2287,8 +2287,8 @@ class CookerParser(object):
 
     def load_cached(self):
         for mc, cache, filename, appends in self.fromcache:
-            cached, infos = cache.load(filename, appends)
-            yield not cached, mc, infos
+            infos = cache.loadCached(filename, appends)
+            yield False, mc, infos
 
     def parse_generator(self):
         empty = False
-- 
2.34.1


