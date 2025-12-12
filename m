Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E292D59D89
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 19:08:53 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1126.1765566528296050768
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 11:08:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IqWMrGik;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so2689683a12.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 11:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765566527; x=1766171327; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irjqQWCwgc17nbPT2S8YbDMd0aYEXXOPJFYpP4W7Ui4=;
        b=IqWMrGiklCDVirpYqHCIvLbt8dmcwAQJLRcRfjt3AphlS4xLOYTQX8wlLrPdL8I7Ge
         edJBGUBlfBLllpeAJh4swzdPlxa/72k0ikZVGkKonI1cuNVNGHrbP4lhPapyW2FuE+1b
         /2zVKMvlITC16yM8TW0TFY0H9u0kojRAx+aN2fdH25Z0R4VwaXH12ezUGW+jsfDf35Fj
         MMQAlIiDgwojuaW+qJD8HSmRS60LBuAL2ZTl4F+hUN0zDCyJKG8k2Y5e9n0+iVq83WuP
         wJsD4iSYLH4Z+XTLpYukHc9fQOS12Kx+Ko63o7MnbOpoYs9+8I6603xE7+n7M4YdokBH
         JDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765566527; x=1766171327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=irjqQWCwgc17nbPT2S8YbDMd0aYEXXOPJFYpP4W7Ui4=;
        b=B5ZzOmwZr+3PBCAme0hRsQc8bsqzAFdsFgJzLoIyAKIcA1fJmEG5lGSKBebB2x69zi
         ElYGmVWDq9Us9C0i1gV3XznmNhdRU4Mcqe61HhS26jqBk2GW2GygLrWLx4YgRTkuA1Mn
         8fNTcVGgK5F9XdqQblQB8cHwTxH3CAKfApA7Eu6CbhLOZM4O+aok84RtP2lFtaqMQf6z
         hSQSmcBGcRu2f7AC9hi/f610BGUQHbu2yOaD+umz/tXFraGVzcrpQXjW3KJ9l8ZAuzqA
         DHfXQyJU2VC2DQQ09HvN9xEMzX9AuSs6Z4w4AR87UzybUgUocsbRelINAkehKePxpJUl
         jB0g==
X-Gm-Message-State: AOJu0YzQcWcoVs6+Bw2rH73IrS0hLs1i5EUClbdkMHO2xgoerQMi6GCQ
	Qvu83hVTLpwUwU3Unh+J5bv58uhNuWDrDBFSMovz6BFJuH2r/1ppJMsfUIMcJA==
X-Gm-Gg: AY/fxX4rQ3nIxoApOct4kjJ7BAyl8RsKymphx/iYCzgBVuVUn6lI8xkruRQh1NHH9Ud
	1j2bXVfIi+22TQIa48M5lc/RAlcOPpiUPVFMHb8JvqzlWPOxk2RX3fcGGokZqXdYXOarRNLVWVW
	f/NXFg67miUYEGfjUCwa898YCRGSUii4BConSV4x44DSOKdxFG6zxGTH/9cVwCzCRUkE7kamU6r
	bhl5/XcJFeJkuW4hONfy2MiKgoSReHnO5YftqEcG31STBlPCtNC8wcCSK9mmZZ6ra1mu86I1ZuC
	g9ZirDFVcoeJXCGxEEM/anpcOGmBaKEn07een/6ZVbCtJzUWA9PmOsAGdv5Z0je/F4KWpkm3cb+
	jlXDNcd1Syq1d1Pt54HTqz8XmtgysvYwJcsp8q6HxWpodSsICUaynEoaTniH/nbY5k6YSRQ/EqL
	hLoqBZYa6mbu14yzjSlG86kHq3mQ==
X-Google-Smtp-Source: AGHT+IEhvLRqwNKKYNOwOnV+yTvRvgyhqNyDoWIhOsMZ/wSfbTGgiOhvX3IBzhUpux8QhIkgpWS7/A==
X-Received: by 2002:a05:6402:2553:b0:645:d764:3fcb with SMTP id 4fb4d7f45d1cf-6499b1e3610mr3178904a12.28.1765566526549;
        Fri, 12 Dec 2025 11:08:46 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:1401:37b6:6a29:b0c5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210de23sm6147003a12.28.2025.12.12.11.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 11:08:46 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 1/4] bitbake-layers: layerindex-fetch: Fix undefined stderr variable
Date: Fri, 12 Dec 2025 20:08:03 +0100
Message-ID: <20251212190806.32476-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212190806.32476-1-osama.abdelkader@gmail.com>
References: <20251212190806.32476-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 19:08:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18580

Fix undefined 'stderr' variable in error handling. The variable should
be 'completed_proc.stderr' to properly display the error message from the git command.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 lib/bblayers/layerindex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index ba91fac669..0ffc95822b 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -58,7 +58,7 @@ class LayerIndexPlugin(ActionPlugin):
             cmd = base_cmd + ['branch']
             completed_proc = subprocess.run(cmd, text=True, capture_output=True)
             if completed_proc.returncode:
-                logger.error("Unable to validate repo %s (%s)" % (repodir, stderr))
+                logger.error("Unable to validate repo %s (%s)" % (repodir, completed_proc.stderr))
                 return None, None, None
             else:
                 if branch != completed_proc.stdout[2:-1]:
-- 
2.43.0


