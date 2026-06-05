Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4A6CD6E7C
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 13:23:28 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7936.1780665798114733746
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2026 06:23:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=FoFBbcAO;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 08E8C1A092B;
	Fri,  5 Jun 2026 13:23:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D29E35FED1;
	Fri,  5 Jun 2026 13:23:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B023106A242D;
	Fri,  5 Jun 2026 15:23:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780665795; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=KxWHkLzwZJQJh+TQ575Vw7+W7/t/sgYJHKG/1moLw74=;
	b=FoFBbcAO0pxpTIbghM4x2bpYQWy3jvQ72x9xDbXyxmqIxNNsGGheQuo3euEGF9o836Wvzn
	JzJdYn5XnkPCK83K1ipyl+uXqkMHNwTH2/zoIPsZSuHgujyvRBsQ+OoOG/aO6ULCDtoJUh
	FZESCxoiKgduiEwCz1Dn+MUjMQE0xTIFO7Mm+hQu2XH82L1fCEfrhk4AXPYBCOv/4JKfBo
	Gqo/rQAAC40orz8v8XtWFo5Lu+me0NUSyJ9YiH2gwRDhJ3Cgi+k50i0uZVI/UIA8udw1JW
	6LtpgrTT4UkMaQEEicKE80QO3z8X2LWHJU8T4Jb1SqgyYcMhg8yAoB69vASg4Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 05 Jun 2026 15:23:03 +0200
Subject: [PATCH v2] doc/bitbake-user-manual-ref-variables: extend the
 MIRRORS documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-clarify-mirrors-syntax-v2-1-d833dc56c900@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr2K6tqYFA8GV9zAs+jOVMdCamUogh
 LsLeACXL3nf+xbBQAgsbqdFEIzImOIGxfkkXGfiEyT6jUWhikpVSkvXG8IwywGJErHkOWYzSSi
 NtaF2Cq6N2MZvgoDTEX60P+aPfYHLe203OuScaD6eR717f09GLbX0jbfemqDKOtxtSrnHeHFpE
 O26rl/fb/Dd0AAAAA==
X-Change-ID: 20260601-clarify-mirrors-syntax-e3abbf7c0e49
To: bitbake-devel@lists.openembedded.org
Cc: Ross Burton <ross.burton@arm.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4596;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=vKayYielkXeShQjrGqN0nr6/QvoFKhmkNM/aFStsHHs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqIs3BsV4dtijCdejNoKDYRPxT3E9U9nihc6iOP
 z1TJLRWSwiJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaiLNwQAKCRDRgEFAKaOo
 Nn0gD/0RdA07enlDmdP8hhkD6okdmhbc5YI14k2lw5vIRCU3FXV9rn0E6IodbTmfgMpjnoNlgwJ
 C8w7rOfZ5dBiJN22gaYe+zfgAgkIy2lxWwA9VdWW6ZxjnO7fFYGmt0jCYGm+5QMBL7kbXRjZDom
 nifRKztnMr6XOHzYJTQILMPPRo97VGNuraDf0BxLAFFcfAbXvPbcj9uy9RtY9peakcjyP/scHgS
 kc1mNQl+1jl6BcXD8VuJ+smYDxeL80qGLWeFK7ZKdT+PlUd7i5up2yjGTo3Cl/o/BmD8RBDfYZW
 4gNMBu8Y5DwzTMvdk6bZjkdMUtRLAqJPAlFX+YiSE9aIA8BVgmSfHQEw9vbatmb5em8E00gGRoJ
 95wsV2h/yIhlW6O05w8NEilTMsCeyNk1Qm8mg8ulUEd6m4w13yKqmi6m/mR7CGjmXQ+1e0IPmky
 ebbdF2MwzGQwIrYRi3W7FHXKYhrH/KapXZROXBfJy6t0b2ctV7ODTv2QEeeYXbejysqBygMFYSK
 2lLdOL0dnRrZM0qK1xE+vHLxrfrgQqipaAGZqTO2MsJcKxZeq2PtwV+WMepPt+eqJcHQZJhgk5p
 GnPFRMRoN1pSg2y2QzeTNna+7RwR1S0f3VMnhtPqJfG4rxIEg7PaTWfBTCfRzYA4svqxMUy9lXb
 HEnzRqpbvN0W0fQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 13:23:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19615

The MIRRORS variable wasn't properly documented as Ross highlighted in
bug 16297. Give it a proper description detailing its usage and which
keywords are available. Also link PREMIRRORS to MIRRORS as they use the
same syntax.

[YOCTO #16297]

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Address comments by Quentin
- Link to v1: https://patch.msgid.link/20260601-clarify-mirrors-syntax-v1-1-d9dbdbaf037f@bootlin.com

To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: docs@lists.yoctoproject.org
---
 .../bitbake-user-manual-ref-variables.rst          | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 9824b58ef27..721450496b9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1416,6 +1416,58 @@ overview of their function and contents.
       upstream source, and then locations specified by :term:`MIRRORS` in that
       order.
 
+      This variable has a specific syntax. Each line must contain a regular
+      expression matching the original source URL and a replacement URL for it.
+      For example::
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
+      details.
+
    :term:`PROVIDES`
       A list of aliases by which a particular recipe can be known. By
       default, a recipe's own :term:`PN` is implicitly already in its

---
base-commit: e74cfd03afe5aff1f81cbff8c6efcef77c9af618
change-id: 20260601-clarify-mirrors-syntax-e3abbf7c0e49


