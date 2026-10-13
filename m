Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB166CC6B1A
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 12:14:12 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5604.1791893644999425401
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 05:14:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=r9WVvgPa;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 48DE7C653E9;
	Tue, 13 Oct 2026 12:14:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A33B860362;
	Tue, 13 Oct 2026 12:14:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6532E11D71059;
	Tue, 13 Oct 2026 14:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791893641; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=XWifA/YnQo1CWD+T0SAgUutgm1sfXVQ585RZRKHhLi8=;
	b=r9WVvgPardJT5CNtXMRkgLmQKBiumPfW1997VZNSoDIt1puM8GeuNp+5Ty7v08NL1p8Z79
	gKcmypitsiE3IRLpcC9+DUTiRdYCDDS/mw4txTXIAEDjCNgzWYRb6Gv94EKoRhMh6V6yOl
	iE8SfrE7Yqm/1fNj99n2KJsjtjWNpNZGS5PX5aFBo2gYku2XVeeuPLx5Naxy/Z3ZVUaY+q
	cGEzj+lxCSWpkYAo52jbpvpTAPb5j5gqef2B5p3j6kNQ0+KFeX4sqlDhPxGBt2Wca5vJdY
	cen7A0gDp9hYFo5xArkSzrEGk+nJToGq7mFDRbXnCHQtwyJSgO8/xeVe545SUw==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/4] Add -W to treat warnings as errors
Date: Tue, 13 Oct 2026 14:13:33 +0200
Message-Id: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAyA4VchPdNkLASdr0I8lK1qPQzTipIQ3
 p0Bx+/w/wsYq7DBrVpA+ScmYy5o6grii/KTUVIxeOc7F5oW/6QZyZBVRzWkEK8XcpR8ClCij/J
 D5mPY30/bNLw5fvcLrOsGPAC36HIAAAA=
X-Change-ID: 20260914-warn-as-errors-a9c87a0ad2d9
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=1jv5Ceva5NmBcY+TPvD1cskN3wFRClIa3FcJK0bGoRA=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqziB0Tnndp70aqNKEMf0PaWzlT/Bp8AOWso5ZG
 CkjOkezNgeJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCas4gdAAKCRDRgEFAKaOo
 NrkqD/93QSLXcvpKkfOdOBawABZpTattP2B2udUN+K5B95WcyAFDV25LbPWdRGduEnL4AJCZQT8
 fZjSAx41piMnbOOJg+6q0y1Uxk6OhYExnjin9Y/Hkm0rZiD+Lwzh4V7K4XFpYw5BU4P37nYaXas
 r6OipRChcdK+fmSgh8HlIzncnU2ZlOs6hSWQDHXI9+5sDwOImB5aIABhaL4mIY5UUqQJABZVmsX
 fB2u3jzFjULTHhAE4M/+8R2+wsZAKp8KT9yWO9hz6cMFWLuRZOwktBwNuvSWb11tiULcIXRTIXp
 oMFi7YjsU7ZPENCEswIUhNiZ3iWg7i/nrXaIuwinJf+tZ5pjM8O24pjepI0WJY9DcJVBdoOuD75
 zYHczK1fsOX5RYIGqfFKolZaGb9HFpYRzvDk+EtlyynYUx6wzpqfY1RynF3dLJ+9oIit9okjdiF
 Bq6erbtJaHF80dcaiMl8ZmeXjJ0KKjVvSldaCLawdpS+S/9vgv2S2vRk3uL6dfbbLgrb4My9XR7
 T8hCEqteY/CDDVX6CHk4IIWTYiYFY2+VyMQUItm3EmcMtWtcIkbXoB4P+Uy9FToyUQj5a7oizWv
 O2L3srX8y1gitqJOE6h2i/JNllgyAQtcjR2CjzTUmD8Cg5L0eIbfEzTGAMqbBqzkm3QoMlUhjSD
 uNLfXL6y4B7qG3Q==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 12:14:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20325

The purpose of this series is to implement the -W option to bitbake to
be able to treat warnings as errors and make the return value 1 in that
case. This is useful in environments that need to make sure the build
passed without warnings. Currently this is usually done by a
post-process task grepping the last log for warnings.

With knotty, the -W/--warnings-as-errors option will turn warning
messages to the red color (useful to know that the option is in use
during the build) and make the return value be 1 in case of warnings. An
additional summary line is displayed at the end to let the user know
that the option was in use for this execution of bitbake.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (4):
      main: add an argument for showing warnings as errors
      msg: add a helper to show warnings in red color
      knotty: convert warnings to errors when -W is passed
      doc/bitbake-user-manual-intro.rst: refresh bitbake's help message

 .../bitbake-user-manual-intro.rst                  | 36 ++++++++++++----------
 lib/bb/main.py                                     |  3 ++
 lib/bb/msg.py                                      |  8 +++++
 lib/bb/ui/knotty.py                                | 14 +++++++++
 4 files changed, 45 insertions(+), 16 deletions(-)
---
base-commit: a17e8093fd4d5ed7792df86af8d2d63803dc42a4
change-id: 20260914-warn-as-errors-a9c87a0ad2d9


