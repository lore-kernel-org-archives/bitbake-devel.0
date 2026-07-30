Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F076C55162
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 15:19:48 +0000 (UTC)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14126.1785424780849945386
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 08:19:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=gTOy4UGO;
 spf=pass (domain: 0leil.net, ip: 84.16.66.172, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h9tCt53bGzNlT;
	Thu, 30 Jul 2026 17:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1785424778;
	bh=lciZol7+Ir5K7hybqbByWK9LKAErI6suR57EzMJRUsw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gTOy4UGOBBNpfMRHA5r54UsvNLSYEfDrpIR+GCUNSa8P4P9blSm2FJe4vdBcxQUMc
	 Jf6g2lStBB6OLTR6XqEklkHcmUwLr794/qOMkOVkcJw2CW4sI/CgX+Bpxk/rdE9Jv+
	 e845bQN4paFhAZblUOYtzQZaLqhsoDc95RPI4o4x1zbh4ottbyQPzYhLWdXU42/drE
	 yg7EC5u/HnMXNizqu3ZcdyxEhCHFnnzj0JDFTVdG9uGBcWltNqm/P6tAPRhasvxy32
	 4antqCppnITQvBs4JVyJPdHs8tQrM1EUfLeYOGQkV8i3S8oiMzAGn/MCBHuO68arjm
	 j+iAJDOk0K6Tg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h9tCt1F5nz6ML;
	Thu, 30 Jul 2026 17:19:38 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 30 Jul 2026 17:19:31 +0200
Subject: [PATCH 2/3] doc/bitbake-user-manual-ref-variables: fix reference
 to non-existing entry in variable glossary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-doc-fix-build-v1-2-f79ae06a270b@cherry.de>
References: <20260730-doc-fix-build-v1-0-f79ae06a270b@cherry.de>
In-Reply-To: <20260730-doc-fix-build-v1-0-f79ae06a270b@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 15:19:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19878

From: Quentin Schulz <quentin.schulz@cherry.de>

BB_SERVER_TIMEOUT is not documented in a glossary so we cannot refer to
it, switch to simple highlighting instead.

Fixes: b8bb48ed585d ("doc/bitbake-user-manual-ref-variables: document BB_CONSOLE_LOG's persistence")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index a61807d5d..5395ce5e3 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -143,7 +143,7 @@ overview of their function and contents.
       .. note::
 
          For more details on how to make the BitBake server persistent, see the
-         :term:`BB_SERVER_TIMEOUT` variable.
+         ``BB_SERVER_TIMEOUT`` variable.
 
    :term:`BB_CURRENTTASK`
       Contains the name of the currently running task. The name does not

-- 
2.55.0


