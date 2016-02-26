Return-Path: <alex@stunpix.com>
X-Greylist: delayed 466 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 26 Feb 2016 17:26:35 UTC
Received: from forward10j.cmail.yandex.net (forward10j.cmail.yandex.net
	[5.255.227.111])
	by mail.openembedded.org (Postfix) with ESMTP id CF94D7744C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:26:35 +0000 (UTC)
Received: from smtp11.mail.yandex.net (smtp11.mail.yandex.net
	[IPv6:2a02:6b8:0:801:1::10])
	by forward10j.cmail.yandex.net (Yandex) with ESMTP id C947121C91;
	Fri, 26 Feb 2016 20:18:48 +0300 (MSK)
Received: from smtp11.mail.yandex.net (localhost [127.0.0.1])
	by smtp11.mail.yandex.net (Yandex) with ESMTP id 6A9F87E0FC9;
	Fri, 26 Feb 2016 20:18:48 +0300 (MSK)
Received: by smtp11.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	zW3gAfeAJc-Il98tCR2; Fri, 26 Feb 2016 20:18:47 +0300
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stunpix.com; s=mail;
	t=1456507127; bh=oDtCGvpl3i/qbDxw5GxAGZyJo8b874iT1EtYPvxYIDg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Message-Id:References:To:X-Mailer;
	b=K0+b0BkaZmDlrqhFsKmC+5TNPUZbkdIMP3D/8R4TZoaWGPfTBYx4DJ65/Nwa3FBlp
	1c92UES/d9HIQBITj9xexlINPOQvrbqvis8d2hSxxkLdRiNXpFoskxGF1lnxc6sQ1p
	gqsz9J6EDOO00LQP4ATophE/bQcb+tBxUmDmdjiE=
Authentication-Results: smtp11.mail.yandex.net; dkim=pass header.i=@stunpix.com
X-Yandex-ForeignMX: US
X-Yandex-Suid-Status: 1 0,1 0
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
From: Sasha Shashkevich <alex@stunpix.com>
In-Reply-To: <1456505497.11498.81.camel@linuxfoundation.org>
Date: Fri, 26 Feb 2016 19:18:46 +0200
Message-Id: <0F5E2825-BB0A-4726-AA17-FD42D87826A0@stunpix.com>
References: <1456417951-11336-1-git-send-email-alex@stunpix.com>
	<1456483880.11498.68.camel@linuxfoundation.org>
	<8F8D0DA4-2383-4900-A0C6-9AAEA334C568@stunpix.com>
	<1456487187.11498.70.camel@linuxfoundation.org>
	<1456505497.11498.81.camel@linuxfoundation.org>
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
X-List-Received-Date: Fri, 26 Feb 2016 17:26:36 -0000
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_A7B3C320-9E13-4E10-9337-F1A923E41251"

--Apple-Mail=_A7B3C320-9E13-4E10-9337-F1A923E41251
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


>>>>> NOTE: Unpacking /home/pokybuild/yocto-autobuilder/yocto
>>>>> -worker/nightly-x86-64/build/scripts/runqemu to
>>>>> /home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86
>>>>> -64/build/build/tmp/work/i686-nativesdk-pokysdk-linux/nativesdk
>>>>> -qemu-helper/1.0-r9/
>>>>> cp: `/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86
>>>>> -64/build/scripts/runqemu' and `/home/pokybuild/yocto
>>>>> -autobuilder/yocto-worker/nightly-x86-64/build/scripts/runqemu'
>>>>> are the same file
>>>>> DEBUG: Python function base_do_unpack finished
>>>>> DEBUG: Python function do_unpack finished
>>>=20
>>>=20
>>> Despite all tests were successfully passed, something remains
>>> incorrect. Very sensitive feature. I'll check what is wrong and
>>> supply additional test cases with updated patch. Seems I need to
>>> build several configurations locally before submitting such patches
>>> =E2=80=93
>>> just tests are not enough.
>>=20
>> Yes, sadly our tests aren't entirely complete. I'd much appreciate
>> added test cases if we can figure out what the issue is.
>>=20
>> This change does introduce a change in behaviour, admittedly one
>> where
>> we think the current behaviour is incorrect. It is possible recipes
>> are
>> relying on that incorrect behaviour though and they may need
>> adjusting.
>=20
> FWIW, a:
>=20
> -                if urldata.type =3D=3D "file":
> +                if urldata.type =3D=3D "file" and not =
urldata.path.startswith("/"):
>=20
> did seem to fix the failing recipe which was doing something valid. =
What=20
> effect elsewhere this has I haven't checked.
>=20

Yep, that's the reason: SRC_URI could contain absolute paths. Thank you =
for finding that. I'll check the rest of build and send patch #3.

Regards,
Alexander=

--Apple-Mail=_A7B3C320-9E13-4E10-9337-F1A923E41251
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" class=3D""><blockquote type=3D"cite" =
class=3D""><blockquote type=3D"cite" class=3D"">NOTE: Unpacking =
/home/pokybuild/yocto-autobuilder/yocto<br =
class=3D"">-worker/nightly-x86-64/build/scripts/runqemu to<br =
class=3D"">/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86<br =
class=3D"">-64/build/build/tmp/work/i686-nativesdk-pokysdk-linux/nativesdk=
<br class=3D"">-qemu-helper/1.0-r9/<br class=3D"">cp: =
`/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86<br =
class=3D"">-64/build/scripts/runqemu' and `/home/pokybuild/yocto<br =
class=3D"">-autobuilder/yocto-worker/nightly-x86-64/build/scripts/runqemu'=
<br class=3D"">are the same file<br class=3D"">DEBUG: Python function =
base_do_unpack finished<br class=3D"">DEBUG: Python function do_unpack =
finished<br class=3D""></blockquote></blockquote><br class=3D""><br =
class=3D"">Despite all tests were successfully passed, something =
remains<br class=3D"">incorrect. Very sensitive feature. I'll check what =
is wrong and<br class=3D"">supply additional test cases with updated =
patch. Seems I need to<br class=3D"">build several configurations =
locally before submitting such patches<br class=3D"">=E2=80=93<br =
class=3D"">just tests are not enough.<br class=3D""></blockquote><br =
class=3D"">Yes, sadly our tests aren't entirely complete. I'd much =
appreciate<br class=3D"">added test cases if we can figure out what the =
issue is.<br class=3D""><br class=3D"">This change does introduce a =
change in behaviour, admittedly one<br class=3D"">where<br class=3D"">we =
think the current behaviour is incorrect. It is possible recipes<br =
class=3D"">are<br class=3D"">relying on that incorrect behaviour though =
and they may need<br class=3D"">adjusting.<br class=3D""></blockquote><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">FWIW, a:</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;if urldata.type =3D=3D "file":</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;if urldata.type =3D=3D "file" and not =
urldata.path.startswith("/"):</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">did seem to fix the =
failing recipe which was doing something valid. What<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">effect elsewhere this has =
I haven't checked.</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""></div></blockquote><div><br =
class=3D""></div>Yep, that's the reason: SRC_URI could contain absolute =
paths. Thank you for finding that. I'll check the rest of build and send =
patch #3.</div><br class=3D""><div class=3D"">Regards,</div><div =
class=3D"">Alexander</div></body></html>=

--Apple-Mail=_A7B3C320-9E13-4E10-9337-F1A923E41251--
