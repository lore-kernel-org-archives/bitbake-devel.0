Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3877EC83F03
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 20:48:31 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.7133.1751489303505870311
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Jul 2025 13:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=a/MaI8OD;
 spf=pass (domain: snapchat.com, ip: 209.85.218.47, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae35f36da9dso982603566b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Jul 2025 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1751489302; x=1752094102; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eOFgpB9S6rNQwk5jLBUBM11ebIbOFEvQSQtLPJCdmZw=;
        b=a/MaI8ODiamFFWpatOIaZnrK02lYbUzxfRwsh5pf/faGuwXB5Ckx+aB4efa1fBHMdz
         PPOP3xaoYP1iJLjyqBupJQRca2ZdlgI3XJ2foYQy+62C7fjO6v4AiRRJr1yzWbPmp5jg
         6gx2MdqErkNSB4wHlOKdzsot6Zxwksp4C5hQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751489302; x=1752094102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOFgpB9S6rNQwk5jLBUBM11ebIbOFEvQSQtLPJCdmZw=;
        b=SLCJRbxW41YCNgFXf2tmVp7Krpj0QJfrBYEnGgc6dKnx2eoY2XxALWsxtnEljT6Pha
         FMOfMqoD10s84SnHkU0sWmwJUeBLsEJ9l1XQ0u1aU6T1HjbVLsgZp5tUs0fJ8TbCN7j9
         ZcvKiYvGA2HEDSSl59KXkrhrcLTMtkVGBPZ/D0VSbVowQrSRf6A3hDfYMHv/v2TQVrnR
         80keECqng/CK/svYiIePiHm+GoGusr5r8BIcjFfkJGUvXgi5o3VsdM80XS3bjiSbHXr6
         h/Ua8Jt11tHlfZbKqZyew1yAvPtW0tve7rBE7yXYPGwlPEDa8ARJ5TJOx3vHnxOe6XvY
         jThg==
X-Gm-Message-State: AOJu0YyIW6yDxsHDbMrjqbU2Or43pmfIJhebVy2HoplpzZnR7D0WmX0l
	0P51p7oWgGZqYSZkR9wToM7ADpzoax8o7eDhH0U2tYtkn+XmgBjtYtrt9D//5zwgJUONkVfpkeG
	mCJNILZQ=
X-Gm-Gg: ASbGncsdeQivaEcWKibSdpmwuUVn4j/jSNRQtUiv2V1QJF85CW0Jy2cpXu0BBj+wFBH
	ly3de98vjOZATTlXZMLaBEpOFw50RTkWzjEpaEGJkyu1+DqsswoG8FHoOdKgdsjJWB4sc6J04fP
	V/hvyEDAjkn4b5bwcUBSayLAdc+vCiCpeYoVDRyv6Jnc0IO8pja6ltmogc6k7AEGaDOjeA1Orqt
	IeV3r0yOwGNRcrdSIwfovtOE387S77M8HCIoWAq/fizfHX9VOyw42hh//NmNPzkF5axLK/eaQvb
	CMwQlK/4M/goDN4VDDFBdO39UvY4okgZTwPpkSTFe3u/1Xjs6hddX8PIP77xVJF4f8sJbFdeEYa
	T12f6TQ++yQ==
X-Google-Smtp-Source: AGHT+IEB1n/YQ9fiHB7wMh+RBxfNYguNHgt8uBZyCmEGe0YSR8UJ1eNLA2ThagzgPieAMclM1s/7Mg==
X-Received: by 2002:a17:907:6d21:b0:ad8:a41a:3cd2 with SMTP id a640c23a62f3a-ae3d8397340mr67056966b.16.1751489301490;
        Wed, 02 Jul 2025 13:48:21 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831a0e27sm9604644a12.37.2025.07.02.13.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:48:20 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH] uihelper: Fix KeyError race condition in pidmap access
Date: Wed,  2 Jul 2025 22:47:58 +0200
Message-ID: <20250702204758.2773339-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Jul 2025 20:48:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17736

From: Etienne Cordonnier <ecordonnier@snap.com>

I'm seeing random build errors on scarthgap 5.0.10 because the pid is not contained in pidmap.
Fix the error by ensure the PID exists in pidmap before accessing it.

Call-stack of the error:

```
Traceback (most recent call last):
  File "poky/bitbake/lib/bb/ui/knotty.py", line 681, in main
    helper.eventHandler(event)
  File "poky/bitbake/lib/bb/ui/uihelper.py", line 43, in eventHandler
    removetid(event.pid, tid)
  File "poky/bitbake/lib/bb/ui/uihelper.py", line 28, in removetid
    if self.pidmap[pid] == tid:
KeyError: 21041
WARNING: Exiting due to interrupt.
```

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/ui/uihelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index e6983bd55..0bc526ca1 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -25,7 +25,7 @@ class BBUIHelper:
         def removetid(pid, tid):
             self.running_pids.remove(tid)
             del self.running_tasks[tid]
-            if self.pidmap[pid] == tid:
+            if pid in self.pidmap and self.pidmap[pid] == tid:
                 del self.pidmap[pid]
             self.needUpdate = True
 
-- 
2.43.0


