Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8D8C74A44
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 20:31:46 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.6300.1678825906595577828
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Mar 2023 13:31:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=KyLCpI8/;
 spf=pass (domain: gmail.com, ip: 209.85.214.180, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f180.google.com with SMTP id ja10so8222590plb.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678825906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5j5eaAH3eCjqaozMZRLWOSFLJKyCtR7fIpLmwRBTNM=;
        b=KyLCpI8/zdbxuBI+jaKLHjuwP78XrMTW8oLR9rJP/kx9QZe950j55xmQzRFevjsz4y
         UQmxl/YxVT1AbwFpZOIIyK00s3cCGa9Z2SE4d4EOAp75VF/n4BGiAhe4hzRn0OOiEAwc
         lnf43gwRSkTMFr0/h5Pvu65vOa3vBAPMsZCPtue8RCfxhEQgVOGb73PIeno6sLctFMTq
         lmR86mJr1U/n/vP0bPKwis6SbKWP8GWq0zG/n3uM8XA5LUvjpILgecY2b92d1nu3Vh9O
         r9SbhTb81XGscDnSAZs+Vq0Je9Hv60hQR+wL6VmYe+Mrt0qTH4QgiQM+VCQkqvuQepCG
         BEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678825906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5j5eaAH3eCjqaozMZRLWOSFLJKyCtR7fIpLmwRBTNM=;
        b=jTNvZ7nCxHARTYKEQZwxu4tm958szK6iPhgWDUDb/CsrcWomlwbnGcnwxmZ3xb9lH7
         fIi+seRujcXP4/27qGwONezqmlK1k81OaKL2vPTr8DnyssGElE1rlFJ69TlhsQdrijTJ
         ObI9S28YsiqckBT79Wr+I0sZAD5LIIfMWdZiqLQfNIhg/2y4P83JZcPbS1S8vvE55RgQ
         NJ3Ua/ov111Gyh/y8178U+DbUVMu8fjGFnoa8WoFDUgf92qmTPGb3cHVym2oxr6u0O3v
         lSb4C1zH6BpMkC33ouGug9oF1aVnpGsvHJQvQF2Pzq/6TJp4HDchog7stxsuKXWWajQx
         Ojjg==
X-Gm-Message-State: AO0yUKVANs098aMByW1+Pa+jFOFNs70FJ5LNyuAxotb1FOp0X2LKiFO5
	ronSA71FZq+mrqB8fNE5JTKfte6ca+0=
X-Google-Smtp-Source: AK7set/hXHx8AnPOy+wkGymY+EPbFwSylrmwU9uAD9TIuO/kvn68h2eROO0tZ6wjPqsEPp8yb5b0Cw==
X-Received: by 2002:a17:903:24e:b0:19c:fd73:5586 with SMTP id j14-20020a170903024e00b0019cfd735586mr355861plh.38.1678825905658;
        Tue, 14 Mar 2023 13:31:45 -0700 (PDT)
Received: from chiron.. ([2601:1c0:ca00:cea0:155f:ded0:e803:df3c])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902ac8f00b001a076568da9sm215464plr.216.2023.03.14.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:31:45 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: steve@sakoman.com
Subject: [langdale][2.2][PATCH 2/3] toaster: fixtures/gen_fixtures.py: update branches
Date: Tue, 14 Mar 2023 13:31:29 -0700
Message-Id: <7c7f403c00e0f557b0e7c80881d826cf3b60f751.1678825322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1678825322.git.tim.orling@konsulko.com>
References: <cover.1678825322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 20:31:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14558

Re-introduce Dunfell since it is supported until April 2024
Drop Honister and Hardknott as they are both EOL
Add Langdale as it is the latest stable release

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/orm/fixtures/gen_fixtures.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index 0d5f4533b..f0a09be75 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -35,17 +35,18 @@ verbose = False
 # [Codename, Yocto Project Version, Release Date, Current Version, Support Level, Poky Version, BitBake branch]
 current_releases = [
     # Release slot #1
-    ['Kirkstone','3.5','April 2022','','Future - Long Term Support (until Apr. 2024)','27.0','1.54'],
-#    ['Dunfell','3.1','April 2021','3.1.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','23.0','1.46'],
+    ['Kirkstone','4.0','April 2022','4.0.8 (March 2023)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
     # Release slot #2 'local'
     ['HEAD','HEAD','','Local Yocto Project','HEAD','','HEAD'],
     # Release slot #3 'master'
     ['Master','master','','Yocto Project master','master','','master'],
     # Release slot #4
-    ['Honister','3.4','October 2021','3.4.2 (February 2022)','Support for 7 months (until May 2022)','26.0','1.52'],
-#    ['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
+    ['Langdale','4.1','October 2022','4.1.3 (March 2023)','Support for 7 months (until May 2023)','','2.2'],
+#   ['Honister','3.4','October 2021','3.4.2 (February 2022)','Support for 7 months (until May 2022)','26.0','1.52'],
+#   ['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
     # Optional Release slot #4
-    ['Hardknott','3.3','April 2021','3.3.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','25.0','1.50'],
+    ['Dunfell','3.1','April 2021','3.1.23 (February 2023)','Stable - Long Term Support (until Apr. 2024)','23.0','1.46'],
+#   ['Hardknott','3.3','April 2021','3.3.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','25.0','1.50'],
 ]
 
 default_poky_layers = [
-- 
2.34.1


