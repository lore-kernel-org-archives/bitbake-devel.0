Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A5AFD7F9C
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 11:30:31 +0000 (UTC)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.93815.1772191827238681932
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Feb 2026 03:30:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=cJW74tsv;
 spf=pass (domain: 0leil.net, ip: 185.125.25.9, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fMmN14ClFzMdZ;
	Fri, 27 Feb 2026 12:30:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1772191825;
	bh=mqSxDZU3Jt3YFmiPxpZCCGY8IkP+LxhFETxSJUFKzCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cJW74tsvVIlqnJ5Rzdgs0LgXwxf3z+28o0nm3Hx75odmjSPvegrmtIv4qvMBCuLig
	 WkFZ0h11+hIqrr/L9qhIaUEqnNlMpauxxtgunJVwwLOVWU0vqPwo+B/+MwVawcGNfa
	 uryFlYhJ7rcFoeHEUZyvmyGz4svFQSXfdz2dm/A1xWVnCQvZSz3gafWaSBSZD8md43
	 b0H9UOdmZECHocka/atQ2UzDJFDJqfzNE2WeBTUwyydX+FwE5cQioOVy4ARLzO2EDG
	 BwIJ0ci3Sw5xzR7T9QNAUbuZ4jywVgx+mKPCs8O+Z3zmmTMlgvIvXDzEUqB1a0jspt
	 MWNVXeFqt6nrA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fMmN11gG6z5vs;
	Fri, 27 Feb 2026 12:30:25 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Feb 2026 12:30:15 +0100
Subject: [PATCH v2 1/2] doc: bitbake-user-manual-metadata: promote
 inherit_defer directive to subsection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-shell-invalid-v2-1-df5cec5718bd@cherry.de>
References: <20260227-shell-invalid-v2-0-df5cec5718bd@cherry.de>
In-Reply-To: <20260227-shell-invalid-v2-0-df5cec5718bd@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Feb 2026 11:30:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19088

From: Quentin Schulz <quentin.schulz@cherry.de>

Out of all the directives listed in this document, only inherit_defer is
documented in a subsubsection rather than in a subsection.

Therefore, let's be consistent and make inherit_defer documentation into
a subsection.

Fixes: eb10df5a9619 ("doc: bitbake-user-manual: document inherit_defer")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 18f293f4b..1b7941335 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -813,7 +813,7 @@ evaluated at the end of parsing.
 .. _ref-bitbake-user-manual-metadata-inherit-defer:
 
 ``inherit_defer`` Directive
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+---------------------------
 
 The :ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>`
 directive works like the :ref:`inherit

-- 
2.53.0


