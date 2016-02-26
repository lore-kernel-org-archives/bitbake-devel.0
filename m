Return-Path: <alex@stunpix.com>
X-Greylist: delayed 385 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 26 Feb 2016 11:36:52 UTC
Received: from forward8h.cmail.yandex.net (forward8h.cmail.yandex.net
	[87.250.230.219])
	by mail.openembedded.org (Postfix) with ESMTP id 8D2A277265
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 11:36:52 +0000 (UTC)
Received: from smtp4h.mail.yandex.net (smtp4h.mail.yandex.net
	[IPv6:2a02:6b8:0:f05::118])
	by forward8h.cmail.yandex.net (Yandex) with ESMTP id DB36A21449;
	Fri, 26 Feb 2016 14:30:22 +0300 (MSK)
Received: from smtp4h.mail.yandex.net (localhost [127.0.0.1])
	by smtp4h.mail.yandex.net (Yandex) with ESMTP id BD07F2C7EE4;
	Fri, 26 Feb 2016 14:30:21 +0300 (MSK)
Received: by smtp4h.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	Bq7E2J0EmY-UKr8Ebs5; Fri, 26 Feb 2016 14:30:21 +0300
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stunpix.com; s=mail;
	t=1456486221; bh=rQlqm9m7t3azEjOo3XKHwPkuJO7IAry9U8h8IG5s13w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	b=YBHSU4d4xKRZmqosw7k8S2807hApc41mQ9JeQzdD8riIAKU5b1aIrUPMZa3bDZCLs
	G+XKMIgm3TTD3lTuTVTwArpm9tgbykTa6dP2v2LAaJwX2NQqeImfbKGojB47lt3Z3a
	0uE1NPccD78VsR/ZS0EkgWDUaSo1qhlagsWeTXcU=
Authentication-Results: smtp4h.mail.yandex.net; dkim=pass header.i=@stunpix.com
X-Yandex-ForeignMX: US
X-Yandex-Suid-Status: 1 0,1 0
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
From: Sasha Shashkevich <alex@stunpix.com>
In-Reply-To: <1456483880.11498.68.camel@linuxfoundation.org>
Date: Fri, 26 Feb 2016 13:30:20 +0200
Message-Id: <8F8D0DA4-2383-4900-A0C6-9AAEA334C568@stunpix.com>
References: <1456417951-11336-1-git-send-email-alex@stunpix.com>
	<1456483880.11498.68.camel@linuxfoundation.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: Apple Mail (2.3112)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bb/fetch2: fixes copying of file://dir; subdir=foo, bug 6128 and bug 6129
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
X-List-Received-Date: Fri, 26 Feb 2016 11:36:52 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> On Feb 26, 2016, at 12:51, Richard Purdie =
<richard.purdie@linuxfoundation.org> wrote:
>=20
> On Thu, 2016-02-25 at 18:32 +0200, Alexander Shashkevich wrote:
>> When in SRC_URI appears file://dir;subdir=3Dfoo unpacker copies 'dir'
>> to ${WORKDIR}, not
>> ${WORKDIR}/foo as it should be.
>>=20
>> These changes are fixing following bugs as well:
>> Bug 6128 - Incorrect wildcard unpack behaviour in fetcher
>> Bug 6129 - Local directories unpack to a different location than
>> local files
>=20
> Sadly, this change isn't without side effects. For example:
>=20
> =
https://autobuilder.yoctoproject.org/main/builders/nightly-x86-64/builds/6=
80/steps/Building%20Toolchain%20Images/logs/stdio
>=20
> | NOTE: Unpacking =
/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86-64/build/script=
s/runqemu to =
/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86-64/build/build/=
tmp/work/i686-nativesdk-pokysdk-linux/nativesdk-qemu-helper/1.0-r9/
> | cp: =
`/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86-64/build/scrip=
ts/runqemu' and =
`/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86-64/build/scrip=
ts/runqemu' are the same file
> | DEBUG: Python function base_do_unpack finished
> | DEBUG: Python function do_unpack finished


Despite all tests were successfully passed, something remains incorrect. =
Very sensitive feature. I'll check what is wrong and supply additional =
test cases with updated patch. Seems I need to build several =
configurations locally before submitting such patches =E2=80=93 just =
tests are not enough.

Regards,
Alexander=

