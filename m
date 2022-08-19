Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BF4C32772
	for <webhook@archiver.kernel.org>; Fri, 19 Aug 2022 16:55:11 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web09.5467.1660928108513678618
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Aug 2022 09:55:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de
 header.s=phobos-20191101 header.b=qnE2JpIq;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 541BA84AD8;
	Fri, 19 Aug 2022 18:55:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1660928105;
	bh=SlxA16CX9mO+qj+4wvd3u1WQHtQ7E5ImvPXuwkFQv48=;
	h=From:To:Cc:Subject:Date:From;
	b=qnE2JpIqXIBozLGjrrM5nPnU0z438RpYpiEjVS0PSEyXU0yoQ4kw5C4/OeVbrAbOV
	 cZ+jW5MmRLZ/pEr1sThEhuZQI74QWLRelERYY0fj/YLBabovdok1peneO+r5CLghX/
	 uxNxKul5v9Caew/4RsaBNsYnR7GNt5LRcmNEVwUvAe3QrxYFRK6SPIXhQs8GpU7Utl
	 hSn96Is1hvcHJKe1ZK/s+Y9JpYFZFzq9mnRdRx59WslTe3CtWJFsoL2xsLe0b1ZOxW
	 JTnNyf4TeTl2NjbNCKOKAxMzTG7kdiJX0PYdD2EY2uFjRbh13E6kx/E+4Q82AndJoE
	 fEofIFmKGaZpA==
From: Marek Vasut <marex@denx.de>
To: bitbake-devel@lists.openembedded.org
Cc: Marek Vasut <marex@denx.de>,
	Martin Jansa <Martin.Jansa@gmail.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH] [RFC] fetch2/git: Prevent git fetcher from fetching gitlab
 repository metadata
Date: Fri, 19 Aug 2022 18:54:55 +0200
Message-Id: <20220819165455.270130-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Aug 2022 16:55:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13904

The bitbake git fetcher currently fetches 'refs/*:refs/*', i.e. every
single object in the remote repository. This works poorly with gitlab
and github, which use the remote git repository to track its metadata
like merge requests, CI pipelines and such.

Specifically, gitlab generates refs/merge-requests/*, refs/pipelines/*
and refs/keep-around/* and they all contain massive amount of data that
are useless for the bitbake build purposes. The amount of useless data
can in fact be so massive (e.g. with FDO mesa.git repository) that some
proxies may outright terminate the 'git fetch' connection, and make it
appear as if bitbake got stuck on 'git fetch' with no output.

To avoid fetching all these useless metadata, tweak the git fetcher such
that it only fetches refs/heads/* and refs/tags/* . Avoid using negative
refspecs as those are only available in new git versions.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4534bd75..b5fc0a51 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -382,7 +382,7 @@ class Git(FetchMethod):
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=
=3Dud.clonedir)
=20
             runfetchcmd("%s remote add --mirror=3Dfetch origin %s" % (ud=
.basecmd, shlex.quote(repourl)), d, workdir=3Dud.clonedir)
-            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/*:ref=
s/*" % (ud.basecmd, shlex.quote(repourl))
+            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/heads=
/*:refs/heads/* refs/tags/*:refs/tags/*" % (ud.basecmd, shlex.quote(repou=
rl))
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
--=20
2.35.1


