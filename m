Return-Path: <gmstima@gmail.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
	[209.85.217.179])
	by mail.openembedded.org (Postfix) with ESMTP id 1B45672D74
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 08:55:12 +0000 (UTC)
Received: by lbbqq2 with SMTP id qq2so8691062lbb.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=2w0UOf57FCavN5QjDpZo2+d4E0rQdfxY9kTukKMYxeA=;
	b=Cn9UqY/v+D/cxh6+cK2XWedWNfO7UFsODtjAVJP9RbkxvXJ09mEd/JnFQ8cn7IAc2k
	bJmW0MRnqu/ES8fSDduVdyC8diX24cXt9wGA7RYFjwRLUkfRSoWNe7e49Zsly8JcAgyw
	qAnn7DDDbEiVXjDPFVCB6LptmwwiLIsCV0wI3BkX+pFyhblIDbShYl9pYN64FMOcK818
	nNy26dDrZQql2ayjhDSP1IzF9P+/xi6CvI9B6rIHZT6vNUZCXrPG2kqf3YHPsICkLshp
	CmiPM2C8UQ2S+yYHjvDNQPVFWP9Y0AWW9KgH3gxr9p+iAYjsw9+6o7AN4HxkK8LncGul
	+u2Q==
MIME-Version: 1.0
X-Received: by 10.112.173.41 with SMTP id bh9mr437577lbc.107.1428656112953;
	Fri, 10 Apr 2015 01:55:12 -0700 (PDT)
Received: by 10.152.181.230 with HTTP; Fri, 10 Apr 2015 01:55:12 -0700 (PDT)
Date: Fri, 10 Apr 2015 11:55:12 +0300
Message-ID: <CAGpdKU+Jjgtukyfm7E4rO+azk+wxY+TL22zP24DPh-nsTcjvdA@mail.gmail.com>
From: Roman Savchenko <gmstima@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: pkg_postinst_${PN}_append
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
X-List-Received-Date: Fri, 10 Apr 2015 08:55:13 -0000
Content-Type: multipart/alternative; boundary=001a11c2aee61e6f6305135aecab

--001a11c2aee61e6f6305135aecab
Content-Type: text/plain; charset=UTF-8

Hi All,

Why doesn't pkg_postinst_${PN}_append call if I add `python` to him:

pkg_postinst_${PN}_append {
 //called
}

python pkg_postinst_${PN}_append {
 //not called
}

Could any one please help me?

Regards,
R. Savchenko

--001a11c2aee61e6f6305135aecab
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi All,<br><br></div>Why doesn&#39;t pkg_po=
stinst_${PN}_append call if I add `python` to him:<br></div><br>pkg_postins=
t_${PN}_append {<br></div>=C2=A0//called<br><div>}<br><br>python pkg_postin=
st_${PN}_append {<br>=C2=A0//not called<br>}<br><div><div><div><br>Could an=
y one please help me?<br><br></div><div>Regards,<br></div><div>R. Savchenko=
<br></div></div></div></div></div>

--001a11c2aee61e6f6305135aecab--
