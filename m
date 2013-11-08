Return-Path: <peter.kjellerstedt@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id 3E7306D2F5
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Nov 2013 15:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 5D791283F6;
	Fri,  8 Nov 2013 16:51:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SZSohwAqgBn7; Fri,  8 Nov 2013 16:51:16 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id 763DF283E0;
	Fri,  8 Nov 2013 16:51:16 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 5FD33AF4;
	Fri,  8 Nov 2013 16:51:16 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 54CB65C3;
	Fri,  8 Nov 2013 16:51:16 +0100 (CET)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by thoth.se.axis.com (Postfix) with ESMTP id 529353404E;
	Fri,  8 Nov 2013 16:51:16 +0100 (CET)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
	([10.0.5.75]) with mapi; Fri, 8 Nov 2013 16:51:16 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Udayan Bapat <uvbapat@gmail.com>
Date: Fri, 8 Nov 2013 16:51:15 +0100
Thread-Topic: [bitbake-devel] How to strip CFLAGS in the recipe file?
Thread-Index: Ac7cic28m0wdB/dKTQOjVPPkou/4NwAEBleA
Message-ID: <A612847CFE53224C91B23E3A5B48BAC7A40ECEF7A1@xmail3.se.axis.com>
References: <CAJ7NSKp95ngb9yPLNr39eZ7TV7w+BCZrXeSq0-LqfCTk=WE0EA@mail.gmail.com>
In-Reply-To: <CAJ7NSKp95ngb9yPLNr39eZ7TV7w+BCZrXeSq0-LqfCTk=WE0EA@mail.gmail.com>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: How to strip CFLAGS in the recipe file?
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
X-List-Received-Date: Fri, 08 Nov 2013 15:51:20 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_A612847CFE53224C91B23E3A5B48BAC7A40ECEF7A1xmail3seaxisc_"

--_000_A612847CFE53224C91B23E3A5B48BAC7A40ECEF7A1xmail3seaxisc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

You may want to take a look at "meta/conf/distro/include/security_flags.inc=
". I think it does what you are looking for

//Peter

From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Udayan Bapat
Sent: den 8 november 2013 14:53
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] How to strip CFLAGS in the recipe file?

Hi all,

I have a Yocto build environment where I intend to build all recipes with -=
fPIE flag. So I have added CFLAGS_append +=3D '-fPIE' in the local.conf. Ho=
wever since shared libraries can not be built using -fPIE flag, I would lik=
e to remove it from some recipes.

So far I have tried this in .bb files -

CFLAGS_noPIE =3D "${@'${CFLAGS}'.replace('-fPIE','')}<mailto:$%7b@'$%7bCFLA=
GS%7d'.replace('-fPIE','')%7d>"

do_compile_prepend () {
    CFLAGS =3D "${CFLAGS_noPIE}"
}
This throws an error -

*/zlib-native/1.2.8-r0/temp/run.do_compile.23159: line 82: CFLAGS: command =
not found
I also have tried -

CFLAGS =3D "${@'${CFLAGS}'.replace('-
fPIE','')}"
This doesn't work because same variable can not be referenced twice.
Then I tried this -

CFLAGS_noPIE =3D "${@'${CFLAGS}'.replace('-fPIE','')}<mailto:$%7b@'$%7bCFLA=
GS%7d'.replace('-fPIE','')%7d>"
CFLAGS =3D "${CFLAGS_noPIE}"

This fails with an error "maximum recursion depth exceeded for variable 'CF=
LAGS'"
What is the correct way to doing this?

Thanks

--_000_A612847CFE53224C91B23E3A5B48BAC7A40ECEF7A1xmail3seaxisc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#943634;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span style=3D'f=
ont-size:11.0pt;font-family:"Calibri","sans-serif";color:#943634'>You may w=
ant to take a look at &#8220;meta/conf/distro/include/security_flags.inc&#8=
221;. I think it does what you are looking for<o:p></o:p></span></p><p clas=
s=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri","sans-s=
erif";color:#943634'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span=
 style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#943634=
'>//Peter<o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-siz=
e:11.0pt;font-family:"Calibri","sans-serif";color:#943634'><o:p>&nbsp;</o:p=
></span></p><div style=3D'border:none;border-left:solid blue 1.5pt;padding:=
0cm 0cm 0cm 4.0pt'><div><div style=3D'border:none;border-top:solid #B5C4DF =
1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><b><span style=3D'fon=
t-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span></b><span styl=
e=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> bitbake-devel-bou=
nces@lists.openembedded.org [mailto:bitbake-devel-bounces@lists.openembedde=
d.org] <b>On Behalf Of </b>Udayan Bapat<br><b>Sent:</b> den 8 november 2013=
 14:53<br><b>To:</b> bitbake-devel@lists.openembedded.org<br><b>Subject:</b=
> [bitbake-devel] How to strip CFLAGS in the recipe file?<o:p></o:p></span>=
</p></div></div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><div><div><p=
 class=3DMsoNormal style=3D'margin-bottom:12.0pt'>Hi all,<br><br>I have a Y=
octo build environment where I intend to build all recipes with -fPIE flag.=
 So I have added CFLAGS_append +=3D '-fPIE' in the local.conf. However sinc=
e shared libraries can not be built using -fPIE flag, I would like to remov=
e it from some recipes.<br><br>So far I have tried this in .bb files - <br>=
<br>CFLAGS_noPIE =3D &quot;<a href=3D"mailto:$%7b@'$%7bCFLAGS%7d'.replace('=
-fPIE','')%7d">${@'${CFLAGS}'.replace('-fPIE','')}</a>&quot;<br><br>do_comp=
ile_prepend () {<br>&nbsp;&nbsp;&nbsp; CFLAGS =3D &quot;${CFLAGS_noPIE}&quo=
t;<br>}<o:p></o:p></p></div><p class=3DMsoNormal style=3D'margin-bottom:12.=
0pt'>This throws an error - <br><br>*/zlib-native/1.2.8-r0/temp/run.do_comp=
ile.23159: line 82: CFLAGS: command not found<o:p></o:p></p></div><p class=
=3DMsoNormal>I also have tried - <br><br>CFLAGS =3D &quot;${@'${CFLAGS}'.re=
place('-<o:p></o:p></p><div><p class=3DMsoNormal style=3D'margin-bottom:12.=
0pt'>fPIE','')}&quot;<o:p></o:p></p><div><div><p class=3DMsoNormal style=3D=
'margin-bottom:12.0pt'>This doesn't work because same variable can not be r=
eferenced twice.<o:p></o:p></p></div><div><p class=3DMsoNormal>Then I tried=
 this - <br><br>CFLAGS_noPIE =3D &quot;<a href=3D"mailto:$%7b@'$%7bCFLAGS%7=
d'.replace('-fPIE','')%7d">${@'${CFLAGS}'.replace('-fPIE','')}</a>&quot;<o:=
p></o:p></p></div><div><p class=3DMsoNormal>CFLAGS =3D &quot;${CFLAGS_noPIE=
}&quot; <o:p></o:p></p></div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p=
></div><div><p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>This fails =
with an error &quot;maximum recursion depth exceeded for variable 'CFLAGS'&=
quot;<o:p></o:p></p></div><div><p class=3DMsoNormal>What is the correct way=
 to doing this?<br><br>Thanks<o:p></o:p></p></div></div></div></div></div><=
/div></body></html>=

--_000_A612847CFE53224C91B23E3A5B48BAC7A40ECEF7A1xmail3seaxisc_--
