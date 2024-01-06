Return-Path: <vvavrychuk@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA137C46CD2
	for <webhook@archiver.kernel.org>; Sat,  6 Jan 2024 20:24:06 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web11.1992.1704572639764305512
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Jan 2024 12:24:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YoQEUvjV;
 spf=pass (domain: gmail.com, ip: 209.85.208.169, mailfrom: vvavrychuk@gmail.com)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so7190771fa.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Jan 2024 12:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704572637; x=1705177437; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RspbsAxp+mC8f7j95gljDrHR6V1JKjYCGnZ6Wwtzsak=;
        b=YoQEUvjVdhAKuGNT92gpvsJwxv42fWM6Hp+bQ+XYTUA8Ked6dLKgRrNn0c3ZlX8d0Z
         sfDx94DFA+PJ3pGgtRA0mHWWUjfkZtgfxPc+cXIof6dVWG2rmgauSYYpTw2yf1Ijt0in
         t/I/cPwmjKd5ROP1utlQBXVQzz5IauZMOVbIlpvCFRMZj1HTMHzUofRmMGVe2LoH+zGY
         g8B/gxu3lR53ZIOwGrbt/OEIookpmzn5kWUP7vwMk9Z1nmp/TMyd/wVHdfSQTeQ0Ugon
         oqEVuhiC6OQdbFV6IkdzqqpXW2hw5B68ENMJ+DUrWNHErB3cbcOsQmhsCe6pKqTXwUTi
         6uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704572637; x=1705177437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RspbsAxp+mC8f7j95gljDrHR6V1JKjYCGnZ6Wwtzsak=;
        b=eWBHdmwCDQZL7Bhy+i2SfO8PC0H4If+bKCl8l95JeDFLHV0Vss2vANfoFenfRbSzS2
         N2TDBtp+J1Y22rmbYRq2btsYE3gMVgkt9zfr8hv7izVP2bbkp74nzRKAAmHiPzmAKXq7
         d13ZyzU4wRlVeNUX3hIIJNHxK+nHvyekBHT+CEPMcA5CicsG/D3V0ycFawkTvOYhwtKv
         aEulLzY39pwR7HOyrWBQBsChK82oSvaZGfz4ObsEBGCVFTx0Y4R9XBFeTRwZk60vOvb8
         cRaxRWnDgu1kBl4RJzhg+1cVkYcs1jes72wUu+i0Zxp4jzPwup21UafBjEmHQJ1KnYAS
         J1Ww==
X-Gm-Message-State: AOJu0YxHStwh8Wpma5pnFAct8ipaIBciPQeGWyfGyagHgYtXFuAnurHm
	UoR+0xcuCnp3hrh2VrmnSGj1MbzPy+GxmA==
X-Google-Smtp-Source: AGHT+IHhyadEO8LK8WS2ZIsZuBF/1WjdmJ6Spi2tP2+K/3Ic/RYb9p2onTLO85oDbwzujwzEqc3YLQ==
X-Received: by 2002:a05:6512:48c:b0:50e:699b:55f with SMTP id v12-20020a056512048c00b0050e699b055fmr560400lfq.66.1704572637225;
        Sat, 06 Jan 2024 12:23:57 -0800 (PST)
Received: from LWO1-LHP-A10856.synapse.com ([185.219.78.170])
        by smtp.gmail.com with ESMTPSA id s8-20020ac25fe8000000b0050e824e55fdsm619261lfg.107.2024.01.06.12.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 12:23:56 -0800 (PST)
From: Vasyl Vavrychuk <vvavrychuk@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Vasyl Vavrychuk <vvavrychuk@gmail.com>
Subject: [PATCH] bitbake.conf: add missing CACHE setting
Date: Sat,  6 Jan 2024 22:23:43 +0200
Message-Id: <20240106202343.704161-1-vvavrychuk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Jan 2024 20:24:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15746

Without it bitbake fails with

  ERROR: Please ensure CACHE is set to the cache directory for BitBake to use

Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
---
 conf/bitbake.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/conf/bitbake.conf b/conf/bitbake.conf
index 2c1d8be2..f5a5a333 100644
--- a/conf/bitbake.conf
+++ b/conf/bitbake.conf
@@ -23,6 +23,7 @@ DEPENDS = ""
 DEPLOY_DIR = "${TMPDIR}/deploy"
 DEPLOY_DIR_IMAGE = "${DEPLOY_DIR}/images"
 DL_DIR = "${TMPDIR}/downloads"
+CACHE = "${TMPDIR}/cache"
 FILESPATH = "${FILE_DIRNAME}/${PF}:${FILE_DIRNAME}/${P}:${FILE_DIRNAME}/${PN}:${FILE_DIRNAME}/files:${FILE_DIRNAME}"
 FILE_DIRNAME = "${@os.path.dirname(d.getVar('FILE', False))}"
 IMAGE_CMD = "_NO_DEFINED_IMAGE_TYPES_"
-- 
2.34.1


