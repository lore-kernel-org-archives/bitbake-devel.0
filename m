Return-Path: <javier.tia@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41983C35FFC
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 00:34:36 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
 by mx.groups.io with SMTP id smtpd.web10.1999.1742430850171115025
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 17:34:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=deFnVVz9;
 spf=pass (domain: linaro.org, ip: 209.85.222.44, mailfrom: javier.tia@linaro.org)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86dde90e7a3so90854241.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 17:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742430849; x=1743035649; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y59giNKtwyBUQBtmmF9ISweqvTgmhAj61z+4ZJqKxaA=;
        b=deFnVVz9U8+9hUgc5dgdqFN/TQsO6e4iVTZUWVp5M+2Rd0RxrRNMAOwH33HO2KT3cj
         OO39y1+x7+3AYo2uMEwXHwHfUnkz5qiOAhWlR6d0QkmDAdKcFtyDZGr0BBgzZgJDTJcB
         NuN0f3h3IClHdw+vZq4j/0NJMHQCjQneWWDU1HtunOQ91bGROq7JSEj9/0ESM4WHu19K
         USwmln1DMdFdvWmHUzj8FwJIbAZBeOOdiOwcP4kyv86fKJCfU/VamZ6YVDr5jT6mgyjL
         qnw8L1oDOLI6up+HibHg9apguoEPF9VsGtn1ow1swNdQpI8H1d292F3ydo+9Ap8lMpd8
         MjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742430849; x=1743035649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y59giNKtwyBUQBtmmF9ISweqvTgmhAj61z+4ZJqKxaA=;
        b=rj8ghlYzee0xAxCSd21SUCocvYFdF32jCs5YLblSJXyyjJJMEmJqWu7ZiHYShtsvqd
         3Em9wFo7I7oxiRBWuCiAMITwALq8tCfr0iVDXZfM0Rcu1nkA366VOFCLDs5o+n1GoZq5
         e84aVlHEdpmcUN+BNwTveD4v3e1132Dh30XXAtYPrP0Opc/ycBwRfzCKi/SaGTzrDk1E
         mVbqRoC5P3k6t6mRauDcuYn2OuDA8VIMv8T7T+iQerOx8NQ7M7b6W/p+a7fsGmTHGbT/
         h6Wxcnn6d6MPBRMakuxAMvXzZEsqwAE6ST2TDEhEsDKDMJaxxfOOUVxsq9YdOGdk5Bkw
         7aeg==
X-Gm-Message-State: AOJu0YxgMvxpJTv7ECuU+Pp9scxv1GkwTNdLJg5B28hlBc2Sb05DG38a
	WzzXVP1m38nUg4Zpt/2VRCBYXlrxH5GT8ZAANddz5EaGaAOaRkf81fS4L2JZ0HSxecIc5mZBGTH
	QsFw=
X-Gm-Gg: ASbGnctbGoQQ+N4SO68QKeVferKk2lsxX2SNqh2GdXWykPwEsNcvLpWlgopM6/kAATI
	eDS7gC5sydhC2plQql1HKbT4X5S1Zwb/IGmjk/ViNWac7meGH8ZYhFeFo0IqbLCGGdM5VLo7iQt
	55m1oQNjCAzlAGGenZYxi7ERfJbd88+CYCynmzg2ijVyu89EdGeUda3HnjfNOqhFf02SyGgSEq6
	g2ecEG8sQqTS+byQtm47AWIE4bTFf4oPZeWsHap640rpFpdyQfQneaQEtm9ewRJueiyS6l9fADI
	7yunhUAEQNXaL30q7TSiDeDZfRnZ/GwzCygcQinXmodLUqFpf8lOXFRtB9o5cmuqJng0yinC
X-Google-Smtp-Source: AGHT+IFX3e5zE4cUr99LyZRS8dRiK35Vea/WOVKXYczCyLRcA/DmP0sJ+cRW8kb4EO+SlV3wHxXebw==
X-Received: by 2002:a05:6102:161f:b0:4bb:eb4a:f9ec with SMTP id ada2fe7eead31-4c4ec8111d0mr3491502137.16.1742430848888;
        Wed, 19 Mar 2025 17:34:08 -0700 (PDT)
Received: from localhost.localdomain ([170.246.157.153])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d90d68da8sm2676704241.6.2025.03.19.17.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:34:08 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] doc: Mention `if [[ somecondition ]]` is not supported
Date: Wed, 19 Mar 2025 18:33:58 -0600
Message-ID: <20250320003358.977774-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 00:34:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17474

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


