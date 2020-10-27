Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web08.9184.1603773408121176028
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Oct 2020 21:36:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=WXROCHGd;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: maxime.roussinbelanger@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 63so111195qva.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Oct 2020 21:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/LhItoFNTu0Jwexaexo+xyiS35TPga3MAUCGm25+NII=;
        b=WXROCHGdBSa4G/tTEfImEQNYxye9pPzOOcxrK7/c6dOAmN0oe3nn/YLdjgCSnSkG9Z
         sWDuWG+TQhvMRJAL4eCtAZHJO/PBe0QOKEGLoTQ3+fhWH0c8IUzG7RWdA6FPJmC2q1WY
         tdYkkEF7KJthBcF1JEOAY2re9dyQEGOlD2IW17odm918MRrz0l5bOqhcKU3+hORcRqOk
         h6OMqwwGZAApK2XJp64xknTM8Yr4LN2Fl7o5SQXesJHINfLTkInlAQXkhKPKbDpnPGnc
         geRnnLS+oOoPKs+prclDvrxr1UVnO4gPIeVNUvG4X42YYacFA/kHy812uh4kf/euuZqh
         nEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/LhItoFNTu0Jwexaexo+xyiS35TPga3MAUCGm25+NII=;
        b=Qmxskh79kkdLP3LGS2UkSkABNdqSGUpUuKQd2g0FpgKF+Mx6R0FeX1FUNYmjSUy0Jh
         Ud/hd9fG5p0IQvSfQ7mIzuAlnCm8MkvB4RBtD748Vx/12b67Tth8rpa84wGcCYWqPuKF
         2wJKnjUdJTm8A5sf2DLbgD2MMCXQEH1yeKwS+p8cSXGZl6kRtMype6K+55+h7TAuG0/0
         y5D5SgTG63AKSkymsvxxLyh5XELTQsA4jSyKdQk7tk1fKiZ3RYPsQS0lHQUNoDxkdqVf
         zTNCL8W++jL6ebtZbNjveMXUmgnfFnwC7wB++yu9ZFBZOctNk+/1w/SGyLWRYBXiUByt
         s8Lw==
X-Gm-Message-State: AOAM53068gpAfj5mrrhOwC3VUj/jRiE+FsfCqC7su95dN1ohGqPHyyZo
	CzyTqovBZ+E94yPNmfOQKzwjIuF4hvs=
X-Google-Smtp-Source: ABdhPJyh7l57/oOgiiPwdFevIVYa0eG4d2NMbqkCElWO+quv42E1v1yMpHVgXRdUvD9+PGlvGUhB2A==
X-Received: by 2002:a0c:9e53:: with SMTP id z19mr511138qve.23.1603773406982;
        Mon, 26 Oct 2020 21:36:46 -0700 (PDT)
Return-Path: <maxime.roussinbelanger@gmail.com>
Received: from mbedesk.sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id o2sm110158qkk.121.2020.10.26.21.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 21:36:46 -0700 (PDT)
From: =?UTF-8?B?TWF4aW1lIFJvdXNzaW4tQsOpbGFuZ2Vy?= <maxime.roussinbelanger@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Subject: [PATCH 2/2] bitbake: monitordisk: remove unused function parameter
Date: Tue, 27 Oct 2020 00:36:40 -0400
Message-Id: <20201027043640.12167-2-maxime.roussinbelanger@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027043640.12167-1-maxime.roussinbelanger@gmail.com>
References: <20201027043640.12167-1-maxime.roussinbelanger@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
---
 bitbake/lib/bb/monitordisk.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index e7c07264a8..98f2109ed2 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
@@ -59,7 +59,7 @@ def getMountedDev(path):
         pass
     return None
 
-def getDiskData(BBDirs, configuration):
+def getDiskData(BBDirs):
 
     """Prepare disk data for disk space monitor"""
 
@@ -168,7 +168,7 @@ class diskMonitor:
 
         BBDirs = configuration.getVar("BB_DISKMON_DIRS") or None
         if BBDirs:
-            self.devDict = getDiskData(BBDirs, configuration)
+            self.devDict = getDiskData(BBDirs)
             if self.devDict:
                 self.spaceInterval, self.inodeInterval = getInterval(configuration)
                 if self.spaceInterval and self.inodeInterval:
-- 
2.28.0

