Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A4FC433EF
	for <webhook@archiver.kernel.org>; Tue, 22 Mar 2022 17:24:47 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.13028.1647969886111847869
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Mar 2022 10:24:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Te1lDqVh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id h23so23794737wrb.8
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Mar 2022 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y24ydR3OEqG5BkqfZEoYmRxpagqim9fN5s+vdc6oLe8=;
        b=Te1lDqVhlV7xvi6BaGte4lFog98F0QT6ozZ0pCZUpwzxSPrxmj1NYgqmwXPtRUVPwg
         IgudyP45geHThXWyDMqOV7VB9ICL6XYcGymXtnjeCVN9lh5brjKTOsB2hyDsSeTO1um0
         C1Bqzhma3KvoH1Vy0X2SJGavkuF9HZ8CVV1YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y24ydR3OEqG5BkqfZEoYmRxpagqim9fN5s+vdc6oLe8=;
        b=Xh0nc7Lv9I7P1Lk9y+0LkZS6nHLt2pEDNlQ/Ti3nMpNBTjl1IQni0wx94YGjEbCJhZ
         jkjWdyzqC4+BWCzmunE82goB9TyO/jcS2iSbfqYFkqK0kPSS8JgvdvTbbySbrf7cc0wB
         Gjzs1qVm3GpW2hSszEl43QnZKM7Ns7ap/OkGAE8i+ygJOUC0DmD1hBgl7VqetYTM2D4c
         syMOtZOKVUzmf/PWZn6PL8/C6dnAfftj3mieY5yhsLHxN30wGH6JQrtgEBeZfYwyvBgV
         YvjorPosRZJu/wxK5P4R/EpgykEt9+Z+qVUXeLtXEMbzy0f331J6cQslsgn0pMQiGlXZ
         bfDw==
X-Gm-Message-State: AOAM531yguXqmmIE9cW9/Qo3njnycr5FlXk1FvcbeKaR+KNER7/Sd7N+
	ZNMl2nUA/QiVoGE4UoTM9G4eAVaBJHs2YS9n
X-Google-Smtp-Source: 
 ABdhPJwrgvnlv4D11SBnk+tTDUawLL98dhahzwtwx8b86WtggkAexFFaDSaAGDsunKh49v/68WRxUw==
X-Received: by 2002:adf:eb89:0:b0:1e4:b8f4:da74 with SMTP id
 t9-20020adfeb89000000b001e4b8f4da74mr24113535wrn.408.1647969884300;
        Tue, 22 Mar 2022 10:24:44 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4096:7441:f015:a6fe])
        by smtp.gmail.com with ESMTPSA id
 e8-20020a056000178800b00203da3bb4d2sm17282947wrg.41.2022.03.22.10.24.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:24:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Improve ambiguous use of 'dependent'
Date: Tue, 22 Mar 2022 17:24:43 +0000
Message-Id: <20220322172443.1240740-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Mar 2022 17:24:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13496

I'd never spotted this until it was pointed out but the task isn't dependent,
it is a dependency. Fix this confusing reference.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index ebba452592..96e16a45f8 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -1002,7 +1002,7 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
         if changed:
             for dep in sorted(changed):
                 if not collapsed:
-                    output.append(color_format("{color_title}Hash for dependent task %s changed{color_default} from %s to %s") % (clean_basepath(dep), a[dep], b[dep]))
+                    output.append(color_format("{color_title}Hash for task dependency %s changed{color_default} from %s to %s") % (clean_basepath(dep), a[dep], b[dep]))
                 if callable(recursecb):
                     recout = recursecb(dep, a[dep], b[dep])
                     if recout:
-- 
2.32.0


