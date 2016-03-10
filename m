Return-Path: <alex@stunpix.com>
X-Greylist: delayed 578 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 10 Mar 2016 14:40:41 UTC
Received: from forward19m.cmail.yandex.net (forward19m.cmail.yandex.net
	[5.255.216.150])
	by mail.openembedded.org (Postfix) with ESMTP id D17FA70018
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 14:40:41 +0000 (UTC)
Received: from smtp4m.mail.yandex.net (smtp4m.mail.yandex.net
	[IPv6:2a02:6b8:0:2519::126])
	by forward19m.cmail.yandex.net (Yandex) with ESMTP id A3101212A3;
	Thu, 10 Mar 2016 17:31:02 +0300 (MSK)
Received: from smtp4m.mail.yandex.net (localhost [127.0.0.1])
	by smtp4m.mail.yandex.net (Yandex) with ESMTP id 83C0EBE0098;
	Thu, 10 Mar 2016 17:31:01 +0300 (MSK)
Received: by smtp4m.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	brFmajCzx9-V0NemmN9; Thu, 10 Mar 2016 17:31:00 +0300
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stunpix.com; s=mail;
	t=1457620261; bh=fEJ12BnS39rO9lILVhRUX7sgYhIqy4XPdGLd3l/MllM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Message-Id:References:To:X-Mailer;
	b=lvrtjZ+NdqYXexeGWcz//kJIBcSHWx16juETwzjB8ZZsIUUHu+xgh9HxseB4/n/MM
	fJkhdOuPiLwvs973Q8hFMHUcN3CSSxFNAziUKfZq6guYGC36p1TxuWfgv1aAPYq2hN
	30n1yuxpDD/mvhfpdM5i52Uvx2ZO7dgkQn7tGla4=
Authentication-Results: smtp4m.mail.yandex.net; dkim=pass header.i=@stunpix.com
X-Yandex-ForeignMX: US
X-Yandex-Suid-Status: 1 0,1 0
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
From: Sasha Shashkevich <alex@stunpix.com>
In-Reply-To: <1457563326.2804.192.camel@linuxfoundation.org>
Date: Thu, 10 Mar 2016 16:30:59 +0200
Message-Id: <9AA6C8D5-7261-41C3-B7CA-62CBAB984C9E@stunpix.com>
References: <1457540149-94456-1-git-send-email-alex@stunpix.com>
	<48D48E72-F0D1-4705-BDB2-ED59E44F0354@stunpix.com>
	<1457563326.2804.192.camel@linuxfoundation.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: Apple Mail (2.3112)
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 10 Mar 2016 14:40:42 -0000
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_00D8163D-6CF4-4DAD-9419-456CF2E9E869"

--Apple-Mail=_00D8163D-6CF4-4DAD-9419-456CF2E9E869
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


>> Changes were tested on 1.8 and 2.0 branches for core-image-sato and
>> meta-sdk images.
>>=20
>> Additional changes since last sent patch:
>>=20
>> - New test cases were added to cover absolute paths in SRC_URI for
>> local files.
>> - Fixed recipe nativesdk-qemu-helper_1.0.bb: it was based on
>> incorrect copying behavior which had been changed by this patch.
>>=20
>> Please review my changes.
>=20
> Could you have a look at master please? I already took one of your
> earlier patches which I followed with a changes to correctly handle
> absolute paths:
>=20
> =
http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/lib?id=3D2a73181
> 33bbd64f5dcb2ddf400229d4627925580
>=20
> I wasn't convinced the behaviour in the qemu-helper recipe was
> incorrect. If you still believe it is, I'm happy to consider that.
>=20
> I'm also very interested in getting some updated test cases in.
>=20

Documentation have no mentions how bitbake handles absolute paths, so I =
propose to discuss it here. I see it (and have implemented) as this: =
only last file/dir from whole path should be taken:

	file:///some/abs/path/to/file =E2=86=92 ${WORKDIR}/file

Behavior prior to this patch and how it works in current master:

	file:///some/abs/path/to/file =E2=86=92 =
${WORKDIR}/some/abs/path/to/file

qemu_helper recipe relies as well on last one:

	file://${COREBASE}/scripts/runqemu =E2=86=92 =
${WORKDIR}/home/user/projects/yocto/scripts/runqemu

But I believe that recipe authors wouldn't have =
'home/user/projects/yocto/scripts' dir in ${WORKDIR} as it completely =
host specific and useless. For such reason I have implemented behavior =
that copies only last file/dir entity from absolute path to ${WORKDIR} =
and changed qemu_helper recipe accordingly. New test cases are covering =
this behavior too.

If you agree with such behavior, then you can integrate patch v2 and =
remove your fix for qemu_helper in master since it conflicts with my =
changes.

BTW, I want to add one more test case in upcoming patch: absolute paths =
with wildcards. This should be covered also.

Regards,
Alexander=

--Apple-Mail=_00D8163D-6CF4-4DAD-9419-456CF2E9E869
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D"">Changes were tested on 1.8 =
and 2.0 branches for core-image-sato and<br class=3D"">meta-sdk =
images.<br class=3D""><br class=3D"">Additional changes since last sent =
patch:<br class=3D""><br class=3D"">- New test cases were added to cover =
absolute paths in SRC_URI for<br class=3D"">local files.<br class=3D"">- =
Fixed recipe nativesdk-qemu-helper_1.0.bb: it was based on<br =
class=3D"">incorrect copying behavior which had been changed by this =
patch.<br class=3D""><br class=3D"">Please review my changes.<br =
class=3D""></blockquote><br class=3D"">Could you have a look at master =
please? I already took one of your<br class=3D"">earlier patches which I =
followed with a changes to correctly handle<br class=3D"">absolute =
paths:<br class=3D""><br class=3D""><a =
href=3D"http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/lib?id=3D=
2a73181" =
class=3D"">http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/lib?id=
=3D2a73181</a><br class=3D"">33bbd64f5dcb2ddf400229d4627925580<br =
class=3D""><br class=3D"">I wasn't convinced the behaviour in the =
qemu-helper recipe was<br class=3D"">incorrect. If you still believe it =
is, I'm happy to consider that.<br class=3D""><br class=3D"">I'm also =
very interested in getting some updated test cases in.<br class=3D""><br =
class=3D""></blockquote><br class=3D"">Documentation have no mentions =
how bitbake handles absolute paths, so I propose to discuss it here. I =
see&nbsp;it (and have implemented) as this: only last file/dir from =
whole path should be taken:<div class=3D""><br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><a =
href=3D"file:///some/abs/path/to/file" =
class=3D"">file:///some/abs/path/to/file</a>&nbsp;=E2=86=92 =
${WORKDIR}/file<br class=3D""><br class=3D"">Behavior&nbsp;prior to this =
patch and how it works in current master:<br class=3D""><br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>file:///some/abs/path/to/file&nbsp;=E2=86=92 =
${WORKDIR}/some/abs/path/to/file<div class=3D""><br class=3D""></div><div =
class=3D"">qemu_helper recipe relies as well on last one:</div><div =
class=3D""><br class=3D""></div><div class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>file://${COREBASE}/scripts/runqemu&nbsp;=E2=86=92 =
${WORKDIR}/home/user/projects/yocto/scripts/runqemu<br class=3D""><br =
class=3D"">But I believe that recipe authors wouldn't have =
'home/user/projects/yocto/scripts' dir in ${WORKDIR} as it completely =
host specific and useless. For such reason I have implemented behavior =
that copies only last file/dir entity from absolute path to ${WORKDIR} =
and changed qemu_helper recipe accordingly. New test cases are covering =
this behavior too.</div><div class=3D""><br class=3D""></div><div =
class=3D"">If you agree with such behavior, then you can integrate patch =
v2 and remove your fix for qemu_helper in master since it conflicts with =
my changes.</div><div class=3D""><br class=3D""></div><div class=3D"">BTW,=
 I want to add one more test case in upcoming patch: absolute paths with =
wildcards. This should be covered also.</div><div class=3D""><br =
class=3D""></div><div class=3D"">Regards,</div><div =
class=3D"">Alexander</div></div></body></html>=

--Apple-Mail=_00D8163D-6CF4-4DAD-9419-456CF2E9E869--
