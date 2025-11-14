Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B537CE7AB8
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:12:49 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15647.1763118766409731644
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 03:12:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=hBdwQ2QS;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 007E41A1AA0
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:12:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CAABB6060E;
	Fri, 14 Nov 2025 11:12:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACD62102F292F;
	Fri, 14 Nov 2025 12:12:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763118764; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=5iEhV80lAYCSBlBxM7vV7/Lt5b9dQTxEBcMZJLvfA8U=;
	b=hBdwQ2QSspWpl0k6ndbsjNY197LBcCYs4jL5FOmDqw/WH2eGs0qahE2nnBOepjcLWrYi9p
	98ptQdF6MmbKfyLHDbr4hLgD4Ede7ZavDK6sdJxWuMFfmn0eEufdxbmN0hcyLrQdFYplyv
	3u3RzmXv3D7vuz2Gp+F8g/Hu6bf8SBpoQks8DpPUz4j3MjjvRuMEgSE8nAel3chb7MpFEu
	2cAUfC713wbhTOVI+gvG+/Eu8aNqni74NGfdwGt3xUzUin1h4/IIRIcIkivCkhyLJl/PCa
	waC6PRNWWjyWYam2+h+vtbxP181/8ETx/CLTBxI+z/hLFzQvyMBI2nRjvOLcgA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/3] bitbake-setup doc updates
Date: Fri, 14 Nov 2025 12:12:33 +0100
Message-Id: <20251114-update-bbsetup-doc-v1-0-044070bdffec@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKEOF2kC/yXMQQ6CMBBA0auQWTsJAzRFr2Jc0HaEcQFNpzUmh
 LtbcfkW/++gnIQVbs0Oid+isq0VdGnAL9M6M0qohq7tDBENWGKYMqNzyrlEDJtH29uevLXGjFe
 oYUz8lM85vT/+1uJe7PPvBMfxBQohSUp2AAAA
X-Change-ID: 20251114-update-bbsetup-doc-73731c775589
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=635;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=xlhat71o5W6rQyep215NEp+DC+JiBIN+LsBsUhHWpGE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpFw6qCWGuhNpXFYOMXhnKcg4GPGYjgEpMNjpX6
 yIgO7xfDuuJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRcOqgAKCRDRgEFAKaOo
 NmxqD/wOkWbBZP5WHwGUQ5jpMnfIq0rk/TNlM1LhCfARMjhsDwV1ryev1QU8tRZEtVu9MxISJ5S
 e9REUVc6bGoUAMA5wCp9suFzgoFXJmb8kKTlqSQMpUsoFGyrJa1BNNWyxFaZ8+VTHnHaee4MKqJ
 i6Thf8pYl/GfaNkiWInb66T1KqsaA+gwp+3m7ksoS2gh//cz4nV88lzQIweEKMHG+aqd/bQzal/
 mQ4D2l5l7iRQ0oC/9j4tN8wuB30zACfr+x0iPSdlG05TthGlByF7DHkVoLO/WINXSrmNA/DnRhx
 wsFeOgRiIa4TcKS1qLQX/qOEV235fViQzTGlljWjB3XcOqhYVYK39AB06D2MQi2D8SwuNg+bHmU
 /FPJT2wP03KUkuzQ7sE2qB6LKMeT6Get3Za7/qqdo7cLk2vvoLzrOOqCrH2QbNmp9eHG86rxM/0
 Uv8XrYi6CQSdO98n0dWqNXeAYVLnilAZ/3JClnvuHBCI6E9MsTUDaX8/AmFFcPrR9H1Jym2wYnJ
 0SUE2DcNABhcLuK/NjoYwfK42+g23aGdLVifVg9isIIhR/aXH/vQ3RjM2dbtV5J3Hywhjuy2FaT
 6d8FcMoTS2GKLM9txHlGwEx9dAdyAxjPHX3e77XMKriUIUWYPSfe1Y/9o0tES9Xan+aZogzGQDr
 bfHe86ptFLogGwA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:12:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18393

Updates for bitbake-setup's documentation after feedback on the list,
and recent changes to bitbake-setup.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (3):
      doc/bitbake-setup: show how to clone bitbake before using bitbake-setup
      doc/bitbake-setup: quick start: change top dir path
      doc/bitbake-setup: mention the site.conf file

 .../bitbake-user-manual-environment-setup.rst      | 46 +++++++++++++++++-----
 1 file changed, 37 insertions(+), 9 deletions(-)
---
base-commit: ce90d59ff1c96d04856ca5e41a963af00d1783f1
change-id: 20251114-update-bbsetup-doc-73731c775589


