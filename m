Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2127CC79F99
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 17:32:27 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1016.1788802336595973308
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2026 10:32:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AjYndUuB;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495590dde14so54487605e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788802334; x=1789407134; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oBDILWNyFu3XX/Bfu0F7n0CSdc1jqtm0HHRlicbPxiY=;
        b=AjYndUuBGz9KfLUDYopKIA20uJ0TvGI/5QHuyiqIMK27cl4ztQpnTMkzOUfmr0O9/R
         UZq5cfzSocCrz7FTkzDYLQTTKtFMuG8Ej4EbkFZ7bADiGg5OrHGeDKPU856/+rnZjNbo
         OIoLVJwkgF192Fh6amUr+yy8MHmNfNxU5Khmd9Ijpzo1WEnwO5rGZ5T0Jhe9OF8lIZOQ
         gq0Xo8IfMrcMa/kQmx4m6dCBZYtkloAoeCG9UrpiDEuTNoZFMTE3Z7BSqlPZ2jYttcjQ
         HozNOodYWw1yBfP3pqG4afMa+0Jofqgysu/NuVmj9OtEGJ2dFApSnc2V68jGzmK1n5Xg
         Z0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788802334; x=1789407134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBDILWNyFu3XX/Bfu0F7n0CSdc1jqtm0HHRlicbPxiY=;
        b=UE7k9j3l/YMw6jtRHiIIIntYD+N+xhHvQPhu6J2EDWBTotPR5CHw/J2seQ2LeYpG0a
         hag8SMulQssDu7cUUH1ZFRRs0lqEHGOMuGBy/5tg1ptFVnqY0mSpr0IeOXEobfjzcFbg
         IRjN5id9K5R0/Fsymnl1FNQ8zPcub8eG6yfKu/IHNnA08er4U/nQQR8zhbxKoYRzWte7
         jtjtnJeU16OrQUgD1Z3eXaLrIca88oVXJ0m0U0eVkFm8Fv3n3zTg7oPxvTOUh+7Dsl19
         bi1MZ2u2kG3ZXw1UHKEy7olMPl+AssKFkeGVFEYKJvgVCA9iBf4lzhAinAoXabhwyxk9
         XHtA==
X-Gm-Message-State: AFuF++mWRO2/EbEONiZEs0cOqiKkXt4f3o2V10SY1mBPlJFtw5maj+r7
	wdrgLbwfZtmRFpw6dLZdlcmFvOf2B882V01Qy/c4n75D4k8c5+oOXV2EQ82Gfg==
X-Gm-Gg: AYBFou3YvwHchuXNfXg1/D8rfGha/J79/2wSrAlnjq5ScsJMVH8QQ50fgjhG/9z8CZr
	nbowYkyUBCU0Fv8nrfW6Ky9b2cA3ddxjSKvBrdJE/HlKE7r6iQXJCXB3pC70e4hRXmYQiexACC1
	i9thiCK+JqOUVrksJFMWwNpQ89/VrdhIDSv1AlZBdh2sOTiwyiGzv+iUKunIT8gYw/eOT844t2L
	dmW4SDoT4pcpKSxnVdJkU3143OBltnOO8IZOGELOTVlKBQCAz/1E7Ajux0d1ocUSeKHQlGNGAZ/
	i5h4x5jAcLNPwziSl/j+f/aAS6SxbxFNoog0ObP8FajBb1lIXcnS8KQwNt5OEDAkjM2ai2tQyE/
	DkNhcaywBg44YVrI9URmeKW/IbC76lk27n6rVg75yXxzNQ8VnnrfrnExPZ8zChv32ojbgWVM3VP
	HR6R3AdCZhxfdhKsWn+PiK6iyDkgSdsTYApKjWLaCEPegHhoRIuzlZ+EcWWLZctY2D8AFHSWF4G
	K+KGNhyh48EV35EcDzd50otuzRAKM+ar4E=
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr301287575e9.5.1788802334162;
        Mon, 07 Sep 2026 10:32:14 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0656e7bbsm223493305e9.10.2026.09.07.10.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 10:32:12 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bin/bitbake-setup: print a note about fetcher log if something fails there
Date: Mon,  7 Sep 2026 19:32:07 +0200
Message-ID: <20260907173208.3672064-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 17:32:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20168

From: Alexander Kanavin <alex@linutronix.de>

Fetcher errors can sometimes be not particularly helpful, e.g.

ERROR: Fetcher failure for URL: '<url>'. Unable to fetch URL from any source.

In such situations, fetcher log can contain the actual information about what
went wrong, but bitbake-setup would not say where it is (unlike bitbake proper
which does).

So if a log exists, and isn't empty, print a note to try to help users:

ERROR: Check /home/alex/bitbake-builds/poky-master-poky-distro_poky-machine_qemux86-64/layers/logs/fetch_log.20260907192613 for additional information to diagnoze the issue.
ERROR: Fetcher failure for URL: '<url>'. Unable to fetch URL from any source.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 427a2d835..d18d32ba0 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -985,6 +985,10 @@ def do_fetch(fetcher, dir):
         try:
             fetcher.download()
             fetcher.unpack_update(dir)
+        except:
+            if os.path.exists(fetchlog) and os.path.getsize(fetchlog) > 0:
+                logger.error("Check {} for additional information that may help diagnoze the issue.".format(fetchlog))
+            raise
         finally:
             sys.stdout = oldstdout
 
-- 
2.47.3


