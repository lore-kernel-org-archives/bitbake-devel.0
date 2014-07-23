Return-Path: <alexandru.damian@intel.com>
Received: from mail-oa0-f52.google.com (mail-oa0-f52.google.com
	[209.85.219.52])
	by mail.openembedded.org (Postfix) with ESMTP id 612A070684
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Jul 2014 17:17:04 +0000 (UTC)
Received: by mail-oa0-f52.google.com with SMTP id o6so2034918oag.39
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Jul 2014 10:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to
	:content-type;
	bh=VaOuvzSgjKNp4YY6hQ0MPTQGAdGLzTUCqGQqCwAZAMc=;
	b=aIdHfoJPXva+600EcHK+hn0eryrS67rbZQRvIZMAXTIIESx2uc8m8MThXOLEJzkEyD
	e2KvWAr0+IFE7j/1geyKkHxhrHj0AeHnOqQE2alieFui1HTs9Q2MR6e4EbF/iLDc2uHz
	Q0xd5tHS9teW9+RBDPqXGZ5UUH7ekASdbQgPMb0+pcBrtO3DAo/YFuZtXi068zuWYN2C
	2F4/HBVohOFCeGI1PtHVdxbGX+70w3HPunX0YXB5wSAzCPztdLkv6GSqxdo0s86rIxvv
	nwG6eGtkPQRhMPBl3kVcodgMiIZRvVw7CjItNgygSLWlBwjfJR2LaL+rJuuqgqlq537+
	b+fA==
X-Gm-Message-State: ALoCoQknNFguKF/1EHa3qb4lSly4sh/cYQmkcvyRQTE/BnUIQTmzz+8kXkz7Cz6wY97YoWYmA3xe
X-Received: by 10.60.52.5 with SMTP id p5mr3913489oeo.55.1406135825452; Wed,
	23 Jul 2014 10:17:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.122.204 with HTTP; Wed, 23 Jul 2014 10:16:45 -0700 (PDT)
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Wed, 23 Jul 2014 18:16:45 +0100
Message-ID: <CAJ2CSBuuD9Qv=YdkGmzRY3ev9zJ=cESm_-Bg8BdDTnOvkOm+dQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Paul Eggleton <paul.eggleton@linux.intel.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	"toaster@yoctoproject.org" <toaster@yoctoproject.org>
Subject: Toaster patchset for merging
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
X-List-Received-Date: Wed, 23 Jul 2014 17:17:08 -0000
Content-Type: multipart/alternative; boundary=001a11332c8e61e72e04fedf8206

--001a11332c8e61e72e04fedf8206
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Thanks for the test push on master-next.

I tested master-next and it works fine !

However, on prompt from Paul, I refactored the patchset to proper spell out
changes in the commit messages.

Can you please pull:

poky-contrib: adamian/20140723-master-next-refactored
=E2=80=8B
The final diff between this new branch and master-next is NIL, but the
commit messages are updated.

Cheers,
Alex
=E2=80=8B

--=20
Alex Damian
Yocto Project
SSG / OTC

--001a11332c8e61e72e04fedf8206
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hi Richard,</div><div class=3D"gmail_default" style=3D"font-fami=
ly:tahoma,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-=
family:tahoma,sans-serif">

Thanks for the test push on master-next.</div><div class=3D"gmail_default" =
style=3D"font-family:tahoma,sans-serif"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:tahoma,sans-serif">I tested master-next and it wor=
ks fine !</div>

<div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br></=
div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Ho=
wever, on prompt from Paul, I refactored the patchset to proper spell out c=
hanges in the commit messages.</div>

<div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br></=
div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Ca=
n you please pull:</div><div class=3D"gmail_default" style=3D"font-family:t=
ahoma,sans-serif">

<br></div><div class=3D"gmail_default" style><font face=3D"tahoma, sans-ser=
if">poky-contrib: adamian/20140723-master-next-refactored</font><br></div><=
div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">=
=E2=80=8B</div>

<div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">The fi=
nal diff between this new branch and master-next is NIL, but the commit mes=
sages are updated.<br></div><div class=3D"gmail_default" style=3D"font-fami=
ly:tahoma,sans-serif">

<br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-ser=
if">Cheers,</div><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Alex</div><div class=3D"gmail_default" style=3D"font-family:taho=
ma,sans-serif">

=E2=80=8B</div><br></div>-- <br><div dir=3D"ltr">Alex Damian<div>Yocto Proj=
ect<br></div><div>SSG / OTC=C2=A0</div></div>
</div>

--001a11332c8e61e72e04fedf8206--
