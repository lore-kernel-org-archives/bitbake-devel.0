Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A5F47CC9
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 20:09:47 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53724.1772741386643653864
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Mar 2026 12:09:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dCjFw/+8;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48378136adcso51342905e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772741385; x=1773346185; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zrHMVCQCDV1e/mOGPBebMYelU3AXjYcuX9Vtn0CLZVw=;
        b=dCjFw/+8JqtVPsBlTOJCV1GboMywjQuu0G1TlDLJWQiztpF4C9KoJ2l6kZRFSK+Clc
         PLEfl7sg5qrUBAeyXA0zwvqjieIzIGg+GE/kovW3yBUBuxb2cDg5/+UpjW0mAmix/vbM
         Q0n6TInyQdgaeSlA1pxYmNLmGQh8Mcgjjm952cxZSLzDQzIxZIoXta9P7Nkemc25Iwju
         PvBb5SVLcSvONze0NXAM85hE/g6ctQ6xBBOiSZDmkDF7ts06fjyYfXgBx+3g4/1b+6Vd
         36JTFj++zWpTsiplN+FPVnsJKOS53FjALjof8PM6kXVAGvgn23Fjzo61ZNgT38cK18OQ
         AjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772741385; x=1773346185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrHMVCQCDV1e/mOGPBebMYelU3AXjYcuX9Vtn0CLZVw=;
        b=dRSvBA5uRmJz41tDRN8BGHM+rQpoZbw9t/nHOie3fASgUEFvibD0bSX094hGn1nioC
         pQXdpHSE4uyWbeO/x3C6D1COIaE1vaIRUHLkaaeoopI+5PTaACdhkyxx7sMpVTYojKNQ
         9fQ63pILHOfuNIfRYpdTMvUEskOAWT00Gn+8KYEnaWqJ9cD+JAalZgc54pa6FzxLHot3
         /+vP29vqdH20LylHvbuEf6ipbMrECTU0U0CfFzCuDG+13V3PWu6wPJDhNsPf/D4OzS2N
         40stbjv1ckndHJK4vebBGvBO9VXVFPfWROvq0c7ZiNhnt25859QP1TUZs+/r5u9AukpM
         xotQ==
X-Gm-Message-State: AOJu0Yyf3LqwFCJW+9ce1njSeyvRkCJFDzxivlu2sbxAIPkR5gu2T0I6
	XiedWPIWmhda73WEuJkZxXaNBMXSpJNBiUzSOgE/HVXtBI2s7Gx2qAviG7afDg==
X-Gm-Gg: ATEYQzzL8IVemgPoGzUTYj8YsC06HZg4k0pAudYC8HZ6bTfGw4X5DXcTAWAa5qXyYOJ
	GthOZFV7sgibkywBayt5H/7e+D0XQUJwOaR4k6ccnPdgn1iylDYoCab15oNIBs9FMLWJCszGya5
	/zqBGtke9QAIyOenF0A0FWLwlmUmnTfIqTt5YfydiWP6mfs3NTq7EU9LnjmaF/EnBnj/0a+/eTo
	JW7PFfT36PssQlzYeMOZiWFaZlihTUZrWM62g2LvnJKg4yC9uK5/y8ieZMi7mQK0tqbTa8qkGSB
	eCPZnMcvOaTIttHzdP06NT0HcTRfkv2VaCjcn87DH0ctnyq5kRC00/tALFyinxtc6R28gMqTe/6
	HGwWBwn+18GB97AanZz7fTtjZlqokQVe6MQqP2Yh6ljXUkCW3Se8U8frbU+kDA2E8YkmTHx1LIU
	R0/2qQJSFxDxXAxfgNs9kq+SjkezeUu04MSkPC/iIcvJ1kCTiDCNcFpAJyL+g=
X-Received: by 2002:a05:600c:a4b:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-48519896e83mr106144175e9.26.1772741384714;
        Thu, 05 Mar 2026 12:09:44 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851faf3938sm61203745e9.13.2026.03.05.12.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:09:44 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/2] bitbake-setup: ensure that relative local path given on 'init' command line is recorded as an absolute path
Date: Thu,  5 Mar 2026 21:09:36 +0100
Message-ID: <20260305200937.221484-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 20:09:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19117

From: Alexander Kanavin <alex@linutronix.de>

Otherwise status/update operations will fail if executed from a different
directory that the template file was in, as they won't be able to find
the file.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index bdf134aea..1a42aaa51 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -600,6 +600,7 @@ def obtain_config(top_dir, registry, args, source_overrides, d):
         config_id = args.config[0]
         config_parameters = args.config[1:]
         if os.path.exists(config_id):
+            config_id = os.path.abspath(config_id)
             logger.info("Reading configuration from local file\n    {}".format(config_id))
             upstream_config = {'type':'local',
                                'path':os.path.abspath(config_id),
-- 
2.47.3


