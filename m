Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A5E7E0A7
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 09:33:17 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44031.1770629593910734293
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Feb 2026 01:33:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=W90GNDyk;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4807068eacbso37550305e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 01:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770629592; x=1771234392; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtxR5Z+70VIP+f84g611Q9sD1nlr1qPIJEXqoYxmxz8=;
        b=W90GNDyk7nL7ZMeX9rbbFBzA21shYLHfQKrjCRVisTIwnggfU4YtDb56eGlzbcTgkM
         1Vx1C8A2JXQVV4vRSLbA4r0N+O3SPYWOOsllgl8Xvf2w4y4MzdgVm0IgQc7Cbqx5VLog
         YPt9CpML859M00Tbdb6OswpWLnKrL0jMMazVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770629592; x=1771234392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DtxR5Z+70VIP+f84g611Q9sD1nlr1qPIJEXqoYxmxz8=;
        b=eC0ev1QH+qgEUMOw+3tyAsgqyj7ri0elPWP1KnCR5ShluqFee8OLNwLh1GVLVIIRaD
         O4huadWY/94k58e9kN/aGSmq8NhH83leuCb4qxEdfM01XhdZyY4qhSQQKmI7TAN6/hfg
         B4dAXDlTIHTBOZtQWCOpopWmy2+wzBGfIsXN/Ll9rg88vjhOVnbhnLVxJ2lv573Tgjhn
         a/4tQVkHe7VoDCMc22KNqSj99oufDMUvx1R4wwqi3HnRFZL+b25gIrC8vxUl0IylXDHc
         Cw2Dq8NNcysgSzBEYcqaWEIS03TPOn3a6RjFFtQapU6lJr+tRP2toE8VNFZqxwD5tB/y
         yQXg==
X-Gm-Message-State: AOJu0Yyatz8kfg5Z/U5ez5h4vfmoxsoxZIm0zT4QorFJtNRL3FYSjjYx
	87aZaQ5m6q51vIQV6Kr8QxjC60CC2yo2uEGmZAhn3VA9D4uwVFC74WABWcC3q+gLjDoFQCofdFL
	fFC6qieg=
X-Gm-Gg: AZuq6aLQKm2efcwi+mKMwNXmDKAStZeBCH6jy42OYtmkoIhypp9vAJtt4w9jreAwnJT
	Ys+am64fdTa6y8/73xeC9+TEB3Gq3b7ZpPQZDB7pPKM/sTd7hqebTal1Nxox8OrmBusOYRX64tS
	WFKhy+Do20zGDZ8WfjM1ix8UGKp4HmLCr1KFoXeP3QX+EdomCA/OrwhE19zps5PmMguIHrPPEBl
	F5l1zoJveIliUPKKeVi2P6fVLnBjZ1yy8f7j712Zxg8uw16yk3pVnGnE1gatQI0jMJgpk3cylFq
	IYp2PwBZ5FUZC5bjpoyx3g2G7kJmfr/mPFBu5GXF7S5sczBb5vidxcf7Rqdbm4mYNTCBZf9Ine4
	6cYezJKnx5GtSB24zC1/uw6oiBKoJhxyzqtATuANw9CK/wfaAbXoZxlNGCGOs9F+dg23PBHVG5n
	GwcmT0BaM67lEiaTJLbs57uTz8Lxr+5ITBFQXgRLiIdPLnJnJKtLBwUA1uHVi0Sy8Etk4RX8HOq
	zLvzlRkCdwAM4o=
X-Received: by 2002:a05:600c:c16d:b0:480:4a90:1b00 with SMTP id 5b1f17b1804b1-4832021605bmr126371425e9.20.1770629592025;
        Mon, 09 Feb 2026 01:33:12 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376b62b835sm11321718f8f.12.2026.02.09.01.33.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:33:11 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/2] knotty: fix TIOCGWINSZ call for Python 3.14 and later
Date: Mon,  9 Feb 2026 10:33:01 +0100
Message-ID: <e1f50c8c400f1691e514ee604fc33c5cda0df8fb.1770629479.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770629479.git.yoann.congal@smile.fr>
References: <cover.1770629479.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 09:33:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18986

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 415e9e329cf8cc0c2caa01cba80c21cfac9e2414)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 3784c93ad..41a943adf 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -131,7 +131,7 @@ class TerminalFilter(object):
     def getTerminalColumns(self):
         def ioctl_GWINSZ(fd):
             try:
-                cr = struct.unpack('hh', fcntl.ioctl(fd, self.termios.TIOCGWINSZ, '1234'))
+                cr = struct.unpack('hhhh', fcntl.ioctl(fd, self.termios.TIOCGWINSZ, b'12345678'))[0:2]
             except:
                 return None
             return cr

