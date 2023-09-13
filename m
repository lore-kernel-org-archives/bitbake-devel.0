Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78901EE020A
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 19:04:43 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web11.5855.1694631875873170201
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 12:04:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=iCeVVD0U;
 spf=pass (domain: gmail.com, ip: 209.85.210.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6bf0decd032so105042a34.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694631874; x=1695236674; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDM2qxFvXD24qr0smDtHnX4fDwFOceFnlxGQZhrRnWU=;
        b=iCeVVD0Ufcn0pcPdS6FCpHz52z9Lfz3DIbus23YllXBFHmKdfk6LspjrUHETbf+4jO
         uVaS7DIeXTsguRJknwv6GGoETsEbObffUdG32YUMPyaBprweOQyHYabamV6lL2cHctw0
         NEQ+7c57gnpP2gI4Db62ue8Es6FJe31vZ540wRfa5ta8WSogM6MkiO/5LGEZcb1th52H
         GbI8UpuNh7sQ5cZnZGFxrCAFMDTY3xa1grla2pzAJGPlAwT9N0gyM+eddovqt2DRGATA
         6uhtSdfLVlzzCfElUq0authu4s7yPw+tTn/pNYe4WjFXkZ0D8umxipenjt/Qd/cWg5DD
         8srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631874; x=1695236674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDM2qxFvXD24qr0smDtHnX4fDwFOceFnlxGQZhrRnWU=;
        b=mwZnU5Kg+I7je154avsfUnqdCWqExADBEjGwwB26ZwHD2HixfnHpI+bnlsM1EqiEl7
         liodVqLYCgQ4Yhe/K4wPNeRnKTC4oVrtFPVyB7hQE1iiy6z0Itf+yklnXElM7yFBO6BI
         sxkvbnE81GVA0/qkdCH1HnCNAot6IG5PWBewpb/HpR55DWQdOR8BZMWNefa4uHI1Cr9k
         0MC1QodFgm4aF2vLkYVHgaqDD/p4pJzsLlz1/7R/X7f9DpcRbUJSMqv37OwXXUJpBprq
         PIiFQ/1SJIJK6tjXeNz1ttLwORhVoAFbYVi4vgQPwTst+0xN5uq89TeZTJo20S3gZ4Tz
         puDg==
X-Gm-Message-State: AOJu0Yw9Bo6/THBZCVVUa3YQ7y65YKMkarJnwhXSPfEFSAMcx/R9asm2
	b9b6UjZT+BlJIizSTCIEtukn8BIdcjg=
X-Google-Smtp-Source: AGHT+IHl5QYqG6l+FdJU8dyPxUFBcrvKKuolnQKHIpmtvEeRe0K76OEJjvS9Lhvz8Jw4OY0hJd2Q1w==
X-Received: by 2002:a9d:7ad4:0:b0:6b9:67e4:eba7 with SMTP id m20-20020a9d7ad4000000b006b967e4eba7mr3837540otn.23.1694631874396;
        Wed, 13 Sep 2023 12:04:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::88cf])
        by smtp.gmail.com with ESMTPSA id f16-20020a9d5e90000000b006b83a36c08bsm5189593otl.53.2023.09.13.12.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:04:33 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 0/2] fetch2: git: Fix path check for git repos
Date: Wed, 13 Sep 2023 13:04:23 -0600
Message-Id: <20230913190425.3761792-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 19:04:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15055

The original implementation of this didn't account for symlinks/bind
mounts/etc. To simplify the code, make a new helper function called
path_is_descendant() that correctly accounts for these, then have the
git fetcher use it to determine if a git repo needs to be re-cloned.

Joshua Watt (2):
  utils: Add path_is_descendant()
  fetch2: git: Use path_is_descendant() instead of path for repo check

 bitbake/lib/bb/fetch2/git.py | 15 ++++++---------
 bitbake/lib/bb/utils.py      | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.34.1


