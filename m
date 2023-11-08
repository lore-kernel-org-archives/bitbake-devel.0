Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D11C4167D
	for <webhook@archiver.kernel.org>; Wed,  8 Nov 2023 22:57:40 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.107242.1699484253502751751
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Nov 2023 14:57:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=19JTArIa;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.180, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6b709048d8eso190405b3a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 14:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1699484252; x=1700089052; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+48HE52cnXBfhlPNVd70CU8GaYP0QVi9hRSg/I1oG3Y=;
        b=19JTArIaoWJdbr1JEWFCNt+v5K3NsTcmzHNyYQlR71UR+yVDCZxQ9C9tvf1IJ+EeqH
         TkQT5w+lI+FO/PWg5WXxlIJXZ4lRokNTYEYXWjGtgTEXN0RQpDSy5uJRFuNG8e1rIQWr
         g1P3FAel8zTy3x3BAv9QY1QksZT3aRDhzh9j7tXxT+NeeEGl2HviZWRmW58HMSGDyMgE
         6UfC/l8nB1eOrIAg/yZLUyBmof4nT0Ro+mwX0vG2GCKjY00VJPguYqRAahY28vCObYTD
         vFBpVQAt7SVBrmRiP51N0Th3C24k2qSoRhn0lRfKl5lKcwnzXA8v4DblPT60rfHq+UC8
         gBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699484252; x=1700089052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+48HE52cnXBfhlPNVd70CU8GaYP0QVi9hRSg/I1oG3Y=;
        b=vFraCyDjsmyqz90nWLk5nif92EUk+yWAb8PVPzcOwjBhXUaxnSTZxwqeBlOnnobz9o
         rTJXtSGYzV3G65e0sELJQG2o6JYUyC/40nxd8ddws4gXwNoRZmFFpZRVvAgxJPWRZyFy
         00Tbt03CHTKkGrpwsaF+WgLOOqLvhHcyA8F4Mjpi2cX0TADO49MRvJ9nChJiOakNEgbd
         YXNeatt/4+3qMxcnfxtX45aLLtsuDtXubh1vfFjhWdGi3Q/Z4CYAvMX5HyVe6qWl/Te+
         efDCnDy+Ex7UmEoF0wvZj7s+ond1KSDeDtfVwvdNt5TLI3nz7iICnc7/3lwqa/t4pQ/H
         vfjg==
X-Gm-Message-State: AOJu0YxdAcKOcRZ5iIeNvLxBYmwELF9fr5Y64RFUOZlu2ARPOEdxghpU
	U+Q9gIdb76Fzo+rDucXW5d+ESt7ZjWWg6RWoE6eX7Q==
X-Google-Smtp-Source: AGHT+IHI60oin5uDZuCowVXoHsPoiRPOj+Zc+v9a0n23mCADUyyKyjif+Q143hSB0xIOpBvXbz0sdQ==
X-Received: by 2002:a05:6a00:1948:b0:6c3:402a:d53d with SMTP id s8-20020a056a00194800b006c3402ad53dmr3018338pfk.2.1699484252234;
        Wed, 08 Nov 2023 14:57:32 -0800 (PST)
Received: from hexa.lan (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id x6-20020a056a000bc600b006862b2a6b0dsm9798063pfu.15.2023.11.08.14.57.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 14:57:31 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 2/3] tinfoil: Do not fail when logging is disabled and full config is used
Date: Wed,  8 Nov 2023 12:57:20 -1000
Message-Id: <e452c6d7ba5bb4f78a1d2bfb742794efdf171dbc.1699484095.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699484095.git.steve@sakoman.com>
References: <cover.1699484095.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 22:57:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15454

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

If Tinfoil is initialized with setup_logging = False and
Tinfoil.prepare() is called with config_only = False, then it fails
because self.localhandlers is only initialized when
setup_logging = True.

This is seen with, e.g., `bitbake-getvar -q -r busybox MACHINE`:

  Traceback (most recent call last):
    File ".../bitbake/bin/bitbake-getvar", line 41, in <module>
      tinfoil.prepare(quiet=2)
    File ".../bitbake/lib/bb/tinfoil.py", line 390, in prepare
      for handler in self.localhandlers:
  AttributeError: 'Tinfoil' object has no attribute 'localhandlers'.
  Did you mean: 'oldhandlers'?

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 616101ddb630e2c9975022068b52a87c4cf647f6)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tinfoil.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index e68a3b87..fa29b930 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -324,11 +324,11 @@ class Tinfoil:
         self.recipes_parsed = False
         self.quiet = 0
         self.oldhandlers = self.logger.handlers[:]
+        self.localhandlers = []
         if setup_logging:
             # This is the *client-side* logger, nothing to do with
             # logging messages from the server
             bb.msg.logger_create('BitBake', output)
-            self.localhandlers = []
             for handler in self.logger.handlers:
                 if handler not in self.oldhandlers:
                     self.localhandlers.append(handler)
-- 
2.34.1


