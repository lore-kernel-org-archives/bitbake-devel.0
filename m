Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EC3CD5BA6
	for <webhook@archiver.kernel.org>; Tue, 19 May 2026 23:34:02 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1023.1779233637596473491
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 May 2026 16:33:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=h0oUUngh;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso41428735e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 May 2026 16:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779233636; x=1779838436; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9K5Wc3n7kDOq1irB5Vwt7p+1ssbOv9noFA13rb9hiqw=;
        b=h0oUUngh9ePKOBj6BAVxs6aX1nEmgjacR4DejqQiEe+Nam1/eizCalqkinqHrah4kb
         29ZIG/iUxSElYr+NSRG5TvPOw1AbzhwebNNmWpzYWS7z4aThmu4mDzEOiFYz2Mi7hweG
         18jaiUS7c9NaQPpGk4X3T6kqKr7SQ4+2bR/Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779233636; x=1779838436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9K5Wc3n7kDOq1irB5Vwt7p+1ssbOv9noFA13rb9hiqw=;
        b=cym2pANC3TG6mdYB56gd/sNjX3MUFmTUSHAvUVKlyZLxW9gM24mMgyxZE8jenAUUR3
         Jp50p6SeoXtSEN1a5HJ9FQB+bB9KOFJXBt/bI4s47C9op3y6ug+bMZ7psWMcn2SURfnM
         EDsQH5SfcwppT0MXDUQP0UnThmP9CkOyvVkeDk6saTPOoZN4PbYIT68ZyaBbEhNJxWCh
         4zPSqSULpwXwMvQVD9RTiUzOG9A/hG3ghBi33pV7SjEQ+pIMRMvCI9G1aNjnJRipWw0N
         6MlUFa3iaGGZnM6VHp3A2cu9rgxowpXLM1toANEHgX8QFvbL6m3LQnF9xBAiHJ0NM2j7
         VV+g==
X-Gm-Message-State: AOJu0Yw3wm/0Fy3g7rsNKyDITcBV9rIgQVim2RyqOwdT/5tOWAklb4Fy
	XcjZS4Zy1VmxLD6EZoDsCqzVVGzwgZlt1ZDW9kjXNa9duqEt8Xw6UdM10hW+FG5uGuGJ1B02XBG
	j4/t3
X-Gm-Gg: Acq92OHvuM4yrQltVy5GvkDL4OchkKc/X2b0VbDQpgV6xxctKagwSZRGGMAj52QxBc7
	EtGAl/aDv9HGu2xioZCJQqlTPIlEBk92p8ijFrsXCXyps1D4iQjuFTCpV8lCTct9H5N752IcbWz
	kOJDHFGcErU2lb+rWIIUI8V5nX+saqOuhtFaIxOabvxc8aW80WLAVNZNZbPmvILq7KJvU1iofzN
	QgQeHUQ+ViMojbuAksOojb5psQ+qU6DxXaJYMPUMoRfDxTNz53vcNYmyXI0srZMxNW7lxPucZzn
	kHCdXOIS9NEKkazbIC0dYRaa77Kt8/AJuUqUqRh8Phdq9wCxQEuHlXEirz+p49j80uScNQtu8eE
	L3wgrsweP8sTV8uTlG5jdYyE2o00TRyiua9IkuMkrjPWlz+MfDpD/lwefldK6UOIPLjPKWIZ/8p
	0eWQCc7zjsTcG08YRFwCMdGvwi6RoqPopH2eGQtfplrMVZXlv8dGnM6Visj2egvOzSAsbmyQY9h
	F57XCtXFW/rYjgNyPse5cJGkAU=
X-Received: by 2002:a05:600c:3487:b0:48e:7f22:d90 with SMTP id 5b1f17b1804b1-49017d45a80mr137855725e9.4.1779233636029;
        Tue, 19 May 2026 16:33:56 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm349517665e9.4.2026.05.19.16.33.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:33:55 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 3/3] README: Add "2.18" subject-prefix to git-send-email suggestion
Date: Wed, 20 May 2026 01:33:46 +0200
Message-ID: <22021758e66737bcf68dfd2b74adc6a0cb1d42d9.1779233514.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779233514.git.yoann.congal@smile.fr>
References: <cover.1779233514.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 May 2026 23:34:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19546

From: Yoann Congal <yoann.congal@smile.fr>

That might help new users send correct first stable patches.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index e9f4c858e..0701dbbe2 100644
--- a/README
+++ b/README
@@ -24,12 +24,12 @@ for full details on how to submit changes.
 As a quick guide, patches should be sent to bitbake-devel@lists.openembedded.org
 The git command to do that would be:
 
-    git send-email -M -1 --to bitbake-devel@lists.openembedded.org
+    git send-email -M -1 --to bitbake-devel@lists.openembedded.org --subject-prefix="2.18][PATCH
 
 If you're sending a patch related to the BitBake manual, make sure you copy
 the Yocto Project documentation mailing list:
 
-    git send-email -M -1 --to bitbake-devel@lists.openembedded.org --cc docs@lists.yoctoproject.org
+    git send-email -M -1 --to bitbake-devel@lists.openembedded.org --cc docs@lists.yoctoproject.org --subject-prefix="2.18][PATCH
 
 Mailing list:
 

