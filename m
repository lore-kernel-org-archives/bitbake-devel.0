Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41292C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 13:27:29 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.9989.1644499645223819395
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 05:27:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ieK9YAOm;
 spf=pass (domain: gmail.com, ip: 209.85.167.54,
 mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id f10so10408903lfu.8
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 05:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX9OSC5DqNn0lmsRpASq9SFRb+rFhOtSWb4s1w26Zhg=;
        b=ieK9YAOm0Ku87S58g/3z3EQPGzZXkCcBDllGWzf5z3R1lLTHHgsTIgupDNkuWZhU4o
         rVa8vMB/iVpVUaL++oe/hJf8KILvUhPTJpUqtCiIc16ldFZu/lorRd6q+GhkUzePrEcm
         DdBhEIOG+ZaIAUjlMesmETNw9PMn+1oNDIKRX8pWkNlHXT/OXyTp7+nH/C2C1aQ1etTj
         2esLSiAyQWmgqj6I4GBScLrHtBc86EFsBwYHoCGqHrmC5bjCpAtm0EXCizDF9JUW949I
         mJpz4p5xl26GbSF1DqgEkKuiQpuzWv/kRJrvo04T0DJOj23TQOiHpVSFv44uJ1gUUi0s
         DfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX9OSC5DqNn0lmsRpASq9SFRb+rFhOtSWb4s1w26Zhg=;
        b=1iZgI7jZi1GEPsGJcrad5Tn0OSIuNtm5Z7BGwaIivHm0M3qqn4vAgelCCw+sbcJZ4q
         iVRDFU5ZASE1FFbK77glZO9zJ/H1miXBdxkjKKvyTTNYkyiUiePZPHb96VzYoYsxan4+
         AukBV1d6mc2WoOM5OrCTxGtvoI2KKls9rWoqzdHKwGu0LFPF1ruNkwgO4YW/12N6INQb
         OqV9AMSGRe7HjEOjvkl1JwXiwNp7T+vwf+Uf3YelTWQ9Z5cjwLxBw2Y4aqkHt0gmrK9w
         WnlAMgyfKI1MI8lnkIvtgpN/Qx3xXhfd6R5NZ+AZ77AKok77kS1x3JoV1S+aUugYhFoQ
         3gHw==
X-Gm-Message-State: AOAM530mH92nZb82oxB6MT6Mu5Uma0FYN+u3Oo+XWZBQwYirUstd5r7h
	fG8fE6BanHhUwCvvW198u0eV/riFZMCt1KB2
X-Google-Smtp-Source: 
 ABdhPJzloti/WGeBK/AZ4uMN6ZYFBqq3NZZ9omck1+poTT42nEW9RYUFKgJ1/AtvQUwq6YN7ztQXXw==
X-Received: by 2002:a05:6512:308f:: with SMTP id
 z15mr4931526lfd.192.1644499642790;
        Thu, 10 Feb 2022 05:27:22 -0800 (PST)
Received: from localhost.localdomain ([45.134.212.152])
        by smtp.gmail.com with ESMTPSA id
 p16sm2864928ljc.86.2022.02.10.05.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 05:27:22 -0800 (PST)
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: pavel@zhukoff.net,
	Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>,
	Jan Brzezanski <jan.brzezanski@gmail.com>
Subject: [PATCH v2] fetch2/git.py: Check if clonedir is correct after shallow
 tarball clone
Date: Thu, 10 Feb 2022 14:27:14 +0100
Message-Id: <20220210132714.22921-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Feb 2022 13:27:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13328

If shallow tarball clone is used and if tar unpacking fails for any
reason it might end up with empty directory created. Since runfetchcmd
does not check any return code we might not detect the issue and we will
not clone from git. Then due to missing hash it will replace main
repository's git remote with the remote of failing recipe.

To fix this behaviour we'll check if clonedir is not empty and if git
dir is the same as clonedir.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
---
 lib/bb/fetch2/git.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 30da8e95..ed6ecb64 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -356,8 +356,15 @@ class Git(FetchMethod):
 
         repourl = self._get_repo_url(ud)
 
-        # If the repo still doesn't exist, fallback to cloning it
-        if not os.path.exists(ud.clonedir):
+        # Clean repo if git dir is different than ud.clonedir, which means tar unpacking failed
+        if os.path.exists(ud.clonedir):
+            if ud.clonedir != runfetchcmd("%s -C %s rev-parse --git-dir" % (ud.basecmd, ud.clonedir), d):
+                bb.utils.remove(ud.clonedir, recurse=True)
+                bb.utils.mkdirhier(ud.clonedir)
+                os.chdir(ud.clonedir)
+
+        # If the repo still doesn't exist or is empty, fallback to cloning it
+        if not os.path.exists(ud.clonedir) or not os.listdir(ud.clonedir):
             # We do this since git will use a "-l" option automatically for local urls where possible
             if repourl.startswith("file://"):
                 repourl = repourl[7:]
-- 
2.34.1


