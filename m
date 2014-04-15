Return-Path: <cwyse@accu-time.com>
Received: from p01c12o147.mxlogic.net (p01c12o147.mxlogic.net [208.65.145.70])
	by mail.openembedded.org (Postfix) with ESMTP id DC0A465D26
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Apr 2014 14:48:02 +0000 (UTC)
Received: from unknown [74.93.19.236] (EHLO remote.accu-time.com)
	by p01c12o147.mxlogic.net(mxl_mta-8.0.0-0) over TLS secured channel
	with ESMTP id 3a64d435.0.4350.00-286.10903.p01c12o147.mxlogic.net
	(envelope-from <cwyse@accu-time.com>); 
	Tue, 15 Apr 2014 08:48:05 -0600 (MDT)
X-MXL-Hash: 534d46a54c95f962-50f775d2a8f969fdb8b60488d19dd7b75a072dec
Received: from ATSSBS2K11.Accu-Time.com ([fe80::c23c:3931:8fc9:d09d]) by
	ATSSBS2K11.Accu-Time.com ([fe80::c23c:3931:8fc9:d09d%10]) with mapi id
	14.02.0347.000; Tue, 15 Apr 2014 10:48:00 -0400
From: Christopher Wyse <CWyse@accu-time.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: AUTOREV with different branches
Thread-Index: Ac9Yty/CPS5itLvIQQC1BUuzo7EbQg==
Date: Tue, 15 Apr 2014 14:48:00 +0000
Message-ID: <4749E398ABC0754A82239442E1B13E2A6144EFD7@ATSSBS2K11.Accu-Time.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.128.60]
MIME-Version: 1.0
X-AnalysisOut: [v=2.1 cv=HKBNF+dv c=1 sm=1 tr=0 a=ldurMiKFbe+WqYbqJ3PAJA==]
X-AnalysisOut: [:17 a=yzjlov4BZPsA:10 a=N93ZDV0pFrUA:10 a=BLceEmwcHowA:10 ]
X-AnalysisOut: [a=xqWC_Br6kY4A:10 a=JBIHeZSVAAAA:8 a=YlVTAMxIAAAA:8 a=eDER]
X-AnalysisOut: [ruLW_4S1TGUey9UA:9 a=mWb3HSBWkm8BpRh4:21 a=vz5XwSlSslms9UH]
X-AnalysisOut: [9:21 a=wPNLvfGTeEIA:10 a=A_btSNidd94A:10 a=OGO7Si5IzrYA:10]
X-AnalysisOut: [ a=Kdci8UhDXtSSQdVfF9QA:9 a=LXfEzenyQU7wD12r:21 a=aJR-uA-r]
X-AnalysisOut: [3Zuva3f0:21 a=D1ct4Z-GsM04hFnz:21 a=_W_S_7VecoQA:10 a=frz4]
X-AnalysisOut: [AuCg-hUA:10 a=tXsnliwV7b4A:10]
X-Spam: [F=0.5000000000; CM=0.500; MH=0.500(2014041512); S=0.200(2010122901)]
X-MAIL-FROM: <cwyse@accu-time.com>
X-SOURCE-IP: [74.93.19.236]
Subject: AUTOREV with different branches
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
X-List-Received-Date: Tue, 15 Apr 2014 14:48:04 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_4749E398ABC0754A82239442E1B13E2A6144EFD7ATSSBS2K11AccuT_"

--_000_4749E398ABC0754A82239442E1B13E2A6144EFD7ATSSBS2K11AccuT_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I'd like to auto-increment my package revision.  I have 'SRCREV =3D "${AUTO=
REV}" ', and 'PR_append =3D "+gitr${SRCPV}" ' set.  This is working fine as=
 long as I stay on a single branch.  However, my SRC_URI has the branch par=
ameter set to branch=3D${BRANCH}, and BRANCH is set in the environment prio=
r to calling bitbake.  This has resulted in the following issue.

On the develop branch, my package name is:

setup-utility_0.90-r24+gitr9+537d03f5ed3a78caa8148448c8c92053be99010d_armv7=
a-vfp-neon.ipk

and on the release branch:

setup-utility_0.90-r24+gitr1+db553099700f4b6a5e2db0475957700afe6cbcab_armv7=
a-vfp-neon.ipk

The release branch had been built most recently.  I want opkg to use the la=
test package regardless of which branch it was built on, but in this case o=
pkg will use the develop build.

I'm not sure how to correct this.  I see references to LOCALCOUNT and AUTOI=
NC, and it seems like other people have had similar issues, but after revie=
wing them I'm still not sure of the best solution.

Here's a the relevant snippets from my recipe:

   SRC_URI =3D "git://gitolite@....com/universal/SetupUtility.git;protocol=
=3Dssh;branch=3D${BRANCH}"
   PV =3D "0.90"

   SRCREV =3D "${AUTOREV}"

   # Package Revision, Update this whenever you change the recipe.
   PR =3D "r24"
   PR_append =3D "+gitr${SRCPV}"

If anyone could provide any help/suggestions, I would really appreciate it.

Christopher J. Wyse
Embedded Software Engineer
Accu-Time Systems
420 Somers Road
Ellington, CT  06029

Phone number:  860-375-2006

www.accu-time.com<http://www.accu-time.com/>

[ATS_logo_signature]

--_000_4749E398ABC0754A82239442E1B13E2A6144EFD7ATSSBS2K11AccuT_
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
10pt;">Hi,<br>
<br>
I'd like to auto-increment my package revision.&nbsp; I have 'SRCREV =3D &q=
uot;${AUTOREV}&quot; ', and 'PR_append =3D &quot;&#43;gitr${SRCPV}&quot; ' =
set.&nbsp; This is working fine as long as I stay on a single branch.&nbsp;=
 However, my SRC_URI has the branch parameter set to branch=3D${BRANCH}, an=
d
 BRANCH is set in the environment prior to calling bitbake.&nbsp; This has =
resulted in the following issue.<br>
<br>
On the develop branch, my package name is:<br>
<br>
setup-utility_0.90-r24&#43;gitr9&#43;537d03f5ed3a78caa8148448c8c92053be9901=
0d_armv7a-vfp-neon.ipk<br>
<br>
and on the release branch:<br>
<br>
setup-utility_0.90-r24&#43;gitr1&#43;db553099700f4b6a5e2db0475957700afe6cbc=
ab_armv7a-vfp-neon.ipk<br>
<br>
The release branch had been built most recently.&nbsp; I want opkg to use t=
he latest package regardless of which branch it was built on, but in this c=
ase opkg will use the develop build.<br>
<br>
I'm not sure how to correct this.&nbsp; I see references to LOCALCOUNT and =
AUTOINC, and it seems like other people have had similar issues, but after =
reviewing them I'm still not sure of the best solution.<br>
<br>
Here's a the relevant snippets from my recipe:<br>
<br>
&nbsp;&nbsp; SRC_URI =3D &quot;git://gitolite@....com/universal/SetupUtilit=
y.git;protocol=3Dssh;branch=3D${BRANCH}&quot;<br>
&nbsp;&nbsp; PV =3D &quot;0.90&quot;<br>
<br>
&nbsp;&nbsp; SRCREV =3D &quot;${AUTOREV}&quot;<br>
<br>
&nbsp;&nbsp; # Package Revision, Update this whenever you change the recipe=
. <br>
&nbsp;&nbsp; PR =3D &quot;r24&quot;<br>
&nbsp;&nbsp; PR_append =3D &quot;&#43;gitr${SRCPV}&quot;<br>
<br>
If anyone could provide any help/suggestions, I would really appreciate it.=
<br>
<div><br>
<div style=3D"font-family:Tahoma; font-size:13px"><span lang=3D"en-US">
<div style=3D"margin:0"><font face=3D"Calibri,sans-serif" size=3D"2"><span =
style=3D"font-size:11pt"><font face=3D"Arial Narrow,sans-serif" size=3D"3">=
<span style=3D"font-size:12pt">Christopher J. Wyse<br>
</span></font></span></font></div>
<div style=3D"margin:0"><font face=3D"Calibri,sans-serif" size=3D"2"><span =
style=3D"font-size:11pt"><font face=3D"Arial Narrow,sans-serif" size=3D"3">=
<span style=3D"font-size:12pt">Embedded Software Engineer<br>
</span></font></span></font></div>
<div style=3D"margin:0"><font face=3D"Calibri,sans-serif" size=3D"2"><span =
style=3D"font-size:11pt"><font face=3D"Arial Narrow,sans-serif" size=3D"3">=
<span style=3D"font-size:12pt">Accu-Time Systems</span></font></span></font=
></div>
<div style=3D"margin:0"><font face=3D"Calibri,sans-serif" size=3D"2"><span =
style=3D"font-size:11pt"><font face=3D"Arial Narrow,sans-serif" size=3D"3">=
<span style=3D"font-size:12pt">420 Somers Road</span></font></span></font><=
/div>
<div style=3D"margin:0"><font face=3D"Calibri,sans-serif" size=3D"2"><span =
style=3D"font-size:11pt"><font face=3D"Arial Narrow,sans-serif" size=3D"3">=
<span style=3D"font-size:12pt">Ellington, CT&nbsp; 06029</span></font></spa=
n></font></div>
<div style=3D"margin:0"><font face=3D"Calibri,sans-serif" size=3D"2"><span =
style=3D"font-size:11pt"><font face=3D"Times New Roman,serif" size=3D"3"><s=
pan style=3D"font-size:12pt">&nbsp;</span></font></span></font></div>
<div style=3D"margin:0"><font face=3D"Calibri,sans-serif" size=3D"2"><span =
style=3D"font-size:11pt"><font face=3D"Arial Narrow,sans-serif" size=3D"3">=
<span style=3D"font-size:12pt">Phone&nbsp;number:&nbsp; 860-375-2006</span>=
</font></span></font></div>
<div style=3D"margin:0"><font face=3D"Calibri,sans-serif" size=3D"2"><span =
style=3D"font-size:11pt"><font face=3D"Arial Narrow,sans-serif" size=3D"3">=
<span style=3D"font-size:12pt">&nbsp;</span></font></span></font></div>
<div style=3D"margin:0"><font face=3D"Calibri,sans-serif" size=3D"2"><span =
style=3D"font-size:11pt"><a href=3D"http://www.accu-time.com/" target=3D"_b=
lank"><font face=3D"Arial Narrow,sans-serif" size=3D"3"><span style=3D"font=
-size:12pt">www.accu-time.com</span></font></a></span></font></div>
<div style=3D"margin:0"><font face=3D"Calibri,sans-serif" size=3D"2"><span =
style=3D"font-size:11pt">&nbsp;</span></font></div>
<div style=3D"margin:0"><font face=3D"Calibri,sans-serif" size=3D"2"><span =
style=3D"font-size:11pt"><img alt=3D"ATS_logo_signature" border=3D"0" heigh=
t=3D"73" width=3D"112"></span></font></div>
</span></div>
</div>
</div>
</body>
</html>

--_000_4749E398ABC0754A82239442E1B13E2A6144EFD7ATSSBS2K11AccuT_--
