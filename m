Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310CACE7B08
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 13:27:50 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17976.1763126862979596736
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 05:27:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=1A2iauxz;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7A1531A1AA1
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 13:27:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 513BB6060E
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 13:27:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 970FA10371C35;
	Fri, 14 Nov 2025 14:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763126860; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tBqrPPeUwRqLZtuh/68VfHCMLML1M54Q0VQfN5Bv3D4=;
	b=1A2iauxzDdj2rxiI97gG+hrcjk9avFr+jIjpzvmvs3KaG0dcoEWj8l/uV4KzByLvFMwfTy
	1nMaaP4/JTgGy/tXcvBb9uLaTozOdxJTIHVjfpOm0iudZ87pAGjwSMhymVHKnF8QWaVL4G
	EilT4A4AHd3AmXQKgAXQy5UmpDIo10q1mOpZ59u5xecUsUedbHGQpxGzYTPqb+25Acgdnk
	NvlVkP7FaEaTtu9zrCyJ1nXBYmJu+d44ZKLSwRKKeURpYunYvZkM3wbHNE/2LRoOYukLHz
	8DDKVS2UQrm0YsPsDol9fNR8VFqDCfChT+GzrxlbFzZr0WyBdifjtRiYiXQdXg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 14 Nov 2025 14:27:33 +0100
Subject: [PATCH 1/2] data: Escape back quotes in environment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mathieu-back_quote_devshell-v1-1-45e83df2f362@bootlin.com>
References: <20251114-mathieu-back_quote_devshell-v1-0-45e83df2f362@bootlin.com>
In-Reply-To: <20251114-mathieu-back_quote_devshell-v1-0-45e83df2f362@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763126859; l=878;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=2L7+TrW6TDnbXvMq55J5TTGDPOjlcS8tIGDHHkmG2NU=;
 b=XGU1DXrZ59seb5cKGol/uTVZMJgyzKTktYo4P450HjApME9r8LvMRJjal2e4h1VMKX4ptFjLl
 p9hGUbxn7UgDyut9x5kZNiAwzBKAc8ak/XwqjFInmw9iN+VJGmk9vCW
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 13:27:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18400

Escape back quotes in environment variables while generating environment
files, as otherwise they will generate a parsing error:
unexpected EOF while looking for matching ``'

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 lib/bb/data.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index f672a844518d..061e63386f04 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -171,6 +171,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
     # if we're going to output this within doublequotes,
     # to a shell, we need to escape the quotes in the var
     alter = re.sub('"', '\\"', val)
+    alter = re.sub('`', '\\`', alter)
     alter = re.sub('\n', ' \\\n', alter)
     alter = re.sub('\\$', '\\\\$', alter)
     o.write('%s="%s"\n' % (varExpanded, alter))

-- 
2.47.3


