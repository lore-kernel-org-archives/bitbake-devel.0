Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2E2CF34C4
	for <webhook@archiver.kernel.org>; Sat,  5 Oct 2024 13:45:08 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web11.11807.1728135901114852173
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 05 Oct 2024 06:45:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=IejxgbNQ;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.178, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so2744963a12.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 05 Oct 2024 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1728135900; x=1728740700; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcXh5BpwvASJQJ4wEn0Jo/vEfqE2uuxFa7SwAZZK89g=;
        b=IejxgbNQJRvPH2A0Gkkw6lbe/EBRhH/CfTbZ8ytXhEy/F2zjbWEP+SMAYCUGY2vSsp
         j0f8t+rXY9VwjDLV6Glmh/cajZ/StwaPBSxGEUQSdh/SXLaO7EjutzDFsCFfGE9+mTBL
         2EcxLfUIzqDploRMStXvhOtbAOsbn285naWROTS0xqvl9d10Oa0/XVd+UApl0A6X6fU3
         TCjoV2nOITdhxRe2rPy+1Tpxow6I+UJdOPu5iyGqs2L8N24B3zmlpNxfjjgnW81nEjM+
         Jk5/yOL2aeaA7A5ppm4D/jfFSf1X0WiF0RO/+GJktFqD7EFWEgAHbeGbteKRuHbqyKaM
         iYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135900; x=1728740700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcXh5BpwvASJQJ4wEn0Jo/vEfqE2uuxFa7SwAZZK89g=;
        b=ldMSt6jTGN2EF0iRqdOslawzqf5mkn6GsR8VDimm152ldTro+nf7UAWKeW7ap3znMU
         11QCSO/VapFS53dmfcIAg+Hwi6bKF8+y3+CY4ifmM48Rl8ayYVmSXz6lkY4Rgal8FO4+
         8vTogFxm1oflo5+QAjDUpIBF+KliA2pnV38/JqkkcSsSJ1O0GjB4tWObFZu3QasrCa2r
         1lU5sR/MV2onfy1D7EkswcAsmQoiyNm4dqadtzDBCazvgXzeEcbn5Ewz4GgonZxKzKfb
         5UoPG/S+5V6j3852W2aZfnzNyPuDaaBEzTUU9F86XhynrMG4Ixn9kNLYNAjiI9Eyo/Wh
         2CCw==
X-Gm-Message-State: AOJu0Yxtpj5RWuouQHLsBnim5Oqgr3fuRn4IzYDPKsDfuIzuEVziie1P
	N+Nasaz2VKXs4si9CJ6NK2lZqZYjWZgg7Nbh67CjBFMLGp9GDknErm2d28/BZrqZNYM9R8GwQd2
	DIvg=
X-Google-Smtp-Source: AGHT+IGWCUdXjfzIuBI41BQvcj6OXU8JLNUZGUTBCWLpC17KE89nJLV+p3VsNLtSwAtfv1clWX26zA==
X-Received: by 2002:a17:90a:3ea5:b0:2da:88b3:cff8 with SMTP id 98e67ed59e1d1-2e1e5b49169mr9471495a91.6.1728135900313;
        Sat, 05 Oct 2024 06:45:00 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f919csm1831617a91.44.2024.10.05.06.44.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 06:45:00 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/4] wget: Make wget --passive-ftp option conditional on ftp/ftps
Date: Sat,  5 Oct 2024 06:44:48 -0700
Message-Id: <477f90f9515cb7cd093920cee5518f662cef2e05.1728135724.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728135724.git.steve@sakoman.com>
References: <cover.1728135724.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 05 Oct 2024 13:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16641

From: Rob Woolley <rob.woolley@windriver.com>

Fedora 40 introduces wget2 as a drop-in replacement for wget.  This
rewrite does not currently have support for FTP.  This causes
the wget fetcher to fail complaining about an unrecognized option.

Making --passive-ftp conditional based on the protocol used in
the SRC_URI limits the scope of the problem.  It also gives us
an opportunity to build the older wget as a host tool.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f10e630fd7561746d835a4378e8777e78f56e44a)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/wget.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index b3a3de571..9bcb0d4b7 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -88,7 +88,10 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile = d.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."))
 
-        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30 --passive-ftp"
+        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30"
+
+        if ud.type == 'ftp' or ud.type == 'ftps':
+            self.basecmd += " --passive-ftp"
 
         if not self.check_certs(d):
             self.basecmd += " --no-check-certificate"
-- 
2.34.1


