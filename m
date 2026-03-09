Return-Path: <pascal.eberhard@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4DDFCC9A2
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 23:31:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28531.1773099105366453658
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 16:31:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=f18DzLkj;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: devnull+pascal.eberhard.se.com@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A5ABB434A4;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8616DC2BCB0;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773099104;
	bh=cvbiLheeJnhWQf/i0mAc32p4j272BkKF0rHKq4OAZSo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f18DzLkjMZ6pPgoCMWPGUYv23geTEiey6h6oAK3HrZ8cLHOaInbYEXe4OqBjRxeck
	 +P350/2TrSuH8RKusyo/ZhoNaEmhbGZ3tOvdAzS51Dpc8nCdFOTQFSHkFOuyaX9kRC
	 5Ompf+IVA7VaCEtShe7GW7YzALdHaqrA5b9NVTTqDvklRYVNRYifa1/GEBOF7RJ1bY
	 m9qakJpj/tgIb01ABrPBbh0BwAeVsN9Wa06G4y0vGf/9GSmPh2XwYfRfBXwIGf2pAf
	 jOj65cRGe/HpajMRCQLqtgVSyLlK7URlB/iep7Ju8/yJtdZXlSVOH1e1bd/vthqj+I
	 FvmcHZ3wmuMqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B99DFCA16F;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
From: Pascal Eberhard via B4 Relay <devnull+pascal.eberhard.se.com@kernel.org>
Date: Tue, 10 Mar 2026 00:29:41 +0100
Subject: [PATCH v2 4/4] doc: bitbake-user-manual-ref-variables: describe
 BB_FETCH_METHOD_HTTP variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-add_alt_fetch_method_curl-v2-4-4789639b28f1@se.com>
References: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
In-Reply-To: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
To: bitbake-devel@lists.openembedded.org
Cc: Pascal Eberhard <pascal.eberhard@se.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773099103; l=1168;
 i=pascal.eberhard@se.com; s=20260304; h=from:subject:message-id;
 bh=mMN0eDTcP33G0a41mnOnUsgTrlLpjDXr5F9CTc4gENE=;
 b=tCoOqYT9U8lc+3v45Zk2wD/AotwoTq55GzTJzxnDpMj+cD/Fa10N+AFP1hQHU/3LZqRfYhWgc
 zlKbv2tgStqButDIcDaFdwSiDSvTK62jjEljlfkHtuSKCd+3hDqFhJv
X-Developer-Key: i=pascal.eberhard@se.com; a=ed25519;
 pk=J7TbFctjt1RVuN5K0juhf/w1E9bAfSeoQ/JG1vV9mWg=
X-Endpoint-Received: by B4 Relay for pascal.eberhard@se.com/20260304 with
 auth_id=661
X-Original-From: Pascal Eberhard <pascal.eberhard@se.com>
Reply-To: pascal.eberhard@se.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 23:31:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19135

From: Pascal Eberhard <pascal.eberhard@se.com>

add BB_FETCH_METHOD_HTTP variable to select between wget and curl method
for http, https, ftp, ftps protocols.

Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 06bd53619..c459ed3af 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -311,6 +311,11 @@ overview of their function and contents.
       search the main :term:`SRC_URI` or
       :term:`MIRRORS`.
 
+   :term:`BB_FETCH_METHOD_HTTP`
+      When set to "curl", cause BitBake's fetcher to use curl method for
+      downloading web artifacts via http, https, ftp or ftps.
+      When not set (default) or set to "wget", wget method is used.
+
    :term:`BB_FILENAME`
       Contains the filename of the recipe that owns the currently running
       task. For example, if the ``do_fetch`` task that resides in the

-- 
2.43.0



