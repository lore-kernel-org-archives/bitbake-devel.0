Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.8348.1594206739718297066
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jul 2020 04:12:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IDRnJuks;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id q5so48445353wru.6
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Jul 2020 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xsCCCKtXlXqyvFrz36rGMPWAETQwoZvNRK89lSQuFA=;
        b=IDRnJuksXPnWuowWmNagaVLf+T8y6WEN1VRQrpNeBvqtbswp5IHlWSJP/UlXf0R7fb
         NPD3CaOFXU3QL3Q7gCN6E22BTbO9xYBOIJMHyoAsrPL7jrbz+ea6L8NxCpvkFT4IDnfg
         YKrO2SVgyKeoyn2Uba/2sGhDgBk3D2UCAK3Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xsCCCKtXlXqyvFrz36rGMPWAETQwoZvNRK89lSQuFA=;
        b=Z1N0DBN4q6AgjaYwNChsH/PBLQeDt79sv4jqBbK9AJNtZaNPTzNf5RJuFJ0xVNcrPI
         cjJjq6o8gGjoTBNJJkRVQZbycJ/ZYL4oR6udW+KzZLn8tUlBPdhS83yjHjBwY/z6USWJ
         NIpKeHuatHbwKDf76YT9tpYrNLwb+r3quLi0Ttag0PZsktgsmD2QQFrqLk4EgGgns1O3
         MBBIfXxIN2H66qjpssrHmn8ZInfOoZP1kYNVRRcpRO5xhGxc09txo4eEGMUAmqRGEyuG
         qsYQZd7Pn7NgHP53fdPS0GVV1mu4pqyGJG/PNV2y/KEtZ6ig5dNU8rXl2RvL0HQ4RgFR
         EGoA==
X-Gm-Message-State: AOAM531mnWRAHgmB+2cRMJQEX/GrGpkxIRsF7SZqAktKYAqjCtJD3JAn
	AV+TwtIp4BzozYyWavPaYazn7Bm7qFA3iQ==
X-Google-Smtp-Source: ABdhPJzxt6tAkUGlC7kGS8+lvCXEzn01bGxmRsLclwavl4iyZ7E/dDbg0uM0TfPQxyojWmHPfYMhJw==
X-Received: by 2002:adf:8b50:: with SMTP id v16mr61037878wra.188.1594206737913;
        Wed, 08 Jul 2020 04:12:17 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id s10sm5641654wme.31.2020.07.08.04.12.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:17 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Change git fetcher not to destroy old references
Date: Wed,  8 Jul 2020 12:12:15 +0100
Message-Id: <20200708111215.375782-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It looks like we're about to see a lot of changes in branch names in repos. If
we have the prune option here, those old names are lost, the changes propagate
to our source mirrors and our old releases break.

We have the force option so any replaced references should be replaced, its only
orphaned branches which will now be preerved.

I believe this behaviour will cause use fewer problems given the changes that
look likely to happen.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index dbf8715674..644ba9238b 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -355,7 +355,7 @@ class Git(FetchMethod):
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
 
             runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, repourl), d, workdir=ud.clonedir)
-            fetch_cmd = "LANG=C %s fetch -f --prune --progress %s refs/*:refs/*" % (ud.basecmd, repourl)
+            fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, repourl)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
-- 
2.25.1

