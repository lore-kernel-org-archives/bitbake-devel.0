Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E1C433EF
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 09:24:14 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web09.2496.1655285053248897354
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jun 2022 02:24:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=hN6PFIxu;
 spf=pass (domain: gmail.com, ip: 209.85.167.43,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id w20so17919827lfa.11
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jun 2022 02:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=njy2CoZVi6yFu/T6Ps+/D8a00VaO6+iKOADHkJYvaXc=;
        b=hN6PFIxu3uBV1/P8aXZbn8PicnY2MJpOb2ADyJE/tqq6T6hR1BHa591jDs4ibAJAul
         P40O9fZd+yInWNW8qZNqnkFHwoXroAemN/G2HIw/tK8wXv5dyKfczf9BaLbcj7i2MgMA
         1ov3bRcRU+y3CN+NE8hizxifzfeROtjSknfkz8s/TZ51UERPNEg25k41Jvdjnw9c5fPt
         s5JArpSgCVNhd6l6ZAGmaaJ4kAON5JxawRGD2oIi37eVwd0mgn+z92teAV9bKT+BXhZ/
         0D4JIarmKHNLBDFhHTNkVMeKNma4fNsBbbzZTVDEuhePjuSQhdxSXxnwydCjdmWqVwNY
         BiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=njy2CoZVi6yFu/T6Ps+/D8a00VaO6+iKOADHkJYvaXc=;
        b=SV7bJruFa9O8ePi3/0m09XfNvhBrT+GZlQnKsiMx/wm94ih4rSymF60hmBtHCiaW7u
         XeCKJVJ5vC6MXNxXy7l4fJPiQnKBrtALxmphXKPsugsq0mHcLnbIQ4QLJte2gPFl1O2v
         1V49yzgaZZNm70rXlraojV6fRBRa1gFILJhnbiztWVOHCdiwSdUaw/WPlt2lMMceQsm9
         0jLuvLPFxOlubSAuEb2+YJkSFiKzFXLr+lDoIlbqTWyS5CkKbnku/wCcLCNumzALjMW/
         CXYDG/Ih7w7tg622WSYBTmh94p/ol8aXsdSYS0CnCNv1BS2vNZpUJgVF6Jm3Aobhdyy9
         y9xA==
X-Gm-Message-State: AJIora8h21W/VgermGpexIazjX05/iIwkbFwqXqh+8U0r7+oN2iDurTK
	YHcE/lIwoI0rA3cPQxSdbeBpODNhYeg=
X-Google-Smtp-Source: 
 AGRyM1u1XC35bDa/VpAD49/0cRcqfJghlzDFbs20y0w8yqL7kTy/BD4qryzTr26nKg3CpX4iDbAh1A==
X-Received: by 2002:a05:6512:3189:b0:479:7513:7ee6 with SMTP id
 i9-20020a056512318900b0047975137ee6mr5446291lfe.584.1655285050665;
        Wed, 15 Jun 2022 02:24:10 -0700 (PDT)
Received: from localhost.localdomain (89-253-118-72.customers.ownit.se.
 [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id
 t22-20020a056512209600b00478641f62c0sm1730146lfr.28.2022.06.15.02.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:24:10 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Subject: [PATCH v5] bitbake-user-manual: Correct description of the ??=
 operator
Date: Wed, 15 Jun 2022 11:23:45 +0200
Message-Id: <20220615092345.327707-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Jun 2022 09:24:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13765

Stating that the assignment is done at the end of parsing is misleading.
The weak default value is the value which a variable will expand to if no value
has been assigned to it using any of the assignment operators.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---

Changes in v5:
* s/overriding/replacing, since "override" has a special meaning
  in the context of Bitbake

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

