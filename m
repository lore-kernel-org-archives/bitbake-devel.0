Received: from mail-ea0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eren@hambedded.org>) id 1TjFnf-0004Xn-F0
	for bitbake-devel@lists.openembedded.org;
	Thu, 13 Dec 2012 21:54:35 +0100
Received: by mail-ea0-f175.google.com with SMTP id h11so913095eaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Dec 2012 12:40:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent
	:x-gm-message-state;
	bh=9BO08robqehvaUYjtNeu5s3wQ/Fi4IkMmXNV/zCD/r0=;
	b=CHS9HikRMROuy8uUq1+S8W0TKZaLFJ+UjEHtUds765BGrr4Wt/txiJjbOSkxUks7Ad
	S02eWnw7VkEKLpTTkUDD5hk6hMj+95ht2brYm7p2tMGxOjPth/mTUT4bkWMuLSBOf67U
	qsT0FdUjoLyTyjoOyfUq2XNJh/NrrT/SA9U/5g/FyUKOv29rMRFmeVCWCtmX5BU4gv9j
	+BPruCWWRSfvPdF53kOc9U1ZfY0q4+pXB+9u7Y+qOenlgj4kZFBGYUyuqV82jQ+HVYcC
	pI1pih1XZrKwMbfqVC2aUUdChe47dkXKVi1URf3W1bRwfpgCwb0Qkbx6sSH9S5uwXf81
	7G6g==
Received: by 10.14.1.195 with SMTP id 43mr8130310eed.31.1355431200156;
	Thu, 13 Dec 2012 12:40:00 -0800 (PST)
Received: from gmail.com ([46.196.117.99])
	by mx.google.com with ESMTPS id b2sm5128667eep.9.2012.12.13.12.39.58
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 13 Dec 2012 12:39:59 -0800 (PST)
Date: Thu, 13 Dec 2012 22:39:47 +0200
From: Eren =?iso-8859-1?Q?T=FCrkay?= <eren@hambedded.org>
To: Trevor Woerner <twoerner@gmail.com>
Message-ID: <20121213203947.GA14893@gmail.com>
References: <20121212184156.GA743@gmail.com>
	<CAHUNapTLC4rNkq3iEZjKdLJNY0Tmgx4m+W2hy0npuWy+gPKnrQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHUNapTLC4rNkq3iEZjKdLJNY0Tmgx4m+W2hy0npuWy+gPKnrQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQn/OogoodZL5thdDH84xiuhnMDn6Orof+njnXFhAoosykLc0FIdBkE7HhDqCxMC7q3Vm3a2
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Thu, 13 Dec 2012 20:54:35 -0000
X-Groupsio-MsgNum: 3042
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2012 at 02:57:29PM -0500, Trevor Woerner wrote:
> On Wed, Dec 12, 2012 at 1:42 PM, Eren T=FCrkay <eren@hambedded.org> wrote:
> >  " .bb and .bbclass
> > -au BufNewFile,BufRead *.b{b,bclass}    set filetype=3Dbitbake
> > +au BufNewFile,BufRead *.b{b,bappend,bclass}    set filetype=3Dbitbake
>=20
> Don't forget to update the comment too :-)

Thanks you for your feedback. V2 of the patch includes updated comment
already. I fixed it while preparing v2.

Regards,
Eren

--=20
    . 73! DE TA1AET
      http://linkedin.com/in/erenturkay

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)

iQIcBAEBAgAGBQJQyj0TAAoJEOM7bMm6HhcTAs8P/3Sj+hsN7hz/osXYIXM9zat9
IL3sN0MyJdRt3Ro0NwjjLcchvuKxaM2WDYlK8dEPVs7R4BxyrNjXEaMvszZruhR2
7Nq4k6Ywm05ldJpbtsuWiyu9ou/pQrgU4Lt0ge9Y+G+ggMWR0znElsgTXunINvnJ
UZMJMgC5eYBL7KVHYZ6NyHU2B07H3WpYdPt5sYT/x0XYPv62OD8Y1LOS+8QccOc4
2auXEdvHxTHbDHlz8kQShAEEcgarHPseWmPwXUFla1kJZwwcPTn0bYPASrg0Fgq0
pO8u6TtbfzHbeKjesGqypa4F18e+vV6oYwr6iqNHf8AM/f2jfb3REEC46GhJFbgf
HBgaHoWVmmG/kRs+TLzXKYNvpjaaLaOZV2BXXJHPbxe8OqIBWVPQoIYJli/fq7pJ
kBnvYJmjsWRmZD4Q1FJS6TVue4ij++eJTLz/2oMDQzpWuxdcwgj83rrvZ4fjz63+
RIjm0OTPEIqr446EIUBmUyIrmaam+gVdsMyo2quQ77EUcPgbJEcAHcLlRIhgEqt0
TVAqIui+SaRc6u/lOQpw+oBfqGp0uH7XoSfysbBF+zOL5re64kga0oGbrRN1UJNJ
QgurEIUoQ/gBjzI/GcABpnTboar66mqxnXlWFUtvwfyQR0C4kABJ1OPMEe0FZAU7
iggAVaHcdC5cT0TQ+ibj
=TKdT
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
