Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C28FF9EDFC
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 15:19:32 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.85251.1776871164336890331
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Apr 2026 08:19:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JlV1CErM;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so24310635e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871162; x=1777475962; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w41vFNHOqWx0n33s1UH/Sv0plJWxcOrAS+1RMqL1v5Q=;
        b=JlV1CErMcGyqEWGlDKLwauGxt/T3zmYcdP9x1zMRmxhbkL0XP/E5QlnAXGDv4uC2BL
         8rrfhSwCo3m+t5j9LJ+u47mfiCRt86FX6qTUKuphy3LW+39s8o8IjYVVRF5rUlWmiN+E
         pTdkZEqwItp0vAlAtR33VCeVOJd0cl0ENlrnorVS+bA2541Z2fPZlomEbgpWZ++GQ34Z
         243dbll6bdPRl8JmgYWJByWJigpMnuSH8YDWtVIb5NOd53tzqwEsWyjI7Cyn/zkiJ2UZ
         Zrngtf2sbnPukqwgRPlA2iWgZe6KO99/vFMvNyy6MyCiYj5oxkHmTXxIeazWicZODfp7
         tLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871162; x=1777475962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w41vFNHOqWx0n33s1UH/Sv0plJWxcOrAS+1RMqL1v5Q=;
        b=DhCYfefEx0VDezNDn1cELXfGuCjk+AWKB6l4LfHwbKOJYg805Kt5CR517ytAIa3HMB
         Nvhaor7CKVbv2YpcqN57Swyj/QpOHsdGGbUn8pfLmKa4gXPvp/S+UrQSFkdWsIAob7RH
         KtwM1BPK5ZGfZrfWtAJUwkLbJ13FK5JnOUjsCsLHPd4Rf1uo6mnZ/acAa23Bwq9rz/lk
         tu/228pVGFnKpcuZ/BP6ogDz8wLpZE3IPHSNCUmYd6KKR7li7aXdQQjpgomhffGmOtaH
         YgssiLVkQUxPmBs+kdV8wVN5vHGiMwmYR7yfwNZJhjVtf6kd2NECMtpfQREvyOMHJNSg
         k9bQ==
X-Gm-Message-State: AOJu0YwNvBU8M73baHhXTmwvhsY/vE57Hdsew1hLW9mv2AZ3brp/XWH2
	/Uy+7jmwrIQDAykgkHvG0dYj2PB//CN21miMIg0AGUU5/gO8zh0VC2F9YKKnKg==
X-Gm-Gg: AeBDieu8U69+h49xKQhRkDlkQLbiXBlwqN7L0bJEM7qYLEYlXpGxoIFRnw8VUX9hcZG
	io+qPw1SiomJvzNjJs5X1oU4bAtJtkh3YC6WzMZG7aswLIO74bmixxB0Cz6N9g9e4bcRu36+AGr
	HWekx9tgdlYrBNlV1Pr7Yuq9dnXuHMStXN5S3XF4rZFV/5kUMh7jJuwD2HHkcBsoRIMG5qVvdy7
	l7Ej0MYD2ovuu7FAJFGrceVU7x0BGo/2KAMzj/0PmR/8AawRYpWpJEu2++y/flAmEBIk3TC5RwD
	xBQVrh3zdrGQXdlEww6+LKHna8Gb87Fv6Mi4qAJx7YqBbrjg4zHXQCo02ftb2QTNz3egB0HExRr
	Ve8lwTny+eZpn5zSoOB/4/4NVSCSSeq4uTiHdInH1AAWKVdYjVps12UnPWiRhDmrMtZhsXGufda
	7Bg1kbQ+JRWrIhW1gtapIq+vDgbKm3kwfYVu/+IIFhVURPExF4tk6dB+D6YHVBja8E+gpUxw==
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id 5b1f17b1804b1-4891d7a463emr178188465e9.3.1776871162346;
        Wed, 22 Apr 2026 08:19:22 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm413681215e9.8.2026.04.22.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:19:21 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] fetch/wget: in upstream version checks, match versioned directories exactly
Date: Wed, 22 Apr 2026 17:19:12 +0200
Message-ID: <20260422151912.2598831-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 15:19:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19377

From: Alexander Kanavin <alex@linutronix.de>

This change is in code that iterates over a html page, picking
out links to versioned subdirectories to check further for new versions.

Without the ^ and $ guards, there would be sub-string matches. This results in
querying the server multiple times for the same directory (for example,
perl check where the page contains multiple references to 5.0/something-unrelated)
or querying the server for directory that doesn't exist (nasm check, where
existence of 3.02rcX directories would result in querying the server for non-existing 3.02).

I have confirmed that the overall oe-core version check returns same results as before, with
less network churn and nasm version check working properly again.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index ca4959ab5..6ac4306c0 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -539,7 +539,7 @@ class Wget(FetchMethod):
         version_dir = ['', '', '']
         version = ['', '', '']
 
-        dirver_regex = re.compile(r"(?P<pfx>\D*)(?P<ver>(\d+[\.\-_])*(\d+))")
+        dirver_regex = re.compile(r"^(?P<pfx>\D*)(?P<ver>(\d+[\.\-_])*(\d+))$")
         s = dirver_regex.search(dirver)
         if s:
             version_dir[1] = s.group('ver')
-- 
2.47.3


