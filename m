Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF2A10AB819
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 19:23:59 +0000 (UTC)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57027.1774553028216431844
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 12:23:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=aO2NKrFO;
 spf=pass (domain: 0leil.net, ip: 84.16.66.170, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fhYbk1F5xzH7C;
	Thu, 26 Mar 2026 20:23:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1774553026;
	bh=ZidlJP1Y+CCn+vIy9UrLKw6cHmKoxzm5NG7nLkbpgiE=;
	h=From:Subject:Date:To:Cc:From;
	b=aO2NKrFOepxKnCaAo2lfVXXXQ3TusR6wmIOspXbRcGgiZiWnUzP8ZZmtntODQ9y/x
	 nfeoYV0CoppvuwcvWpiP+7dWZwR8Dfoi4Z3b6HYLkmT6uVh0fhGOtdLSyZr8kNuDbM
	 uZC0yeIKylydhm8oJQCh8aGwIXumK4S1BFz9qbCqxkHiR1tn42rnP5qhW4ezwxxGUH
	 QlPo0LvgAX04gjNH+IWYD172HPKgJ6MPkyyVbs+ITiEe90Je43wAXgdv3yNj0aUYK/
	 TDHoa/7WawlbiprUDXgoXmQunClAIPhN2oV4y09w4iTRICb2PBu7CDBLoH19Kawxo+
	 8QnE4JKXbNQZw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fhYbj3g3kzPP4;
	Thu, 26 Mar 2026 20:23:45 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH 0/3] doc: bitbake-user-manual-metadata: fix code-block and
 indentation
Date: Thu, 26 Mar 2026 20:23:30 +0100
Message-Id: <20260326-metadata-code-blk-v1-0-051530f9a051@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBBA0V+RWTsQkxrQXxEXeYzt+CxJWgriv
 xvr8izu3SFSYIrQFjsE+nLkbc2oygLcy6xPQvbZIIXUQkmNCyXjTTLoNk9o5wkb4XT9UNqqRkH
 u3oEG/v2fXX87fuxILl0jOI4TSnowj3UAAAA=
X-Change-ID: 20260326-metadata-code-blk-90c65436b393
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 19:23:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19257

This fixes a typo resulting in an intended code-block not being a
code-block and inconsistent (but with no impact to the generated output)
whitespaces in the same file.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      doc: bitbake-user-manual-metadata: fix syntax for code-block in addfragments
      doc: bitbake-user-manual-metadata: fix indentation consistency
      doc: bitbake-user-manual-metadata: fix indentation consistency

 .../bitbake-user-manual-metadata.rst               | 32 +++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)
---
base-commit: 05a0ca339a6fee75f7979c3ee95fc91b2bd9b92f
change-id: 20260326-metadata-code-blk-90c65436b393

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


