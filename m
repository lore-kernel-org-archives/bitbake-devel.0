Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0D9D78798
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 16:11:10 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20207.1766160660380697084
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 08:11:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nXsmxhMW;
 spf=pass (domain: gmail.com, ip: 209.85.208.47, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso2449944a12.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766160659; x=1766765459; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YNo0IJIF5S14qJVRGpCnFVLNnSPvE+uxNcCUQLkH8w8=;
        b=nXsmxhMWvH0sQjGC4y8FHTE7gQc6PHgiPtgDnkHPo6BVHH60No5cDNQmhVZcuQN7WO
         RRTqP3pEdlhaxougdHccmozoKvbqvThUqiT1EovufFZSFjXDys+41wQPak/4BpT20gh0
         Bc1t3wJ/6JcefYUP9wye/G2IFjRDLXKsEPcflizOi2wGTz41B1wQr7CDiZOUqFzBDm52
         eRGlLcZQP3JVvy8hVvFtotJRPggRZRcMjtUireluZbC8mB9Al6hka4f7WTuslba5095l
         6aeyoegjaIQHP5zp72lLi4nZSFOxQonGkQ7sZpvgyfdWYFAm3A5QGdzRZUimKEQI+tnB
         6O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766160659; x=1766765459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNo0IJIF5S14qJVRGpCnFVLNnSPvE+uxNcCUQLkH8w8=;
        b=hiQ6viYEsTarJm+ON+pat+jpYHalf93Bsreqo8XaQPu8U97YQ/D0pem3I86sWZj19H
         D7RHuFTNhRE2nYwKkDJWBJ6eo4mSElyVcncyn+2M+U2hoFnNLXTT8+smT/xhbtTfQ93J
         pofO62zAH7PUqRGDJfAqt4bnYWoBMoIW8gw+h0HpxpdY0lUNTReaD14dipzHM8QRbjFN
         vo2K7IxUxQuU1dk/rKzU/jEL9b5nSEPY10842ttN0xahyZVA8woYp2wcDPS02xWw/6+/
         I+lT19tabySZWjsC5ahJ6quskSKqb79e7GLOoCN9JQgOV69lN+OkXYEdWcmHpOg+jHSx
         stvw==
X-Gm-Message-State: AOJu0YzkkkQBsi+7ZnUg4rsRamJ1DYbtoZLqm81YLDLihkJ31z+pf40s
	Zre05mTR8Wlwmq2+rr2ghWWlOBbQavGUr3rt2k4M1+Bp54F0OZmerjdP/sNtFA==
X-Gm-Gg: AY/fxX4nzlZ5ZpAz6vnUEl3zdmr3mO/zeHQ6uqAC1+BsNbCN/sRDE4VREwEgNTtuKzh
	xjGYbhURoJt7HoI7N6zuzt1oEqUjFyxJr4VyBONAkrtWoI5WxkhNiru7+/fH9mwXfDRD/6x0VdQ
	m3UzTw5RPqBJ7iVQ6kVTD7Y7ZEDxIaC9euAcj9T9GIHwTQJRVcNFzmuRQupP0bOFuaWt62q7veD
	CNspaVx/WaLiEu2t5gJppT9Sx0CzCYORzp3KkGhw/U5U9GbWZ/Jf4Xz7bqWl6bvN8xgcXiBqaEk
	sTPxaYKFnBWinE5KGCM6dqB2ElSzFmpCymNh2iDmKFs9xlSWusqHizgCcA1NAy27bLkKIduK/C+
	w89o4Vli++hTgrNm6/ubiAtlpMBMVSz8dZfIz8ORXTgBGiVv5/GLDP7vqiZg+i3Dj1tl9NphThP
	MaVWGgf2RkOKK0
X-Google-Smtp-Source: AGHT+IGSSZo4LwVdhArWi5HRvW1QbvtWHck0aI0Zi5KerfQKiL9HgRb9EwrLRdPPmJzelrlYY2adZQ==
X-Received: by 2002:a17:907:6eac:b0:b73:6b24:14a0 with SMTP id a640c23a62f3a-b8036f10e30mr349354366b.18.1766160658433;
        Fri, 19 Dec 2025 08:10:58 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:27:4771:315a:aa0f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f86sm262894466b.17.2025.12.19.08.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 08:10:57 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	paul@pbarker.dev
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v2 2/4] bitbake-layers: layerindex-fetch: Fix branch detection method
Date: Fri, 19 Dec 2025 17:10:51 +0100
Message-ID: <20251219161051.6503-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 16:11:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18623

Replace fragile parsing of 'git branch' output with the more reliable
'git name-rev --name-only HEAD' command to get the current branch name.
This avoids parsing issues and is the recommended way to get the current branch name.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2: change current branch detection to name-rev --name-only
---
 lib/bblayers/layerindex.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 0ffc95822b..1c6511889d 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -55,13 +55,15 @@ class LayerIndexPlugin(ActionPlugin):
             switching branches if necessary and possible.
             """
             base_cmd = ['git', '--git-dir=%s/.git' % repodir, '--work-tree=%s' % repodir]
-            cmd = base_cmd + ['branch']
+            # Get current branch name
+            cmd = base_cmd + ['name-rev', '--name-only', 'HEAD']
             completed_proc = subprocess.run(cmd, text=True, capture_output=True)
             if completed_proc.returncode:
                 logger.error("Unable to validate repo %s (%s)" % (repodir, completed_proc.stderr))
                 return None, None, None
             else:
-                if branch != completed_proc.stdout[2:-1]:
+                current_branch = completed_proc.stdout.strip()
+                if branch != current_branch:
                     cmd = base_cmd + ['status', '--short']
                     completed_proc = subprocess.run(cmd, text=True, capture_output=True)
                     if completed_proc.stdout.count('\n') != 0:
-- 
2.43.0


