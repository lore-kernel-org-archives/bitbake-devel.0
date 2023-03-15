Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E480AC7618A
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 01:33:41 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.2024.1678844014556679441
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Mar 2023 18:33:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=R8vaJJdO;
 spf=pass (domain: gmail.com, ip: 209.85.210.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f174.google.com with SMTP id ay18so10855788pfb.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 18:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678844014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtFkEngGD6XHPAAJOyERVHg8tLZ1P0Ys/zpCRpjR0GQ=;
        b=R8vaJJdOCcy0t0aWaz/diclpBwEqjLLGFYxIl2gTcyid5JB8O5LCCtxm7f1NLnGVLd
         ovNR4AoSwYcrMjspl2lIWCsLy5gJjNQOw5NXbzsOQtAmmTfAGTTkopNyF2t2PCtDfiHc
         zh4240zYm7SrN90jh77tKqGBSqHLBjkteEgLS1jQLjIg/3OYHDbH8CZHEE0q5FPOzncA
         bJ7zdW7g+Apr0XeKKBCNCKKcDNyDwlXND4PrlLc+nKiTOO1mF6ezVaskYr1KeocuW4tw
         KGFvDlPPNsBFx1kvz4AUJ0ebF87tf1me7n3hTYF8g6eA4hxr2jiGyJ4ad1cCZ6KxfUCH
         QXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678844014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtFkEngGD6XHPAAJOyERVHg8tLZ1P0Ys/zpCRpjR0GQ=;
        b=M7aeaJqUG4f2Q50XE8MwzTMjWwnRaSk/WeHKEMTmsLknmA0SAPmQ6XW0LB/64xwBfs
         53Fw0B86d5EHGjDQC7cZwDyX6TrHg29O6NUSu71jAyvfDPoqeP5Uo1mK/2YtWVTLgK38
         Wykuudb/xvTNqgs6bYMEFLltE/4+HTHzRNUU2yzHpA+vwx+4OhBdXqr7k/TkcvJw6T73
         J1QBxW9biZUNJoVPh/JIEMTKTITgl0HltPVKWGnktDpvYtu0dML6PLIw30ZV1V3SrsmN
         PGBD6t3u442Zt4vGfDfFSenEbAjsoge9PwqcALCvsQ3U2c4VP7jm07M+n9VQ6gRrZ6yg
         yBmg==
X-Gm-Message-State: AO0yUKXu5nGb8Ea7sIum5W3ZH5vG0qoeC+UhdXKmiWsENX1RWoocepLH
	pulPvLmpMQ3KrOsqmmzIj4J/T4Bo7lU=
X-Google-Smtp-Source: AK7set9IX4hcrXYlrXOk3BBruR1AnOwFg3SuRSDr8LTFrDj8g/DDcvbn24C5grttEQXCxGbnD3GfDw==
X-Received: by 2002:a62:1dd2:0:b0:625:6677:838a with SMTP id d201-20020a621dd2000000b006256677838amr3354830pfd.11.1678844013595;
        Tue, 14 Mar 2023 18:33:33 -0700 (PDT)
Received: from chiron.. ([2601:1c0:ca00:cea0:155f:ded0:e803:df3c])
        by smtp.gmail.com with ESMTPSA id t21-20020a62ea15000000b00571cdbd0771sm397745pfh.102.2023.03.14.18.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 18:33:33 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [mickledore][2.4][PATCH 1/2] toaster: update gen_fixtures.py for mickledore
Date: Tue, 14 Mar 2023 18:33:05 -0700
Message-Id: <a5bb47260f713344df360307ee713be846487310.1678843397.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1678843397.git.tim.orling@konsulko.com>
References: <cover.1678843397.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 01:33:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14561

Update for 'mickledore' 4.2.0 release and bitbake 2.4 branching.
Drop 'langdale' as support will be ending soon.
Update stable branches to latest patch release.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/orm/fixtures/gen_fixtures.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index 69f557657..71afe3914 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -35,18 +35,19 @@ verbose = False
 # [Codename, Yocto Project Version, Release Date, Current Version, Support Level, Poky Version, BitBake branch]
 current_releases = [
     # Release slot #1
-    ['Kirkstone','4.0','April 2022','4.0.6 (December 2022)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
+    ['Kirkstone','4.0','April 2022','4.0.8 (March 2023)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
     # Release slot #2 'local'
     ['HEAD','HEAD','','Local Yocto Project','HEAD','','HEAD'],
     # Release slot #3 'master'
     ['Master','master','','Yocto Project master','master','','master'],
     # Release slot #4
-    ['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for 7 months (until May 2023)','','2.2'],
+    ['Mickledore','4.2','April 2023','4.2.0 (April 2023)','Support for 7 months (until October 2023)','','2.4'],
+#   ['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for 7 months (until May 2023)','','2.2'],
 #   ['Honister','3.4','October 2021','3.4.2 (February 2022)','Support for 7 months (until May 2022)','26.0','1.52'],
 #   ['Hardknott','3.3','April 2021','3.3.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','25.0','1.50'],
 #   ['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
     # Optional Release slot #5
-    ['Dunfell','3.1','April 2020','3.1.22 (January 2023)','Stable - Long Term Support (until Apr. 2024)','23.0','1.46'],
+    ['Dunfell','3.1','April 2020','3.1.23 (February 2023)','Stable - Long Term Support (until Apr. 2024)','23.0','1.46'],
 ]
 
 default_poky_layers = [
-- 
2.34.1


