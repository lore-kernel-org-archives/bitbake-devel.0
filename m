Return-Path: <johan.korsnes@remarkable.no>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0863C4332F
	for <webhook@archiver.kernel.org>; Thu, 29 Sep 2022 12:21:55 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web09.9598.1664454106614890189
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Sep 2022 05:21:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@remarkable.no header.s=google header.b=c5DueE21;
 spf=pass (domain: remarkable.no, ip: 209.85.167.42,
 mailfrom: johan.korsnes@remarkable.no)
Received: by mail-lf1-f42.google.com with SMTP id d42so2021358lfv.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Sep 2022 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remarkable.no; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=K0zBWWgjrcwARSrEiMrpZ1CJ8zOgylTVr3cQGUMbmpw=;
        b=c5DueE21NN+KoEn83z5/9yxZZ7nSdzmZ6t8dWQE4ZLB8hbEXTUuPFJqU10kHiZbADD
         3QFuvfeAHOOTsSf/1ZmGU8D5hGNnxs9Bxr+rTm6vPWTwe94SHG6vyqHLOrsCjIpTI90l
         VEf//Yj87UlK4c0vAIrB0iOH8yliSWonIC8iis0DzMoHNfICaEKtTKmr+TyT7C0rsaVX
         P2Qq1z/JZ8Pyl2GdynRXloW4kEgKOD2G6wqjVrCEGYwjIrllyQKeVcl989X/qwlZh9eg
         wlgepkXv5cKyOG/4/7+hgGx0ahI6nEOXJLZBs6JYk6g4MsEPv9HoxAKTZeFzrEv7RtXR
         V5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=K0zBWWgjrcwARSrEiMrpZ1CJ8zOgylTVr3cQGUMbmpw=;
        b=LXtIBSKFz3zTgLcj1s26xN3sXXfgJpPSiojmTOW9UvlU4QamGw+jLL84AqOnTfRRf2
         pTm57wimu3q2xS/3jM9fNyCc3EGozqj/pYLVMHWdpg5rHKJN35pcu3GconJgBc+Jm5QQ
         DeN568XBv3UeMmr5+16Z2hygqqqiX4KwL2NNLUVB3MAKsaKbQI8tdweLM3une3JvvzGq
         vDtm7IBbxA1E90wIQW/tfbaQHGV0hFks4Dxnb6ygRN54Xxe5h4D5QLrNrQlk3kn9LPPC
         ZxSiPXrHVsOfAjSBxinqBV2huqDNXgXbHyHbN8ZqQe1LVdDaoKa9EC9ROI198mCMdOKP
         uJwA==
X-Gm-Message-State: ACrzQf39PTXS+PnBIrFejU7tTq1LrpKEknLFClNbiBWOByjptgVqvKEb
	e7MbXW109DhBL/6e86QZLx4mxJm3leTpTAU=
X-Google-Smtp-Source: 
 AMsMyM7WO8SjmZHeoUGz6AMrD/fRrf+/ub8PSo1UA/4LkD+M1nVSdL6tU2psEuPxAJcqc8U10ncfSg==
X-Received: by 2002:a05:6512:2384:b0:497:ad1c:799 with SMTP id
 c4-20020a056512238400b00497ad1c0799mr1251773lfv.294.1664454104903;
        Thu, 29 Sep 2022 05:21:44 -0700 (PDT)
Received: from localhost.localdomain (217-13-24-82.dd.nextgentel.com.
 [217.13.24.82])
        by smtp.gmail.com with ESMTPSA id
 m8-20020a056512358800b004947f8b6266sm770986lfr.203.2022.09.29.05.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 05:21:44 -0700 (PDT)
From: Johan Korsnes <johan.korsnes@remarkable.no>
To: docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Cc: Johan Korsnes <johan.korsnes@remarkable.no>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Ross Burton <ross.burton@arm.com>,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH v2] bitbake: user-manual: inform about spaces in :remove
Date: Thu, 29 Sep 2022 14:21:33 +0200
Message-Id: <20220929122133.261961-1-johan.korsnes@remarkable.no>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Sep 2022 12:21:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13999

Inform the reader that there should be no need for spaces in the value
when using removal override `:remove`.

Considering why spaces are used in the other override operators, it
might seem obvious that they aren't needed for the removal operator.
But, it seems like I'm not the first to be confused about this.

Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Ross Burton <ross.burton@arm.com>
Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>

---
v1->v2
 * better wording :)
---
 .../doc/bitbake-user-manual/bitbake-user-manual-metadata.rst   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 337821612c..bc27eb1b6b 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -330,7 +330,8 @@ Removal (Override Style Syntax)
 
 You can remove values from lists using the removal override style
 syntax. Specifying a value for removal causes all occurrences of that
-value to be removed from the variable.
+value to be removed from the variable. Unlike ":append" and ":prepend",
+there is no need to add a leading or trailing space to the value.
 
 When you use this syntax, BitBake expects one or more strings.
 Surrounding spaces and spacing are preserved. Here is an example::
-- 
2.37.3


