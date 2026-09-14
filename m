Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2BCC88E50
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 05:58:56 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13190.1789361855287850071
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Sep 2026 21:57:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UPKFCFCr;
 spf=pass (domain: gmail.com, ip: 209.85.210.179, mailfrom: zhangqiang.zq307@gmail.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-853e2610bb4so1964263b3a.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 13 Sep 2026 21:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789361854; x=1789966654; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BG5Ca5hLuzYMf0n94rBk8fU3BzYQcZZ8sUgFkKXyTKc=;
        b=UPKFCFCrpfTcKHMXgcKnU6Dc8+bkmtqoEV6UNLyE0WxZIVClk9j9zpGpPm43zB8LCZ
         9QSMu6eB3j41QpCEKOO04JLN6yicPEt6/bSXgXZKvJHMux2pJuXv4D3M+Q9VfSSpTwk3
         s2jQPuSvvTwGc3Srkj6hr0ecuHiemweg038liY+kFhN1INIsLKJwZ4Sp5agwn8wtSdF/
         hnRY+K0hkVhQi7mr89oanWxtDDJkvae0M9Lfbdk7rN+QkOAopxyjH6GXWPTc6exJql2H
         pmxJHizNO/jxnLewg+xyFTOnzSWEY8ApTyhjGcuv5BbQe+hCEx9i4/tHnbaCxMkdTL2N
         omWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789361854; x=1789966654;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BG5Ca5hLuzYMf0n94rBk8fU3BzYQcZZ8sUgFkKXyTKc=;
        b=jLCzZVN1s5ZfSw0O3jh6KGFt81fgUlBtyToMP/mnc2f2217KNICkZ71XxhajbL/Wxj
         4Cql0WEXrYZ/G7d2iRARyq00y34Ol1ilVKzv6efswS+HJXEVlWTcWrQ/hMXhKkhNWjr9
         18dBYgPZf7LnjcQW8WSecj8XbVw9iFAIV23LAG/S+sSYgExPW5gi0dWcmVKfm5DpfYUV
         79W4TagvtKUO/GlRBJ7KGMpd65ggGKVjyo/PKNprJx/03BqawiYEfnqPAIWZg8szofLN
         feuqqekPLmd3Bz+5VtM5XGKn7skEUbn/KVH45GTPUs4yjWEEoA6IHwr4ki99gGQWtPnU
         q+Jg==
X-Gm-Message-State: AFuF++nU1c8TWX5pKpajJqPRZyIlB9MI9ph0c/3qxO3O+HH9k2xDnZ5C
	/rEFZZk5M/QGUlqkGyPRGLNU/a0AXH5o/cNJ5mfRCu5zxVUyA5HudvsqLHdw0Sop3F4=
X-Gm-Gg: AYBFou3+EE1Wx0rf1SFADIB4snTrGn5kAcWtQoRdoLvUeX/w/wauahgOh0TyLtEyzZj
	VlCGea16qylqusJqMEzSloOgj3U4YvKu4bkvxdbp+j1PndrDCKEUEz5O3lqJ3w0odp5ggtScFRo
	Vqs7cOiAv5momretF4y6YKVyeDf7vDNzDw8aTo9QRIped1r61CbQcSvmIKBtVPHhXBAw8LnSiB4
	upQIXWOcsjqTBQUC2wLIhe9OfPZD7XEyIT5bm9ZO2PNKIS8xd3W95rNrbxJP1lrBNR+Nvxq96Tr
	E1fzx1jL1NKkZR6Y0AWpfG8jcMwesX2/6YtTYSoEfJtcYFtD9zcYgEFR+bBDgYiVipYdK0o77oL
	6J3RJ7lgy9HFGRsfThj/IZjNJhZDuE5i/q2P7SXj+aQ6uVfvf+Zf1irujCQXgkiJDkYCtoCJsr2
	EXsfufjwoU6579S79edloJgdO/umGmkwhz/XN1uyIwi6Y5Mw++rd1+b45fiQfuW3GroCqgryS9n
	NDQwOqPHDtF3u6bWpmU+A==
X-Received: by 2002:a05:6a00:1585:b0:868:6ea7:16ed with SMTP id d2e1a72fcca58-86e2c19e1dcmr5980840b3a.19.1789361854519;
        Sun, 13 Sep 2026 21:57:34 -0700 (PDT)
Received: from PC-203689.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b44e96546sm3879336b3a.37.2026.09.13.21.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 21:57:34 -0700 (PDT)
From: zhangqiang.zq307@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?=E5=BC=A0=E5=BC=BA?= <zhangqiang.zq307@gmail.com>
Subject: [PATCH] fetch: Add log_errors parameter to Fetch.download()
Date: Mon, 14 Sep 2026 12:57:08 +0800
Message-Id: <20260914045708.1440579-1-zhangqiang.zq307@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 05:58:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20190

From: 张强 <zhangqiang.zq307@gmail.com>

Fetching an sstate object from a mirror can fail transiently and is
recoverable when the caller falls back to running the real task.
The unconditional logger.error() in download() makes bitbake exit
non-zero even though every task ends up succeeding, as bitbake counts
any ERROR message towards its exit code.

Add a log_errors parameter so such callers can request the first
fetch failure to be logged at WARNING instead of ERROR. The default
(True) keeps the current behaviour for all existing callers.

Signed-off-by: 张强 <zhangqiang.zq307@gmail.com>
---
 lib/bb/fetch/__init__.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index 55ab710f3..0c3a4a7d4 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1884,9 +1884,12 @@ class Fetch(object):
 
         return local
 
-    def download(self, urls=None):
+    def download(self, urls=None, log_errors=True):
         """
         Fetch all urls
+
+        log_errors=False logs the first fetch failure at WARNING instead of
+        ERROR, for callers that treat a fetch failure as recoverable.
         """
         if not urls:
             urls = self.urls
@@ -1957,7 +1960,10 @@ class Fetch(object):
 
                 if not done or not m.done(ud, d):
                     if firsterr:
-                        logger.error(str(firsterr))
+                        if log_errors:
+                            logger.error(str(firsterr))
+                        else:
+                            logger.warning(str(firsterr))
                     raise FetchError("Unable to fetch URL from any source.", u)
 
                 m.update_donestamp(ud, d)
-- 
2.25.1


