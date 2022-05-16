Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062A9C433EF
	for <webhook@archiver.kernel.org>; Mon, 16 May 2022 10:20:19 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web09.27217.1652696410259273067
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 May 2022 03:20:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JCn7rtpO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id d21so3916549wra.10
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 May 2022 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh2/EyBFki9oMils8eJ0kuxpKsWl5j1JZYanryuundI=;
        b=JCn7rtpOwqntgXg4cYMYNuBNXjE1Hkbnp/OixSzQZqdOOYmTEotfpyn8exDaflADAQ
         N/p/YiJ0ZaU/wpM0unmRulsAEbWk/xWWlHZ+nS7f+NdUgjRQt18nVTHn1SDieNI4F/Ki
         CdoOMLNFbCB14O606Q0naSCTopCQxMXs1inzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh2/EyBFki9oMils8eJ0kuxpKsWl5j1JZYanryuundI=;
        b=GYcSzR2L/CpCnZqQCKbV9TQQfMUfMDeDkLxxV01z8/wb9ODvjndTveWJy4W5vcRb/h
         wXsLjyp1FaGfV6TtDp24cRdHIyhAQ7p2osArXruEyZJClgscHBWVixQ0DI1KlcJn/lJO
         XH7VYZlgXB9TU+/8bb0/Dp0vw+m9/TG+FkYDz2WOQgtoD5PTMG274XUWJeAbfw+ehkbQ
         DgophEGQAoyvcExk+sKhLU/IKW5Y6htaHlQFkmVKqYwTbFlRv3oWJr0GMvKzKHMUsd6P
         yB3ruMzw49dYTd6A0kFFDqlOuE2Azc6gSKDdw3HoTVj40aaqfkx4AGBw8c+Cb6/vaAbZ
         iEAg==
X-Gm-Message-State: AOAM532gTADPdVZ87RRoI8T3SgOTQYeKfIz3hqjDtMpNaO81uyIE/Ln4
	1fRXwapOuS0o14NovwmyNcpfD4uHgUtOAlCa
X-Google-Smtp-Source: 
 ABdhPJwuCFw06m0HuIk7hi+WUvn24ZF/5d2G5imvydTMPvXTwOXSw8UAmGQcyfNGyKwM0yzLGsqQ5g==
X-Received: by 2002:a5d:554d:0:b0:20d:44a:ba38 with SMTP id
 g13-20020a5d554d000000b0020d044aba38mr5545398wrw.515.1652696408371;
        Mon, 16 May 2022 03:20:08 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:907b:5576:ab63:2b17])
        by smtp.gmail.com with ESMTPSA id
 i8-20020a05600c354800b003945cdd0d55sm10688509wmq.26.2022.05.16.03.20.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:20:07 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] build: Add clean_stamp API function to allow removal of task
 stamps
Date: Mon, 16 May 2022 11:20:07 +0100
Message-Id: <20220516102007.444641-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 May 2022 10:20:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13702

We currently have no API to be able to remove all the potential stamps of a
task. It is unusual to need to do this, particularly as you could race against
other things happening in the system but we do have a use case for this in
cleaning up sysroots in OE-Core. The alternative is to mess with CLEANMASK in
OE-Core but that is just going to add potential for errors.

We need the first part of the make_stamp() function so separate that out so
it can be called seperately.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index af60c3d8f5..55f68b98c5 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -835,11 +835,7 @@ def stamp_cleanmask_internal(taskname, d, file_name):
 
     return [cleanmask, cleanmask.replace(taskflagname, taskflagname + "_setscene")]
 
-def make_stamp(task, d, file_name = None):
-    """
-    Creates/updates a stamp for a given task
-    (d can be a data dict or dataCache)
-    """
+def clean_stamp(task, d, file_name = None):
     cleanmask = stamp_cleanmask_internal(task, d, file_name)
     for mask in cleanmask:
         for name in glob.glob(mask):
@@ -850,6 +846,14 @@ def make_stamp(task, d, file_name = None):
             if name.endswith('.taint'):
                 continue
             os.unlink(name)
+    return
+
+def make_stamp(task, d, file_name = None):
+    """
+    Creates/updates a stamp for a given task
+    (d can be a data dict or dataCache)
+    """
+    clean_stamp(task, d, file_name)
 
     stamp = stamp_internal(task, d, file_name)
     # Remove the file and recreate to force timestamp
-- 
2.34.1


