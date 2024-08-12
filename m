Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD34C52D7C
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 12:28:44 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.44994.1723465718119219250
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 05:28:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=KSeoHmAv;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 56B819C5D24;
	Mon, 12 Aug 2024 08:28:37 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id IWUbqcprqwRE; Mon, 12 Aug 2024 08:28:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C60E99C5D4F;
	Mon, 12 Aug 2024 08:28:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C60E99C5D4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723465716; bh=VW25cEKDrkSw/0qTRV9IqYD9THV3wFBU77+1vArsiVU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=KSeoHmAvRG8HhYHuioSDFb0DXiIuWiF9pIpKEdbsJTfDYz3OG7XeP2VaDBImukSjW
	 6APSYPKasAoEmWcG83ulfTEgIMMb9OpDdWjuUysqCb90iHdVce2UjrZ5vEc8LfQqv8
	 leZvvyrVRy6zdMVSGaULfoa0KyByuCogR7Fdim3UXvs7gSpNZ9XASfCAeRFq2WzDUc
	 /ZCSdwdCAbI1Yn652xZUM3XJOn5sHllyRENrtb7T1dL0rPbbx4W9LcheDE6oIvm+X+
	 ztzNFusN0lv3JbsCpjAobDLaB6hr1Y6eFypZjpmW9jKME7L1dHnszXrgkhlS4nVAC9
	 Ktxmw8x6K4LcA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id vGMYV-346j5j; Mon, 12 Aug 2024 08:28:36 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CCC7B9C5D24;
	Mon, 12 Aug 2024 08:28:35 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com
Subject: [OE-core][Patch v4 0/4] npm: improve fetcher and recipetool compatibility
Date: Mon, 12 Aug 2024 14:28:25 +0200
Message-Id: <20240812122829.577515-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 12:28:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16466

These patches improve the compatibility and accuracy of creating npm reci=
pes
through devtool, which is the intended way to create npm recipes.

This part of the series is about the oe-core changes.

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


