Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F02C3DA7F
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 12:25:54 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.44941.1723465550116656664
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 05:25:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=p03lNHTB;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DD4199C5D24;
	Mon, 12 Aug 2024 08:25:48 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id shX4tTg2qQmH; Mon, 12 Aug 2024 08:25:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 78E029C5CBC;
	Mon, 12 Aug 2024 08:25:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 78E029C5CBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723465548; bh=psOZStOhuGHoh8SdKQvuDTvyiMGAC4dwfpu/lPKycVU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=p03lNHTBCppZ6vbA5RnTcoRB51EeOWo0vXYDmNiwTONiVzl5dvVEoTYBbvP6WwkaL
	 zQ5SPYGabsfhoHOBGeuvStapX9pUo2ouxZEX43eIVhUOHEAxOaEbBC4L+erlp3PHVr
	 rxugJo8F/aLMmFEmgcTuulQ1/3lrKKcg/OmaQotue63QhH2k/1JcYOTnYNujb8A35z
	 LYbs1h4V65PZo48Vr/I4yw7RW3cZIfpgYCV6nWVPk0TPRlPqMsZcrwsg/aFvrKB9Nc
	 XRdXED/vGI4ohJll/lTMJ0Uz403b3lzP/iv8F2vA9wyqAhamueYYDzRQMtctNcOZkh
	 kLYXUmNgBXgWw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fLxpdnmbUEPp; Mon, 12 Aug 2024 08:25:48 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 84F419C56BD;
	Mon, 12 Aug 2024 08:25:47 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com
Subject: [bitbake-devel][Patch v4 0/2] npm: improve fetcher and recipetool compatibility
Date: Mon, 12 Aug 2024 14:25:37 +0200
Message-Id: <20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 12:25:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16463

These patches improve the compatibility and accuracy of creating npm reci=
pes
through devtool, which is the intended way to create npm recipes.

This part of the series is about the bitbake changes.

v4:
 - fix oe-selftest
 - submit bitbake and oe-core patches separately
v3: https://lore.kernel.org/bitbake-devel/20240808144824.543208-1-enguerr=
and.de-ribaucourt@savoirfairelinux.com/
 - split bitbake and oecore commits
 - added refactor commit to remove duplicated code to find and match lice=
nses
 - removed commit that copied all the COMMON_LICENSE_DIR md5 to licenses.=
csv
   (thanks to the new refactor)
v2: https://lists.openembedded.org/g/bitbake-devel/message/16401?p=3D%2C%=
2C%2C20%2C0%2C0%2C0%3A%3ACreated%2C%2Cnpm%2C20%2C2%2C0%2C107102413


