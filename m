Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE87BC5516D
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 12:46:06 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5663.1785501962825079127
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Jul 2026 05:46:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=tpMrBVS1;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8B8481A135E
	for <bitbake-devel@lists.openembedded.org>; Fri, 31 Jul 2026 12:46:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5870F603C2
	for <bitbake-devel@lists.openembedded.org>; Fri, 31 Jul 2026 12:46:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF3D811C16807;
	Fri, 31 Jul 2026 14:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785501955; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=5l1/o0VZF3r0NmddfwO5pdvo3Ij5yUZb/kHB7PBg4Xo=;
	b=tpMrBVS1nqOrQZjYrUid0zanUey81LsN6EFf1/2/VKs5YXqSJlo7CCZ1ykAeTlns3jOOdb
	IKvK6M5cEg20BDKMnoKqsODHq4zO+4paMVc70TlycO81GQWg6WxiOB91vKfKnpBte7jASa
	L5w0K3CxfFphQlvsF/rSr2f9P1nLReypAas7nGHzzTnTFUALOqRaObyzWl5GvbSbUCcWN2
	54BaPMLT0uF37BzzVBqORv64sAQF+PWb2hRT64DApyHKTIV+6aZY1aj8JrhHRTDdXDUu5f
	eUA09L2SOkWCiJG+OvkDVgSSlmcssGfe5sbJrZfWFMFfi4lCnwES2P/2sjWlTQ==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [PATCH v2 0/2] fetch/{npm,npmsw}: fix security issue and re-enable
 fetchers
Date: Fri, 31 Jul 2026 14:45:50 +0200
Message-Id: <20260731-dev-tprrt-fix-npm-v2-0-67b65c67de4e@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ7CIBBFr9KwdgxFi9WV92i6KDC1aAsNINE0v
 btQXbp8mbz3ZyEenUZPLsVCHEbttTUJ2K4gcujMDUGrxIRRximnFSiMEGbnAvT6BWae4HCsJWc
 nVKxnJHmzw3Tamk37Zf8Ud5Qhhxqhg+gemEM4tlkYtA/WvbcfYpm131zJ/8zFEijwXuG5Ej3ta
 nEV1oZRm720E2nXdf0AGztx59UAAAA=
X-Change-ID: 20260605-dev-tprrt-fix-npm-348c627ed2f2
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 Jul 2026 12:46:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19892

The npm and npmsw fetchers were disabled in 355cd226 (Jan 2026) because
the npm fetcher retrieved checksums from the remote registry rather than
from the recipe. This series fixes the root cause and re-enables both
fetchers.

Root cause analysis
-------------------

The npm fetcher called `npm view` to resolve the tarball URL and then
embedded the registry-supplied dist.integrity / dist.shasum directly into
the proxy URL. Since the same party controls both the tarball and the
checksum, a compromised registry could serve a modified tarball with a
matching hash and bypass BitBake's tamper detection completely.

The npmsw (shrinkwrap) fetcher was caught in the same disable sweep, but
its security model is already correct: checksums come from a locally
committed npm-shrinkwrap.json file, not from the network. It needed only
a missing FetchError import fix and re-enabling.

What changes
------------

On the fetcher side, npmsw is re-enabled after adding the missing
FetchError import and fixing two correctness bugs: an empty packages dict
no longer raises FetchError ('if packages is None' replaces 'if not
packages'), and a missing 'resolved' field now raises ParameterError
instead of AttributeError.

The npm fetcher is fixed at its root: _resolve_proxy_url now stores only
the bare tarball URL in .resolved, discarding any registry-provided
checksum. _setup_proxy injects the checksum from the recipe's own SRC_URI
parameters (sha512sum= or sha256sum=) instead; uri.params is cleared
before rebuilding the proxy URL to prevent an npmsw-written .resolved
file from contaminating the npm fetcher with a registry-sourced checksum.
A checksum is now mandatory: urldata_init raises MissingParameterError
if none of sha512sum/sha256sum/sha384sum/sha1sum is present in SRC_URI.
Unlike wget, npm has no independent anchor for the fetched content (no
pinned commit, no fixed path) -- the registry is exactly the party this
fetcher was disabled for not trusting -- so, unlike the rest of
BitBake's fetchers, this requirement is unconditional and does not
depend on BB_STRICT_CHECKSUM.
version=latest is now a hard ParameterError rather than a warning, and
the dead 'if ud.version == "latest": return True' branch in need_update()
is removed since version=latest is rejected at urldata_init time. The
broad 'except Exception' in _npm_view is narrowed to json.JSONDecodeError
so that FetchError and ParameterError propagate typed to callers; the
error message falls back to str(error) when 'summary' is absent from the
registry error dict so it is never silently None.

On the test side, skipIfNoNpm() dead code is fixed, all unconditional
return-skip guards are removed from test_npmsw_* tests, and new tests
cover version=latest rejection, recipe-checksum injection, and
wrong-checksum rejection.

Migration note for recipe authors
----------------------------------

Recipes using npm:// must now supply a checksum in SRC_URI, e.g.:

  SRC_URI = "npm://registry.npmjs.org;package=lodash;version=4.17.21;sha512sum=<hex>"

Unlike the usual missing-checksum flow for other fetchers, this is not
a warn-then-continue: a recipe without one fails immediately at parse
time (MissingParameterError), before any network access is attempted.
Any stale .resolved files under DL_DIR/npm2/ written by the old fetcher
(which embedded registry-sourced checksums) must be deleted before
rebuilding.

[YOCTO #16105]

Fixes: 355cd226e072 ("fetch2/npm: Disable npm/npmsw fetchers due to security issues")
Bugzilla: https://bugzilla.yoctoproject.org/show_bug.cgi?id=16105
Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
Changes in v2:
- npm: require a checksum (sha512sum/sha256sum/sha384sum/sha1sum) in
  SRC_URI unconditionally, instead of falling back to a bb.warn() and
  an unverified download. This was raised by Richard: test_npm and
  test_npm_premirrors passed with no checksum in v1, which meant
  nothing was actually being verified for recipes that don't set one.
- tests/fetch: add a checksum to every direct npm:// fetch in the
  test suite; add test_npm_no_checksum_rejected, which confirms the
  missing-checksum error fires regardless of BB_STRICT_CHECKSUM
  (unset, '0', '1', or 'ignore').
- Link to v1: https://lore.kernel.org/r/20260616-dev-tprrt-fix-npm-v1-0-6fde95bf0a8b@bootlin.com

---
Thomas Perrot (2):
      fetch/{npm,npmsw}: re-enable fetchers now that checksums come from SRC_URI
      tests/fetch: restore and extend npm/npmsw test coverage

 lib/bb/fetch2/npm.py   | 111 +++++++++++++++++++++++++-----------------
 lib/bb/fetch2/npmsw.py |  12 ++---
 lib/bb/tests/fetch.py  | 129 +++++++++++++++++++++++++++++++++++++------------
 3 files changed, 169 insertions(+), 83 deletions(-)
---
base-commit: 7e6466f48191c1e4ab9b91705deb237eff2c7f01
change-id: 20260605-dev-tprrt-fix-npm-348c627ed2f2

Best regards,
-- 
Thomas Perrot <thomas.perrot@bootlin.com>


