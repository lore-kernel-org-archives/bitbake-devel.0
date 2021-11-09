Return-Path: <peter@hatina.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DCFC433F5
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 12:59:52 +0000 (UTC)
Received: from mail.hatina.eu (mail.hatina.eu [194.182.66.63])
 by mx.groups.io with SMTP id smtpd.web11.11547.1636462790582421450
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:59:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@hatina.eu header.s=dkim header.b=Hvwe1qiX;
 spf=pass (domain: hatina.eu, ip: 194.182.66.63, mailfrom: peter@hatina.eu)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5C3C081B2A
	for <bitbake-devel@lists.openembedded.org>;
 Tue,  9 Nov 2021 13:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hatina.eu; s=dkim;
	t=1636462786; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5PS1t0q0YM8XGRVpS9rojjWpiKuh/kRMq+AAE1nglLE=;
	b=Hvwe1qiXCd6JDXHykUtK+7u9uNosY/qZR7mkjNqADfXWUlQ9dY7x9x66mhjZb6DHoN3lp3
	IMcssX4R9OKUHbXl8LJrQaXQh+/Zcc/QAnK/p/F0r4dsgiHwBXfyGcOrPAH9zo59P+mP0+
	pncWDz2VgQa8rB6ruwO6/IY6KNJHatOsSxOz2AWNUJin/6/xm73VG+Jy8QD+JwhqMuw4S9
	IFoFe/h8suC+pDcWZY3OamwEmZZaiO1dZkKvPHasPPu7QmL1QYLkOvU76qav/WieyoUguM
	ppBhisA4x8GPKqhpWL45XXrMFXDMnU1LBy96T0QbLdjGo8P4wEAXHTVJg21TEw==
From: Peter Hatina <peter@hatina.eu>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] bitbake style/workflow
Date: Tue, 09 Nov 2021 13:59:46 +0100
Message-ID: <5526793.12DZrFb018@xps13.hatina.eu>
In-Reply-To: 
 <CAD=4a=VtVpxjFUUB-0KPePw-Js5vctqDEYZitM8H4vgaE1TNCA@mail.gmail.com>
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <CAMaS9hPn5k2w+MXzPE6jLfkYJmQi8CMTNbhtUu64Vn6avs-e0w@mail.gmail.com>
 <CAD=4a=VtVpxjFUUB-0KPePw-Js5vctqDEYZitM8H4vgaE1TNCA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 12:59:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12971

Hi there,

same thing here.

+1

On Tuesday, November 9, 2021 1:57:15 PM CET Ernst Sj=F6strand wrote:
> Hi,
>=20
> jumping into the thread a bit randomly.
>=20
> I work with Yocto at $DAYJOB and the use of a mailing list for patches has
> really hindered me from contributing, with Outlook and DMARC etc.
> I'd much prefer something like Gitlab! When the Mesa project switched to
> Gitlab I set up an email subscription for all new merge requests
> which emulated the old feed of emails pretty well IMHO.
>=20
> For the code review I've always preferred Gerrit for it's powerful system
> of patchsets and ability to review the commit messages very clearly.
>=20
> Regards
> //Ernst

=2D-=20
s pozdravom/regards,
Peter Hatina



