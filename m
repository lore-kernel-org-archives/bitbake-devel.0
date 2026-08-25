Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C30C61DC7
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 13:03:15 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20922.1787662987774845801
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 06:03:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=KtObPjxb;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8D4DE4E4137A;
	Tue, 25 Aug 2026 13:03:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 615AE604C4;
	Tue, 25 Aug 2026 13:03:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9A9211C794A6;
	Tue, 25 Aug 2026 15:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787662984; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=9m7nOoiAEPttx8sU69Yc1kBYF5niWiHcqbA8+hyr4Gc=;
	b=KtObPjxbfmYu1v+laKQL9FLN6KOruGz8StSZgAit0lhQ3ViOcIQ+efuJjivj7HxYa4MCe7
	fIfMbzfSGtPv6DxvHoDhks9mCsdW4Hc/ku1glQTF/ROgk8R8VuyJ3Furoenj8ekEq6BXRs
	rc+kN0xamiU8DW4NUlHPDZGtHCBUt2RoJtpbZjOGiA+6VcrbuDct4SFePsYUhI18V3U6X9
	DqcLSFsLp5GhLhba9kM+VMGcJ8Sb4asZQpGWkcwbK3yPlch34BN184r8iSMu2Bo8KBj0bI
	zAGu6xVBSK2YcW5cXD61G5oRSrhlEy6KLBnGOSLB//lxoc0HIUKC0i32BICMMg==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [2.18][PATCH 0/2] fetch/{npm,npmsw}: fix security issue and
 re-enable fetchers
Date: Tue, 25 Aug 2026 15:02:56 +0200
Message-Id: <20260825-enable-npmsw-fetcher-wrynose-v1-0-425c8cc1e111@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBAF0KuQWTsGRrHEqxAWtHykRgvpoGgId
 7fq8m3eSorooXTOVop4evVjSCh2GbmhDRew75JJcjnllZSM0NobOEx3XbjH7AZEXuI7jAqW0hy
 7gzFwYikVU0TvX7++bv7Wh73Czd+zln1RNbRtH4NOaveGAAAA
X-Change-ID: 20260825-enable-npmsw-fetcher-wrynose-2574d377ec2b
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3855;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Gy2tXHMVd9r0jHfNONhBQQcIFcK4TAiII3v+fNy7H04=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqjZKGxwQOuWzxOHOHBOJhYwau7Qe1YFajGYhNh
 /4lesYRd8mJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCao2ShgAKCRDRgEFAKaOo
 NhXWEACnbspG6lYm2H+lCxN8aNk1rjSTYowGN0gwI1RSLdRT+8M/F0LbBbndJblbF3krNI1ujnf
 boEkqqPuVGLlAp+Hqa3qT4nSCbw/2rloXrOEfFrmG2VXpwmm3jC1kLUSsIfozDoIPJ1if1cFNs1
 s4m/nfpPs+RICwJhHFWz93Nd89p5wLk/PLtG0AHjTlbqSYIhmiJiFnZdKeFrBsSER9Xq7+jIAta
 gGi7eymJKemB5sXDukfbpYm95YCWEMkjJznzk0hHjZtWs2eIDUoln3+6CEE0l7DL0wcQ3+0MeON
 VNY3wmV27NjT6V1seV6dfCFMmiy5mxJyZeYNgPXFO2DgFPusZYmjuia31AXMcc+oL7BrvYBwvXg
 aTJjo3heqRJcRihGS0pKR7q89H8ISAQb119f5PIB9a1PEc3SGKILtq4G9P7PuUSpvVrtnKzLO1e
 TsOBJ3XTSG2qYeDAyi7+NVsaQ2VFMxvixdXRSWbdmNwIVXjvJDdMqCPP1EW7XmsqjxYNfZdXZdb
 sKLNlXqRM9IpvwxeQOHoqxKws3jwjK1k4naUegTyuvB1cIezAr93HZxK5kKvckKAbe9bmCbOF6G
 6mCe2W3FnxbWJ+GZQ0LZ3EwzX19n7u5oEbzJfqBD3J1W0fE8Cp6MJ5pTNmYoN0+LtjBg6GN00j6
 zavHz3NTyrdWKeQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 13:03:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20034

This is a proposal to backport patches re-enabling the npm and npmsw
fetcher on 2.18 (Wrynose). The two patches from this series are simple
cherry-picks, and had no conflicts applying.

Applying these two patches locally is also fine to me, but as this seems
to be working as-is I figured this might be helpful to others - up to the
maintainer(s) to decide.

Tests are passing locally:

$ bitbake-selftest -v bb.tests.fetch.NPMTest
test_npm (bb.tests.fetch.NPMTest.test_npm) ... ok
test_npm_bad_checksum (bb.tests.fetch.NPMTest.test_npm_bad_checksum) ... ok
test_npm_bad_recipe_checksum_rejected (bb.tests.fetch.NPMTest.test_npm_bad_recipe_checksum_rejected)
A wrong sha512sum param in SRC_URI causes the fetch to fail. ... ok
test_npm_destsuffix_downloadfilename (bb.tests.fetch.NPMTest.test_npm_destsuffix_downloadfilename) ... ok
test_npm_mirrors (bb.tests.fetch.NPMTest.test_npm_mirrors) ... ok
test_npm_no_checksum_rejected (bb.tests.fetch.NPMTest.test_npm_no_checksum_rejected)
A missing checksum in SRC_URI is rejected regardless of BB_STRICT_CHECKSUM. ... ok
test_npm_no_network_no_tarball (bb.tests.fetch.NPMTest.test_npm_no_network_no_tarball) ... ok
test_npm_no_network_with_tarball (bb.tests.fetch.NPMTest.test_npm_no_network_with_tarball) ... ok
test_npm_package_invalid (bb.tests.fetch.NPMTest.test_npm_package_invalid) ... ok
test_npm_package_none (bb.tests.fetch.NPMTest.test_npm_package_none) ... ok
test_npm_premirrors (bb.tests.fetch.NPMTest.test_npm_premirrors) ... ok
test_npm_premirrors_with_specified_filename (bb.tests.fetch.NPMTest.test_npm_premirrors_with_specified_filename) ... ok
test_npm_recipe_checksum (bb.tests.fetch.NPMTest.test_npm_recipe_checksum)
A sha512sum param in SRC_URI is forwarded to the proxy and verified. ... ok
test_npm_registry_alternate (bb.tests.fetch.NPMTest.test_npm_registry_alternate) ... ok
test_npm_registry_invalid (bb.tests.fetch.NPMTest.test_npm_registry_invalid) ... ok
test_npm_registry_none (bb.tests.fetch.NPMTest.test_npm_registry_none) ... ok
test_npm_version_invalid (bb.tests.fetch.NPMTest.test_npm_version_invalid) ... ok
test_npm_version_latest_rejected (bb.tests.fetch.NPMTest.test_npm_version_latest_rejected) ... ok
test_npm_version_none (bb.tests.fetch.NPMTest.test_npm_version_none) ... ok
test_npmsw (bb.tests.fetch.NPMTest.test_npmsw) ... ok
test_npmsw_bad_checksum (bb.tests.fetch.NPMTest.test_npmsw_bad_checksum) ... ok
test_npmsw_bundled (bb.tests.fetch.NPMTest.test_npmsw_bundled) ... ok
test_npmsw_destsuffix (bb.tests.fetch.NPMTest.test_npmsw_destsuffix) ... ok
test_npmsw_dev (bb.tests.fetch.NPMTest.test_npmsw_dev) ... ok
test_npmsw_git (bb.tests.fetch.NPMTest.test_npmsw_git) ... ok
test_npmsw_mirrors (bb.tests.fetch.NPMTest.test_npmsw_mirrors) ... ok
test_npmsw_no_network_no_tarball (bb.tests.fetch.NPMTest.test_npmsw_no_network_no_tarball) ... ok
test_npmsw_no_network_with_tarball (bb.tests.fetch.NPMTest.test_npmsw_no_network_with_tarball) ... ok
test_npmsw_npm_reusability (bb.tests.fetch.NPMTest.test_npmsw_npm_reusability) ... ok
test_npmsw_premirrors (bb.tests.fetch.NPMTest.test_npmsw_premirrors) ... ok

----------------------------------------------------------------------
Ran 30 tests in 101.185s

OK

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Thomas Perrot (2):
      fetch/{npm,npmsw}: re-enable fetchers now that checksums come from SRC_URI
      tests/fetch: restore and extend npm/npmsw test coverage

 lib/bb/fetch2/npm.py   | 111 +++++++++++++++++++++++++-----------------
 lib/bb/fetch2/npmsw.py |  12 ++---
 lib/bb/tests/fetch.py  | 129 +++++++++++++++++++++++++++++++++++++------------
 3 files changed, 169 insertions(+), 83 deletions(-)
---
base-commit: 0ad6c1c34a5e07a5f8dd66ab248c1e7b37b69fa9
change-id: 20260825-enable-npmsw-fetcher-wrynose-2574d377ec2b


