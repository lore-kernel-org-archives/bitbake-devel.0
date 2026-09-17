Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E76C982D0
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 22:17:20 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1879.1789683436886235925
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 15:17:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=JBxIXGO2;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so954525e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789683435; x=1790288235; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+gYPXz8tCVNu5jnv06gWZD30fDoI0MW4XpSVWD4C22Y=;
        b=JBxIXGO2Jm4Aq2bIAPJMgw1aM4YSzCRvwpa5MoxNyvZX/3tucAPGsPnhedKxw36YN+
         jI4pzTNsBSRsDs4WuSQuyl0GB7SI0hSudpsQTHVq7HwqunFTzrKg1Slc1Y0K4vaF3Mgo
         yLB7xqpkulbs/PGnh96mOP8qFqZ4836o/g7u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789683435; x=1790288235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+gYPXz8tCVNu5jnv06gWZD30fDoI0MW4XpSVWD4C22Y=;
        b=nQcYtUjdeaiBAyo9mZdk4FCPTZQpfrzZRKgs469rggsL4WIgPKG/tqOQFsiHdjG/Lt
         svInWGUcEhU61qAWo+xfIuqpZr9gIkCnFppBcTkjB5uYDVtu8F7u2gSn79VIbSx8PX5+
         hJGXTQ87SpFOQ2LJX/wh1J0M6olWdGbgw9igtREFsqCfF5ClQhCMmqSgI0bS0MWp0Uld
         2jcE6016x1PHtuj2g26WudqpjF3Apy8AR3QPZz6YqOOgiLbvbZAoEsAai5NonyUVjVvJ
         AUxvZCDtP5bByvLTB6RRjVAs7uQnJJ5ZtshL3QgPpvUAMD18Jvw2hUFjr1MAC7R8MyXj
         laRQ==
X-Gm-Message-State: AFuF++lvBkd+I2pZ8DekYa8tM/NON5/WeTdFycJ7LmmuUJ8WM3vzo1M/
	LqG0bK/PnPJR4q/EpAhLrGowb3eYMDzMZV0yx/GZGynpK7L09YzIGSoKEI2KniNmZT5x3KIHYAo
	4Y/xKvUM=
X-Gm-Gg: AYBFou37cadmnEPLYxZoCcjj26GMkjUkSaD3QPyYi9HnXf7fD0kihvDu0UrxmmbRz1d
	ARb2fouAsStRtXZ5q52SbuH3UXmpEpOyrLMegKI2Q/CXqCStTOz1avoD+J2yOVO5y7/qtpD91xJ
	pr0OF/rX5waGjR9cdEzh60sMJMEOl4q4CVsyNaVloHHuSi9/GWzTYhyBKmDJEnW7+X0TiYX3d17
	iD/oGA8bQqFmgWJvtU5EAJaKHXG5dA0rJZAMCEFU/bBp+ZfqkwOVlq10CG4hAtf+CD063srDhv/
	UDett/xFnWUMJmTZKiDFQqtZB6onY9vkitC5c8McnTEOmeaYnDzBPk9yyeIiyg7nuY8dKkql226
	wODCiipXvakMVMkNtRz00kdtrSEPz1HAfSet0F7T2n9JIV8NfqJfE9SICknm7QI3Jz/k084HVtN
	eH5QF8FThz3SJf/aOlWYa21rhXWToy4Ryb2hvEQuKrTDz0OfmEN/gi+bSS38fQeZx+pUp9o+Ojg
	gzIoMJJT0ia9j67uXCiYcgLMyjaOvmxBs0Qek3WaM8wW+GjNJcN5xnhyCNtddNhJo/XqPwNZK0=
X-Received: by 2002:a05:600c:34cc:b0:49e:6c27:d093 with SMTP id 5b1f17b1804b1-49fc56dbafdmr3457045e9.15.1789683435133;
        Thu, 17 Sep 2026 15:17:15 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm185737725e9.11.2026.09.17.15.17.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:17:14 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 7/7] tests/fetch: Drop ftp checkstatus test
Date: Fri, 18 Sep 2026 00:17:05 +0200
Message-ID: <84a8d046593840df460c1312365031c817eb8918.1789683244.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789683244.git.yoann.congal@smile.fr>
References: <cover.1789683244.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 22:17:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20230

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This single url takes 100s in each of the two tests it is used in,
compared to the fraction of a second for the other urls. Nobody
should really be using ftp any more anyway, drop this test url.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a181827fa0fe6738441b40b5206cc2cadb5f7dce)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/fetch.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index f8aa0fd07..792ad1489 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1716,7 +1716,6 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://docs.yoctoproject.org",
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
-                      "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
                       ]
 
     def _start_checkstatus_server(self):

