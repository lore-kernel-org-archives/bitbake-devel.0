Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7474DD47CCD
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 09:57:55 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2685.1768557471262246649
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jan 2026 01:57:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Wp2kOBDv;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so11233995e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 01:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557470; x=1769162270; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceg/7D0yrAi0eKmxnCwx4lN9Ut2KI01CfsJ17D6X62s=;
        b=Wp2kOBDvox4KunWy8kKtF9xtWYkoe7dTWH1ZtbBCzzGpKB7n5EzGO5yafyS3PsaTPW
         FDKT0ojnlI60iVo91/Hp93A02DI4h7nCS/mWE72HTm9E9Blygf6UwHwNPd7ox6Y4OBBI
         hJgRravRsV9dAf4QILNfNIjcbRM8YcwfyUWIJz8/JzXKOtbBvNVnmijxAR98SD6lHe5l
         S0KowtMRS3xM+ziA9PaD2qq5SUS+IaaJPRpmCUmXpQZgrXKpVJGHp1wARmsmTRH0jYDj
         S74nJYtsKqhmx/nDT7RiQnU+IlRwExFS4H8c133ieAIHRlH+cPIMMHyhzLAPNcaoReLx
         6Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557470; x=1769162270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ceg/7D0yrAi0eKmxnCwx4lN9Ut2KI01CfsJ17D6X62s=;
        b=qn4veRDEZdmeGMjON3SBlyPQj6WrQHhvG7TFI1q11anTUv/l48GqAHinz8smxLQ9FK
         A1v1u/VwNUqme7cqlOWHMU9h6QGrWwVPyv3a6EsuyddOnIFsIgKaryVFte4HksZbD1SG
         nEoaAzQPFvWGihFn4ohNWTgZI5Gv9ycF0H8OPB2ZJcCRij+CiYkykGXWGrmk8HfVxfrc
         CKbvIZRNyt1jH9siZV2POU2JRAMXxwsK1UC/3fmXq+FNVtiy/NL2nF1hQTx+hNmokkPL
         CzfZVh22QuLUJBOLsNN+YiqiDdLl73hZVUatRoKh5eHy9LehAoq7isq02KqRmCIsCbQe
         Xqvw==
X-Gm-Message-State: AOJu0YzP0vSj1tqAQQEPA1fjDnIT1P0G6sv+9yhJOiw/HZZcojYcjhIs
	FpF8EVS3jY+MBfZbOXKwyL+kNxq3119cXLrmNlNTSqJN6kuFVr5dNf2MVlJoccI7
X-Gm-Gg: AY/fxX4cfcXiqD3B4Nyg9V+0xPS0z8fuCSh9NCGm2Vv9BAWX+vG4hLN3r738N+zL3cy
	bS6cK1q8ci/mvOWHtGEhe+PaoPT1ptT0ImbHZiQS+KR+t86BeF19ur5h6RwDlsD2CO/Ef4JpcQ6
	We748K0/sRNXZMl73VNlQHkr1FiI76s5alrvY12kM/cMPgqdKP/ErZ3VtPiI3vYBrBIY5CS1u8C
	gF0LqgNL5l4ZAqynwc9v3UtR7Hnl/hvoS2HD+xoSCGVfheqGlQQEIM0bX7P49WR8kHM+mnXh9/e
	Qw/6kbCmKb5/KANPqsI+sZBzhnRQnNo6W6f4nU3jqUEUs/VqZHMyoO2T2/NtFmTvXKJI9Vlh/Vw
	aSqyBJ8gqXo5idoCbqlCGbxydGE40BmJZhQRbNNnfb1Dmx1ptIvJ9rrwpMFxo0DzA76bhf6oRkf
	8BG8vUJqTDWOQji/jhYYnMc5YnybwDC3zq8KRPqnHYdYHH6hs=
X-Received: by 2002:a05:600c:35c2:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-4801eb09296mr24893665e9.24.1768557469594;
        Fri, 16 Jan 2026 01:57:49 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c1b2sm34188175e9.3.2026.01.16.01.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:57:49 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 4/7] bitbake-setup: sort configurations before printing a list of them
Date: Fri, 16 Jan 2026 10:57:37 +0100
Message-ID: <20260116095741.3654153-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116095741.3654153-1-alex.kanavin@gmail.com>
References: <20260116095741.3654153-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 09:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18795

From: Alexander Kanavin <alex@linutronix.de>

The order was non-deterministic which did not help finding the
number for the right one in the list.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 8b5cb37ba..776ab15f0 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -474,7 +474,7 @@ def choose_bitbake_config(configs, parameters, non_interactive):
     return flattened_configs[config_n]
 
 def choose_config(configs, non_interactive):
-    not_expired_configs = [k for k in configs.keys() if not has_expired(configs[k].get("expires", None))]
+    not_expired_configs = [k for k in sorted(configs.keys()) if not has_expired(configs[k].get("expires", None))]
     config_list = list(enumerate(not_expired_configs, 1))
     if len(config_list) == 1:
         only_config = config_list[0][1]
@@ -792,7 +792,7 @@ def list_configs(settings, args):
     shutil.rmtree(top_dir)
 
     logger.plain("Available configurations:")
-    for config_name, config_data in json_data.items():
+    for config_name, config_data in sorted(json_data.items()):
         expiry_date = config_data.get("expires", None)
         config_desc = config_data["description"]
         if expiry_date:
-- 
2.47.3


