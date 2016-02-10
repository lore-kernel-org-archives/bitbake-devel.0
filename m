Return-Path: <shuangistan@gmail.com>
Received: from mail-vk0-f47.google.com (mail-vk0-f47.google.com
	[209.85.213.47])
	by mail.openembedded.org (Postfix) with ESMTP id EB843731D8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Feb 2016 13:33:30 +0000 (UTC)
Received: by mail-vk0-f47.google.com with SMTP id c3so13019029vkb.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Feb 2016 05:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:cc:content-type;
	bh=w5i4shGi0f1+kgvpsEWR3MSSrNCZCWl2/VdrcAerdXQ=;
	b=fZnOLZhOSP2QG6gu1JqwR/5RarSDFIn/uspEm5VnQhuE/Z4+uWpFSuiYSFkod9lO32
	DEjlbbl96SS5EyPu+yP0GMhCfAE2PZVRiVyjcq3Ol2k6cym9vVMMgHhwy6XWL//ZCZUs
	yabQUMoGYqCeV2QzOMsA12LNnM2lMFtEf/248QxM21RByIPT7q33TyismfceLrcaDLxP
	NnHZ/J2SJa3A0ltiE4RjdvJowG+i6EMuPScqTNbzsSiKH5cXXDW+JMGHT64ZAFK4rEwG
	V/M0d7Ii5N+4T7N/DU0trBWKKluxcQATd2qUi8SwEd7xjVdwVTcjqZCtoeAFjqyTSqG+
	USfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
	:content-type;
	bh=w5i4shGi0f1+kgvpsEWR3MSSrNCZCWl2/VdrcAerdXQ=;
	b=euuyhz+ChSYhJZsnJFz+IQDO43vk8uepfi3rslv4uYvBxaLYnA5p6nh06CTVZCZR8y
	lUoTlHC/jwb709lX18gPKW7SNkhzNnO/17cTKTYLM1kjxr+IDayRK3hSSAPbF66mBHk2
	A08ntlZoRy1jW/QbF0eEPaSG5mAd7a8GPU3AQNO4rd85iBYgHS1roarPLhDmZlxkkkYh
	L8B/X/hnpJf7jLU4+BG7i2PvE/bdub0/BCibkgMqx/50X15qr+7Mc5tGBBocYuNhwlxt
	2wi+8u16/57GuuZDtNAU6htY+jrzNCxG7cINXw/IF9SRy5q3aLwq3rr8NNtZuIZA0rvX
	1RqA==
X-Gm-Message-State: AG10YOQWuTryXp1YqJJ6oXWLzeABgd0TyMeSKtjeLV26j66oXJSkHW6W0EWwN1dIzgs05gzOnkis3Dst3FZXqQ==
MIME-Version: 1.0
X-Received: by 10.31.133.19 with SMTP id h19mr29664871vkd.127.1455111211001;
	Wed, 10 Feb 2016 05:33:31 -0800 (PST)
Received: by 10.31.56.194 with HTTP; Wed, 10 Feb 2016 05:33:30 -0800 (PST)
Date: Wed, 10 Feb 2016 14:33:30 +0100
Message-ID: <CAAneanS4Ny=zQs=5jQYuS0GWf7mvFOR6tcS3rt9RUPUW3f2L-w@mail.gmail.com>
From: Shuang Liu <shuangistan@gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Sun, 14 Feb 2016 10:15:03 +0000
Cc: sliu@de.adit-jv.com
Subject: Bitbake override style removal with variable expansion
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
X-List-Received-Date: Wed, 10 Feb 2016 13:33:31 -0000
Content-Type: multipart/alternative; boundary=001a114573fad72ddb052b6a7a69

--001a114573fad72ddb052b6a7a69
Content-Type: text/plain; charset=UTF-8

Hi,

I face a problem that I tried to use the bitbake override style removal
with variable expansion.

I have a foo.bb and set FOO_PACKAGES = "${PN}_dummy"
And I use a foo.bbappend to remove it by FOO_PACKAGES_remove = "${PN}_dummy"
This doesn't work.

However, FOO_PACKAGES_remove = "foo_dummy" works fine.

Furthermore I tried other variable names besides PN, e.g.
FOO_PACKAGES = "foo_dummy"
FOONAME = "foo"
FOO_PACKAGES_remove = "${FOONAME}_dummy"
This doesn't works either.

So maybe there is some issue with variable expansion in the override style
removal?

I use bitbake 1.22 and am sorry I cannot test the master branch on my
working environment.
BitBake Build Tool Core version 1.22.0, bitbake version 1.22.0

Does somebody have some idea about thie behavior?

I am a bitbake rookie and please forgive me if the question is not
reasonable.

Thank you very much

Shuang :-

--001a114573fad72ddb052b6a7a69
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div><div><div><di=
v><div><div><div><div><div>Hi,<br><br></div>I face a problem that I tried t=
o use the bitbake override style removal with variable expansion.<br><br></=
div>I have a <a href=3D"http://foo.bb">foo.bb</a> and set FOO_PACKAGES =3D =
&quot;${PN}_dummy&quot;<br></div>And I use a foo.bbappend to remove it by F=
OO_PACKAGES_remove =3D &quot;${PN}_dummy&quot;<br></div>This doesn&#39;t wo=
rk.<br><br></div>However, FOO_PACKAGES_remove =3D &quot;foo_dummy&quot; wor=
ks fine.<br><br></div>Furthermore I tried other variable names besides PN, =
e.g.<br></div>FOO_PACKAGES =3D &quot;foo_dummy&quot;<br></div>FOONAME =3D &=
quot;foo&quot;<br></div>FOO_PACKAGES_remove =3D &quot;${FOONAME}_dummy&quot=
;<br></div>This doesn&#39;t works either.<br><br></div>So maybe there is so=
me issue with variable expansion in the override style removal?<br><br></di=
v>I use bitbake 1.22 and am sorry I cannot test the master branch on my wor=
king environment.<br>BitBake Build Tool Core version 1.22.0, bitbake versio=
n 1.22.0<br></div><br></div>Does somebody have some idea about thie behavio=
r?<br><br></div>I am a bitbake rookie and please forgive me if the question=
 is not reasonable.<br><br></div>Thank you very much<br><br></div>Shuang :-=
<br></div>

--001a114573fad72ddb052b6a7a69--
