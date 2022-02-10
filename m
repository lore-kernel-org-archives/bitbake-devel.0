Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FFAC433FE
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 09:21:29 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.7961.1644484887628548153
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 01:21:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=N2totG8a;
 spf=pass (domain: gmail.com, ip: 209.85.221.44,
 mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id s18so8345920wrv.7
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 01:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4SGN2/vHFTl/DyYQwIk18wLuPCjnpCrjwJ2WBvlmPo=;
        b=N2totG8aRHKQHA+zarsiWT4I8d56iT9jK6UqfssY0kIBlMqMIw49u5MyR6xE/Iqh/2
         o4Dr9PC8Kt5MECXQ+1xdwWYODA3Qus3OWGk8FUJv+Ihm1Z7PBMbYEPMkj1ygPsi48/ys
         ySljBKpOWabMCXfMcuYWqVpSCkcDcTa7l7xks3jKIQko69vxCDJOOqZVRhssR7avM6kv
         fxM4RZYmpjCrrqRBn+Q2JtB3/FcK7FOBNkBKJI2w8Nnv6pn0C3O4rjWlawiiPlu5sMVq
         3ZDkCfPARs6NMHxc1Wd4DWurpC7G/QGhfdhtioJNHBdTasxkzxbO/09pe/gkO5Bo90TE
         TTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4SGN2/vHFTl/DyYQwIk18wLuPCjnpCrjwJ2WBvlmPo=;
        b=ebqLW432WUVW/VFj7FYgQh49KMAUGflsDHsmw92g+v/zgmBqxP7t+9sYvUaEFzM50l
         QZoqOXorGJgRyLlxZP96a4b/3wpYweO9L7iQr/oGjgS/9esnWxm+H7tbiSbr1EMrZdKC
         aZuuEYcCqesVqXnPPQNPIju+SJjswjFO2lvk+bh80rvJWrnA95dPV735IcheR3ypx72K
         fVmnwQmQW2evRN0Bs7AF4pLGS+cpWgAViUlvFh0PHsD8Gz6TsKj8Uh0t+38dfwOa2HgX
         mWE0IJiueyZws6cMWA3DFVJlro6fmB79ljkDLN8gH4pNjW7DBnHAFud4MDpakOvBlcxJ
         Rfdg==
X-Gm-Message-State: AOAM533Y1lV+8rv4AxOWQUWXRL5YMRabdXScjv99KOzrwClXx8HwcCso
	cRxl9xb14cD15F+EW9Qh2IJUxiBzUjEIjG4b
X-Google-Smtp-Source: 
 ABdhPJyWNoZH+ZO1q9ZtJK3LjsPP4KQRMdF0ksNWeFMZgsGYUABHgzngM3wAEdWemTrD8GfWP1hv0g==
X-Received: by 2002:a05:6000:4b:: with SMTP id
 k11mr5463931wrx.144.1644484885911;
        Thu, 10 Feb 2022 01:21:25 -0800 (PST)
Received: from localhost.localdomain ([194.99.105.106])
        by smtp.gmail.com with ESMTPSA id
 e8sm3672641wru.37.2022.02.10.01.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 01:21:25 -0800 (PST)
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>,
	Jan Brzezanski <jan.brzezanski@gmail.com>
Subject: [PATCH] fetch2/git.py: Check if clonedir is not empty after shallow
 tarball clone
Date: Thu, 10 Feb 2022 10:21:19 +0100
Message-Id: <20220210092119.3994-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Feb 2022 09:21:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13326

If shallow tarball clone is used and if tar unpacking fails for any
reason it might end up with empty directory created. Since runfetchcmd
does not check any return code we might not detect the issue and we will
not clone from git. Then due to missing hash it will replace main
repository's git remote with the remote of failing recipe.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
---
 lib/bb/fetch2/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 30da8e95..cd317633 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -356,8 +356,8 @@ class Git(FetchMethod):
 
         repourl = self._get_repo_url(ud)
 
-        # If the repo still doesn't exist, fallback to cloning it
-        if not os.path.exists(ud.clonedir):
+        # If the repo still doesn't exist or is empty, fallback to cloning it
+        if not os.path.exists(ud.clonedir) or not os.listdir(ud.clonedir):
             # We do this since git will use a "-l" option automatically for local urls where possible
             if repourl.startswith("file://"):
                 repourl = repourl[7:]
-- 
2.34.1


