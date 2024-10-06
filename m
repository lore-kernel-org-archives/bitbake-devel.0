Return-Path: <git@oliver-kaestner.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943FDCFB424
	for <webhook@archiver.kernel.org>; Sun,  6 Oct 2024 22:27:28 +0000 (UTC)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
 by mx.groups.io with SMTP id smtpd.web11.40693.1728253644084566868
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Oct 2024 15:27:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@oliver-kaestner.de header.s=key2 header.b=KXwG3KfW;
 spf=pass (domain: oliver-kaestner.de, ip: 188.68.63.166, mailfrom: git@oliver-kaestner.de)
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4XMGpW0JRxz3s16
	for <bitbake-devel@lists.openembedded.org>; Mon,  7 Oct 2024 00:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oliver-kaestner.de;
	s=key2; t=1728252995;
	bh=/vshw/h1ff/CtsP/gIfJgZ7MDZXMV0J+tA4/lKPVBSk=;
	h=From:To:Cc:Subject:Date:From;
	b=KXwG3KfWabQ0u2gC6fsvHSvTrUN04EnnQWx/avTWmtQRaRm0ZL+dDKdhcUAO4hiFF
	 Y1X6HYCvfR/YTFjfiOL/EGje9ObSjasPyv6Q6Qwadr15bYJNwSsnSDUofhJJ8Hv+oh
	 5QV6kSEURSYsHMIxjPE5FRWoyWTFvC0Q4Bs/OivvswFWV7Y02nHET8SWf6OBCj2Et3
	 VUS+t3oysCPhsxIZHD6NoymywHfRH1cebN4xdRVeULdSeuw5gX8RKSkjr7fX291CXN
	 JE7NSs440uoywiyhlcKgui10yCE/eanpK51RpCEmFS/WCMzfqeON9G4x2RY3o5TJ3n
	 F9OEJi6KwNGHQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4XMGpV6jPXz3qTh
	for <bitbake-devel@lists.openembedded.org>; Mon,  7 Oct 2024 00:16:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mx2fa3.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4XMH2x2WZVz8tY8
	for <bitbake-devel@lists.openembedded.org>; Mon,  7 Oct 2024 00:27:21 +0200 (CEST)
Received: from oliver-pc.home.okaestne.de (p5de75435.dip0.t-ipconnect.de [93.231.84.53])
	by mx2fa3.netcup.net (Postfix) with ESMTPSA id 82685E0224;
	Mon,  7 Oct 2024 00:27:16 +0200 (CEST)
Authentication-Results: mx2fa3;
        spf=pass (sender IP is 93.231.84.53) smtp.mailfrom=git@oliver-kaestner.de smtp.helo=oliver-pc.home.okaestne.de
Received-SPF: pass (mx2fa3: connection is authenticated)
From: =?UTF-8?q?Oliver=20K=C3=A4stner?= <git@oliver-kaestner.de>
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Oliver=20K=C3=A4stner?= <git@oliver-kaestner.de>
Subject: [PATCH] fetch2: add GitHub Codespaces support
Date: Mon,  7 Oct 2024 00:26:30 +0200
Message-ID: <20241006222630.278007-1-git@oliver-kaestner.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-PPP-Message-ID: <172825363680.16520.5905454458713548167@mx2fa3.netcup.net>
X-Rspamd-Queue-Id: 82685E0224
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: 1usMQDUT6ixuJXQG/VyxXH0vYuTl2YEIAGLcrHhJn2WbmeqqkSDq
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 06 Oct 2024 22:27:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16646

GitHub Codespaces use a Git credential helper that provides access to
authorized private GitHub repos. To do this, it requires access to the
`GITHUB_TOKEN` env var, so add it to FETCH_EXPORT_VARS.

Signed-off-by: Oliver K=C3=A4stner <git@oliver-kaestner.de>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 33a8086f2..06687b018 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -878,6 +878,7 @@ FETCH_EXPORT_VARS =3D ['HOME', 'PATH',
                      'AWS_SESSION_TOKEN',
                      'GIT_CACHE_PATH',
                      'REMOTE_CONTAINERS_IPC',
+                     'GITHUB_TOKEN',
                      'SSL_CERT_DIR']
=20
 def get_fetcher_environment(d):
--=20
2.43.0


