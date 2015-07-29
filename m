Return-Path: <gmstima@gmail.com>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
	[209.85.213.169])
	by mail.openembedded.org (Postfix) with ESMTP id 71FF260132
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Jul 2015 15:34:15 +0000 (UTC)
Received: by igr7 with SMTP id 7so148620692igr.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Jul 2015 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=gFcn4dW/ToZok4q8Y5S11za/9GWMtukhkUYZosZ3W/8=;
	b=pwAFHcc2F5SDlpw5UIa1kWaBamDy+MqSxXNWzfhKP/RMGfVq2S87IoUROh+pHYYofu
	xG+vsyamip33qNbbHiLd+EsTX5wM731E/FiuwVppY7own5BlcmSasKW0egJq7mrrX1oR
	LBG9YQ3lgPpdyUxtoAUoFJH1Mobc8/gG/SBii2vMYCZcfy/SGu+jz9MPw1BaY3hvbdkj
	sQnLOcBprK/AdmND3s5a9eX8VUMiHoApRvSVluG2Fy6ouLWKR3P86n5tnYHb4m5lBEeM
	VZrCqUd14FUp/TrVGeCOnezSiHr8QuD0vH4Y9GMnY5BDFveh7womT3HMBZU4oeowQVSY
	ltwQ==
MIME-Version: 1.0
X-Received: by 10.50.30.9 with SMTP id o9mr2618546igh.36.1438184056007; Wed,
	29 Jul 2015 08:34:16 -0700 (PDT)
Received: by 10.36.92.69 with HTTP; Wed, 29 Jul 2015 08:34:15 -0700 (PDT)
Date: Wed, 29 Jul 2015 18:34:15 +0300
Message-ID: <CAGpdKUJDc37GZa3v8t8BYpdp2hpcdaB_rHPt6kiQ0J5BqmMrmw@mail.gmail.com>
From: Roman Savchenko <gmstima@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Get package inheritance
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
X-List-Received-Date: Wed, 29 Jul 2015 15:34:18 -0000
Content-Type: multipart/alternative; boundary=047d7bd76aeac7b371051c0551c3

--047d7bd76aeac7b371051c0551c3
Content-Type: text/plain; charset=UTF-8

Hi all,

how can I get package inheritance?

Example what I want:

my_package.bb
inherit A // can't be changed
inherit B
Inherit C

C.bbclass

python do_some_stuff() {
    bases = d.getVar("INHERIT")
    if "A" in bases:
         do_some_stuff_for_a()
    else if "B":
         //
    else if "A" and "B"
}

addtask do_some_stuff


Regards,
R. Savchenko

--047d7bd76aeac7b371051c0551c3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi all,<br><br></div>how can I get pac=
kage inheritance?<br></div><br></div>Example what I want:<br></div><div><br=
><a href=3D"http://my_package.bb">my_package.bb</a><br>inherit A // can&#39=
;t be changed<br></div><div>inherit B<br></div><div>Inherit C<br><br></div>=
<div>C.bbclass<br></div><div><br></div><div>python do_some_stuff() {<br></d=
iv><div>=C2=A0=C2=A0=C2=A0 bases =3D d.getVar(&quot;INHERIT&quot;)<br></div=
><div>=C2=A0=C2=A0=C2=A0 if &quot;A&quot; in bases:<br></div><div>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_some_stuff_for_a()<br></div><div=
>=C2=A0=C2=A0=C2=A0 else if &quot;B&quot;:<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 //<br></div><div>=C2=A0=C2=A0=C2=A0 else if &quot;A&q=
uot; and &quot;B&quot;<br></div><div>}<br></div><div><br></div><div>addtask=
 do_some_stuff<br><br><br></div><div>Regards,<br></div><div>R. Savchenko<br=
></div></div>

--047d7bd76aeac7b371051c0551c3--
