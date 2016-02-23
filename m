Return-Path: <alex@stunpix.com>
Received: from forward4o.cmail.yandex.net (forward4o.cmail.yandex.net
	[37.9.109.248])
	by mail.openembedded.org (Postfix) with ESMTP id D9C3E77291
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 21:45:56 +0000 (UTC)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::28])
	by forward4o.cmail.yandex.net (Yandex) with ESMTP id 22DB420FA5;
	Wed, 24 Feb 2016 00:45:55 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (localhost [127.0.0.1])
	by smtp4o.mail.yandex.net (Yandex) with ESMTP id D423D232021D;
	Wed, 24 Feb 2016 00:45:54 +0300 (MSK)
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	pmYgPAS0ZO-jsqOfLvh; Wed, 24 Feb 2016 00:45:54 +0300
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stunpix.com; s=mail;
	t=1456263954; bh=Ygb3n7qDJATkSd67oR7yK5FvySc1oKqMSqn/gp25v4Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	b=hNAKWWH7Q6pjnTo3pfjFI8klM3Q5a1JlOouTUaN92eeh3KavSvE3S2eHGw7HZYV5x
	yec3jZ9m/Gu5nzUmiiyDKHBZepLKLL5BRYGEZqQ94fjuxZUZuCRxGdfP+Fc97Qpwd7
	liJ1s5DSIegrpNB12obxPoxtFi8nhDlu/1BJL2Ms=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@stunpix.com
X-Yandex-Suid-Status: 1 0,1 0
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
From: Sasha Shashkevich <alex@stunpix.com>
In-Reply-To: <1456174278.28376.199.camel@linuxfoundation.org>
Date: Tue, 23 Feb 2016 23:45:53 +0200
Message-Id: <7649ECE9-ABB2-4984-A4EA-0288C35C2F6F@stunpix.com>
References: <1456166091-13075-1-git-send-email-alex@stunpix.com>
	<1456174278.28376.199.camel@linuxfoundation.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: Apple Mail (2.3112)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bb/fetch2: broken functionality for entries like file://dir; subdir=foo in SRC_URI
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
X-List-Received-Date: Tue, 23 Feb 2016 21:45:57 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> On Feb 22, 2016, at 22:51, Richard Purdie =
<richard.purdie@linuxfoundation.org> wrote:
>=20
> On Mon, 2016-02-22 at 20:34 +0200, Alexander Shashkevich wrote:
>> For SRC_URI entries like file://dir1;subdir=3Dfoo1 and
>> file://dir2/dir3;subdir=3Dfoo2/foo3
>> subdirectories ${WORKDIR}/foo1 and ${WORKDIR}/foo2/foo3 are created,
>> but dir1 and dir2/dir3 are
>> only copied to ${WORKDIR}/dir1 and ${WORKDIR}/dir2/dir. Correct way:
>> directories must be copied/unpacked
>> into '${WORKDIR}/foo1/dir1' and '${WORKDIR}/foo2/foo3/dir2/dir'
>> respectively.
>=20
> Where we have cases like this, I'd ask that you add a test case to
> lib/bb/tests/ which illustrates the problem and ensures we don't
> regress in future. We've had far too many problems with corner cases
> and the fetcher :(
>=20
> I need to properly review the patch but wanted to mention this now.

Good point. Just launched test cases for my changes and one regression =
appeared. Bad. I'll fix regression and add test cases.

Thank you. :)

Alexander=

