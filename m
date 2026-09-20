Return-Path: <WXbet@proton.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A19C982DA
	for <webhook@archiver.kernel.org>; Sun, 20 Sep 2026 19:02:44 +0000 (UTC)
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34781.1789930956384317086
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 20 Sep 2026 12:02:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=f6kZyfjD;
 spf=pass (domain: gmail.com, ip: 74.125.225.138, mailfrom: wxbet.oe@gmail.com)
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so6037445e9.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 20 Sep 2026 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789930955; x=1790535755; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P0/RkYYO10gSZdUKpPa18CsmfeTQJk0RuIdF6fjm5r0=;
        b=f6kZyfjDxiT55S301Qo0IQY3t2MsutftIsp0ANePYkJeojCuEXaNbHPhdcSTsu1+j3
         GFjwdbwTcQSUSZWLc18YVEgQKHOCHlSsv0d55ie7qSnzSu1HeKUycVfhxKZ46NqHc8UX
         niNzlE2H4xP5WRiVuII7SKFLdaadfF2FkSqsbZ9AJSGq2fkbKF/Csxdlf6me3qNls2XM
         igdTd+kJ3X/1r+4/GsgC3h6EswvQ6m0Raj2oQuVfQmmCutMhHiXRICJLHbr3KyIeX3nG
         tKJurpqGee1fklgpp54oyYCH4JSGd9v+FORJYUkSACZmmvSVqeOsM5iFD2ve+LRodc1x
         BSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789930955; x=1790535755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P0/RkYYO10gSZdUKpPa18CsmfeTQJk0RuIdF6fjm5r0=;
        b=WSW766HeM6+Ob3zM/YdkOLw5GyjhfVNep7QpVELW5STD0eBchXz5N7OKuD2DAmNEV4
         UDJ9drtba498UM9u9ua1jARZldhg2XIrCPpT5NXKJosgxavURWJ4jh9FJZqRKA1m3oJm
         HoKKPd2vtbuuGY3ro84JCMa4LvPxExL69WRdVOQBH90KIGKEggHL2NLK7SCzNlC53VcH
         GUXzC/vOMuzz0fgqYr1PXigy6Af/VdlCeuFfyPJvx8nbMLXC6OU4aw25esVxCdwL6UIS
         ilVF9HroQbuPItgr2HCNF4vtlFQbW7CrjpdqMSZj2nUfdtcOFxhos8rAH4zdjJCXl+7E
         J62A==
X-Gm-Message-State: AFuF++mOStboRTniVezWUNJNtbaMgUrz2aRXWBTBxK5MIfAePU3viIeB
	iZCZFwgmoU7VgU0UO04nHs0aQYkEedAEgu7J7yitHWmKrfP+KC0/P6r9nskRaeHLNAnK0K6E
X-Gm-Gg: AYBFou3X0jGpZzR2+j8GdkOxkCgMdbomffSjcrLz1Ycf4mv0nqQAA8v/OBAmgzMLEJy
	qDwlB4nWClpckdVSzVDXy793HBa491zKGvFJJkTUwrRPPTc2KhOsTFaXF4nvipLu2ruKE4OKIc2
	aeK2DJ3XmJQsgz0vetcfJQR2Vl13GtrtrVqueB7kZwXI7c3ojHccZWOn4rTDLjp2YwFvivlCa8F
	kahEyRck5pEPuSDSpQx+MurLko2NBUZtuLtlgIDt2zuEkLAMzEf7M57zxQ5wHdNX7r2YO/dRKiK
	HP55wENf15yFOyZuS6/0EwfzqBy9FKF/Z6DquYG4sH9kfypK4jzTXJrMRWtbTQYCY0dERYWRSfc
	Z4vtpv/RGJ3jdMFgnN2726EyICF7WXKS3uNkzxdLuqrCJFzVDyurCtj+hbwgPuUOXJ5NHW42K/y
	EPA8hr75BMg+s3lxJSilCzJyXxQjUOmHN1e++Kr9Z0VV7OOTFUSB0hK92SdaCZpTHRPCq9mQCdf
	PQ0mkZ/VmpDMSDuYLms1Q==
X-Received: by 2002:a05:600c:3584:b0:49b:96a0:5c00 with SMTP id 5b1f17b1804b1-49fc57227b7mr159008255e9.13.1789930954332;
        Sun, 20 Sep 2026 12:02:34 -0700 (PDT)
Received: from localhost.localdomain ([94.31.114.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724460898sm15874486f8f.9.2026.09.20.12.02.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:02:32 -0700 (PDT)
From: WXbet <wxbet.oe@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/svn: fix typo in the svn:externals error handler
Date: Sun, 20 Sep 2026 21:02:22 +0200
Message-ID: <20260920190222.5657-1-wxbet.oe@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 20 Sep 2026 19:02:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20232

From: WXbet <57314510+WXbet@users.noreply.github.com>

The except branch swallowing a failed "svn propget svn:externals" call
reads "passs". Python parses that as a name, so the handler raises a
NameError instead of ignoring the error, and the original FetchError is
lost. Introduced in 58097a59f ("fetch/svn: Convert to use lists of
command arguments").

Signed-off-by: WXbet <57314510+WXbet@users.noreply.github.com>
---
 lib/bb/fetch/svn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch/svn.py b/lib/bb/fetch/svn.py
index 73ce83f..5d57793 100644
--- a/lib/bb/fetch/svn.py
+++ b/lib/bb/fetch/svn.py
@@ -165,7 +165,7 @@ class Svn(FetchMethod):
                         else:
                             bb.debug(1, "svn repository has externals:\n%s" % output)
                 except bb.fetch.FetchError:
-                    passs
+                    pass
             scmdata = ud.parm.get("scmdata", "")
             if scmdata == "keep":
                 tar_flags = []
-- 
2.47.1.windows.1


