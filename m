Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34997E6F085
	for <webhook@archiver.kernel.org>; Tue, 23 Dec 2025 10:18:13 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.98153.1766485084585350122
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Dec 2025 02:18:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=yoJP28vF;
 spf=pass (domain: smile.fr, ip: 209.85.221.47, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so2464486f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Dec 2025 02:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766485083; x=1767089883; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jehs/+SvFYY5GvjC7H6J/zAgN0xaZG98RwtnE+BfuXo=;
        b=yoJP28vFaWiH9W0W1vcfb6FvbyB3RQ7FrtxsvcbN8Dh7WrSCDqhQQiSLYA56+8b32n
         1C/Ba6CxBYdKisGGYBRB/xM15k+pNQur5mpBhZLCQaTI9QjARCQwm9CPJkKMLs0J1Twy
         6YpyVA+jplRIrXgFXTqI6uXqviPfsgkVrp3hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485083; x=1767089883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jehs/+SvFYY5GvjC7H6J/zAgN0xaZG98RwtnE+BfuXo=;
        b=MQhK4gt0s9DLOVmpr9CoM2HRmGH8YSt+RWJts4KY59aBpjRzmMUn0M1lS9hdeVOhaY
         HZHCot+kyFp4fENDc4NKPWpZtY4WTMeokFzY6Fx3QmbM9wQhoKbVqoZ2b4jVS0VcC3j7
         Kx3hdjbwsCbJcf0Q5JaLtQ3dwzh0RBZLIgSUlJdNR5spoht88c2rLQBIlwXNTcg7VKh7
         NfvRW5om6hjGEspLtTsQ7jYdz9krJyDatx+BrZRdIOBW37kdtv212UgIZIXv+7GdX9/7
         NVwOOmdv8XvhatRocqUoPXHFmNlECKJebdQGgjkRXmt4Va4otrfz3Xvk6yBO1ip63ViH
         DWTA==
X-Gm-Message-State: AOJu0YzN1GQC7JomZl8lKVqe3IQk/28GeljZ4PyCt4NzeowBC1OPCKeW
	UhH6HHC5V/0EnFHNaop9wSHL9po5u+8gpkZ2m4uBQpRNdMksZjA+/kwj6Sf8ewzANZPtgeSKF5i
	oBfLheyk=
X-Gm-Gg: AY/fxX4qJJS4horp1NSg6SuuEGovAtRrYLiZfbTlkhn+9yQKvF+L/DiWfP9R67cTe12
	9TwX0zSqtI/738L8hfYpRvnGaWmtdge1XiMeMiTCaRg4XSxLhko48Ml3niPofPLWDwB9DYrGX6K
	BsnpA0pHHaDqLSU0jjEvHk2jIX87lOX2flBCqcUHQBfzO4pZZPXMRM6UZcc1Mf4vCVWW/ZVZ/Zt
	hA3jYiS+8kp2hNf40lYYaWXSPJIPVVzjYfhJgbogFLZ2+UUCfqAgR32biUaWGDwvS4fl2l0CCsW
	5vGk/MfTizMtjZYj08juta/z5aeUJ9aZgIn6/5EoikZBODymWxs/KtC+1bGBu/8Xxhm7QaVQZco
	VLrfdIGUi+oJx7PdQanJbyMKxgQ9KIJkgwXKIE2nZT89gw0arORdBJjnV/VWhRbNsiMy5ICqOxX
	VQEMptu8NgnnrQbtM=
X-Google-Smtp-Source: AGHT+IHTCSM5dCR54ZJNT9YXudK59JGtHqa1LbCzg5zH6KjwX+lKL6GpsJLQwoyiVV7m844DkMqJVg==
X-Received: by 2002:a05:6000:220c:b0:42f:b65c:1e4f with SMTP id ffacd0b85a97d-4324e4c97ccmr14202288f8f.17.1766485082838;
        Tue, 23 Dec 2025 02:18:02 -0800 (PST)
Received: from heaven ([2a01:e0a:25d:d2b0:4eb0:a6f9:d3f9:1686])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab257asm27428376f8f.38.2025.12.23.02.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:18:02 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v5 2/4] layers.schema.json: support 'uri'
Date: Tue, 23 Dec 2025 11:17:54 +0100
Message-ID: <20251223101757.1057188-2-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223101757.1057188-1-corentin.guillevic@smile.fr>
References: <20251223101757.1057188-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Dec 2025 10:18:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18644

The property 'uri', which is a shortcut for 'remotes/origin/uri', is now
supported under 'git-remote'.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 setup-schema/layers.schema.json | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 1a0255435..f42606941 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -46,6 +46,10 @@
                                 "description": "The output of 'git describe' (human readable description of the revision using tags in revision history).",
                                 "type": "string"
                             },
+                            "uri": {
+                                "description": "Specifies the git URI, can be used instead of the more elaborate 'remotes' property when there is only a single URI",
+                                "type": "string"
+                            },
                             "remotes": {
                                 "description": "The dict of git remotes to add to this repository",
                                 "type": "object",
-- 
2.51.0


