Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA72CCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 11:48:55 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11620.1762948134949565707
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 03:48:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=h+C2Piyf;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-2.intern.sigma-chemnitz.de (8.18.1/8.18.1) with ESMTPS id 5ACBmrgr453489
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 12:48:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1762948133;
	bh=ZlJZtI13K6b2rb2OV0QHY8+/RTKdy7BT/LoXAPrpmTM=; l=1159;
	h=From:To:Cc:Subject:Date;
	b=h+C2PiyfTSXLPSPGEzvy9PYrbBPbIT1KmS38NfzkrHoPkWaT+j/b+GvobidD0iyH6
	 jYNLZqRsm1lluZkZtehQ2mg11cQqtpEI/OdNqSqtiiJkeZLi5U/kkJNdy3T1ApSJ9p
	 /vRDjeJtYzVlXj5mZ+VMfVC5zTU2FGLObk/eCQBF+VyfBi52FVNGxbb6mmJPGsr4Ws
	 K7NLfQNkAKaVs8TTN2Cn38qLTl70j1gsWcsItx4CtTa6cMVlY3f9dx4j4yJy7XuAtL
	 tDGpQXHG6tmDjDwRqSXdZsFCVWNSaffJlQapnmKlpA5RMnLEn9FhARSlUFfP4n+ruQ
	 bX+leCfC3Wcdw==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.18.1/8.18.1) with ESMTP id 5ACBmpwe4019398
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 12 Nov 2025 12:48:51 +0100
Received: from mail-msa-2.intern.sigma-chemnitz.de ([192.168.12.72])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id FRXCSN76I2; Wed, 12 Nov 2025 12:48:50 +0100
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.18.1/8.18.1) with ESMTPS id 5ACBmoa7440582
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 12 Nov 2025 12:48:50 +0100
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.98.2)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1vJ9LG-00000000DxU-3EF7;
	Wed, 12 Nov 2025 12:48:50 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH] knotty: fix TIOCGWINSZ call for Python 3.14 and later
Date: Wed, 12 Nov 2025 12:48:47 +0100
Message-ID: <20251112114847.53576-1-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 69147422f95b4083a919bb62
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 11:48:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18351

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

Python 3.14 enforces stricter type and size checking for fcntl.ioctl()
buffer arguments. The previous code passed a short 4-byte string ('1234')
to TIOCGWINSZ, which worked by accident in older Python versions but causes
a SystemError ("buffer overflow") in 3.14.

TIOCGWINSZ expects an 8-byte (4x 16-bit) buffer corresponding to
(rows, cols, xpix, ypix). Use an 8-byte bytes literal instead and unpack
the first two values.

Tested with Python 3.11, 3.13, and 3.14.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 00258c80f..66b2146c5 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -143,7 +143,7 @@ class TerminalFilter(object):
     def getTerminalColumns(self):
         def ioctl_GWINSZ(fd):
             try:
-                cr = struct.unpack('hh', fcntl.ioctl(fd, self.termios.TIOCGWINSZ, '1234'))
+                cr = struct.unpack('hhhh', fcntl.ioctl(fd, self.termios.TIOCGWINSZ, b'12345678'))[0:2]
             except:
                 return None
             return cr
-- 
2.51.1


