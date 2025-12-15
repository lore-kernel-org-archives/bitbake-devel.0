Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43BDD5B17A
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 14:54:55 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50489.1765810489502351682
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 06:54:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HfTWXTha;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6498a6f8ab4so5755194a12.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765810488; x=1766415288; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0ntilutKEIMSs+OfbjGMcw9pfagdGvCeXseaiJqBzc=;
        b=HfTWXThaDPu66jD99w4LX5OIfWDxMGwFx/mtrHUmHr/Nj9CZc2ajQ6Uv0Rranoswmk
         1jZwkBgKQ2K3ofLzrZmwsZ8V5h6Sh6blNzrO7bf/FYZyPMP0NZJlKuqZZhVOw5pI22ko
         IAJVSXEV1YBpTC2WnzoQGUVHcHuo/+EiAPlyKxR/q3j9zCxkQjWjsC8Li3ojN612DvWS
         zRSoHbwYhR81hE8pbJvJqwCwGpVmoabj1xyDCAYXlW7Lp786MlaHoYOwgALWMHlaJxWX
         Q5+li3zHetPEK6OdkXIUqNiQ02dvDeWVnizEAGco48nRlxuqwpl1ncGXehnevBRq60Qc
         41Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765810488; x=1766415288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T0ntilutKEIMSs+OfbjGMcw9pfagdGvCeXseaiJqBzc=;
        b=wYOgaHmxv/LCdjq3y7sUocq8cv4Qxz/iu1U8J1O/vaoy8jfiLIFFyhpUO236ncC997
         JDoOQmHJ4vjyt+1A28Gh/ZW9Bn1aYCGPMlDIdaXQymtXxOwwa3zYoN+hXP+qYU12n7q/
         m8yv+qLJO3fgPhLGO+47Ti23SBGMjSxP8DNjkoL0CdedmqYvZmaFHCckWtc14ON8ujx9
         f31+7umeEBm3MAIqPndE0NmWWtVtElnCF42lrr6cmOfdeT5ucXwtp7I9tW8qdYRjis0/
         Chtm4jsOh5HS3QkvjHnLg5SbZ+cuaRcGH1/5iPYjN/YYemRkCQ3dx955yaVb+8FTAzVA
         xZDQ==
X-Gm-Message-State: AOJu0Yz6dZCVaKCzsT7gKtHelGaxf/ZpV3VkDccv+Fp4fDPQurb4JWix
	7h8bDetOc/KuMFXkUgV65mBOYqYLbddlVgGfzH7xQ+hnQphH3DY2cHBwsi+YRg==
X-Gm-Gg: AY/fxX73ojwqLKMH1G6YvN95B/wL1od9WDLmrfLnW6dDPyJRMIEGpFfFOMj1NLY4qjr
	gsAs2pZf7SsyxERZEl3vp6CDouwNQlQ5KOSUHeOsLAtr/WB/7k6+Cxd7MjkS7ivMotMESlNTA5m
	X/P9KTvbkBfAYOmzinI5k1OyH5svEQ7xuH5/4eYu2wgm89G2FBMrZxcMz3p+lOkB85XmBokEI0l
	XWh2mS/I3nIYnxFzWijk47owFRlSYI5fZytbqX7f3pKOW7CNgtRhpJcLYAruzTd9AMmu6un8zqX
	gL6JAvYABrvRC4jRqLrrfV49tqHHaCfWCWzoZW1bFpfs3IeNO44p5gfia1FhKzc0Ib2jKQ3Pfe1
	0e8gIEWsI/HsuCdeB5o4Sj2E+55C45jND2LkzAnkT0+SBo7VyhqBdqO6kgfF+3duGMuMKQY6LhQ
	6bbiPS1dnb31xSMvBkV0UnNdrSFeu89xW/ItbTHos1ETkm08k=
X-Google-Smtp-Source: AGHT+IF24CjV6nYHmY7v7oMksqpz29BM7kxVPrtLCpVu5OjRuxe7iaZ8P+0OnORu21OimQD7Bp8Hjw==
X-Received: by 2002:a17:906:f5a9:b0:b79:f734:4d66 with SMTP id a640c23a62f3a-b7d23629123mr1230517766b.18.1765810487455;
        Mon, 15 Dec 2025 06:54:47 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498204fbb3sm13589812a12.8.2025.12.15.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:54:47 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [RFC PATCH 2/2] bitbake-setup: share sstate by default between builds
Date: Mon, 15 Dec 2025 15:54:18 +0100
Message-ID: <20251215145418.2680311-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215145418.2680311-1-alex.kanavin@gmail.com>
References: <20251215145418.2680311-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 14:54:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18597

From: Alexander Kanavin <alex@linutronix.de>

Nowadays sharing sstate must also include sharing the hash equivalency
information and thus, managing a hash equivalency server. There are
two ways to do it:

- starting/stopping the server outside the bitbake invocations, and
guaranteeing that it's available when bitbake is invoked.

- using bitbake's built-in start/stop code which launches a server
before a build starts and stops it when a build is finished; essentially
this is a private server, using a database private to a build directory
(by default).

I couldn't come up with a good way to do the first option in bitbake-setup:
it needs to be invisible to users, they should not have to run special commands
and they should not wonder why there is a mysterious background process.
It's not impossible to auto-start a shared server, but that will quickly
run into synchronization issues: if one server is being started, another
should not be started at the same time. If one server is shutting down
(e.g. after an inactivity timeout), another starting server should wait
until it frees the socket, and block all bitbake invocations on that.
Memory resident bitbake does this in lib/bb/server/process.py with a lot of
complexity, and I don't think it should be added to the hash server as well.

On the other hand, hash equivalency database is sqlite-driven, and sqlite
documentation reassures that sharing it between different simultaneous
processes is okay: nothing will get lost or corrupted: https://sqlite.org/faq.html#q5

I've confirmed this by running simultaneous builds that way: nothing
unusual happened, and sstate was shared as it's supposed to.

There's a new setting that turns off this behavior for situations
where the server and sstate are managed externally.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 6f7dba16c..f382f6eb0 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -777,6 +777,12 @@ def create_siteconf(top_dir, non_interactive, settings):
 
         os.makedirs(top_dir, exist_ok=True)
         with open(siteconfpath, 'w') as siteconffile:
+            sstate_settings = textwrap.dedent(
+                """
+                SSTATE_DIR = "{sstate_dir}"
+                BB_HASHSERVE_DB_DIR = "{sstate_dir}"
+                """.format(sstate_dir=os.path.join(top_dir, ".sstate-cache"))
+            )
             siteconffile.write(
                 textwrap.dedent(
                     """\
@@ -794,7 +800,7 @@ def create_siteconf(top_dir, non_interactive, settings):
                     """.format(
                         dl_dir=settings["default"]["dl-dir"],
                     )
-                )
+                ) + (sstate_settings if settings["default"]["common-sstate"] == 'yes' else "")
             )
 
 
@@ -1001,6 +1007,7 @@ def main():
                          'top-dir-name':'bitbake-builds',
                          'registry':default_registry,
                          'use-full-setup-dir-name':'no',
+                         'common-sstate':'yes',
                          }
 
         global_settings = load_settings(global_settings_path(args))
-- 
2.47.3


