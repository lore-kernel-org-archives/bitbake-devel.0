Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909B6CA1009
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 13:58:50 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.52234.1756735126996156748
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 06:58:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ah0iZRes;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b043da5a55fso74596966b.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756735125; x=1757339925; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2yuXcYicNsLfmVmTvV6iIFzMrQnvqDQBWylQv3X+Z4=;
        b=ah0iZResWUAv1sMe2PC3T4wW4kXXEirJJMMtd+kGX7f5yxjWadTOxDp6Q6/rv1wvLa
         st0JwOM0x301GgZ5QpsV5hoUc03hUtMyvh9cl9vxsiMUcxO8Am5+SFeKI4YuczQrtLPk
         1KLbKiYozybJNljCT5Fwh0PsihOiIk6zjyq7i4ao49a24afv4Wqu1d8XfOqdjPf4afIC
         TLLwS8kgk8Gt9uNG8Ca5E8AX6XjxmtVuvhe+9/d9omFvcmhTVJunaIT/gud7GYB1fJNQ
         8C8lLPFvD/plznuaxzxyrNAjEx3N2CVDNV6YTl8yeUxT0KvNbKRch0wPpXhN49kXp0sD
         cYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735125; x=1757339925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2yuXcYicNsLfmVmTvV6iIFzMrQnvqDQBWylQv3X+Z4=;
        b=GLAZR+cgYSgZLZIkfbsI2mwbidZ/RuQM5im6FzqjjphzbXtRtgGzguxaECui2NnGQL
         dRpeDVY1Y4EFnB0an5BpoSaNYzWgiVeWM4EB+qPrhActTGixIfnKaXyxqUnquwrTQcAi
         3htJCci6WKYOfj2anPP6J0EdFi27VAUtR8iIrsQKYEzJTvPEZDjXSMKnrbSEO4QD7XP1
         NY2yAVDlLWOpYUOKe+Gs7I6G7CQu5aKAy/sSunghpyLWEHHuASp1aM251gNECc99HXfZ
         pFiIncwsobTO1LDC8dnFUYTV4cEp9iwgtzDdROOoJqtb1IbeBFVdXxqRaW0YCFANCgP/
         qb0Q==
X-Gm-Message-State: AOJu0YwGdtK7t02XsBoWz957U40iwNMDeI9iqjdHh86uXdKEueCKIn/9
	GfvgNMkoS06a9ODRD15FGU4h4KA6wjVb/HbwRAcB8iCPwSIa1gl2GaAKrRUGFA==
X-Gm-Gg: ASbGncuaDwQVKPD/H7XpwvT6g2bktxc60LD1CJY4sGltuEgZFiArXuGUG5WYyLxZ7Hp
	hn11M4VrMuLLhHwabgSew7Fj4uYvtosfPIE5KzV6U0V4CSOWSCmqNLBsr49BAlqqw/NOP0nRHWV
	a0TsPKNzLpFX4UNl1TXCwo2s5TOvgiwbgHocgNwxVnD9QetePPJ7L/9gesRUgLF1asuCT58xFlU
	WS5BtZGd7RXyqAYbdaQSL7ToSVWUVz5L7mdLD24T4DVUbfgRVsjdfbWO1J84gIqdI9pN86NOH1K
	jtygFi7SRLtUuIhssVXJKIrjkwtJ2MOb/Ry+HL3HuhMDNMzTnB8+QNd6DUFcldQCUeh7Q3/DqJP
	pYyFFXUV+dgITSYEIsrbP3eNeS0pJlTVVWjuksHa01izvBuAzNJaA9Cl+duDvA1LPclhd+9j34B
	3hBabcc6qlGgDFnLQ0LW8xQK2LkuH8Yk+Fs5sc5NNMxDb8faPzB+5K8EC5NRTx+O8NfwT7
X-Google-Smtp-Source: AGHT+IEmPzvNdbCjf8gfkZFwcLcw2CeYEE/LU7N4FqIy6lBKMdU4MgPAj2fMNXwOvacdcKPkgtq/xw==
X-Received: by 2002:a17:907:1b10:b0:afe:c099:aeb3 with SMTP id a640c23a62f3a-b01d8c90624mr897008366b.25.1756735125304;
        Mon, 01 Sep 2025 06:58:45 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c6fdsm873503166b.75.2025.09.01.06.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:58:44 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Gyorgy Sarvari <skandigraun@gmail.com>
Subject: [PATCH 4/6] bitbake-setup: fix typo
Date: Mon,  1 Sep 2025 15:58:34 +0200
Message-Id: <20250901135836.2927686-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250901135836.2927686-1-alex.kanavin@gmail.com>
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 13:58:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17916

From: Gyorgy Sarvari <skandigraun@gmail.com>

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 596c9885a..9c2922b59 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -539,7 +539,7 @@ def install_buildtools(settings, args, d):
             print("Buildtools are already installed in {}.".format(buildtools_install_dir))
             env_scripts = glob.glob(os.path.join(buildtools_install_dir, 'environment-setup-*'))
             if env_scripts:
-                print("If you wish to use them, you need to source the the environment setup script e.g.")
+                print("If you wish to use them, you need to source the environment setup script e.g.")
                 for s in env_scripts:
                     print("$ . {}".format(s))
             print("You can also re-run bitbake-setup install-buildtools with --force option to force a reinstallation.")
-- 
2.39.5


