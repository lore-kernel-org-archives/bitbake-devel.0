Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDA8CD6E50
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 15:00:19 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12172.1780066815802368832
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 08:00:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=SBHKHzZ9;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so311494f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780066814; x=1780671614; darn=lists.openembedded.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpWQpNkAF4P8cFqIDunGQAng64Y6WrhCZayHLNxCItw=;
        b=SBHKHzZ99oWh3nl+RJmtBsO+g+G+BJFRVEXNT4HsnOm1BIfNFysKkurrLZckcF3Vkt
         rpvkPcx3VOjClcyDekx/a+PxiwRwk9c/Ai00qsBT6mn08thwgfR/BvuKdyvMAqiWbBtC
         ZvTbTvQObMdsfSGrCWYMGYco2wzEmvfSw1J43l4FxZxBQwQI6/+hTXQqM6Dc7m94NRGc
         y4BKVNLugMQHjP1vRCQDWrGLLjvEkMYGieSFmyfgrzQ9HwjzUAjdnnXJ8WqFZTGl+qpA
         Cc5AsHY7SNsP1Br+xBMj89RLEEUeiYBwUsNKaVUQu66k39UFp9nNoPrcJLwHps6iM7YS
         xLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066814; x=1780671614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OpWQpNkAF4P8cFqIDunGQAng64Y6WrhCZayHLNxCItw=;
        b=BOqn4JdUPveZ3it1ufnhH8h8rYx7iyodgzMlS4x6qg4AfwLwIrovRLUF2+6feaKUet
         UNBvK56fGKWYLFKcX3tZ6mBnnxTYJ06S37tbAMBemzLkVlQrxpjgGGGzhle9KejA9Fuw
         n6apfocgzDo7op4J5mH0bEN1+uWTn1GXpNpxRWpfCGygBqg8GnN7I9109TXvoSchUrLI
         p52CP1LXgTAZx054DbSYebscKKHmZXmSvRRONysvhLfW7YWRj8DFYU14jfYka73UvPqL
         pVnv2nFIG6t2E5zVrZFvHInbZtUULVJR/eO6PEbyM8qvBn8OTBwCy3IP2bdNyodH95ux
         B9Hw==
X-Gm-Message-State: AOJu0YxP3Nrhg4XFJJDmlKiYOL77uZxX93y/cXQrf9UVXmaBrNBlaYnq
	o6B9gWufN17Y0/J1OWaAUUCkxlro0yPmAl+z/BsLJc5cjdx8UrQnHFfE75dYVtTa
X-Gm-Gg: Acq92OHiiZQR1/WxOc/GsiujMBIswxmPI/cHheHuadfydiLz1lnLElREHpw5VDksVy3
	jS5RsdR0IbNE6w+evxRVcjmJZaFeT41SlaF5IB77+3yJKfFXmQdCsEYvRcsl4WsRZCVWX6qpSSC
	X9zqZgFD0aFEJc3lrLKOTFEJAL5sWRmU8jxWR4z61BQwx06dkieowcHl3PXC7Xj3Vfry3kpfjE5
	8RdxvfVhAtJhxO+lNLSitiU0RLG6POkhzldE+8KBnFfIIOqwIw8yC4Owmg2Ny1kBlkSgdOVrZ9i
	qSj4TOVoFO+uT3i2i4q7Mar7mq1nOqObaos9V1VHeetZNQdn9bb0JAIOKKdiqYpSLW0/MJeZHcx
	vevVueSor7zgsbfgWgTi6e5yGh13xq+fLZ1TKjf6dZqL1958Cm9S6sJEkXzlCszf3Txb0oy+hdq
	5cSswuxuAoCkuUHmqJm5zPM5MJQN9KYiHQvhwWYzNs+JDH0906vT1ggyEgDqLZgrfwgY3V751Vx
	3S2ymz22KLIXjydi9hKap26u5rBRMDkyYV1uw==
X-Received: by 2002:a5d:6191:0:b0:45e:eec6:5020 with SMTP id ffacd0b85a97d-45ef6b8ed7emr225346f8f.38.1780066813563;
        Fri, 29 May 2026 08:00:13 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm4285826f8f.34.2026.05.29.08.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:00:13 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Fri, 29 May 2026 17:00:00 +0200
Subject: [PATCH 1/2] bitbake-setup: clarify configuration merging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-bb-setup-notes-v1-1-a251ef1c5af4@toradex.com>
References: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com>
In-Reply-To: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 15:00:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19564

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

When nested configurations are used and the same key is present in both
configs being merged, the Python "+" behaviour is used. This leads to
lists being appended and strings being concatenated. The first is an
intuitive behaviour when specifying a tree of configs, the latter might
not be.

Clarify the configuration merging behaviour explicitly in the docs.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 77fc4c3dcba0..1252f22c823a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -1068,6 +1068,12 @@ They contain the following sections:
       configuration choices by putting together information from a leaf
       configuration and all of its ancestors.
 
+      When the same keyword is present in a nested configuration and in one of
+      its ancestors, the values are merged with Python ``+`` semantics. For
+      example, lists are appended and strings are concatenated directly. String
+      values such as ``description`` should include any needed separators in
+      the configuration data.
+
    -  ``bb-env-passthrough-additions`` (*optional*): List of environment
       variables to include in :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
 

-- 
2.43.0


