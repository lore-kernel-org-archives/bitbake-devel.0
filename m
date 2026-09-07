Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94A4C79FA0
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 15:47:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38397.1788796017685507271
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2026 08:46:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=lL+JQ2DE;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5971A1476
	for <bitbake-devel@lists.openembedded.org>; Mon,  7 Sep 2026 08:46:53 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A8A693F7B4
	for <bitbake-devel@lists.openembedded.org>; Mon,  7 Sep 2026 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788796017; bh=RXQqHZfDHEHnsbU5TXSHkwLdIHD614Na31d5t6OimDU=;
	h=From:To:Subject:Date:From;
	b=lL+JQ2DEcONtX35ktR7zXmj0PsPv+tosDi9owaSFhEklWmXzSWRR8DNRcVJF3qdmQ
	 ZDPmpdBroFf8RgMGaPHy5STlRnoAZMo/mPGBc7Dj1wg9vLX7hWGVlHmDWL46m4gw5v
	 G8XEQDkdDe9gqh8yeP52xUAgRHtPhAti87Oa9AbQ=
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] vendor.txt: add tomli
Date: Mon,  7 Sep 2026 16:46:53 +0100
Message-ID: <20260907154654.32166-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 15:47:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20166

tomli is the standalone TOML parser that became tomllib in Python 3.11.

Add it to the vendored libraries so that bitbake/OE can always have a
TOML parser.  When bitbake depends on 3.11 onwards, this can be dropped.

TOML is increasingly used as a sensible configuration file format, for
example Python's pyproject.toml and Rust's Cargo.toml.  Currently OE has
code to parse Cargo.toml with a nested nativepython3, and pyproject.toml
with regular expressions.  By vendoring tomli into bitbake we can just
import it directly and use it without needing to use nativepython3:

  try:
    import tomllib
  except ImportError
    import bb._vendor.tomli as tomllib

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 vendor.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vendor.txt b/vendor.txt
index 6ce8846c8c..8d5dcad77e 100644
--- a/vendor.txt
+++ b/vendor.txt
@@ -3,3 +3,4 @@ ply=3D=3D3.10
 progressbar=3D=3D2.5
 simplediff=3D=3D1.1
 typing_extensions=3D=3D4.15.0
+tomli=3D=3D2.4.1
--=20
2.43.0


