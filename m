Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1AFCD98DD
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:11:56 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45176.1781183511105193995
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 06:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=CnZ9/PY/;
 spf=pass (domain: smile.fr, ip: 209.85.221.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4600ddc4017so5452199f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 06:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781183509; x=1781788309; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyhsjDUN8PXNd/hMzNzd8ynGnD4A6+mHqMiAuPQBC4c=;
        b=CnZ9/PY/Q6gK1Wg2AKWENpfkJtpwSjg6DhZd7/fpeFeTFGeNKaN2I9vRHCcKrylkOP
         YhSJYcAZQmXCckZFT7XkPYprUZzti7891RjLTXECCf4ryUQKvcxtDgv6cAN6tDmBOKp0
         SselAsBn5ndpgdEcW4NgaP1lyvsECJU6lJ9ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183509; x=1781788309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dyhsjDUN8PXNd/hMzNzd8ynGnD4A6+mHqMiAuPQBC4c=;
        b=XoGaEelnaaa651BbDOkhBb2H+4ItHk4maK4s+RvyTWlCEJ7Xia31xt+85IoJTzavYN
         KKn6ZdDuxKMyaMZoT2DOhbHiwmz9psde6t5yJuoFooN1EASVRbbgM3Js6YfKqR8i9C1c
         zJVCefcDzBi7df/QbgMNGTO73NvMjOQrFc0crBPj7nXVdQq8m4feRkTyBumWhjUWK43e
         UdJqBV08RPzP7CpORfHvZtshvWWZgoQzHbWSMH4GRSO7NgX4uSEwj67z0p8opmZBBRvW
         ldakHqgTUY6LsWVeD8HNtBZmnvZoK2tufRZrEqVX8YMG44B7EPMG5+iFwkyZAFlSUbrx
         qUDQ==
X-Gm-Message-State: AOJu0YxLBUP0aP/J/Rv2KGgUNp1K3GPw86kPA/c3syc67XUUr852AqNq
	rI0sHGkItI6ZfwMmn+iAXB+k2eE5UWrpgsrIZMXHS/aT9As4onk/nTrS8oko2FEyXiAL6xsWOYy
	Q2/eq
X-Gm-Gg: Acq92OGM4K+E505UbJQmcXjr/+e+M/ghFvG7AqULGkp4C3/988DJFCCqmIUNQ38CBlx
	WEam6ydLzMURKnnOLK7NkznSRSiyr9UwcezrzXTfbnEuryzcabniEQUGJ7SCnXe/Q2q3oFIzRpF
	v51+ZujZ6kunClx2K0lXHMc7zrfg4CByu2TdBQ486EkEwQp8gpultdejr1YhPuFzT4Sxugux3ki
	89K34jdlOZSIVSQVuk/9MqlvOJKbfChREY0ahtLDIAQsfrbWuKAHq26DwRB96qhDGCTY3a63dLe
	q4hV0v5soSKSg421feN5W6JXWQUQDSl7XzmmP5Ch9Eu+Rsp/SgPbILujNsTYb90942rFkskpMe3
	ST/K9LuXl7fJTmoYEuHPl0TYjiP/0r3/ViR0F8KQKHvhVRcQW74Sn1iafePNbVqckkfzGlMMd7a
	F4OM0YjWJTwfi5gZJ3y7NCucQPxsO7/ywGRgR5x6YaNkcOhzm+kyqrVWJgpsurZM9OxHV6c+lxh
	Q4WbaWymuHEEvIMlwly01uQ82pWU4ck2ceKim+g4rVZTYmXuw==
X-Received: by 2002:a05:6000:298f:20b0:45e:ce49:43d8 with SMTP id ffacd0b85a97d-4606758cf51mr3376029f8f.4.1781183509291;
        Thu, 11 Jun 2026 06:11:49 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0084744357c26c6744.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:8474:4357:c26c:6744])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm82048251f8f.28.2026.06.11.06.11.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:11:48 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH v2 5/8] fetch2/crate: guard against empty version list
Date: Thu, 11 Jun 2026 15:11:27 +0200
Message-ID: <317cdbef364202ea0a857516d65710c95c96bb1a.1781183212.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781183212.git.yoann.congal@smile.fr>
References: <cover.1781183212.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 13:11:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19665

From: Thomas Perrot <thomas.perrot@bootlin.com>

Both latest_versionstring() and latest_versionstring_from_index() would
raise IndexError on versions[-1] if the fetched index returns no usable
versions.
Return ("", "") in that case, consistent with what callers expect when
no upstream version can be determined.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ffdc2a02693379d7ead0f7b940111340843d49a4)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/crate.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index d84bae0bc..eb1fd5719 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -164,7 +164,7 @@ class Crate(Wget):
         versions = [(0, i["num"], "") for i in json_data["versions"]]
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
 
-        return (versions[-1][1], "")
+        return (versions[-1][1], "") if versions else ("", "")
 
     def latest_versionstring_from_index(self, ud, d):
         """
@@ -182,4 +182,4 @@ class Crate(Wget):
                 versions.append((0, data["vers"], ""))
 
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
-        return (versions[-1][1], "")
+        return (versions[-1][1], "") if versions else ("", "")

