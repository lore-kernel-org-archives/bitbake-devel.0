Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47336C25B74
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 16:05:29 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.18182.1715875519100811498
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 May 2024 09:05:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Z+9EGMVd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so6915765f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 May 2024 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715875517; x=1716480317; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EAgbg/FwkkUyKQ1fyLm9vzx4apaMrqbdcwfSX/uQfHQ=;
        b=Z+9EGMVdHcTfNq8SjCCBGZoIVsuyJ5fMimWhowmQLK0M5XWeprGmBEuDvUdC+1e46l
         N2mw18S5TvQIoIWq8tkKoxOdnROfo/MbXEffXwVyCkBkwtOXU/Lj5B2FgSQaDHO+B1H2
         9hVOT+vttYyIsMg01crrWCbtdyc7ubFwcuW/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715875517; x=1716480317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAgbg/FwkkUyKQ1fyLm9vzx4apaMrqbdcwfSX/uQfHQ=;
        b=TFbhVauSs7+6pq9PDCajHTiC8yf7BrkX7r9dlttnzBckwHvcC0L8Q8EHd5D2CQlycN
         YDe6FddpcGPOyL0KS+bSQ5aEiyQcbNiS/oWRCetphSuE6sq+cyjwanvVlVhlCnefnEhw
         NmaYe6jmTZpRhqBIn07l0q7eTKbahjV7MbPEgJUxIZzA/S/QHOOMJ2JNeFKmmTcjWNPn
         tNL3xdy0BRtKAlulVXVKw4YmIBvEUuzYy4xfnakrR+9GycCGe6nKKn76lM1UQi8Ku1wZ
         3HfPczjAUkCL+vnJFWsw1tVNIq8mMmVkeAC1vLsyb2tWX1TYO+2/Whykv78M/+JB8jD+
         XFYg==
X-Gm-Message-State: AOJu0YzGdhJQsrj3IWGczB6MLr9I3dbZ2KM7pU0mm9JR/3MVc+l4wo40
	peoa9WTVjI9zeLeQxsIqiRx/gbIq/XOPPRda9Ho8I9bYM07kgmJatKa4+vw4CftNn9RnjndcWGI
	WKgo=
X-Google-Smtp-Source: AGHT+IGGq9hbBsVM+ANWg8U6w58lgtyxgHTKnNif1HsFMpJWkwAP8WuTJIAsEvu1uJl5S7/Al8maWA==
X-Received: by 2002:adf:f7c2:0:b0:345:663f:cd79 with SMTP id ffacd0b85a97d-3504a630fafmr14639094f8f.14.1715875517224;
        Thu, 16 May 2024 09:05:17 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:27f7:a21e:9b36:73bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a78e8sm19531288f8f.61.2024.05.16.09.05.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 09:05:16 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] parse: Improve/fix cache invalidation via mtime
Date: Thu, 16 May 2024 17:05:15 +0100
Message-Id: <20240516160515.688850-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 May 2024 16:05:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16226

We have been seeing obscure failures in devtool, particularly on newer
autobuilder workers where it appears the cache is assumed to be valid
when it shouldn't be.

We're using the 'seconds' granulation mtime field which is not really
a good way of telling if a file has changed. We can switch to the "ns"
version which is better however also add in inode number and size as
precautions. We already have all this data and tuples are fast so there
isn't really any cost to do so.

This hopefully fixes [YOCTO #15318].

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/__init__.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index a4358f1374..7ffdaa6fd7 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -49,20 +49,23 @@ class SkipPackage(SkipRecipe):
 __mtime_cache = {}
 def cached_mtime(f):
     if f not in __mtime_cache:
-        __mtime_cache[f] = os.stat(f)[stat.ST_MTIME]
+        res = os.stat(f)
+        __mtime_cache[f] = (res.st_mtime_ns, res.st_size, res.st_ino)
     return __mtime_cache[f]
 
 def cached_mtime_noerror(f):
     if f not in __mtime_cache:
         try:
-            __mtime_cache[f] = os.stat(f)[stat.ST_MTIME]
+            res = os.stat(f)
+            __mtime_cache[f] = (res.st_mtime_ns, res.st_size, res.st_ino)
         except OSError:
             return 0
     return __mtime_cache[f]
 
 def check_mtime(f, mtime):
     try:
-        current_mtime = os.stat(f)[stat.ST_MTIME]
+        res = os.stat(f)
+        current_mtime = (res.st_mtime_ns, res.st_size, res.st_ino)
         __mtime_cache[f] = current_mtime
     except OSError:
         current_mtime = 0
@@ -70,7 +73,8 @@ def check_mtime(f, mtime):
 
 def update_mtime(f):
     try:
-        __mtime_cache[f] = os.stat(f)[stat.ST_MTIME]
+        res = os.stat(f)
+        __mtime_cache[f] = (res.st_mtime_ns, res.st_size, res.st_ino)
     except OSError:
         if f in __mtime_cache:
             del __mtime_cache[f]
-- 
2.40.1


