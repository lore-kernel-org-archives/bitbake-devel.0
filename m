Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E125C79FAA
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 07:31:14 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6473.1788939066589844387
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2026 00:31:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=DGpwz8K2;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b965570d7so62283535e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1788939065; x=1789543865; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UHP5nm6A7C2oRk+g5YH6jBWyYD2p3QINf1KMLxW4Qbc=;
        b=DGpwz8K2IVGWlPufJ6vpOlPCH62oXRFHxkMn1Xk75ak0qMyhGETVHI6h7m8I8AYPaM
         kSe220UHkyGNdyrEeWa+kpBwZ2YhqKWODs5F7xBB5xj9qk1X0my9rBjGRJjS3Q/ym+qu
         4D0SEI4r3Mp57MsgOiyh7+WleX/CbOcyejUDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939065; x=1789543865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UHP5nm6A7C2oRk+g5YH6jBWyYD2p3QINf1KMLxW4Qbc=;
        b=c6QnUVHFYYr6pq2ny/aFh2wOld/zud+CVoqL33SJf83xNvj4yakCuj+Y7DZBb0XRc8
         K5N6F35S056kuaaSXfB78iZ+5VFRLap4qHEr1f/5+9NLFU3UEUtctI5G2wYo0nN6yci/
         65n+T+DHzf0/dH2HqKmp8Ln4dUj9FEouQH4s23LDh8HIHH3dzJlOFcowRUM7WTSfG/M/
         dW9ilR1qk5cjI/0OylktMcheU6Z+paEBae1Cx1PZuCd/Nx6gq9HyiZIw+e/7yhnL9dor
         YUctuPL5YxmfnSnIntaOny57Dr6yQCfz6xD9QQuw/qv1uJcSdhPIPvRVX2FGsmKz8yOf
         URgA==
X-Gm-Message-State: AFuF++kamZlPaSszlOk6B2HOYy6jo4UrQiyGeW/qMhfdrmWjcLF0o1XF
	Pt7Geu+eGKkCFkgCd6/zXXAeWWLJuB0jVT4ki5uD5D/LPldJ+gna94S/a1JAX7pIbMYPJihjBlx
	X4EY9a44=
X-Gm-Gg: AYBFou32h9Yh02E/7pT9+9+TEK4dtDvejao6iLZ3316uQLUpPUU57zzS9FC0b/v7k2s
	2PJUyXggt7RwKvMwelEpUoWh7K1+2f5ejeUTv76EI1TvBI4CfI7yTyehgdhxBVuoX1/DybQq6UJ
	oLSsMpq7Jkc0TlGlQAF4Rf1yVQgykoVtcfqckfarjUv/BHkNtoKNv+40/06Ao6V8H3Tn/wR2KyV
	tcfo5HkvFwr05cwJCCJXRYUkSnw2344e79v0xV3Gv3qNoyuhQN7BeJZbqpuXWOPO7nv9PKM4TTV
	vavWP8fplLdrwH9HrVQ8Ozq7/tlhM2iOY4szEIXTgjsR1Np1SoRMbBH1VpOl0jXfiPk29F5z3wb
	lX49BruL7BmpVgrVRhCc3k0PRtCEvtgJksZeGeF9+BIuqBx8KVpiy5cxdumwVDTQwjRsnzPMhVg
	BdXRXWzlUnlAPbBjZEbWVQnIjASRGCGiQhKSwnWEs2HVghmy/s7jWcuZt8v5fX85EfIiRz8pIFF
	1KyhejWR2Y3lr+Gcuzb5C5YbcHSnp1+634K/ofVDLLNVhDsSejq8QQsDyx1oVYhTrvc9AjOwBw=
X-Received: by 2002:a05:600d:4447:20b0:49c:fc6e:8cbc with SMTP id 5b1f17b1804b1-49cfc6e8e40mr217289185e9.32.1788939064718;
        Wed, 09 Sep 2026 00:31:04 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm553491385e9.4.2026.09.09.00.31.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:31:04 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 2/4] fetch/gitsm: Store the original url data to fix relative gitsm paths
Date: Wed,  9 Sep 2026 09:30:58 +0200
Message-ID: <b491cd593faa4786c0b2f199e794c95d7a29c2c0.1788939009.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788939009.git.yoann.congal@smile.fr>
References: <cover.1788939009.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 07:31:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20174

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the gitsm:// url contains a git submodule with a relative "../" path
and the fetcher is configured to use a premirror, it will fail as the
host name encoded in the original url is lost and the correct paths
can't be found.

Save the original url data in the new data so that it can be consulted to
fix this kind of edge case.

The test case change that follows this provides a test of this functionality.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 58872250f72f5760b4126552bdec5497f5a1a1f4)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/__init__.py | 1 +
 lib/bb/fetch2/gitsm.py    | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e0494b3cb..b9373d2a9 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1052,6 +1052,7 @@ def build_mirroruris(origud, mirrors, ld):
                     newud = FetchData(newuri, ld)
                     newud.ignore_checksums = True
                     newud.setup_localpath(ld)
+                    newud.origud = ud
                 except bb.fetch2.BBFetchException as e:
                     logger.debug("Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
                     logger.debug(str(e))
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 5869e1b99..8b4ec6209 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -88,7 +88,10 @@ class GitSM(Git):
 
             # Convert relative to absolute uri based on parent uri
             if  uris[m].startswith('..') or uris[m].startswith('./'):
-                newud = copy.copy(ud)
+                if hasattr(ud, "origud"):
+                    newud = copy.copy(ud.origud)
+                else:
+                    newud = copy.copy(ud)
                 newud.path = os.path.normpath(os.path.join(newud.path, uris[m]))
                 uris[m] = Git._get_repo_url(self, newud)
 

