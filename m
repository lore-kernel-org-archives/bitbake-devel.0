Received: from mail-ea0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eren@hambedded.org>) id 1TitCK-0008Jk-RY
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Dec 2012 21:46:34 +0100
Received: by mail-ea0-f175.google.com with SMTP id h11so381318eaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Dec 2012 12:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent
	:x-gm-message-state;
	bh=r7E/3t/DkM4RFfGhlWoNDufy71OqSCN2LP58vgAQfCA=;
	b=ATXVcuQCmBihq5PwPzkTT5Ey5YeGnR+vL88EOWabk08dyHbrGs1L90dqdNc2kD44dZ
	32MBgppv18k9LObUSBIngfy3x1iXOjc9Qk6S/Hkxnl9qKYoFUgpfW8nnLMf5IhSzWd/w
	5wX0Ywgtff72Q8/Vt0AMYZy8BDHmQrhhlOcxfpRF3aVPQM1CliIXHidHweF8yvk6wUKn
	jY4N2Vh+3KL6F5DiCxnvD/6Zs+8vhMgnWNizwYSeTcfC/OSEnR51e+o8FqIbcnxEPg/o
	33CzuLyMBrSuziiZw8+QtFhfw1iNhQhKJ5bZn3yYg1qBMJqzxHE15fEZV1WLeD2UvtKF
	vmtw==
Received: by 10.14.0.133 with SMTP id 5mr5719050eeb.29.1355344318955;
	Wed, 12 Dec 2012 12:31:58 -0800 (PST)
Received: from gmail.com ([46.196.117.99])
	by mx.google.com with ESMTPS id k4sm51726295eep.15.2012.12.12.12.31.56
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 12 Dec 2012 12:31:58 -0800 (PST)
Date: Wed, 12 Dec 2012 22:31:51 +0200
From: Eren =?iso-8859-1?Q?T=FCrkay?= <eren@hambedded.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Message-ID: <20121212203151.GC743@gmail.com>
References: <20121212184156.GA743@gmail.com>
	<alpine.DEB.2.02.1212121356150.13192@oneiric>
	<20121212195335.GB743@gmail.com>
	<alpine.DEB.2.02.1212121459210.13746@oneiric>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1212121459210.13746@oneiric>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkwjUXdY1pUBAdcqKNt90ukZMf2bxNqv47wrPTo2wYcvINM5JDTm8porAYp6cFUQu0JVaic
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake.vim: detect *.bbappend files in ftdetect automatically
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
X-List-Received-Date: Wed, 12 Dec 2012 20:46:34 -0000
X-Groupsio-MsgNum: 3034
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GUPx2O/K0ibUojHx"
Content-Disposition: inline

--GUPx2O/K0ibUojHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 03:02:31PM -0500, Robert P. J. Day wrote:
>   sorry, i didn't mean to pick on you. :-)  i would avoid that kind of
> extreme optimization for a couple reasons.

No problem :)

>   also, it's sort of just a fluke that you can do that kind of
> optimization.  the instant you add another suffix that starts with
> something other than a "b", it messes things up and you lose the
> advantage.

Right, at first glance such a little code is not understood instantly.
foo.{bbclass,bbappend,bb} is more natural for suffixes.

>   anyway, i will leave this in the hands of folks higher up the food
> chain.

I'm sending V2 of the patch.=20

--=20
    . 73! DE TA1AET
      http://linkedin.com/in/erenturkay

--GUPx2O/K0ibUojHx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)

iQIcBAEBAgAGBQJQyOm3AAoJEOM7bMm6HhcTebEQAKilhNqS/aShGaObsdT3/h9b
8qdn5u64wny7mBPf3/aXihCBG5NNs170VZ6bvgEhn0JTfycMaFGnmHilPf+d+B07
mL6y7EJFEuTKqdif7JiaBwQqQDFagbqEh3rYdzK1K9ovs+gT7DlDqYZA4hmNg+M5
5tcXOqav0mXK1CHc4WJmWaW8ao4TkoALjN6pnqSPCrYtvyUdMjyqVjmhjn+y2TRI
IB3UoVqTSY1kDeIo1BxGmdUntp4/6fLqeu1gSdUYoWOmX+hmYi0nUgdpAPI4ASDq
ZmXJ8Fml9vLlneRhOOP79dgA2sHDfLBRIR4ZC/OJv4lLX4swXTnMqMt9JV9gwVtJ
v8yer6vTbEinO+KgA3PjlCtk0jJ9z7BVIwFTP2WqfMJgWLgW0kvqiD1sGuIvOYFn
5IrFAndLiIrmGGyFzTpUr6SpP3jGTnz2H2UDPZxbaL/b9NOISvgwlLUNsbZaFY2Q
LfbHOgVd1hn0ZFbxf3SQWzRO9uny+DPimQXTngBZjp0NQbzO4oS96y8aPNmUQmSL
Z/R1J4J15XqQP9tFao4IigL51qv+8iBW5L5U5yagkVbGi0YBWUvwTis90utnw0E8
RrX4jMpQTRH71wxwZhL5Y6nFMAa/XBrKNJ3wSLKpTkq/1qEKYGkJbBrQyDmn/IVC
OjwHUhc15nSq6p+QpL+v
=BDAT
-----END PGP SIGNATURE-----

--GUPx2O/K0ibUojHx--
