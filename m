Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63F6D3EE74
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 15:02:29 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39445.1769094143653009245
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 07:02:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=GwYheRdO;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2F44FC21AA4;
	Thu, 22 Jan 2026 15:02:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 565A0606B6;
	Thu, 22 Jan 2026 15:02:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F5F0119B808A;
	Thu, 22 Jan 2026 16:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094140; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=SdingNcLYXXUoTr/iMtw7Bkny18IDuIF88EYSKxE+zU=;
	b=GwYheRdO4Q7/TEJq8RnJ2iM06cWBbPazE5kHavWvg27dbayx/SuM8C0ieh9L4kjRP1AkWg
	OAC8rXbtDqEwD9buwvsoABqkhaoWeAGZM1RzFcppZrJvza7fAXTXrhR9jPRkRIWekBUT5X
	VN1E5nr3bIb9/qPG1WCdrvNToTInwtxpOtA9390NgFaXPM9lQmeP5O6j6pJfLw05rC53Q0
	OUzYLXZIgQ4XUS/3Bzw8F6CqnR38ZrmKp1iVXKGlOn+nTmvP9CTLylGV3Ua2clVL8t1Dgy
	x4+wNGFVnvqQpeBZey51+3kTEi3L0uyq4asbHzRxRDaTnc/R2uqYg5nZDM8rnw==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v3 0/3] bitbake-setup: add descriptions for fragment
 choices
Date: Thu, 22 Jan 2026 16:01:57 +0100
Message-Id: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOU7cmkC/43NzQ7CIBAE4FcxnF0D9CfWk+9hPBS62NUKTaGNp
 um7C/WiJ53bJJNvZuZxIPTssJnZgBN5cjaWbLthuq3tBYGa2JnksuRClKAoqPqG4DGMPejWOY+
 gRuoCWTBKVBUvcq1lwSLRD2josfKn87v7UV1Rh2SmRUs+uOG5/k8i7f68mgRw2DdlSl2haY7Ku
 dCR3Wl3Z+lskh+c5D84Gbm6wZLnxsisEN/csiwvtqp5wSsBAAA=
X-Change-ID: 20260116-bitbake-setup-choose-builtin-fb199054cc25
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Kanavin <alex.kanavin@gmail.com>, docs@lists.yoctoproject.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=cZ/k+ft8kVeLvM/Tf0oJgbccZoRulu19x3+Z9fT6GQE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcjv6vLsMrGKnuZGTaWtxX7TBDe3xgvtLGLD8I
 K2yOvqjXTyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXI7+gAKCRDRgEFAKaOo
 NtQJEACx83QrIUKpf2Z/zfSVDIn/NnPMnirpyUgnLVFE3M37gcbdlw3WuAjtyT5+qktELweNVZQ
 jePnuxcyraW6t/lDPU+H/pl/V6uwSI1hBMbN9faXf+zPbyyd6Xt07OtS7Kx/XUcRVix4P8hjM19
 5OYnyVUBz6EbgX7dYKvTIG3yHm0URLPDmKCqHr6AJKEbXyeJNyUTgpM1JwnSJ5aJH7CUurXw2Fo
 H7M7yJgzVtiYVnohs8MJREv/byff2Gx5ETq3Jv/H1W72+//coRhsUw3O7fmS7MyvFVpmN/fNbpw
 cvVnPRQWq6Af1p0fFar5hRqmL7+ZfkUQNbkIyK5b59WCEUhIM6AfLsY/RSkHBrEJTF29iESic7N
 GE26PWJsj6SwYtp1z/FMrPXpcUF9SAqvJblHJC5A/CxXGVLGAK0m0TfTKErWTs0qU4fnDhdl+fH
 5lTP7Bt5hLKEhftROd98EzukqY+hPHpbtxz51UOKmq8wMUPyyWxwNCFUim1IqHbnsG97RMO7Unv
 IoMkGav4DzjoKqpuOhN5sBmxadMsqxCoivtF4NfqlkDzAHcCxUdmAuJxT1Dzl6BxtX+Z49OIleL
 xD3B6kJ2Y1X1jXary6Mce4LiGDjD/BbTSlFQTzEM8mNb0M3R5sdIFceDqXO1AgX8iIdFZiD2Z//
 FkHcLzK+YrSBgKw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 15:02:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18849

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
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

 bin/bitbake-setup                                  | 23 ++++++++++++++-----
 .../configurations/oe-nodistro-master.conf.json    |  6 ++++-
 .../configurations/poky-master.conf.json           | 14 ++++++++++--
 .../bitbake-user-manual-environment-setup.rst      | 26 ++++++++++++++++++++--
 lib/bb/tests/setup.py                              | 25 +++++++++++++++++++--
 setup-schema/bitbake-setup.schema.json             | 21 ++++++++++++++++-
 6 files changed, 101 insertions(+), 14 deletions(-)
---
base-commit: 5127faf986d8543bb88e73cf3dccb407d80c9a25
change-id: 20260116-bitbake-setup-choose-builtin-fb199054cc25


