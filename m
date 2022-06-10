Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2BEC433EF
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 19:09:21 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.31062.1654888156701037316
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jun 2022 12:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Wdu6zttc;
 spf=pass (domain: gmail.com, ip: 209.85.208.174,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id m25so104599lji.11
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jun 2022 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5ej4RQmn/mzzas0tnMkDdzA9RZ3XybSe3bBCis3V+E=;
        b=Wdu6zttcMb8NA5bGq0yZB9dzmRrmAdNNSLe+REoMkry0te041IGIAKouncZu7iHFnc
         /yzW/kNoozKYUHSdvbUYtQKBMUoP5zzaJ3kfHw4X7a6HiNKzJknOvbjAuLC/wYRIixYG
         h3na3JG8G4ikajzgC0PLpJxGhPKSNSkwqJ2kSw48eFDX10Mm5JqOu+I1U0BREW7wOeVL
         dzKOHWUVARaGbNAhl1NDuYpVvzb1QCWxDphybEok5R0KyCyc2E5aGBLgdmAHjclO/7FF
         r6qa0UutgvQNPa8iJxRoAjGEr3x8oYKcYrHz+8v8DLfJWCzOgu04u5rab0QFTtswSS4T
         LJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5ej4RQmn/mzzas0tnMkDdzA9RZ3XybSe3bBCis3V+E=;
        b=23eLBTTuwSLakwCqst8fzb8RLPnP+04QvJHvMMRaUUNc2axRjkdfaO1TwZg/u3KLFR
         6BWGFbPFZZXcEQTyEI0q+A0w+AUxv+hxVUFOJKkYD0K+C2dEyEVDCU3QaKbAyiX9mc7J
         YCr99TwOcTMvfROZ84ay4AFFYV1y3ztg+tYBX2NIyacNM2gz+AlUfxD67lTmQlFe/paV
         o+/wvgD6qFZ9CDxa4CAI4WkwuF21dsA9yELb8CU4cWJRHtzuYJ0CH+HwLYMTKIbRueQI
         rXzsI/HvG2AXQsIVIGFk/MgoqiJLU8g1h+sJbMzWjTVkYftiOXlpdoTT5oO2M9CIywQ4
         gGug==
X-Gm-Message-State: AOAM5333Nw14mK9qxrxCIVpFESC+iH4r8Blq1ZF3CI15CG7lcnZBfaNV
	MaNXwd7cgoG2aW0jEBZ3u29fWqngkIY=
X-Google-Smtp-Source: 
 ABdhPJzeTnksv02aDefreBQTngoWl37qZkOFmb7LCLayGXYEd/lTFZohHUwI5lFy7U4MK5EQusnwDQ==
X-Received: by 2002:a2e:3112:0:b0:24f:132a:fd71 with SMTP id
 x18-20020a2e3112000000b0024f132afd71mr63699777ljx.522.1654888154388;
        Fri, 10 Jun 2022 12:09:14 -0700 (PDT)
Received: from localhost.localdomain (89-253-118-72.customers.ownit.se.
 [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id
 h23-20020ac25977000000b0047255d21128sm4843620lfp.87.2022.06.10.12.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 12:09:13 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Subject: [PATCH v3] bitbake-user-manual: Correct description of the ??=
 operator
Date: Fri, 10 Jun 2022 21:08:45 +0200
Message-Id: <20220610190845.181330-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jun 2022 19:09:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13754

Stating that the assignment is done at the end of parsing is misleading.
The weak default value is the value which a variable will expand to if no value
has been assigned to it using any of the assignment operators.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---

Changes in v3:
* Update commit message
* Change "... via one of ..." to "... via any of ..."

Changes in v2:
* Add comment to line with immediate variable expansion

 .../bitbake-user-manual-metadata.rst          | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index af4b1358..45355b6c 100644
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
+will expand to if no value has been assigned to it via any of the other
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

