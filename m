Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB35C001DE
	for <webhook@archiver.kernel.org>; Tue, 15 Aug 2023 16:12:53 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web10.138351.1692115965900249310
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Aug 2023 09:12:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=Jbqw37li;
 spf=pass (domain: gmail.com, ip: 209.85.167.176, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3a7d7de894bso3958699b6e.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Aug 2023 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692115964; x=1692720764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2BtNQBoArC5okRyNv8qTe41WZFW/du3mZX3GUnagVdk=;
        b=Jbqw37liKWDiJzJyawJxevODUeeFNrW53e+HBhIBCufegaYrWiZ1y7Zdbr1WXd4Ug5
         hZjSH/BagPU5Mr3L5Rsrkz30/ayLw/4PlCgGBVd1QhhJeexXgocy6HeBusjNPlk6RArU
         ejbf9rYXI93jlpR/MKtzpZFzHhY5YYahMO7Sg/O7bI3Ps+5lvlNmxSLSMi8YWIwAZAMl
         EoLULNxJ21uTYfrcUESayMqPL++3gvUoBl08goS4/t8zQnSqkoCeEzoCgXawfBx3kbIr
         NTtb44Uq35qQsmImOtlq9gHp/Gkh6i0wQlPi2SioBT8SkYTB50Li8x0fn1lRk5Xr7toJ
         sjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692115964; x=1692720764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BtNQBoArC5okRyNv8qTe41WZFW/du3mZX3GUnagVdk=;
        b=knpP3dTZkJuIoK1kry/QxDTQulGrsos74HHFQOwSM697nGxQov/FrhwSx1c1JwzExu
         KbQPShgq/YtJNT1PmP+p64tgmZyNKRrg/fibrfueshmF+Ykfamg40wGgBKH0jtj45X5o
         5Gy1hswzUSvYLtI+JQ9I/+UyQlYFde4lMo/xHdIFl5b42zNq/wjRfEE0XJSwWlZuU5kD
         /lKc/niM7etmeQnnsOdRjykEXCDPonIcrHTTPJ2/XoUoXM4GHe74MC+vYCVx4ftLvcYa
         EYq3337wPD2xGncBMxyTv17NtMjl0mUacQvJEK7lO80TFQUvD2skWnWVC6+/ghOi+PsB
         bm1A==
X-Gm-Message-State: AOJu0YxW3eTnvfUblA03CskoXbhKfJtD1uqMwcL5C+cQPZyCERj2KuoK
	dTTsM6WrF7+nOJf9u+uGSP9vXmHmsS4=
X-Google-Smtp-Source: AGHT+IE29e4XC+t9/KQf+RzzkhbXmASe3ZMj4wke7EcSzZqZ0MT9tncfJQld60U7RDT68d2zrzADAw==
X-Received: by 2002:a05:6808:1416:b0:3a4:3072:e597 with SMTP id w22-20020a056808141600b003a43072e597mr14948825oiv.54.1692115964663;
        Tue, 15 Aug 2023 09:12:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6897])
        by smtp.gmail.com with ESMTPSA id 12-20020aca210c000000b003a7543bb635sm5501062oiz.22.2023.08.15.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:12:44 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] cooker: Fix error message
Date: Tue, 15 Aug 2023 10:12:39 -0600
Message-Id: <20230815161239.1514637-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Aug 2023 16:12:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14944

"Not" should be "No"

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 11c9fa2c40d..064e3cae6e8 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -650,7 +650,7 @@ class BBCooker:
                 raise
         else:
             if not mc in self.databuilder.mcdata:
-                bb.fatal('Not multiconfig named "%s" found' % mc)
+                bb.fatal('No multiconfig named "%s" found' % mc)
             envdata = self.databuilder.mcdata[mc]
             data.expandKeys(envdata)
             parse.ast.runAnonFuncs(envdata)
-- 
2.33.0


