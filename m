Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB28D65C73
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 11:11:08 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.35226.1731582659281050287
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Nov 2024 03:10:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IBZzSlqQ;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-381ee2e10dfso288073f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 03:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731582658; x=1732187458; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws1gWkyGI4yaWFzhZcbqxVzfseYgbY0VRVhs0VzZGYk=;
        b=IBZzSlqQtk5lvOALnqzC3L1T3gn1UFknz4FaUqYsEAnrsJNHIBovoda6hVNXampJGW
         2ZtgM2UBYMsqn+EDo8zyF8k3P+Pqc09EEV0E8wOLzGGtixego1A1Qjg7XkkOb3D14Low
         c62CmzlA5Yu+adadO6FuiSufb+xeh/4dRioBonoWhI0KdRSEawJ8Qu268fr9oYuvzWF4
         KW+jZVt5pGsjU4fYY7deEEBpiHVaY/sTzP5mCuN49BYKOqLX+r6r/AQce8wSfapzRLQa
         dUTxEnxbXAUAM4uG0RPYmScEZO2fTB0SNwD7qGJJcDlvjefGdlc6mLPPwS/0NWamjGSi
         9+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582658; x=1732187458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ws1gWkyGI4yaWFzhZcbqxVzfseYgbY0VRVhs0VzZGYk=;
        b=e78khgZO+DseYx63wmVsHs8ibtjrjfqTYMl1W4WFy2K/FZ5znen5JqHOU7oBJJWJ0J
         iIav++cmy0IQItbzeUpdDIm/ac382CTYrQFPHBmfN5PPhfYtXM2prxvm2FKeN/zVGSE6
         t6aTMV9MTUkMvDlvNtpYoCFFBvTIuDlbCSrELmpLxv1FkglolaHqKmqXSL8Yk7EmqAId
         CpQdXV2X8q2VjqXZz+wzNQbv9iiVaC0Q/7e5O7S1GHJsQ2Da3pLnpXUS9FWrC0eFaxOj
         QoC+O5nqgoLqhpSQGHhZSZfFAotyHrt7MAI30ltj7a9nkL/2+1IxIcF1hk+o5cLhGszU
         1BKg==
X-Gm-Message-State: AOJu0YycUangdfF75JeqRBAQVr+f9OAXpwp1utQTJ2GV2bAjOg8maGBm
	iCsdA6B4YZ3IzGE2UuT17hq+7H9Mc/2cd+8RDkzDO4h1A5e8s8qekxOMZg==
X-Google-Smtp-Source: AGHT+IFZMzSOm0ou+Q2D0F1xw/btJM75qQtyQkp8o83Zfn4l6+BDhF4uanpjYkLZIgoqKT53X1y69Q==
X-Received: by 2002:a5d:59ad:0:b0:381:df72:8678 with SMTP id ffacd0b85a97d-3821850235cmr1263754f8f.16.1731582657372;
        Thu, 14 Nov 2024 03:10:57 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada31b0sm1199051f8f.1.2024.11.14.03.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 03:10:57 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/3] parse/ConfHandler: allow / in variable flags
Date: Thu, 14 Nov 2024 12:10:48 +0100
Message-Id: <20241114111048.2624711-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241114111048.2624711-1-alex.kanavin@gmail.com>
References: <20241114111048.2624711-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 11:11:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16799

From: Alexander Kanavin <alex@linutronix.de>

This is beneficial for config fragments, as their names
are specified via flags, and those names can include slashes:

BB_CONF_FRAGMENT_SUMMARY[init/systemd] = "This fragment enables systemd as an init manager"

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/parse/parse_py/ConfHandler.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 31001e2afe1..35321dacfe1 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -21,7 +21,7 @@ __config_regexp__  = re.compile( r"""
     ^
     (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
-    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]*)\])?
+    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@/]*)\])?
 
     \s* (
         (?P<colon>:=) |
-- 
2.39.5


