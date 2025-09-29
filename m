Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5315FCCA46F
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 12:56:45 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web11.52699.1759150598410649393
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Sep 2025 05:56:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bBJWYHIc;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso8382676a12.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759150597; x=1759755397; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX9xxXcci50IbKX9GSpABXq+hnqeOEo8lXky4qGze2A=;
        b=bBJWYHIcbztPbR1G9bHbwhyM+uF2FOAN9DBnx+eBs/xfjPNkUBix98s8YX/K8Fg2bO
         TPFHVL0lup4FzAP4qByli6juDuXLHI38FQZ1lzJ27sSNQn/8OGMy+UVzFGGLTSCXyQcd
         60L1lV4UGhvKQeVDoPKduKsqSaPErG+qUvA/rORWlAMYNGN/+69wJQfZxVEoBbBCRUEP
         f+mJy2CyJbIiwaRSP15Y7tuJz4MR7IpJSnpdKKOXauQDFTcyY/s3eY686YJ1TS6Vpxxe
         oAYyWpVa+9c3SWpjpGcR7A0oBZ1KTbs2co/6umKtT+9eEboy9I8LT99ZBHTnK11BPP5A
         2eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759150597; x=1759755397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qX9xxXcci50IbKX9GSpABXq+hnqeOEo8lXky4qGze2A=;
        b=iGGiYDbes6137RPBvdDq9ubzimr425lYX++zXoR+eKmFLDauQk/47jqGLMRGcCJvEI
         hB9YMl915g2uIpKWyYn5Bd9DJOurmXaxtJ3P/wC7tKdglbwt3UW8tbd2nySP1mlO+jy4
         AVdxhQnH1yxFWQ3KxUMCjcFZPlT6C1f0Ba9vb4DycPkKMZMGpE9I4R/3iliDmw/zWOa2
         igawzJO34+2cRo2d/tBeoQVpqjzyNdQXoRZZpSm0ZJoA8JeJmsmpa1hmeVLe9/57Kdms
         /E5fNJ54/YfIT+XrRjHQ3NVMTpDPTfE/7T4uB+Ff+UfifuHXaQF1ILY+iiwHNu4B87/e
         BHUg==
X-Gm-Message-State: AOJu0YyKAAfF1lHkPejfiVwvCcNsYMUH+j0LkReGANCK0JrH/oLrFF79
	bYvGFDRbLYOSohuBTnh4XFQXRM7cFDUgKZSBYHH0mEmxN/iZVvwtwjxMDP2v2Q==
X-Gm-Gg: ASbGnctbX/0jhLecY5ron1HdjH8UxFo75jJ7eGGVCuIbzhQ05/qbcr6XjRhSfc5va7H
	Acm5ay4VWjwQvPn/KOTFryWoB0Q8mxZhxAA+ZgGBohD31EOTpiMZh9lzdoaAxNtqKn+BKf1s0dl
	otcD57GinDDQzM+kUK/GveisADVaq8+3nbzYIoOo2tIrclqxA9xCbgv7I64KIUJ20YHijSP8PX/
	BXzJ8FYpp2yb6nyK8Fr5H60wb7so/EKjAtSKfQeZNggZfT0+b3Mv3uk8IR2xZwDPZR5L4ivLNmp
	1GxCjZhc4n2BOHm+K64vLHUbs4gg63vI2ACPAlSSV0a/mBRaAz7paehyFnRNWCHwu7M++hKQbxb
	bSNjxSq31F7dZoxIU9o0sVYvQiTQW6UoWDoKCSRhPB4SJzcHBWgyOMjHG0Wo4AqOhBFSSMIrtmQ
	r0yrEBme8NAaJ8qx3E0KkYADqc6DMophBO+Hvi3kLoL8Wjt0MKIm+MjJrAG0PTQL3F6LPw
X-Google-Smtp-Source: AGHT+IGXAZ7wgLD+Qcsn+BhqArWra5qCF92tB5Idr5fWq3Q51/YMw0oqcGmtRmIWpxQrHVQCYo5nrA==
X-Received: by 2002:a05:6402:42ca:b0:634:b3d1:8f91 with SMTP id 4fb4d7f45d1cf-634b3d19105mr13396369a12.0.1759150596718;
        Mon, 29 Sep 2025 05:56:36 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634b46dca59sm6575915a12.8.2025.09.29.05.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:56:36 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH 07/10] bitbake-setup: Switch to internal default registry files
Date: Mon, 29 Sep 2025 14:56:13 +0200
Message-Id: <20250929125616.1751116-7-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929125616.1751116-1-alex.kanavin@gmail.com>
References: <20250929125616.1751116-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 12:56:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18106

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Switch the url to be the default internal registry rather than a private
repo which was intended for testing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b07bf2eb7..7067cbd4f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -19,7 +19,7 @@ import datetime
 import glob
 import subprocess
 
-default_registry = 'git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main'
+default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
 
 bindir = os.path.abspath(os.path.dirname(__file__))
 sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
-- 
2.39.5


