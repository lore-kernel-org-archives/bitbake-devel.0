Return-Path: <alex@stunpix.com>
Received: from forward11j.cmail.yandex.net (forward11j.cmail.yandex.net
	[5.255.227.175])
	by mail.openembedded.org (Postfix) with ESMTP id 3BA1D7391A
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 27 Feb 2016 17:24:12 +0000 (UTC)
Received: from smtp13.mail.yandex.net (smtp13.mail.yandex.net [95.108.130.68])
	by forward11j.cmail.yandex.net (Yandex) with ESMTP id 42CC4214F5;
	Sat, 27 Feb 2016 20:23:49 +0300 (MSK)
Received: from smtp13.mail.yandex.net (localhost [127.0.0.1])
	by smtp13.mail.yandex.net (Yandex) with ESMTP id D3030E4044C;
	Sat, 27 Feb 2016 20:23:48 +0300 (MSK)
Received: by smtp13.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	hDR5lPaLz8-Nmo0BEEw; Sat, 27 Feb 2016 20:23:48 +0300
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stunpix.com; s=mail;
	t=1456593828; bh=TP9hEe9ZYgfftcXYPJ9VwmMAe72rt0aoBLsAlUEaRms=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Message-Id:References:To:X-Mailer;
	b=Wn4a43+5eFc7hZNt+oqTTHIy6SRwxQRLyvxONt1flcTYlCJgdQZ7zJ0aPnpDbrP0Y
	Em8JPyVhiTBUuenC5e9EJMGD3uHXVMyMXUIPoIQsReQCaLU2PsQGtbh2jWCWnRNY46
	f3aeGSbEzLiD6pGqNZcR01bxKAaTyV9FGDlB8Pyc=
Authentication-Results: smtp13.mail.yandex.net; dkim=pass header.i=@stunpix.com
X-Yandex-ForeignMX: US
X-Yandex-Suid-Status: 1 0,1 0
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
From: Sasha Shashkevich <alex@stunpix.com>
In-Reply-To: <0F5E2825-BB0A-4726-AA17-FD42D87826A0@stunpix.com>
Date: Sat, 27 Feb 2016 19:22:43 +0200
Message-Id: <01A7B622-DF74-45F2-B9AA-E64522ED3E31@stunpix.com>
References: <1456417951-11336-1-git-send-email-alex@stunpix.com>
	<1456483880.11498.68.camel@linuxfoundation.org>
	<8F8D0DA4-2383-4900-A0C6-9AAEA334C568@stunpix.com>
	<1456487187.11498.70.camel@linuxfoundation.org>
	<1456505497.11498.81.camel@linuxfoundation.org>
	<0F5E2825-BB0A-4726-AA17-FD42D87826A0@stunpix.com>
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
X-List-Received-Date: Sat, 27 Feb 2016 17:24:15 -0000
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_A4795846-2CAE-4BA3-B637-7B9034FBD737"

--Apple-Mail=_A4795846-2CAE-4BA3-B637-7B9034FBD737
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


>>>> Despite all tests were successfully passed, something remains
>>>> incorrect. Very sensitive feature. I'll check what is wrong and
>>>> supply additional test cases with updated patch. Seems I need to
>>>> build several configurations locally before submitting such patches
>>>> =E2=80=93
>>>> just tests are not enough.
>>>=20
>>> Yes, sadly our tests aren't entirely complete. I'd much appreciate
>>> added test cases if we can figure out what the issue is.
>>>=20
>>> This change does introduce a change in behaviour, admittedly one
>>> where
>>> we think the current behaviour is incorrect. It is possible recipes
>>> are
>>> relying on that incorrect behaviour though and they may need
>>> adjusting.
>>=20
>> FWIW, a:
>>=20
>> -                if urldata.type =3D=3D "file":
>> +                if urldata.type =3D=3D "file" and not =
urldata.path.startswith("/"):
>>=20
>> did seem to fix the failing recipe which was doing something valid. =
What=20
>> effect elsewhere this has I haven't checked.
>>=20
>=20
> Yep, that's the reason: SRC_URI could contain absolute paths. Thank =
you for finding that. I'll check the rest of build and send patch #3.

Some other recipes are still failing even with your suggestion. WIP. =
This isn't my high prio task in project, so it takes some time to fix =
all cases.

Regards,
Alexander


--Apple-Mail=_A4795846-2CAE-4BA3-B637-7B9034FBD737
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D""><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space;" class=3D""><div =
class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" class=3D"">Despite all tests were =
successfully passed, something remains<br class=3D"">incorrect. Very =
sensitive feature. I'll check what is wrong and<br class=3D"">supply =
additional test cases with updated patch. Seems I need to<br =
class=3D"">build several configurations locally before submitting such =
patches<br class=3D"">=E2=80=93<br class=3D"">just tests are not =
enough.<br class=3D""></blockquote><br class=3D"">Yes, sadly our tests =
aren't entirely complete. I'd much appreciate<br class=3D"">added test =
cases if we can figure out what the issue is.<br class=3D""><br =
class=3D"">This change does introduce a change in behaviour, admittedly =
one<br class=3D"">where<br class=3D"">we think the current behaviour is =
incorrect. It is possible recipes<br class=3D"">are<br class=3D"">relying =
on that incorrect behaviour though and they may need<br =
class=3D"">adjusting.<br class=3D""></blockquote><br style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">FWIW, a:</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">- =
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
-webkit-text-stroke-width: 0px;" class=3D""></div></blockquote><div =
class=3D""><br class=3D""></div>Yep, that's the reason: SRC_URI could =
contain absolute paths. Thank you for finding that. I'll check the rest =
of build and send patch #3.</div></div></div></blockquote><div><br =
class=3D""></div>Some other recipes are still failing even with your =
suggestion. WIP. This isn't my high prio task in project, so it takes =
some time to fix all cases.</div><div><br =
class=3D""></div><div>Regards,</div><div>Alexander</div><br =
class=3D""></body></html>=

--Apple-Mail=_A4795846-2CAE-4BA3-B637-7B9034FBD737--
