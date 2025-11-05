Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B35BCCFA1B
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 19:06:48 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17904.1762369604156097405
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 11:06:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H+7c0YXo;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee130237a8so133341f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 11:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369602; x=1762974402; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYCNFMpdWkQFM4DMFhg+r/4DTkF+qIKKphTbOWJeHo8=;
        b=H+7c0YXo3UjA1uGeMll/7yDQoBN3/U9yudvNUSmsIqZDZo2z/zqs98Xzf83I4HPTCw
         Vecpfd9irz40pDkqO05A9KIFJTmCL6RBD/Q19ZaQRBc7N4of02a88Iv5Tar1GZYw2B0V
         eR0DTgHCboUxBy47u5eBOG4Spk78YLKILfD65zE5EZnGoHfwOHf56Y05OvQHFRre6ij+
         qZOH8g2bX+y8Pma2lNsKHo9YwOQWKFdm3p9avorqtBeNt5N3G2PmEtkvCdAOBgcky4lz
         mpLBnHQphzS9LiBrRWHQzhkkypbjt5LLiXc1ge+h2QqxJEEt+JTfri4SMjiRRq3L+fH/
         6a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369602; x=1762974402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYCNFMpdWkQFM4DMFhg+r/4DTkF+qIKKphTbOWJeHo8=;
        b=SCLWQ+Zx4c0nIMvcAzburHIx62O0pSmlHQ6x86+UTtaVn7swTnjM9oCguRI0nbjCaW
         ru0O47tMFjpHxQltD5NcyLiDc7MbtJEkyOQD3/Tplxr5Fnmh0980q3g86SxXWUnXkJiN
         ILIcCcqT1dA6+jJyRWTVcGeUpMeZhQzeewz/czDJvvW2KBkYDT6PA/RV+OcOCdQZ8Q/h
         HbsRvYmmJhC0tb1BFkN+0g9p8uQPMENSJO3Dog/1aPv7SDFULD3kJKxo6Zv2jEYtICXF
         wOAjKCQdMjZvZQaBE2FqLiaw0DLYnb0kwTefAnmP78TahjBDeqK7pUQvVOhrwjPlVs95
         LtoQ==
X-Gm-Message-State: AOJu0YzaKE2EQQ/W9KhBKnNMDAfz9BwfSMpDc4yYmyA4wq2SKH+lcgZA
	1pBBFSOlqIryLBXhfwgiVW16VpJeOCCduKD3YXerDA+tS8Qx4OdVEts84SoH4Q==
X-Gm-Gg: ASbGncsVeiYCWHQPveTautUhe3wSsF/9Gr7N9mjHaPy3hGTse+u2kVOvSGWhTuB8iNC
	yM+hQrKyaD+/TxQU12Bq/VrCIHyNTHoTSdkKK8KwXtW+CANaLVUq9tt3/G4Hna4Ikkt9g1haq/y
	uJ9bgsepMxhHH0ipcQyIpiYfPErtQwDoE39OGS/7yPIHMHjELU7h9rvyJnpsIqHO1KU//Ig2r6E
	dULs1LoOv/UUSTaST7qn+fxeP+N27IHD2arI4ib7Eg3Q1q1o5J6wlBiNXns8+5VseDpy7ELkBap
	cPNwUayCHBg9i0ZGQnsI89QefGOd5JyZm9V1rkOextcaUgTAj+xQheJgBElxhpNhQajL+GQuYBs
	a3x574dXpFWWkawJ09cYaNrWH0krleZ5l5OwSfQ5pnLUl7gCPe+DWAyXarWznidi15q83BHGhbK
	IISuSd2YBNLOQnTs2i81NQfRkUKu2+bZ7qlxXk
X-Google-Smtp-Source: AGHT+IFiIWDoGOd4h+uByrCzBPa+JvK8oXEhulsQ4PPQOj3gi/ke28N9of+iS2uIlFb2l/ugaE1QZg==
X-Received: by 2002:a5d:5f46:0:b0:429:8c4e:b0c8 with SMTP id ffacd0b85a97d-429e32f7b92mr4523305f8f.27.1762369602488;
        Wed, 05 Nov 2025 11:06:42 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb477203sm313840f8f.29.2025.11.05.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:06:42 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 2/6] bitbake-setup: fix key-error when changing a new 'section'
Date: Wed,  5 Nov 2025 20:06:32 +0100
Message-Id: <20251105190636.679388-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105190636.679388-1-alex.kanavin@gmail.com>
References: <20251105190636.679388-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 19:06:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18271

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

Setting a key=value in a new section would raise a key-error when
using in-memory settings, e.g:

./bin/bitbake-setup --setting default top-dir-prefix /tmp/bitbake-setup --setting default top-dir-name gs settings foo bar baz

Loading settings from
    /tmp/bitbake-setup/gs/settings.conf

Traceback (most recent call last):
  File "/tmp/bitbake-setup/bitbake/./bin/bitbake-setup", line 853, in <module>
    main()
  File "/tmp/bitbake-setup/bitbake/./bin/bitbake-setup", line 838, in main
    all_settings = merge_settings(builtin_settings, global_settings, topdir_settings, args.setting)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/tmp/bitbake-setup/bitbake/./bin/bitbake-setup", line 733, in merge_settings
    all_settings[section][setting] = value
    ~~~~~~~~~~~~^^^^^^^^^
KeyError: 'foo'

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 bin/bitbake-setup | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index a9035e7c8..3f56f8378 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -726,9 +726,13 @@ def merge_settings(builtin_settings, global_settings, topdir_settings, cmdline_s
     for s in (global_settings, topdir_settings):
         for section, section_settings in s.items():
             for setting, value in section_settings.items():
+                if section not in all_settings.keys():
+                    all_settings[section] = {}
                 all_settings[section][setting] = value
 
     for (section, setting, value) in cmdline_settings:
+        if section not in all_settings.keys():
+            all_settings[section] = {}
         all_settings[section][setting] = value
 
     return all_settings
-- 
2.39.5


