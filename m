Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8396C43334
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 04:24:52 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web08.566.1655267085522921888
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Jun 2022 21:24:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=CccyBKMh;
 spf=pass (domain: gmail.com, ip: 209.85.208.176,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lj1-f176.google.com with SMTP id s10so11847985ljh.12
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Jun 2022 21:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLbN7TCGqHhlbbEz3O4iqGif4uLIOMmfSjumq/Bkrzc=;
        b=CccyBKMhZQcvKXfObYEESep5mfWgHYnKyojnbYaYn7Lyt4EBH+XY1uctRusT8KumcT
         A4haRBhx++oqT1erIo/Lg4bRsGpDZKtuJQqdg5jxQ92SIcFJkpBmAvjwcuQuVQfOJlHM
         bSy0llywv2+IajCvxaIX/L+JpTcd/SDC+W0/rBKo6CeHEWwI5kv4LOIw8P7pnybJtyUu
         4CdDvZs+8Kot/jhYcztI2VpqKqGvHt7046fF5Qqmhu4g/3J/+4S7Jz1mKxoi9x5Phl4v
         TyCPw2Ra7PaZ3iGz1ZLpKxrkkKQ1dnNXPlbTM9TnDBELsGSxhrnNwOd7ycByXU9D5oy7
         uTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLbN7TCGqHhlbbEz3O4iqGif4uLIOMmfSjumq/Bkrzc=;
        b=q4EYstr4q6sy+vxR8eNBGC2LZQs95w7EPAUwPJwlK+pJCGF0kZCzi5m5VXhM9VX5Pk
         NLiitMAtyEAHvAu0zg0mI3Q1gtH3RkabXZbYoSmFXGMo6i62TiEMRjIF9cNNaCOV5bmv
         z+cdJpjJkFGPqnDStcMCBDLTOA5/ok8c5BT0zo+fGJIJxOkQFXuCJZ7qiKnFIuxycE5X
         f0Z3+c/s1msHzdFfsAW7v+WGU8Mr/lCAQausgxcKuCAaHvCkHQTWhn5mujK3BCZ5Y0hh
         l49W85CIKAidwvF7LSiZ9n6tFfHxoHrmSz38xuulnIQce6ucQPny2xUrE4PNMWX2TgSV
         Knfg==
X-Gm-Message-State: AJIora8gc2p3G+aEnSgWurZvO0xX6oImxsnow/dsl6sW/YTnL7ubnISP
	6TVAICrNm+ovil1W/OxYiIKZ0w2gFm8=
X-Google-Smtp-Source: 
 AGRyM1unJ9vE0B3Tc53xkcngTT9c9nITYOY7PT0qY6TOD0rAwzoFBQh4SUsvhivk0JH+xBJEXv8QtA==
X-Received: by 2002:a2e:2415:0:b0:259:63b:30e1 with SMTP id
 k21-20020a2e2415000000b00259063b30e1mr4024225ljk.33.1655267082952;
        Tue, 14 Jun 2022 21:24:42 -0700 (PDT)
Received: from localhost.localdomain (89-253-118-72.customers.ownit.se.
 [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id
 7-20020ac24d47000000b00478f782d045sm1640095lfp.174.2022.06.14.21.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 21:24:41 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Subject: [PATCH v4] bitbake-user-manual: Correct description of the ??=
 operator
Date: Wed, 15 Jun 2022 06:24:24 +0200
Message-Id: <20220615042424.7606-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Jun 2022 04:24:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13762

Stating that the assignment is done at the end of parsing is misleading.
The weak default value is the value which a variable will expand to if no value
has been assigned to it using any of the assignment operators.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---

Changes in v4:
* Mention that "??=" operator overrides previously defined weak default values
* Add examples when appending/prepending, with and without override-style syntax

Changes in v3:
* Update commit message
* Change "... via one of ..." to "... via any of ..."

Changes in v2:
* Add comment to line with immediate variable expansion

 .../bitbake-user-manual-metadata.rst          | 55 +++++++++++++------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index af4b1358..3250c205 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -195,22 +195,45 @@ value. However, if ``A`` is not set, the variable is set to "aval".
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
+assignment operators. The "??=" operator takes effect immediately, overriding
+any previously defined weak default value. Here is an example::
+
+   W ??= "x"
+   A := "${W}" # Immediate variable expansion
+   W ??= "y"
+   B := "${W}" # Immediate variable expansion
+   W ??= "z"
+   C = "${W}"
+   W ?= "i"
+
+After parsing we will have::
+
+   A = "x"
+   B = "y"
+   C = "i"
+   W = "i"
+
+Appending and prepending non-override style will not substitute the weak
+default value, which means that after parsing::
+
+   W ??= "x"
+   W += "y"
+
+we will have::
+
+   W = " y"
+
+On the other hand, override-style appends/prepends/removes are applied after
+any active weak default value has been substituted::
+
+   W ??= "x"
+   W:append = "y"
+
+After parsing we will have::
+
+   W = "xy"
 
 Immediate variable expansion (:=)
 ---------------------------------

