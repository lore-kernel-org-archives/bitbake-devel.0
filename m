Return-Path: <benixvincent@yahoo.com>
Received: from nm46-vm6.bullet.mail.bf1.yahoo.com
	(nm46-vm6.bullet.mail.bf1.yahoo.com [216.109.115.109])
	by mail.openembedded.org (Postfix) with ESMTP id A439460886
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Aug 2013 05:20:36 +0000 (UTC)
Received: from [98.139.212.148] by nm46.bullet.mail.bf1.yahoo.com with NNFMP;
	06 Aug 2013 05:20:36 -0000
Received: from [98.139.212.208] by tm5.bullet.mail.bf1.yahoo.com with NNFMP;
	06 Aug 2013 05:20:36 -0000
Received: from [127.0.0.1] by omp1017.mail.bf1.yahoo.com with NNFMP;
	06 Aug 2013 05:20:36 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 454857.67943.bm@omp1017.mail.bf1.yahoo.com
Received: (qmail 51793 invoked by uid 60001); 6 Aug 2013 05:20:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1375766436; bh=n9nLWtCK4ngGpNKdBlgddBVmRVOmHv0gkH26AMWL1ag=;
	h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
	b=wXpXkiYY88m+d7MWj3eBzqKmyd1ZaEnX5NMz3s1WdTqQt7NTZvoZFXGz9fm3fj0Z3sXviEzU/Q2bCP4TCNucwr/eVGS/v5qCmp0/JaqJDMHiN1rzFgu2csvduuGorfqyc2XUInOBHHU5mHy4CW2K/uucns7d8FrQTAC26MECgA4=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=s1024; d=yahoo.com;
	h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
	b=IvZlbxODKyZ5CFbWLp5FlkZ8hyAxtZmUP/ACSqrbgiaYjFIk6ozg0vNpf0fD/xRWCAQvshpGWfRU4csyLVrikxftkRV+dFjmYpk6wbRXrfVkUtCVhaxP3yfTTC3gf5hY4etrihZf3CVO0O0lDvunAjc/0pek9vPdKX7eJhi9DDk=;
X-YMail-OSG: pefAdg0VM1lrYDOT_KJyK1kRcQS9U7yzSny7gvlZ9TSBwsj
	2fOLHyHj9q5a.V3ydpChVodTuvLwP.3VL8fiyhzr_9CiodS3n.i4m400fBg0
	VIYWqOpXqYB4aKmiuVL5dPu8dq.t.mKdYTH8qVVfI8B3GdQQ.OyHFd.X_NTx
	s2BpUAwSsf2I2Zm6hRon__ydBV57Vcby8Nz9MKleEJiS0k8G3oZqHbahSIR3
	7AHIbIlEvUU1UF.x0ArnyxZ46aUZVYxzEhzj46utzH9cY9gzpRPQFpHaHAYl
	XpEfKDc0S5zKqRBNE4M6qDhnKK45CPYsVB0ycn.IQgOAV0XOMNu9rfi.cz.a
	kgCd_XSBpAiy6sZAKHErMTByBcnkqrVis5Bu4PisWvszuId0p1CD.WOZrNZa
	Hh75UczdOHRHbC4X6XQqRRwaD.hcxjoHHBYI0VFF.Ew5olOCQaEokYrfleJP
	27AbtPuyfAd8gcHCESv3a6N90.h3V_I.rkRmgALfsQ9ByTA96G7pb3cOtKNW
	I919hsQT5Qa205w.t3FN80t0JX2gLDd9Fs5grQmz121FgJaS0DAWTCfY41bt
	rmaJ.XvGZrGZksNkkp5G9Kj4SieiXbzP8RxtkYhqQAU2n._.3zz1TX5p5Cuv
	keE3fMtlxPwIctbYOBnm_kQaQJaen6b2vmbAyaV_PyCjF9NW6lvEprw--
Received: from [72.163.217.102] by web162604.mail.bf1.yahoo.com via HTTP;
	Mon, 05 Aug 2013 22:20:35 PDT
X-Rocket-MIMEInfo: 002.001,
	CgpOTyBkaWFnMSAmIGRpYWcyIGFyZW4ndCBwYXJ0IG9mIHBhY2thZ2UgdmFyaWFibGVzLiBIZW5jZSBpdCBkaWRuJ3Qgd29yay4KCkJ1dCB0aGlzIGlzIGEgc2luZ2xlIHBhY2thZ2UsIGFuZCBoYXMgdHdvIGluaXQgc2NyaXB0cy4gT25lIG9wdGlvbiBpcyB0byBjb21iaW5lIHRoZXNlIHR3byBpbml0IHNjcmlwdHMuIEJ1dCBJIGFtIGxvb2tpbmcgaWYgYW55IHBvc3NzaWJpbGl0ecKgCgp0byBsYXVuY2ggdHdvIGluaXQgc2NyaXB0cyBpbiBvbmUgc2luZ2xlIHBhY2thZ2UuCgpCZW5peC4KCgpfX19fX19fX18BMAEBAQE-
X-Mailer: YahooMailWebService/0.8.152.567
References: <1375764715.11349.YahooMailNeo@web162605.mail.bf1.yahoo.com>
	<ADEA8F38-F1BB-427C-8864-440A2B8FA6C7@gmail.com>
Message-ID: <1375766435.51103.YahooMailNeo@web162604.mail.bf1.yahoo.com>
Date: Mon, 5 Aug 2013 22:20:35 -0700 (PDT)
From: Benix Vincent <benixvincent@yahoo.com>
To: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <ADEA8F38-F1BB-427C-8864-440A2B8FA6C7@gmail.com>
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Multiple init script in bitbake file
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
Reply-To: Benix Vincent <benixvincent@yahoo.com>
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 06 Aug 2013 05:20:37 -0000
Content-Type: multipart/alternative;
	boundary="1866672204-994373909-1375766435=:51103"

--1866672204-994373909-1375766435=:51103
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

=0A=0ANO diag1 & diag2 aren't part of package variables. Hence it didn't wo=
rk.=0A=0ABut this is a single package, and has two init scripts. One option=
 is to combine these two init scripts. But I am looking if any posssibility=
=A0=0A=0Ato launch two init scripts in one single package.=0A=0ABenix.=0A=
=0A=0A________________________________=0A From: Khem Raj <raj.khem@gmail.co=
m>=0ATo: Benix Vincent <benixvincent@yahoo.com> =0ACc: "bitbake-devel@lists=
.openembedded.org" <bitbake-devel@lists.openembedded.org> =0ASent: Tuesday,=
 August 6, 2013 10:28 AM=0ASubject: Re: [bitbake-devel] Multiple init scrip=
t in bitbake file=0A =0A=0A=0A=0A=0AOn Aug 5, 2013, at 9:51 PM, Benix Vince=
nt <benixvincent@yahoo.com> wrote:=0A=0A=0A>=0A>=0A>=0A>Hi=0A>=0A>=0A>I nee=
d to launch multiple initscripts (2) for a single package, I tried the foll=
owing;=0A>=0A>=0A>=0A>=0A>INITSCRIPT_NAME =3D "diag.sh"=0A>INITSCRIPT_PARAM=
S =3D "defaults 16"=0A>=0A>=0A>=0A>INITSCRIPT_NAME =3D "drivers-init.sh "=
=0A>INITSCRIPT_PARAMS =3D "defaults 14"=0A>=0A>=0A>=0A>But the second one o=
verwrites the first and I see just one init script in my sandbox.=0A>=0A>=
=0A>then I even tried this=0A>=0A>=0A>=0A>=0A>=0A>INITSCRIPT_NAME_diag1 =3D=
 "diag.sh"=0A>INITSCRIPT_PARAMS_diag1 =3D "defaults 16"=0A>=0A>=0A>=0A>INIT=
SCRIPT_NAME_diag2 =3D "drivers-init.sh "=0A>INITSCRIPT_PARAMS_diag2 =3D "de=
faults 14"=0A>=0A>=0A>=0A>=0A>=0A>even this didn't work.=0A=0A=0Ado you hav=
e diag1 and diag2 in PACKAGES =A0variable ? if not then it won't work. I wo=
uld suggest to add additional=0Apackage to list of PACKAGES the recipe is g=
enerating and then use the above syntax.=0A=0A=0A=0A>=0A>Any help is greatl=
y appreciated.=0A>=0A>=0A>Benix.___________________________________________=
____=0A>bitbake-devel mailing list=0A>bitbake-devel@lists.openembedded.org=
=0A>http://lists.openembedded.org/mailman/listinfo/bitbake-devel=0A>

--1866672204-994373909-1375766435=:51103
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div><span><br></span=
></div><div style=3D"color: rgb(0, 0, 0); font-size: 16px; font-family: 'ti=
mes new roman', 'new york', times, serif; background-color: transparent; fo=
nt-style: normal;">NO diag1 &amp; diag2 aren't part of package variables. H=
ence it didn't work.</div><div style=3D"color: rgb(0, 0, 0); font-size: 16p=
x; font-family: 'times new roman', 'new york', times, serif; background-col=
or: transparent; font-style: normal;"><br></div><div style=3D"color: rgb(0,=
 0, 0); font-size: 16px; font-family: 'times new roman', 'new york', times,=
 serif; background-color: transparent; font-style: normal;"><span>But this =
is a single package, and has two init scripts. One option is to combine the=
se two init scripts. But I am looking if any posssibility&nbsp;</span></div=
><div style=3D"color: rgb(0, 0, 0); font-size: 16px; font-family: 'times ne=
w
 roman', 'new york', times, serif; background-color: transparent; font-styl=
e: normal;"><span><br></span></div><div style=3D"color: rgb(0, 0, 0); font-=
size: 16px; font-family: 'times new roman', 'new york', times, serif; backg=
round-color: transparent; font-style: normal;"><span>to launch two init scr=
ipts in one single package.</span></div><div style=3D"color: rgb(0, 0, 0); =
font-size: 16px; font-family: 'times new roman', 'new york', times, serif; =
background-color: transparent; font-style: normal;"><span><br></span></div>=
<div style=3D"color: rgb(0, 0, 0); font-size: 16px; font-family: 'times new=
 roman', 'new york', times, serif; background-color: transparent; font-styl=
e: normal;"><span>Benix.</span></div><div><br></div>  <div style=3D"font-fa=
mily: 'times new roman', 'new york', times, serif; font-size: 12pt;"> <div =
style=3D"font-family: 'times new roman', 'new york', times, serif; font-siz=
e: 12pt;"> <div dir=3D"ltr"> <hr size=3D"1">  <font size=3D"2" face=3D"Aria=
l">
 <b><span style=3D"font-weight:bold;">From:</span></b> Khem Raj &lt;raj.khe=
m@gmail.com&gt;<br> <b><span style=3D"font-weight: bold;">To:</span></b> Be=
nix Vincent &lt;benixvincent@yahoo.com&gt; <br><b><span style=3D"font-weigh=
t: bold;">Cc:</span></b> "bitbake-devel@lists.openembedded.org" &lt;bitbake=
-devel@lists.openembedded.org&gt; <br> <b><span style=3D"font-weight: bold;=
">Sent:</span></b> Tuesday, August 6, 2013 10:28 AM<br> <b><span style=3D"f=
ont-weight: bold;">Subject:</span></b> Re: [bitbake-devel] Multiple init sc=
ript in bitbake file<br> </font> </div> <div class=3D"y_msg_container"><br>=
=0A<div id=3D"yiv3096805348"><div><br><div><div>On Aug 5, 2013, at 9:51 PM,=
 Benix Vincent &lt;<a rel=3D"nofollow" ymailto=3D"mailto:benixvincent@yahoo=
.com" target=3D"_blank" href=3D"mailto:benixvincent@yahoo.com">benixvincent=
@yahoo.com</a>&gt; wrote:</div><br class=3D"yiv3096805348Apple-interchange-=
newline"><blockquote type=3D"cite"><div><div style=3D"background-color: rgb=
(255, 255, 255); font-family: 'times new roman', 'new york', times, serif; =
font-size: 12pt;"><div style=3D"font-family: 'times new roman', 'new york',=
 times, serif; font-size: 12pt;"><br></div><div style=3D"font-family: 'time=
s new roman', 'new york', times, serif; font-size: 16px; background-color: =
transparent; font-style: normal;"><br></div><div style=3D"font-family: 'tim=
es new roman', 'new york', times, serif; font-size: 16px; background-color:=
 transparent; font-style: normal;">Hi</div><div style=3D"font-family: 'time=
s new roman', 'new york', times, serif; font-size: 16px; background-color: =
transparent;
 font-style: normal;"><br></div><div style=3D"font-family: 'times new roman=
', 'new york', times, serif; font-size: 16px; background-color: transparent=
; font-style: normal;">I need to launch multiple initscripts (2) for a sing=
le package, I tried the=0A following;</div><div style=3D"font-family: 'time=
s new roman', 'new york', times, serif; font-size: 16px; background-color: =
transparent; font-style: normal;"><br></div><div style=3D"background-color:=
transparent;"><font face=3D"times new roman, new york, times, serif"><br></=
font></div><div style=3D"background-color:transparent;"><font face=3D"times=
 new roman, new york, times, serif">INITSCRIPT_NAME =3D "<a target=3D"_blan=
k" href=3D"http://diag.sh/">diag.sh</a>"</font></div><div style=3D"backgrou=
nd-color: transparent; font-size: 16px; font-family: 'times new roman', 'ne=
w york', times, serif; font-style: normal;"><font face=3D"times new roman, =
new york, times, serif"><span style=3D"font-size:16px;">INITSCRIPT_PARAMS =
=3D "defaults 16"</span><br></font></div><div style=3D"background-color: tr=
ansparent; font-size: 16px; font-family: 'times new roman', 'new york', tim=
es, serif; font-style: normal;"><font face=3D"times new roman, new york, ti=
mes, serif"><br></font></div><div
 style=3D"background-color:transparent;"><font face=3D"times new roman, new=
 york, times, serif">INITSCRIPT_NAME =3D "<a target=3D"_blank" href=3D"http=
://drivers-init.sh/">drivers-init.sh</a> "</font></div><div style=3D"backgr=
ound-color: transparent; font-size: 16px; font-family: 'times new roman', '=
new york', times, serif; font-style: normal;"><span style=3D"background-col=
or:transparent;">INITSCRIPT_PARAMS =3D "defaults 14"</span><br></div><div s=
tyle=3D"background-color: transparent; font-size: 16px; font-family: 'times=
 new roman', 'new york', times, serif; font-style: normal;"><font face=3D"t=
imes new roman, new york, times, serif"><br></font></div><div style=3D"back=
ground-color: transparent; font-size: 16px; font-family: 'times new roman',=
 'new york', times, serif; font-style: normal;">But the second one overwrit=
es the first and I see just one init script in my sandbox.</div><div style=
=3D"background-color: transparent; font-size: 16px; font-family: 'times new=
 roman', 'new
 york', times, serif; font-style: normal;"><br></div><div style=3D"backgrou=
nd-color: transparent; font-size: 16px; font-family: 'times new roman', 'ne=
w york', times, serif; font-style: normal;"><span style=3D"font-size:16px;"=
>then I even tried this</span><br></div><div style=3D"background-color: tra=
nsparent; font-size: 16px; font-family: 'times new roman', 'new york', time=
s, serif; font-style: normal;"><span style=3D"font-size:16px;"><br></span><=
/div><div style=3D"background-color:transparent;"><font face=3D"times new r=
oman, new york, times, serif"><br></font></div><div style=3D"background-col=
or:transparent;"><font face=3D"times new roman, new york, times, serif">INI=
TSCRIPT_NAME_diag1 =3D "diag.sh"</font></div><div style=3D"background-color=
: transparent; font-size: 16px; font-family: 'times new roman', 'new york',=
 times, serif; font-style: normal;"><font face=3D"times new roman, new york=
, times, serif"><span style=3D"font-size:16px;">INITSCRIPT_PARAMS_diag1 =3D=
 "defaults
 16"</span><br></font></div><div style=3D"background-color: transparent; fo=
nt-size: 16px; font-family: 'times new roman', 'new york', times, serif; fo=
nt-style: normal;"><font face=3D"times new roman, new york, times, serif"><=
br></font></div><div style=3D"background-color:transparent;"><font face=3D"=
times new roman, new york, times, serif">INITSCRIPT_NAME_diag2 =3D "drivers=
-init.sh "</font></div><div style=3D"background-color:transparent;"><span s=
tyle=3D"font-family: 'times new roman', 'new york', times, serif; backgroun=
d-color: transparent;">INITSCRIPT_PARAMS_diag2 =3D "defaults 14"</span><br>=
</div><div style=3D"background-color: transparent; font-size: 16px; font-fa=
mily: 'Times New Roman'; font-style: normal;"><span style=3D"font-family:'t=
imes=0A new roman', 'new york', times, serif;background-color:transparent;"=
><br></span></div><div style=3D"background-color: transparent; font-size: 1=
6px; font-family: 'times new roman', 'new york', times, serif; font-style: =
normal;"><span style=3D"font-family: 'times new roman', 'new york', times, =
serif; background-color: transparent;"><br></span></div><div style=3D"backg=
round-color: transparent; font-size: 16px; font-family: 'times new roman', =
'new york', times, serif; font-style: normal;"><span style=3D"font-family: =
'times new roman', 'new york', times, serif; background-color: transparent;=
">even this didn't work.</span></div></div></div></blockquote><div><br></di=
v><div><br></div><div>do you have diag1 and diag2 in PACKAGES &nbsp;variabl=
e ? if not then it won't work. I would suggest to add additional</div><div>=
package to list of PACKAGES the recipe is generating and then use the above=
 syntax.</div><div><br></div><br><blockquote type=3D"cite"><div><div
 style=3D"background-color: rgb(255, 255, 255); font-family: 'times new rom=
an', 'new york', times, serif; font-size: 12pt;"><div style=3D"background-c=
olor: transparent; font-size: 16px; font-family: 'times new roman', 'new yo=
rk', times, serif; font-style: normal;"><span style=3D"font-family: 'times =
new roman', 'new york', times, serif; background-color: transparent;"><br><=
/span></div><div style=3D"background-color: transparent; font-size: 16px; f=
ont-family: 'times new roman', 'new york', times, serif; font-style: normal=
;"><span style=3D"font-family: 'times new roman', 'new york', times, serif;=
 background-color: transparent;">Any help is greatly appreciated.</span></d=
iv><div style=3D"background-color: transparent; font-size: 16px; font-famil=
y: 'times new roman', 'new york', times, serif; font-style: normal;"><span =
style=3D"font-family: 'times new roman', 'new york', times, serif; backgrou=
nd-color: transparent;"><br></span></div><div style=3D"background-color:
 transparent; font-size: 16px; font-family: 'times new roman', 'new york', =
times, serif; font-style: normal;"><span style=3D"font-family: 'times new r=
oman', 'new york', times, serif; background-color: transparent;">Benix.</sp=
an></div></div></div>_______________________________________________<br>bit=
bake-devel mailing list<br><a rel=3D"nofollow" ymailto=3D"mailto:bitbake-de=
vel@lists.openembedded.org" target=3D"_blank" href=3D"mailto:bitbake-devel@=
lists.openembedded.org">bitbake-devel@lists.openembedded.org</a><br>http://=
lists.openembedded.org/mailman/listinfo/bitbake-devel<br></blockquote></div=
><br></div></div><br><br></div> </div> </div>  </div></body></html>

--1866672204-994373909-1375766435=:51103--
