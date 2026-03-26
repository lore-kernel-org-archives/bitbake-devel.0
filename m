Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12300106F308
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 08:55:21 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43098.1774515313975025941
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 01:55:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=TQkqK18L;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D84B34E42802
	for <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 08:55:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE87B5FDEB;
	Thu, 26 Mar 2026 08:55:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E03810451B10;
	Thu, 26 Mar 2026 09:55:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774515311; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=J/91ipG0ZB3RNVSfO11un9UylTOngOUnkBNXT4w21S4=;
	b=TQkqK18LFbOr5zgrHf3vbLBChxsbHZ6AbJ3E6ThaCPqxL4s8hI2sgxrxluiAIQLNVdkSFR
	4dr7q2khCCoCKASu4XEbMFRYf9AlDZiQp6PoGZR2Fs5Y3KVhBsg2f0kgMILSRCixu7Upq4
	y/Bqcr+9NNmvhqtm88kNzWyUtWi199tDpNmkiwqz3C9+ukbRasiXaCYv06+m1pQ8AH6bWK
	n5NAOQi+zCJWN/HkS3uyd3N4fS0V0GYEw9X/qyyG0Likih1vKVO/vKMYz77MkJcLBIyeIG
	ZtRN0Fcls6o/d1wDah2RODgT4arAG9VzgonqTQvoHg0yL5Rjc9psXZ3wnH1gAA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 26 Mar 2026 09:54:57 +0100
Subject: [PATCH] doc/bitbake-user-manual-fetching: add warning on the Git
 subpath parameter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-add-subpath-warning-v1-1-ece919e8779a@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6DIBBA4auYWXcSBcG2VzEuEEadLqgB/EmMd
 xfb5bd474BIgSnCuzgg0MqRvz6jehRgJ+NHQnbZIEqhSyk0GucwLv1s0oSbCZ79iJWSdpDPpql
 fCnI5Bxp4/13b7u+cfMimewXneQHZjSSXdwAAAA==
X-Change-ID: 20260326-add-subpath-warning-153cf3877495
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=1bijF0g2TeMyz2ubl2WddW3x3dVZYJt2Luvn2/3nvOw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpxPRu1diP0bP0XehWpIC4pntKipwt/BVWvQk+B
 SZ2x9or3KqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCacT0bgAKCRDRgEFAKaOo
 NrImD/9uZr+g7qJ+2CWv5DHAz79d53eClQ944GukeJ5IHh2oe8BIh3Qegc7kcErudaRZ3PtRgUG
 jbihGrWt0zNnBhO3k64iZDSswJAQ1NWgHEZxW0A0KHjAxwoGOWLGrlXqrSStHC+NHDPS/FSsBMU
 Iw9wM5SzWO3RaJ7aFh28kBr9hSnpMUVycTOimjTd/FVOhGHkUtj9aM5TlDijmTj8oRtuKFGBn61
 wtqgZCk34r2HBgNMjvxb60mZvBIhFZyU88nVsslm+uwXaCdEtU4lFSFLttny/Av/Pd9DqjaMK9d
 S5UhXRelaf28SyHiXI2nP0PmnPPF9WlomtPzRkKe6dRgcJC8klB1yddlbRkvbsrLwEwNjrQgY+f
 RgslK5h0JvlPBu25BnyykVjhBWUmPEe+K384+NkSwv8Py8jNdRPhx/4JiiXOCmVAT89bNTYoaA7
 EYxIv05kRdPmjpRwbMSkPUUbvXPot4JNBim9YRbXDHnAkCMNr68ClREs9A6V6Zv0RvJILl7Rryc
 yo8yR0KfqhcrMc4ZOswimP1hHAgg49+Qjjr7fgQkyYAnjrK3YmnGIwLU21rEdBmdlk5WA0zzdby
 RdKZOiMuCrkXvx+i1XAYGhurpPazLCXyCD1KOGIFbM5MjYTI/MEj5972FfX/jwWHLkmBb/smDhv
 wCQN8MZQdznzX9g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 08:55:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19233

[YOCTO #15558]

Add a warning on the subpath option which has an unexpected behavior
with regards to how the HEAD is updated in the checked out repository.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 1dcdc0ffee1..5d7d6f7a34d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -380,6 +380,21 @@ This fetcher supports the following parameters:
 -  *"subpath":* Limits the checkout to a specific subpath of the tree.
    By default, the whole tree is checked out.
 
+   .. warning::
+
+      When using this option, the value of :term:`SRCREV` may not be reflected
+      in the checked out repository.
+
+      To achieve a partial checkout of the repository with the ``subpath``
+      option, the BitBake Git fetcher makes use of Git "plumbing" commands: `git
+      read-tree <https://git-scm.com/docs/git-read-tree>`__ and `git
+      checkout-index <https://git-scm.com/docs/git-checkout-index>`__. However,
+      these commands only update the **files** within the repository, and do not
+      update the current ``HEAD`` to point to the commit specified by
+      :term:`SRCREV`. Instead, the value of ``HEAD`` will always point to the
+      tip of the branch specified by the ``branch`` parameter, which may or may
+      not correspond to :term:`SRCREV`.
+
 -  *"destsuffix":* The name of the path in which to place the checkout.
    By default, the path is ``git/``.
 

---
base-commit: 112bddd8fc684fbdd71139429251b127739f863b
change-id: 20260326-add-subpath-warning-153cf3877495


