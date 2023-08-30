Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489DBC83F01
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 15:28:03 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.8.1693409275188449281
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Aug 2023 08:27:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fORkP1Qc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so15571835e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Aug 2023 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693409273; x=1694014073; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+se9EpOF5qyfqstYmJ05yX2OtE6YAqDwcPrad5OZ1KE=;
        b=fORkP1Qc//0/lQo4QOh9gyyrPYSuXE9LoM7YTlUldCL9kcCeefmPzGL5eNNcqpqkoh
         zjy051MI2uJDu48+5GU/Q5dHvAKPnbGZlmwyE/NLiriKd/hZ0GccZOL5zRVe7NV5p5Zd
         cTEj76cn/Fkb2ddGj3qun11SQ1+opkhWiKkQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693409273; x=1694014073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+se9EpOF5qyfqstYmJ05yX2OtE6YAqDwcPrad5OZ1KE=;
        b=jGe3tWqnmFWUQeOOsvuLyDGrib+4fvDW78JtDSkUQuuzr06QxyeYJO1ELoftScDhir
         PRpy+9ab8Y3njWRiKUsr6m5ITBTxm1Y39QOZF+CSHZEjkXBIMMEk8QO4NhzHx4myekF8
         K/UtoRW2z8nDUpiFqZicEDHEXwszTBhWdpXCAL4cBCmMxqgZ6iQjvK6U6Jy7tp6ePFs2
         R3un+QP9TMGLEgQIDzUgh3mMRG2fX++AAJYs+FqAeIafbMMxmHwKtLfyxmZ7HvZC2/qv
         lSZQDd+fngBJGhsiXWVwyQfgenGY8BmQ0nirmCWsLO6U2Ase7G5Xgc4LNqAnt5VTiE+O
         HgxA==
X-Gm-Message-State: AOJu0YxWCshoRn8O7DxFV4yki7MbWR1bSpUO5QUvzm95A7XkflwSkBCG
	cvPdAyCQ+o24Ie2wDsBURUtnddaLrmj40j9MNyw=
X-Google-Smtp-Source: AGHT+IEoZ7cn5gJk43HmdYpzTpG2HLFdHrepsOepiIAyDII1CxWdC3PEB9wuFMGx2pZRjgbmprAFKQ==
X-Received: by 2002:a1c:4c0d:0:b0:3fe:d780:4f7a with SMTP id z13-20020a1c4c0d000000b003fed7804f7amr2008558wmf.3.1693409273083;
        Wed, 30 Aug 2023 08:27:53 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:15ec:a052:9304:60a5])
        by smtp.gmail.com with ESMTPSA id s5-20020a7bc385000000b003fe61c33df5sm2607056wmj.3.2023.08.30.08.27.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:27:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] README: Update to point to new contributor guide
Date: Wed, 30 Aug 2023 16:27:51 +0100
Message-Id: <20230830152751.2015138-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Aug 2023 15:28:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14991

Now we have a contributor guide combining various wiki pages, point at
that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 README | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/README b/README
index e0f12b49f3..46096d82a0 100644
--- a/README
+++ b/README
@@ -18,13 +18,11 @@ Bitbake requires Python version 3.8 or newer.
 Contributing
 ------------
 
-Please refer to
-https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
-for guidelines on how to submit patches, just note that the latter documentation is intended
-for OpenEmbedded (and its core) not bitbake patches (bitbake-devel@lists.openembedded.org)
-but in general main guidelines apply. Once the commit(s) have been created, the way to send
-the patch is through git-send-email. For example, to send the last commit (HEAD) on current
-branch, type:
+Please refer to our contributor guide here: https://docs.yoctoproject.org/next/contributor-guide/
+for full details on how to submit changes.
+
+As a quick guide, patches should be sent to bitbake-devel@lists.openembedded.org
+The git command to do that would be:
 
     git send-email -M -1 --to bitbake-devel@lists.openembedded.org
 
-- 
2.39.2


