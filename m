Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
 by mx.groups.io with SMTP id smtpd.web12.12029.1595510416634516311
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jul 2020 06:20:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=klAZc/k9;
 spf=pass (domain: gmail.com, ip: 209.85.166.68, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f68.google.com with SMTP id z6so6189916iow.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Jul 2020 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGneBLy5Q+ManxBSWo1qRISzZa8Fy2sAo1luPUmObsY=;
        b=klAZc/k9tq3HMz8kfVBUIbc/pK265qD57q9mSK5+5bZU9x7LlbJyqnge0CikU+goRr
         wt4ncsC2mdCKlnIjcOBeaKRCbWW2pjyQB3ChkSzoHPLrYNMyuG9npauhb8PdogakdZN+
         OnjgTfEC9WDdiSIwV1Ko2RKeHr4LqOGJ3vb0hLSRcMsBjWaiLnq28Zezbh1sV/cVvN4y
         Y05CK35Ljv+HsrZGJBGSkMrWpBm8ScjhDR7/23f58WVtqWtbkXAJK48zUJnyhYYji4Jh
         p+OXCf+sO75JUOjMU4nMuyvx/aTQ6AsemLPyF/AX14iK68qZBY26FWR2kXHE9FffWXnJ
         8Tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGneBLy5Q+ManxBSWo1qRISzZa8Fy2sAo1luPUmObsY=;
        b=rhkn7J9jMBwi5oaj7IEymEzmRwh61A5kTV7fbV0Y/CIEXuYde1nREpmOtXxjrqbzZi
         Y45pN32jv5LPbBfZkhF4cG4SbHifjTMwX/aBhxZFID3V3CSailfwqXLyPTc4qbBahCMD
         ETLbTgZE/xL96ur141t03j8fa3FE5tF335gHU6QnFqoA9DalA0T3DlGxPwif9mJpwbgT
         FxZvK9PktS24B/TTvVro+5dyETfoPHom6hRqRvMCmSFQDdY6uT14URzihhTLrAjP7LlP
         bBiVZB9c4LQCzfrKFk4OM39Ijf3v/YPNmXL34R8t3MNdArCYGNfLceQQpLoUz8gYyvl4
         ah6Q==
X-Gm-Message-State: AOAM533aIO8GdXQqzMofyOFP0Zf4UD8hvUhgzdTDwFTdvdDoWb0gp3GS
	eHjTdr+LMYqsmgwaqoAbYlXGQDdR9D8=
X-Google-Smtp-Source: ABdhPJz91O06OKi20BfcnaL9ZS/MzHneGKSZfztq0FH5Emgf4fR6abvCFJd65FlNYuXceaZCZEUJZw==
X-Received: by 2002:a02:a909:: with SMTP id n9mr4831141jam.70.1595510415733;
        Thu, 23 Jul 2020 06:20:15 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:9c5e:b78a:a4eb:7dd7])
        by smtp.gmail.com with ESMTPSA id k24sm1481135ilg.66.2020.07.23.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 06:20:15 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: command: Handle multiconfig in findSigInfo
Date: Thu, 23 Jul 2020 08:20:12 -0500
Message-Id: <20200723132012.28287-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the findSigInfo command to accept a recipe specified with the
multiconfig prefix

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/command.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 805ed9216c..48a7f1a158 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -723,10 +723,10 @@ class CommandsAsync:
         """
         Find signature info files via the signature generator
         """
-        pn = params[0]
+        (mc, pn) = bb.runqueue.split_mc(params[0])
         taskname = params[1]
         sigs = params[2]
-        res = bb.siggen.find_siginfo(pn, taskname, sigs, command.cooker.data)
-        bb.event.fire(bb.event.FindSigInfoResult(res), command.cooker.data)
+        res = bb.siggen.find_siginfo(pn, taskname, sigs, command.cooker.databuilder.mcdata[mc])
+        bb.event.fire(bb.event.FindSigInfoResult(res), command.cooker.databuilder.mcdata[mc])
         command.finishAsyncCommand()
     findSigInfo.needcache = False
-- 
2.27.0

