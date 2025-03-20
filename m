Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D70C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 16:55:00 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.12926.1742489692275684018
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Mar 2025 09:54:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ANd9XcUN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-391342fc0b5so906072f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742489690; x=1743094490; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MtFOGxsIiD9Dx85x/b4Bb1mU4uRjPJ8dBHz0aRrQY3I=;
        b=ANd9XcUNg3b96QoBSCKBjS21SUHyP40+dW8VwZwb37tF1K2u84Veb7OTQRqdbtUIh5
         N+pMcW1ULi9KBbmcL3mwwZ/iO7spCJyJ7TmMRIJ8r42ZnM4k4N7qPn3PCslJV8bvRBdf
         9frvMN7/FTPXRTowwhHh+ov048ovrB5TGEDps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742489690; x=1743094490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtFOGxsIiD9Dx85x/b4Bb1mU4uRjPJ8dBHz0aRrQY3I=;
        b=uLXlCDdGxh+8WIX5dfvcXglWAYV6Y9PsVmVteFiDYGSBzuCrM90TQQNDcQHdi7YuaR
         gMJoLVrR7kgezvAFJ9jw8tKSVOJMs0TbYe9KXtvw73grcr6YMmd8jc51PEttTlSSYW1t
         LPYP9cfn19BgPAbPbfcoAY4AkF6PnU4aUHnlNtd0Ftwx8Gt9aXBK0CESjdyPuzY8o7Xj
         vXamPN2D2xWsdVaQGgXamJK9CUZaSqXJHJAY2tXkWzSw5vD379MUTuf095+sX236qwn6
         lrqIfxnWJAvyLnq5B9RMbzR+HKCLOFW48gvIMHIEDRg95ueY++LfVTTbx4cBbC0b2JnF
         nEYw==
X-Gm-Message-State: AOJu0YzO7GChVcnvQn4ILggPtEUqp2PbuXd8DfArV+4mn6ZnJpgw4Ki4
	d0I2LqOj9aV2W8Om09Q8gavha75f1uKfUWPaV3R2Ny0Eke6PbLoInR59rdNpqXBUKiPpS1ywhkk
	l
X-Gm-Gg: ASbGnctz5+Ld2Jifr7PeZfx3i7svSWKgvnJkrr4sFmjsSjWVdm/4Q5pNeuA11+G/scb
	/+b2zkq5HvqvC+CrCMqvAowqNtMLOmGH1jyUUumuzbctvnIut1Y5CRcnzvbfFtvzNdsDKYzWFbx
	HW1LveDgIULoLSrq3t5XvJr9kGGSrem2nFoW+qJJDIN4RpKULmWg9cZ0putykmo/76LqL0aHUvH
	RUSDzW5OwEJmzWA9yM9K4A7LXobhlLNTvSIPj8dTqvsLsMu9dw6CzsmwkHuCm9dsNthkXLwqFWm
	mZnvHA6QSeKAXxAcBMlq5U+ZoqhyuHiPcfNzxQ2vSa4/XJxDjNy2ucQo3AfpIcR/v1ZCGRsg243
	br9erI7tm
X-Google-Smtp-Source: AGHT+IHdzEQENw0HVuBL+RSFBBYrQGFbKkifq/JvIrNsxKFh7cy/l8JIUKJBLhwizZkCsylYNE6BOg==
X-Received: by 2002:a05:6000:1fa4:b0:391:952:c730 with SMTP id ffacd0b85a97d-3997f8f8c1fmr191354f8f.11.1742489690036;
        Thu, 20 Mar 2025 09:54:50 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ede9:63ed:996d:ca84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9957cesm109291f8f.4.2025.03.20.09.54.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:54:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] Revert "bblayers/query: Fix using "removeprefix" string method"
Date: Thu, 20 Mar 2025 16:54:48 +0000
Message-ID: <20250320165448.977193-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 16:55:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17481

This reverts commit 004cfdec1c865f2351bbac99acb3d63bfef9d380.

Now we have python 3.9 as a minimum we can do this.
---
 lib/bblayers/query.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index 9b2e081cfd..eb7cb465b4 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -145,8 +145,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
         skiplist = list(self.tinfoil.cooker.skiplist_by_mc[mc].keys())
 
         if mc:
-            mcspec = f'mc:{mc}:'
-            skiplist = [s[len(mcspec):] if s.startswith(mcspec) else s for s in skiplist]
+            skiplist = [s.removeprefix(f'mc:{mc}:') for s in skiplist]
 
         for fn in skiplist:
             recipe_parts = os.path.splitext(os.path.basename(fn))[0].split('_')

