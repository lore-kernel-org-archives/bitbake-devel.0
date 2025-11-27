Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0917D11183
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 10:29:45 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15777.1764239376928140258
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Nov 2025 02:29:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UVlyWWbT;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so1315209a12.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 02:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764239375; x=1764844175; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL73/JKB0ul+gGdMBnrAoJH0zwKdlAAgA6EQDq3xuFI=;
        b=UVlyWWbTidy5if0QZk9op0aF3wm3zGoQohjrQ7Rt1ZNeYJNF6hsVXKvvPI3h6NaTxd
         kxyDlZQ4teRKSS+cjHVZr2jFPE1wlYVQ/oXvdlj6n1dvYE7UFHsWDt3chMQ9jWZq6P/5
         xGCdhxawAV3ZfoAk96F4kuPaMfRQVE5QV9Cldtno5gHOxCk7uZ5XFip6Lc92BhrokFt7
         Mxop3epcWkPnHojIE4R3lWtB4jIkK9HwFlL6uEm1X9exxe0O7pglz+FWa3/ZPBYzMm6p
         u/6wN6TCu+kZ2u4mhcx6pqLAxIACfuCHR6nsecC3bkxQ6v6IKxHbXwcX/qBE+EvAOt4O
         JUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239375; x=1764844175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lL73/JKB0ul+gGdMBnrAoJH0zwKdlAAgA6EQDq3xuFI=;
        b=ngnQjSeuqA4BnsfDp1a10QfbjqKlkE5vdn9fHIcnKkepkkn4QqHujEcIFj1/wZ0Ucm
         3sb92Rr8RKe8SrrA5wW6aMuDWMq84+jNg9IsjqcXW6ak6MwUNP8uzdoHgZpI6E9LxLiN
         bo7u3EXiUMzdHKWZ59gzYsgRynstap7i7moD/fX80tLFrBrVMtIdCYVSK8ifqB393qju
         1T0R7snRiPISBIFT7hX+kF5lNDe6rJyhHNRpfX2nqDPMgEEtIAeIx46GOAEEQhqgoHwO
         kYh5KVyomQt6tgG/FroseL90Bnyth5gHHMa5eSVNY6zp4ZR4xLW2W4dPy6Pl5gacVCuE
         Myew==
X-Gm-Message-State: AOJu0YzERgTdAbvi1tGumav+q0C5zibp/EYACVE+Z/RBkboXOdoxTNxA
	93o+/bf5wMAi7bSvGAZLGi8kfHDFZBE5LQETcXDqQin2tqSmhjvzWSoECgGF3w==
X-Gm-Gg: ASbGncsnorCH1znCelgFnL2gkShOsJa0kHvkS5hThJ4n6ow5TnkeejEd6Sm/pcIPLH9
	/b/0lsbsQ+tJFYTDhlzn7Wn437bhZ6Ug+7PJSLocKetK4Dk9NEXMdvP8BuvcOkCgLB3jrFvgCzz
	imdzyiMRzsMAr83ca0JC43j/6JifD9dFeDLv6Wt7WDxagEYUs9ONCx9VbK2oKuNGAGKRz+u6Oyx
	zxIyWhl3d4HFJUWfuw0gtq4+XVBJY+eNvKI7m+T//SuEoURbgcQzkU+18lJiGrJ2wLr+AJOQZ0X
	bMRksAcha/XVhJ+EYs9mG5bWbs/TXzEViPiFehF2J0DcXhhItizfsQpsBiEzstJyEyfsFZQTQ5Q
	wuAr+DPVk9RdoC31csmgQGmqwOSUbqt7YnTdLjkXUNyPX9jDYeFlLZnMz/cqVJxEY9CuM/R+F+D
	dSEzoJtyNb94e3jNlUgD8vba0267Nqa6toWRY05MaxNRHOwI8B7S4=
X-Google-Smtp-Source: AGHT+IF0ckvVtkgmHtROCATEOdl50/T2s9axj43b/yq2a8ri74oJufcS/PBG48mYohHNa+j2jbkPrw==
X-Received: by 2002:a17:907:6e9e:b0:b76:2f40:a307 with SMTP id a640c23a62f3a-b7671b1a00dmr2548364466b.57.1764239374946;
        Thu, 27 Nov 2025 02:29:34 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59a6a74sm122661566b.45.2025.11.27.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:29:34 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 2/3] bitbake-setup: add an optional 'expires' property to the schema
Date: Thu, 27 Nov 2025 11:29:27 +0100
Message-Id: <20251127102928.3647918-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251127102928.3647918-1-alex.kanavin@gmail.com>
References: <20251127102928.3647918-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 10:29:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18501

From: Alexander Kanavin <alex@linutronix.de>

This can be used to document, in a progammatic way, the end of life
date for a configuration, and make users aware of it.

Bitbake documentation already has its description and does not need
an update.

Bitbake-setup is using the property to tell the users until when
a given configuration is supported, and omits it from available
interactive choices if the date has passed (unless asked expicitly
on command line).

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 setup-schema/bitbake-setup.schema.json | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 027ba2568..e51fef3b9 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -15,6 +15,10 @@
         "sources": {
             "$ref": "layers.schema.json#/properties/sources"
         },
+        "expires": {
+            "type": "string",
+            "description": "End of life date for this configuration, in ISO 8601 format (YYYY-MM-DD)"
+        },
         "bitbake-setup": {
             "type": "object",
             "description": "BitBake-setup configurations",
-- 
2.39.5


