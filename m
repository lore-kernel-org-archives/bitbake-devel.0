Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4F8D74ECB
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 13:24:28 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.67693.1769174658999001709
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jan 2026 05:24:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=xyKuaW9F;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D07504E42218;
	Fri, 23 Jan 2026 13:24:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A685F6070A;
	Fri, 23 Jan 2026 13:24:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18E28119A8547;
	Fri, 23 Jan 2026 14:24:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769174656; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=9bM5YhDkoGyIeRI0Mwnah6pNmMxAAYHiBWP4K+DnrLM=;
	b=xyKuaW9FNyWRfQcJ+frwStQCalAsCGjXRpPue3QzOJObDAOrSYCKgSbcYsxQLvBYredsVG
	VmMVfZl51nEG7XkzOMSaLi6IQbFjLbF47jQe3h1hYxqgKd4VpZmhkMW1xHuglHdRHeG+KH
	r7RoxCT70g7CXA5on3s+2i4UtH4NKIlFTN6hGnteSukIba41vm/EjIX1fV+W4B4nBg3TLX
	vIHZiY3lw05w+ERArGvFlG1IKG6098AnCiwfRKsV5PT0J3DwgiGZpwc+uADsl9iiQE1u8w
	F89xvmixsEn9NawB6mm8qWYjx9YLq/9pRwDn34i8uCAquq79HKJxx/6e2eZmAw==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v4 0/3] bitbake-setup: add descriptions for fragment
 choices
Date: Fri, 23 Jan 2026 14:24:05 +0100
Message-Id: <20260123-bitbake-setup-choose-builtin-v4-0-99361f2128f6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHV2c2kC/43NwW7CMBAE0F9BPmNkb+K06an/UfVgb9ZkC8Qod
 iIQyr9jwwXEgc5tpNGbi4g0MkXxtbqIkWaOHIZc6vVKYG+HLUnuchegoFFaN9JxcnZHMlKajhL
 7ECJJN/E+8SC9022rTI0IRmTiOJLn043/+b33OLk/wlTMsug5pjCeb/+zLrt/Xs1aKvnZNSW2J
 d99uxDSnocNhoMoZzM8cKDecJA521Gjau+hMvqVqx45eMNVmUNjoNUWUduPZ25ZlitYyzCZegE
 AAA==
X-Change-ID: 20260116-bitbake-setup-choose-builtin-fb199054cc25
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Kanavin <alex.kanavin@gmail.com>, docs@lists.yoctoproject.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=+zvISwPJyxrRMRIPYtMJGAwppezsmNcN/yxQ/WBcIvA=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpc3Z9Ztb4SmVwlA0/X4evR2WOaYkPvpttRYIzN
 74xCYwVV/mJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXN2fQAKCRDRgEFAKaOo
 NlcPD/0ZHWrdyBMOG7eoNINMCG0vfK+48Wn9JuUL5OHzd8DFiOjHAsZmGjMJ0uGicXc/YcUi3q1
 a6fXU3i8RBUxmHX+c11TZwSTDup+EbvSg+1z/gBl1j94pU+6nB/GKBydLfvQj0/lYMw3/46LHOu
 OfMvAtHtz1rkVWTUp4ZNtgvLZczC9NroS9MjBATS8u974xpSrJfMf5z9tKM6x68jfbQ3E8sZTS5
 XY+KwiA93WAxIFISEzkc882Jasur6wgFzarJuzsJc/DJvmMvVjBBfwpZz1Zwn+ZmJLFl5ebUYtb
 Kl4vws91kEA0cXyfYHqmJ8vop4xBMDXBs7ekZo/0rvrbolPgP/MG0IgOLHdsBkk0yba/gFJTUY2
 W35SoTekq4jJcNlaNlHkswD+UidOAUVHvzYxQrt1mOFkwoqNkXd+OPHRjQcGKm/TQwY7JlDoIlC
 1ups82zHUQ6BDGIBSwaxGZkjtoBygXIL5UCffx7I5ut+hXaDNmYfxfA/Xirlg5C0WXn/QJD5Nqz
 /X+GKXCLFxBv+stCAXONhLnuuT3fAPHkFL5Taor4viQhjwGGR0yfSWHnEw8GpvzJPRK/UaRTI1+
 LmERaws/2Ax9NU5DflIe9DKU6JWFP3kTS2NMxbaKqfI2jRH4bKnOdhBM1ipYnUVCoomC95lMaEK
 KYJIToGN7kvSpwA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 13:24:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18859

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v4:
- setup.py: move the fragments to gizmo-notemplate, add a second option
  (that isn't used, but it doesn't make much sense otherwise)
- rebase on top of https://lore.kernel.org/r/20260116095741.3654153-1-alex.kanavin@gmail.com
- Link to v3: https://patch.msgid.link/20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com

Changes in v3:
- Rework logic as suggested by Alex
- Remove modifications of {oe-nodistro,poky}-whinlatter.conf.json
- Add a test case for oe-fragments-one-of
- Link to v2: https://patch.msgid.link/20260120-bitbake-setup-choose-builtin-v2-0-ade604ff2351@bootlin.com

Changes in v2:
- As suggested by Alex, change the new way of specifying fragments to
  remain a dictionary so they can be extended in the future
- Link to v1: https://patch.msgid.link/20260116-bitbake-setup-choose-builtin-v1-0-8d66666a9efd@bootlin.com

---
Antonin Godard (3):
      bin/bitbake-setup: add descriptions for fragment choices
      default-registry: update fragments choices with descriptions
      lib/bb/tests/setup.py: add tests for oe-fragments-one-of

 bin/bitbake-setup                                  | 23 +++++++++++-----
 .../configurations/oe-nodistro-master.conf.json    |  6 ++++-
 .../configurations/poky-master.conf.json           | 14 ++++++++--
 .../bitbake-user-manual-environment-setup.rst      | 26 ++++++++++++++++--
 lib/bb/tests/setup.py                              | 31 +++++++++++++++++++---
 setup-schema/bitbake-setup.schema.json             | 21 ++++++++++++++-
 6 files changed, 105 insertions(+), 16 deletions(-)
---
base-commit: f48cd5c7dc58aa95032f19d4d628acb31512d9d6
change-id: 20260116-bitbake-setup-choose-builtin-fb199054cc25


