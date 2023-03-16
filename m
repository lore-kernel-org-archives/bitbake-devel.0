Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A48C6FD1F
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 12:12:37 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.10422.1678968746987673956
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 05:12:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=OWwm32V6;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id p4so1302474wre.11
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678968745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=urIUkXOviiJ2tcviX9xw4r0BPbg7agQh5pZ2+uOaYvw=;
        b=OWwm32V6jA7SxC7+F+2cQoGudvfBxd468BU3pIIuhP2wxuWbIth05VMKejKu9fcZfI
         Ubh1f0YeOyY+NX4YqvafWZhcM7f32baNUStdw6lBal9inBM4NR/sVhKypQFpr7pVf14s
         XfUd2fOo6ohabL7pO9KRSz4ZY4GOIKEroEKm47RyCvfQk4R/GXYUgfYhPaCxYizEc1KE
         HHENy90ZGBNQ4k/IDUyZejBQ8sHDDmWme+8ONbyVRHWYRPScDxhPFRufYQpC8KdVSpF+
         9KG5YYuQHkP5knfENC2q+eRnEpoZgv5A4bHKxwNukuMgoGjktcltBf+SNp0J+9nC1Y6/
         bgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678968745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urIUkXOviiJ2tcviX9xw4r0BPbg7agQh5pZ2+uOaYvw=;
        b=iFZpMDC6vqqaB8rPAd9Vahwdw9sw4upIck+MsHru0RL1zIekC8w1HZQsv6H3zXLPVp
         1G4LK5pES1BMRqRm+RTxMBmnm4FWIjRiuLeHIKZljaujo9A8pozhGn62xpQ1M3+KpZwY
         i0tO3Pe+MrUNDGRKzVIH6bPNQX/HLaMjnLMJ+w3UNbN5TOw4c5fjn4nez/7V0LZEw+s9
         g+Ed9sMBh7tpGgPMzi9LTvXo/oU8Unzur2SUcQgAf0TIU2AWc7tWsI24BPwDPuy4t530
         37oipoyQnP0NVHEOl15+sEGzXEdoabp00IV4aZgaAlV/E4NsAFmGNt/c02Wx9wUIdJRy
         XtQw==
X-Gm-Message-State: AO0yUKXN9WUtwUrTxK6tRyrKPFaYM8Qj94Uv7qT0gFSPr6mTW4HckG9n
	2cIhO4f6bhR6gJs6mRDEsLcBEZQRDms=
X-Google-Smtp-Source: AK7set8BDSVEOpcdqGIaYBGVDHOKLaewPVuamLwQDfuusPx+zzPgD19l3nFEO/vLz5z7VTsp9tv2ew==
X-Received: by 2002:adf:f209:0:b0:2d0:27dd:9c40 with SMTP id p9-20020adff209000000b002d027dd9c40mr4069931wro.26.1678968744895;
        Thu, 16 Mar 2023 05:12:24 -0700 (PDT)
Received: from work-pc.core.sigfox.net ([2a01:e0a:8d5:c6c0:65ad:993a:17fa:6608])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b002c592535839sm6899684wrj.17.2023.03.16.05.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 05:12:24 -0700 (PDT)
From: frederic.martinsons@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>
Subject: [PATCHV2] crate.py: make checksum verification mandatory
Date: Thu, 16 Mar 2023 13:12:15 +0100
Message-Id: <20230316121215.28151-1-frederic.martinsons@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 12:12:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14583

From: Frederic Martinsons <frederic.martinsons@gmail.com>

Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
---
 lib/bb/fetch2/crate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index f091200d..f8367ed3 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -33,7 +33,7 @@ class Crate(Wget):
         return ud.type in ['crate']
 
     def recommends_checksum(self, urldata):
-        return False
+        return True
 
     def urldata_init(self, ud, d):
         """
-- 
2.34.1


