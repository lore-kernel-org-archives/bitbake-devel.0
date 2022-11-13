Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE361C43217
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 23:30:26 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web08.54.1668382217661999216
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Nov 2022 15:30:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lk/hRgNT;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id w23so2172501ply.12
        for <bitbake-devel@lists.openembedded.org>; Sun, 13 Nov 2022 15:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8JcbiDT1IQ/vPSHwRfQHJ8e2nnUxl7SIIYuxAyJWXg=;
        b=lk/hRgNT9nQ2CBCvLm/v4AKMb7Se5pO5qJ/sNcGHF4aDolnKfEjKDbNcaWJvxn5XOW
         SneujSX/9RqylpGm2r3+RHy2dZATwpWhvYHSVAMglEK2Yt/iEVq2P4ZUYqKIma6fsA43
         LJtuEu7qUTErJmvWiD29kILPKlKXo5bMzzatmgU6cRqdyoKB7+qURcHFL0tWED2SNDma
         mtKRRQxISnaA3u77ahcVwZYYCYdxvsIr/B8TnjS3c0rrPkJ5/lKB0HMRJbSkyyTrkO9Z
         Utww8NvMqLeLT6oz5l9pzHVrYsQM2P1GECW7GDtGzTNKgC1pMCHZY2SgVsw7tatNXV1E
         lTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8JcbiDT1IQ/vPSHwRfQHJ8e2nnUxl7SIIYuxAyJWXg=;
        b=omeQpxDKk6e33eKX4K9IiI6zFYeC8Cn/2w5kgils1kq7WOC49yZHFAY4upxxYzYKnk
         OPHwfpbP3mpyWsJko76poa2RRizMzhq6N1vWcJ6I/1NWzmpkepcsfg+babXC8YHkhgLG
         vJEfGTgcNNr6RLO+ssPXcNdWwxGiql7GCUi/GkbmIXO7+jZ1tT/4PYcQ3bPGuX/9vz6e
         6tcxuxVthNFXnBx2mRNffEkWIDzZFPbfqnfxqtw0nL9/Lyt4LTivQeIOz6new5V3bJ2U
         k7asEbHvTpaOhyGEdAkeORYy2e+NbW4MF4w3X0t+QgHo7d9Rz3v53qG1kPyKE9bcWW3S
         alBQ==
X-Gm-Message-State: ANoB5plDJ/WKWcG8yS+pRazE/IGYAF9URBVLuQA5RG8PuW5cf9y+0UdR
	EyAGxaKUnoTvhLKOF7aTRDgNu5kZATv1HA==
X-Google-Smtp-Source: AA0mqf46Jj5vY92+Fo01orqIpzGt+DERf8mFzBocW6R+5Dw5ZqOC9bW0Qccej44SLEqoEnJA1tN0Tw==
X-Received: by 2002:a17:902:9304:b0:185:3f7a:50cc with SMTP id bc4-20020a170902930400b001853f7a50ccmr11309268plb.99.1668382216522;
        Sun, 13 Nov 2022 15:30:16 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:4998:ee9c:6c85:68ed])
        by smtp.gmail.com with ESMTPSA id c129-20020a621c87000000b00561b3ee73f6sm5404438pfc.144.2022.11.13.15.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 15:30:16 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [PATCH 2/3] toaster: fixtures/gen_fixtures.py: update branches
Date: Sun, 13 Nov 2022 15:30:02 -0800
Message-Id: <3c0a7a853a9c1788b8d3f1b738ee63e8a8872b62.1668381699.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1668381699.git.tim.orling@konsulko.com>
References: <cover.1668381699.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 13 Nov 2022 23:30:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14079

Drop Honister and Hardknott as they are both EOL
Add Langdale as it is the latest stable release
Add comment about Dunfell (currently crashing)

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/orm/fixtures/gen_fixtures.py | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index 0d5f4533b..ad20d6bdd 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -35,17 +35,26 @@ verbose = False
 # [Codename, Yocto Project Version, Release Date, Current Version, Support Level, Poky Version, BitBake branch]
 current_releases = [
     # Release slot #1
-    ['Kirkstone','3.5','April 2022','','Future - Long Term Support (until Apr. 2024)','27.0','1.54'],
-#    ['Dunfell','3.1','April 2021','3.1.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','23.0','1.46'],
+    ['Kirkstone','4.0','April 2022','4.0.5 (October 2022)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
     # Release slot #2 'local'
     ['HEAD','HEAD','','Local Yocto Project','HEAD','','HEAD'],
     # Release slot #3 'master'
     ['Master','master','','Yocto Project master','master','','master'],
     # Release slot #4
-    ['Honister','3.4','October 2021','3.4.2 (February 2022)','Support for 7 months (until May 2022)','26.0','1.52'],
-#    ['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
+    ['Langdale','4.1','October 2022','4.1.1 (November 2022)','Support for 7 months (until May 2023)','','2.2'],
+#   ['Honister','3.4','October 2021','3.4.2 (February 2022)','Support for 7 months (until May 2022)','26.0','1.52'],
+#   ['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
     # Optional Release slot #4
-    ['Hardknott','3.3','April 2021','3.3.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','25.0','1.50'],
+    # 'dunfell' seems to have a bug:
+    # Bitbake crash
+    # Traceback (most recent call last):
+    # File "/home/usersetup/poky/bitbake/lib/bb/ui/toasterui.py", line 337, in main
+    #   buildinfohelper.update_and_store_task(event)
+    #   File "/home/usersetup/poky/bitbake/lib/bb/ui/buildinfohelper.py", line 1267, in update_and_store_task
+    #   assert identifier in self.internal_state['taskdata']
+    #   AssertionError
+#   ['Dunfell','3.1','April 2021','3.1.20 (October 2022)','Stable - Long Term Support (until Apr. 2024)','23.0','1.46'],
+#   ['Hardknott','3.3','April 2021','3.3.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','25.0','1.50'],
 ]
 
 default_poky_layers = [
-- 
2.34.1


