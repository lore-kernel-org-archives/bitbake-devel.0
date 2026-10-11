Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28A4CA9EBD
	for <webhook@archiver.kernel.org>; Sun, 11 Oct 2026 08:49:10 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23565.1791708541320119500
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Oct 2026 01:49:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=alkHZUgB;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b0ef9c76eso782518f8f.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 11 Oct 2026 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1791708539; x=1792313339; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZjfTqqWWiJIVcIGCrQ25MXE26Zh2qK1XNIJMBDeZ3M8=;
        b=alkHZUgBtSRyZS+DqNtWUuRmuaKip79GK3pKU0d3jRSIb5RcRq8doDX8maK6b5SwDJ
         8hwPtGKPXyzPaUcH0folW7asFsH/98w3NSgcXB9/A14Hu3QPIdc9i1dP8Z84lNOVHYf2
         1CBK6UbLxz5V79fkabAOLTCSqpgnkCVfSvsrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791708539; x=1792313339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZjfTqqWWiJIVcIGCrQ25MXE26Zh2qK1XNIJMBDeZ3M8=;
        b=sm0JAf39TQ8Z5okJi4cVjw2PV8kvnDoMBzaQ71TjN6utiUWLO1Xa1HGnqp40jmQJQN
         wp8wovPox75MMjfbtyosGJVFSs5hy2s5e/3bWRQzfxZlA80+9pJ7Vmyiu/bh2QDQl1Ka
         4g8CGo3AM4VP3nBv14TLgu4Kc/gPlBdNekbLw0o/rgiuNGd7Z77yFR1ORcrgKv+0Vh97
         5o17h9ONTiQfa+6ZVnSsRbYYzX9Aibyau/ysWwFc1/qSPKhQkJ3FwrEOzXf+cBSZMsXt
         Xo1wi7TxDux7LJhjHQEETfquGNvkIW+GGAMKHuObzuCMYAcDungvKlyAUQqjBnk9VKuQ
         xtQA==
X-Gm-Message-State: AFq9FYIwr9IN8i1kmvNBiO9RYwBZhboW6Rg1AlvsmKQ+hHRPRX/NBOIs
	r58Rvy9gMiBFqPs0VwDG0X7WxpuItf/VkD1fl+x2n5sAES5BvQ7itwmjJMQo/ylIq9L6/44PX/o
	CU3TQMis=
X-Gm-Gg: AYBFou1o0MJwyWpWpACGYNkPKO5LY3fdFlJB3BGC4yxOIxTceLwF+z8j0urwFUNMcib
	gRqHg4tkT7LT8ASqrNJQVkqf7ZV25oyMCB93GI7IcRBEG23k4P/SqsKObcrdNG0VItXmVR5SPh7
	mYA8tYn/e7REMQr1hV12TgTrnyrjtLummHsgP6outwVsvWM4I/FZgXtxxL+9J5PV1fICu9vI1U7
	6TySldF1HkxGQKvfD0VP53Sbxgbn/73xsc17c+jM6GfVosvHR7a2ndUYZmYS81/WM09Vw7F1Oya
	1Qx3jbyEgzXzyp8mTdyaFssYzT75AOL7hoRbGpBpU3TEiqBomM9Q1FI0ZEyjMXjLykf7Elux6ae
	xsq5YE5cLclsMHOILMjn5jKxRkzZYFPRDkFUreRUDDv2K820HpiOtM+jRIP4xpgZm9QQjSrlJfE
	snxlqWVKSNCIUeL0HmAwd08unJleHr7KdouSXDaUwv+svclFslz98ugOH9mW3d9e7HtcRJ3ZPlx
	agM3XfTye8setvcP1S8dP+tXXSzcFjaXMxlMrkLdGPOBUjryjN1oRrq1nrkGusM7HPN0yW3Xw==
X-Received: by 2002:a05:6000:27cc:10b0:48c:7ee3:e07f with SMTP id ffacd0b85a97d-48dba9de8damr8276558f8f.37.1791708539258;
        Sun, 11 Oct 2026 01:48:59 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9aca657sm13276677f8f.43.2026.10.11.01.48.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 01:48:58 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 1/1] ast: Make PyLibNode support submodules in BBIMPORTS
Date: Sun, 11 Oct 2026 10:48:27 +0200
Message-ID: <6e260eb6ab1631607ea414d9ff8ede1155faa5d9.1791708353.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791708353.git.yoann.congal@smile.fr>
References: <cover.1791708353.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 11 Oct 2026 08:49:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20315

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

For a given `addpylib <path> <namespace>`, the existing code would
import all modules specified in `BBIMPORTS` with the assumption that
there are no submodules. This adds support for specifying submodules as
well. E.g., `BBIMPORTS = "foo.bar"` will now make `<namespace>.foo.bar`
available.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/parse/ast.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index e23ef6db3..a9cfe75c3 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -310,8 +310,9 @@ class PyLibNode(AstNode):
             bb.utils._context[self.namespace] = __import__(self.namespace)
             toimport = getattr(bb.utils._context[self.namespace], "BBIMPORTS", [])
             for i in toimport:
-                bb.utils._context[self.namespace] = __import__(self.namespace + "." + i)
-                mod = getattr(bb.utils._context[self.namespace], i)
+                mod = bb.utils._context[self.namespace] = __import__(self.namespace + "." + i)
+                for submod in i.split("."):
+                    mod = getattr(mod, submod)
                 fn = getattr(mod, "__file__")
                 funcs = {}
                 for f in dir(mod):

