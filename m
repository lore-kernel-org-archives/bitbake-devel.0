Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7571BC4332F
	for <webhook@archiver.kernel.org>; Tue, 20 Dec 2022 10:07:22 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.46881.1671530832745651702
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Dec 2022 02:07:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RaEnpVUD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso10683621wme.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 02:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YB+IHnf1pFgovCffrOvmp/xRNs5bRr6eQofVWU0cvyE=;
        b=RaEnpVUDn0bRqexAeNl3We+Zo+CVXpBgCuw0VAhApfed1QmqO6vJq7MTDTsH/uIYU5
         xrRy78lgfXIg2gQg7XkqUYCs2lK5Zk9Un+hSj0tlXxfODNsyQVRdjgu9dNHLZgEyPdYt
         EZpMwuWkMRTRf4GgwcSioG0k10LcepR66LbLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YB+IHnf1pFgovCffrOvmp/xRNs5bRr6eQofVWU0cvyE=;
        b=SBm0Vhk42UgovOgoLWASBOFPpg4J5auq7xHSAkEj795QrwIHc7ucrB5MguJPB5zjsu
         GDMCoYxG375d34FLbCT1IjUFZvWMK/sDGbHf7pysEFPhR7tCkaYXwR9lWlwnpiFvU69h
         JV0wXt4jpQS9AL5UhO4LIQUFouauxlNMyhaUYYOh01aRmBlT8QCpwdT2CaMOmX3kHgmB
         BOUZ6xqLtTuRXCAg2K4iTcHOinsGr7Tji70U5yrlkSj+Z1HeU3VJslXqC74sN2QBxjmb
         GsgJG1rrXAI/81tmxza/DUem4Yjcv6rgEN1mDQmf8+VOjPAaapm4JU9fEIcQaV6TRZO8
         vrkQ==
X-Gm-Message-State: ANoB5pljGZNF8ypQNbMqI4O1w9uh5R+FdpAGjvTZ1JsZ+NbhqP7Fup21
	zpHFfdLMcHdjPEMDAgd5QUfctwu7BUv35NxI
X-Google-Smtp-Source: AA0mqf6lyTcEdo0NCXl7chuqt03sxSrV1tGpcoCPiExlWsL0xbbXVrMmnGh8tC3WsSnx+HBsmKcp+A==
X-Received: by 2002:a05:600c:3d8f:b0:3cf:a18d:399c with SMTP id bi15-20020a05600c3d8f00b003cfa18d399cmr35228616wmb.1.1671530831067;
        Tue, 20 Dec 2022 02:07:11 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1273:dbb7:632c:a9de])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c1d1300b003cf75213bb9sm25464052wms.8.2022.12.20.02.07.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 02:07:10 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] cache: Allow compression of the data in SiggenRecipeInfo
Date: Tue, 20 Dec 2022 10:07:09 +0000
Message-Id: <20221220100709.402769-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221220100709.402769-1-richard.purdie@linuxfoundation.org>
References: <20221220100709.402769-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 10:07:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14208

The data in SiggenRecipeInfo is large and has a lot of duplication. The size
causes a few problems, impacting:

 - bitbake's overall memory usage
 - the amount of data sent over IPC between parsing processes and the server
 - the size of the cache files on disk
 - the size of "sigdata" hash information files on disk

The data consists of strings (some large) or frozenset lists of variables.
To reduce the impact we can:

a) deplicate the data
b) pass references to the object on the second usage
   (e.g. over IPC or saving into pickle).

This patch does this for SiggenRecipeInfo mostly behind the scenes
but we do need a couple of reset points so that streamed data is written
correctly on the second usage.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py  | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/cooker.py |  1 +
 2 files changed, 76 insertions(+)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 96ab069180..f5b527ba6a 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -263,6 +263,80 @@ class SiggenRecipeInfo(RecipeInfoCommon):
         cachedata.siggen_varvals[fn] = self.siggen_varvals
         cachedata.siggen_taskdeps[fn] = self.siggen_taskdeps
 
+    # The siggen variable data is large and impacts:
+    #  - bitbake's overall memory usage
+    #  - the amount of data sent over IPC between parsing processes and the server
+    #  - the size of the cache files on disk
+    #  - the size of "sigdata" hash information files on disk
+    # The data consists of strings (some large) or frozenset lists of variables
+    # As such, we a) deplicate the data here and b) pass references to the object at second
+    # access (e.g. over IPC or saving into pickle).
+
+    store = {}
+    save_map = {}
+    save_count = 1
+    restore_map = {}
+    restore_count = {}
+
+    @classmethod
+    def reset(cls):
+        # Needs to be called before starting new streamed data in a given process 
+        # (e.g. writing out the cache again)
+        cls.save_map = {}
+        cls.save_count = 1
+        cls.restore_map = {}
+        cls.restore_count = {}
+
+    @classmethod
+    def _save(cls, deps):
+        ret = []
+        if not deps:
+            return deps
+        for dep in deps:
+            fs = deps[dep]
+            if fs in cls.save_map:
+                ret.append((dep, None, cls.save_map[fs]))
+            else:
+                cls.save_map[fs] = cls.save_count
+                ret.append((dep, fs, None))
+                cls.save_count = cls.save_count + 1
+        return ret
+
+    @classmethod
+    def _restore(cls, deps, pid):
+        ret = {}
+        if not deps:
+            return deps
+        if pid not in cls.restore_map:
+            cls.restore_map[pid] = {}
+            cls.restore_count[pid] = 1
+        map = cls.restore_map[pid]
+        for fs, dep, mapnum in deps:
+            if mapnum:
+                ret[dep] = map[mapnum]
+            else:
+                try:
+                    fs = cls.store[fs]
+                except KeyError:
+                    cls.store[fs] = fs
+                map[cls.restore_count[pid]] = fs
+                cls.restore_count[pid] = cls.restore_count[pid] + 1
+                ret[dep] = fs
+        return ret
+
+    def __getstate__(self):
+        ret = {}
+        for key in ["siggen_gendeps", "siggen_taskdeps", "siggen_varvals"]:
+            ret[key] = self._save(self.__dict__[key])
+        ret['pid'] = os.getpid()
+        return ret
+
+    def __setstate__(self, state):
+        pid = state['pid']
+        for key in ["siggen_gendeps", "siggen_taskdeps", "siggen_varvals"]:
+            setattr(self, key, self._restore(state[key], pid))
+
+
 def virtualfn2realfn(virtualfn):
     """
     Convert a virtual file name to a real one + the associated subclass keyword
@@ -621,6 +695,7 @@ class Cache(object):
                             p.dump(info)
 
         del self.depends_cache
+        SiggenRecipeInfo.reset()
 
     @staticmethod
     def mtime(cachefile):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d96afcc669..48c3002ce3 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2263,6 +2263,7 @@ class CookerParser(object):
 
 
         bb.codeparser.parser_cache_savemerge()
+        bb.cache.SiggenRecipeInfo.reset()
         bb.fetch.fetcher_parse_done()
         if self.cooker.configuration.profile:
             profiles = []
-- 
2.37.2


