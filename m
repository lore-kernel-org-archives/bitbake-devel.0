Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4DA109193D
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 00:26:27 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2589.1773966377650126162
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Mar 2026 17:26:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=djjIKyDj;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso12940815e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 17:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773966376; x=1774571176; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeWfpN1BOXhgMYGJp29ljydYkpi1qQ860AGfSXe84Gk=;
        b=djjIKyDjvSy9IDbYTqIiJOlZ0fsc2lR+IBttlJVaxP/t/sNo6tevon+d+DDFlbvGLo
         n6c1m+iREOKde6rSPgDoqHiHjQkILkwBWuKGeT3U2060PwFtz8uuw9Jix/BfG+Lv+oRU
         mY68DnZ5NcgonwtfVGjze0jvCAei3+7wcykI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773966376; x=1774571176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DeWfpN1BOXhgMYGJp29ljydYkpi1qQ860AGfSXe84Gk=;
        b=V6dIce0YeEW3v6ESOLk5kMY43j2PYvwTx+QzdgEd9+6t0j5O7hVu46mUbwAh3y8QDq
         qFYc2IwZ/CWhSBeXABMPWMeewiehpl/YXm9Wsq76sUstz0mRXk5BopCRVA3nXLo8CBoY
         AnwbBFK5RDbX6WT9dfPg8i+/YK4KCbFz5mIuCCZmC3qSBdLIxHFgkWAs9zQJb6WHhAb0
         uZhiu2XAdAhl2vkZtnkjjhHtI4MlePMak0ZvYL+i8SsLxab9RZhc/jbNg4NrKeihGkCv
         w6Z3j3NlCoyF+6sPZKyc8/xWIHpAgoJZAPXFBdnZ3Gs5mIyj++oB4c98UpnnO+VT7SGn
         z1iA==
X-Gm-Message-State: AOJu0Yyb9vQeMa2QDTWDS0vLmKIhCTBc5BqtpivshWLiOen/kIbywv/O
	wwweZdYE+Xquwe8YKG87QtYAN6YjwlYD74lUzOchGtArSGW2hxZTLH3dBk0zQRrdKmz4HiBLCco
	jxyVk
X-Gm-Gg: ATEYQzxKq0LOlBIQiQTdFW/iwJXBdnoVKpgLYhkQhxXMd+dsJ1QYwcMzBpLRoUDPzfa
	pT4t9nMwLEMpgz267EebznzonaDpRI11lrGRiCUpoB5WdgshS/2+pqhc1EY0kWX2WjkbHWMX62k
	q2PxJNRRi5bPE0mBecmpHYCgoA8uAIhRmEexmTS3Km3oDM0FxDVUyT7ISz5+suJzRIs3jOYXxX9
	hVYW76mbnrCt2GKJtNZHP82Jg+xvNTSy0QuDBRxlf6XS3SwLnVnTp8lgcVbXMFa6jhaAa7oMV21
	UsiWSG4hsHdGCGvcTGw8A/9x6DrO9UatYmyHl48O7sF3rB596a6aIXZ6JNsJYksoKgtuvlj6sNp
	Rmz/KBbZTaHDD/S5l20uUrWlj5vK6HOZy/BuARv1QcC6YGyBUNA0+IEkwEJizPAaQ0OjoyBm2Fo
	+au9EeJrvZftGCjD1C+0pXQL8N06m/1Z1bswcbUFGX+4d2bhJQa6ZI/huCs10ukNq+3q8BPoJNg
	02XL3M2CX6TeC2VwV4NrTkH/6w=
X-Received: by 2002:a05:600c:4e02:b0:486:de04:5906 with SMTP id 5b1f17b1804b1-486ff0271a7mr14050805e9.19.1773966375592;
        Thu, 19 Mar 2026 17:26:15 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fb4309d1sm106036545e9.3.2026.03.19.17.26.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:26:14 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 3/4] fetch2: Fix incorrect lfs parametrization for submodules
Date: Fri, 20 Mar 2026 01:26:10 +0100
Message-ID: <27d4df9ce9072a066d8e32802099dd61786bf5b7.1773966318.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773966318.git.yoann.congal@smile.fr>
References: <cover.1773966318.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 00:26:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19182

From: Philip Lorenz <philip.lorenz@bmw.de>

The existing code would pass `True` or `False` to the git fetcher. As
the fetcher expects `lfs` to be set to `1` this always lead to LFS
fetching being disabled.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 5e487a5a096400271ed1e29b0df72903f2304e49)
Suggested-by: Michael Siebold <michael.siebold@gmail.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index ba62517f0..5c9899148 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -123,7 +123,7 @@ class GitSM(Git):
             url += ";name=%s" % module
             url += ";subpath=%s" % module
             url += ";nobranch=1"
-            url += ";lfs=%s" % self._need_lfs(ud)
+            url += ";lfs=%s" % ("1" if self._need_lfs(ud) else "0")
             # Note that adding "user=" here to give credentials to the
             # submodule is not supported. Since using SRC_URI to give git://
             # URL a password is not supported, one have to use one of the

