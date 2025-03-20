Return-Path: <javier.tia@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D96C35FFA
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 00:35:16 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
 by mx.groups.io with SMTP id smtpd.web11.2123.1742430912882030825
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 17:35:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=d+VE4vXI;
 spf=pass (domain: linaro.org, ip: 209.85.221.172, mailfrom: javier.tia@linaro.org)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-523edc385caso97476e0c.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 17:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742430912; x=1743035712; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y59giNKtwyBUQBtmmF9ISweqvTgmhAj61z+4ZJqKxaA=;
        b=d+VE4vXImTuNcrXLmAYhDR/N9O6XM2d6ITDiz1POOjtNAKiNMwJCLNld+PJHpCCXTj
         7tNTcjXaux/NaI52ASt10FWUviMbM+eYWXY0wMhhJY8OCSCX/D3hSb+yd6jELsmIzgge
         zsPoEzcgUrZFmPVqQR5fwIIKtkipu0pSjOh32Nr3+c22s4txTlUSXVryvnzvF1cYfkif
         GwYYxMkpYXInzuhT0WxN39j3gdaM2BDhrznN3kHdPB7l498q9zmtRZ8HUl/7XYs3ffts
         J7fTHNa0ViU21hg4cmnTvUvi/amzQV2bM4rIJPtKFE67svyK3CSqZpEz7W9jessZkOHz
         m4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742430912; x=1743035712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y59giNKtwyBUQBtmmF9ISweqvTgmhAj61z+4ZJqKxaA=;
        b=eUH9dLhP4BI6IoB9l8ox37ZMImEGlHhQ0rTw195joGCSC/C9Tu87q0w6eTRSHuliiu
         1qGwYKe1yL04mrak31d/tKc2Rklvmcw54tsO7+EyOvmJ0kAq7jCw8hsuVBmsFCXFALLH
         lNHFGJboIgLGIHyKfb8+YczsbGVE4Tbvec7j0v5KjZvGJbwHUBCqblTEDRaYm/gUNp0O
         JthlyLQzAYE+l/qSb8/Qlk+xMr65UOIZpGoBh8K01LVvxWM1XyEAWrIBSQv1ZfdNzajp
         DzYEcFVzAz4XF8lpOL+O+92hpv0+CMsRHC/pCIqEv5UhC/iZ66/UD4d0z4BkM6Bb991U
         GgrA==
X-Gm-Message-State: AOJu0YzpjnF+bwLGK5erJ4VH6/Cg7qr0IQrcrANQNdhTH23+sjep536X
	dFvtchTDar64SPlQjRTPbeQNCJJfIB4rbOOexAV26GJSQHCpn76w4AQ4LH7oevpISvKE5/WnwM8
	5krk=
X-Gm-Gg: ASbGncuexhqnWwi1c3xaoplzFoVu3+PJ0gLJcWoPAr8PiAX3d+OoIxkcOmOUPOvKBe6
	u8v7Xz74aWQN7W/g3k3v7oUw4hfdDpKqtW/6K7WZRBxCAUrcwuAuuOa99GGh32I2LSqnazFutRh
	c4oUXW81h7J43+yW/Y2EiMrUnzZqeyutalrPtUdFJ5lzHRXx/Ik6a5adv+ZY0MWxe94SPYaExXj
	xvUHRAJyhNlPFo7EYkqC8nPoBY9yUjLgGgHvi6i6Rmy3i9NuQKb4LN8ATPsaGLTAqG3mHY8Tza7
	WNsm6gGOslob9vUJn7U5Cn2iAk4pKmDTiTBH/wzvrVHlk1m/ZDp4NuJN4vCgzg==
X-Google-Smtp-Source: AGHT+IFtYPS2v0+uUVNNLnu4S7K5jquw0ZhLLgu7XT1LkhbXofgJeRKsg4Nnpr8daz+jsZsNW5fNjw==
X-Received: by 2002:a05:6122:8c03:b0:520:5a87:6708 with SMTP id 71dfb90a1353d-52588febfb7mr4342364e0c.0.1742430911753;
        Wed, 19 Mar 2025 17:35:11 -0700 (PDT)
Received: from localhost.localdomain ([170.246.157.153])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a581473sm2726908e0c.3.2025.03.19.17.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:35:11 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] doc: Mention `if [[ somecondition ]]` is not supported
Date: Wed, 19 Mar 2025 18:35:01 -0600
Message-ID: <20250320003501.978567-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 00:35:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17475

I keep forgetting using `if [[ somecondition ]]` is not supported.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 415fbf6d6..5474e154f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1381,6 +1381,10 @@ To make use of this technique, you need the following things in place:
    To call your modified version of the function as defined in your recipe,
    call it as ``do_foo``.
 
+   .. note::
+
+      Conditional expression using ``[[ somecondition ]]`` is not supported.
+
 With these conditions met, your single recipe can freely choose between
 the original function as defined in the class file and the modified
 function in your recipe. If you do not set up these conditions, you are
-- 
2.49.0


