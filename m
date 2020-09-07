Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web12.58.1599493779358249868
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2020 08:49:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fB3pJpkj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id q9so14791340wmj.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2020 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KnK1xrafawFf1Y5c1ufh79lTwmg4lSwMeZyVP8wyrY=;
        b=fB3pJpkjmNcOmdpoGzXOSLGySS0S29NWeFq0eUz75y0vFXh/DOrIHnvNFf0vo1tVKv
         G47DdzMyy2RLS+RlL2FW9G78J3qMAHSa8vbp00POJ7NyB6DhAM7unK3K1jtEuw0O6CdQ
         mvNf6uAvsC0oelJXIbKmz8EbVI6Ml2JjChXD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KnK1xrafawFf1Y5c1ufh79lTwmg4lSwMeZyVP8wyrY=;
        b=tY6rC9GX3Myeu/Gy5fvhfsqOLTkF5JuZ8VATr/BlZ8Ldj5rqkY1gHEsZVp6VdujB63
         7rk2YGOI5AHj7DwZ7Npy5MHuLsAtURbbtP63pjSd6RlJPPWBKyqqyzSExBkzi2q66I4O
         kMrkB43USwRqwzYQSh+UsLRdyyIWkkXdn6VgIGK4dyuEUJWra9LxVDKJXPhxLdXUxrzc
         xPCMTxrJdOljSytJ1wgO1hFsv/OIfcs61xlE3UIrVuAkqv/NQlauWAPQHFtdvOvaQ1bm
         LXI8PMBf//mNcGLH0mzEzJSRUhSHhtiZMoc5RjRSVw56AWMEhuFK7SC3eBgajnAYFvIq
         UKHQ==
X-Gm-Message-State: AOAM530t3pwNwiOMCGaG2RQ3lAK0wi9+Os0OfjGE/S6u+H/BHUasL1xe
	r2QKNycFXSDC4KN94nm7sEl0iyEb/R1zZA==
X-Google-Smtp-Source: ABdhPJx5j1A8LWLgusC/ULeOAW+SAjqNjh8ouT75iu/Z1tZYtHaMMD2Caguq8mdBcbj7W+7w/v4r3w==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr20347113wmk.125.1599493777325;
        Mon, 07 Sep 2020 08:49:37 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id h5sm29534503wrt.31.2020.09.07.08.49.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 08:49:36 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Ensure parser worker signal handlers are default
Date: Mon,  7 Sep 2020 16:49:36 +0100
Message-Id: <20200907154936.1928698-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise this can interfer with multiprocessing exit handling.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 7de3df018d..f3ff4274ad 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2090,6 +2090,8 @@ class CookerParser(object):
         if self.toparse:
             bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgdata)
             def init():
+                signal.signal(signal.SIGTERM, signal.SIG_DFL)
+                signal.signal(signal.SIGHUP, signal.SIG_DFL)
                 bb.utils.set_process_name(multiprocessing.current_process().name)
                 multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, exitpriority=1)
                 multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, exitpriority=1)
-- 
2.25.1

