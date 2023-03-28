Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FDBC6FD18
	for <webhook@archiver.kernel.org>; Tue, 28 Mar 2023 20:38:51 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.8009.1680035929770729070
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Mar 2023 13:38:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WFR0OwRn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so8334171wms.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Mar 2023 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680035928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cNnjWSlXbCts9eRUb+ScVf3U4vrVaLmQGRyDuF+neqY=;
        b=WFR0OwRnRMMiMy97aF66PzZLk9kLPDkJk1nz/eyGSoJoCmF1/uPZJjZG+8MQUW4RoZ
         VHczUZuuXXLd82dRtDAB5B/zTghxUaDlIzNar//2hOZRSB0+bNtRDdvdp3vM61Tyq67B
         J69Vc+HthOxG9pDqiOVg0/pXmC7ByGRgSbHbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680035928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNnjWSlXbCts9eRUb+ScVf3U4vrVaLmQGRyDuF+neqY=;
        b=ELONyCAIO4jtGMg1jFPhjB5bfF2AQ/ssl3L9mXjgiUyEarZsZlG1HejCnEo2nXlAQH
         sgUirXRpopwBtnWHD1IEBwXJ2KIoj7ydakLc+JPFwckjCSGwDgn5XiWl9Oc2fFEb9kAR
         aewQLv/BRG38Ah084HC0vEvqxo0pPZHgKZcmbmJFlqMPpYPY6EkO2AGnQEbo1Se6lNTi
         8mWb3gd/RAFfKMoaDA8ry27GwL7V4S2jewvHGWcYgeXsDjqLxwAXbWO6tU7r/9ci83Ur
         R6K5j79YscIy2Scu5e4lz/8Nba+hcrgXPKIaV9wZECWgqZ/JRi1Duij52C8YAQek4Uly
         sOOw==
X-Gm-Message-State: AO0yUKUmFYzI+MNGSgmtXDznp1/WHyCRThcNx+Il6VmWlI4DGbf4Q94n
	rDlGgHyugzG86MLArJYsg1qBawzy+AYaX6ohJWo=
X-Google-Smtp-Source: AK7set/sc6PHQEPzaJW2sS6dGdwCtpP+HvTeNQ+VJ/HQhsKX/VigKW5yJZ0cnz4ar4n0td0djmvlLg==
X-Received: by 2002:a7b:c8d0:0:b0:3eb:39e7:35fe with SMTP id f16-20020a7bc8d0000000b003eb39e735femr12735520wml.30.1680035927739;
        Tue, 28 Mar 2023 13:38:47 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a292:121e:1e7c:1ae7])
        by smtp.gmail.com with ESMTPSA id s3-20020a05600c45c300b003ed51cdb94csm13589145wmo.26.2023.03.28.13.38.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:38:47 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/local: Mention the value of localpath in failure message
Date: Tue, 28 Mar 2023 21:38:46 +0100
Message-Id: <20230328203846.2604638-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Mar 2023 20:38:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14626

We have an obtuse rare and intermittent bitbake fetch failure. Understanding
the value of ud.localpath at the time of failure would be helpful to debug it
further. Tweak the debugging to provide this in the output.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/local.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 0bb987c644..5332faafe2 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -72,7 +72,7 @@ class Local(FetchMethod):
             filespath = d.getVar('FILESPATH')
             if filespath:
                 locations = filespath.split(":")
-            msg = "Unable to find file " + urldata.url + " anywhere. The paths that were searched were:\n    " + "\n    ".join(locations)
+            msg = "Unable to find file " + urldata.url + " anywhere to download to " + urldata.localpath + ". The paths that were searched were:\n    " + "\n    ".join(locations)
             raise FetchError(msg)
 
         return True
-- 
2.38.1


