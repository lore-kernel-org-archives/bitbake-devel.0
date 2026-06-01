Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798BDCD6E65
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 13:21:50 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28429.1780320106972701382
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 06:21:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=TIRAoM+b;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D01F04E42DE4
	for <bitbake-devel@lists.openembedded.org>; Mon,  1 Jun 2026 13:21:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9DD546026B;
	Mon,  1 Jun 2026 13:21:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 053F71088822D;
	Mon,  1 Jun 2026 15:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780320104; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=xOjlAhIN6xQdXVDHMyoY3IIY0oqSTR5gVkqVhwI4R64=;
	b=TIRAoM+bW4oMeolExUHLwxuD0tLv36BuWsy4RWj+ySvDc5G4PMu35KZ9Fmf/3cz/M4ABne
	JI8d4rzDpdemdsCv6PINk9iZSaHKpBR0e95Wq1EM+5s5xK8xSusSz0N/Me61POpnxCArkK
	fKeZh1QBnQsuXm+PHZohPxBetl+5j3GrEmqJUd8oE7m8naWKcF2XOIDdBsuuCmJjUEC6ka
	o9EJvfWx+aNkFV58T6sZt2UakEGUsRqlE9j37N4In3ZT09BaI84RLXgnuTXkue1IDuoIrB
	dOSUPIW4ihtEgx+ijawsIRyQP15pKLVDJzVEPzs81aJyLwcngcwnXB+wXmP/Tw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 01 Jun 2026 15:21:29 +0200
Subject: [PATCH] doc/bitbake-user-manual-ref-variables: extend the MIRRORS
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-clarify-mirrors-syntax-v1-1-d9dbdbaf037f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDsQrVjqVaSLJE50So0yo0UR7
 95Ul2/x/w5KwqRQZzsIfVl5jAn5LQPf29gRcpsMhSkqU5kc/ccKhw0HFhlFUbc42xXpbp0LD2+
 ofEKKJ6HA6zluXpd1cW/y8/8Gx/EDRSiCWXoAAAA=
X-Change-ID: 20260601-clarify-mirrors-syntax-e3abbf7c0e49
To: bitbake-devel@lists.openembedded.org
Cc: Ross Burton <ross.burton@arm.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4361;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=kBSiQZ/bNTqh0/lUHlq1N6fQn2OE9JRL5D2bEWKC9eQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqHYdm/Yp4WWNRwp9VRCM+wkJRfxLm76SJ1BGvn
 8J9RpjML1yJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCah2HZgAKCRDRgEFAKaOo
 Nk8/EADJpoWaP3lY2J+MpgfVYWmvVNYnQxSEaPYJOm9LyHIGriGDDFpEqfNrwWypNjO5QOSA28r
 9nKfVekIdNOrLNECwDk7D2/68HnLE8q03T8pW2OuxsTg7IEu6zhVSX/fbS2lAmg7J9UQiV+GWdE
 YKtbMy7i7ihOqiAPppP1japJC25/mQH71pMvV0/wqaWiZsGzWXr1lsQVgEp4QFEN0/eRmqdyVm3
 /0yUOkz8tuwji0Xl7jE/vSQH0fbgEmPSgG1LcyCTORPvr7FW8MlsKLDA28BArHPmQZ9iI4bVbrL
 aPlG1LNx4JLfvh+I/5U2SgbeY2bCMhfuMkN9BNEXZSO88JRI4TeDWicfMhHLeI6CpfpDwtdBq1B
 U1MX4+kQVvVPCrNarEHOzzePI8LHq134WOX1I3oeH/FfubAz5bEHdbXyhnFYC/wrM83DesxgjCw
 Ifm8KSJ/c4Qb7Bm2qT8U3e/JAi83tzgiF+s8FTG38DFuf4uGIf017Nl0gp3cJvQSqBMBU0/vO5P
 i3nSeJ+KspRfnjUv7mhfy57aalebQgKEV3CKsKArosU4EWdHKd6CG8K2bj7uyJuBG/Ejz1hVcoG
 hCDCJdhKSPLY7iAFAttgJr2pSdG6geNWXwi7BnrgVOYv2gKzvUfS6HofQb5oVLs/H3iQq9ZPq+V
 ATrWXsc1AXP+sjw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 13:21:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19583

The MIRRORS variable wasn't properly documented as Ross highlighted in
bug 16297. Give it a proper description detailing its usage and which
keywords are available. Also link PREMIRRORS to MIRRORS as they use the
same syntax.

[YOCTO #16297]

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst          | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 9824b58ef27..753e9a38f90 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1416,6 +1416,58 @@ overview of their function and contents.
       upstream source, and then locations specified by :term:`MIRRORS` in that
       order.
 
+      This variable has a specific syntax. Each line must contain a regular
+      expression matching the original source URL on the leftmost part and a
+      replacement URL for it on the rightmost part. For example::
+
+         MIRRORS:prepend = " \
+             git://git.openembedded.org/.* git:///mirrors/openembedded/BASENAME \
+         "
+
+      In the above example:
+
+      -  The leftmost part means that any Git repository (``git://`` fetcher)
+         whose URL starts with ``git.openembedded.org/`` will be matched.
+
+      -  The rightmost part is the replacement URL for the original repository,
+         which is hosted locally in the ``/mirrors/openembedded`` directory. It
+         also uses the ``BASENAME`` keyword which is detailed below.
+
+      The rightmost part of each line can contain keywords which are
+      automatically replaced by BitBake. These keywords can contain either a
+      sub-part of the original URL or meta-information about it.
+
+      For what follows, let's take the following URL as an example for the
+      original source (matched by the leftmost part of the line):
+      ``git://git.openembedded.org/project/repo.git``.
+
+      A replacement for this URL can be created using the following keywords:
+
+      -  ``TYPE``: the URL scheme or fetcher type. For the example above: ``git``.
+      -  ``HOST``: the URL host. For the example above: ``git.openembedded.org``.
+      -  ``PATH``: the URL path. For the example above: ``/project/repo.git``.
+      -  ``BASENAME``: the URL basename. For the example above: ``repo.git``.
+      -  ``MIRRORNAME``: a translation of the host and path with common
+         characters substituted to dots (``.``). For the example above:
+         ``git.openembedded.org.project.repo.git``.
+
+      The rightmost part of the line can also be a bare URL that uses no special
+      keywords (usually ``https://`` or ``file://``). For example::
+
+         MIRRORS:prepend = " \
+             git://git.openembedded.org/.* file:///mirrors/openembedded/ \
+         "
+
+      In the above example, the fetcher will try to find a mirror tarball in the
+      ``/mirrors/openembedded`` directory. The name of this tarball should follow
+      the name of the tarball created by BitBake (for Git repositories,
+      the :term:`BB_GENERATE_MIRROR_TARBALLS` variable must be set to "1" to
+      generate them).
+
+      If we take ``git://git.openembedded.org/project/repo.git`` as an example,
+      the tarball would have to be named
+      ``git2_git.openembedded.org.project.repo.git.tar.gz``.
+
    :term:`OVERRIDES`
       A colon-separated list that BitBake uses to control what variables are
       overridden after BitBake parses recipes and configuration files.
@@ -1544,6 +1596,10 @@ overview of their function and contents.
       use ``file://`` URLs to point to local directories or network shares as
       well.
 
+      The syntax of the :term:`PREMIRRORS` variable is the same as
+      :term:`MIRRORS`. See the definition of the :term:`MIRRORS` for more
+      details on it.
+
    :term:`PROVIDES`
       A list of aliases by which a particular recipe can be known. By
       default, a recipe's own :term:`PN` is implicitly already in its

---
base-commit: e9a06f79d9ec767c9d95470be78b006d6fd0d59c
change-id: 20260601-clarify-mirrors-syntax-e3abbf7c0e49


