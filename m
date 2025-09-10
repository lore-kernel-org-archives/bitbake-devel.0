Return-Path: <patrick.vogelaar.dev@mailbox.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676DECA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 14:55:12 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.web11.20464.1757516101893792490
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 07:55:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=DtnNknsl;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=CYtClDaN;
 spf=pass (domain: mailbox.org, ip: 80.241.56.152, mailfrom: patrick.vogelaar.dev@mailbox.org)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cMNyW3hQKz9v4D;
	Wed, 10 Sep 2025 16:54:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757516099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ug5v62dNN3QSmbts7Q/nxZG7ewHSz8FpjJKg4MEMSaY=;
	b=DtnNknslNxQ5Yn9L66Z1TtwNGIyDtFdZpvd0vgCW2HNaKiQacIvapCEBRPciT3HnMOcQON
	DrBP+hzOh53HB7BaJu5z/DTuTMZh+/uFmreN4Kq7SuynJdEHmaVHA5Ps0RgFStgz8Y7Ldc
	zCBVqCoSRx0ILSdLZDbdedQ3UlAl+ceHGU/ejipRnbcM5V0ZhfOo4Vp4+/ZaaxIjgYvm0p
	Eu0/Wdgofvvr4zireSj/RScTEjj2TdE5wwSn64EzoIqeQOhbpyPUIeZ9wpjzBXjhrApsuU
	fKwn8q/qjIlVtoZ7X25PwIHUOrdwbnMfMEw4S6+h7VvAS9ZniUwEate/ohoomg==
From: Patrick Vogelaar <patrick.vogelaar.dev@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757516097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ug5v62dNN3QSmbts7Q/nxZG7ewHSz8FpjJKg4MEMSaY=;
	b=CYtClDaN+fJ6MEfV/czqFdKSk/ImJqU4iW/2X9GLWpmDJbuXdQoHRYu3pg+xcgY2HTjXxC
	nFDWTN8/QW896Yl6RaDUOUkQJtCon6/4rdf9wlskzo/Ps2WytwUx5HdgeusTel0swIGyvm
	kxpTxTgsUCs2C/B0ALN+6PNzVFAddtYWRCJs9TeAb7j7y2iEYnb9qqQcsqXW7lXqozZyUc
	KMKDJDU7gTWnhldSk+AMH/tTgQ3Oa5kDuhTS5MnTJU21d2bxsfDBiLgAnJZNyLGNPhH2oe
	mBICZYDJh46njUJUqBFCVuSvWvoiCD848oWzWcY6fQjt0H7sKat1vBBHaNbsDg==
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Patrick Vogelaar <patrick.vogelaar.dev@mailbox.org>
Subject: [docs][PATCH] doc: enhance SRCREV_FORMAT description
Date: Wed, 10 Sep 2025 16:54:00 +0200
Message-Id: <20250910145400.232143-1-patrick.vogelaar.dev@mailbox.org>
MIME-Version: 1.0
X-MBO-RS-ID: 6df1d29f548423db950
X-MBO-RS-META: 9w6yxgbuhzu9qytq8zpd3d7gjcwdxsbi
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 14:55:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17996

Adding documentation for having an empty first component for the
SRCREV_FORMAT.

Signed-off-by: Patrick Vogelaar <patrick.vogelaar.dev@mailbox.org>
---
 .../bitbake-user-manual-ref-variables.rst                   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 810f88689..07e754096 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1670,6 +1670,12 @@ overview of their function and contents.
       ``AUTOINC`` placeholder is added and if needed. And, this placehol=
der
       is placed at the start of the returned string.
=20
+      The :term:`SRCREV_FORMAT` can also take the form "_component2".
+      This assumes that there is a component in the :term:`SRC_URI` that=
 does not
+      have a name assigned. While this is not considered good practice, =
it can be
+      usefull if a ``.bbappend`` file needs to extend the :term:`SRC_URI=
` with
+      an additional repository.
+
    :term:`STAMP`
       Specifies the base path used to create recipe stamp files. The pat=
h
       to an actual stamp file is constructed by evaluating this string a=
nd

