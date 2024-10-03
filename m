Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2712ECF34AD
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 13:22:14 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.11286.1727961728718770999
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Oct 2024 06:22:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CQmR/+jl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so667351f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727961727; x=1728566527; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SauaoGIEcZqUv6fFacnfQczCeqWjwyPxLfM/hzdzCf4=;
        b=CQmR/+jlcM4aWPoDKpLi6v5lnEvUXa5biCrbesdJL3eJ9p6uYVcZjd3g38H0vF4dYg
         9tpqGhk4v9vtWe9nJ1Co2HLcTyxt/aelX1P93JPotVxKa5Oy0Yjj8vE21IgJE8iPEq6+
         LBeWs0K08WhIuBh5B/j1XMAAF4RIkWCymwQwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727961727; x=1728566527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SauaoGIEcZqUv6fFacnfQczCeqWjwyPxLfM/hzdzCf4=;
        b=OCGLSviiAxeUMkNkbG0Lq1iUJZg1Wf6gVkVNetBSepVmyXxKMoS2kr3OvCXUXgL2f4
         DGKOkl9UaFDUOt4OsoVS2vPtXuEUkt4uAlOmTg2TykvJHZg+vNQTkmQxRDUSj4GKP4NO
         mJDx1jCpzyBuLcHiaN4YQVLF7X8ONjPfUktsdYMvnfj3gX+jdc3oV1CmqOi/v9krIULS
         gS0fGdc79GyIkbcw4A0QX5085sXTEAgwCqjUD9O8/L7Fhh11EtYSfvmNU4XFueSBy2S2
         u2lT+rd+cQ7ObsARWyZCpwV297QdPvYoZfEBixMtnfMUKJ0Vu4NmT0N1n4n/VfgvR7tQ
         pGMw==
X-Gm-Message-State: AOJu0YwgXSQLFMlCKuDy9xHM4fVi9lsIrg/sCRDu25Q6HWWFRtiORbRi
	K7KJ+QmmEvuCit616yQA/YJwJlp2OpC9uXpqd2YhV/CGjPfoiitd9G67YRWhAbR4Lx0ZEhj0e2m
	Y
X-Google-Smtp-Source: AGHT+IEETAHdcF3zTMA+Ea3uUSEMFguQQJkjLdJnxli4Gb5zChuGPSmstTADmIQ5mSYhS9F7QBZA0A==
X-Received: by 2002:a5d:438a:0:b0:37c:d2f0:40ee with SMTP id ffacd0b85a97d-37cfb8b28b3mr3688852f8f.18.1727961726742;
        Thu, 03 Oct 2024 06:22:06 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:cae3:f165:6194:3295])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082a6a87sm1264046f8f.79.2024.10.03.06.22.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:22:05 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Avoid deprecation warning
Date: Thu,  3 Oct 2024 14:22:04 +0100
Message-ID: <20241003132204.3574272-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 13:22:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16635

From re on python 3.13 onwards: "Passing count and flags as positional arguments is deprecated.
In future Python versions they will be keyword-only parameters."

Avoid the warning.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 33a8086f27..b194a79be9 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -237,7 +237,7 @@ class URI(object):
         # to RFC compliant URL format. E.g.:
         #   file://foo.diff -> file:foo.diff
         if urlp.scheme in self._netloc_forbidden:
-            uri = re.sub("(?<=:)//(?!/)", "", uri, 1)
+            uri = re.sub(r"(?<=:)//(?!/)", "", uri, count=1)
             reparse = 1
 
         if reparse:

