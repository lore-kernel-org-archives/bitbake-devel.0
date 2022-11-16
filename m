Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E9DC43219
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 12:21:34 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web12.6565.1668601289093982062
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Nov 2022 04:21:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XWGAgLzr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id o4so29498024wrq.6
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Nov 2022 04:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkS+eDtwkMiGdREhqTt28ku6eGmFLyVh4ZfMKF/9hsM=;
        b=XWGAgLzrSh3dThA9XFkylyaKUWNRYtCvlAjKGoFtrdFebbo6z5ynNwSqqSX69yfRtJ
         BTXeU3JPHGk4Ld+P3CimpL/XbuBDDDhFgaNHW0yInKmcZTxQ+M8U+H+OwnambMfhSQQz
         n2N3lXaSTWJmJgqbYLiE7ybWTpBYz8abtxp5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkS+eDtwkMiGdREhqTt28ku6eGmFLyVh4ZfMKF/9hsM=;
        b=JvAvJYrEunDUMlfoY6Dw4txE9xzWF7QYyUFvn1MbXQJ71OujCBMojLzrpYEdmfbjzN
         zNSR+jcf1IE+aslPe9cjptkMWW+dUJQsD3NkRlyOeTAHiyEOqAxt5X3Cwke1UJ0kQTFn
         YkbJoXwDJDpVX6K6KeGBUgtkp7TeC++Iz4OdUNVMLTrj3ztchK8rNizr+J6kF8alBieE
         L6g+NF8ybgzMeoJy6F4+KC6aSShgfx5rRvOTofaG7qUnXZ396HPQYNVFGwll6Wt7+42i
         Bp2weH2QmJPGDU51VSZE8UaT7V1RZLJlMhTgTs9+bg27ElulVFNQQ/FmEFtSfs0ckyaV
         40Eg==
X-Gm-Message-State: ANoB5pmxx+VM2F7HJW0ISC9eGaSFbwDyuVM1gK1nB7azZG5EIv8HDMYl
	g5MRTGQPAyYmnLlvv7ly4oSm1MCT375LeQ==
X-Google-Smtp-Source: AA0mqf4H7/+TFQNRhm0SQ1hLaW2plWZiajjUQAN56dpxDML9clFJul5sJ5qRyF6JQwYBL/hGPTBchg==
X-Received: by 2002:a05:6000:1b09:b0:22e:5063:8f20 with SMTP id f9-20020a0560001b0900b0022e50638f20mr13240436wrz.151.1668601287138;
        Wed, 16 Nov 2022 04:21:27 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6779:84d:e47:6803])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4fc5000000b0022cd96b3ba6sm17510604wrw.90.2022.11.16.04.21.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:21:26 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] cache: Drop unused function
Date: Wed, 16 Nov 2022 12:21:25 +0000
Message-Id: <20221116122125.2564989-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116122125.2564989-1-richard.purdie@linuxfoundation.org>
References: <20221116122125.2564989-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Nov 2022 12:21:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14087

At this point users appear to all cann add_info directly. Failing
to do that means the file dependency tracking code isn't active
so would cause problems. Therefore drop the unused function.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 22ca6f56e6..22ed3e80be 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -649,18 +649,6 @@ class Cache(object):
                 self.cacheclean = False
             self.depends_cache[filename] = info_array
 
-    def add(self, file_name, data, cacheData, parsed=None):
-        """
-        Save data we need into the cache
-        """
-
-        realfn = virtualfn2realfn(file_name)[0]
-
-        info_array = []
-        for cache_class in self.caches_array:
-            info_array.append(cache_class(realfn, data))
-        self.add_info(file_name, info_array, cacheData, parsed)
-
 class MulticonfigCache(Mapping):
     def __init__(self, databuilder, data_hash, caches_array):
         def progress(p):
-- 
2.34.1


