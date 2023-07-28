Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F79C04A6A
	for <webhook@archiver.kernel.org>; Fri, 28 Jul 2023 16:28:28 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.36363.1690561705920750593
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jul 2023 09:28:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20221208.gappssmtp.com header.s=20221208 header.b=UxSQLXN8;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2217388f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Jul 2023 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1690561704; x=1691166504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gs9ligjdjRTPeOwTjEXdiIj/1KqGFEjojOteBvkg8dk=;
        b=UxSQLXN8uU7D+Uz3bwthOLBm+M/RZCxrjLxl4m+Fk4/wK92Xs062SopENuZK0+5DJY
         NjjnTqeitseK9cfLAhInzeV2hTiWj9SBwzo1FFqMbC243YWziCquY/tKiT6zLoJ1QGcm
         cKeymtmkSqYp8qyxG9RtK/JRhNUgE44zCVCFgxSz3Om2Mwxrl9v9d6obUTkUEmp0qOuI
         4djLObQNCCgi2QowJqfJgmqrJj/Wrk45q+JyOXwhB0D3YTFJw8I73Pvk2zOSQ5SkHm3G
         zDuOjJfaevBC0kmfbrsGjwmSPg2/miXmnmxRHZYqp/PLU9nita1Rv2g6mZywIYxP99tl
         URAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690561704; x=1691166504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gs9ligjdjRTPeOwTjEXdiIj/1KqGFEjojOteBvkg8dk=;
        b=bxC2UJ0RBW2gVq3PZaRQiVRukoOkOpuouX/Kuj432Z7PsS/PewEEOr9XIs4TxO8ZZ4
         P9Sr3GfHvFd/X4S3ZU9LGBVRrXNlHMl6XJhSsPnoj46j4MhYPuU/dCJtcD/6XOm8qcF7
         jIA8mWjpv4vtwY/HIorOOkXA4YgDi+Nqf67Lk/hWWbOOUl2wdKHGRjhtwvbfilL/T3WW
         yvMfmDvLWmoa07ayId2rH7AuXkfdLMeleLasMHNmsUkle0p+QYArbNq9RD7dkwiPwkWM
         Z6mgvzDZ7LX6cPUF5PhoYS3H1mhdXJ72CIFFwPlPCOqkFJO2Z2hwq5sfwbeS72rJBwYS
         3DrQ==
X-Gm-Message-State: ABy/qLYLOSE+aVHp0FlO8g2iPQ1evkZloBljOFmd2YqJtViWpQhWLvCQ
	1R66sk1Kmb9xIj4/WrYSo4QTlVag0CCg/Lokugs=
X-Google-Smtp-Source: APBJJlHfIpO5Cd4nqCNMQOuG3gyo36B/8c8fG+JUGOwsQ0mfQ+Ehq7TmCNQc+t+tvXYhvuVL4/iruw==
X-Received: by 2002:a5d:63d1:0:b0:315:901b:e795 with SMTP id c17-20020a5d63d1000000b00315901be795mr2223898wrw.13.1690561704029;
        Fri, 28 Jul 2023 09:28:24 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.numericable.fr ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id x2-20020adfffc2000000b0031755da6a8asm5176622wrs.33.2023.07.28.09.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:28:23 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] fetch2/gitsm: Document that we won't support propagating user parameter
Date: Fri, 28 Jul 2023 18:27:51 +0200
Message-Id: <20230728162751.1683289-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Jul 2023 16:28:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14893

[YOCTO #13550]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/gitsm.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index f8e239bc5..47225b972 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -123,6 +123,12 @@ class GitSM(Git):
             url += ";name=%s" % module
             url += ";subpath=%s" % module
             url += ";nobranch=1"
+            # Note that adding "user=" here to give credentials to the
+            # submodule is not supported. Since using SRC_URI to give git://
+            # URL a password is not supported, one have to use one of the
+            # recommended way (eg. ~/.netrc or SSH config) which does specify
+            # the user (See comment in git.py).
+            # So, we will not take patches adding "user=" support here.
 
             ld = d.createCopy()
             # Not necessary to set SRC_URI, since we're passing the URI to
-- 
2.30.2


