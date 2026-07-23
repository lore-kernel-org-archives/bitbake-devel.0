Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE97C531CF
	for <webhook@archiver.kernel.org>; Thu, 23 Jul 2026 13:49:41 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23886.1784814580286522259
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jul 2026 06:49:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Z1d1Oqti;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so4930375e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Jul 2026 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784814578; x=1785419378; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mA3ySwD11Orf7/RQ3PnLo82KTsSmBrzcQSPQ46xv4Is=;
        b=Z1d1OqtifJ4C6vVcjsjNzEpTu24+veE4RlGkmSY2EfthgZtfQz427Pbr2y6Pl3p/7Z
         nP29jkAcRJCZF9y+4U5anfLpwPf4gi/jO5XzW3qTjIQColMbn1DeDB5DockGdY4w/0SV
         eKXig3CNtMAJyqMNVbALdnbbzjrLPOU8FqCfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784814578; x=1785419378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mA3ySwD11Orf7/RQ3PnLo82KTsSmBrzcQSPQ46xv4Is=;
        b=gS2doA1zBslesZswb5jYplCP2txtpSKhtx7Aqy6QUWj65HurXQv2l+AVbYjhtFvDsE
         nR2fMtcYt/ypjfO7HWaVH91PT1HPR91iT207SQCHkgkYwUCGogxbitwQG/o8PN0Ul7er
         mTaYagLbSKBXJEPgIuqoCYdzYAYh8LPwdBAxBCZrMJ4Q3n2/y/Q/2E8zi/+Dn6QzLaCm
         xMig7LnKndKLSn/U2vQA2xM+SjhrCIkFQeSrMvP9IjKbY2Sybu6P42yvF+FY6iMhChUG
         UHRz5GBx2djAR7Fc0wTcYfwVjqIV7Nl5eKAqF2VWmnvPRIhpxx6J70QU44XjWPQAV8SK
         40Xg==
X-Gm-Message-State: AOJu0Yzw8ikJnXPLQvVGxOoa4WdFXsFSUpYqeTiSFLkIhtb2BTbHIvKf
	8lYd2Pp8jlf0k/zvL2PBFyYAEQl7R8kMQzXw2M7GwkTx9ziEEyfHoBdxVf/aDhJlfM2ZCuYCFQY
	FGdZVftk=
X-Gm-Gg: AR+sD13RxJ42kzYPfnJJiLF9OZxuaDhlzWfQDAMkfC35qF4j2CMuAlEBm44eGYBITRj
	4qChPGJLBei4KzyftbrPPDpuRu1BuZjP9hOVvURKXfJEzztcxvwi9tmhurqEjjED+ceVBDeEbuT
	bhPpLnYS3a5qXj3lsuuLt51I0b7Hl0BVyBr7XUEdWMbPc8GVpMWT7tWCyfL8bqHrI3b0iTvxHSe
	tXcJ5noBIKl8V6Z4uGW1gELaDkyEN6oUPrV6dcjB55iUySbu4gpQGAyST5NibWe7SQ207c/QIgQ
	qwkZndpRAiftasDyWgdBw3sS5+/dNpIaaAfed0QqU/tqxh/z3humx50t+maBhlmckVBPs7il8hf
	Dyt4GHCELNqejXbdJ0Ood0a6kwXYaqrWSlOBgLtOIlrxQj2IB4LgjB+phWYJU6WhZf5Si1uXv6R
	E7/BCfZ+SwhMeMNLAVDB7gU8QFViWVjys=
X-Received: by 2002:a05:600c:3107:b0:493:b87c:c87d with SMTP id 5b1f17b1804b1-49573cce8eamr31653635e9.11.1784814578262;
        Thu, 23 Jul 2026 06:49:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2205:d253:2df6:b9d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b7483f0sm128103045e9.3.2026.07.23.06.49.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 06:49:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/setup: Drop win32 platform reference
Date: Thu, 23 Jul 2026 14:49:36 +0100
Message-ID: <20260723134936.928230-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Jul 2026 13:49:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19849

bitbake doesn't run on win32 and likely never will so we don't need
this reference.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/setup.py | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 5fcbcbcf0e2..53a07ee3a68 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -907,12 +907,8 @@ class PyPIPackagingTest(unittest.TestCase):
         venv.create(self.venv_dir, with_pip=False, symlinks=True)
 
         # Get paths to venv python and bin directory
-        if sys.platform == 'win32':
-            self.venv_python = os.path.join(self.venv_dir, 'Scripts', 'python.exe')
-            self.venv_bin = os.path.join(self.venv_dir, 'Scripts')
-        else:
-            self.venv_python = os.path.join(self.venv_dir, 'bin', 'python')
-            self.venv_bin = os.path.join(self.venv_dir, 'bin')
+        self.venv_python = os.path.join(self.venv_dir, 'bin', 'python')
+        self.venv_bin = os.path.join(self.venv_dir, 'bin')
 
         # Install wheel using pip from the outer environment (offline, no-deps)
         site_packages = self._get_site_packages()

