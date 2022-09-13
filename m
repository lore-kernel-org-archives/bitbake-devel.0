Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1C2C6FA8B
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:20 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web08.5358.1663079233557791317
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=qPChgcGR;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id d12so11989320plr.6
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=6U0Uc1Yn5PeWX+SOZ0pogOyiVwBHi7XslDZY8U3gnY0=;
        b=qPChgcGRpAPnVYpyfWBif3dYQHRdMn4s1jnEKV04Qo2VUHiJtRmEOJtNTaNO7pbOkY
         vsFzhzMsbBkoJ80L8rMH9FshFtW0GD9v+c0Ug4UUrqsEnqV59fYvjdGuX0ri5aXe+65D
         jyQ5/tSXNtmcv32sWrH5yNCeTqzAgQQlqKZdfa0bnRFS8t5YY4nJtu9iOJUHJRkJj2pT
         dvpv0j9jXjEUfxJBVzT5OUUn0xugkZeUjDznHNBPwhySdnNI5E277DIU7qig1wnnoh4M
         FRkbafv2ODNFyZBu6vrpF9Vv2i+5vKoMwewcqB/229Yph3fgnpQ1kIeqMIHYk5Rilasc
         nX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6U0Uc1Yn5PeWX+SOZ0pogOyiVwBHi7XslDZY8U3gnY0=;
        b=3KIDvcAEi8cGb2dHFQgvI/lYXlCFVa26HA2gX4gyiKjAEDZsyMzWme7CZvDztFmfSC
         NCHdPM6MiIF7+10rVLpuRgnA0+mxsy0QA4FiLbfb+yQOnwVdPXmdpypSfEXAwULARDk7
         aGDUT+j/xFh/kmBAJ0FyPPPjSZX6EdOkTBFIZ/JzKuZ/o/8+2Deqgv5Lw8W8nhA49WB1
         /Mogn4UqIvLGuJ46ozivOx2/ahYz2AnGxb1w2e8tmp7nkZsNGUB5qkrpbtG31EZPwnzQ
         v3w+VDoE15qUsmLSayvhhgBUPPpU4sal8Jd5VkKvzclHaMSadk7zWJor66rP7HnrEZoh
         97nw==
X-Gm-Message-State: ACgBeo01DQbUF8q4pi6VfrM2ANhk2O/zBjUVFOGkP63KM+7Q7pyhTSot
	WRVVoVH9S0KiE/YhiH/rT2p6sUtog41jYBDq
X-Google-Smtp-Source: 
 AA6agR7k2wWKuaGLt8rtkrKsNN0PhBEtmxSxTLaw4ZnwQiwR95xJmI/6QYq+YdsBdpBWkjB1nu+Nng==
X-Received: by 2002:a17:903:32cc:b0:178:41c1:2e41 with SMTP id
 i12-20020a17090332cc00b0017841c12e41mr5573383plr.126.1663079232511;
        Tue, 13 Sep 2022 07:27:12 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:11 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 05/14] bitbake-user-manual: Correct
 description of the ??= operator
Date: Tue, 13 Sep 2022 04:26:35 -1000
Message-Id: 
 <da80bda3c26695e9d9b34e5e402ad8a61f2f316b.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13966

From: Jacob Kroon <jacob.kroon@gmail.com>

Stating that the assignment is done at the end of parsing is misleading.
The weak default value is the value which a variable will expand to if no value
has been assigned to it using any of the assignment operators.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8189f58d0449d16f162b6e8d98c4e5edc6bff875)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 .../bitbake-user-manual-metadata.rst          | 55 +++++++++++++------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index af4b1358..33782161 100644
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
+assignment operators. The "??=" operator takes effect immediately, replacing
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
-- 
2.25.1


