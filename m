Return-Path: <git@oliver-kaestner.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B669BCF2578
	for <webhook@archiver.kernel.org>; Sat, 12 Oct 2024 19:34:11 +0000 (UTC)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
 by mx.groups.io with SMTP id smtpd.web10.17705.1728761647449161851
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 12 Oct 2024 12:34:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@oliver-kaestner.de header.s=key2 header.b=eqT69J2L;
 spf=pass (domain: oliver-kaestner.de, ip: 188.68.63.166, mailfrom: git@oliver-kaestner.de)
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4XQtfZ0lycz3ssh
	for <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 21:22:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oliver-kaestner.de;
	s=key2; t=1728760934;
	bh=LiJKpejoDmnAKqIQQeOD9PRdjRO70X/9NLdw4UZtjtM=;
	h=From:To:Cc:Subject:Date:From;
	b=eqT69J2L7CJCDQbyiPB4SIZFWkGnGI8tublq/iZYxGk1tu5OPppwu/k3/zPZAQORV
	 Xht4eoqnQbixWBLi+HY8YqCp0nC4Y8e34N9NHyTHBW0liN7v+nooWaINXjIKS5UyeA
	 t8NdzBSr9AqlnribR4N04g3PdnVXT5JUhJ0JGjRjuAFtp4bD0+BmLpHjnRro0pvYWE
	 1p6Y009zIv4z5UzE9FZ57R9S2RZfGGCU+wJFpIm7HSGZJnW8RENNhd7yQILeE7VCbj
	 cClbsGo0ofKtsjidjUTf4+NimpoJ50J6695wMpdbkWhRYYyPW6MvAs4umBS4nDV1DS
	 gb0/aXtoyTHHw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4XQtfZ04Zcz3ssF
	for <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 21:22:14 +0200 (CEST)
Received: from mx2fa3.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4XQtwD5P70z8sb3
	for <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 21:34:04 +0200 (CEST)
Received: from oliver-pc.home.okaestne.de (p5de75435.dip0.t-ipconnect.de [93.231.84.53])
	by mx2fa3.netcup.net (Postfix) with ESMTPSA id EDDB2E0225;
	Sat, 12 Oct 2024 21:33:59 +0200 (CEST)
Authentication-Results: mx2fa3;
        spf=pass (sender IP is 93.231.84.53) smtp.mailfrom=git@oliver-kaestner.de smtp.helo=oliver-pc.home.okaestne.de
Received-SPF: pass (mx2fa3: connection is authenticated)
From: =?UTF-8?q?Oliver=20K=C3=A4stner?= <git@oliver-kaestner.de>
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Oliver=20K=C3=A4stner?= <git@oliver-kaestner.de>
Subject: [PATCH v2] fetch2: add GitHub Codespaces support
Date: Sat, 12 Oct 2024 21:31:35 +0200
Message-ID: <20241012193319.97250-1-git@oliver-kaestner.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-PPP-Message-ID: <172876164024.30061.3693448619814944902@mx2fa3.netcup.net>
X-Rspamd-Queue-Id: EDDB2E0225
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: He2c1jQCV3JUE4vzn7N8iu8SB2zADEOwBwqqosueKOTn0a4XvRXF
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 19:34:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16677

GitHub Codespaces allow users to use GitHub-hosted pre-configured Docker
containers to work on GitHub repositories in VS Code within the browser
or using a locally running instance of VS Code [1].

Users can define access permissions for Codespaces containers, allowing
them to clone or work with other private repositories [2].
To do this, a git credential helper is injected into the container at
/.codespaces/bin/gitcredential_github.sh, which contains the following
lines:

    #!/bin/sh
    echo protocol=3Dhttps
    echo host=3Dgithub.com
    echo path=3D
    echo username=3DPersonalAccessToken
    echo password=3D$GITHUB_TOKEN

The `GITHUB_TOKEN` environment variable is automatically set when the
Codespaces container is created. If authorized by the user, it has the
specified permissions. It is thus required to be able to fetch private
git repos from a Codespace container, so add it to `FETCH_EXPORT_VARS`
to make it available for invocations of git.

[1] https://docs.github.com/en/codespaces/overview
[2] https://docs.github.com/en/codespaces/managing-your-codespaces/managi=
ng-repository-access-for-your-codespaces

Signed-off-by: Oliver K=C3=A4stner <git@oliver-kaestner.de>
---
Add some more details about Codespaces and its injected git credential
helper.

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


