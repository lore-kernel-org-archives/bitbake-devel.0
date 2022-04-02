Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECE8C636FD
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:46 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.9692.1648887315085767695
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Apr 2022 01:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EvfL6XVi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id
 m67-20020a1ca346000000b0038e6a1b218aso221903wme.2
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Apr 2022 01:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=362KOpTFDMmRiPsNMCGrH25RehV/7miKSBWP3lo1b4s=;
        b=EvfL6XViJ7+8PGH7QKIavbUW5jMmbS7HKPPKbJtNbUEStzpuf4VseC38SkqjizPA8J
         OhpExvYr1sbszx2RJNqSttMvJZ27w3x/rxTUSgVbAfrv29spTlIsSv7yY2cJl6fnUld1
         lxHaHsHh2DluZ4P3Ce824scJktprK7psL/FHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=362KOpTFDMmRiPsNMCGrH25RehV/7miKSBWP3lo1b4s=;
        b=OONsyjC30dhI9JLWusid+v87Bn8WnIlH07XSDuD2iDIhiBfJfqzp6YXctmAbrI+eKu
         iwvui37lj51Tj47CGEMExZiP/sYyOzT+oG+QgDQcK5aA+OTVQyGqqFmQf4Y86vwkWjhB
         OY3pkURVomw0QDGFemJKYUfVSyKOuSJfg2lz2G+bpUE/sFMMufK20AaRVDPfbwhMUw0n
         /7vdtgk7E17n7qLPWGNAH3OsqByPg3rfVIvPz2gcTMPzpLhWI2kBTYwaLE9u6/sZXVHt
         V7Ku2pnhISjxNttTCPsf9I+Rs3I6yktgtlfDAlhEirW2vsrpPBzXCZp6iI1txYu6Wu0b
         traA==
X-Gm-Message-State: AOAM533Q0fn8hGldJbABjmU2+yWOlcmnc77bL9uNRtixftbpVyn1G4ym
	dhC5dyHGJbTmYBr688fuqAR8ChPzjHKQnkej
X-Google-Smtp-Source: 
 ABdhPJxbNKJ2zx/VATP0X+ElNJivaVZ2/n9RvUkiSvMTaQbud5R8t9mongxFATb1IdBfo91EdbiWqA==
X-Received: by 2002:a05:600c:2188:b0:38c:9a21:9c95 with SMTP id
 e8-20020a05600c218800b0038c9a219c95mr11328014wme.87.1648887313064;
        Sat, 02 Apr 2022 01:15:13 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:c5e1:7b92:5e42:dfdc])
        by smtp.gmail.com with ESMTPSA id
 az19-20020a05600c601300b0038cadf3aa69sm17505071wmb.36.2022.04.02.01.15.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:15:12 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] parse: Ensure any existing siggen is closed down first
Date: Sat,  2 Apr 2022 09:15:11 +0100
Message-Id: <20220402081511.1642907-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13567

We're still seeing issues with unclosed asyncio event loops. At the
init site, make sure any existing one is closed first to try and avoid
this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index c01807ba87..347609513b 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -113,6 +113,8 @@ def init(fn, data):
             return h['init'](data)
 
 def init_parser(d):
+    if hasattr(bb.parse, "siggen"):
+        bb.parse.siggen.exit()
     bb.parse.siggen = bb.siggen.init(d)
 
 def resolve_file(fn, d):
-- 
2.32.0


