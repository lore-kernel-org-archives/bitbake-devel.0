Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4318BFF886F
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 17:23:25 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2945.1777396999946960617
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2026 10:23:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XLjJYJey;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48896199cbaso115224875e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777396998; x=1778001798; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vx939IQlTfVzqs0YFsVnR+c9sk3QrcKN3ulNIwRL9GI=;
        b=XLjJYJeyHJ6w/1zDNLlBcCmxPexk6MofyvIwHlopo4dBhqSwPw4j519fra1rxKkHPf
         Zx6gsGXyAQbVgHXKscFCdbRmVqPL321PgTjnNQKk0Vs8YP1SXp+rwgUHoYEzyS4wbex7
         j0vyEkmkt4Zm1mdalr3/zjHaJcCtI+b8ldddRsaCxmi96lUsQPKdoiplXB1IUaQa6B2Z
         i35Ra/Ir67lzCqZqAHhMpAr6URI3UoahsRO/+Qu9iDn5KuEBjl4MEoBfvuXylRlzYIQU
         dERlViggzgRj4oCwnqrXO9uTJaoaMkHiUymlSSJ8zcUYaC2Cymr/ViJpewPX2AH3RO/z
         Mtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396998; x=1778001798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx939IQlTfVzqs0YFsVnR+c9sk3QrcKN3ulNIwRL9GI=;
        b=RFb06he9vErzpZAGsJf1Cck8kNoUJ58lRv3uZk1BbKsh4r/zpoXL8T55LQAGKA7kE5
         3u41XWO1GPsZgGQSq2L7vpdHAd/d0IWNXYEZ6RCvaHwQo6xfArc5FnURyP2nJqBu/N/W
         kherSCYw/8715UmoRZEczBboA9Ysnv4zjKM6+wtzNbKCFZGt58fch0ZxaA7ixImUp21a
         /E1Z6EGkDqr/+UMDnMx/i4jYO4l6ynPXBCunwmtqT7mZqX7XQVC3jk/oZLHtKByi7Vmd
         qzIE9gfjQrm1M2kY+zWxayNsTp9S8GUR/xbRUnrPWhRr7DRTdsWE5XtuaEWG25RAGBMQ
         syfQ==
X-Gm-Message-State: AOJu0YyqqaNzQQSUtiwg08gox6fKoDtrjUavax8JytBTG/mSQsZ9cOcO
	Ylf9QquZG+vgmjKwOqxaz0islA+5dx6A4NmYeZGCQI/S+jsN8AcrJ9OVB0LOnw==
X-Gm-Gg: AeBDieuf/JZaEiO3y++t9vZw03ES86HezVrsNhZYq1r/siIc48spGHfQZmBJ0lt+e3E
	qaihfcFtoRVEwVHdCoRp8TrYoY3eRxIIzc4ssNAB+8USH1vCBKgCko1zOe8FvFL+8S7mLDDGevQ
	5kRZKsyVuCAlS4kckeqq4UjwZN/UNbG2S2gRPrv95a+yt0NUko7HbLCnkn5lurY5+KK1KPB1vdK
	TqG/m9IqLgI9zEwO0t6/RCA1piR4r9RgPHUUWqErNjaQ5qku/1CSwKcccDdDVcPDt2YRy/DCPeE
	rfu+57macDL7IamqW/eFu391+YYDXxDXuhtzJ53BtAz554oLhG2TcUTd2f8dlF5K+juhsXZnIfm
	NV9cmBmJEAzLp13zSn92o+sBkdnnzzFJNOuTunioEL4Y2KU2D4kU21+JySdWOFVb4su0yDQtuoC
	6u65bMequ1cRe17QD1Lncg2CAWiKDz70BtF+vUqlEaCD1CZDo2vxr2EwNe5UcIn/C/sQZxRDgqt
	Xoaw63CEoV2/1MQprylU7t4BZhEdWM=
X-Received: by 2002:a05:600c:e41a:b0:48a:592c:e632 with SMTP id 5b1f17b1804b1-48a77b0625emr47467625e9.16.1777396997947;
        Tue, 28 Apr 2026 10:23:17 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b900af7sm930505e9.1.2026.04.28.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:23:17 -0700 (PDT)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Chen Qi <Qi.Chen@windriver.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.16][PATCH] fetch2/git.py: fix update_mirror_links
Date: Tue, 28 Apr 2026 19:22:57 +0200
Message-ID: <20260428172257.1897748-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 17:23:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19404

From: Chen Qi <Qi.Chen@windriver.com>

We cannot assume ud has the same fetcher with origud. For example,
if we set map git:// to file:// in PREMIRRORS, ud is using local fetcher
and origud is using git fetcher. In such case, the ud does have the
'shallow' attribute. And we'll see the following error:

  Exception: AttributeError: 'FetchData' object has no attribute 'shallow'

Looking at the logic of this function, I think it's the origud's shallow
that should be checked. So the logic becomes: if origud is using shallow
and its full shallow tarball does not exist yet, symlink to ensure it
exists. This should make more sense.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0fcdb19df..738174cd1 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -356,7 +356,7 @@ class Git(FetchMethod):
         super().update_mirror_links(ud, origud)
         # When using shallow mode, add a symlink to the original fullshallow
         # path to ensure a valid symlink even in the `PREMIRRORS` case
-        if ud.shallow and not os.path.exists(origud.fullshallow):
+        if origud.shallow and not os.path.exists(origud.fullshallow):
             self.ensure_symlink(ud.localpath, origud.fullshallow)
 
     def try_premirror(self, ud, d):

