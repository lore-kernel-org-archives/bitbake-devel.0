Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04427C46CA7
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 22:43:32 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.51251.1701902601752863929
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 14:43:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=gZ2ZgI+Q;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4428B9C33CC;
	Wed,  6 Dec 2023 17:43:20 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id gaq1Ney-q8rW; Wed,  6 Dec 2023 17:43:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E4D629C3632;
	Wed,  6 Dec 2023 17:43:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E4D629C3632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701902599; bh=jIOv4ok8m9dw6pIV6BBrk12vjYwBxpRDf3ZFHZWc8GM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=gZ2ZgI+QbmO0K8E8rDWw/FgFSl5FfzrF7LiuQCYxeWL+ACygT+ojK2OJ+vpIYpEAI
	 hXA8FufewxpwcUKd6O0cp8krDYe0XlMsIse+d8XOsAcGc2+MCGp3+tZOZNcWzsq0pC
	 xq6Q8SSZGha/UwWXBoVSvmMwqER4FQNOeaPiCOqwcJK2hH4EAOHi1t6cNBuWwRzfVk
	 UwyUQTRGJATdBy8zoa1NomHYiLI/T3/PCaaP27q54hrNCNGWuj9xFY0w3wRt8mJA6b
	 2ALR7ChDBUpeav37DSkRCM2X8NKo8gEkTSmuuL5sZcyz3vuZcO12z7U9LBfZwOBblB
	 5DNvkBjfaxDpQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id MP8v2T8ZL9qz; Wed,  6 Dec 2023 17:43:19 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B901F9C2CEF;
	Wed,  6 Dec 2023 17:43:19 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [toaster][PATCHv3 0/3] toaster: feat to import eventlogs]
Date: Wed,  6 Dec 2023 17:43:02 -0500
Message-Id: <20231206224305.34686-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 22:43:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15625


Added new feature to import eventlogs in toaster from the build directory=
.
V3: Added class EventPlayer to lists of libraries under  bitbake/bb/ui/ .
Updated file read functionality to match new eventlog format.

Excluded listing of files that don't contain the allvariables definitions=
 used to replay builds.
This part of the feature should be revisited on the future because the BB=
_DEFAULT_EVENTLOG variable
generates a file by use which could become infinite in a long period of t=
ime.


