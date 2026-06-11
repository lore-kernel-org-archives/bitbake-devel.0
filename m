Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12E0CD98D5
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:11:55 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45065.1781183508761067731
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 06:11:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Y5mEhnHu;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eee266c6cso6527523f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781183507; x=1781788307; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CjKr0qX1d668HabZpFzG+MHiddz0rIE6LgKXx4FAjA=;
        b=Y5mEhnHukQ3wbJ/nOojsq0TRDylC0zeflMC5Cd50h2rNHeDV7cBe+5eMRBkaZ9UWfv
         sDCXYGM6F+9amkH9K4iA2f1xgrpjDAGA1++Qh8H0rkDLGFo53Pk0i16MbgzjhS0J68WV
         rA9A2tz+tRAjhdStWzPl11CouNT+A2Svhl9MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183507; x=1781788307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4CjKr0qX1d668HabZpFzG+MHiddz0rIE6LgKXx4FAjA=;
        b=dBlAAk241fY1ERQJg4t7HMRGHB+hKjEiZ04PWv8Qp3ZuaqBL4el4u4G1KeaCkOjRtA
         xa02AIQcYOjFq60MNwnIhNQanRK8neJ0jJgrIZjXaPcY52ao3+qOOQi+8mG+S5zw047Q
         63Dp9sehkQIeVXaH3MIRzwYPciN0/akUrZd3ypGqJbFCT8M/x0SguLcnCcM65he2jX8N
         xjVSqR0rcJCaETnxnlgA0wv7JPx8f3efV+xDvLy5FYYmd/DazSK12BBg2Zm2HCD/OxEE
         XZvb5fwFio2dKHpvpkZB8MPxZ5/qyHprhBFfJeGi4ng/6g7jdjZni9aBiok8gicJ1Rz6
         1j6w==
X-Gm-Message-State: AOJu0Yy0ffHEL5Lyc+9vsUNX5evhzwMBoM5JMgDmMmlYvmZcIxNal7UZ
	LkJRAu8ot7IDb+9fGOqd6eH41+ZwGPq+IPa5A59yj128IxJFP3nOpooq+KqPvilrZLtkhJC/sQc
	2zKLR
X-Gm-Gg: Acq92OFCPhH5U9PTSLCeTd7WUPREwGOc2e5RcRmYqJzfTEXjSkijsnU1e4xgJetxx/Q
	3HY8wiwNx2J41c92FbZIv6hasEIzdc39XmO++CFRhoxB3qwaNzDk+9wd/Bl2/+zumgpQicgI0aw
	XfPR32Ua/SHN5/FraVy6Qx58veCgyXf086JKwdO8SjyiZotw1OnQgWvh7NfG4v80w0A6c2q5rK6
	SnBwGK5oz0Av0O9uRfOB8Nd/wyA8Ott+LA4V6agPoFqmpS3pUz0bl7UHE95UgsYIAS4gx6p5I7p
	YvhTozNhYPEhqQhY7znoqLTdkNQUnG6swSDsYHZ4+Uy5E4RzL+dFGC+PSrIhcznag69Wl46Eny1
	kKdAcYNUJlaqBzrqLRrWM+OYYbeVTjSb/UWqT+9MzbSjBHGyaPLJ2lAinUAw0x0wly2xuSF0Vpg
	YoH4PfzjuUqnLA1HdiZgG6j/rFeGw8CdNM3fb87n+lEacuIlAds1NY1qu450fbkrICFilvcaUmY
	Oqat4XMaqWBM6s273G4uXDLyVAPVDj8P9YfOJ8=
X-Received: by 2002:a05:6000:438a:b0:45e:f2e1:9a20 with SMTP id ffacd0b85a97d-460677ce9c4mr4129569f8f.27.1781183506952;
        Thu, 11 Jun 2026 06:11:46 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0084744357c26c6744.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:8474:4357:c26c:6744])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm82048251f8f.28.2026.06.11.06.11.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:11:46 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH v2 1/8] fetch2: reraise IOError during download
Date: Thu, 11 Jun 2026 15:11:23 +0200
Message-ID: <69e22a5f95d650ed83e6064d4e99b8dc067a6659.1781183212.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781183212.git.yoann.congal@smile.fr>
References: <cover.1781183212.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 13:11:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19661

From: Anthony Squires <me@anthonysquires.ca>

Fixes [YOCTO #16268]

Adds a missing "raise" statement to download that ensures when there
is an IOError/OSError that is is correctly reported and not silently
discarded.

When an IOError is thrown in this case do_fetch silently passes which
then leads to downstream failures in do_unpack when the file doesn't
exist.

Signed-off-by: Anthony Squires <me@anthonysquires.ca>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0460038e4705934e614b26ba5febc09293924cd4)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0e4f491ce..d913d7511 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1969,6 +1969,7 @@ class Fetch(object):
                 if e.errno in [errno.ESTALE]:
                     logger.error("Stale Error Observed %s." % u)
                     raise ChecksumError("Stale Error Detected")
+                raise
 
             except BBFetchException as e:
                 if isinstance(e, NoChecksumError):

