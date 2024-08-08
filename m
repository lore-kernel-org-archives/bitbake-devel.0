Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60873C52D6F
	for <webhook@archiver.kernel.org>; Thu,  8 Aug 2024 14:48:38 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.61876.1723128513470336299
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Aug 2024 07:48:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Z6haJ0t3;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 688619C589A;
	Thu,  8 Aug 2024 10:48:32 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id RRy39JhQX35K; Thu,  8 Aug 2024 10:48:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EEC9E9C58EF;
	Thu,  8 Aug 2024 10:48:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com EEC9E9C58EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723128512; bh=HH/WQYZJQ2YIqFAQQg23EdDwHmlVzBL1uq9Nb7QTUso=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Z6haJ0t3bCOxuP+nqOwe0GtdMF0TdgdMNbcZLc4oHiXI28apbIqVIjq1B6l/qtZ2p
	 rNgx2tRMRldvb+LgjRzsZqE+ztM2EZnygiPJu0cP0pirsZfV/cWzSN6IvDj876TIGb
	 xww0+bOHtyGmdWDdnn7rVtk1IFmtBsF1ksfsyJmDk0coTaiHRY2bj+miMO/99lq9ch
	 FlGhQ3rxLwVTAH0HhSpVtsowcBoq8ssr1dnAWQCo2ZAnSsykV/jheRJ36WgGMJ1Kbf
	 ODXWJSepXUEXEkQ+IA47MJpC1iX4IuYhlbEx0AFcilUkakuQNS1yHUWMKJabZrIl3H
	 vOJ7ewOibLvsQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id jIQ9eA1EvHJq; Thu,  8 Aug 2024 10:48:31 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 03E9E9C589A;
	Thu,  8 Aug 2024 10:48:30 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com
Subject: [Patch v3 0/6] npm: improve fetcher and recipetool compatibility
Date: Thu,  8 Aug 2024 16:48:18 +0200
Message-Id: <20240808144824.543208-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Aug 2024 14:48:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16453

These patches improve the compatibility and accuracy of creating npm reci=
pes
through devtool, which is the intended way to create npm recipes.

v3:
 - split bitbake and oecore commits
 - added refactor commit to remove duplicated code to find and match lice=
nses
 - removed commit that copied all the COMMON_LICENSE_DIR md5 to licenses.=
csv
   (thanks to the new refactor)
v2: https://lists.openembedded.org/g/bitbake-devel/message/16401?p=3D%2C%=
2C%2C20%2C0%2C0%2C0%3A%3ACreated%2C%2Cnpm%2C20%2C2%2C0%2C107102413



