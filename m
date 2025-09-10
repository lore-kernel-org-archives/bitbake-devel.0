Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CD4CA101F
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 15:59:32 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.22659.1757519963612321215
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 08:59:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=nBkztwAn;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445806df50so61853195ad.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757519963; x=1758124763; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9yO81M5eJaSsNa4tXpscSOpU3GQgN58Bh9vwOf8Qhs=;
        b=nBkztwAnFXb4L7NirWl5xYq8h1VZ1hNLq445U/5MTCWAZaDT07e85x6nCXSZ0MpO1e
         U305BGXVoVOgLEyvKwsFQdG+1F1SuTEJSCPPtJVzByHu9nKEp5eejK0sFDufAf1x2aRS
         5XSJdFfqG0TfbNU0+eaGkZd0sQwxSJ+I2mQ55ZqI0DVFYeust18SanmEgx3sC7MHBQ4h
         zHWJtFDlpY3PhgIHIXKCnoskBS1xSEPPLzpeAhNchMrLhftbxcYXYHaG8iKczD4JTgw/
         TS7EwXlgh53M4c/wiyfDmLhy6vcgs/K6980MXq0cEF5ePG/WTpuaVLjeGllnq96quSeY
         Yl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519963; x=1758124763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9yO81M5eJaSsNa4tXpscSOpU3GQgN58Bh9vwOf8Qhs=;
        b=ZZ3WGQnrSlzCOQtdZ8jdTcWwHIjX/jodxgZXTfxoHQzTWJjRNgOdz78sZXhdY4blQE
         jSgpEoFZ9IiPf9vdNXwp6CjvVB8bPkd83df1Ye3OETyc9RNdkbEy2SyYNsp1+LHHOFe0
         zjHUhgvLLbfoyhP0GhFkLtUozdc/Z5NS3led3S5HfPl8Sh6kj0TFMPGiBoYj6fsP/N+o
         rDKdMMFcFulBBaSa588h4q7ATq95IxrZCDKw1/v4utj+bySOnRFT0TI7gi4MHPXl0elx
         ZwWZwrhACYoABM1AzPvacQxATJRZ2a+SJplPbx7ghz8r0TsuRozlFQmX0BWqZtIAVWwP
         z8ng==
X-Gm-Message-State: AOJu0YzH9C8W60A44yill8RIhegYr5aYLFk0L6WhZGzsD8K+DYoKvdou
	kvZXFVlaQ+FwyWWrS19YJZiZcaG9TlWm7colmHjwCWlD48SAxYa1G0goSsuZYqm4tovTEXcVKOP
	z0FsR
X-Gm-Gg: ASbGnctPN4ttbkUhOBRtBxS//1jVJbXni863TuxnapKpsPNDyaoRFgtZaBs8sRbg39/
	3Amv0kuY6l4p1PuaIOdjq6z5ay42povPPTnnv5wDzN6bshDmWvarg0ZM6ettdfy3ipCj2cUzcdx
	rlTaqYJEqvrXZB1gqHir3rYh/iy0bCsfkCxBO1ilbb2DANzGrlRMOuLtEUNjVSseAVSsqD2VPdV
	DszOht3xNocv26WKgfvZv1/cG6zE9nqNcOtZW3BV3U8pRvUPcmsIrC2OObqdL9XYUWXyfuzua1k
	xSNRYBGbaP6tLTLawmC8amtZbQJmTeLyMEXcZFUmqN5EfhODWJSLykdiWRHWX6QA1bCX3bA8qZO
	DtDRBDVDAB0m0zoxdjqY70dbw
X-Google-Smtp-Source: AGHT+IE70bzW7/KPNSCGFnzuf4FCvj2P5+ntsmoGNRs0ftJcdXYMt83HogebspKXi5PtrX9VXj532w==
X-Received: by 2002:a17:903:2b05:b0:24e:81d2:cfe2 with SMTP id d9443c01a7336-2516f04ffeamr228559885ad.7.1757519962819;
        Wed, 10 Sep 2025 08:59:22 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5b33:a32c:9e59:27d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2acff4c4sm31235405ad.124.2025.09.10.08.59.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:59:22 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/2] bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()
Date: Wed, 10 Sep 2025 08:59:14 -0700
Message-ID: <dd87b44413fe0fd0c9061027ae178ec994532844.1757519842.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757519842.git.steve@sakoman.com>
References: <cover.1757519842.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 15:59:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18002

From: Bin Lan <bin.lan.cn@windriver.com>

There is the following warning when executing to bitbake linux-yocto:
  bitbake/lib/bb/fetch2/__init__.py:464: DeprecationWarning: 'count' is passed as positional argument

This is because the 4th parameter of re.sub(pattern, repl, string, count=0, flags=0)
is a keyword parameter. We use keyword arguments for parameters that are not positional.

Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1a6ff25d4..7b75d5d83 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -460,7 +460,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                 for k in replacements:
                     uri_replace_decoded[loc] = uri_replace_decoded[loc].replace(k, replacements[k])
                 #bb.note("%s %s %s" % (regexp, uri_replace_decoded[loc], uri_decoded[loc]))
-                result_decoded[loc] = re.sub(regexp, uri_replace_decoded[loc], uri_decoded[loc], 1)
+                result_decoded[loc] = re.sub(regexp, uri_replace_decoded[loc], uri_decoded[loc], count=1)
             if loc == 2:
                 # Handle path manipulations
                 basename = None
-- 
2.43.0


