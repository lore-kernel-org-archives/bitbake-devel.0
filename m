Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8CECD4F47
	for <webhook@archiver.kernel.org>; Sat, 16 May 2026 19:12:00 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11358.1778958711243400857
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 16 May 2026 12:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Mb3Jyg/s;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44e5624c053so436233f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 16 May 2026 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778958709; x=1779563509; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ai0oP0m5S+CEn5Osnnf9QduL8sDbCqCItLi5cO9MBwY=;
        b=Mb3Jyg/sGbv6v4ZxprBINilO5L4oMiT0/hLqFMcmr8EjW73Lsic2WG71snn6E77Dhq
         HoZzuwmvy8ZknsMlw1tWvku4qLA7tI01dzexJpF1LP/CKeYQizc3qqZSUArzDcDi+6xO
         tF/d1Wa7XLDt3udgswFdtm4bGHSBz2a5icOuZ2Y0Wyud66e/Fvn3H/TXu+tlSai8Pd9W
         gZJ2yJjvL3kimW1EwK/jf8dOEtsuhIbCjNX90VFLxrujFdaLkkcpgQdhs+zn0SDBW01f
         +GmrGq4C8t6qEP+TDC1pR9L7pqobuULijBijTqLNjR5urZP1dSF62zPuCtE9uBBCOxVL
         O2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778958709; x=1779563509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai0oP0m5S+CEn5Osnnf9QduL8sDbCqCItLi5cO9MBwY=;
        b=KuLqPzqL4jWjJE4bo9OxIKLDrADTeHCMmjNSX6enjk3cA3FC/J/Y9A7r7pYVLNIAp+
         Ta6LrJrNAhAK96QevYdlDlwE3VGiv2CJLYGgb7l0njxcE8l0kxPA4HIGtf6Yye4nQMeQ
         Fx4pLiRsYCnFNj7mti/lPDu1jXTZs2zpDiDVLdEYapxsR4VJP6W29u816qUn/N+Ov5SF
         Phc0mSpv7k5FkxeZK/+5d5aBqhAeCJc+sOFWUFhvgBgynCFmI3cTIaPgqJnuzyjeV0zd
         fmBPE0BZ3jghvTciDtVEaZ/TR5QPOWmDaOLbKD1G7ejQ05OuR0n34z+ETVyEJhqFvvxa
         KNQw==
X-Gm-Message-State: AOJu0Yx/Ye24XtDYIPbTW+fWjitkm8vH/dKgvWE2Q6ZbSVotJqHyYaNk
	kgIaSwzMGchaEr0DASPmRduK7XyJ0u0fZUT/VAo3f5JVhKktqbsVcRDdzKsJjQkPgTw=
X-Gm-Gg: Acq92OEFXuiLYuut7sw8A55zs6xGq47hS5LpJOE5P5iWRhaxwj81BIBWHZjInheiW2j
	z6D77/+aPh8L9l4DSPAkM3yswYwuIRFswM9POf6tWeV93Zz7X+qxNSVsvTt08B9+3wBS2CBMxp7
	G8/OEdLEM7td2COHThoHOMGmIpjIn9rOGj8JvMOHXw/T4mk4S1ECw1sy0hnLCPiT+JrSzvz4cTP
	uJDPYChnQ01LdqGDq9q2QxKNZnA48NYt925NdBfDGlAZEIQwThHvTmV3mPQJU/uwBTdRpUrnBPT
	JIkGiGECrBO8OBp2gMngN70AgCkLtXUv+d/1vUoBzHTXtSVhv/ZV6vdQ/X9wWhdI+Mstood3VTu
	ZcdpPW/as18DM5BTZAyD299i4mZ0WJzjtRY5sTV/MXIDoBOfWp6ZBjgGHaO3dTMoMfuYIOeh3Nu
	oUoWKYCNnBZH/YjOOP5x3uQtHHjVKfRJD/R6NfouUieBGiWP/76Dw9APTabeS/52OwS43YgiiLa
	X8KwLetYiMrcmvqqYCcIyW2NlYIZ52JLmoWCXfbHZNe4Mepr+StVw==
X-Received: by 2002:a05:600c:a293:b0:48f:e6de:1cba with SMTP id 5b1f17b1804b1-48fe6de1dc5mr78081565e9.17.1778958709137;
        Sat, 16 May 2026 12:11:49 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:8070:d188:380:5f4a:8ba5:a0d5:73db])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe53804aesm138951905e9.15.2026.05.16.12.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 12:11:48 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	quentin.schulz@cherry.de,
	richard.purdie@linuxfoundation.org,
	mathieu.dubois-briand@bootlin.com,
	Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH v4] doc: bitbake-user-manual-metadata: document inherit_defer limitations
Date: Sat, 16 May 2026 21:11:37 +0200
Message-ID: <20260516191137.11033-1-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 16 May 2026 19:12:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19530

Add a warning explaining that anonymous Python functions cannot be
used to influence inherit_defer, since they run after the directive has
already been resolved.

Also rename VARNAME to VARIABLE for consistency throughout the
documentation.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
---
 .../bitbake-user-manual-metadata.rst           | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 0c7c3ff99..134cf8ff1 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -827,17 +827,17 @@ the variable after the line is parsed will take effect. With the :ref:`inherit
 
 Here is an example::
 
-   inherit_defer ${VARNAME}
+   inherit_defer ${VARIABLE}
 
 One way to achieve a conditional inherit in this case is to use
 overrides::
 
-   VARNAME = ""
-   VARNAME:someoverride = "myclass"
+   VARIABLE = ""
+   VARIABLE:someoverride = "myclass"
 
 :ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>`
-defers the evaluation of ``${VARNAME}`` until the end of
-parsing. Assuming ``someoverride`` is in :term:`OVERRIDES`, ``${VARNAME}``
+defers the evaluation of ``${VARIABLE}`` until the end of
+parsing. Assuming ``someoverride`` is in :term:`OVERRIDES`, ``${VARIABLE}``
 expands to ``myclass``, which is then inherited.
 
 Alternatively, you could use an inline Python expression in the
@@ -853,6 +853,14 @@ In all cases, if the expression evaluates to an
 empty string, the statement does not trigger a syntax error because it
 becomes a no-op.
 
+.. warning::
+
+    Setting or modifying variables within an :ref:`anonymous Python function
+    <bitbake-user-manual/bitbake-user-manual-metadata:Anonymous Python Functions>`
+    will have no impact on the value of that variable in an
+    :ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>` directive
+    as the function runs after the directive has been resolved.
+
 See also :term:`BB_DEFER_BBCLASSES` for automatically promoting classes
 ``inherit`` calls to ``inherit_defer``.
 
-- 
2.48.1


