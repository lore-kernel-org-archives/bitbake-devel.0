Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF1ECD6E0
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 18:06:39 +0000 (UTC)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25478.1770833192708117228
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 10:06:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=YpijehKQ;
 spf=pass (domain: 0leil.net, ip: 185.125.25.13, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fB5wQ5l9pzC22;
	Wed, 11 Feb 2026 19:06:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1770833190;
	bh=WSXc47pUNY65BTpch+5vXCYfACEp0V2Dos511v5FpL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YpijehKQqqsTeEppGZ2ZldRrEo3fokoHfCxFp3zVG6rXwHCI6KSuetwUfuPSn5OvV
	 u75rkBpbcKSPV8sHFuvhVJFpYIWSjkrQEjyoDJtDHib6cMsmdgZ6obuxVbzcTWSUUR
	 FTTmEachBg2sKbz78j0kXPNombOgPcW8HZU4JxBJwfr+Nxm7/6XISEzWUmTxr9qr2y
	 6MMOOy+DbVFNXKo8yJ8Zmg50MwTAbVNDx7r8j7jLO2CH5KDXLRTghBeirr32m0mSt9
	 +QfUJLKivpomiAR0l2+YsHPJpZp8/Ih3FCsO6Dag5iA2Ac5QyefHApXDwj0CN5KQPE
	 aba7NrsbjeBGQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fB5wQ1q5dzgcn;
	Wed, 11 Feb 2026 19:06:30 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 11 Feb 2026 19:06:21 +0100
Subject: [PATCH 2/4] doc: bitbake-user-manual-ref-variables: have directory
 examples be consistent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-bbmask-slashes-v1-2-b72161c647ef@cherry.de>
References: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
In-Reply-To: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 18:06:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19010

From: Quentin Schulz <quentin.schulz@cherry.de>

It's a bit confusing to have a mix of paths with and without a leading
slash. The behavior is actually different. The next commit will explain
when/why to add a leading slash.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 18bbd638d..f20a9012c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1054,13 +1054,13 @@ overview of their function and contents.
       BitBake to ignore all recipe and recipe append files in
       ``meta-ti/recipes-misc/`` directories (and their subdirectories)::
 
-         BBMASK = "meta-ti/recipes-misc/"
+         BBMASK = "/meta-ti/recipes-misc/"
 
       If you want to mask out multiple directories or recipes, you can
       specify multiple regular expression fragments. This next example
       masks out multiple directories and individual recipes::
 
-         BBMASK += "/meta-ti/recipes-misc/ meta-ti/recipes-ti/packagegroup/"
+         BBMASK += "/meta-ti/recipes-ti/packagegroup/"
          BBMASK += "/meta-oe/recipes-support/"
          BBMASK += "/meta-foo/.*/openldap"
          BBMASK += "opencv.*\.bbappend"

-- 
2.53.0


