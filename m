Return-Path: <l.goehrs@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3690C282C6
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 09:09:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web10.6937.1740647343971580965
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 01:09:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: lgo@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <lgo@pengutronix.de>)
	id 1tnZt8-0002I8-28; Thu, 27 Feb 2025 10:09:02 +0100
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tnZt7-0036DD-1Q;
	Thu, 27 Feb 2025 10:09:01 +0100
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tnZt7-006qeW-0x;
	Thu, 27 Feb 2025 10:09:01 +0100
From: =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	yocto@pengutronix.de
Subject: [PATCH v2 0/5] fetch2/github_release_artifact: fetcher for (private) release artifacts
Date: Thu, 27 Feb 2025 10:08:48 +0100
Message-Id: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 09:09:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17338

This fetcher enables downloading artifacts attached to GitHub releases
in private repositories.

Authentication is provided using tokens via the `GH_TOKEN` variable
or a `token=` URI parameter.

Changes from v1:

  - Provide examples on how to provide the `GH_TOKEN` more securely than
    just hardcoding it in the recipe in the commit message.
    E.g. via the `local.conf` or environment variables.
  - Indent the code example in the documentation `.rst` using three
    spaces instead of two.
  - Document the `token=` URI parameter along with the `GH_TOKEN`
    variable.

Thanks to Alexander Kanavin and Antonin Godard for their review feedback
so far.



