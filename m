Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74D4D767E2
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 11:36:38 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15009.1766144188157710000
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 03:36:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=2juqyyJK;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so11671715e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 03:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766144186; x=1766748986; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QYEFXynZ6z2giDTXuSACF5RTGmP+FMi5dV2Dcg+oGY=;
        b=2juqyyJKA4wmKBb5l4cl5uMxL1MfGplZk87dMQGeRXe61i+Z7pDO8fCAGiykryt5UF
         za8Co7nI7K3zqDxkNH9Afd1t2dm3x7n+nEmWQRlVCwWh4ACWOjB31XCqpIyeco1PbWXV
         r8lSdoGIkdg5RzVMOC77wCwG/LIai8AxbfcRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766144186; x=1766748986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QYEFXynZ6z2giDTXuSACF5RTGmP+FMi5dV2Dcg+oGY=;
        b=prY5Pl2nIJIOKEYG/17SxW7AJCtcez16N24OWuJ5FG0R3TuTbU86lq1YLw3WEtdCRx
         tv3wJC+++O7dGtZ+YuXXQdTtaXe4MOkEgsPdIJq8LOeCDw0hBAioZCSJVqfYmSL5tf3g
         2M8ldTtJhcEHEoP0OguqN9hx2bvMLpCQRUIC7kPm1fK61na78xVlRV3liqPTVfiL/K6/
         rSq7pBEqx3N4/wm7rUIQ4G9Ol0WN+ay1oGocclG3A+mDFb0HeuAk2jzbNtiEU+Pt+++X
         54TUa8jflqGnUdF8m9V9l9SWX4y3Cph76s/kqk1lrDrSvQ5am4AQb3ZnGVHnaAmtsKtZ
         leGw==
X-Gm-Message-State: AOJu0YyQTfOC2GYeGjPCtviHRx64UwvnmEAr5FMQOvvVgN7ZYh9+I74p
	8xwA+c3pgaIazdI9uQ8Jh6CambcOnSxpkIGYywTpCyE9wKlts6LMVxplrSv6ShXr1RMb6rgdhgQ
	aS65oWE0=
X-Gm-Gg: AY/fxX72TuRCQM+I7hjw7W0NeAGPyypVGtbmA0wbnHspOlnM/pikStbSZuR0a9fW3vH
	l0BfI8IjZB5a9etA5UwILFr5um11JRs1xCYERdBbd37F8Zl4k5K1WIO8bGL2AsGkZ+9Tj1c2Bb+
	LlufdyOgjVt35shRiogeeWv9Biu2xnc0lxxQJ48DM5mBDcgo5NGsVerfLlU4OIAJFeMtkLrdXSN
	ZY5Htg0yQwINNn3zUlJE3xFi952+sksfX3Oip4DhVAPp53wegg/4IopunncVi2p/YqvGJxYo/1D
	XVwf3BnaHVP531bzdyebc0uEBg+aVcwdPb7s2sXMH/4eTEEMKH+X9raEiDIgBYHOL574EO8GAzN
	qa98tPeGIjVuJVizt4VrfhG90edKL7EgOPlP+Tmd490TUdNw1URmVMXGs7yixdiQ4azLFQE7Arv
	O6HCubrgi2wqZ0m1rvYUIRHqoG4e6729JSOf8iy5nvw9yMiVM8tpC2+V3XIpU8bEkjnkxpmTVkA
	X0jT9rAPB54x3dPE18=
X-Google-Smtp-Source: AGHT+IGfsiXE8mDYRSVvA3nYCIATQbgmX3flWCUagpiMjXnqRcrKJiPgybk6DK42F9PBB5aZaF7m7g==
X-Received: by 2002:a05:6000:24c8:b0:431:808:2d58 with SMTP id ffacd0b85a97d-4324e50d219mr2883519f8f.51.1766144186585;
        Fri, 19 Dec 2025 03:36:26 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aee5sm4549810f8f.4.2025.12.19.03.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 03:36:26 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v3 2/2] meta/files/layers.schema.json: use URI shortcut for some remotes
Date: Fri, 19 Dec 2025 12:36:15 +0100
Message-ID: <20251219113615.1573842-2-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219113615.1573842-1-corentin.guillevic@smile.fr>
References: <20251219113615.1573842-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 11:36:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18615

Among the three sources, only two have a single remote. So we can replace
their entire structure 'remote' -> 'origin' -> 'uri' with a shorter one
(property 'uri' only).

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 meta/files/layers.example.json | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/meta/files/layers.example.json b/meta/files/layers.example.json
index f3b6522083..d990502205 100644
--- a/meta/files/layers.example.json
+++ b/meta/files/layers.example.json
@@ -5,11 +5,7 @@
             "git-remote": {
                 "branch": "master",
                 "describe": "",
-                "remotes": {
-                    "remote-alex": {
-                        "uri": "https://github.com/kanavin/meta-alex"
-                    }
-                },
+                "uri": "https://github.com/kanavin/meta-alex",
                 "rev": "05b25605fb8b2399e4706d7323828676bf0da0b5"
             },
             "path": "meta-alex"
@@ -18,11 +14,7 @@
             "git-remote": {
                 "branch": "master",
                 "describe": "15.0-hardknott-3.3-310-g0a96edae",
-                "remotes": {
-                    "origin": {
-                        "uri": "git://git.yoctoproject.org/meta-intel"
-                    }
-                },
+                "uri": "git://git.yoctoproject.org/meta-intel",
                 "rev": "0a96edae609a3f48befac36af82cf1eed6786b4a"
             }
         },
-- 
2.51.0


