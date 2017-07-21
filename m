Return-Path: <t_dufff@yahoo.ca>
Received: from sonic302-6.consmr.mail.bf2.yahoo.com
	(sonic302-6.consmr.mail.bf2.yahoo.com [74.6.135.45])
	by mail.openembedded.org (Postfix) with ESMTP id AC30E77B95
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jul 2017 19:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048;
	t=1500664509; bh=HZfx5QL4Wy4jV6RJuCo6+mZ96h8VCCmr8cQDpp4ugO0=;
	h=Date:From:Reply-To:To:In-Reply-To:References:Subject:From:Subject;
	b=BRRJxbEi9siwr8hpLeeDMn5EA2IdDQDIHJbGuQFuEaVXo7cDRYZTynYbkjHUKkcBwu4M1Y+fB2/8lAivYtPnru10e/j289KhZf4I2kyWqBh3qxjvoMm68X1qISM20xlDFxMf3z5cc+rOsJhvsmlH6MqQGrHpc+zwoWhQiAx1DzfessxjSaXIC0ZrBMGFxCjhZB6ut+MOAJQ8EIXuhMT7jD/P9aVR/rpLfWF0DVoCyhrfWs4TcRYkJi6MqpqCozQxEqzG0tEP82sTIEbEq33mxl4498x9fWeiYElppxaeaZaJuUzLu+rcTumQCHevmQPzlJ1b/5f8FzrpYNdv/MTn7Q==
X-YMail-OSG: Hy6vxK4VM1mYYA8ZfbAHT_IoVb5Lx6PpVhYMQKWtvDzVirq7jVd1IzemuxbGq8C
	isuva0cpmBONn1hCC7UEH9yQWTgz9K_XH15uHrIzv4DMWcuzILdTib76qsitLIfuakxdZkhjkcHF
	5nF8TyJMVpH7j2WJAvYEmdMB7lfP8vs5rT9QI_nCbsvEu5NzHSucY7um.SMVVKIfsTCAf6Yyw29o
	uPJePYVSQUyTiePZapcKAAEUQvYLJNu9KkfcIy8PttejbHPLf1HnUiFmS_1pAZAYdU45sNgd_dL3
	J0eoTxR9ypjuGW84MsSLtdDTDATi_f7R.QmLOH1nfywAokxlZmQIzYCOyuX1yU08INea41x2.B2U
	j2TrTHyChSPJhnjctcZ3QCqavIcoqLFSwdPEZzwDfbpf9k8hH48l_lfCCV.PYUVlIagW8_BHg1fj
	f4L2WpW4g0rAriDuh64MhobkwrMmax8vbhArs6YzZzjwxK5yYaSMTiKaJxdTAYYVmBntOkLh4mQY
	ni__IpYDyrW.5Y3bAbA--
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic302.consmr.mail.bf2.yahoo.com with HTTP;
	Fri, 21 Jul 2017 19:15:09 +0000
Date: Fri, 21 Jul 2017 19:15:09 +0000 (UTC)
From: kris duff <t_dufff@yahoo.ca>
Reply-To: kris duff <t_dufff@yahoo.ca>
To: Viditha Murahari <viditha@mpconsultants.org>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Message-ID: <1750627692.2260284.1500664509314@mail.yahoo.com>
In-Reply-To: <CAGCkR7pSFetC-P4unXU_nyGG9pQj8WrEWUQvwmewQe2aKWdZtQ@mail.gmail.com>
References: <CAGCkR7pSFetC-P4unXU_nyGG9pQj8WrEWUQvwmewQe2aKWdZtQ@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: WebService/1.1.10121 YahooMailNeo Mozilla/5.0 (Windows NT 6.1; Win64;
	x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115
	Safari/537.36
Subject: Re: need help to write a recipe to link a static	library to my application
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
X-List-Received-Date: Fri, 21 Jul 2017 19:15:08 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_2260283_1997861256.1500664509312"

------=_Part_2260283_1997861256.1500664509312
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Maybe it will not help you, but I would suggest you to use a complete devel=
opment package.
I mean, you should use autotools or cmake to build your application locally=
, then package your source and inherit autotools or cmake. It will be easie=
r for you to make things happend.
Hope this helps.
Kris=20

    On Friday, July 21, 2017 3:11 PM, Viditha Murahari <viditha@mpconsultan=
ts.org> wrote:
=20

 I'm new to yocto and bitbake and I'm building a voip application for a cus=
tom imx6 board. I want to use =C2=A0pjsip libraries to build my application=
, I have compiled pjsip in my yocto build and generated pjsip libraries ( a=
ll pjsip libraries r static). I'm having issues building a recipe for my ap=
plication that calls the pjsip functions. Below is how my recipe looks=C2=
=A0

Filename: rttapp.bb
DESCRIPTION =3D "Simple voip application"SECTION =3D "examples"LICENSE =3D =
"MIT"LIC_FILES_CHKSUM =3D"file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ade698=
e0bcf8506ecda2f7b4f302"PR =3D "r1"
SRC_URI +=3D "file://rttapp.c"SRC_URI +=3D "file://include"SRC_URI +=3D "fi=
le://lib"
S =3D "${WORKDIR}"
CFLAGS_prepend +=3D "-I${WORKDIR}/include -DPJ_AUTOCONF=3D1 -DPJ_IS_BIG_END=
IAN=3D0 -DPJ_IS_LITTLE_ENDIAN=3D1"LDFLAGS_append +=3D "-L${WORKDIR}/lib -lp=
jsua2-arm-poky-linux-gnueabi -lstdc++ -lpjsua-arm-poky-linux-gnueabi -lm -l=
rt -lpthread -lasound"
do_compile() {${CC} ${CFLAGS} ${LDFLAGS} rttapp.c -o rttapp}



When i do bitbake rttapp, the error i see is as below

Log data follows:DEBUG: Executing shell function do_compile/tmp/cc6nn4Dp.o:=
 In function `main':/usr/src/debug/rttapp/1.0-r1/rttapp.c:159: undefined re=
ference to `pjsua_create'collect2: error: ld returned 1 exit statusWARNING:=
 exit code 1 from a shell command.

Please advise--=20
_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel


  =20

------=_Part_2260283_1997861256.1500664509312
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font=
-size:16px"><div id=3D"yui_3_16_0_ym19_1_1500662595016_32357" dir=3D"ltr">M=
aybe it will not help you, but I would suggest you to use a complete develo=
pment package.</div><div id=3D"yui_3_16_0_ym19_1_1500662595016_32357" dir=
=3D"ltr"><br></div><div id=3D"yui_3_16_0_ym19_1_1500662595016_32357" dir=3D=
"ltr">I mean, you should use autotools or cmake to build your application l=
ocally, then package your source and inherit autotools or cmake. It will be=
 easier for you to make things happend.</div><div id=3D"yui_3_16_0_ym19_1_1=
500662595016_32357" dir=3D"ltr"><br></div><div id=3D"yui_3_16_0_ym19_1_1500=
662595016_32357" dir=3D"ltr">Hope this helps.</div><div id=3D"yui_3_16_0_ym=
19_1_1500662595016_32357" dir=3D"ltr"><br></div><div id=3D"yui_3_16_0_ym19_=
1_1500662595016_32357" dir=3D"ltr">Kris</div> <div class=3D"qtdSeparateBR">=
<br><br></div><div class=3D"yahoo_quoted" style=3D"display: block;"> <div s=
tyle=3D"font-family: Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-=
serif; font-size: 16px;"> <div style=3D"font-family: HelveticaNeue, Helveti=
ca Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;"> <d=
iv dir=3D"ltr"><font size=3D"2" face=3D"Arial"> On Friday, July 21, 2017 3:=
11 PM, Viditha Murahari &lt;viditha@mpconsultants.org&gt; wrote:<br></font>=
</div>  <br><br> <div class=3D"y_msg_container"><div id=3D"yiv8974911077"><=
div dir=3D"ltr"><div>I'm new to yocto and bitbake and I'm building a voip a=
pplication for a custom imx6 board. I want to use &nbsp;pjsip libraries to =
build my application, I have compiled pjsip in my yocto build and generated=
 pjsip libraries ( all pjsip libraries r static). I'm having issues buildin=
g a recipe for my application that calls the pjsip functions. Below is how =
my recipe looks&nbsp;</div><div><br></div><div><br></div><div>Filename: <a =
rel=3D"nofollow" target=3D"_blank" href=3D"http://rttapp.bb/">rttapp.bb</a>=
</div><div><br></div><div>DESCRIPTION =3D "Simple voip application"</div><d=
iv>SECTION =3D "examples"</div><div>LICENSE =3D "MIT"</div><div>LIC_FILES_C=
HKSUM =3D"file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ade698e0bcf8506ecda2f7=
b4f302"</div><div>PR =3D "r1"</div><div><br></div><div>SRC_URI +=3D "file:/=
/rttapp.c"</div><div>SRC_URI +=3D "file://include"</div><div>SRC_URI +=3D "=
file://lib"</div><div><br></div><div>S =3D "${WORKDIR}"</div><div><br></div=
><div>CFLAGS_prepend +=3D "-I${WORKDIR}/include -DPJ_AUTOCONF=3D1 -DPJ_IS_B=
IG_ENDIAN=3D0 -DPJ_IS_LITTLE_ENDIAN=3D1"</div><div>LDFLAGS_append +=3D "-L$=
{WORKDIR}/lib -lpjsua2-arm-poky-linux-gnueabi -lstdc++ -lpjsua-arm-poky-lin=
ux-gnueabi -lm -lrt -lpthread -lasound"</div><div><br></div><div>do_compile=
() {</div><div>${CC} ${CFLAGS} ${LDFLAGS} rttapp.c -o rttapp</div><div>}</d=
iv><div><br></div><div><br></div><div><br></div><div><br></div><div>When i =
do bitbake rttapp, the error i see is as below</div><div><br></div><div><br=
></div><div>Log data follows:</div><div>DEBUG: Executing shell function do_=
compile</div><div>/tmp/cc6nn4Dp.o: In function `main':</div><div>/usr/src/d=
ebug/rttapp/1.0-r1/rttapp.c:159: undefined reference to `pjsua_create'</div=
><div>collect2: error: ld returned 1 exit status</div><div>WARNING: exit co=
de 1 from a shell command.</div><div><br></div><div><br></div><div>Please a=
dvise</div></div></div>-- <br>_____________________________________________=
__<br>bitbake-devel mailing list<br><a ymailto=3D"mailto:bitbake-devel@list=
s.openembedded.org" href=3D"mailto:bitbake-devel@lists.openembedded.org">bi=
tbake-devel@lists.openembedded.org</a><br><a href=3D"http://lists.openembed=
ded.org/mailman/listinfo/bitbake-devel" target=3D"_blank">http://lists.open=
embedded.org/mailman/listinfo/bitbake-devel</a><br><br><br></div>  </div> <=
/div>  </div></div></body></html>

------=_Part_2260283_1997861256.1500664509312--
