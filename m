Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8E2C43334
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 12:36:47 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web12.6749.1654259800941299273
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Jun 2022 05:36:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=bi1/whJK;
 spf=pass (domain: gmail.com, ip: 209.85.167.51,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id l30so12406054lfj.3
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Jun 2022 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtUesBetWylPBysfYWkyYx+bIgj4ZTOY03hvdB2oQR8=;
        b=bi1/whJKI0rCFs+tH0j4Ceq+cYazbX9IeOXcfrZ+v+7IWUB/hzHG0BsizQxhQCxQof
         wqHwCUfoSN+/gUF7i+M33PmXP+s/MBE6yOHhELvr9VhA0k+gWV9aVAWd9nD27PxaowIn
         xRR8uXmYJEjvxjVDWPJ7tqjduwQoUYrZ6Xf7ZK2f9FPT472zZwHe8azUDwImvTC2QUmN
         beCFsjYtOrlgPVIe4dNQWU4kbeEVjIT9+uR/E6wWbhZT5a9RUg1e7iRYDSxyqw+QjJqB
         DcbgPxXc7uyH93almX8perHO/hbEB2VTw1kd/H2LnsPJOaIE5Ez6ODp5obbyIsIQC0nf
         ugDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtUesBetWylPBysfYWkyYx+bIgj4ZTOY03hvdB2oQR8=;
        b=Mf5AsYzpEBF18KTm9c9ktn4xPo0eauQouBp8HO4P9ATTCBrWgSRWEbcAVIOittu6Hq
         f1RhQjGZbFB1uWVP8KlmyQjcTaK9taUoXawBpTaiT/w1hJGsSUfcqSNhz/yxt8G4EsLg
         IBMb/OlU0Pth74M3U1mU73cYjZws30bAA+RO22Bh6haoUrylTf2Mup9CKBe1ReWp+wuv
         8XbqASrBXQ5cnI4sYHHbpKxY/FJcFtos/XtwNu2eDOOb216Uxx2vOgENeuw1rvpKKK5j
         9BNdBaXy/d4GoQjRDRwerpTf7IZt6iY956nTSFvOrUr6vHQMKDRS1wfxD8aqgNsi08OJ
         BilQ==
X-Gm-Message-State: AOAM530la8teSRQyF+nTXYOV6vVzvQfjH6s2qjSw5Wf/npt0/PdW2ghw
	E51HkVDOeR8d9b2JEjn095yyOFTcBYk8XA==
X-Google-Smtp-Source: 
 ABdhPJwW7M3BTedFP8v9BtTYEdR4SXjDr85XG6POD1/sQqQiDb6hZ/hiO4z+ZyMEUUUMNwWo2BBOTg==
X-Received: by 2002:ac2:4e04:0:b0:478:8cf7:7026 with SMTP id
 e4-20020ac24e04000000b004788cf77026mr6623593lfr.602.1654259798938;
        Fri, 03 Jun 2022 05:36:38 -0700 (PDT)
Received: from localhost.localdomain (89-253-118-72.customers.ownit.se.
 [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id
 v6-20020a056512096600b00478f1e04655sm1574417lft.14.2022.06.03.05.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:36:38 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Subject: [PATCH v2] bitbake-user-manual: Correct description of the ??=
 operator
Date: Fri,  3 Jun 2022 14:36:18 +0200
Message-Id: <20220603123618.32173-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Jun 2022 12:36:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13731

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---

Changes in v2:
* Add comment to line with immediate variable expansion

 .../bitbake-user-manual-metadata.rst          | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index af4b1358..cfe46562 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -195,22 +195,21 @@ value. However, if ``A`` is not set, the variable is set to "aval".
 Setting a weak default value (??=)
 ----------------------------------
 
-It is possible to use a "weaker" assignment than in the previous section
-by using the "??=" operator. This assignment behaves identical to "?="
-except that the assignment is made at the end of the parsing process
-rather than immediately. Consequently, when multiple "??=" assignments
-exist, the last one is used. Also, any "=" or "?=" assignment will
-override the value set with "??=". Here is an example::
-
-   A ??= "somevalue"
-   A ??= "someothervalue"
-
-If ``A`` is set before the above statements are
-parsed, the variable retains its value. If ``A`` is not set, the
-variable is set to "someothervalue".
-
-Again, this assignment is a "lazy" or "weak" assignment because it does
-not occur until the end of the parsing process.
+The weak default value of a variable is the value which that variable
+will expand to if no value has been assigned to it via one of the other
+assignment operators. Here is an example::
+
+   W ??= "x"
+   A := "${W}" # Immediate variable expansion
+   W ??= "y"
+   B = "${W}"
+   W ?= "z"
+
+After parsing we will have::
+
+   A = "x"
+   B = "z"
+   W = "z"
 
 Immediate variable expansion (:=)
 ---------------------------------

