Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB97CD4F54
	for <webhook@archiver.kernel.org>; Tue, 19 May 2026 23:34:02 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1021.1779233636907390687
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 May 2026 16:33:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=N4W6lMBH;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so24113035e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 May 2026 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779233635; x=1779838435; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z45C/w4/gVfyej+gvXcV/NidZMw0z3zx15EB5+J6FOQ=;
        b=N4W6lMBHS1DIUj94Xubp7AnKeO//QK1YaKoIKAX23QeR5Meg8qogfKwxJr8y2KmmbQ
         luwhMMMSLnho27bcAxkitPQ6WUTUPM49pKTHgVJgwxMedBuZ0WNNth3PmY3kpAhKYmcp
         2Y+QyIcvJKKNKijslA0a0Bq2DcULBsfVytYBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779233635; x=1779838435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z45C/w4/gVfyej+gvXcV/NidZMw0z3zx15EB5+J6FOQ=;
        b=pcN1QupwtGYGh56od3uI+/PGbo6Ja2nIwtnfslmt0v7mONlj10d5gpeXBL/RAiLfjY
         L0ww2N8pHPIZsjv3uW3tcl5VwIKhvG+Ojxb+vgkghX791S54UPJvjzAcnswruv92DOko
         MVLExbYpLXjXr+ndSahaUboPN7bChFxGamOqSR9TKXczEqSHqQjwsLEkcBhWQ9TqtQ02
         TwMnOmPQdnsgk5psZn7vpBXbEFXEAc1HnYurYXIxq4PxEkIlcLJ8zwMGNoqhadNTmy5R
         eMKVZXMO57UahPN+ZmmpagL0ByJwZ7d4UwwxdUyh1U2fUbgIdHQdnc/kfRouu/y+5esD
         5Qqw==
X-Gm-Message-State: AOJu0Yw98C6h4J1FjKXIoVWHEAaoTItRz55IaYIguMiJSQqRepfTngXf
	np+Gozf39ZYcIUlx698YuBfuz3nW/0c+J4Q1WKRmwCTTu6NBr00qChhTDQxLPF5LWwpuHU+ViL3
	KklcL
X-Gm-Gg: Acq92OGGGjPvXkuiuZPAv2SMzhKv9fOgcPEONq7ykifiADP5Kjd3aZlAxtDjITUMxBP
	0yIWxgWMp/uV8gfS8on7V+Xgn8Zn6pO0hG9XSU73s8htCbd4InJ99j8ta235P8a3NWe/6DZdSpd
	aBTmQoavsqHV2R6SuAwNioZb8S3/O53+M6t5hjbTgxT0Z9jrbzSRNz9nIJO1rTsM6vOM8klxNkH
	1XYgqv2dsuqqjg5+upzPlvmj1PNCfn8wcT4VwddCm2JoutR4Idlk7uZOc4rzZO4r48hnNd9EZDp
	uRb/Y0I96fg3iXdcBu59FGKvMtXQK64EkWPry/OD55T1cCYiKcAnLRdlSO1ytnOPfnAewtA3e/K
	jJAfaWLHRNzqpWojY7AT1zq+RZ61yMzuq3FRR3vOdCUd2cS4r1qseL3Hqm733nXCyzL77Rz0M2K
	SpJQGX7HCrjtCxTRwnodyg/elhqUO4y1FN1BGz3BdPQdgKVQqvNSAUtfVfbXFY79C9RRzeCiLc4
	MqgMPiZDk8mpL7s6d/lV1XprQg+8vKr8pBU0w==
X-Received: by 2002:a05:600c:46d0:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-48fe4dad784mr297974735e9.5.1779233635102;
        Tue, 19 May 2026 16:33:55 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm349517665e9.4.2026.05.19.16.33.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:33:54 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 1/3] fetch/wget: in upstream version checks, match versioned directories exactly
Date: Wed, 20 May 2026 01:33:44 +0200
Message-ID: <41393883d5e9f745b714e2ccb077c085b3c0f25b.1779233514.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779233514.git.yoann.congal@smile.fr>
References: <cover.1779233514.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 May 2026 23:34:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19544

From: Alexander Kanavin <alex@linutronix.de>

This change is in code that iterates over a html page, picking
out links to versioned subdirectories to check further for new versions.

Without the ^ and $ guards, there would be sub-string matches. This results in
querying the server multiple times for the same directory (for example,
perl check where the page contains multiple references to 5.0/something-unrelated)
or querying the server for directory that doesn't exist (nasm check, where
existence of 3.02rcX directories would result in querying the server for non-existing 3.02).

I have confirmed that the overall oe-core version check returns same results as before, with
less network churn and nasm version check working properly again.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 4af5f6a65a63bd92021d5eaa9d9ecc14f7397823)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index ca4959ab5..6ac4306c0 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -539,7 +539,7 @@ class Wget(FetchMethod):
         version_dir = ['', '', '']
         version = ['', '', '']
 
-        dirver_regex = re.compile(r"(?P<pfx>\D*)(?P<ver>(\d+[\.\-_])*(\d+))")
+        dirver_regex = re.compile(r"^(?P<pfx>\D*)(?P<ver>(\d+[\.\-_])*(\d+))$")
         s = dirver_regex.search(dirver)
         if s:
             version_dir[1] = s.group('ver')

