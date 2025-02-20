Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34A4C021B3
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 14:30:32 +0000 (UTC)
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
 by mx.groups.io with SMTP id smtpd.web11.50645.1740061831774210459
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 06:30:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Lt8XewU+;
 spf=pass (domain: gmail.com, ip: 209.85.219.65, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-6df83fd01cbso4589336d6.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 06:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740061831; x=1740666631; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Je6UvbSIl3Urotkxuvue6xq6VQK9hqI5afmsV81+Sc=;
        b=Lt8XewU+XOddXtYNEKzj2f5t7ScGxHnMdKEgFq61GHkb23UmGDuMT49/m7aQHQlV5n
         8m3XMG5bSGqXzDsDjIJunE365OqbRYio9zunFqZ59Q8Q906SZlOzSNQLCJNfJkFPSpU/
         IlyVSs32ngEG42P1hefh5E6ZHXJp6urBGXAx+AC0Hq/Xh+YdU6r22LpleIkQWxqfy/Dj
         nVy9Ql3g/JflZekLCE09FdYKIlx3WjrsTiaay3FL9nl9dUSs3w+a/tlIxlruIQKp4HEY
         N5Nz2Og6kN3QmJWGGDdqHlfvbtJgzbwlbgpwPi50+cxZBBiTHqFka/ocEnZJm9+Upr2o
         xhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740061831; x=1740666631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Je6UvbSIl3Urotkxuvue6xq6VQK9hqI5afmsV81+Sc=;
        b=B9chM9aMGNU9LcS61RaG0zBJpy4mhOXTTrMhMEV28LOhL4Vat6/g+KJv5lAlCmIsgw
         Px03Hy/G2tyCO5lG1chTuxL4lcBsTPa7+mmu8XbHNQPJaXPg3fFRoOBt8/iZkx5HGRwQ
         w13zAU0JTkh5I+Ud4raDrKTeykpq2MUf8nslJ2ln5y95BPEjD/xiN3//2oDFFGiRV5s5
         LQ3opwlibZaqrJj22d6TtbO5gmbQZ3lY2NG6wexAaaG9pWzuPTveTfe4JJ7GJSU3grUb
         UUQtFjE6icKrgdLKlD34/Kv6XF8ZNvOUEFwDqJqXHj3yNEh1bZnkzPnR7MOKmsxlJH8Y
         /4vQ==
X-Gm-Message-State: AOJu0YwpBebK73R4t11p6UpCCrJRN4psEz4fKd/IE7z7mQIVZB4r9Vm7
	S1Ba/L4RkaZBemorDyAh7eLbXkHl6seHaIWcPIKSeFdasEPNBbqPyawFLIjx
X-Gm-Gg: ASbGncu+GDhVXwsKCVEy2+M2Effn71KJfdSNKaIpDAldbU75Y/yUazAjYVkCXDrF5p+
	sGyFeZT1vcbHFqTgrNn5HS1OV7apbtcYXeiYB289Ee5Ug5P0kuyomMhcqdpa/J+6xO8qK/sBe/3
	47r1nh+JuAKK8JYysv7VTTvFFF+vCI8SuMHJHi+i95FWveTwNUB1zTZPaJ+9oJ277wNjrYaZH4o
	LJlXS/0LSNKNVWbSLfymWXc4pkor6Pc0b6WUlmFlzQNRabKF5RZwz4FDG4M4z2eKt+LV31pDlsf
	ePBOtpPEfGOQdXUGmdWP1Lw/aSiPT+iuurrCSmRL0Oh96FUuhgMlcxCrmYUJDYHD6USgrY+Hkku
	1KPpmJT2jG5JR
X-Google-Smtp-Source: AGHT+IFNklgFfWf4SY7mAjnMzO0An3IrYs/vyozBlOvJzIb0kWO7e1fZjlOwLP6FjAe3xKUBfKIN4g==
X-Received: by 2002:a05:6214:2029:b0:6e6:5bb2:c1a8 with SMTP id 6a1803df08f44-6e6975ae884mr114478826d6.34.1740061830570;
        Thu, 20 Feb 2025 06:30:30 -0800 (PST)
Received: from 5748df6bdb91.yourbase.domain.local (c-73-168-239-54.hsd1.il.comcast.net. [73.168.239.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785a4asm87110116d6.29.2025.02.20.06.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:30:30 -0800 (PST)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>,
	Geoff Parker <geoffrey.parker@arthrex.com>,
	Alex Kanavin <alex.kanavin@gmail.com>,
	Chuck Wolber <chuckwolber@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Subject: [PATCH v2 1/1] fetch2/npm: Adding npmrc support for private registry authentication
Date: Thu, 20 Feb 2025 14:30:30 +0000
Message-Id: <20250220143030.12982-2-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220143030.12982-1-eric.meyers@arthrex.com>
References: <20250220143030.12982-1-eric.meyers@arthrex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 14:30:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17256

Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
Cc: Geoff Parker <geoffrey.parker@arthrex.com>
Cc: Alex Kanavin <alex.kanavin@gmail.com>
Cc: Chuck Wolber <chuckwolber@gmail.com>
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
---
 lib/bb/fetch2/npm.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index c09f05044..23fb5029d 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -107,6 +107,21 @@ class NpmEnvironment(object):
         """Run npm command in a controlled environment"""
         with tempfile.TemporaryDirectory() as tmpdir:
             d = bb.data.createCopy(self.d)
+
+            # If an .npmrc file exists in the HOME directory, then use it in the NPM environment
+            # (along with the user provided configs). Otherwise, leave it blank.
+            home_npmrc_file = os.path.join(os.environ.get("HOME"), ".npmrc")
+            tmp_npmrc_file = os.path.join(tmpdir, ".npmrc")
+            if os.path.exists(home_npmrc_file):
+                bb.utils.copyfile(home_npmrc_file, tmp_npmrc_file)
+                # Still need to append the contents of the user config created in __init__
+                with open(tmp_npmrc_file, 'a') as t:
+                    with open(self.user_config.name, 'r') as u:
+                        t.write(u.read())
+                        t.flush()
+
+                self.user_config.name = tmp_npmrc_file
+
             d.setVar("PATH", d.getVar("PATH"))  # PATH might contain $HOME - evaluate it before patching
             d.setVar("HOME", tmpdir)
 

