Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4192C53219
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 07:57:55 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6359.1785311868268374959
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jul 2026 00:57:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=OBkpK62o;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so5678935e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jul 2026 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1785311866; x=1785916666; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bomcgvMjAczmXGgOD0sHFRnos2cUijoBmx23flR7ytI=;
        b=OBkpK62oFCk++B+1TRblBsJxjPume6+2R/yiVa7+Ek3JEBp9Oakay5YbBlqhShQBBk
         wHpe9jQAwWHs5DZ9qjQzbcVIsamrMjwjUioQPycjDjjT3zxmZwpRgWLSt8C47w7JFQXb
         29O/P43fy9BgpwXF87aGdGRi3OMcqcNIKJldk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311866; x=1785916666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bomcgvMjAczmXGgOD0sHFRnos2cUijoBmx23flR7ytI=;
        b=cutu6xIqdXuAWThoSpKNiHSxB/WhzkTphYWMGnMnzLwEQaAPinPZoJhGLoOKv7/+W6
         iEgDszV3lVNeYH92GhMLvHvi8D9mKZ0pBMpYkxEnYiEPhm0VwPVdoaNTJx0MT8AisXku
         chJDeC3w5Z+DYX3k4I50UukwxbTSOv6DRg/qEqQajbWzChFsxEGicJcKKlKvkwFJtDWt
         DcNdwxjRHGHc64yrufHGLTf2OXMK7H0Yfx1Rqq5CnFiIc00DGQKBdfEs3Y2fO07sFnwJ
         7W+FKucCcsVfDP265aFzXUJh8j/oD2nvkjyT23nZdHAgRnHcYNK4vVyQ26P/S3da2IRS
         wxWw==
X-Gm-Message-State: AOJu0Yxeib6agWWMuk09pwVVJZRv3pfFEJsGCCG2Z4BwBLYA36Q0tXww
	8zdJce78zjGv3gIyqppZ2hYE8FvD2LswxVKdHJ15MppYQIkyPlxMoUTwUvrZ5RtMUuFm50uLQZz
	D2qTFgiA=
X-Gm-Gg: AR+sD12VXIyg77RG4FGIOqBxZ84qFpFz5hcJHOdeZcIiWZZRZxDWij13ShYWMWZ/sfK
	gNivLsoPpMxxkxEd4u82Ljj77jI08DAyjzaJYo5QQcklNYkatgy7DscrBSL7lqxPHrjuxdaoUGf
	kPptEn1CKV903WmePblTP0x8oFuIgeARDEXjQ8T7H6EylW6XBCFWtzf3woeaVnIb6nbYDwDqbQq
	qvrWnM2KHV32qw+6UVQz2zymtSLGFK3LlnjXY4A49VcY9FjxrSx5t5f+NTn97i9rSlDGN//FaD4
	l4q02ptwnfzTLGx6UliamSAlRuc7guQgiaaXu43JLbb0z/Ir8s3+0Hnw311pFsGTAIZH1RVUD/f
	Hjex6ZIlkYKbIFXEl8L3OMB0IT2wrIey3qdYgt+XhP183aItME9acpa2UMDgaFYNAsdqDLLnJnF
	+1YQwTofjOEAhwcqauynwM8pXZtfrGcE6Hx9g8t7apfZPgubzllTBL11JnME1JtQjW6j5f5s14y
	EpEHXIke0q3Hb0YDboDbttgKpb5Nl+8wo0w3uRLXXUmyA0whlcJ4Ry6zSfyg+rvAth+TQe4A8U=
X-Received: by 2002:a05:600c:548f:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-496ca1fa4b4mr38007825e9.19.1785311866564;
        Wed, 29 Jul 2026 00:57:46 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d77970sm39189595e9.5.2026.07.29.00.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:57:46 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 1/2] README: Add "2.8" subject-prefix to git-send-email suggestion
Date: Wed, 29 Jul 2026 09:57:21 +0200
Message-ID: <40f0570bdad3d008268a1085dfad2da97b1ddbd1.1785311679.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785311679.git.yoann.congal@smile.fr>
References: <cover.1785311679.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jul 2026 07:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19870

From: Yoann Congal <yoann.congal@smile.fr>

That might help new users send correct first stable patches.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index e9f4c858e..b5eb5ac40 100644
--- a/README
+++ b/README
@@ -24,7 +24,7 @@ for full details on how to submit changes.
 As a quick guide, patches should be sent to bitbake-devel@lists.openembedded.org
 The git command to do that would be:
 
-    git send-email -M -1 --to bitbake-devel@lists.openembedded.org
+    git send-email -M -1 --to bitbake-devel@lists.openembedded.org --subject-prefix='2.8][PATCH'
 
 If you're sending a patch related to the BitBake manual, make sure you copy
 the Yocto Project documentation mailing list:

