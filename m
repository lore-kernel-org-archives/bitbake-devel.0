Return-Path: <l.goehrs@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092C5C28B2F
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 12:01:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web10.9448.1741348863402819237
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 04:01:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: lgo@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <lgo@pengutronix.de>)
	id 1tqWNx-0006hI-R0; Fri, 07 Mar 2025 13:01:01 +0100
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tqWNw-004Tkt-2g;
	Fri, 07 Mar 2025 13:01:00 +0100
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tqWNw-0088rO-2A;
	Fri, 07 Mar 2025 13:01:00 +0100
From: =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	yocto@pengutronix.de
Subject: [PATCH v3 0/5] fetch2/github_release_artifact: fetcher for (private) release artifacts
Date: Fri,  7 Mar 2025 13:00:50 +0100
Message-Id: <20250307120055.1816436-1-l.goehrs@pengutronix.de>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 12:01:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17403

This fetcher enables downloading artifacts attached to GitHub releases
in private repositories.

Authentication is provided using tokens via the `BB_FETCH_GHRA_TOKEN`
variable.

Changes from v1 to v2:

  - Provide examples on how to provide the `GH_TOKEN` more securely than
    just hardcoding it in the recipe in the commit message.
    E.g. via the `local.conf` or environment variables.
  - Indent the code example in the documentation `.rst` using three
    spaces instead of two.
  - Document the `token=` URI parameter along with the `GH_TOKEN`
    variable.

Changes from v2 to v3:

  - Rename `FetchData.headers` to `FetchData.http_headers` and do not set
    a default. Use `getattr` with a default instead.
  - Rename the token variable from `GH_TOKEN` (the de-facto default in
    GitHub actions) to `BB_FETCH_GHRA_TOKEN` (makes it more obvious where
    the variable is used).
  - Remove support for supplying the GitHub token as SRC_URI parameter
    to make it less likely that they are accidentally leaked, when e.g.
    sharing the recipe.
  - Do not use `dict_a | dict_b` to merge the header dicts,
    as that feature is not available in Python 3.8 used on Ubuntu 20.04.
    Use `dict(**dict_a, **dict_b)` instead.
  - Explicitly state in the documentation that access tokens should have
    minimal scope.

Alexander Kanavin and Peter Marko have voiced some security concerns about
the token handling in bitbake variables that have not been adressed in
this v3.

The security of the current solution should be on par or better than
what we have for `http` URLs that include basic auth usernames and
passwords. I consider this acceptable.

A generic way to store these kinds of fetcher secrets outside of the
normal bitbake variables would be desirable though.



