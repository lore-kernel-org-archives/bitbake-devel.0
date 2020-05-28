Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web12.13077.1590675554088140868
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 07:19:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=DKIp9HCd;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: maurofrqueiros@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id r15so3339173wmh.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2020 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LBqCmHy9j7zWvQAN5VkjE2YiwdPgWwGDQ4IV5iF1NV8=;
        b=DKIp9HCdeukZkscupqebi06jAoZ8hRE2XJHToehRhlNN0btMJEEbniaQajw4pI3zZL
         x0YqAYTWRnUnaSqLtXC28DNZCWNg/UAvgI9z9CAeZGYeqpQJfqOKBZOJRn+muyhFK19Q
         pgRjhKNWwIBqAD6XOxDwo+E8VQERBB8pb08J+VI98Krgbt4stPHl0UrGTk3qOxEDXULK
         7818ak1DLA5L4DBsWc7vKKYAU1y8Z+MpZYLUzMW7d8dcpoxwOVTQjzXplqcB7Zh0qCb2
         6LJcNWgseRY8NafEikMHWoDXJQvduvFz6KpXECU1bj8m0+76nO72WPSFA1HYK7x6dTXe
         tNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LBqCmHy9j7zWvQAN5VkjE2YiwdPgWwGDQ4IV5iF1NV8=;
        b=mpJYf+hIRBMigv6p3x723bX07CEQTQv4J7KNplwCQDWnjajwX1oXYKt1b6rVkFMQrD
         +7RqrCFq1TOXepYeVm/ztNAZ1e6AxfeXneWlns03WLPzTPaFg1cBkFqG8ANxC/eWCyNk
         gI1awfpVGkfuyd5r9n1cdyM2Vr013YujaKrey+ulwecJiurmrAoMSWISCw8g/F/EpQ8g
         qSgxgLrVSRtZA9jk9Rko4ZzqQfaUmJBWwTmjl3XOFhJC7g+Xi7EcGXM+lrfW0uuG+yn2
         nTrIbOAT+XW7xKrgxCwvIeR3tYAX/ayafbZ+B2z4OHR0kdkAKz5l4UTiN06hv1+feCKC
         62oA==
X-Gm-Message-State: AOAM531UpQsjyFvC1fe5UqhcsoM/LRAJsNlB/4lP8g/q++fHTu1lTFhe
	1p7Oz/P/dfNGQpp0udBhkSB5PRhzqjHGhw==
X-Google-Smtp-Source: ABdhPJym6N58bw3PX35uNCc6ZxGOYmUMS2GVuFf04Re7iaHYJ90/SExjxJ4VZkklyn2R29ILPP/4Rw==
X-Received: by 2002:a1c:ab07:: with SMTP id u7mr761019wme.130.1590675552420;
        Thu, 28 May 2020 07:19:12 -0700 (PDT)
Return-Path: <maurofrqueiros@gmail.com>
Received: from ctw-bre-003.criticaltechworks.com ([83.240.214.249])
        by smtp.gmail.com with ESMTPSA id q4sm6942497wma.47.2020.05.28.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:19:11 -0700 (PDT)
From: =?UTF-8?B?TWF1cm8gUXVlaXLDs3M=?= <maurofrqueiros@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mauro Queiros <maurofrqueiros@gmail.com>
Subject: [PATCH 3/3] git.py: Use the correct branch to check if the repository has LFS objects.
Date: Thu, 28 May 2020 15:18:53 +0100
Message-Id: <20200528141853.213890-3-maurofrqueiros@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200528141853.213890-1-maurofrqueiros@gmail.com>
References: <20200528141853.213890-1-maurofrqueiros@gmail.com>

Function "contains_lfs" was only looking at the master branch when searching for LFS
content. LFS may be configured in specific branches only, so we need to use the
correct branch.

Signed-off-by: Mauro Queiros <maurofrqueiros@gmail.com>
---
 lib/bb/fetch2/git.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index eab76a10..b7841c43 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -566,8 +566,15 @@ class Git(FetchMethod):
         """
         Check if the repository has 'lfs' (large file) content
         """
-        cmd = "%s grep lfs HEAD:.gitattributes | wc -l" % (
-                ud.basecmd)
+
+        if not ud.nobranch:
+            branchname = ud.branches[ud.names[0]]
+        else:
+            branchname = "master"
+
+        cmd = "%s show %s:.lfsconfig" % (
+                ud.basecmd, branchname)
+
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
             if int(output) > 0:
-- 
2.17.1

