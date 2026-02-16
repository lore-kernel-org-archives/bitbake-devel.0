Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E60E7BD92
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 10:36:41 +0000 (UTC)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17021.1771238199132132246
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 02:36:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=RBn1/uGd;
 spf=pass (domain: 0leil.net, ip: 45.157.188.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fDzj12YS2zhFx;
	Mon, 16 Feb 2026 11:36:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1771238197;
	bh=WSXc47pUNY65BTpch+5vXCYfACEp0V2Dos511v5FpL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RBn1/uGda30e6NhVh8UcWagX9jX2WumusVq+CA4BaxY4LG6UzeMJRf7yumZsIizux
	 qS70JyPptQd7mf3CE3ebT2K6XlDRa1qhBQQst+S0avJZtHJYfKWoBbT1GnvQb9KocG
	 zW1H2ef/4W2WNjGrTlTuCXxIdhKdJyZsgR7sjTOE3FQVao/Nj5IPenRVgDnKOL0GFF
	 jrW7LBnd5g1QdzMBSQqigeA4le8uRhXIXhTTNfg5rW47vvBo7s1QSWuOKvh7OuWREV
	 fKMNgGT+sXn7GiapHUEat9Wi8Oc3dWNZzWOcTb5yB7FQJjL2CR7OZuOSVG8lyRdTB9
	 EBJmeiYApeQgQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fDzj05vQ4zPPF;
	Mon, 16 Feb 2026 11:36:36 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 16 Feb 2026 11:36:23 +0100
Subject: [PATCH v2 2/5] doc: bitbake-user-manual-ref-variables: have
 directory examples be consistent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-bbmask-slashes-v2-2-b9bb52f5fd3d@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19037

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


