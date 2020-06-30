Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.7722.1593486539073858640
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2020 20:08:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=j0T4fo2S;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.180, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f180.google.com with SMTP id 35so7903825ple.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2020 20:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=h9xyeslpVF7fdWBWZ/mc7j5QQq6cpe//8/EpGq7mta4=;
        b=j0T4fo2SzmaSpOyn6EyFOt2N7m9hofgPmgaKkctoJY+QdmSjTCgLagfOFGZ1ufKPR8
         3398KFlNq+Om7cJXQQl/g4ZA9voPFidAqRxtW0ZWHElKdrEIUYVybnHWSVEpbERgf3/n
         4+GHUHTObn64L9IzsJYd4cYCQmrMUwsFAMmHcghpztRVPSBeHIQWJ4Cyjjf82+bzAjRL
         Gvp1/Bci9yvHwbLa4KfD4korXbT/fgHOb/GP/de6NH/vhixnKQ/NDIJ3+pPt4qc6Ccei
         KceT451HDJguXrHy/zbAKgyELwj9xfRnGigq5WzIJuZXhAFt7z27db794nIlB4CDpz26
         d7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=h9xyeslpVF7fdWBWZ/mc7j5QQq6cpe//8/EpGq7mta4=;
        b=mFT5C6a4qBCWbp90A1fhNkgoP6RG0WBG+dki1jQ+aIUQn3dPHV701gj0r5JGCaEtcG
         L/nA4eAuzrwjz8aXROOFUaHdTR+NY2V5KGMAfCWA1V/ohzoNrs2ful0iMDtsvvpLsqs4
         fyn+nsyKoiI8Zxlil1yRFPDqlYQjkSPkyyLh9KR1rI858ZuTH81jggsSf8anOTqEdCv8
         AqYXdcKhgMPbGrdeh6DzKvW0mOUBLcz4lmISG+X/xsZmk+KRF8ba9v618pq+Qt0FPAGJ
         wfW9y4H1RZRW2gD9PHRfZ1N0Q0VdqXkZYaomjrQVAza9m/PQJw4PQQ7TXYtRsFU7UVbo
         mv4w==
X-Gm-Message-State: AOAM530PjT/wauaSHIn9p5ZXmYFwJ7G1s5yWirS+8zJX5307SC/kQ2Sx
	63pkCuebG+qKrXGBISHc0W/p7lHMOSBugQ==
X-Google-Smtp-Source: ABdhPJzAMGmK64ipAL6vdjWnND2Z5tsQIcMPvT9UiJWJLFVcIXYzWZY98N7kCGC63nqNxX2T8lj9sw==
X-Received: by 2002:a17:90b:918:: with SMTP id bo24mr7530841pjb.191.1593486538013;
        Mon, 29 Jun 2020 20:08:58 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com ([99.197.43.113])
        by smtp.gmail.com with ESMTPSA id n14sm970933pgd.78.2020.06.29.20.08.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 20:08:57 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/6] test/fetch: change to better svn source
Date: Mon, 29 Jun 2020 17:08:22 -1000
Message-Id: <a587bbb15ebb29b5239ec09956d4a8f653ab29ff.1593486375.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593486375.git.steve@sakoman.com>
References: <cover.1593486375.git.steve@sakoman.com>

From: akuster <akuster808@gmail.com>

fixes:
svn: warning: W175002: Unexpected HTTP status 504 'Gateway Timeout' on '/openembedded/bitbake/!svn/vcc/default'
svn: E205011: Failure occurred processing one or more externals definitions

picked pcre2

[Yocto #13948]

Signed-off-by: Armin Kuster <akuster808@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1483d17108da02f5d615e83403d5fd6288ca957c)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4697ef59..29c96b2b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1031,7 +1031,7 @@ class SVNTest(FetcherTest):
 
         bb.process.run("svn co %s svnfetch_co" % self.repo_url, cwd=self.tempdir)
         # Github will emulate SVN.  Use this to check if we're downloding...
-        bb.process.run("svn propset svn:externals 'bitbake http://github.com/openembedded/bitbake' .",
+        bb.process.run("svn propset svn:externals 'bitbake svn://vcs.pcre.org/pcre2/code' .",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
         bb.process.run("svn commit --non-interactive -m 'Add external'",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
-- 
2.17.1

