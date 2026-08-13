Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E320C5CFCF
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 12:48:52 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18132.1786625323017022226
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 05:48:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=c+Ch6KLr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f633e6058so573569f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786625321; x=1787230121; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YVCEs0Xl7BcbEP+LDjP6IUYst2jpv4xnAZJxMS5M2AU=;
        b=c+Ch6KLruj6BybWO5tTO2xNOjuHeEL4YAw96KWKcHCBuOP9Jmy+krHeykZYa8OLxe1
         z1VS1p57mplW5XNHpiUHn8QDISvUGGuiDaY4hIccknl4BMt1+YYmaV4DXHDPXzV3Vxta
         An0LYf6uXv7ia5IwbwB/pBkOXhZ+n9ma+SG1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625321; x=1787230121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YVCEs0Xl7BcbEP+LDjP6IUYst2jpv4xnAZJxMS5M2AU=;
        b=g+IGgH0ahCL+QMyfad6f3IdcWl1bTpkg3bXTzIuuEO0qnPP8P0wM1IAztfIKHXm7Z7
         98XSVl5zUA3lAe+/WMw/HwwdzcGyOrsvvNgw5RQeSyictJF0aghlpnFRhO8G2CplLuLR
         Ft7oLWk948Z3JmbABUuc5HFOMhkN76jkcLiPQhT/7h8RGZ3lmUCI91SLOgFsCtrp9DE8
         AbPhgNzNb/Es61tbn/y2JioLUHbdEaspiaORc2OsYmt5ZRjX+yF8o6f68BDZPMESDO3U
         j7aeWNQ0n6D18jltrxX2P/fJetucM75OrZf7NJL8aHpmBivY8Z2d/IN04z4f8YKsMSV0
         x3hw==
X-Gm-Message-State: AOJu0YxwDdpkZHEvYw6L4kNKYeL2DcLZzzeVSBfyUCfeQyf6lAV4D0w1
	89K6iBXZl0zb0a+ZLT/VIvJPz7FkXRzyOMqfOcjv6rgSFMELOroYBSDZ6/ZAeQzF87Sbkql2WgM
	dOdCZEn0=
X-Gm-Gg: AR+sD13kiZmfkSTFt5W67fzI2IXqQ+0w3doqkwhjGvQOmjl/rgQ592OSu4/rjgBPBOF
	qO6FIBxK0m+oBVLieBwohkls5cLUueZCZlqhcYVze3ihk3W70w4Vk0Z+OY/krxtnJG7nvC4s7fw
	+qJ5rVbiI9Cje4jnJZuZLe2R3vhGYktQazaBrbUs7o4Adg1K0kOE3+z3VC4u1p5cub+I0Kx9813
	dDBOj11H22IzS3y0zlhAz73D7Bf7oBIN+dAZt9NlZtvNpX1Zdl91QW4jv1HKitVkCpi72NRa+0M
	P+7al3KB5l9s/74hUMWeXb13w0hrZzNCMPrl1QhtmIHoRwIUnnC4tC94GpqT5++YmuoggRT0jmw
	2vWMQPD6RGDJX4sRhbDXaKVn6IojzmL/nr0VG4aueINDy/sn8SpwNCPIemQ7Uk6CBrLzbF2QL4d
	XndurxMsPfwJYqf1N0Kn+xXaObuZW3cwu24pILJQGEg+j+O28bak8Lbeh30szvPmJgKf0183oE0
	piyiXgG/63Zt1ymvA==
X-Received: by 2002:a5d:5007:0:b0:472:fe1a:1ee9 with SMTP id ffacd0b85a97d-4815a0285a1mr6425690f8f.20.1786625321160;
        Thu, 13 Aug 2026 05:48:41 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e77b:339c:e0c2:6c8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6616sm6685768f8f.25.2026.08.13.05.48.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:48:40 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/6] utils: Add lockfile_to_exclusive
Date: Thu, 13 Aug 2026 13:48:33 +0100
Message-ID: <20260813124834.1770307-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813124834.1770307-1-richard.purdie@linuxfoundation.org>
References: <20260813124834.1770307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 12:48:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19927

Add a function which turns a shared lock into an exclusive lock. This is
useful for planned changes to the fetcher code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 92b60b39d2c..b635f68a153 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -587,6 +587,13 @@ def lockfile(name, shared=False, retry=True, block=False):
         if not retry:
             return None
 
+def lockfile_to_exclusive(lf):
+    if not lf:
+        return
+    fileno = lf.fileno()
+    fcntl.flock(fileno, fcntl.LOCK_EX)
+    return
+
 def unlockfile(lf):
     """
     Unlock a file locked using ``bb.utils.lockfile()``.

