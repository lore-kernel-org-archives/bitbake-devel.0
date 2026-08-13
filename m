Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75836C5DF66
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 12:48:42 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18130.1786625319966883812
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 05:48:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aad5nu9x;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4813ea321cdso603198f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786625318; x=1787230118; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5bKzIS7uiPiHMh1413O3cJUYz2vgckZ4OdATy8Xb9TY=;
        b=aad5nu9x7sM+SQJ+EyOuhTyTY9RxxzGC4hUDkVLTKz1YZM4EdbebeTGoVwIFNUXXNQ
         P/uoqw1ALAsJNU9ZOHbY9CqamvDutiFYV7+Xvly83dhq4+geWRIYGoRWlmfFB1eBxASh
         MC8G+orwtYpmBC+dP3Ffp2AsqDxLpL5Cn3/yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625318; x=1787230118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5bKzIS7uiPiHMh1413O3cJUYz2vgckZ4OdATy8Xb9TY=;
        b=Km8YrVEfvf+OWKkJhGhPSfYob7ZQhAcf5xz4S4SZhUFwqSpgmvIPxcoVaoXRKXj2Pb
         NeuLmhnjd4//wftqBsL4TDJ61W6abyDeVYnohzOhOVTEnMvJ27v/5R9cc7la1haqU1xq
         79pAq/BxJXjdNF+lI2YFMJ7SkPhstabK5IXoI3GZtvsAUfTSXufTheRqzGcTwBcDt0/j
         n9vm2jtF8KEjCoge35kl6bZERN11whMQkdyYdWHQxqq5ty5LjM7vhBMqkLCGZ+OmbbsR
         E40UhTSpMbMau81pQctQAbZK09009+rR3Cu27V89jDfFKVVjh1dl8OqLE4LzL8NfI9wM
         h68w==
X-Gm-Message-State: AOJu0YwbdNOrSanjBbtmUuzU3HHIbZ1dEwlUlK+kTQqSlEcP792NOkAB
	+BpCddeJveUuJz+PAdtjSEgXRkHYKc0AaWpes033ETKhJn9/xC9+DcaSPo7QpQQOZaY9WkwxHsC
	G1JDVlFQ=
X-Gm-Gg: AR+sD120U23hyaUh1hHEWBYzYEuSxU8GFOcmTe7dwvyABEZZSwqQv5/rrU85aIkwBW1
	mg1dpkmevYHYNYlTHI8DlmLdfQQuUWyyB0E40ugiYN2IYNZHZITX4p0ieyW7zQPuYMyfX3NTVe9
	OcSAIcfEyUnSzi2UXVm52/8+DWxcGcSCtqp77gmywuABXTKHcOq4XLcwa3OuPsOtof6efVSAwEH
	b/gIZXSG4kmBPNjK50Ir6XVxp9nUDNYbugxqejpEyAWoBfnmzJ9gGZDAtJxclXXqiEAvWQOO5aM
	8O6SW6SZ3vNhKgCWkjmvYuVMH0Q3oaHKeg5X5l+xZy0k3FW/Ulanh/p4cNFqQMROL8n3qtCkINy
	3oIZAlYIiAC/jxeTwJwvEv3yCmK1+Beuatmvslx2IUXg3EZd7HKQcd1aM0OUv6VP/VacDxWwxzZ
	vKcj7xYljgR2sNVQPVyLc4Dnx/6NGYKI+vHPPDhQ+CwmGpzxv0X/25cn3N0BXnDQMKCK7Vxu4vD
	naajScH0+C9YyKp5g==
X-Received: by 2002:a5d:584e:0:b0:481:57de:df20 with SMTP id ffacd0b85a97d-4815a5436ffmr6764125f8f.15.1786625318007;
        Thu, 13 Aug 2026 05:48:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e77b:339c:e0c2:6c8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6616sm6685768f8f.25.2026.08.13.05.48.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:48:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/6] fetch2: Drop unneeded checksum check
Date: Thu, 13 Aug 2026 13:48:30 +0100
Message-ID: <20260813124834.1770307-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813124834.1770307-1-richard.purdie@linuxfoundation.org>
References: <20260813124834.1770307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 12:48:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19924

This was added in 022adb30dbb0df764c9fb515918cb9a88e4f8d6f however
the checksum exception is now correctly handled in try_mirror_url
so this code block is just duplication and not needed anymore.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 604208c2c82..51db8304c65 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1925,15 +1925,6 @@ class Fetch(object):
                     done = True
                 elif m.try_premirror(ud, self.d):
                     done = m.try_mirrors(self, ud, self.d, 'PREMIRRORS')
-                    if done:
-                        try:
-                            # early checksum verification so that if the checksum of the premirror
-                            # contents mismatch the fetcher can still try upstream and mirrors
-                            m.update_donestamp(ud, self.d)
-                        except ChecksumError as e:
-                            logger.warning("Checksum failure encountered with premirror download of %s - will attempt other sources." % u)
-                            logger.debug(str(e))
-                            done = False
 
                 d = self.d
                 if premirroronly:

