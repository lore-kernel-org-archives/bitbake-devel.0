Return-Path: <robbinvandamme@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A6EC54FB3
	for <webhook@archiver.kernel.org>; Sun,  1 Jun 2025 20:14:30 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.34764.1748808861829858605
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 01 Jun 2025 13:14:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dVos9w+m;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: robbinvandamme@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a365a6804eso2813861f8f.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 01 Jun 2025 13:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748808860; x=1749413660; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ceQxH+cU+xJmdMBbwxVILSX1g/zF67j04RKwT/0LB/4=;
        b=dVos9w+mVqM4vuROh/bv9akOp7biqq9b4WqDUrpj+Qg21dcocS9C+V++E18WdPOHvy
         ylcM5+ZF4afaN6egFeCZGL0diQy22YNP6rE+nyiP55kMiln6i86CpUrIaZCmIRnxb8He
         kCyIFYqeUMoRWhlXQJQcMQYdw00fn0EDwUNR3ub1FanwM2t+DEY556y+x6OmTAc9f7Tw
         pF+Uq8Rc1arOH4wCny9Row1Y6snDef0mUsoPjO2vjztCpYCoGc63lvbpfi3Qghbr3jXF
         Lz+jXgoPFrbMAcqj6VVxP3UMffNPQ3BLMfmHIR96TehxdOL609eLeYHQrpzga5AFmZsJ
         iqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748808860; x=1749413660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceQxH+cU+xJmdMBbwxVILSX1g/zF67j04RKwT/0LB/4=;
        b=TqzZBOmarMzN7xRvlI7LRG9TyLAFXDbNCQjzhyHqj0PFIy47jdLv6tiYEzPj1rIh0e
         gpgGLhx0lE0/nI/UMWIMqenjKtDLviy2Qn9RDSxUXgD3b9xMfe+z2FOaVOF9WENYInVn
         C+fhwM5Rg8wq4HrhhbLOWNCglK5tP7k4PX8fH1ZcFk83fO0Llm9Sr+VcwaWzGo081RGn
         qRkTUSHbv6zylix5pyRBv8Q+qLFvwrwzfuL0KebMTJStMLIFHI+0dL4Dbgqzdm7Qg5oU
         1fZNlZn7P6wrzZCLKvJ1SI5NN+7axCVTuw+4p8fxUidyr+hQacStGfEaTnMVNq3JhrMj
         i6Rw==
X-Gm-Message-State: AOJu0Yz1ySwZv7Nss7+/CX0T7DmROg3UBZOXv3JEKKZUXxhNjfth4vvn
	7J3FzQzEO8An3U8RiXGn6mGxqPdWSAphDYmKg1U3jl46dm9WSlsOtbobpbcG1Q==
X-Gm-Gg: ASbGnct5WqcOW15NoItZw3tQrEWjOFvd2DyK99cYL7jWvfjb5cwRxzkAx42R9xLPQKH
	f8nbJT9Fs8VxFnGydCmOD3bhyE25tL1I0dUoGRrmd1RASTysgb/EWcttXZHGdcAJscP6BwYG8Jf
	IBQ2saU8c7bo9kxY1lCS027Wl2B1wYWvHUmAHz6geXL6srTQYDy6M40KbadbH/gy9N+cpbknS9R
	HxDD6o8423Opf1RWevDOORsTu67l/pbV0f0hB8OnplmeoB0/zEKQTFNeXZFNNwQaIht6OfnPy9z
	Xgzlu0lf2GDvEL7Gyd1ShbXW5hw8HduFm2YphPC9E4R25GONgcR2F19ch3eUCysNyef/RK53DDF
	aW7Rc1DU7f7XjkiY2gsQk9Xitnac=
X-Google-Smtp-Source: AGHT+IFRfS7BpLZe7kh6kTG3iR/xWxoZWU/TzuvSkBaDSAvHOvhSz7KFTiXtnMAHYocm+C282GGJwA==
X-Received: by 2002:a5d:4110:0:b0:3a4:fc08:8faf with SMTP id ffacd0b85a97d-3a4fc0890c1mr4471509f8f.28.1748808859947;
        Sun, 01 Jun 2025 13:14:19 -0700 (PDT)
Received: from PC-G502T14.localdomain (78-20-31-164.access.telenet.be. [78.20.31.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f0097205sm12498842f8f.79.2025.06.01.13.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 13:14:18 -0700 (PDT)
From: Robbin Van Damme <robbinvandamme@gmail.com>
X-Google-Original-From: Robbin Van Damme <robbin.vandamme@renson.be>
To: bitbake-devel@lists.openembedded.org
Cc: Robbin Van Damme <robbinvandamme@gmail.be>
Subject: [PATCH v2] Update documentation and add extra check for az fetcher. AZ_SAS token should be prefixed with a question mark.
Date: Sun,  1 Jun 2025 22:14:15 +0200
Message-ID: <20250601201415.176479-1-robbin.vandamme@renson.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 01 Jun 2025 20:14:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17664

From: Robbin Van Damme <robbinvandamme@gmail.be>

Signed-off-by: Robbin Van Damme <robbinvandamme@gmail.be>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 lib/bb/fetch2/az.py                                      | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index fb4f0a23d..eac3cbdfb 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -686,9 +686,9 @@ Such functionality is set by the variable:
    delegate access to resources, if this variable is set, the Az Fetcher will
    use it when fetching artifacts from the cloud.
 
-You can specify the AZ_SAS variable as shown below::
+You can specify the AZ_SAS variable prefixed with a ? as shown below::
 
-   AZ_SAS = "se=2021-01-01&sp=r&sv=2018-11-09&sr=c&skoid=<skoid>&sig=<signature>"
+   AZ_SAS = "?se=2021-01-01&sp=r&sv=2018-11-09&sr=c&skoid=<skoid>&sig=<signature>"
 
 Here is an example URL::
 
diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
index 346124a8b..1d3664f21 100644
--- a/lib/bb/fetch2/az.py
+++ b/lib/bb/fetch2/az.py
@@ -36,6 +36,8 @@ class Az(Wget):
 
         az_sas = d.getVar('AZ_SAS')
         if az_sas and az_sas not in ud.url:
+            if not az_sas.startswith('?'):
+                raise FetchError("When using AZ_SAS, it must start with a '?' character to mark the start of the query-parameters.")
             ud.url += az_sas
 
         return Wget.checkstatus(self, fetch, ud, d, try_again)
@@ -62,6 +64,8 @@ class Az(Wget):
         az_sas = d.getVar('AZ_SAS')
 
         if az_sas:
+            if not az_sas.startswith('?'):
+                raise FetchError("When using AZ_SAS, it must start with a '?' character to mark the start of the query-parameters.")
             azuri = '%s%s%s%s' % ('https://', ud.host, ud.path, az_sas)
         else:
             azuri = '%s%s%s' % ('https://', ud.host, ud.path)
-- 
2.43.0


