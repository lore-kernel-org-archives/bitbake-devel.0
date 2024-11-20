Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28351D743DA
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 21:32:27 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.26.1732138337175767615
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Nov 2024 13:32:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eZ+Slm8P;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3823e45339bso142180f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 13:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732138335; x=1732743135; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=11ato+NutFdB/QXJ9RGwV2usvYU23qmnf8m0AVj75Wk=;
        b=eZ+Slm8PceMgErA0/NOReuHPiZJuQgoIlo3Nz3FWo79W8jE9gNzhRtRAS/FhehEqzr
         s3B5iKWE76D9dGKhFDbHXjk3B4G31Vr8LAuLF4TjaGXeETyeCZGMoYyaddFfFIsOnJTZ
         pb8w+WzulHl4lhjJrF1tWCbesTg1/XdUE8C3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138335; x=1732743135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11ato+NutFdB/QXJ9RGwV2usvYU23qmnf8m0AVj75Wk=;
        b=pRyrTEcZ3k0gZFegGb3+h3bCyImLPcjo/aq82LJ/ufpDl0/N2n84xB2NETpZgm3KFQ
         z8JHaOg5b5BTXQlbzAzJw0il0BQDld230KVu6ImOun+S6FuFQbiQkob2NhdV6H5T/gLw
         JDYIRosbaJTjjXfUKZqL8VnoDbl0V5VvkM9+nrd6kSmLOveVD5ygdRaLcV4hdRTuji7J
         kLtpDpvSODsJObeWWTXMAI/R4k3EeTC0FMNbrqdYvpb3pQMHt0Y5cM35hXB6U28xGGNn
         Qk2CxZRH8I1XQR81fRzK7Lcf8drfc1lN4rkZd2bGuUcvWfze5Og6BvXuXkuWVMniQhAP
         kuZQ==
X-Gm-Message-State: AOJu0YzPtgvD0Zs1CsNNbyn85ok9sPBgK1am9m+JzsZIGxHDTGI8c/rF
	PamiUuII4FNVfc/V13aXIC2OkKbphieliPOTnJPmpvY5OwaR3ucpJjAv4QDIRVP8o1X7rHbaVkI
	yES0=
X-Gm-Gg: ASbGnctWKODY/5sPs48jSMu/FyKUDpUszxn+FtFja8sES/DssTCttvDMSC0n3jRV9li
	Qc4WGIXObC7NwJRGsw+Z0Kd+oGavKDGNm4KyqMceVyMbwnFw2k0FozrlhHKprv2R39k6UY7yDVO
	Qm96Upt6FSh6Gqgvu8r8lAoxGwaFNJTXT63EqKoXIi+B96szPUcE3YsrGqMKohb07qO6gWegR63
	vrbqs4LrJLW/VqgdUwikDYl8CFLw4y0chfmTDUdtx4o3Y84d/693krtiK14KZLLXo6G5VyHQ57t
	xg4=
X-Google-Smtp-Source: AGHT+IFqc6hZylN8x64s5vDqAnSDN49WJCvSFBSVAlY0g3VdfMWQqd/KayEYwXLx5PApWz9fC0yJqQ==
X-Received: by 2002:a05:6000:2801:b0:382:2f62:bd45 with SMTP id ffacd0b85a97d-38254afa5c3mr2573404f8f.29.1732138334878;
        Wed, 20 Nov 2024 13:32:14 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5abf:50dd:d6fd:8415])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549107f9sm3064319f8f.51.2024.11.20.13.32.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:32:14 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/wget: Increase timeout to 100s from 30s
Date: Wed, 20 Nov 2024 21:32:13 +0000
Message-ID: <20241120213213.2481909-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 21:32:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16821

Testing shows the worst case CDN response time can be up to 100s. The wget fetcher
is used for accessing sstate from the CDN so increase our timeouts there to match
our worst case repsonse times.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 7856d10fa4..773d41ca81 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -82,7 +82,7 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile = d.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."))
 
-        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30"
+        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 100"
 
         if ud.type == 'ftp' or ud.type == 'ftps':
             self.basecmd += " --passive-ftp"
@@ -371,7 +371,7 @@ class Wget(FetchMethod):
                 except (FileNotFoundError, netrc.NetrcParseError):
                     pass
 
-                with opener.open(r, timeout=30) as response:
+                with opener.open(r, timeout=100) as response:
                     pass
             except (urllib.error.URLError, ConnectionResetError, TimeoutError) as e:
                 if try_again:

