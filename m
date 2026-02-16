Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED3E7BD9D
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 10:36:41 +0000 (UTC)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17106.1771238200894503967
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 02:36:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=c1Somcs0;
 spf=pass (domain: 0leil.net, ip: 84.16.66.170, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fDzj315lTzfSC;
	Mon, 16 Feb 2026 11:36:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1771238199;
	bh=apND0+S+5XM7X+UhcoPP+qJfPL2cgC1CLIuB/PE/6bc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c1Somcs0YXVmdmizigIfonfFlfRn+sxo0oZ8bjeM6kMAI/8EejdP1uW0SAo1NRRgM
	 oqMAPUIvrbo0Wy5aAqqHRBCA/B+Stz2mxtRfm9JaSapggYzlGtAo+18w0ozd5gjdHs
	 blFKN3CyVZ7EVG3jpaqaUmforLnCQzhOO3QEqbwSdqq00MkuP9xqPIq201RcWS80AB
	 g79Moxkrtu33Vi6TLW5CB4uxqqoO+RsJ6pmOnCUpfm95OhbfIXAeeK+A3oFAwLOaX0
	 V+cy+0Ttm+yG7+6nPvj1Egs1yiUjfvnyU+qo44SANdcYwAK7JJQtOVs1afhcaIVhSv
	 Jn89AxAX4L29Q==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fDzj24XmFzN7t;
	Mon, 16 Feb 2026 11:36:38 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 16 Feb 2026 11:36:26 +0100
Subject: [PATCH v2 5/5] doc: bitbake-user-manual-ref-variables: update
 Python re doc link to HTTPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-bbmask-slashes-v2-5-b9bb52f5fd3d@cherry.de>
References: <20260216-bbmask-slashes-v2-0-b9bb52f5fd3d@cherry.de>
In-Reply-To: <20260216-bbmask-slashes-v2-0-b9bb52f5fd3d@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 10:36:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19040

From: Quentin Schulz <quentin.schulz@cherry.de>

It's 2026, use HTTPS for the link.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 9daf8223d..e424bd040 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1048,7 +1048,7 @@ overview of their function and contents.
       compiler. Consequently, the syntax follows Python's Regular
       Expression (re) syntax. The expressions are compared against the full
       paths to the files. For complete syntax information, see Python's
-      documentation at http://docs.python.org/3/library/re.html.
+      documentation at https://docs.python.org/3/library/re.html.
 
       The following example uses a complete regular expression to tell
       BitBake to ignore all recipe and recipe append files in

-- 
2.53.0


