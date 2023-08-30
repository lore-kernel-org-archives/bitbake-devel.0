Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549CFC83F15
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 15:30:53 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.105.1693409444310108944
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Aug 2023 08:30:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GxBYFYGO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-31aeee69de0so4852223f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Aug 2023 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693409442; x=1694014242; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=duMshjsPWwzAUvcTHV8Xm4KsuzGTldlcFlGDHJZd6oc=;
        b=GxBYFYGOdtzSXDLA2pahb/1mnHDuNEb36SWsDZMtfcVPxj1Mh4ELdje92T3ChHQmyY
         D3hMawXIC8IHek+MaXFywwJr5jXI8PNMy1yRL73wwCr0BKSzrhBGhoR0XHTfohl+0BiT
         K4Y58BjIX4z+JjC/9IwKvjvBa8BtvtXaVCn00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693409442; x=1694014242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duMshjsPWwzAUvcTHV8Xm4KsuzGTldlcFlGDHJZd6oc=;
        b=S/JZJSI5++5iC7sjf2oPW31PAVl/jyBtEFSKAU8CcYLUa9KnZWm8yXC5BXmmoZHsdL
         dVjlcRp/rnH+CPtEYErjTTcLgpM7KBoF6vApP0pfAsPpA17pyEloAspxiljIMHxHEQys
         23ZAgSU7NfZbDGrQsHAW4gOj/cvtRcasqywy8DpCIwV2B48lbpsF5J1VzN8gK6SiiUJT
         xPNnFFA6ZuwO51un6uPqntWTpbAYdfai9csdXTf4SfM6CoXlU4z1OD4aE1vjSma+S34e
         Y03BzNeuA5vnWxVHtUtspVrRRL+CQUuVRki1apGBhG6UiVb87aVSEKWjUs0FN2w2IXki
         iacw==
X-Gm-Message-State: AOJu0Yw1yPfTE+IznvitzjWdVCP3DcN0GrLVlee3X/2bMqDp2vigew5u
	GVvv4Bpgqta47dEXGpnlq/kKtgqbD/BL3fN114M=
X-Google-Smtp-Source: AGHT+IH1XWHPCuJKhJ0gIqoTKZBSzzeAe8/LbzDm0cNcZu28rnUIjA68CdaFWNmJew4MjJZqgj5JtQ==
X-Received: by 2002:adf:e946:0:b0:31d:c36a:bdf9 with SMTP id m6-20020adfe946000000b0031dc36abdf9mr2206220wrn.67.1693409442366;
        Wed, 30 Aug 2023 08:30:42 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:15ec:a052:9304:60a5])
        by smtp.gmail.com with ESMTPSA id d10-20020adff2ca000000b0031c5e9c2ed7sm16914970wrp.92.2023.08.30.08.30.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:30:42 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] README: Update to point to new contributor guide
Date: Wed, 30 Aug 2023 16:30:41 +0100
Message-Id: <20230830153041.2015294-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Aug 2023 15:30:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14992

Now we have a contributor guide combining various wiki pages, point at
that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 README | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/README b/README
index e0f12b49f3..38a461f5c9 100644
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
+Please refer to our contributor guide here: https://docs.yoctoproject.org/dev/contributor-guide/
+for full details on how to submit changes.
+
+As a quick guide, patches should be sent to bitbake-devel@lists.openembedded.org
+The git command to do that would be:
 
     git send-email -M -1 --to bitbake-devel@lists.openembedded.org
 
-- 
2.39.2


