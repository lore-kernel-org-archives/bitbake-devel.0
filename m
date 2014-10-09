Return-Path: <succes.incorporated@gmail.com>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
	[209.85.215.44])
	by mail.openembedded.org (Postfix) with ESMTP id 17A026A9D4
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Oct 2014 12:43:42 +0000 (UTC)
Received: by mail-la0-f44.google.com with SMTP id hs14so1096701lab.17
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 09 Oct 2014 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:content-type:subject:message-id:date:to:mime-version;
	bh=KFCPUqEI6sLo5QZbcdUKT/ZOH6eoBKofwIPAMY7/Y34=;
	b=AfOhbDWldgh0kxb/Sfd4em0gOMNIemGgok2K2G6HzTNmIcQPLt0OzA5DUqfVaMIc+D
	RWUgqMtWw/z7SrNf1eKYB4RaZA4MmgAmc5IS8icgQ09PSCUqtA5uRJyl02nzwbddptKH
	apDsa3BsPOxz4PyoyUnK57yP22/u7br7wkkpHLpYibmazYGHr34h1Jvh4Z+uXTwi7dm9
	jQ/Harf2wqZNp1fNJ9ouqt7SIG5EzQ0Ba9YTbZbCRP3vfZDqb8zOKdcUVXa5FJaMgODf
	AdHAVJ6FA1r23hrwRSG/MCu8GlZ0yobHQtcYedTLYSB7rSrrAvDpeIpt0Qi/iAF2t44R
	di4g==
X-Received: by 10.112.73.4 with SMTP id h4mr17404180lbv.19.1412858622710;
	Thu, 09 Oct 2014 05:43:42 -0700 (PDT)
Received: from [10.192.96.130] ([192.38.33.17])
	by mx.google.com with ESMTPSA id q17sm933548lal.42.2014.10.09.05.43.41
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 09 Oct 2014 05:43:41 -0700 (PDT)
From: Manuel Piroz <succes.incorporated@gmail.com>
Message-Id: <C62CE9D6-CFC7-4D06-A28F-FA3536E9A2D6@gmail.com>
Date: Thu, 9 Oct 2014 14:43:39 +0200
To: bitbake-devel@lists.openembedded.org
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
X-Mailer: Apple Mail (2.1878.6)
Subject: help
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
X-List-Received-Date: Thu, 09 Oct 2014 12:43:44 -0000
X-Groupsio-MsgNum: 5076
Content-Type: multipart/signed;
	boundary="Apple-Mail=_E0F9146D-B217-4E34-A8E9-12F91ABEC30E";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_E0F9146D-B217-4E34-A8E9-12F91ABEC30E
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_BECC8BCE-0016-4114-ADF6-F6687F63FA75"

--Apple-Mail=_BECC8BCE-0016-4114-ADF6-F6687F63FA75
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello All
I=92m new to the community and i just started building
i have a bit of a problem trying to build an image i have searched the =
WWW for answers and no luck. I=92m running the command=20
=93bitbake core-image-minimal=94=20

Loading cache: 100% =
|#########################################################################=
##############################################| ETA:  00:00:00
Loaded 1222 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        =3D "1.22.0"
BUILD_SYS         =3D "x86_64-linux"
NATIVELSBSTRING   =3D "Fedora-20"
TARGET_SYS        =3D "i586-poky-linux"
MACHINE           =3D "qemux86"
DISTRO            =3D "poky"
DISTRO_VERSION    =3D "1.6.1"
TUNE_FEATURES     =3D "m32 i586"
TARGET_FPU        =3D ""
meta             =20
meta-yocto       =20
meta-yocto-bsp    =3D "daisy:7a12eda78555a78ad33c6e38c1ed2b29982b165f"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
Currently 15 running tasks (624 of 1791):

// This is The beginning of the build






// this is the END
Summary: 1 task failed:
  =
virtual:native:/home/Yocto/Mano/poky/meta/recipes-core/ncurses/ncurses_5.9=
.bb, do_install
Summary: There was 1 WARNING message shown.
Summary: There were 2 ERROR messages shown, returning a non-zero exit =
code.
[UNITdaMERCENARY@YoctoBuild 4]$=20



--Apple-Mail=_BECC8BCE-0016-4114-ADF6-F6687F63FA75
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Hello =
All<div>I=92m new to the community and i just started =
building</div><div>i have a bit of a problem trying to build an image i =
have searched the WWW for answers and no luck. I=92m running the =
command&nbsp;</div><div>=93bitbake =
core-image-minimal=94&nbsp;</div><div><br></div><div><div style=3D"margin:=
 0px; font-size: 13px; font-family: Menlo; color: rgb(0, 237, 15); =
background-color: rgb(0, 0, 0);">Loading cache: 100% =
|#########################################################################=
##############################################| ETA:&nbsp; =
00:00:00</div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, 0);">Loaded =
1222 entries from dependency cache.</div><div style=3D"margin: 0px; =
font-size: 13px; font-family: Menlo; color: rgb(0, 237, 15); =
background-color: rgb(0, 0, 0);"><span style=3D"color: =
#000000"><b>NOTE</b></span>: Resolving any missing task queue =
dependencies</div><div style=3D"margin: 0px; font-size: 13px; =
font-family: Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0); min-height: 15px;"><br></div><div style=3D"margin: 0px; font-size: =
13px; font-family: Menlo; color: rgb(0, 237, 15); background-color: =
rgb(0, 0, 0);">Build Configuration:</div><div style=3D"margin: 0px; =
font-size: 13px; font-family: Menlo; color: rgb(0, 237, 15); =
background-color: rgb(0, 0, 0);">BB_VERSION&nbsp; &nbsp; &nbsp; &nbsp; =3D=
 "1.22.0"</div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);">BUILD_SYS &nbsp; &nbsp; &nbsp; &nbsp; =3D "x86_64-linux"</div><div =
style=3D"margin: 0px; font-size: 13px; font-family: Menlo; color: rgb(0, =
237, 15); background-color: rgb(0, 0, 0);">NATIVELSBSTRING &nbsp; =3D =
"Fedora-20"</div><div style=3D"margin: 0px; font-size: 13px; =
font-family: Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);">TARGET_SYS&nbsp; &nbsp; &nbsp; &nbsp; =3D =
"i586-poky-linux"</div><div style=3D"margin: 0px; font-size: 13px; =
font-family: Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);">MACHINE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D "qemux86"</div><div =
style=3D"margin: 0px; font-size: 13px; font-family: Menlo; color: rgb(0, =
237, 15); background-color: rgb(0, 0, 0);">DISTRO&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; =3D "poky"</div><div style=3D"margin: 0px; =
font-size: 13px; font-family: Menlo; color: rgb(0, 237, 15); =
background-color: rgb(0, 0, 0);">DISTRO_VERSION&nbsp; &nbsp; =3D =
"1.6.1"</div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);">TUNE_FEATURES &nbsp; &nbsp; =3D "m32 i586"</div><div style=3D"margin:=
 0px; font-size: 13px; font-family: Menlo; color: rgb(0, 237, 15); =
background-color: rgb(0, 0, 0);">TARGET_FPU&nbsp; &nbsp; &nbsp; &nbsp; =3D=
 ""</div><div style=3D"margin: 0px; font-size: 13px; font-family: Menlo; =
color: rgb(0, 237, 15); background-color: rgb(0, 0, 0);">meta &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div><div style=3D"margin: =
0px; font-size: 13px; font-family: Menlo; color: rgb(0, 237, 15); =
background-color: rgb(0, 0, 0);">meta-yocto &nbsp; &nbsp; &nbsp; =
&nbsp;</div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);">meta-yocto-bsp&nbsp; &nbsp; =3D =
"daisy:7a12eda78555a78ad33c6e38c1ed2b29982b165f"</div><div =
style=3D"margin: 0px; font-size: 13px; font-family: Menlo; color: rgb(0, =
237, 15); background-color: rgb(0, 0, 0); min-height: =
15px;"><br></div><div style=3D"margin: 0px; font-size: 13px; =
font-family: Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);"><span style=3D"color: #000000"><b>NOTE</b></span>: Preparing =
runqueue</div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, 0);"><span =
style=3D"color: #000000"><b>NOTE</b></span>: Executing SetScene =
Tasks</div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, 0);"><span =
style=3D"color: #000000"><b>NOTE</b></span>: Executing RunQueue =
Tasks</div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);">Currently 15 running tasks (624 of 1791):</div></div><div =
style=3D"margin: 0px; font-size: 13px; font-family: Menlo; color: rgb(0, =
237, 15); background-color: rgb(0, 0, 0);"><br></div><div style=3D"margin:=
 0px; font-size: 13px; font-family: Menlo; color: rgb(0, 237, 15); =
background-color: rgb(0, 0, 0);">// This is The beginning of the =
build</div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);"><br></div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);"><br></div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);"><br></div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);"><br></div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);"><br></div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);"><br></div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, 0);">// this =
is the END</div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, 0);">Summary: =
1 task failed:</div><div style=3D"margin: 0px; font-size: 13px; =
font-family: Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);">&nbsp; =
virtual:native:/home/Yocto/Mano/poky/meta/recipes-core/ncurses/ncurses_5.9=
.bb, do_install</div><div style=3D"margin: 0px; font-size: 13px; =
font-family: Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);">Summary: There was 1 WARNING message shown.</div><div =
style=3D"margin: 0px; font-size: 13px; font-family: Menlo; color: rgb(0, =
237, 15); background-color: rgb(0, 0, 0);">Summary: There were 2 ERROR =
messages shown, returning a non-zero exit code.</div><div style=3D"margin:=
 0px; font-size: 13px; font-family: Menlo; color: rgb(0, 237, 15); =
background-color: rgb(0, 0, 0);">[UNITdaMERCENARY@YoctoBuild =
4]$&nbsp;</div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);"><br></div><div style=3D"margin: 0px; font-size: 13px; font-family: =
Menlo; color: rgb(0, 237, 15); background-color: rgb(0, 0, =
0);"><br></div></body></html>=

--Apple-Mail=_BECC8BCE-0016-4114-ADF6-F6687F63FA75--

--Apple-Mail=_E0F9146D-B217-4E34-A8E9-12F91ABEC30E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJUNoL7AAoJEJ1TlXF66+4YRmwH/RGYzG9rc9h0rR3TDntVBmXH
dd8hif11Db12t8RaZJi5jyhRQb1QA6Z+OodRjsqlTkljX0zpQKdz5nKr7GI+Tt0N
8bgc2vlIMX6mMvjq75lPqdWIS0Sup+0sZfXlhRudsIull2WkpXnAWJUs8YaW7hsD
xHPTed/TSGbq7gm5Jjx3IkEpXG/FRg8PIX16TpsFpcKAthIx7torEfbMWXeyK8lg
CELhfKZUXadLyuU5oWxMwNBzcFjdWb9tk0kYlILWo+ciFYIWUwkc7oDBi8o9GxxK
mFKepqw89YPPgPA6Hs0Z7YB2YH67fXWi2mYpyNpr3ND6xCnZjjsTpIJrxr95sJA=
=I40D
-----END PGP SIGNATURE-----

--Apple-Mail=_E0F9146D-B217-4E34-A8E9-12F91ABEC30E--
