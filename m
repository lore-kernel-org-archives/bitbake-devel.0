Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACDEE7BD8A
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 10:36:41 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17101.1771238198431861363
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 02:36:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=Z3HdXhm5;
 spf=pass (domain: 0leil.net, ip: 45.157.188.14, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fDzj04XpXzgQx;
	Mon, 16 Feb 2026 11:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1771238196;
	bh=L6H1tw62hGL2vdwemXZyjMbUMe2jbN/HpT66YshS+1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z3HdXhm5JZyrVT4J+/OeHJUe6b0RoQW9BdbFJGNNDY0Rf1cr/8lmEa2vbVMN86S9k
	 6T3XGiUECbA75f9BtDioCJSHOLupMfNehKuijtC3TXWsReuUtxHGnX8tbjS6aHI7NU
	 q3Mkkf51fDjpQ0kKoP/DGDiPR15DsoAHo9yl8C7kkFzls8AFLoFz6A0kr0Ry903JVP
	 dUjFZn/ol3H/q/Sg19pcFn40oEAwixZxZTRwoy45xtW2uSzoOHUJh417UEJbjHOHxW
	 rvEmG7+jsoeQZMAmGshIIXsNzxNVst/uxsyVDmuDgu/ks4vwX239DgK7+zd8ds9mvI
	 secOHZG4k3EHA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fDzj00rcdzPPC;
	Mon, 16 Feb 2026 11:36:36 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 16 Feb 2026 11:36:22 +0100
Subject: [PATCH v2 1/5] doc: bitbake-user-manual-ref-variables: clarify
 BBMASK directory matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-bbmask-slashes-v2-1-b9bb52f5fd3d@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19035

From: Quentin Schulz <quentin.schulz@cherry.de>

BBMASK matches files in the directories matching the regex, and also in
their respective subdirectories, so make that clear in the wording
leading to the example.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 4b3b10d46..18bbd638d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1051,8 +1051,8 @@ overview of their function and contents.
       documentation at http://docs.python.org/3/library/re.html.
 
       The following example uses a complete regular expression to tell
-      BitBake to ignore all recipe and recipe append files in the
-      ``meta-ti/recipes-misc/`` directory::
+      BitBake to ignore all recipe and recipe append files in
+      ``meta-ti/recipes-misc/`` directories (and their subdirectories)::
 
          BBMASK = "meta-ti/recipes-misc/"
 

-- 
2.53.0


