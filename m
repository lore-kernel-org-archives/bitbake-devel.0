Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id 601787316E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 13:02:19 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-FEM-01.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp 
	id 1a9YCJ-0001ts-Nx from Awais_Belal@mentor.com 
	for bitbake-devel@lists.openembedded.org;
	Thu, 17 Dec 2015 05:02:20 -0800
Received: from EU-MBX-03.mgc.mentorg.com ([169.254.2.36]) by
	SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) with mapi id
	14.03.0224.002; Thu, 17 Dec 2015 13:02:18 +0000
From: "Belal, Awais" <Awais_Belal@mentor.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: fetch: use orig localpath
	when calling orig method
Thread-Index: AQHRN7WTLy9Y594dpke9G+YewV0Yzp7PJsVQ
Date: Thu, 17 Dec 2015 13:02:18 +0000
Message-ID: <2021B186DC632746BD5A3CE32F12BD280119AB7286@EU-MBX-03.mgc.mentorg.com>
References: <1449773843-23411-1-git-send-email-awais_belal@mentor.com>
	<2021B186DC632746BD5A3CE32F12BD280119AA60C3@EU-MBX-02.mgc.mentorg.com>,
	<CABcZANm0FxRqAfJdjLS1nq9JQ3fJeQNBAd3zWYqiWmZKhLR0cw@mail.gmail.com>
In-Reply-To: <CABcZANm0FxRqAfJdjLS1nq9JQ3fJeQNBAd3zWYqiWmZKhLR0cw@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.202.0.68]
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake: fetch: use orig localpath when calling orig method
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
X-List-Received-Date: Thu, 17 Dec 2015 13:02:20 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_2021B186DC632746BD5A3CE32F12BD280119AB7286EUMBX03mgcmen_"

--_000_2021B186DC632746BD5A3CE32F12BD280119AB7286EUMBX03mgcmen_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ping! Is there a reservation against this?

BR,
Awais
________________________________
From: kergoth@gmail.com [kergoth@gmail.com] on behalf of Christopher Larson=
 [clarson@kergoth.com]
Sent: Wednesday, December 16, 2015 8:54 AM
To: Belal, Awais
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch: use orig localpath whe=
n calling orig method


On Fri, Dec 11, 2015 at 3:56 AM, Belal, Awais <Awais_Belal@mentor.com<mailt=
o:Awais_Belal@mentor.com>> wrote:
This applies to 1.28 as well and otherwise broken builds are seen where the=
 git tarball from source mirror is outdated.

As Awais says, without this applied, if you have an out of date git mirror =
tarball, you'll get a do_fetch failure, so I think we really need this merg=
ed.
--
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--_000_2021B186DC632746BD5A3CE32F12BD280119AB7286EUMBX03mgcmen_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">Ping! Is there a reservation against this?<br>
<div><br>
<div style=3D"font-family:Tahoma; font-size:13px"><font face=3D"Tahoma"></f=
ont>
<div style=3D"font-size:13px">
<div><font face=3D"Tahoma" size=3D"2"><span lang=3D"en-US">
<div style=3D"margin:0">BR,</div>
<div style=3D"margin:0"><i>Awais</i></div>
</span></font></div>
</div>
<font face=3D"Tahoma"></font></div>
</div>
<div style=3D"font-family: Times New Roman; color: #000000; font-size: 16px=
">
<hr tabindex=3D"-1">
<div style=3D"direction: ltr;" id=3D"divRpF183948"><font color=3D"#000000" =
face=3D"Tahoma" size=3D"2"><b>From:</b> kergoth@gmail.com [kergoth@gmail.co=
m] on behalf of Christopher Larson [clarson@kergoth.com]<br>
<b>Sent:</b> Wednesday, December 16, 2015 8:54 AM<br>
<b>To:</b> Belal, Awais<br>
<b>Cc:</b> bitbake-devel@lists.openembedded.org<br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH] bitbake: fetch: use orig localp=
ath when calling orig method<br>
</font><br>
</div>
<div></div>
<div>
<div dir=3D"ltr">
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">On Fri, Dec 11, 2015 at 3:56 AM, Belal, Awais <s=
pan dir=3D"ltr">
&lt;<a href=3D"mailto:Awais_Belal@mentor.com" target=3D"_blank">Awais_Belal=
@mentor.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
This applies to 1.28 as well and otherwise broken builds are seen where the=
 git tarball from source mirror is outdated.</blockquote>
</div>
<br>
</div>
<div class=3D"gmail_extra">As Awais says, without this applied, if you have=
 an out of date git mirror tarball, you'll get a do_fetch failure, so I thi=
nk we really need this merged.<br>
-- <br>
<div class=3D"gmail_signature">Christopher Larson<br>
clarson at kergoth dot com<br>
Founder - BitBake, OpenEmbedded, OpenZaurus<br>
Maintainer - Tslib<br>
Senior Software Engineer, Mentor Graphics</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_2021B186DC632746BD5A3CE32F12BD280119AB7286EUMBX03mgcmen_--
