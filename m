Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web12.9364.1603773405152054306
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Oct 2020 21:36:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=sCWkfdLd;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: maxime.roussinbelanger@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id x20so134324qkn.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Oct 2020 21:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fSRmZ9XzNKJmS3Dao6rcJeDut/jNB9RUQqvzbbjJeY=;
        b=sCWkfdLdCdtavljOLjCN05noYszxAmVsqs8QFIG9F3NuCwPMA0bwMIWf3S4nLsldNy
         XjKXk97o+sHBfHPYjTnLaCY4fuFMU5wjTrdNQ4HEmwzzxLVp8ZM5nGIZ01eBX2jNzLJ9
         gHA9ZeNb4MYhk082XKdsFWFFiBDKNTemJSNWqJ/Bc3ONKIVR+0FBFWwtgk1VAcfRh3ZH
         CLbXPO1uVXZyJtXZGQWyw8DL2sCOJrMu/XjI8TEWk/TIpCgeP0fzTELyMc0vsqlzvz1s
         DxQWizY82VR/uGoZa+u6ROVLQPglgnM7KA3D5ohBNKYj8TV7Eif5n/AdFtxDcLAUSR3W
         C6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fSRmZ9XzNKJmS3Dao6rcJeDut/jNB9RUQqvzbbjJeY=;
        b=UpiKTsmLoxN4+IgjFJJ96+JcyaA4dGx/ShExWMj12eKTp9pRVIYKPUq7LSAWR5kKln
         9JEgjqvq8p54I+rrNplxbtSP1K4yTV7Rb+W3ELOitj8zZDf4ysviXAl6A41/b5wFW4E0
         FDKDjQoJx1JeYEGE/vxXxBqisrVtTvChsMhqWQmzR6zU6XVmegeSRHwa8JNDxYmqRua5
         Ikd30KBUNSXZc7RzPTfEJC8l6/feB4i89aSU7tscILwhs5h+UlCafWHBPenIoxe4UF2o
         aE7YyK3s1N6pT3XEwoS5b6M70RNF1mnyqY2Aet+uCQZRY/blJneF7urxmVewMGK9AGg9
         /RWg==
X-Gm-Message-State: AOAM532wQo8u029TfoBRB9BdFQXV0QEVd7vrXRdknA1ny3lf3aBQijVM
	LXMH7OnuyGlBGfDQWO7znV4PJYxEqaA=
X-Google-Smtp-Source: ABdhPJwVzck/3+BT03SQQ6/jefL+7kcBF3wPkEx8NFwElYRFPJ+cjtkDS8Bondj/JWD1fKNj2bMTbQ==
X-Received: by 2002:a37:b5c4:: with SMTP id e187mr397138qkf.253.1603773403997;
        Mon, 26 Oct 2020 21:36:43 -0700 (PDT)
Return-Path: <maxime.roussinbelanger@gmail.com>
Received: from mbedesk.sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id o2sm110158qkk.121.2020.10.26.21.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 21:36:43 -0700 (PDT)
From: =?UTF-8?B?TWF4aW1lIFJvdXNzaW4tQsOpbGFuZ2Vy?= <maxime.roussinbelanger@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Subject: [PATCH 1/2] bitbake: cache: remove unused variables.
Date: Tue, 27 Oct 2020 00:36:39 -0400
Message-Id: <20201027043640.12167-1-maxime.roussinbelanger@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
---
 bitbake/lib/bb/cache.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 9e0c931a07..ebb2422496 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -449,9 +449,7 @@ class Cache(NoCache):
         return cachesize
 
     def load_cachefile(self, progress):
-        cachesize = self.cachesize()
         previous_progress = 0
-        previous_percent = 0
 
         for cache_class in self.caches_array:
             cachefile = self.getCacheFile(cache_class.cachefile)
-- 
2.28.0

