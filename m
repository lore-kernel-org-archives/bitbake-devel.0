Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED815106F310
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 09:11:30 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43268.1774516285981149376
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 02:11:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=m0zIm7n4;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E80511A2FFC
	for <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 09:11:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B17CF5FDEB;
	Thu, 26 Mar 2026 09:11:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD65210451B15;
	Thu, 26 Mar 2026 10:11:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774516283; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=pJavGwPN6TGzODHmY5BDSvsWsSwPcsugDECMA8yF1K8=;
	b=m0zIm7n4Zrz7V0P2zMLh4sjnia+pXlniLBhLz9BwgpU/NgVASjOKt74BbmIbL4RDMmaljw
	zQ2qogegpGlRl/iaNuPWtMy1sE+qUKBljK/SpSVk9LjTO4nGeGSG7wrxFCMATnfIlN8fvv
	ACS/Md1akqG411v+QzWAzWPqZFCTNioE2Lgmsh8SYt9eUvQC4aLVN+7hZyNSUOK44YIIOh
	R0lfdlY8K1kh4ClX+668QSAahefzJC1xqnf+4+YK7jTeopHb/QLn78afLPuwbEY2UgoBka
	J15HTu9s8Nn9F9NzdfLLLDOZZU63ujph6ER5B60Y12sBEIuZvF0jByHVaJr1UA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 26 Mar 2026 10:11:14 +0100
Subject: [PATCH] doc: add warning notes on the disabled NPM fetcher
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-disabled-npm-fetcher-docs-v1-1-8e2fa7c1d0c6@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTsQI7ToVcRFMvnbjmhaMlWE0
 rsb7fJbvLeSoSiMLs1KBW81nXLF8dCQjCEPYE3V5J1v3cm3nNRCfCBxnp/cY5ERhdMkxk6CdOj
 OPvhItZ8Lev3839fbbnvFO2T5DWnbvo/ZsHh9AAAA
X-Change-ID: 20260326-disabled-npm-fetcher-docs-0cac7e792a2b
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2759;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=q+kU0eToGTOEbPZMDo8h4yWHtbiapD5OvaqVRmiZFZ8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpxPg65OnQ21cOFATZRF7PxNwbKub+VAY63abdh
 Feyc7XIi1WJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCacT4OgAKCRDRgEFAKaOo
 NuzQD/9nxs25H5UwFwz5ul61TwO1F6qUCqfGgPw4GrV3fCvtSzUVyRnnVVTQ/0uNZ8Mx9qlT3IU
 zzCXXQyisDaxMTofHR/3otmApRT0l+HrRiObxPmesN6l8z+l4mERvc0P1ILR9QKr55xmx15dTKk
 cfj2Ns+zm3at0RHjMq8CTciOnWCHY+cAlPOiuf2/Rr1l6VosZQMXVF7MWYRnBT4Zt5ct4PyJ8hv
 wfM2q++6d3BKSBZ7zAebNgmb+fMBzlzWhVDE2eTt2AZGNumxRap0qSDe9ezCSyLxygVw5ta6XF1
 LGE9w3eC4JMsLnQTm8gxtnTgxF3gQUcjayR2jBTVoCACaxlUO16dCDwlUNC/0LahyP5KSYx0IYz
 F2Z1mDOQlDJGzo3J6r/EwVA0Rh8cAWchrukGghTuEH7GyaFf9K4EQEqiLMO3xWxoy9xB4DZodyj
 dtWBdE8BaXybpgkq5+FzOE+gZbnDyQEdm3GdIOzI5Q1OqRjYBqGk6wDzK/XHDYyecrETeRmECf9
 m9SW/fclEbKwNHMzQxJrCmWlDWbzkK42tvccvrUBZBTS28j1L5L+UpkwTZhXqdtVN57GmNcJmfn
 qtI4qaB98LoF1H3jgy4sgw9HQWsT2x9LcVYSscrnQijhI+t+AK3a4wW+rA3rk2PSt5/0+qWgzp6
 ztDyTLmfyhwBj1w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 09:11:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19234

Add warning notes in bitbake-user-manual-fetching.rst and
bitbake-user-manual-ref-variables.rst regarding the disabled NPM
fetcher.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst     | 12 ++++++++++++
 .../bitbake-user-manual-ref-variables.rst                    |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 1dcdc0ffee1..6af80359125 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -680,6 +680,12 @@ Here is an example URL::
 NPM Fetcher (``npm://``)
 ------------------------
 
+.. warning::
+
+   The NPM fetcher is currently disabled due to security concerns. See
+   `355cd226e0720a9ed7683bb01c8c0a58eee03664 <https://git.openembedded.org/bitbake/commit/?id=355cd226e0720a9ed7683bb01c8c0a58eee03664>`__
+   for more information.
+
 This submodule fetches source code from an
 `NPM <https://en.wikipedia.org/wiki/Npm_(software)>`__
 Javascript package registry.
@@ -719,6 +725,12 @@ to automatically create a recipe from an NPM URL.
 NPM shrinkwrap Fetcher (``npmsw://``)
 -------------------------------------
 
+.. warning::
+
+   The NPM fetcher is currently disabled due to security concerns. See
+   `355cd226e0720a9ed7683bb01c8c0a58eee03664 <https://git.openembedded.org/bitbake/commit/?id=355cd226e0720a9ed7683bb01c8c0a58eee03664>`__
+   for more information.
+
 This submodule fetches source code from an
 `NPM shrinkwrap <https://docs.npmjs.com/cli/v8/commands/npm-shrinkwrap>`__
 description file, which lists the dependencies
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 06bd536195c..8d8e8b8b912 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1738,6 +1738,12 @@ overview of their function and contents.
 
       -  ``npm://``: Fetches JavaScript modules from a registry.
 
+         .. warning::
+
+            The NPM fetcher is currently disabled due to security concerns. See
+            `355cd226e0720a9ed7683bb01c8c0a58eee03664 <https://git.openembedded.org/bitbake/commit/?id=355cd226e0720a9ed7683bb01c8c0a58eee03664>`__
+            for more information.
+
       -  ``p4://``: Fetches files from a Perforce (``p4``) revision
          control repository.
 

---
base-commit: 112bddd8fc684fbdd71139429251b127739f863b
change-id: 20260326-disabled-npm-fetcher-docs-0cac7e792a2b


