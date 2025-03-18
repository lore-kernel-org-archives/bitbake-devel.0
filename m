Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8BDC282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 12:15:44 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.10262.1742300144054445848
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 05:15:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HFhX1x8U;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so19023285e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742300142; x=1742904942; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5C5kMeNDU1pTYeNaC43NSKHM4V8/7Jk7BoFYqVKGGoU=;
        b=HFhX1x8USMGmStVt80V2ygPqiklefztABLwcBNPyLHeGfG4ctkCteGfiPl04O/CEDr
         +tGnKAGWxUkyPxW1yzIGuDbtZJciJwOqh43koPP5iaAADDv0YqhE4ujqpLSLj89Z7gVe
         KVHMpEcmqtpZFBLAeumstQ2uPVx8/rYU4BHdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742300142; x=1742904942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5C5kMeNDU1pTYeNaC43NSKHM4V8/7Jk7BoFYqVKGGoU=;
        b=O7Dt7RoJ8/4VQTFL07cxedxxNjtkXoNcHDCryAz7Jd2NsbNbJSrqPYqjqvMCzYNUng
         vi83yA7mcc+gSLEIC5uJXnyrX/E1EO8zX3kc1+jpaMuFy40x9uFX7oHcx3fFsX+IzOCn
         vCrbO5qpkMZ0QYReDWI0EVVuV4IQKTb0jPiU/JxfFdwSmbx0sy+Dbf0ydX4BsOktRPRt
         uG86CPythA4UW0bl2Ca++Fl0fvDchvZk4ptQdGigH1IgES1d5v09ycYe+hZromWVZX6k
         F52UdIwC2YvCaY/HQWbrvaE00ielPzPh/+DwnBQjMBqhq0HRV8z/HI+0MAvuBsxVbQva
         Vn3Q==
X-Gm-Message-State: AOJu0Yw8YT/XFzM/NPGi5QE8l/Zqftl4zDf87GR/ZejjOTnfpoiVjYQ+
	Bz3aXmIHGp9eXjFwXFisKhHBlhPxxpdx0XtUIQPC/iBnJA4qO44IaBXvBJlr5EcGBYh/pLnUm8s
	G
X-Gm-Gg: ASbGnctL/jBTeAgn1RYbEaKk+X3fAFzB4Oe0MKNZbUEEs6Yx55fG+OjO83uojAjt04l
	7X8pwPxBQbhZMMVgJoAjvTvMQfJj9vnx9n5gNZZ8y3wK21cIIbEXO/uMPyefNak34WloCe6xWgp
	XKCdrESYfPFnjkUFP2Ug6azw00hkqL+3BEteKQRQEZBkxHjFUjmhC8tomVrA1S6mo7G4zxqE+ZL
	GTQ1l6PTkf9z9z5FNadsBmO2r4F7Og/XMVpmOAT499SyznC5QxlnorPOm0/N35q2Gda/oIO4yoI
	0b2Fw16jEU90CXKeddHL1pf0V1TpRkDVy5T+rsoqkYIzdqz7ywzPQbnJeiesFBJ/GZ4V4icorQ=
	=
X-Google-Smtp-Source: AGHT+IEFBjb7x63QKLwz+bVsfyLOqgfcv6Jk5d01bWtguCsGLNc8oRfQKXkw272n03hTZ8vUKc9IGg==
X-Received: by 2002:a05:600c:354d:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43d3ba14c74mr16905385e9.31.1742300141736;
        Tue, 18 Mar 2025 05:15:41 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:791f:f4e7:28a8:7096])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3978ef9a23bsm13703154f8f.15.2025.03.18.05.15.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:15:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/git: Ensure tags work with shallow clones
Date: Tue, 18 Mar 2025 12:15:40 +0000
Message-ID: <20250318121540.4123354-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 12:15:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17455

If we want to validate a tag when using shallow clones, we need to ensure
the tag is imported to the clone. Adding to extra_refs allows this to happen
ensuring tag validation in shallow clones works.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 53fdc4c3df..7fda9d2753 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -674,6 +674,8 @@ class Git(FetchMethod):
         for line in all_refs_remote:
             all_refs.append(line.split()[-1])
         extra_refs = []
+        if 'tag' in ud.parm:
+            extra_refs.append(ud.parm['tag'])
         for r in ud.shallow_extra_refs:
             if not ud.bareclone:
                 r = r.replace('refs/heads/', 'refs/remotes/origin/')

