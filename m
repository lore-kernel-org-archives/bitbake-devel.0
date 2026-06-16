Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BE0CD98DA
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 13:37:38 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.154658.1781617056560994316
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 06:37:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=mTQHBCjx;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3B97BC2BB32
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 13:37:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A39DF601A9
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 13:37:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 068B6106C9D50;
	Tue, 16 Jun 2026 15:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781617039; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=U9pn3R/48PUtzx6zLzuLtmZ49OX9BZHZSFUKFoNK2vI=;
	b=mTQHBCjx5UbpKA7CjDBsoU6nrBQuwcORRCwEdfmeOHOomxrfF4HQWmWXFD80uvxTNBElks
	IKmn3dQ+qsryFban7LjuJQ+bze0FpmBeMZXXOpUlprsc7NdUwTA9LkdoTzXhHbd+IFvI21
	dAsOv8pFw7up/j1box8fGLLWj+3kA8O96HzZOztgIqSzV6C/4sTq/p5zmNK5buViMnoIQ/
	gyBAMX5eJnZFy7eJFSnNSlmu2QtTBjDfos7835HJoK6aJBtGwzEfMeUsQZA46AKRy5TIc4
	n49CJ4VU4roSqevbqA/mvD78FnvJ8qXd77G/P/kY12Gkxd9IYUtvQwH+X+c9bw==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [PATCH 0/2] fetch/{npm,npmsw}: fix security issue and re-enable
 fetchers
Date: Tue, 16 Jun 2026 15:37:03 +0200
Message-Id: <20260616-dev-tprrt-fix-npm-v1-0-6fde95bf0a8b@bootlin.com>
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
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 13:37:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19705

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
When no checksum is present in ud.parm, bb.warn() is emitted so recipe
authors get a clear signal instead of a silent unsigned download.
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

On the first build without a checksum BitBake will download the
tarball, compute the hash, and instruct the author to add it. Any
stale .resolved files under DL_DIR/npm2/ written by the old fetcher
(which embedded registry-sourced checksums) must be deleted before
rebuilding.

[YOCTO #16105]

Fixes: 355cd226e072 ("fetch2/npm: Disable npm/npmsw fetchers due to security issues")
Bugzilla: https://bugzilla.yoctoproject.org/show_bug.cgi?id=16105
Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
Thomas Perrot (2):
      fetch/{npm,npmsw}: fix security issue and re-enable fetchers
      tests/fetch: restore and extend npm/npmsw test coverage

 lib/bb/fetch2/npm.py   | 94 ++++++++++++++++++++++++++------------------------
 lib/bb/fetch2/npmsw.py | 12 +++----
 lib/bb/tests/fetch.py  | 64 ++++++++++++++++++++++++----------
 3 files changed, 100 insertions(+), 70 deletions(-)
---
base-commit: 7e6466f48191c1e4ab9b91705deb237eff2c7f01
change-id: 20260605-dev-tprrt-fix-npm-348c627ed2f2

Best regards,
-- 
Thomas Perrot <thomas.perrot@bootlin.com>


