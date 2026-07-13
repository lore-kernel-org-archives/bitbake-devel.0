Return-Path: <michalwsieron@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFD2C43458
	for <webhook@archiver.kernel.org>; Mon, 13 Jul 2026 16:28:49 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.210.1783960128202170095
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Jul 2026 09:28:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=mW2gEKY1;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: michalwsieron@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15c42a45adso10526066b.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 13 Jul 2026 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783960126; x=1784564926; darn=lists.openembedded.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k3tAieKeoDP6chQu4GUli4zyNUfOLQc+a3NNE3cZ4ts=;
        b=mW2gEKY1vVR+0h+yeByuUs+MLfKrkvZT3FucalgfG6aLd88YNN82bnYvNce5DbotJF
         0z+CP7quyWPpY2oPrr2SrEwGPriwophPpEzbAYrCngRL2laij/GgDZH9vJCh0OTScK4u
         Be6Qwkz65npEP13fdZK17IM/WE9ZNBpOD9aXiMIjehZLvLfBDnH2HXYv+ss5mHPxPF1S
         T2AdI14nQLb+8SOQuSud8cFKwIkCDf4IaLHiv4N0xEmh/Rvo6HIhbcROe3ZivHDZTjz3
         7xtOKbAjBr4DOchftIclCMmS/ILUUFJcAPKt5y6+ZARt1GJGFaDrdeOZBgWEO1v+pJjw
         MeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783960126; x=1784564926;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k3tAieKeoDP6chQu4GUli4zyNUfOLQc+a3NNE3cZ4ts=;
        b=iXeehvjxTw6YXZ3cS7HrgLkkwjPAAPmf8xSpqPodHhFXnpHQZy10iRz543/qN8injN
         h8et3c3dGVp9wcHcNzOcVHYNgaCuqSg+/oke/+5orS+3ffRnI0HwhCMgsuRtth0JxdVL
         +EDV3EpoUXLRe7PnCNCQcA6of4iB5fLlCEedEMEvO0r2m3ET1pOhcdEa9zRn6pTlYv5z
         QkZmYa+atlXpy6Z7Vyy7inFtb2k3jdgPGvONpmCAFOdcM8Zfs/WWHMx50fEAJz6Klrxi
         +dVmf46l/eVILqzeqjFVDmXqNjemyP3zsXf8YPra37yBHIDpRAk18SwAX3oY6g5E9GLn
         a+Fw==
X-Gm-Message-State: AOJu0YyZvMNBO5FNoTaP5227zpI1/xL4o+1YplcZdFAwoaEhnIgZjAY9
	Mp96IJTkSxbgeU/u3Moe3ajPdGVNb9x4CyZNHOm/pJUxBRvvkjVWvmqziPQDaH9l
X-Gm-Gg: AfdE7cm7DVPx2ic/7Piqh2Y/kL9nZqwtluzYCV5g+1V/anMWSvVeKm9lPjvxvt2El/D
	VLN7kRzmScAwrrphVkFotx6/wdAr8jLy4s25zAEVKuiEHqieu4UTd6KvUtWUZXZyLAkIrjnFL0Y
	+JnhQ6zbNoV3i9zSKsgl2huT8IxmCLtfwt+bRZmZlQWTiHe4JIL7bsLG/ZNoOit0IHKGAxX49Q9
	kCFdkdmtIbXtYWx9rVwjwuKfd6MenEd8S3ceNuiZ45ntkJQKqaOgLKvc5GuhiXZggZTLp/ut6gJ
	hgoiFAZtZC8CT6udGQ2xBKer83EdVZCV7rmoBPqLHzmx6SGiCg8MlkgNCvtxIdjW78eRB2P14Qg
	bvh5P3P38gJ++qwVNtrd/8SRdUzPTjJzfdXxGdnYsPG/CwydsJ13I4XbaIOLnEag0fcpsFw7wv6
	4Dm/+bp4Kq89FqHsewqdIYYydsuRbP47EUhmh/60Tb6z8kE39BH6bd99tNjhnP
X-Received: by 2002:a17:907:3f05:b0:c16:b95:4ce9 with SMTP id a640c23a62f3a-c161e89c5e9mr426480466b.8.1783960126114;
        Mon, 13 Jul 2026 09:28:46 -0700 (PDT)
Received: from [127.0.1.1] (185-72-185-154.cgnat.inetia.pl. [185.72.185.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d3859f69sm817817866b.27.2026.07.13.09.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:28:45 -0700 (PDT)
From: Michal Sieron <michalwsieron@gmail.com>
Date: Mon, 13 Jul 2026 18:28:19 +0200
Subject: [PATCH] fetch2: Ensure UntrustedUrl.msg is str
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-untrusted-msg-str-v1-1-9496b78c39a5@gmail.com>
X-B4-Tracking: v=1; b=H4sIACMSVWoC/yXMTQqDMBBA4avIrB1Q6x+9irgwZqIjNC0ziRTEu
 5vW5bd47wAlYVJ4ZgcI7az89gllnsG8Tn4hZJsMVVG1RVc+MPogUQNZfOmCGgRNUzvTuX7qbQu
 p+wg5/v6fw3hbo9loDr8RnOcFfhcov3UAAAA=
X-Change-ID: 20260713-untrusted-msg-str-b54fb7f8a8d6
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michalwsieron@gmail.com>
X-Mailer: b4 0.15.2
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Jul 2026 16:28:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19836

After e74cfd03afe5aff1f81cbff8c6efcef77c9af618 and related commits were
merged, fetchers call bb.fetch2.check_network_access() with a command,
which is no longer a string, but a list. In case of untrusted URL this
would now cause an exception:
    Exception: TypeError: __str__ returned non-string (type list)

Signed-off-by: Michal Sieron <michalwsieron@gmail.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 4535f55a5..a5772f8a9 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -51,7 +51,7 @@ class UntrustedUrl(BBFetchException):
     """Exception raised when encountering a host not listed in BB_ALLOWED_NETWORKS"""
     def __init__(self, url, message=''):
         if message:
-            msg = message
+            msg = str(message)
         else:
             msg = "The URL: '%s' is not trusted and cannot be used" % url
         self.url = url

---
base-commit: 3a99c26fa581d70ed67bd08a5e0e0d0b18369a7c
change-id: 20260713-untrusted-msg-str-b54fb7f8a8d6

Best regards,
--  
Michal Sieron <michalwsieron@gmail.com>


