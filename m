Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3938CC25B48
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 14:06:07 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.201090.1698329159879402415
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 07:06:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=GHvTMn/j;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3765D9C29B3;
	Thu, 26 Oct 2023 10:05:59 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id bD22b6TF-1m9; Thu, 26 Oct 2023 10:05:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C5FC19C29BE;
	Thu, 26 Oct 2023 10:05:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C5FC19C29BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698329158; bh=VVGjltAFHNtRNQNKFfHWAfDN6tWxVLONawhl/DkVzt4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=GHvTMn/jKqYEZDiyQuAl2wreI8dVwZ0V2eNryfXRWhfxvijk6VireRyyq47HFRsk0
	 x4D2oC/0/reX1ET9/CXOXJTma7r59JKkFiy75dGdj1joi2kjifOLWZ/APX+tL62wqf
	 LFewdkn1HYIgBkB7805sAqGbJsBwpY2c8i/nx8qXbCSzWzNC7jeVzu6F10tC8QsOII
	 0xJ2dLNcy32/6+PMIkYcfsgba+ti+P/ewYnm+r8RpnIQkAkKhvrTOBtEC6eDwpH0zP
	 r55y8apo0sD8kJu8BjAzITvykYzv9Xd/SLjPVfK1xzvmV6lop0Vt75rx40uzOCw9U3
	 hNpek69K22xkQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id GRzcSvg0vhhN; Thu, 26 Oct 2023 10:05:58 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AFC229C29B3;
	Thu, 26 Oct 2023 10:05:57 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <tim.orling@konsulko.com>,
	Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/3] Bug-fix logging permission error in docker
Date: Thu, 26 Oct 2023 15:04:52 +0100
Message-Id: <20231026140453.790676-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026140453.790676-1-alassane.yattara@savoirfairelinux.com>
References: <20231026140453.790676-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 14:06:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15288

From: Tim Orling <tim.orling@konsulko.com>

toastermain: try Path(os.environ.get('BUILDDIR')

Developer: Tim Orling
Reviewer: Alassane Yattara

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>

---
 bitbake/lib/toaster/toastermain/logs.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/toastermain/logs.py b/bitbake/lib/toaste=
r/toastermain/logs.py
index db5d459f9b..573fbef9e5 100644
--- a/bitbake/lib/toaster/toastermain/logs.py
+++ b/bitbake/lib/toaster/toastermain/logs.py
@@ -8,7 +8,7 @@ from pathlib import Path
 from django.http import HttpRequest
=20
 #BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
-BUILDDIR =3D os.environ.get("BUILDDIR")
+BUILDDIR =3D Path(os.environ.get('BUILDDIR'))
=20
=20
 def log_api_request(request, response, view, logger_name=3D'api'):
--=20
2.34.1


