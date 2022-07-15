Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2F1CCA47C
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 11:21:35 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.5232.1657884086350652840
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Jul 2022 04:21:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ll+bJKEs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id e15so1072561wro.5
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Jul 2022 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZhL6h3Z5+w5gQ/KEqCmTAYJtyzaisSZbUi6tSfQEF6M=;
        b=Ll+bJKEsSB/jIu1RkMHLHrZ/ZeAsRCQ+UJ4t7K9qewr+bt9tvQevuWVBuCsG8EQtoW
         x/i/3MgE+KgsoX6Fqum3CaTOsBCOwm15c8xSn3VLaeLEB+GKL7EYfy4onD0k+MlsTiUI
         VWzg3Np0f9IOxhUvTaMI1EW0gnSqEeDzTikFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZhL6h3Z5+w5gQ/KEqCmTAYJtyzaisSZbUi6tSfQEF6M=;
        b=ilfWcdeggWH5n0o0X4+rePEzm22l5SwWR9gEE3JEW6Yzr1V69ljvf3b4vnvz1+7klU
         plxXrGP0rkPMNNnJGBd/QZAyRjxKLvGbscJbe1m3djXyvtaH7buHQT+YUktNUELqXCxi
         q1Ntg8rjGA7IceqgEWEZWNWWVcc6Cai+ciSwwi8WVbXNbRACMo5KJpulcR0CGQZMqyS/
         sN3eqJLokQs3dTJh6KPBfB/ZxfKnKCdW/ICNIk4w3BmDYEYxQqHMY6g2wQN6TTeLfu5u
         rO05Q3pFFde/OuUEexAXpTxnLLm9nJGvWJR2cOUwE92AfE+uU/N5VBjZtgCb+NI+jMhX
         W/DA==
X-Gm-Message-State: AJIora/pzz62IkmKSW4BuV3eNRzhef3jEVAR7kcQY7pfVNbl8W7FD5i1
	NqjPp9MulxGD4BCx8fyor+n9/nmH0p9wfw==
X-Google-Smtp-Source: 
 AGRyM1u/IA5Wy5ZftfRftOeVE6vxkEv8Ww/gfefK38A+gMOd7PI4Qlmy52CjbnbrDBEf3pLaC9AsiQ==
X-Received: by 2002:a05:6000:249:b0:21d:a952:31f1 with SMTP id
 m9-20020a056000024900b0021da95231f1mr12581069wrz.411.1657884084478;
        Fri, 15 Jul 2022 04:21:24 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ef6a:f831:81f1:d696])
        by smtp.gmail.com with ESMTPSA id
 d15-20020adffbcf000000b0020fff0ea0a3sm3628229wrs.116.2022.07.15.04.21.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:21:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] fetch2: Ensure directory exists before creating symlink
Date: Fri, 15 Jul 2022 12:21:22 +0100
Message-Id: <20220715112122.634528-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220715112122.634528-1-richard.purdie@linuxfoundation.org>
References: <20220715112122.634528-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Jul 2022 11:21:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13830

If the mirrors code is trying to create a symlink and the
parent directory doesn't exist, as might be the case for sstate
mirrors where the fetch is into a subdir, it can silently fail.

Ensure the directory exists in this case to avoid issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3eda9bbe70..0fb718b23e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1097,6 +1097,8 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
 
 def ensure_symlink(target, link_name):
     if not os.path.exists(link_name):
+        dirname = os.path.dirname(link_name)
+        bb.utils.mkdirhier(dirname)
         if os.path.islink(link_name):
             # Broken symbolic link
             os.unlink(link_name)
-- 
2.34.1


