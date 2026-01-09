Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE6AD1A623
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 13:20:18 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9818.1767964810076635355
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jan 2026 05:20:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=W5VIbZEs;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so25251175e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 05:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767964808; x=1768569608; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFu5lhkrxPgZPOqnSmBLnqC98ebar0RJTdyfmfIIZc0=;
        b=W5VIbZEsOUABpaipXsdrc5k42Nn2mfEWFGDeevsnol/BtQ9l0cM7B0LYLBNaBCbA7c
         xB3EluTiyVmsN6GbyAWdjx9aIkmx+sYec2EY0epCvIVP/CE0/S2Ap12LsRTddSaoZphX
         6JDwOKRgfdf1YrSxn1XZJ2IbjLnzgUK/sDad42CvFDGt90UYMNw65cFUzP5h5Ku+lJ8T
         LGqdwkQbDq/ZBAabn49w9lLoUWGLzNuhFZJd2RkcP2RVxUenzvwONsjbtYdvFAgxA/1h
         UPt/JIA0KKXWLGibAiUfi3b+q/jEkfWQvwLKamX2L6jCpKCUqwzrB+DVJBF+Y4fxqHH9
         vsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964808; x=1768569608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xFu5lhkrxPgZPOqnSmBLnqC98ebar0RJTdyfmfIIZc0=;
        b=lrT9XerNpnuquuVGN2Xv8/YvZB2wjIyHirtu8TCQ62n9z/B27bM/5/EcxJAqJPiORd
         pUFubGD6cET4FYL1sdPrah5x1GNcog+iSk5qRYnMKrEfpol8JdJd5Z8uTP9T+Kjy+UT1
         pj83DDQo9vdbn8ZHclRCVy/W/RcQO2RtlessH/E+kmI7Qvy2+ZTCUWrW1KT2nktfeKd5
         m1hfgjhS2EI4CrSeFPwt1gNvKAaabxAac65IR21E7UCIFqUKwasvmkv/9laF9UDsDnvK
         cV4bXtqZRM4MSI2jjgPCugr0kPR4yXwC+B6aPDXirzzD77Ew8ji+tqHTMj9ZdYH7vOJw
         jDng==
X-Gm-Message-State: AOJu0YxQX2ke0qV2el9FqR0VcQ/7X5jhUYIpG3EjagVjiGCT3IbvPBaw
	ttXVXUme3n9qEXDeo4qm5BrRlpqa9rKTRqBJUlJMnpmEo0x9vStrt7qDsDBk4w==
X-Gm-Gg: AY/fxX7/5Zrjo56m64HbSddmrzzpVyjx9S/0E/yvrT7zrOO9fCC6FCBYs1ZHRByARar
	5qN7RdY3cKyjjtVgaKWzxTLEzSm/EuEm3WEvGVcM5cvRRa3sQHfTVIvX8JhOUoZiRrN0csVCuuv
	3Ax+cwCMkVB+3dNvgfMvm3v6RGPJRacsUdoIOeQ0R4J9UnBN8O7ib7dG1G34lxXrRPh138svq7S
	jdsGUiwM7iNH4pVokTsGC8iCKUuIEHFcGTvuhB2ZZvgsoCKXcZj37fG4/QDCYSWJCULWre588Zt
	wvrXPO1rxFaMiSC/82E7wY2TJfqFEmnZRaiaGUNLWECjYoENSrY76gHepHRfDWSi0nwjanU1Ec2
	x4PbiYr6DYyAOg0ztmDRyq1dRDfRLrFiX78T23GqGN0vgnr6Z1qw1kA/pnu6DHnsDvPo3kU7akv
	t07EWw6WQMwydDI4NYedXWqHrGzAC1BS4NSGRHZ3dfTwyls0E=
X-Google-Smtp-Source: AGHT+IHPxN3wr8Oh/Zej0Qm7QbmTUsP9K41ekL6S3Mh05UTYoXPqzQ5hGzdkb0G/LTi2nF15p4h9Sw==
X-Received: by 2002:a05:600c:3b15:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-47d84b36bcbmr99672455e9.18.1767964808289;
        Fri, 09 Jan 2026 05:20:08 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6953fasm202291505e9.5.2026.01.09.05.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:20:07 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/5] bitbake-setup: allow empty commits in configuration history repo
Date: Fri,  9 Jan 2026 14:19:58 +0100
Message-ID: <20260109132000.2372791-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109132000.2372791-1-alex.kanavin@gmail.com>
References: <20260109132000.2372791-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 13:20:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18725

From: Alexander Kanavin <alex@linutronix.de>

This can happen when a user has checked out a different commit
in a component under layers/. 'bitbake-setup update' will reset
to the commit in the configuration, but there will be no changes
to it, and so no difference in the config history repo to be
committed.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 4ccf47e87..93c11bd09 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -81,7 +81,7 @@ def write_sources_fixed_revisions(config_dir, layer_dir, config_data):
 
 def commit_config(config_dir):
     bb.process.run("git -C {} add .".format(config_dir))
-    bb.process.run("git -C {} commit --no-verify -a -m 'Configuration at {}'".format(config_dir, time.asctime()))
+    bb.process.run("git -C {} commit --allow-empty --no-verify -a -m 'Configuration at {}'".format(config_dir, time.asctime()))
 
 def _write_layer_list(dest, repodirs):
     layers = []
-- 
2.47.3


