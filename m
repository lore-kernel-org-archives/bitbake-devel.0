Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F7BC3F2D4
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 13:49:13 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.17873.1655387348455523470
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jun 2022 06:49:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=HbeRASou;
 spf=pass (domain: gmail.com, ip: 209.85.221.45,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id w17so1958565wrg.7
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jun 2022 06:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Z/+9Q9P8Pd+cpUlHbyLDcQ987zCspEEfE31i9WyVkY=;
        b=HbeRASouj1Hcqg8DcpTtH/RsMiv/U643bL5L1vEGleLLclUuDvrE27IHdnudtAPaCF
         ETxA5/1VG/XESQ/FMhfkjRfRJQdl9F+Srgx8EGZecsud1rx5JHNIiuWsYuIP6JyOsvuK
         fSRAFTmGn1Q6CpysyUxNkdUZuzBtfs2O5l3NuRyyGO1dZ+Zk9OPpbyuPZFONK9sITM4S
         Nr2W8IdV0JV/ZBJYZ8xlE2/AwovtlksDGRhKxk8f9iUh2BCoTrXNWxEdAoj+fuifslRQ
         pfJtPrzBJHgRBBiTaeqQmk4pv8uBsgMB8kCnKh6/txUQFRyOmNo23TPCmKNXR8xfxMzr
         /iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Z/+9Q9P8Pd+cpUlHbyLDcQ987zCspEEfE31i9WyVkY=;
        b=Z0ktOZxj5wc1YF789lv/qPqe9w36u8/B+ZUs7DYP1TI7d71VnRh9u1QA/Ym6WHkivx
         Pdc3++1PQE6VGuz/dMuMPVWvyCLABMrluuLFuF5l2RUOtPC9Vot8WPVsrmX1JcEmpffO
         90oxpxtAqtMt6T+mGfbhjqlaiuheFx9BGWZSVPqlU/OwnzftZPs0exS6/QYAee5Yvs8a
         8pRLOG4qbVNaIo/a5FU1E7033JGsfrz9lDNoR426s0p1vuPX1uKz1ckZUsmi2cmOX1lV
         ia3JWqw1+zuOERMU+Cx6I93XbuOng3q+W/kvk22XAncD+hQGd48itp4BX9CoqkY5N4ww
         95zQ==
X-Gm-Message-State: AJIora8ZnqcNaInFwou1EAhSeoj102XqZy4gjX9iIrUWPG37tNxb7Pz3
	/z04niVQjEl9RCLSUTf9umf2fLQIn64=
X-Google-Smtp-Source: 
 AGRyM1uBvDPhwdrQzLnDunf+2ypHYhobsXaMdyfYgRHPDqra7/mFczbEtmbn7EgCqVD4izPw+NQunw==
X-Received: by 2002:adf:d1e7:0:b0:215:2126:dede with SMTP id
 g7-20020adfd1e7000000b002152126dedemr4774892wrd.297.1655387347074;
        Thu, 16 Jun 2022 06:49:07 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id
 m188-20020a1c26c5000000b0039c4945c753sm5988313wmm.39.2022.06.16.06.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:49:06 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Ross Burton <ross@burtonini.com>,
	Ross Burton <ross.burton@arm.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Anuj Mittal <anuj.mittal@intel.com>
Subject: [1.46][PATCH 3/4] knotty: display active tasks when printing
 keepAlive() message
Date: Thu, 16 Jun 2022 15:48:49 +0200
Message-Id: <20220616134850.3471187-3-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616134850.3471187-1-Martin.Jansa@gmail.com>
References: <20220616134850.3471187-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Jun 2022 13:49:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13770

From: Ross Burton <ross@burtonini.com>

In interactive bitbake sessions it is obvious what tasks are running
when one of them hangs or otherwise takes a long time. However, in
non-interactive sessions (such as automated builds) bitbake just prints
a message saying that it is "still alive" with no clues as to what tasks
are active still.

By simply listing the active tasks when printing the keep alive message,
we don't need to parse the bitbake log to identify which of the tasks
is still active and has presumably hung.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 30f6c3f175617beea8e8bb75dcf255611e3fc2fd)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index e70c2464..71c5a3e9 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -227,7 +227,9 @@ class TerminalFilter(object):
 
     def keepAlive(self, t):
         if not self.cuu:
-            print("Bitbake still alive (%ds)" % t)
+            print("Bitbake still alive (no events for %ds). Active tasks:" % t)
+            for t in self.helper.running_tasks:
+                print(t)
             sys.stdout.flush()
 
     def updateFooter(self):
-- 
2.35.1


