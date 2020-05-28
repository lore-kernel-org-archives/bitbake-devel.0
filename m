Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.13156.1590675551293983233
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 07:19:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=kBu4/oSr;
 spf=pass (domain: gmail.com, ip: 209.85.128.66, mailfrom: maurofrqueiros@gmail.com)
Received: by mail-wm1-f66.google.com with SMTP id f185so2236408wmf.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2020 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zxiABiSFJE6g8mk1YKJmTkaeIZvEDmGOrtB1hOGNV/A=;
        b=kBu4/oSraKHKmes8gVpydMbuK8hp8N4T/zfDO5pARDybXXZgYSsBZRTldUjQnHOtZ9
         ovdSpMcLVWRktFJKhWZ6Z+cBC4i0ZLXxWh+IswCnxuUG3XYCPZYXWhATjbZi75tM2zhQ
         fgWS90Vww+XfVrcxm0NSLfbUmWUuGQ4dpn+XOMpRQH7vd/VMJtkDQYnMGFY9s/G+OOGk
         Ek+4DKUsGMLwBgI5jG+C8jkMIbljk3Yff86O/YJnXArjJ6r9vWOwwNvQN6t3f5qsGCdP
         v37KQiQiMo40CaQAvShT7H4XdwUN/PWluP6rKTfieJTzpcNHacq2LqQloVOlLu9E4pWk
         0jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zxiABiSFJE6g8mk1YKJmTkaeIZvEDmGOrtB1hOGNV/A=;
        b=YPb0XCsp/xqaBy578VosP4zosdeGeJ2KwphKPUnRHnRODrCL1szk8IXU+bDZ4hfP5W
         OeAOUYL13GpOtAvBlrhBeUPVQL3Lt8oty1nD6J0ETWEOZjSKynk5TJa3tkBujwQVC/hl
         PpTMmf20Y8YaeJTWyh+WlFL/mXVnxYdtTbD+6Jv7Zv5qnwVe/vP7AR+2PPWwEer2dB+g
         lblEEtTw+tyAhgm42usYgdFCNVBcAS9bY4kfApbbcOQxe++e6+wLHXEpciOsI0wbJQul
         MMEjkm7YSZtguhsFxUj2OmRxah0n1xymtCcUQWy4iV1M/zpokZ37uIK0JxfqepHd1u1m
         Q1lg==
X-Gm-Message-State: AOAM530apsqyW4ZH1X+486Vr0FIMJ1c8wA/8eNemI/ZH1Qawxgei5dR7
	ENH9c09Uuj1OYhMX48zKwlJkTuhOnxj3fA==
X-Google-Smtp-Source: ABdhPJwpqOQtmIsgaSsh3OjSACeaLu4+lPtePY8/WU13dsnVD9bi/1nNmxOFRHa7ql1BJ07fmFWJcg==
X-Received: by 2002:a1c:c2d6:: with SMTP id s205mr3872830wmf.140.1590675549607;
        Thu, 28 May 2020 07:19:09 -0700 (PDT)
Return-Path: <maurofrqueiros@gmail.com>
Received: from ctw-bre-003.criticaltechworks.com ([83.240.214.249])
        by smtp.gmail.com with ESMTPSA id q4sm6942497wma.47.2020.05.28.07.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:19:09 -0700 (PDT)
From: =?UTF-8?B?TWF1cm8gUXVlaXLDs3M=?= <maurofrqueiros@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mauro Queiros <maurofrqueiros@gmail.com>
Subject: [PATCH 2/3] git.py: LFS bitbake note should not be printed if need_lfs is not set.
Date: Thu, 28 May 2020 15:18:52 +0100
Message-Id: <20200528141853.213890-2-maurofrqueiros@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200528141853.213890-1-maurofrqueiros@gmail.com>
References: <20200528141853.213890-1-maurofrqueiros@gmail.com>

The message "Repository %s has LFS content but it is not being fetched" was
being printed, even when Git-LFS was available and "lfs=1" was set. In those
situations, we want to fetch LFS content, so that message would not make sense.

Signed-off-by: Mauro Queiros <maurofrqueiros@gmail.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4c7d388e..eab76a10 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -509,7 +509,7 @@ class Git(FetchMethod):
         if self._contains_lfs(ud, d, destdir):
             if need_lfs and not self._find_git_lfs(d):
                 raise bb.fetch2.FetchError("Repository %s has LFS content, install git-lfs on host to download (or set lfs=0 to ignore it)" % (repourl))
-            else:
+            elif not need_lfs:
                 bb.note("Repository %s has LFS content but it is not being fetched" % (repourl))
 
         if not ud.nocheckout:
-- 
2.17.1

