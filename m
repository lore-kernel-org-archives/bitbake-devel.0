Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F377CEACEF
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 19:48:55 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18491.1763408928869241188
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 11:48:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mg536URP;
 spf=pass (domain: gmail.com, ip: 209.85.166.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-949022f1c85so85296739f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 11:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763408928; x=1764013728; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSBUNpymSwpCaS20S7dN8Mr4EWf4PXc3ExIgx4qWwL0=;
        b=mg536URPGZrGnTXoezUIigp/yM7FM0gEjGT4qh5jT10f5CfZX1uo5CC4uSYOGwQ3NC
         LkN291uyeJ+epAnkPxlrr/xb03IrCagBYLB14gKBtroVl4Cph3A/JYLZQ+fx+Zs7s7Sp
         WpSqpHrC+2Calhkav7nfx4lRtoCyP3kvRr3UBSXdXPImkwZvYaBYwDodBG4JSWT61Oci
         TkKpTmIa+tYka1bCJ5mpGmgDkeMbeMqKF/hxRHTdM/I6hP+mh04KapwjgRB1cEzixtnO
         Vw3r8oU1NnguSZHNnGqA7WYcwWHeUxxBQ1pYzoe/xs6gSeDs8XdNkW/U1rHdQqqxcoM5
         ep1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763408928; x=1764013728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wSBUNpymSwpCaS20S7dN8Mr4EWf4PXc3ExIgx4qWwL0=;
        b=E7ILWHrI/VjMtRouaTkqE7RwerDWrFaIzZVWOKyxWgqJtOqOh9iFbUtTsHCTxi81L9
         kbhM0syylEPrQWRpkZ62s9iicpSmxq15LY9EqAyC79sMUjrPlGvD57C5+t4U9WtZynNH
         H+bKa5MmYRNIqQRgKXKnuf8Or/5FAYiRlX4Llrgi1BFbhnc8N0SWLBbPs2k2ABsWpzH/
         BJSPem8YnzhkQ3eXCSTSox2UwUWpEiXYTER2scgxNGu6k3FH5RZlkmbTTaBedY7IlGQB
         YpC5oLI795vS0eDDdf8/9vN0V4ZAmHotn/q6DpKi8megAupr87nYVJu5Zp6xP7AzgWmm
         pR9w==
X-Gm-Message-State: AOJu0Yx1Lqw/7dQXrYJs5JapvAisSprqotLExmhrZaEMxlwzsGNBqlu4
	ZqwsCsb28MZQzwlml9mgtvKQrq9Yt6c4OUmBpuYBreOwJZFff5f8M+z5ZWWVAQ==
X-Gm-Gg: ASbGncsvikwH0wuz+CUzPk/Vf6grH5vFBQ7i9h6diBOnXlGYKDOuk/dbXfjPMFNk33X
	zvWNM3MS8sMZfUicacVeNpF2rhqyxHR8H58EbIzGLOVGZSlnqDJJ8FUR8NwKPXog5au9nmJQTff
	AxHWJph6LPHiWrYrHxBeqYVOX5a5vpOgfX+OzeUQErL9ZMcHfFqfNS6C2HoSdsDHWml2OQxHxw6
	hzv97DDQyCrdxfzaq3nSnWwVCg5X27OD7CmInTrDZO8xiiacA5KKLVRs3+Itu+s6AieY8FX28M7
	GUP4KLLckGUwHUlcVVhwqHl2IgjZAAYCyG2SQqMuZ1xCfDGpEYxwm7eck8GYsFLB0Jnbjt1HmM+
	Pu2HivY9BUn2eVvYOW9M8mqTC+8Kf6poez6X3IBoegks5NqDzjxoNN55vamr0SmQDlownkrqkdv
	hcQq/wmS1s6hpI2oH9rBk=
X-Google-Smtp-Source: AGHT+IGJdRoQKBgl/zg+uobfkYJ6RQO5ptT4DEBIQXYlBfa8IgTaLjIAFCyGjrdCA6Y+HOzq4LnRiw==
X-Received: by 2002:a05:6638:285a:b0:5ac:3c17:59de with SMTP id 8926c6da1cb9f-5b7c9c31616mr8609947173.3.1763408927881;
        Mon, 17 Nov 2025 11:48:47 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::9115])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd24d922sm5086968173.10.2025.11.17.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 11:48:47 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 2/2] default-registry: Change default setup dir
Date: Mon, 17 Nov 2025 12:48:40 -0700
Message-ID: <20251117194840.2322115-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117194840.2322115-1-JPEWhacker@gmail.com>
References: <20251117194840.2322115-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 19:48:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18438

Uses the template mechanism to provide shorter setup-dir names by
default. Specifically, the machine names are no longer part of the setup
path since they are intended to be changed without needing a new setup
directory.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 default-registry/configurations/oe-nodistro.conf.json | 1 +
 default-registry/configurations/poky-master.conf.json | 1 +
 2 files changed, 2 insertions(+)

diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro.conf.json
index 7619738b1..7ed00584f 100644
--- a/default-registry/configurations/oe-nodistro.conf.json
+++ b/default-registry/configurations/oe-nodistro.conf.json
@@ -43,6 +43,7 @@
         {
             "name": "nodistro",
             "description": "OpenEmbedded 'nodistro'",
+            "setup-dir-name": "oe-nodistro",
             "bb-layers": ["openembedded-core/meta"],
             "oe-fragments-one-of": {
                 "machine": {
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 60531ba02..e55ff796e 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -54,6 +54,7 @@
         "configurations": [
         {
             "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
+            "setup-dir-name": "poky-master-$distro",
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
-- 
2.51.1


