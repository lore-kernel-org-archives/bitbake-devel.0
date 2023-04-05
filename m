Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCF4C7619A
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 10:16:27 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web10.126294.1680689778521452806
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 03:16:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=UwTFLevB;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
	by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 335AGFed1418417
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 5 Apr 2023 12:16:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1680689775;
	bh=v7vqjdyP7PB8l5PbTQUehk+TW7JweWjdcvjGeVPikd0=; l=1434;
	h=From:To:Cc:Subject:Date;
	b=UwTFLevBWW98zCpXZZkM19mye1vPSCsLSvLVjNBGJJs4fgQyB6/3y7ax+hcPc0wsr
	 YbJsZWyduoTYx1bTmpzyB/L46R4sUQamMHOQKIuriiebYpM/kiI0Cr2VClvfLN8gev
	 YD5QflzvTUo37VUoFFf0VRKJKjkOMz8XJHpFjlep+VF76LJNZAv4jcmmTJ97HeH7Gd
	 vnoG2wjFtcXFxBIIzZiL3gq8gvA6P6rp2Y/yD/3NEbmEB0lelPaHxYw6StFndsDLX7
	 JqavKhtDvM2OA9n707Wb18Gh+akC6ct1qrTTaMB4yjwwOXJlgz3HPGZjvcx9+eZYVb
	 F+jJjaadMPRbg==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 335AGDWf1660900
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 5 Apr 2023 12:16:14 +0200
Received: from mail-msa-3.intern.sigma-chemnitz.de ([192.168.12.73])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id SYCGRKNLBN; Wed, 05 Apr 2023 12:16:13 +0200
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 335AGDgI1373387
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 5 Apr 2023 12:16:13 +0200
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.96)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1pk0BZ-00Dt0L-0k;
	Wed, 05 Apr 2023 12:16:13 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH] fetch:crate: create versioned 'name' entries
Date: Wed,  5 Apr 2023 12:16:09 +0200
Message-Id: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 642d4a6d5038ce378780cae5
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 10:16:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14645

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

It is common for rust packages to depend on different versions of the
same crate.  E.g.

|    crate://crates.io/windows_x86_64_msvc/0.42.2 \
|    crate://crates.io/windows_x86_64_msvc/0.48.0 \

Identification only by the plain crate name makes the sha256sum
ambiguous

| SRC_URI[windows_x86_64_msvc.sha256sum] = "9aec5da331524158c6d1a4ac0ab1541149c0b9505fde06423b02f5ef0106b9f0"
| SRC_URI[windows_x86_64_msvc.sha256sum] = "1a515f5799fe4961cb532f983ce2b23082366b898e52ffbce459c86f67c8378a"

and requires lot of manual work to fix the SRC_URI list.

Making the 'name' property unique by appending the version allows
direct copy & paste of reported sha256sum errors to complete the
crates list.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 lib/bb/fetch2/crate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index 590dc9c12681..a7021e5b367c 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -72,7 +72,7 @@ class Crate(Wget):
         ud.url = "https://%s/%s/%s/download" % (host, name, version)
         ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
         if 'name' not in ud.parm:
-            ud.parm['name'] = name
+            ud.parm['name'] = '%s-%s' % (name, version)
 
         logger.debug2("Fetching %s to %s" % (ud.url, ud.parm['downloadfilename']))
 
-- 
2.39.2


