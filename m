Return-Path: <elmehdi.younes@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C54F589CD
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 12:59:15 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18754.1776949153667975426
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Apr 2026 05:59:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=BAou/c/y;
 spf=pass (domain: smile.fr, ip: 209.85.221.51, mailfrom: elmehdi.younes@smile.fr)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so6812399f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776949152; x=1777553952; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/4hBCCvCg3fxF4NMTfBccJXsJpN+9XxGeN7TaPikhY=;
        b=BAou/c/y9AmQqwvSwZaB78P9kJNZKyr//W9yGvZTYK5vCmX8cdiJF2NX/GWOaHTKnz
         GgfDtCbvnb6dXnPR5t3oOTIpitZhztPiiS3Zn4HFtGkHJsBmkipmgjnIUltbjIJL+nbf
         ZBVdLZlIB31dId5Isy98eEHGP6osoIw6YvdOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776949152; x=1777553952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/4hBCCvCg3fxF4NMTfBccJXsJpN+9XxGeN7TaPikhY=;
        b=eKOF2FfTByxkQEorswaP2EJeBP2jNyQ6KhY3d3R2X0oHydYSYbA1KZoQDY/9rUxDBT
         0m+4Oz9Fwf/smAbBMYrHgI7GDXRl8YLTq50WGHyWL+H9MNmqTCHYnIceri6U2gRUg62w
         8QrzZkOQKSNGALobFE2bWl0qWgKqjEesoXu/ihZ9XF8mnrmDnasskddwVIXTcoQm9q3t
         0L/NyCvXa/E6bEoxZcZO3jZTN4arb+Q3vsO7VwNzEeW9suTjBugIZe/SGR6Azt7d+wo7
         zpL1VJIG8RJ6MXD6DfrnePTGTINLY8qq8v4wQ0CnPY2oz0cHDyryoKG0I1SFZM/S0wVR
         pl3g==
X-Gm-Message-State: AOJu0Yyq3fqXZP+KvZAb1HcwrHQIWGoeLF5eropb0JTbxjkPN3X27UH6
	hUW8RmJGSq8r8w6zY1zr61l1y56EmDiAxjKBV8glUOr+YdIp9y25CgFg2fSO1Xg0fvUYjnA8/m6
	VtFAEDrk=
X-Gm-Gg: AeBDieuGHONZsGZEHvO071g+3xbdXpTb3W0lFlBhDijfrzu1g6T+v3QMm4a5huDrlll
	Q4/05O9hrwuXdhPi/FqU55SQLsvkVJhKvMdEoAx3KuWySx9QrJyVmNNnvJVxNp9o75fnorg9/9w
	zxyTA7aW3G1yHomTJoTK+KKOuJUN1SS8dEWMfbKN3Qfi4XjMM+yaWMuyeUce/6IKD+h5emaNYWX
	3eK7KBvTlwsNbq8EBAshtPqszx+EwrEyKGwWZGsFpGZBebtqTrMWKL77GZvJ7P64osxH+636qQC
	fLvIqvf/Sa78rGnrzycgixjHz4twgTUF6c2DuA0fA5xE9MPvpEPOlWLhd62nUe2+T4GZbgUNe11
	yKe81V76SKG/H7BDWVoM4rvpbHqHb26OVelwjHMEdmlR0gXuM35hiS7+I1a1U7Idojiw9ctVjHg
	zEgsbPaQzEha+SLIrcZVzisAZOrzuXzpJuftuiIiGDsHbk78V+FAuQnzUg/70BZ9IHtlb2j8zN/
	X5az3wxklMkKO5Lg8SfOzsa8M41x284
X-Received: by 2002:a05:6000:22ca:b0:43d:50c:6f33 with SMTP id ffacd0b85a97d-43fe3e0bde7mr42417334f8f.26.1776949151682;
        Thu, 23 Apr 2026 05:59:11 -0700 (PDT)
Received: from FRSMI25-BOLET.. (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm50709086f8f.31.2026.04.23.05.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 05:59:11 -0700 (PDT)
From: El Mehdi YOUNES <elmehdi.younes@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	El Mehdi YOUNES <elmehdi.younes@smile.fr>
Subject: [PATCH] bitbake-user-manual: Fix bitbake-setup settings command
Date: Thu, 23 Apr 2026 14:59:02 +0200
Message-ID: <20260423125902.1146038-1-elmehdi.younes@smile.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 12:59:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19380

Typo in the bitbake-setup documentation.
use "bitbake-setup settings set ..." instead of
"bitbake-setup setting set ...".

bitbake-setup: error: argument {list,init,status,update,install-buildtools,settings}: invalid choice: 'setting'

Signed-off-by: El Mehdi YOUNES <elmehdi.younes@smile.fr>
---
 .../bitbake-user-manual-environment-setup.rst                   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index c22e19bd6..77fc4c3dc 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -674,7 +674,7 @@ The ``bitbake-setup settings`` sub-command helps modifying the settings of
 
 Settings must be set with a section and a value, for example::
 
-   bitbake-setup setting set default top-dir-name bitbake-builds
+   bitbake-setup settings set default top-dir-name bitbake-builds
 
 Will set the value of ``top-dir-name`` in the ``default`` section to
 "bitbake-builds".

