Return-Path: <zhangqiang.zq307@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B71C88E67
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 05:12:15 +0000 (UTC)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13395.1789362730897731271
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Sep 2026 22:12:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JUcFEmGE;
 spf=pass (domain: gmail.com, ip: 74.125.228.12, mailfrom: zhangqiang.zq307@gmail.com)
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so1034489a12.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 13 Sep 2026 22:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789362730; x=1789967530; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BG5Ca5hLuzYMf0n94rBk8fU3BzYQcZZ8sUgFkKXyTKc=;
        b=JUcFEmGE32W2FaOa0Sh3z3QpqM5Rrj1jGUDLlTVijY+mf3scKr4WiXFzi4SPxK4G5f
         kAJkQ4LS8Vq5c+NFIMf0GiFVzXDJCiRVJg8lO5C9z8jjjnjIU2yKXLkfW6pti+9iTHEK
         UK1ClErkHCkQf8BeDFppmMr/yByUJKIand36Z5C2dHBSWKkUvdXZbIiIrjAZPG49u3m4
         l99V8t3+klt9FUfjXMeHy392CNMjwswqHMxkw3ajWJwexYpCiWc9hQGV9JOUI8V3UBZh
         FTHy24kfxCwEmTlaYm4KAAYIuXa+xh9Z6xgbK0or4m/qAEOue5I128OruFJ0erM8cRWd
         QNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789362730; x=1789967530;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BG5Ca5hLuzYMf0n94rBk8fU3BzYQcZZ8sUgFkKXyTKc=;
        b=d++pTfluM3z8ABPMt2ztzJVMhD8eKMC02TfFpe3QAXjIZXz0uJmRl8e0lFoIobdAEa
         RegsCuG/HNo7QuZ1Gkp7/PAkNBeBdxvpGlEUkWmbWRwd1/nj8EMmg4nZcd3I45BYjLrm
         zekrnPBrrqS5NztsAuCo3F+17pVuJkJ6z4wjqWxht54GT0KLU+HWr9BHjtmVPy485wFV
         NjQ69VvN017jdN+E8QUoZ9KTpiN9PjMSnSB5D5IEM79lKysq/V5avKfo77SO//l1AUXF
         OSJNnU0hu4aRdm0Kq0tdwnzoWN0ZzowYZY2nuWJF1ou+WwpRNu8jAvEKEmjbyzrumPEw
         sU7Q==
X-Gm-Message-State: AFuF++lKgIiX1zNqXscfefRGDXfbcEgJt8KCRdT9kATII+HwfIm+3X36
	Smp99aLmfLAy852OYXjKgJ/Jy1iJZv2yAf/ojqwfKFlak8epQSbjvk5RVRCPdtBxlEE=
X-Gm-Gg: AYBFou3FI9eL+k7xjMUJT60s9eH9MlhZRNTG72eUkkUfGz40XdBxEuSomreUsSGVnwT
	NgWWj0W6g/rqHtCYAMUppPT0Y520k4k6XSf9x0BtOTtAlvF6DARJn9mku5jP9NBtADsF3J0CPGz
	7WVY8B9tsQDs/7KujO91HBa+JlgIvpHW/QxczeKzpVlLWOSnVn3kwvqYudfoG5oORlk+usPVpd2
	+HPgrP5QeO4KpCaf8j4GgDlY05G11IRbaaaNlMsYHvpomSy5QMRDwi1Ax8t3VoABNJ8TZLerGXw
	sNk05/YDZECNY8Q/F3PZoABTkhx61Zs/76BSYNiGjZH4lqih8y8hRwABYo1Tkod5nInHeqRIX2G
	UHW6h/JB0dI/aStGefvBP1kOh3Ghd172Uo0Mpg+EGxT4RzeiaRii5j/xG2yG9YwGS/rszGzlVna
	yTqEm4yigXHXjRDqUit5y9LKi7umlXdxpDiFNLi+ksMNewmrnvKuQ85xq0RimLCl+vWyVVvMq8p
	7Do58UWPD9EpKHIm4xW2g==
X-Received: by 2002:a17:90b:5866:b0:39d:eda6:8a0b with SMTP id 98e67ed59e1d1-39deda68b98mr1758601a91.21.1789362730260;
        Sun, 13 Sep 2026 22:12:10 -0700 (PDT)
Received: from PC-203689.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95091214sm19681140a91.3.2026.09.13.22.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 22:12:09 -0700 (PDT)
From: zhangqiang.zq307@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?=E5=BC=A0=E5=BC=BA?= <zhangqiang.zq307@gmail.com>
Subject: [PATCH] fetch: Add log_errors parameter to Fetch.download()
Date: Mon, 14 Sep 2026 13:11:48 +0800
Message-Id: <20260914051148.1445323-1-zhangqiang.zq307@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 05:12:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20188

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


