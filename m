Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1C2CD8CB9
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 15:47:10 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23917.1781106426014581508
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 08:47:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=0EE8yoy+;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AB171C4FEDD
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:47:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8BB35FFC9
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:47:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55B84106B9AFB;
	Wed, 10 Jun 2026 17:47:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781106423; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=FOmjVE/e7318I2pFf01s7DWMmFF/NV0Kj9BtpjmZLcc=;
	b=0EE8yoy+nWV25l9ljmdUU3vheKrcvwKwZSxZNH0NEzks0KoXUU+E+/yT3ilyOujZNXcQgR
	1EHmne9opomM+vg0cqCZTk/evsaaOYXP4kGYJw1QIMGk1FCFPnUWNYnGIr4nfQHujaNl7C
	/JRTpaYqLzfYh7siH19CzXV5zcLjH5s3a14XKHO34T9s464+rrNE/HNFMsxG0cuT62Lpbw
	7+/moPn5DBdg7XMeWxzPkH2UOWsFApyTJ1Q6XIUSEF+3m7UI/RnIThgLKcHSX9bEieIoSp
	/4Wr6/insKdNiPftz2f7e1sXlL5vH9bkf+wopwVyeuGw2KfskucDNCapQ2nBwA==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [bitbake-devel][PATCH 0/2] fetch/npm: fix security issue and
 re-enable fetcher
Date: Wed, 10 Jun 2026 17:46:59 +0200
Message-Id: <20260610-dev-tprrt-fix-npm-v1-0-9bf501d4ee0e@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywrCMBCF4Vcps3YgjjWKr1K6aJKpjpcYJrEUS
 t/dVJc/h/MtkFmFM1yaBZQnyfKONfa7BvxtiFdGCbWBDFljzREDT1iSasFRZozphYf27C2dONB
 IUH9JuU4/s+v/nT/uzr5sUOekuOHBG8TPHtb1CzLTk4yEAAAA
X-Change-ID: 20260605-dev-tprrt-fix-npm-348c627ed2f2
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:47:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19645

The npm fetcher was disabled in 355cd226 (Jan 2026) because it retrieved
checksums from the remote registry rather than from the recipe.  A
compromised registry controls both the tarball and its advertised hash,
making checksum verification meaningless.

Fix the root cause by separating URL resolution from checksum handling:
- _resolve_proxy_url now stores only the bare tarball URL in the .resolved
  file; the registry-supplied dist.integrity / dist.shasum values are
  ignored entirely.
- _setup_proxy builds the proxy URL from that bare tarball URL and injects
  the checksum from the recipe's own SRC_URI parameters (sha512sum=,
  sha256sum=, etc.).  When no checksum is provided the proxy URL carries
  none, and BitBake's standard BB_STRICT_CHECKSUM machinery handles the
  missing-checksum case the same way the wget fetcher does.  A bb.warn()
  is emitted so recipe authors get a clear signal instead of a silent
  unsigned download.
- version=latest is now a hard ParameterError instead of a warning; it is
  inherently non-reproducible.
- Narrow the broad 'except Exception' in _npm_view to json.JSONDecodeError
  so that FetchError and ParameterError propagate typed to callers.  Also
  fall back to str(error) when 'summary' is absent in the registry error
  dict so the message is never silently None.
- Clear uri.params before rebuilding the proxy URL to prevent a
  .resolved file written by the npmsw fetcher (which stores the full URI
  with checksum params) from contaminating the npm proxy URL with a
  registry-sourced checksum, bypassing the security invariant that only
  recipe-provided checksums are trusted.
- Remove dead 'if ud.version == "latest": return True' branch from
  need_update(); version=latest is rejected at urldata_init time.

Migration note: recipes using npm:// must now supply a checksum in
SRC_URI, e.g.:

  SRC_URI = "npm://registry.npmjs.org;package=lodash;version=4.17.21;sha512sum=<hex>"

On the first build without a checksum BitBake will download the tarball,
compute the hash, and instruct the author to add it.  Any stale .resolved
files under DL_DIR/npm2/ written by the old fetcher (which embedded
registry-sourced checksums) must be deleted before rebuilding.

[YOCTO #16105]

Fixes: 355cd226e072 ("fetch2/npm: Disable npm/npmsw fetchers due to security issues")
Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
Thomas Perrot (2):
      fetch/npmsw: fix security issue and re-enable fetcher
      tests/fetch: restore and extend npm/npmsw test coverage

 lib/bb/fetch2/npmsw.py | 12 +++++-----
 lib/bb/tests/fetch.py  | 64 +++++++++++++++++++++++++++++++++++---------------
 2 files changed, 51 insertions(+), 25 deletions(-)
---
base-commit: d6bc0e5ec549a4f984cb3d470dd3c04d0ea46fde
change-id: 20260605-dev-tprrt-fix-npm-348c627ed2f2

Best regards,
--  
Thomas Perrot <thomas.perrot@bootlin.com>


