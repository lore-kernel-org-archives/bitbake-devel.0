Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AC8C43334
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 09:47:26 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web11.5485.1654249638581208114
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Jun 2022 02:47:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=bbl2chU0;
 spf=pass (domain: gmail.com, ip: 209.85.208.176,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lj1-f176.google.com with SMTP id l18so552789lje.13
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Jun 2022 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Xs6YMdyBNr4HMzTIJM0dE9Nrx35XAkRrmTz+oQJpP8=;
        b=bbl2chU0FZ9RnpeP55OGfGXBkYo7VvkQq1VZs87iVPWEKa5sguO/J2qOVink2A6fdI
         aCsIlcfhc456op/sAskeCjxKr41JlpCRZ0wDKoIUob3ImW22umZc6O11B3X/Ae6VNMRh
         eDQQd9G28NKmuWg29LrWkt8VpjV2kw/jWtU0OM5y98SymIhQ0aKjiKmtu/d/oUmELCDn
         s8SBUk+TwO6jj/ExEuP7YDrjiwJt86i/OYqr79fxQvb79dEvKSSGQs/M/yOJNSlr9kGq
         pJbHc7jM34/Ad5CSpXEdHDfuKZ9WbTGjuzmGEq/CO7KwdNt60QwIbzzxNQEI7JkLNq8N
         vHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Xs6YMdyBNr4HMzTIJM0dE9Nrx35XAkRrmTz+oQJpP8=;
        b=DcERZJhSlNZoBWdQdNOhTsrt+TkQVUSlW/jwooAfZINcqw9vcHUUrAD0dvqk5mycFV
         +gmdC6sT/CCtt44KBvIgeJzwyE7k9OpvYhvZtQ3jdoc7i4y4q63c1EkkOw9t+MAfbANg
         OOTZNTbqlIFODT1A1h9Mxv+5+7UurbFayp0KfAP88akOd+DJ2rhAsRZTPJbwC/uIIZPl
         EJ6XeV0CK2HqY7pMgH3cTzSSaW7Nn+V19bSyq1/+mXnxmMFOOCxulAXRNef3OQxOJhf/
         XLewxp/3Fzih+QeScSeuk//RGlhFSw7wS/XRGgg/FlcgA3/sLqOS0H7fqZ9eBKZ0/JiQ
         Fd/A==
X-Gm-Message-State: AOAM530FwNZzKj/JzuSqta6/WJx2SlFyIznu298viqxLDFGpd3Wea1GU
	1QbxHVZ2J3sVEjst/Ecg7SX6+teIfXeu1w==
X-Google-Smtp-Source: 
 ABdhPJyC+t98DSZfScIKSSDGXuSzbJJI2uVeuBBzZ3fj6p9KkoCNyotBDRJsluY0Xw8VYhEiPjiOzg==
X-Received: by 2002:a2e:9584:0:b0:255:829e:590a with SMTP id
 w4-20020a2e9584000000b00255829e590amr460814ljh.170.1654249636474;
        Fri, 03 Jun 2022 02:47:16 -0700 (PDT)
Received: from localhost.localdomain (89-253-118-72.customers.ownit.se.
 [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id
 q23-20020a05651232b700b00478ffd14ac1sm1491151lfe.163.2022.06.03.02.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:47:15 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Subject: [PATCH] bitbake-user-manual: Correct description of the ??= operator
Date: Fri,  3 Jun 2022 11:46:51 +0200
Message-Id: <20220603094651.22816-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Jun 2022 09:47:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13728

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 .../bitbake-user-manual-metadata.rst          | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index af4b1358..1c146f0f 100644
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
+   A := "${W}"
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

