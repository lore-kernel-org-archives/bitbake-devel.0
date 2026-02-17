Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D800EF99FF
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 13:36:46 +0000 (UTC)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12074.1771335399959916024
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 05:36:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=H1UUHtmM;
 spf=pass (domain: 0leil.net, ip: 84.16.66.169, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fFgfG2cPXz1vB;
	Tue, 17 Feb 2026 14:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1771335398;
	bh=aJhl7mgjFeHegk2ATcON7KtZAcTsFxsKQP3zYpmWyyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H1UUHtmMz8cBicm1aJGH2LOKzKrjxPFM/ANXyJxyFQEjEoKoISKkcyWleSkbrSmH5
	 Q1ZLyRxcOy8PYBKR9xTBFERCjX28xs2D42EuoV81+sOc86BxGhgO8HnyUpmJLtnse3
	 7DXdltkS+XaebGaOs5XrZ/VSwH+ORqLQIHbzrHmpLRcmA5C4CeVmUUVDvxNB/52cCc
	 zNTyve6n87br+/lRHObmb+Wj+06YxYBJQm2sNdqL8uWIkzJbEEEacz/HBqBhOrx940
	 3E9QJEUKb9igvbdS7oSV9S7PBRWYj9NwjJcHiB2uGXSXuckJ6FGOPBFD2P5BRZG5Jb
	 s8WQca0VX7tQw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fFgfF6pr7zWsf;
	Tue, 17 Feb 2026 14:36:37 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 17 Feb 2026 14:36:31 +0100
Subject: [PATCH v3 5/5] doc: bitbake-user-manual-ref-variables: update
 Python re doc link to HTTPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-bbmask-slashes-v3-5-6a02cde9fdab@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19055

From: Quentin Schulz <quentin.schulz@cherry.de>

It's 2026, use HTTPS for the link.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index bab5252e9..d867f74ec 100644
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


