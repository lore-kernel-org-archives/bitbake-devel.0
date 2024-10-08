Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE35CEF16C
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 12:36:41 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.8084.1728390995323358906
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 05:36:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Xr2aqghy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cc810ce73so2944776f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728390993; x=1728995793; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVHyIEg8w++hN0pohrf4BdPgbxgVUKfJ8HephhM1P8Y=;
        b=Xr2aqghySTQ8eAF7YG3GuS2SQoOxt/6UjCCBl+fE5LoW0BtJ/GE65pwyDZUhtrTquD
         S4Fjg0vIiwco5o5r6N7DhT+RfvQxnw6GoRM6Pd+/xCKr2buZWAyQuLt60kRbm6Bsul4M
         RWWa5t416D+MkSSlgYu999+CtpQgostO2L2cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390993; x=1728995793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVHyIEg8w++hN0pohrf4BdPgbxgVUKfJ8HephhM1P8Y=;
        b=SXvsII6+AUXX936lacSrB7FVmDLHU1a+IF31OCEYgyhMxoMJ4N2W41/KHnQOiNQgi6
         QB8rZqb42CJRXIV08r2qjLEeIJ8VCQPjSaelQ4rSaf8j4Wbd11RkXmfH46ciVcGN/niH
         XM54x7tNeIJEvfCPpt/RV5aMlI/AdG58tRVG6UEbNWLPp/XJjr3+ixZ6B2rkGwaXrlRl
         5GIoKcOv8Mr0wHa8fqAQh7QTLaS/vgBoFuB4tFi3crXp6Rmj40JVK/G20B2IvC2prkIE
         ql1fFZSuAO/Ni1zfa0S/o4Ny9pR0oW4+gRLvwECTWCqoIQll6CFbDr6h/hweupwriDFC
         wF5g==
X-Gm-Message-State: AOJu0YxjCEv3iLQqltciXUrK3nU/juFCd3wpJUfbxJhjhMRPXbJYYbOw
	b0p+kHzfhf6YNsdHft76zeEZkhvmMm6S/EqKoyYa95xrxhsUPnN4a6F8rEqt3JTq2/aV80iEB/D
	i
X-Google-Smtp-Source: AGHT+IGdaPiEJ7xWpOPsSl3TdBqUbl0eCtfkMFR/6dqcKw3W9dVXnUanITK9BydjOjg4vnmGc10wdQ==
X-Received: by 2002:a5d:5751:0:b0:37c:c605:218b with SMTP id ffacd0b85a97d-37d0e792649mr7210456f8f.35.1728390993441;
        Tue, 08 Oct 2024 05:36:33 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f9a:5ae5:8636:3d57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a47esm8019492f8f.28.2024.10.08.05.36.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:36:33 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 7/8] toaster/tests: Fix kirkstone numbering
Date: Tue,  8 Oct 2024 13:36:26 +0100
Message-ID: <20241008123627.252307-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 12:36:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16660

When the fixtures were updated for the styhead release, the test cases
were not updated to match. Fix this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/functional/test_create_new_project.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index cdfdd9ab20..c3b5679514 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -110,7 +110,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
           - Release: Yocto Project 4.0 "Kirkstone" (option value: 4)
           - Merge Toaster settings: True
         """
-        release = '4'
+        release = '5'
         release_title = 'Yocto Project 4.0 "Kirkstone"'
         project_name = 'projectkirkstone'
         self._create_test_new_project(

