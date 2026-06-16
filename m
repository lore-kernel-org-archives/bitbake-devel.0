Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0A6CD98D2
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 07:13:42 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.148154.1781592475749067222
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 23:47:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@emlix.com header.s=20250930 header.b=nFwBY/oB;
 dkim=fail reason="dkim: body hash did not verify" header.i=@emlix.com header.s=20250930 header.b=nFwBY/oB;
 spf=pass (domain: emlix.com, ip: 178.63.209.131, mailfrom: andreas.muetzel@emlix.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
	s=20250930; t=1781592473;
	bh=mFyXWYUgkVTXcnneY/qUqHE0GPk5F+khL6Hpos3O4hw=;
	h=From:To:Cc:Subject:Date:From;
	b=nFwBY/oBXGm9PhonvLciriThOrJEHml9JQSxni48ezalVL3BoSaYF9t0fd+gdbuQZ
	 M8GW8hlg/YKphjmbkfbfhEHc9tvU2Ia6P2LRHun6YGQmAj0q6lu0ccU/jYhhB+rhGQ
	 P7Z5RdCm2dpNg1t3FF8PoNwmg52Pryd+ARCPbyhbZTlKwL9Y3jjNrSnEoUSBKV6dk2
	 EypdJ3aJMNGMEDYedmIJcO7s2Yc9TE2LdxexvTHBbywBVO2lg863togUoQhZGMkwrQ
	 83Lmk4wxshnzuaFoJzk4QvXRPEA/Q2TIsWZgH2oeUu3bIy+aqs9UTeIzCvKjsXTF6z
	 yMiqU3P/37/nQ==
Received: from mx1.emlix.com (localhost [127.0.0.1])
	by mx1.emlix.com (Postfix) with ESMTP id 36AC95F9D3
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 08:47:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
	s=20250930; t=1781592473;
	bh=mFyXWYUgkVTXcnneY/qUqHE0GPk5F+khL6Hpos3O4hw=;
	h=From:To:Cc:Subject:Date:From;
	b=nFwBY/oBXGm9PhonvLciriThOrJEHml9JQSxni48ezalVL3BoSaYF9t0fd+gdbuQZ
	 M8GW8hlg/YKphjmbkfbfhEHc9tvU2Ia6P2LRHun6YGQmAj0q6lu0ccU/jYhhB+rhGQ
	 P7Z5RdCm2dpNg1t3FF8PoNwmg52Pryd+ARCPbyhbZTlKwL9Y3jjNrSnEoUSBKV6dk2
	 EypdJ3aJMNGMEDYedmIJcO7s2Yc9TE2LdxexvTHBbywBVO2lg863togUoQhZGMkwrQ
	 83Lmk4wxshnzuaFoJzk4QvXRPEA/Q2TIsWZgH2oeUu3bIy+aqs9UTeIzCvKjsXTF6z
	 yMiqU3P/37/nQ==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 1D3035F921
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 08:47:53 +0200 (CEST)
From: =?UTF-8?B?QW5kcmVhcyBNw7x0emVs?= <andreas.muetzel@emlix.com>
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Andreas=20M=C3=BCtzel?= <andreas.muetzel@emlix.com>
Subject: [PATCH] bitbake: fetch2: make unpack_tracer available when fetching mirror URLs
Date: Tue, 16 Jun 2026 08:47:39 +0200
Message-ID: <20260616064749.36789-1-andreas.muetzel@emlix.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 07:13:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19700

When building the FetchData for fetching from mirrors, pass any
available unpack_tracer to the newly-created object.

This fixes the following error that occurs in the git fetcher's
unpack() method when fetching repos that use git-lfs from MIRRORS
or PREMIRRORs:

AttributeError: 'FetchData' object has no attribute 'unpack_tracer'

[YOCTO #15948]

Signed-off-by: Andreas M=C3=BCtzel <andreas.muetzel@emlix.com>
---
 lib/bb/fetch2/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1a6ff25d4d..60bdd32681 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1010,6 +1010,8 @@ def build_mirroruris(origud, mirrors, ld):
                     newud =3D FetchData(newuri, ld)
                     newud.ignore_checksums =3D True
                     newud.setup_localpath(ld)
+                    if ud.unpack_tracer:
+                        newud.unpack_tracer =3D ud.unpack_tracer
                 except bb.fetch2.BBFetchException as e:
                     logger.debug("Mirror fetch failure for url %s (origi=
nal url: %s)" % (newuri, origud.url))
                     logger.debug(str(e))
--=20
2.52.0


