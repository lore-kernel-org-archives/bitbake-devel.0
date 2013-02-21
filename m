Received: from mail-vc0-f169.google.com ([209.85.220.169])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <pranap@gmail.com>) id 1U8gGg-0000jD-MY
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Feb 2013 01:13:42 +0100
Received: by mail-vc0-f169.google.com with SMTP id n10so71179vcn.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Feb 2013 15:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:date:message-id:subject:from:to:cc
	:content-type; bh=llJ1bkx3lgnaklvOnKoFYCOdnyX7m264mhx/pNfkz/A=;
	b=HFVXb8wwDY2qPdlN84olqvvoVmt2+2rK7cMbQP9FZvW0lrvhVzRwBh0lEam6vgqQAw
	yoyHlVJGnK7FMnQWQx5eofraoLgH04aSFsvM7rqEfhD7LRM+DlYe42fq583lZL29vgWq
	Ck01hx4tVCcSf4Xe4aia+xw224YTL6AZcA1UeMtT8hXrYKRSGaOjWPRAYn3VREPE09QZ
	s6Ex5uQ5NugXZTwCkgXe+zZDeimFLDCCt2oxgNThR+hOFTKKFVrxqxAHBFQCELaPO6Sa
	uf7VigKMKAasT/LpRg8MLsSW1q9GEvAaqG2F80xtWFGKZxDUlZtM6EPRUqX5fXULleGL
	8Xqg==
MIME-Version: 1.0
X-Received: by 10.58.245.40 with SMTP id xl8mr34960369vec.33.1361491045642;
	Thu, 21 Feb 2013 15:57:25 -0800 (PST)
Received: by 10.58.186.229 with HTTP; Thu, 21 Feb 2013 15:57:25 -0800 (PST)
Date: Thu, 21 Feb 2013 16:57:25 -0700
Message-ID: <CAKFDafUoMXKYr_xdabpNdfz+yJcBnWLunK6pTL2J5dspkQEr2w@mail.gmail.com>
From: Pr Pe <pranap@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: How to get additional binaries in tmp/deploy/images
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 22 Feb 2013 00:14:13 -0000
Content-Type: multipart/alternative; boundary=047d7bdc059423f29d04d644d642

--047d7bdc059423f29d04d644d642
Content-Type: text/plain; charset=ISO-8859-1

I have an image recipe (appending to core-image-minimal) that builds
components specific to my project and I get a bzImage and a
core-image-minimal.iso out of it. I want to add some bootloader code to be
built as a separate entity  like bzImage and not as part of the
core-image-minimal.iso. Is there a way to do this in yocto?

Thanks,
Prana

--047d7bdc059423f29d04d644d642
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13=
px;background-color:rgb(255,255,255)">I have an image recipe (appending to =
core-image-minimal) that builds components specific to my project and I get=
 a bzImage and a core-image-minimal.iso out of it. I want to add some bootl=
oader code to be built as a separate entity =A0like bzImage and not as part=
 of the core-image-minimal.iso. Is there a way to do this in yocto?</div>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13=
px;background-color:rgb(255,255,255)"><br></div><div style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:13px;background-color:rgb(255=
,255,255)">
Thanks,</div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif=
;font-size:13px;background-color:rgb(255,255,255)">Prana</div>

--047d7bdc059423f29d04d644d642--
