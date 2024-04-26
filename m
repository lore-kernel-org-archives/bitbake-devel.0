Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC5C4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 11:34:25 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.11572.1714131257374969140
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Apr 2024 04:34:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gCJWbyw8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so17622935e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Apr 2024 04:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714131255; x=1714736055; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKs21glEq+/Oal+wxxcKJ+8I7uIu99RhHPfFrjsP4K8=;
        b=gCJWbyw8CujOBkyfYQr7F11eI8FiHY+MxxbrvR8lVB2B4T6nU/UyI4SnKxx38zvKUn
         ffGE/DALGiRkdukWGBHIYxG0P+cVSLnVqhJ4lSt+UCpFZR7brU+2DHH4pSJ68veTaPFL
         F8Bvla8yZtLWbiHJhOe2dEzGtkonLQbSX7vnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714131255; x=1714736055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKs21glEq+/Oal+wxxcKJ+8I7uIu99RhHPfFrjsP4K8=;
        b=eSsCecFCTRJSWDhm6ru8vzhbAxlWSFDvsz+UQjo9rKIzpwaITLCdSnDIV0ncs8KG71
         F2jdG+rykBhrlCiW2AD8aMm4EQtoCd3vcRFt2yKArHDNEzvMFV1FNONdc9D1twYCgVo3
         9NVr1q7tmm4A20yXhLnd9wEG9C4aFQqMEfJpXN1qnxC3trA0mxpNIF51cuDueYLLnI+w
         NchPhe3xkwh0TB3KRQJ57IL9MBQ0WpL/p39HDGzXjcTEINb8R/dX3w0wAShgYnkV2mgS
         /Z8Am4VNEKjanIcqEZT5p3ZZJDxba6gDucRgnZ125i3rgxby++Kgrn8cf4tJ+wBTpDo+
         P8zw==
X-Gm-Message-State: AOJu0YwYiBRVDQx2ggzcWcdTnFX0kVDvSYS21uLBUiUrWc1I7YzhL8qK
	BpyLQri4rHvNgvGOev3eebXaThU56uaS2GHT++jmyGoYLkqWKNPIXpT3Gue98gi8J/hgLtmv4BE
	5bGs=
X-Google-Smtp-Source: AGHT+IGMTsi2WVXZl8SCOAKL3qJHFjk1/Ft12zByzvXg64clH5jhOCViabcQ6sHSzxbezG7xLxVQmQ==
X-Received: by 2002:a5d:6b87:0:b0:34a:4b4b:7f4b with SMTP id n7-20020a5d6b87000000b0034a4b4b7f4bmr4900631wrx.19.1714131255207;
        Fri, 26 Apr 2024 04:34:15 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c2c3:166d:66c4:a177])
        by smtp.gmail.com with ESMTPSA id h16-20020adffd50000000b00346d3a626b8sm22399027wrs.3.2024.04.26.04.34.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 04:34:14 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] build: Handle conflict between cwd and cleandirs
Date: Fri, 26 Apr 2024 12:34:14 +0100
Message-Id: <20240426113414.952926-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Apr 2024 11:34:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16141

If the cwd of the task is also a cleandirs, you would see warnings from bitbake
about being unable to obtain cwd during the task execution. Tweak the code
to detect this and avoid the warnings.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 44d08f5c55..ab8bce3d57 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -197,6 +197,8 @@ def exec_func(func, d, dirs = None):
         for cdir in d.expand(cleandirs).split():
             bb.utils.remove(cdir, True)
             bb.utils.mkdirhier(cdir)
+            if cdir == oldcwd:
+                os.chdir(cdir)
 
     if flags and dirs is None:
         dirs = flags.get('dirs')
-- 
2.40.1


