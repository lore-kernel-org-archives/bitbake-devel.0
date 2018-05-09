Return-Path: <kumar.ugesh003@yahoo.com>
Received: from sonic307-5.consmr.mail.sg3.yahoo.com
	(sonic307-5.consmr.mail.sg3.yahoo.com [106.10.241.182])
	by mail.openembedded.org (Postfix) with ESMTP id 35F0474B5F
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 May 2018 02:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1525832540; bh=ECZWOuDC7D8OMm+P7KYlmtJ5cXJCuZ7DmQAbHEKqH34=;
	h=Date:From:To:Subject:References:From:Subject;
	b=qdBZ2/5/A7UlXhHpG0Yb/FNA/vGBUSIAoh44fObaJsteykTRZfFlkSa09DxaHk+yszu0qQIyUNSHbej4+YFjEn1GKhzJ2AVJ1BT9BtnAdSKMusMMP5QdBichtJzVuI/0DZuOArD0W7wTrLFpy4zDFdxzU9TgM7fb7NfA4lWQZdL2vrfQjagOo22iNOjzVzhXYnAUt8cNT9uFbyUyQDa5YUGohu8yrl3oWAmWpGeaY4TUpaID3PhuHpl2iA2kvsIjIwCDKR5nGOGK7Um+3HGVj8RG4m588VaFggEo6Q3xOUnkDfPN+drmivwvn15M1JJNyyzWPiBxtRiesxFOMy5C6A==
X-YMail-OSG: U8zWzj4VM1n.PT627bmaPSwL8x4GTde3w45VrPWxTCQXW_flya.VxJdCX.lOtWX
	dO43Qbpe5Ptjqk91ThEoyakYZTYV9dm6oIt0ckmold2dk6OHr9myq.QwhX3yHtdGOcWYVppq92y4
	J4W0iFR1.7SIPHzhg6_3YmX73l1o9vNFLAPd1eJd_2SE9jMlfUbcUShQrwr53qxlf6lXHr1FB3au
	aRXq4m1SoclswH7x5TtgtB5Uk_u9XnGbnii55p5BBEhMSyAap54FQaf.czwqWmBum4vA17tEgBzt
	9QJZ.g3MQcw5vrzEgKfCFuR5TBeLP6MQ.jZRHTqYhCWihWbPjk_MwIjzBd2MyVVVE948i0nlO_2H
	NXorYyXeOnboAiRYnRISjQSFk1a7OjjCmh3Tsh26N.3v27EnjuX2iwAd3AIsDVooLzIwz5YuN1Bg
	up528FNn0JtP30PDEbVsy8s4C2qa54a1gh85tRBA9Nn525I393mFvjrW2ql5QcJFvWOIBRfEJ7c3
	y7GczafMiFm4Y2YnYarrw_HlPJIZMVov_ztxOXl35DkW03LCVVxdysrLaDh6.YQEIO4uLp5_7QPd
	z.JUg5RAnxP3fFSkhWGlBwqHtV3cMgVjN_TjipR11w5v8n1P7M78SdH_U6HhjX_r3T2lZ4Htw1BP
	L8pHd9fa.
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic307.consmr.mail.sg3.yahoo.com with HTTP;
	Wed, 9 May 2018 02:22:20 +0000
Date: Wed, 9 May 2018 02:18:20 +0000 (UTC)
From: Ugesh Reddy <kumar.ugesh003@yahoo.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Message-ID: <1184471455.1381374.1525832300014@mail.yahoo.com>
MIME-Version: 1.0
References: <1184471455.1381374.1525832300014.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.11848 YMailNorrin Mozilla/5.0 (X11;
	Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu
	Chromium/64.0.3282.167 Chrome/64.0.3282.167 Safari/537.36
Subject: .bb script file for auto tools
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
X-List-Received-Date: Wed, 09 May 2018 02:22:21 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_1381373_1446077222.1525832300012"

------=_Part_1381373_1446077222.1525832300012
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello All,
=C2=A0I am new to bitbake and having the basic understanding on bitbake. My=
 project uses auto tools and it has Makefile.am and configure.ac when it ru=
ns with autogen.sh it could able to generate Makefile and configure with ge=
nerated files the bin program is generated. I would like to do the same wit=
h bitbake. The below are the structure
=C2=A0 =C2=A0As mentioned in the below linkhttps://github.com/DynamicDevice=
s/bbexample

When it executed like below it works fine=C2=A0$ cd bbexample=C2=A0$ ./auto=
gen.sh=C2=A0$ ./configure=C2=A0$ make
How can i write the .bb file for the same ?
Regards,Ugesh



=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=C2=A0 =C2=A0
| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |


------=_Part_1381373_1446077222.1525832300012
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:Helvetica Neue, Helvetic=
a, Arial, sans-serif;font-size:16px;"><div style=3D"font-family:Helvetica N=
eue, Helvetica, Arial, sans-serif;font-size:16px;"><div id=3D"ydp388441fayi=
v6951807158"><div style=3D"font-family:Helvetica Neue, Helvetica, Arial, sa=
ns-serif;font-size:16px;"><div>Hello All,</div><div><br></div><div>&nbsp;I =
am new to bitbake and having the basic understanding on bitbake. My project=
 uses auto tools and it has Makefile.am and configure.ac when it runs with =
autogen.sh it could able to generate Makefile and configure with generated =
files the bin program is generated. I would like to do the same with bitbak=
e. The below are the structure</div><div><br></div><div>&nbsp; &nbsp;As men=
tioned in the below link</div><div><a href=3D"https://github.com/DynamicDev=
ices/bbexample" rel=3D"nofollow" target=3D"_blank">https://github.com/Dynam=
icDevices/bbexample</a><br></div><div><br></div><div>When it executed like =
below it works fine</div><div><span><div>&nbsp;$ cd bbexample</div><div>&nb=
sp;$ ./autogen.sh</div><div>&nbsp;$ ./configure</div><div>&nbsp;$ make</div=
></span><br></div><div>How can i write the .bb file for the same ?</div><di=
v><br></div><div>Regards,</div><div>Ugesh</div><div><br></div><div><br></di=
v><div><br></div><div><br></div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div><div>&nbsp; &nbsp;</div><div>=
<table class=3D"ydp9ae10bc2highlight ydp9ae10bc2tab-size ydp9ae10bc2js-file=
-line-container" data-tab-size=3D"8" style=3D"border-collapse: collapse; co=
lor: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot=
;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot=
;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 14px=
;"><tbody><tr><td id=3D"ydp9ae10bc2LC1" class=3D"ydp9ae10bc2blob-code ydp9a=
e10bc2blob-code-inner ydp9ae10bc2js-file-line" style=3D"padding: 0px 10px; =
position: relative; line-height: 20px; vertical-align: top; font-family: SF=
Mono-Regular, Consolas, &quot;Liberation Mono&quot;, Menlo, Courier, monosp=
ace; font-size: 12px; word-wrap: normal; white-space: pre-wrap;">&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr></tbody><=
/table></div></div></div></div></div></body></html>

------=_Part_1381373_1446077222.1525832300012--
