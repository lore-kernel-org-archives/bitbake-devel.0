Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61B4C433EF
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 15:35:44 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.9874.1634139343801170013
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 08:35:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fHobacKT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id k7so9639262wrd.13
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EpMe8cl3FSgFjH+Wey6OwFHXPdlEjOptneXDM2mGaAU=;
        b=fHobacKTenX9g2qtFakBPqJlP0LCaRxXcdzZ5hkzMU66jGMUoeaf4cJPNkY5KpWEo6
         NyZMvV9es5DdDrPeJdc8Ng55vdBHzZIakwvLXuBqYOi7FAyzIRupK7ZoqfvB2QhiPWJB
         aDYuc6GTKjt65jvRXw+SEMxwcMUQTtH24pp8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EpMe8cl3FSgFjH+Wey6OwFHXPdlEjOptneXDM2mGaAU=;
        b=pe17uT4Ch8Lu6eUgi+Y5etRsVvZ7+n51EOX5fEPeOZbVWgb4b6XAd63TYJioS8ilgn
         a37EJf+TjsGLCSF8cB2qusBBtYoEWTAmoZcblnj8jVNWssJxCTGy51Wr1bCj469CIqev
         6UO0HUxC2XXCte9VS3D0Cj67ogSZ6BFnqKdjmXmUhIwmysKnvCW6v7u4BOHvfz1bVPJd
         ow6+/ZfR+8gCp3qAVxZCw/er8Qp+IBZ7rQeECvYvDO2ZsETOqrzI1Tb6+d3rOEK7mYB5
         ef90RWqoPHGsfq2hvhAkTq5Kc5gm0ECWIMyhSCkIncf+euRLCc8oGND0HvqZ+PmaNUWv
         KqWw==
X-Gm-Message-State: AOAM532R3ObRIdKAmhGvhHDrzVIR0uvVRypCmTyxG9kJdPHS4OtRO+31
	O2lMoH+jGp9/8TJ+beRmDS6sNsQe8Hg6zQ==
X-Google-Smtp-Source: 
 ABdhPJy59NGKlbKKpWx4dIeuZyjdV3ViZUzUz3smgBgoGCsOiS1gfKkjbr/r6EmYh15kTKAlXagJfw==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr40004167wrm.21.1634139341875;
        Wed, 13 Oct 2021 08:35:41 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:65b2:89df:e6ae:44c4])
        by smtp.gmail.com with ESMTPSA id
 q18sm5631717wmc.7.2021.10.13.08.35.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 08:35:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] compress: Allow to operate on file descriptor
Date: Wed, 13 Oct 2021 16:35:39 +0100
Message-Id: <20211013153540.2873636-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Oct 2021 15:35:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12770

The code works fine if we pass a file descriptor in and we need to
do this from the siggen code so add that as a valid input.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/compress/_pipecompress.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/compress/_pipecompress.py b/lib/bb/compress/_pipecompress.py
index 4b9f662143..5de17a82e2 100644
--- a/lib/bb/compress/_pipecompress.py
+++ b/lib/bb/compress/_pipecompress.py
@@ -49,7 +49,7 @@ def open_wrap(
             raise ValueError("Argument 'newline' not supported in binary mode")
 
     file_mode = mode.replace("t", "")
-    if isinstance(filename, (str, bytes, os.PathLike)):
+    if isinstance(filename, (str, bytes, os.PathLike, int)):
         binary_file = cls(filename, file_mode, **kwargs)
     elif hasattr(filename, "read") or hasattr(filename, "write"):
         binary_file = cls(None, file_mode, fileobj=filename, **kwargs)
-- 
2.32.0


