Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBB2E909B4
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 13:36:46 +0000 (UTC)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11925.1771335398322802851
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 05:36:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=gI+vsom+;
 spf=pass (domain: 0leil.net, ip: 83.166.143.171, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fFgfD583Bz1Gy;
	Tue, 17 Feb 2026 14:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1771335396;
	bh=L6H1tw62hGL2vdwemXZyjMbUMe2jbN/HpT66YshS+1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gI+vsom++i7iYoP/ejLTqjxDN0C76RQV74uqBMV6pnuOsIsn9rKJktdvSF4f8ZBIQ
	 sxBsgQAgX5/fPjTww79FDn/zjdRrynXWRYBiN8fvI1WVLjdC+73kWMMleutjY0jHKt
	 zDJRwi+e0m/iPbE7lwOO2hNXkoA8LYyIRgoooLBQcM7PQcTNxlMWqpKIxh+aieUJm7
	 X10WYWAt61apO+gtjq1upt0FUKjK9xfvxh1MmMyKK/4mTfh266plcXgZ2u9pJYYkSa
	 fOFOEobhldJLg/fPyKcH7TIDzmGv8nZJ9zJFVn4Yl4546uGw2lf6huIdQRCPaZZjUr
	 ums6YnvI60Ncg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fFgfD1tGMzXMP;
	Tue, 17 Feb 2026 14:36:36 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 17 Feb 2026 14:36:27 +0100
Subject: [PATCH v3 1/5] doc: bitbake-user-manual-ref-variables: clarify
 BBMASK directory matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-bbmask-slashes-v3-1-6a02cde9fdab@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19050

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


