Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24715C3DA42
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 13:34:08 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.79891.1720445644363271543
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jul 2024 06:34:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=sckghrCH;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 902129C5D29;
	Mon,  8 Jul 2024 09:34:03 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id WscoPhz96ZwE; Mon,  8 Jul 2024 09:34:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2559B9C5C84;
	Mon,  8 Jul 2024 09:34:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 2559B9C5C84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1720445643; bh=w4VGgYgno1klN5WmUQ5gjjzEg68u0PE7gUYhdSFBCyA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=sckghrCHYy8uoUc/3t9nnFqSHaJ5pFJ9HrArLGfy5slC2UsdjXnQvvofNCq6JLfIO
	 1VJ1eo0w87CM65/H046ISvGlLvw2tbrv7HzG5qxoT2WSG9KU60qvYIQVPs5wTFFHq+
	 Ssmp8eCSb4QipJJLX0iw1rXXdf/JXdY02J7ktOsRoge9UjrIjnkAwM6Cv1lMFN8TqM
	 fUjO1Y+ystpu7nMGcj+ljQVbe7QLji/qHaVPjsHNcLH7Zp8MIAFCL4o8c3ejaFvl6y
	 h/fbZn2FQfIPnquEI3zMXD63sS+hYhkQb4sEN4BmAGMHivz/OvREWJz/f77qgBy91o
	 maX+hWTjMYfSg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8xqYTlEIPDi5; Mon,  8 Jul 2024 09:34:03 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 6AFE29C5C76;
	Mon,  8 Jul 2024 09:34:02 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org
Subject: [Patch v2] bitbake: fetch2: npmsw: fix fetching git revisions not
Date: Mon,  8 Jul 2024 15:33:53 +0200
Message-Id: <20240708133357.306422-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 13:34:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16401

These patches improve the compatibility and accuracy of creating npm reci=
pes
through devtool, which is the intended way to create npm recipes.

v2:
 - add patch to use licenses from COMMON_LICENSE_DIR
 - add patch to update licenses.csv



