Return-Path: <gerard.b@tekmagic.net>
Received: from mail-yw0-f170.google.com (mail-yw0-f170.google.com
	[209.85.161.170])
	by mail.openembedded.org (Postfix) with ESMTP id D13C26014F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 19:29:43 +0000 (UTC)
Received: by mail-yw0-f170.google.com with SMTP id o16so63140989ywd.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tekmagic-net.20150623.gappssmtp.com; s=20150623;
	h=reply-to:from:to:cc:references:in-reply-to:subject:date
	:organization:message-id:mime-version:thread-index:content-language;
	bh=bAgCvjWOyrMIvKHizXaWA9vCVe3UtrgQVfFGqK28DBw=;
	b=Xq0BHfGG46xd/kcHFkOw56VXx/K1k9KKdsbPgoaq1oTgY66baE3ILTKJuvv4OTBm2C
	8byAUWmP6yQeNEJ6QO//WXPwVXHALLOFXX7OVTvLpxs1zEGmKYNPWwdut49kzmHWrIy6
	DoYsHTUUQeeFqAf2+OcHqwzsxqp7c+64sIjP5JAhywCLHp9FkfyA0EkLcPQXMFp4nLsZ
	0bbkix1EE9D8F/zFhNCr0CY2AGe7PrFX71SkKxZaRf5dyDUPzrKWa49ZVg0IXd99d46z
	2rwvzcokX1kI/jKTZnIyvmMmwLDE+rP3IUnVtLq2RsB/hee8SiLbqKQi6uI2ZJjqe3wc
	Lkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:reply-to:from:to:cc:references:in-reply-to
	:subject:date:organization:message-id:mime-version:thread-index
	:content-language;
	bh=bAgCvjWOyrMIvKHizXaWA9vCVe3UtrgQVfFGqK28DBw=;
	b=erCW9IvyrklKa9fLi+xV4zgvTMRifdARXXWbMcKvB9alZbVjkG47Z5JInYpsceGjot
	6/vO10ni+VJ4Rl/6yjQlHv31DwTe+ikgCAZZL3Dp6SaMZqRODTDCy1Y8w/BWaxElq6WJ
	8Fz6iAI37+LL5EUTcDY2zk7el4qV8d+8LuiaONJilzIfNB/YzvaNwiSdT3iMkkwfWcOK
	m3VcuNyJNNbhwrkw/nTLp3IqJZ6mgZ/u9uhqjbTML+TgqdmLakWuvZ3o7UoEVhjwrql6
	sXtQH7qAwR6De4qvyvHSmKH+8m+IwwjaZYKalUshBp4D5IGOKkYQg2q8/kuf1ORKAMl7
	XS5A==
X-Gm-Message-State: ALyK8tLtFk9ZYYw5ZW0fhYxRaWi6qRLx4rU5ybEhdAOw3e4EhwksfZuHjd1aq2lqrbAbSw==
X-Received: by 10.37.37.81 with SMTP id l78mr309537ybl.112.1464031784145;
	Mon, 23 May 2016 12:29:44 -0700 (PDT)
Received: from Win8onMBA (pool-72-78-196-69.phlapa.fios.verizon.net.
	[72.78.196.69]) by smtp.gmail.com with ESMTPSA id
	w185sm20183441ywe.1.2016.05.23.12.29.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 23 May 2016 12:29:42 -0700 (PDT)
Reply-To: <gerard.b@tekmagic.net>
From: "Gerard Bucas" <gerard.b@tekmagic.net>
To: <bitbake-devel@lists.openembedded.org>
References: <03d601d1b528$7bca9b90$735fd2b0$@tekmagic.net>
	<03e401d1b529$3aaa2210$affe6630$@tekmagic.net>
In-Reply-To: <03e401d1b529$3aaa2210$affe6630$@tekmagic.net>
Date: Mon, 23 May 2016 15:29:41 -0400
Organization: TekMagic
Message-ID: <03f101d1b529$74cdb560$5e692020$@tekmagic.net>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQETnGQTInMdIZQuBkIycC+8kkK3LgKNOVTRoS6wJMA=
Cc: 'Denis Carikli' <denis@eukrea.com>,
	'Otavio Salvador' <otavio@ossystems.com.br>,
	=?iso-8859-1?Q?'Eric_B=E9nard'?= <eric@eukrea.com>
Subject: Re: libsoup build error in master (missing gssapi/gssapi.h ?)
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
X-List-Received-Date: Mon, 23 May 2016 19:29:44 -0000
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_03F2_01D1B507.EDBE8660"
Content-Language: en-us

------=_NextPart_000_03F2_01D1B507.EDBE8660
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

=20

I have been trying to build yocto with chromium but keep on getting a
libsoup error that I can=92t seem to resolve.

=20

Looks like: fatal error: gssapi/gssapi.h: No such file or directory

=20

=20

So probably has a missing dependency in libsoup recipe?

=20

Any ideas from anyone on how to resolve this?

=20

x86_64-poky-linux-libtool: compile:  x86_64-poky-linux-gcc -m64 =
-march=3Dcore2

-mtune=3Dcore2 -msse3 -mfpmath=3Dsse

--sysroot=3D/home/gerard/development/minnowMax/yocto/poky/build/tmp/sysro=
ots/g

enericx86-64 -DHAVE_CONFIG_H -I. -I../../libsoup-2.54.1/libsoup -I..

-DG_LOG_DOMAIN=3D\"libsoup\" -DLIBSOUP_COMPILATION
-DLOCALEDIR=3D\"/usr/share/locale\" -I../../libsoup-2.54.1 -I.. -pthread

-I/home/gerard/development/minnowMax/yocto/poky/build/tmp/sysroots/generi=
cx8

6-64/usr/include/glib-2.0

-I/home/gerard/development/minnowMax/yocto/poky/build/tmp/sysroots/generi=
cx8

6-64/usr/lib/glib-2.0/include =
-DGLIB_VERSION_MIN_REQUIRED=3DGLIB_VERSION_2_38

-I/home/gerard/development/minnowMax/yocto/poky/build/tmp/sysroots/generi=
cx8

6-64/usr/include/libxml2 -fvisibility=3Dhidden -O2 -pipe -g
-feliminate-unused-debug-types
-fdebug-prefix-map=3D/home/gerard/development/minnowMax/yocto/poky/build/=
tmp/w

ork/core2-64-poky-linux/libsoup-2.4/2.54.1-r0=3D/usr/src/debug/libsoup-2.=
4/2.5

4.1-r0

-fdebug-prefix-map=3D/home/gerard/development/minnowMax/yocto/poky/build/=
tmp/s

ysroots/x86_64-linux=3D

-fdebug-prefix-map=3D/home/gerard/development/minnowMax/yocto/poky/build/=
tmp/s

ysroots/genericx86-64=3D -Wall -Wstrict-prototypes =
-Werror=3Dmissing-prototypes
-Werror=3Dimplicit-function-declaration -Werror=3Dpointer-arith
-Werror=3Dinit-self -Werror=3Dformat=3D2 -Wno-format-zero-length
-Werror=3Dmissing-include-dirs -Werror=3Daggregate-return
-Werror=3Ddeclaration-after-statement -c
../../libsoup-2.54.1/libsoup/soup-session-feature.c  -fPIC -DPIC -o
.libs/libsoup_2_4_la-soup-session-feature.o

make[3]: Leaving directory

`/home/gerard/development/minnowMax/yocto/poky/build/tmp/work/core2-64-po=
ky-

linux/libsoup-2.4/2.54.1-r0/build/libsoup'

make[2]: *** [all] Error 2

make[2]: Leaving directory

`/home/gerard/development/minnowMax/yocto/poky/build/tmp/work/core2-64-po=
ky-

linux/libsoup-2.4/2.54.1-r0/build/libsoup'

make[1]: *** [all-recursive] Error 1

make[1]: Leaving directory

`/home/gerard/development/minnowMax/yocto/poky/build/tmp/work/core2-64-po=
ky-

linux/libsoup-2.4/2.54.1-r0/build'

make: *** [all] Error 2

WARNING: exit code 1 from a shell command.

ERROR: oe_runmake failed

ERROR: Function failed: do_compile (log file is located at
/home/gerard/development/minnowMax/yocto/poky/build/tmp/work/core2-64-pok=
y-l

inux/libsoup-2.4/2.54.1-r0/temp/log.do_compile.31332)

=20

Thanks!

=20

Gerard

=20


------=_NextPart_000_03F2_01D1B507.EDBE8660
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1"><meta name=3DGenerator content=3D"Microsoft Word =
15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:14.0pt;
	font-family:"Calibri",sans-serif;
	font-weight:bold;}
code
	{mso-style-priority:99;
	font-family:"Courier New";}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;
	font-weight:bold;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;
	font-weight:bold;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:black;
	font-weight:bold;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:black;
	font-weight:bold;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72"><div class=3DWordSection1><p =
class=3DMsoNormal><b><span =
style=3D'font-size:14.0pt'>Hi<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span =
style=3D'font-size:14.0pt'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span style=3D'font-size:14.0pt'>I have been trying =
to build yocto with chromium but keep on getting a libsoup error that I =
can&#8217;t seem to resolve.<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span =
style=3D'font-size:14.0pt'><o:p>&nbsp;</o:p></span></b></p><p =
class=3DMsoNormal><b><span style=3D'font-size:14.0pt'>Looks like: =
</span></b><code><span style=3D'font-size:10.0pt'>fatal error: =
gssapi/gssapi.h: No such file or =
directory<o:p></o:p></span></code></p><p class=3DMsoNormal><code><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></code></p><p =
class=3DMsoNormal><code><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></code></p><p =
class=3DMsoPlainText>So probably has a missing dependency in libsoup =
recipe?<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>Any ideas from anyone on how to resolve =
this?<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>x86_64-poky-linux-libtool: compile:&nbsp; =
x86_64-poky-linux-gcc -m64 -march=3Dcore2<o:p></o:p></span></p><p =
class=3DMsoPlainText><span style=3D'font-weight:normal'>-mtune=3Dcore2 =
-msse3 -mfpmath=3Dsse<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>--sysroot=3D/home/gerard/development/minnowM=
ax/yocto/poky/build/tmp/sysroots/g<o:p></o:p></span></p><p =
class=3DMsoPlainText><span style=3D'font-weight:normal'>enericx86-64 =
-DHAVE_CONFIG_H -I. -I../../libsoup-2.54.1/libsoup =
-I..<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>-DG_LOG_DOMAIN=3D\&quot;libsoup\&quot; =
-DLIBSOUP_COMPILATION -DLOCALEDIR=3D\&quot;/usr/share/locale\&quot; =
-I../../libsoup-2.54.1 -I.. -pthread<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>-I/home/gerard/development/minnowMax/yocto/p=
oky/build/tmp/sysroots/genericx8<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>6-64/usr/include/glib-2.0<o:p></o:p></span><=
/p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>-I/home/gerard/development/minnowMax/yocto/p=
oky/build/tmp/sysroots/genericx8<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>6-64/usr/lib/glib-2.0/include =
-DGLIB_VERSION_MIN_REQUIRED=3DGLIB_VERSION_2_38<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>-I/home/gerard/development/minnowMax/yocto/p=
oky/build/tmp/sysroots/genericx8<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>6-64/usr/include/libxml2 =
-fvisibility=3Dhidden -O2 -pipe -g -feliminate-unused-debug-types =
-fdebug-prefix-map=3D/home/gerard/development/minnowMax/yocto/poky/build/=
tmp/w<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>ork/core2-64-poky-linux/libsoup-2.4/2.54.1-r=
0=3D/usr/src/debug/libsoup-2.4/2.5<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>4.1-r0<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>-fdebug-prefix-map=3D/home/gerard/developmen=
t/minnowMax/yocto/poky/build/tmp/s<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>ysroots/x86_64-linux=3D<o:p></o:p></span></p=
><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>-fdebug-prefix-map=3D/home/gerard/developmen=
t/minnowMax/yocto/poky/build/tmp/s<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>ysroots/genericx86-64=3D -Wall =
-Wstrict-prototypes -Werror=3Dmissing-prototypes =
-Werror=3Dimplicit-function-declaration -Werror=3Dpointer-arith =
-Werror=3Dinit-self -Werror=3Dformat=3D2 -Wno-format-zero-length =
-Werror=3Dmissing-include-dirs -Werror=3Daggregate-return =
-Werror=3Ddeclaration-after-statement -c =
../../libsoup-2.54.1/libsoup/soup-session-feature.c&nbsp; -fPIC -DPIC -o =
.libs/libsoup_2_4_la-soup-session-feature.o<o:p></o:p></span></p><p =
class=3DMsoPlainText><span style=3D'font-weight:normal'>make[3]: Leaving =
directory<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>`/home/gerard/development/minnowMax/yocto/po=
ky/build/tmp/work/core2-64-poky-<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>linux/libsoup-2.4/2.54.1-r0/build/libsoup'<o=
:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>make[2]: *** [all] Error =
2<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>make[2]: Leaving =
directory<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>`/home/gerard/development/minnowMax/yocto/po=
ky/build/tmp/work/core2-64-poky-<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>linux/libsoup-2.4/2.54.1-r0/build/libsoup'<o=
:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>make[1]: *** [all-recursive] Error =
1<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>make[1]: Leaving =
directory<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>`/home/gerard/development/minnowMax/yocto/po=
ky/build/tmp/work/core2-64-poky-<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'font-weight:normal'>linux/libsoup-2.4/2.54.1-r0/build'<o:p></o:p=
></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>make: *** [all] Error =
2<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>WARNING: exit code 1 from a shell =
command.<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>ERROR: oe_runmake =
failed<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>ERROR: Function failed: do_compile (log =
file is located at =
/home/gerard/development/minnowMax/yocto/poky/build/tmp/work/core2-64-pok=
y-l<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-weight:normal'>inux/libsoup-2.4/2.54.1-r0/temp/log.do_compi=
le.31332)<o:p></o:p></span></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>Thanks!<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>Gerard<o:p></o:p></p><p class=3DMsoNormal><b><span =
style=3D'font-size:14.0pt'><o:p>&nbsp;</o:p></span></b></p></div></body><=
/html>

------=_NextPart_000_03F2_01D1B507.EDBE8660--
