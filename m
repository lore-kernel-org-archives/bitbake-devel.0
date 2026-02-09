Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7A6E7E0AF
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 09:33:17 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44032.1770629594924029177
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Feb 2026 01:33:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=015mk/os;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359249bbacso2886003f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 01:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770629593; x=1771234393; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWifF7f9AlJlYEptrwOvYtaZw4YPuCbshzV8lH0r030=;
        b=015mk/os0DSdjWYNxI01Wqo90SvIr3+a6xsh2pMBbU5mi6ABtObAsLO5ctd7rBYrmr
         hL1rkQlDMp1B59X3zbTxLFhb6GqP7zDPNgoQerY6Dv0QPTBAEbRrrAQmihr15/DA0ykk
         t9NDtrAfyBidTFQ3ZPZb0noCeAtmxN7rsHBek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770629593; x=1771234393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pWifF7f9AlJlYEptrwOvYtaZw4YPuCbshzV8lH0r030=;
        b=iPPLeO4N1RUeBTXzEsaFQbx9TKcfKNaW9FlBPIb5aKowE1Dgo+ol9cpH0wA2fR0j/c
         PkKR5Gg0CRTWaJ/UxNj8PQ9VsX7ZvjHEJODztLkste7OhK1tuVveln84ElIOVML4O8ul
         B1UMaJp5Bu+EAR/RZiI2wXvYCPn5nxaPRRCX1Rg5YEHvhRfj9XO3qb26hLuaUqxsI9Pp
         jXS1Th6p9Zyt63tn2yvHVe86nmY/BDtHY8zxa2aw30+vhEtsHAXRlYjeCe1+4A5veTZP
         FZzoSgOSmA8vejMpLE+hNIGkDYL7MW+XWtEp74eqp84KVysNRVKujS9+/uexzSYquJFK
         6QHg==
X-Gm-Message-State: AOJu0Yxqhhhi1C/fS/uj5WGg0zEvWrpwt03YPXX/7mdBLpZQ+7yHO/r+
	4HtJAzey+Jqhz/SNkdTHv/B/LHnMThz4jO+bc2fpGsHQPdij4HXGTLE+17C58SU3/rGSWUMHCPJ
	JnUbl1Qw=
X-Gm-Gg: AZuq6aIHNa0Kd3wpyTWZr9btGs829klh/QBvV8+dW1jd00jSgHfjfmPaLrCTrwi9VAY
	9Vww+Es5gJEg00ebGXsv4SLzZ2GpPvoUwweiwPRsgTY8utuP+/pDuoNomQs90yF6uIpdMAWgLL3
	QMbXiOh2P4bKnR+4BL1JqxuXc+IlUwk6PriZFTigDOANKj1NrT5ai3YjP/Dnkg41vUiN/tWe8jV
	tAXTbE6i5CmdGf0flJ3f8zs5wlV6GVmpX/so12E870HV70Fu/OuqxzqgwjEybAmZ0b/qaJaw+R5
	Bd0if9W9IpLqawXISjz4rO24/xoMeAScYJSo49rMFkm6qO+l0DQftCrd3tmgFFTpThF+7vBVO2X
	N2EM4sJ1spjKhK3zADhiZohkmoePu0/h8W1lmkLTxgAKYdfL/yw1M4/T9VrCT0Z4JBI1JjjPc1I
	MA2vaF5COmrOqlP88ARFCfzrLgVd9FDDenYH8vt6hSiXekJ2WTScNckwkEHj2EdbADj7hV2TTtp
	fsASXetpvvk2Iuv8YtaTKBHlA==
X-Received: by 2002:a05:6000:2884:b0:436:8f7e:a486 with SMTP id ffacd0b85a97d-4368fbbae4dmr11192268f8f.11.1770629593031;
        Mon, 09 Feb 2026 01:33:13 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376b62b835sm11321718f8f.12.2026.02.09.01.33.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:33:12 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/2] knotty: Make sure getTerminalColumns() returns two integers
Date: Mon,  9 Feb 2026 10:33:02 +0100
Message-ID: <1b923cdd50449aaa41152b72eac8669f27ec7ec2.1770629479.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770629479.git.yoann.congal@smile.fr>
References: <cover.1770629479.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 09:33:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18987

From: Zoltan Boszormenyi <zboszor@gmail.com>

Python 3.14 complains about these:

Traceback (most recent call last):
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 722, in main
    termfilter.updateFooter()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 339, in updateFooter
    lines = self.getlines(content)
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 370, in getlines
    lines = lines + 1 + int(len(line) / (self.columns + 1))
                                         ~~~~~~~~~~~~~^~~
TypeError: can only concatenate str (not "int") to str

and

Traceback (most recent call last):
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 722, in main
    termfilter.updateFooter()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 341, in updateFooter
    for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
                                           ~~~~~~~~~~^~~
TypeError: unsupported operand type(s) for -: 'str' and 'int'

Make sure getting the number of rows and columns from the terminal
via the environment variables LINES and COLUMNS are returned as a
pair of integers. This matches the return value of ioctl_GWINSZ().

Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a4e0b6f8077276a0bfb9d05c759bc752a84d1f76)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 41a943adf..5198e93d8 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -145,7 +145,7 @@ class TerminalFilter(object):
                 pass
         if not cr:
             try:
-                cr = (os.environ['LINES'], os.environ['COLUMNS'])
+                cr = (int(os.environ['LINES']), int(os.environ['COLUMNS']))
             except:
                 cr = (25, 80)
         return cr

