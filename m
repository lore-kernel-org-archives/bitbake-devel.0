Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF9AE909AE
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 13:36:46 +0000 (UTC)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11926.1771335398742428144
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 05:36:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=kUiXEaD3;
 spf=pass (domain: 0leil.net, ip: 45.157.188.15, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fFgfF0yfszl3;
	Tue, 17 Feb 2026 14:36:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1771335397;
	bh=WSXc47pUNY65BTpch+5vXCYfACEp0V2Dos511v5FpL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kUiXEaD3GAeiJ7fv0Zd53+QMLZjzxByjP20tt2hEw9d6nZKQ+VUUpXJrqoy8Zle+S
	 0ZuX7i36l+jgg+KBbSKZNQ14utW68/j4mL6VntiocfCFQbNxnkU+S4VGBwbPh9+E/S
	 nJoexkSQ+xWjrxCTi9wbDqtpXQoO8/WUgiJgcM9x4GlJhilxtlXGMNp2po14w6YHd2
	 AOXVPjQn1/O+fLKiuORECwR2FS6vbdgtxaPPY1YbhhzOEwolnAekVH/M0zHMTkd70v
	 zvMBloXdvVFH4ehGE3oDoBW0TFgX1rhdNk6r1td0y5FAsYIR7UxGJcEr0ctSk/gxD/
	 jJxD+hEPaOJfw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fFgfD51Y5zXc1;
	Tue, 17 Feb 2026 14:36:36 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 17 Feb 2026 14:36:28 +0100
Subject: [PATCH v3 2/5] doc: bitbake-user-manual-ref-variables: have
 directory examples be consistent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-bbmask-slashes-v3-2-6a02cde9fdab@cherry.de>
References: <20260217-bbmask-slashes-v3-0-6a02cde9fdab@cherry.de>
In-Reply-To: <20260217-bbmask-slashes-v3-0-6a02cde9fdab@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 13:36:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19053

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


