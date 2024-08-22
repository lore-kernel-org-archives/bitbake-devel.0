Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB8EC5321E
	for <webhook@archiver.kernel.org>; Thu, 22 Aug 2024 07:53:30 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.8327.1724313204986373159
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Aug 2024 00:53:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=SuyAwP2+;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9C0589C5DDB;
	Thu, 22 Aug 2024 03:53:23 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id U_svQGPOtSx4; Thu, 22 Aug 2024 03:53:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 001559C5D12;
	Thu, 22 Aug 2024 03:53:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 001559C5D12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1724313203; bh=W3qyceWREGrBEwtTfhSLEg8I95J2DwUWV0iSNCH2Z94=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=SuyAwP2+2ZA8Dw4MIO2bYenfXLUTxKpKXsBlXPxP/ipqsIZ/hrELRZfJ0Tp/GZLIT
	 sCby0bjy4A/qfTJc+V0ifu87LIn6Mjt4TbE3AKGRPoCNRBdbiRZb4AkQafqq5auJZz
	 wUg6asn614vewZ+xZaptj6SXvOH3qxWMP2EI/Wje6kfhOnu9MALDpDFNEito8npr6g
	 bXGj3rDDz2URCKiYI1qA8Se8YyXcW0HEWF1jVK5LzmVZvwyf4D8z4OTi2rDkKxNTQF
	 locGd5j+v13UNylv/OIOURs57ecSktoN5r3HZViJCtY+QwWgO7MmDuFcK0Fo29+Gs/
	 g7X8a66T/kG1Q==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id LKGjGv-K2GhD; Thu, 22 Aug 2024 03:53:22 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0A88C9C5763;
	Thu, 22 Aug 2024 03:53:21 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com
Subject: [bitbake-devel][Patch v5 0/2] npm: improve fetcher and recipetool compatibility
Date: Thu, 22 Aug 2024 09:53:13 +0200
Message-Id: <20240822075315.18570-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Aug 2024 07:53:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16513

These patches improve the compatibility and accuracy of creating npm reci=
pes
through devtool, which is the intended way to create npm recipes.

This part of the series is about the bitbake changes.

v5:
 - improve commit message
v4: https://lore.kernel.org/bitbake-devel/20240812122539.573337-1-enguerr=
and.de-ribaucourt@savoirfairelinux.com/T/#m4a99d67b4c445fc199ab31266438e1=
737e08266b
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




