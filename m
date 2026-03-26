Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EEF10AB81B
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 19:23:59 +0000 (UTC)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57028.1774553028387092169
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 12:23:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=By4zkxk4;
 spf=pass (domain: 0leil.net, ip: 185.125.25.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fhYbk3ywkzGFN;
	Thu, 26 Mar 2026 20:23:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1774553026;
	bh=zwOCBcM7nyv1QTPDWArtcP7Dj4RPQhF8ZfSp0BOVf8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=By4zkxk4F88H2cI6WMYPKrNA/sJPBCTiaEyYNFaqrGtuFEgmR66Y0FnjP3JJyLR6k
	 koGSXqPdEUM9/RATPY1ODEQd0KwTnIzS08av2b/bbYW/ve+jQyeHyIN7wPhR90YVmJ
	 tfineZOPLlYIHTDdoL1Y44Wc29zgKQHviXaeB97ohwU/UR19QX2kc7TPXi8Z5s01gQ
	 4Rw3W+0DIOtnh1PwmsJhBlbDEyLXERNnFdSST74EbYlKapmOEVJjcStUtJArvqFYo9
	 xrtyMmJUxz320SZZJvxzCe+XkHS0Mluu4ODdS6+tgYvpY75e5rG+8kZThZNw1cZfNj
	 HhInDC4gHbN3g==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fhYbk19PyzMCY;
	Thu, 26 Mar 2026 20:23:46 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 26 Mar 2026 20:23:31 +0100
Subject: [PATCH 1/3] doc: bitbake-user-manual-metadata: fix syntax for
 code-block in addfragments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-metadata-code-blk-v1-1-051530f9a051@cherry.de>
References: <20260326-metadata-code-blk-v1-0-051530f9a051@cherry.de>
In-Reply-To: <20260326-metadata-code-blk-v1-0-051530f9a051@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 19:23:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19258

From: Quentin Schulz <quentin.schulz@cherry.de>

OE_FRAGMENTS was meant as a code-block and thus needs two colons, a
newline and an increased indent for it to work, however we were missing
the second colon.

Let's fix that oversight.

Fixes: 3b9d7bea915d ("parse/ast: add support for 'built-in' fragments")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index bf517f030..56604e0dd 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1052,7 +1052,7 @@ The variable containing a built-in fragment definitions could look like this::
    OE_FRAGMENTS_BUILTIN = "someprefix:SOMEVARIABLE anotherprefix:ANOTHERVARIABLE"
 
 and then if 'someprefix/somevalue' is added to the variable that holds the list
-of enabled fragments:
+of enabled fragments::
 
   OE_FRAGMENTS = "... someprefix/somevalue"
 

-- 
2.53.0


