Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53674C6FA99
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 20:46:11 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.30870.1678481170380874227
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Mar 2023 12:46:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=oKdLhQ6d;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id az36so4263531wmb.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 12:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678481169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JiTWM+MdCg9IOgA/X0u2f0T1rgZVeqO24TUedvTmmc=;
        b=oKdLhQ6d1DanPOBLWcBI4rFzgWSoxpnlgfxNUbD0DvwCEX/EsF6Cz0P/UN8ML3uFVg
         k6+XmKUuEtUctzmk91gJBecS+wk/Qhft53PWUPoO5z2px7xhe2EAOh6SVewbcm70gKkR
         2sCp8KSNUi7vE0EPJuDufFz4RcgXmrMHqG0SAvBV/fu6xNgAsLU3YrWnZR2uVNwSJPZh
         27KcfT6WAo33LsVa3I5dU3NX1accPtJptXcUHwO0+aHQpUoudkXemdJLUE93NHZxuOCD
         ZwJNujT56w2QUJ168QylwwjTcv9hyhq8IlvsuOXV1mmlx2u/RFipumnuR3BE0y678Dn/
         a95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JiTWM+MdCg9IOgA/X0u2f0T1rgZVeqO24TUedvTmmc=;
        b=UehTQeECOG+1R2AU0k/tkLoBA++dxriCPN2pABN4RTa5/ptojxyhaI5zJTp2VU0mSz
         uCB6xFSO74bKiOo6QT6UDi/95UdXNRD1ZJk2Sv1B2BgBzD+0+Kr4SyKvGljDhj29iaXI
         iZp2uA9i9iCYAKYsnRejH3ysA/PBdQ4UgNbz+kReTlxndWJ50NdEU0+uLn13vmOenaHU
         m5VgTnG81uD06CF54OivT1inOWy02zmslgMER11kE/jetffYb7iTsE4TPZqZYu4UUWaN
         5oVyEWhmHtpTrrcGEiZZYZ62Ech7bQaifongNJvp6tNvWMXGevwaUK+ffvSoxNvfln1X
         ZxfA==
X-Gm-Message-State: AO0yUKVTe5jtHlsCZGzsHcG5CN7nmaY6VadlLWbF+KQ3mbsA9exYkW+O
	/nv+5kjjbEoTQlbmyzMavvMHJB2PNr8=
X-Google-Smtp-Source: AK7set8e9aHS66qEijLPrSgjb0p1ENJCJUISu//DTDwg5qsamOKPiPiIbIlHHU8JVjneCHV+4u0ErA==
X-Received: by 2002:a05:600c:198e:b0:3dc:42d2:aee4 with SMTP id t14-20020a05600c198e00b003dc42d2aee4mr3999503wmq.25.1678481168873;
        Fri, 10 Mar 2023 12:46:08 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc30c000000b003dc522dd25esm861432wmj.30.2023.03.10.12.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:46:08 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][PATCH 2/4] cookerdata: Remove incorrect SystemExit usage
Date: Fri, 10 Mar 2023 21:45:59 +0100
Message-Id: <20230310204601.730833-2-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310204601.730833-1-Martin.Jansa@gmail.com>
References: <20230310204601.730833-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 20:46:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14545

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Calling SystemExit doesn't work well with server/client usage since the string
isn't printed to the right place. Use bb.fatal() instead which prints the right
log output and raises and handled exception which then shows correctly on the
UI.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index fe5696c70..efa671aa0 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -435,7 +435,7 @@ class CookerDataBuilder(object):
                 msg += (" and bitbake did not find a conf/bblayers.conf file in"
                         " the expected location.\nMaybe you accidentally"
                         " invoked bitbake from the wrong directory?")
-            raise SystemExit(msg)
+            bb.fatal(msg)
 
         if not data.getVar("TOPDIR"):
             data.setVar("TOPDIR", os.path.abspath(os.getcwd()))
-- 
2.39.2


