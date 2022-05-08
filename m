Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF2C433EF
	for <webhook@archiver.kernel.org>; Sun,  8 May 2022 22:52:29 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.25619.1652050348106530473
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 May 2022 15:52:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bpIYwJfB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id d5so17138371wrb.6
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 May 2022 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9XCiDTleIa7aa8Z0tNmha9jcNgXp2f2ExymgMXZu0Tc=;
        b=bpIYwJfBf1q7OsVOB3jGv0J+lzaNZhXDS80qlNcauLbu2UiNBjHFDXIlw7nTglOt3K
         kz+S1s20w8t23/ev6/ff2au7ycRqZbnAmTiPrv4aSszH/txQ79AXyjDagzFHBHTD5jD3
         fCk8Xi50GdLrHPvmtL8seRJzujEayE5cT1O2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9XCiDTleIa7aa8Z0tNmha9jcNgXp2f2ExymgMXZu0Tc=;
        b=gFU0nzcZKBBp+Ec5R9vm4jMHIBM5mXdcP53V+pKfK+SaOWyfXMaiGULr8+TnjqZa4l
         auUSMl+tkox7zbzjpORenJQumMQrf6I+CvaaSUqIzxkiROmUva/+aKa4MhmMOwG44Fq2
         hfYDWDAm6zVceZcUNya1H/TvJDk+Thj5SAq9BVSP3dsF/jLIdB4/EX3kEREsL4wRoozQ
         HZdNeQUvSF1Hy7qQNF3rCvU5gjORSrwXzSiYS8256U4ahVzs7DS0c+WXdWEtbAUKUdye
         ghoSiIy4qmsbPjlZ/1ppJ2gSFmFksnoSVa1I5EaV8QRLosXLaqCX3htOv9aSTeh2Pjxg
         6L0Q==
X-Gm-Message-State: AOAM530RosWE0TkpbjyJqha4fs28Oj8/4mDg1h3C1elRTtRvHtxEjxOr
	J8ghNstvZaVdW5cJaJJVVKVjH90shDYqv9Gn
X-Google-Smtp-Source: 
 ABdhPJzdqVt/16ncV5PGCu+2aIt7OxnAYBgIpl2fOoGxhTH5hYjPBCjtsQIRE6trZ+dQKnqowIafcA==
X-Received: by 2002:a5d:4348:0:b0:206:1c79:fd57 with SMTP id
 u8-20020a5d4348000000b002061c79fd57mr11636932wrr.344.1652050346216;
        Sun, 08 May 2022 15:52:26 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9751:d995:8644:a17e])
        by smtp.gmail.com with ESMTPSA id
 f3-20020a5d4dc3000000b0020cb7c89611sm4441285wru.107.2022.05.08.15.52.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 15:52:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/git : Use cat as pager
Date: Sun,  8 May 2022 23:52:24 +0100
Message-Id: <20220508225224.182959-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 08 May 2022 22:52:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13679

We don't have less in HOSTTOOLS in OE and this can confuse git. Force the
pager to cat to be consistent and minimal everywhere.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index bdcfa4978c..23f8c0da8f 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -243,7 +243,7 @@ class Git(FetchMethod):
             for name in ud.names:
                 ud.unresolvedrev[name] = 'HEAD'
 
-        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false"
+        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false -c core.pager=cat"
 
         write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
         ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
-- 
2.34.1


