Return-Path: <alex@stunpix.com>
Received: from forward11o.cmail.yandex.net (forward11o.cmail.yandex.net
	[37.9.109.178])
	by mail.openembedded.org (Postfix) with ESMTP id CE7A26013D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 16:54:21 +0000 (UTC)
Received: from smtp14.mail.yandex.net (smtp14.mail.yandex.net
	[IPv6:2a02:6b8:0:801:1::13])
	by forward11o.cmail.yandex.net (Yandex) with ESMTP id 9C25120C90
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 19:54:19 +0300 (MSK)
Received: from smtp14.mail.yandex.net (localhost [127.0.0.1])
	by smtp14.mail.yandex.net (Yandex) with ESMTP id 10B091B600CF
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 19:54:18 +0300 (MSK)
Received: by smtp14.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	4v0BwQi3z0-sIHqp2VD; Wed, 09 Mar 2016 19:54:18 +0300
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stunpix.com; s=mail;
	t=1457542458; bh=5XejSiFVhzgEO87MGclgV1WVM8lKxOUI+w8aIJYfW2M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:
	Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	b=jO2oWfeNqFVdeKNAE1TIH1EOmUdpdwnt/J9SibW3xxp6jc5MoU8g5WhmCHu0TvHlr
	dhOT7jJ9YtzXqO4mXytzpTgAcbqbF8N92w0NByFP8Vf4Fmah0mg+QU30A+PzIWeB9W
	jgkqLBrH23+gXT3TsEWsi7Cqz/kp/9Dl6TnHwXqs=
Authentication-Results: smtp14.mail.yandex.net; dkim=pass header.i=@stunpix.com
X-Yandex-ForeignMX: US
X-Yandex-Suid-Status: 1 0
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
From: Sasha Shashkevich <alex@stunpix.com>
In-Reply-To: <1457540149-94456-1-git-send-email-alex@stunpix.com>
Date: Wed, 9 Mar 2016 18:54:16 +0200
Message-Id: <48D48E72-F0D1-4705-BDB2-ED59E44F0354@stunpix.com>
References: <1457540149-94456-1-git-send-email-alex@stunpix.com>
To: bitbake-devel@lists.openembedded.org
X-Mailer: Apple Mail (2.3112)
Subject: Re: [PATCH v2] bb/fetch2: fixes copying of file://dir; subdir=foo, bug 6128 and bug 6129
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 09 Mar 2016 16:54:22 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> On Mar 9, 2016, at 18:15, Alexander Shashkevich <alex@stunpix.com> =
wrote:
>=20
> When in SRC_URI appears file://dir;subdir=3Dfoo unpacker copies 'dir' =
to ${WORKDIR}, not
> ${WORKDIR}/foo as it should be.
>=20
> These changes are fixing following bugs as well:
> Bug 6128 - Incorrect wildcard unpack behaviour in fetcher
> Bug 6129 - Local directories unpack to a different location than local =
files
>=20
> Signed-off-by: Alexander Shashkevich <alex@stunpix.com>
> --

Changes were tested on 1.8 and 2.0 branches for core-image-sato and =
meta-sdk images.

Additional changes since last sent patch:

 - New test cases were added to cover absolute paths in SRC_URI for =
local files.
 - Fixed recipe nativesdk-qemu-helper_1.0.bb: it was based on incorrect =
copying behavior which had been changed by this patch.

Please review my changes.

Regards,
Alexander=

