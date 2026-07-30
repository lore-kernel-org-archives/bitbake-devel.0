Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03381C55177
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:07 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18455.1785436380078265277
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 11:33:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=IouSGcwu;
 spf=pass (domain: gmail.com, ip: 209.85.167.170, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a4c6081f9fso63628b6e.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785436379; x=1786041179; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EKnVVvQLGYQVBqqlwMzNNMoh+34r7ffbwuqLdEkaRWk=;
        b=IouSGcwuhLqgFvpexVInoxdn44L8oVC8OVE92NSic7Jc4TI4i/LoSl6hiHENlaCiZu
         xo+6uXcU4Jai98Kkl6+y1OMttc8Ez0b+46VvW3wK2eU+e9jr1hGK3bez0t2h7Qiy+xqB
         dcC6y/V3IQk5pDabgHouEU+JFm8C8u68L0dj5WZ7tTcLAyFbpz+iniieM34EMCZI4Orr
         NZ5it7BDUqZ47nIBkzy933+JEgVvTPIQ6T5VJIOPXfInBDZeTJdoxIDlwu+JwoaRQE0H
         0sekj5jDwvtHQKPRqoAc7AYeOMmF/mgvjKfxaoCVAEjEC+f3cGiwajwo/PWlAiIJGZ7d
         Dklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436379; x=1786041179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EKnVVvQLGYQVBqqlwMzNNMoh+34r7ffbwuqLdEkaRWk=;
        b=ZfIl6p40+8HDpipu80bS9TcdNKQXY91p+CpTRJQaYginqw9JvWzOB8hNQ+gzYm4Yhu
         1s0hezqZyAZJ0DLYHD7xVzAtZZjBGdPKLXNteVpufceYHQhvw8f7B026/gQz3ySPwjg1
         uxaZp51Oi2PDm8/HPwWVakJF/1/HZr+i5ZHLFFNnWoAks6tM6Av2e51Ov/2vhRALygjp
         45trVl/lZ6lmsE662GlKTW4U0Ua8+WtpdBFgI11TOD0RXbxjeGqawc+ULKwwbGWD+3ds
         5fHT/c/XJQ1MTpMT7ngJT3EWXMvUUfmQz66qO0mAuri1paekvCW9awgiMfAn8Yc1rQhT
         R6HQ==
X-Gm-Message-State: AOJu0Yw7uzXBVgOiWDqL8qrxdJZkXQkgRCaSXiVqsIpeSML4eGr/KE5C
	NpgALVKuxbOH5eZHHp48C0Gry4AET/nkt4CmsMSPO5Ie7MiVaKsG3MTmgDzWOw==
X-Gm-Gg: AR+sD1261zt9+0fmONZufmbPyrG3Y3/GeCTHctNwnqn/fIdVGRk9/E5pPPovsrtyYhV
	84jdJ+uyIYqlt+MSc6U6R9AfwFQ5SNqF/y0gpKrhnOK6V1CoEN1nrVKN9h6ySB2l/ZfP0NZdFJi
	OSoYuUs1HfwRgLbLrtdvi2cT37i1lH1AU+6/wY5z5wZt1gAq69sCvsRNfGcmtOEEVwZvFlMohnR
	rcXeop6y7VR/iDRcBk01VGvw6w9h1weJVVakgvI1Y1jTlI3VifNlJZRofCIasUTRK7XH3nW7Me1
	Q9GKKg4g7uyIB58wvpkia6N1P633FBi3OVs6lOybACsUYWtrh1TSaaNVLzEVhxwEWPsH/T9/2ld
	wkMcGrA0HxySA5bYqw/OWpbbPb9Z1l3QmR+IV/nzepBlLcwS40gI+1M5Q7gFkOAWPriylrXky6k
	5bESJdm0XHxeYLozAgyStlXKHw7vNKUiaqey18qjzHCSM7VeCJkk6hUwlQKg==
X-Received: by 2002:a05:6808:f13:b0:490:9f92:d00b with SMTP id 5614622812f47-4ad879701ddmr2746549b6e.29.1785436379213;
        Thu, 30 Jul 2026 11:32:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::10c9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc5c3fsm4593047b6e.13.2026.07.30.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:32:58 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 04/10] hashserv: tests: Improve test logging
Date: Thu, 30 Jul 2026 12:30:57 -0600
Message-ID: <20260730183254.793698-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730183254.793698-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
 <20260730183254.793698-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 18:33:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19884

Log client messages to a file to aid in test debugging

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/tests.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 7c736d6cc..551b9e298 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -30,7 +30,7 @@ BIN_DIR = THIS_DIR.parent.parent / "bin"
 
 def server_prefunc(server, idx):
     logging.basicConfig(level=logging.DEBUG, filename='bbhashserv-%d.log' % idx, filemode='w',
-                        format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
+                        format='%(levelname)s %(filename)s:%(lineno)d %(message)s', force=True)
     server.logger.debug("Running server %d" % idx)
     sys.stdout = open('bbhashserv-stdout-%d.log' % idx, 'w')
     sys.stderr = sys.stdout
@@ -93,6 +93,8 @@ class HashEquivalenceTestSetup(object):
         return self.start_client(self.auth_server_address, user["username"], user["token"])
 
     def setUp(self):
+        logging.basicConfig(level=logging.DEBUG, filename='bbhashtest.log', filemode='w',
+                        format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
         self.temp_dir = tempfile.TemporaryDirectory(prefix='bb-hashserv')
         self.addCleanup(self.temp_dir.cleanup)
 
-- 
2.54.0


