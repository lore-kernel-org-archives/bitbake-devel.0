Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830A6CD6E4A
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 15:00:19 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12171.1780066814606556333
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 08:00:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=bYRq4jxl;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef616daf6so325445f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780066813; x=1780671613; darn=lists.openembedded.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZcr/4rbbchy8lFv9C9AfZ8Vt9UYlfZsyfqnNEETcbE=;
        b=bYRq4jxlxRW9FIXgGmDd1W7eloltwuFQRf2rlEJJ0Q7hsGrBc+LmbnuyjQZoB47Rod
         QvUV/wR7+zouRBfyRW0hYbfsMcKdXhzw7Ke3IIjz0x+p+lIsVDDDejri+G9CYHXgKEZ4
         tW/MzQSTP9yFtYefApwUaB0x2ajuBU97yygdJz7x41d+WEKjksZ0mC5FFS8GnJpZDQfU
         GSlyEauzoGSmN7SlOQyoEvi2QKEna2ubJuxo4ewxJrFrnT7F+lTsewCZhZJYsi1gxXM5
         rsbVMDjJ6iPjGHTU0/AMif02x9nsl0ICOmo/N83xKetD2mQrzEsZ0DWJqzCbZPnsCZx4
         t+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066813; x=1780671613;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZcr/4rbbchy8lFv9C9AfZ8Vt9UYlfZsyfqnNEETcbE=;
        b=EtBqGjrzU8J6fGb16JpoJn2LxGw4JTKWE/o/rcd+JrEIrXAKUtlgekkMKhZUoDIgVv
         2rsc6fovwxeEWyymLF7wAzwAlHWdDFUvyL4D9vwRVCmBGLwIDOsTeRHV0FQI0G/uFhvv
         DiRedEsJA/tVOruQEOVLUcxYw8w/BwsIk8dExLBI7opm/HmADxL4w+QXj0QqSPA8CIwk
         KwAjCYYuKi3xFktiPu9en7BepFtj8PP0hXjSphwLq7BWy1kjh7BaCVGy11TB6CBX3j9E
         vpQoBKJ9I+dEz7KScWDDwv3KP8Gu1qVLtxcTzQAB88V6t+3lHFmVSDp9tsrHcvVSmdm3
         2nZg==
X-Gm-Message-State: AOJu0YyKNjXsKOxB5dtVGqHlGJYWbNLmeOlQv60DGrjPDogqYe+ySmYJ
	7yXuRVyViWVnjqWQF2d+6i7VFN+mGqo93Pw5soSC73J03JWWkbIOm5EXT1dVCckq
X-Gm-Gg: Acq92OEIC7v/bOWxUK3QY+XRey2Y6LS+vDrY7H8ykV1rILNUEm0A9JuCExjQuV50A1P
	Hg5wpkhO2yY0BEWWEzukGMRJd0BPOnugzG8EAIDRk1k9KHvZ8xK4+RJML/xefjUxG1flEWONpZe
	O6FueqWRPxx+B0WvPYLywPcrvy7JdHaGrC4cNKcIVaqY5zKJ2FEDj/h8y/8swHRZyVGNM930t7o
	sljXIToHB4ZW1rIfBJG0tVsqI64xQ0XsZz63GHvOdRqZlz2lvBd/zqzfnypHmazVkRzHyH+P246
	/mt5wZJQMkcPp4sS2WqEtfxD9SRYNQwv2s3kmXogKCNFRgQ0kcyPUBnft+7f2DUvB6kXPnuN9dr
	4ygSmnPCecxiRsedNzMrqoGMtB7Hoxv2HQtc66+gZD4K6G8Z03F31aWzbuYkoey11ijw3yjbe+O
	rN5f8CsXbLr3RNw7etdukVY6GyW6LVXDxUQAwO7X0WlqgK5f9i7UACc2FwV/sdV8oP2gv/KIzTV
	SzfI6B1s2V+56OkrVFonjWu+tiJ+q1RgJSrtA==
X-Received: by 2002:a5d:50ce:0:b0:45e:ebe5:2010 with SMTP id ffacd0b85a97d-45ef6b88099mr224295f8f.33.1780066812833;
        Fri, 29 May 2026 08:00:12 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm4285826f8f.34.2026.05.29.08.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:00:12 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Subject: [PATCH 0/2] bitbake-setup: clarify configuration merging and add a
 notes property
Date: Fri, 29 May 2026 16:59:59 +0200
Message-Id: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO+pGWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNL3aQk3eLUktIC3bz8ktRiXQMzM2NjE8MkAxNzCyWgpoKi1LTMCrC
 B0bG1tQCS5rJ5YAAAAA==
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 15:00:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19563

This series aims to clarify the configurating merging, since it is not
necessarily obvious.

The second patch uses this and adds a "notes" string property that can
be used to populate "conf-notes.txt" when bb-layers is used instead of 
oe-template. For this and the "description" property, it's good to be
aware that strings get concatenated when they occur in nested
configurations.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

---
Ernest Van Hoecke (2):
      bitbake-setup: clarify configuration merging
      bitbake-setup: write notes for generated build configs

 bin/bitbake-setup                                             |  3 ++-
 .../bitbake-user-manual-environment-setup.rst                 | 11 +++++++++++
 lib/bb/tests/setup.py                                         |  4 ++++
 setup-schema/bitbake-setup.schema.json                        |  4 ++++
 4 files changed, 21 insertions(+), 1 deletion(-)
---
base-commit: e9a06f79d9ec767c9d95470be78b006d6fd0d59c
change-id: 20260529-bb-setup-notes-0663341b0478

Best regards,
-- 
Ernest Van Hoecke <ernest.vanhoecke@toradex.com>


