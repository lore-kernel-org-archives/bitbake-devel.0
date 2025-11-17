Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E56CE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 08:16:11 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5028.1763367367784713275
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 00:16:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=u0fHkWwf;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7CEF3C12650
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:15:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8EB89606B9
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:16:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF06F10371CF2;
	Mon, 17 Nov 2025 09:16:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763367365; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=exuxfBKY59beoSUAOswzK49Q23ZXwj5MFjVXjKrX+8w=;
	b=u0fHkWwfcvd7rywV2HPo+ps1Y+RZVgckfZNofs/2Qc/yXnXu141dZlKM64vhRTcFplDKj5
	tkIZRQUQVUHkgdXazjnrKaDtSjoKKbwhBEipbnsuDfCbHnyWLZZJHLMjIG2CLcZ5Px/5G5
	MzPzHy+A0oNl/HSk7V4PuvS7R3WjfvEejMp/Pf3C0w2TIBqBxYhyf3sdZm+fos5I0gu+oG
	pK1ej9WL9NSaTBniJ30hVJ7zcQTF2RuVcf6U4Ohyw/MzC4dpFLBEDyTxCATWK/8I6KCOhG
	wBbixxBXDYS7xPo26ECC9pKDiZrFgivLNHn7j3alI/GS5DwLylVGQ1AiUzLFsw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 17 Nov 2025 09:15:37 +0100
Subject: [PATCH v2 1/3] bitbake-setup: fix top_dir creation in
 create_siteconf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-bitbake-setup-abort-v2-1-a73f44e83bc0@bootlin.com>
References: <20251117-bitbake-setup-abort-v2-0-a73f44e83bc0@bootlin.com>
In-Reply-To: <20251117-bitbake-setup-abort-v2-0-a73f44e83bc0@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=934;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=C073iM5h3Rt0VCEkrJbH98jjKQ3zxWgUnavg299Pwl0=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpGtnCBtLGqWn9HttHIBiSUZAUFGCBb8ZBtiiYm
 fj4VOMe9g+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRrZwgAKCRDRgEFAKaOo
 NhvfEACjqlEalfv53OTdDkAnODnGSWmVTtsIGk5yxWdvVgPcWmSVH0AjkKCBUpbOQacPTABfpjh
 FIOBHNQO7KkxKvJN5ZdiJEv9x1GjtTsWepTAnS+JlNl/Xj2gU0LLHpUkOq+K1G2ZngzHv82xU0j
 zQcRx0pSsO1YxF9OwYX5s5fImz0Bdzu/TmAJq1polYbUIUimSYsvqiz3enoV9GcxyqD1qHj+vAj
 xM3AkXmdzeojGSJIlaZipcErUzQE3IAH1UpcHppbUScP6KzK1icaIEs6jFN+TOeVjyxuihEzUBM
 TJPRNtB0EyTVMgav5h6vy6sdrA/RuJ/wpMzCynZkMCcq11DbmAYaAuxyzNU6A3jSkz38TOm6olX
 CDutUhcMSKp2bempQYhwEwmwLH9Ct51iROHlw9jsYoi/2hH1eHNF0yDjuVS87gtT7zLXNMGXGDd
 cQpkxe72Qzsmn91DzOqtKuETdGlZr9OXhhi4lGPGiyCGzskvwOMwlErK+/s12xEa0BwbEwI75XI
 qbmniV+egaZh83QK853TJ007pvSpFIMF7zMYd2MDcA6ugT5KPNFA+F6rYUZ3irAFRff83FO3CEz
 uJji+n5l6gG6u+Wg1tOwUXaLQu9wEs4+wiAmwHX+4boxD6nwkTthMR5mBQ/PCm6GU+ujkFvV4/p
 suyNSqsPjutEYNA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:16:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18416

The intent of the create_siteconf() is to create the site.conf file
common to all setups. For this it needs the top directory to be created.
Create the top directory instead of its parent.

Previously, this directory was created by chance by init_bb_cache().

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 3a281defac..adf19ab09f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -677,7 +677,7 @@ def create_siteconf(top_dir, non_interactive, settings):
             if y_or_n != 'y':
                 exit()
 
-        os.makedirs(os.path.dirname(top_dir), exist_ok=True)
+        os.makedirs(top_dir, exist_ok=True)
         with open(siteconfpath, 'w') as siteconffile:
             siteconffile.write(
                 textwrap.dedent(

-- 
2.51.0


