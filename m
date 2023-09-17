Return-Path: <develop@schnelte.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AB9CD37B4
	for <webhook@archiver.kernel.org>; Sun, 17 Sep 2023 12:31:20 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by mx.groups.io with SMTP id smtpd.web10.28738.1694953877315775267
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Sep 2023 05:31:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: schnelte.de, ip: 217.72.192.73, mailfrom: develop@schnelte.de)
Received: from [192.168.178.56] ([91.33.147.138]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAORp-1qsYJd3AGx-00BvOd for <bitbake-devel@lists.openembedded.org>; Sun, 17
 Sep 2023 14:31:14 +0200
Message-ID: <ccc1cddd-3dee-4495-b41c-2dee2b2fe238@schnelte.de>
Date: Sun, 17 Sep 2023 14:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bitbake-devel@lists.openembedded.org
Content-Language: en-US
From: Matthias Schnelte <develop@schnelte.de>
Subject: [PATCH v2] fetch2: Adds vscode devcontainer support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6CBERwkz4cqifja7s4KQDtPiS8Y9e+WwzstIvRzggXf7apn2RTW
 M6UQ2kWerrxFHFtwZEUDf9Qrjsd5z3OygWgLmu+rTFTl0vfS+05BAJPfgrOzApk+E8c+JIw
 aeJ1OlTPLeR7yslroZVDE8aJWZaTIF+iloe3ADjrZ/MNDTXahWCNrFfRzUY3OTlL3y5z2oH
 UOzRk/OMRNgYJDt+N2sAg==
UI-OutboundReport: notjunk:1;M01:P0:doHpofq2iF0=;OqhwLi9rgT9xhRS/BAuHyB9SKMv
 xpAtUoch9z1yfP90WtxoWNGBS1KzVKIJkf7rZJh+z0cL9clXTMAIxdHj8rnPUnAzlfGVCfqwW
 86YaRfxeLg0Y7kjHQyYbV/jpOTmPZ1GvChxCt8Z0ei5dy1ha0EwEDIC1Qfy5lVCn6yngDH1gd
 qAcnbawHm8jSqWOAzhsD3RjWokqFkpvTeXWGjeYqj9MoCOLZyhiHGEyBPvvv5nW2vE5AI4qGk
 eiAkPiAaIYXU/p0dVdV8CQFQ2VaJcOqb//tTOYcZue9Go6xltsTUVlf5DMX1qBpwL6yqM5DCp
 UnCZ45IICeONhNKaiOQALUeRsFEJFjEyVCm/anb412jnRB8+gw5txw3dVyKnFcnTNP1lTr26T
 KDCERJuaq6TPw1yX0k0qTXVvORdl8nY9nhCdJOj/dcrex1VpYvrr6NR7cUCgGs4PM/XFCdrXD
 jTqgHKwPS6Y7rprvllaYb4EDYDCKBMriRnxAj+d7t5fQIKF5d1J6MdiWeiAd3Cbw6+7Ct5p7z
 zSqght/drvT6TvDBb04DkFGMLxFXmlwt2f4Et5Bqv9+LimBIkDiJboxt4UncmQ/g8uUtMPuVd
 a80xqem7xI68O0sP8WETEr7ZRIJsLps0Vw/1pHQQlmUaY6q2Ah6bP5J0JT0lYFXJdc3gWcZs6
 UJ52pA5a/P63fJZxrmBkQJMdJ29NRaL4cGkpsBXyueHyNWu61uuQwNCwwOA5rW0c6UH7Kv4QN
 3FUSY+N3vjnaL80SZrextcrQppCV7k/5K7fayw/aNgYfVdbxGm8pL7tBOL6t37U+8O1onxjFW
 O5nfnltg06+yZyApaLRHJHhfznrBrO/eaOvvlXVT1Rgu734aCPKkCTU5GOvwZZbu2MsfaHAYQ
 25/Vgdnp4TU+DIg==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 17 Sep 2023 12:31:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15073

Visual studio code is injecting a git credential helper
into every dev container. This helper is forwarding the git credentials
from the host into the container.

In order for this helper to work the REMOTE_CONTAINERS_IPC
needs to be available in the environment for all git operations
that require authentication.

v2: Added signed-off

Signed-off-by: Matthias Schnelte <develop@schnelte.de>
---
  lib/bb/fetch2/__init__.py | 1 +
  1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 765aedd5..ffb1a92b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -874,6 +874,7 @@ FETCH_EXPORT_VARS = ['HOME', 'PATH',
                       'AWS_SECRET_ACCESS_KEY',
                       'AWS_DEFAULT_REGION',
                       'GIT_CACHE_PATH',
+                     'REMOTE_CONTAINERS_IPC',
                       'SSL_CERT_DIR']

  def get_fetcher_environment(d):
-- 
2.42.0


