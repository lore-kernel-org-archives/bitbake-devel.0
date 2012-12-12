Received: from mail-ea0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eren@hambedded.org>) id 1Titc8-0000cr-4d
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Dec 2012 22:13:12 +0100
Received: by mail-ea0-f175.google.com with SMTP id h11so390396eaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Dec 2012 12:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent
	:x-gm-message-state;
	bh=lrZlO2kMhkxpH0gk39lEEQUblxQFxlTsPgUfmxIziG4=;
	b=jFGkoplKCd7EFPjaAc81+foxR0D8b6H7ACNwDgq8ViBXK8yfvhb9Ko+JMNcHgXsKhN
	sXhAwBrzT5nHq6yefm/GLTrwoW5fDNg/acZHxEaipPdvmywBXfP6bxFCvenqHnhEaA4/
	MTj2NfCBvBg0bcIbbrEo4lQXCY1X/UYJ7GKrCrgaFWoqHE0AKo1KPks0hY8WbH6YFn2F
	yTo+fPAm4/ex1GMH/hUyJpJERIBzqIXX5P+lCtGOyVap3cssxQ63K0i8BTkzeCEFuGS/
	Dv5NgIoLX5THEEN8TGd3kWlAtY3MxflJABjN1Z/L6PXy0QIRju3KoCjCbusO5mrWHv8P
	gi4Q==
Received: by 10.14.219.72 with SMTP id l48mr5974727eep.37.1355345918214;
	Wed, 12 Dec 2012 12:58:38 -0800 (PST)
Received: from gmail.com ([46.196.117.99])
	by mx.google.com with ESMTPS id l3sm40092157eem.14.2012.12.12.12.58.35
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 12 Dec 2012 12:58:37 -0800 (PST)
Date: Wed, 12 Dec 2012 22:58:30 +0200
From: Eren =?iso-8859-1?Q?T=FCrkay?= <eren@hambedded.org>
To: Martin Jansa <martin.jansa@gmail.com>
Message-ID: <20121212205830.GE743@gmail.com>
References: <20121212203550.GD743@gmail.com>
	<CA+chaQdi0E-4ZtsaiAweAFU5PcYYjnMKAeA-cT3eK+tcJOe_Dg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+chaQdi0E-4ZtsaiAweAFU5PcYYjnMKAeA-cT3eK+tcJOe_Dg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnyAhkv5QIMTgAIFtEm4zNvBi5+z762wLiPwAhq6VntZp5ZLvfjRweia4tD5wkjN1EN1AQV
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] bitbake.vim: detect *.bbappend files in ftdetect automatically
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
X-List-Received-Date: Wed, 12 Dec 2012 21:13:12 -0000
X-Groupsio-MsgNum: 3037
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zqjkMoGlbUJ91oFe"
Content-Disposition: inline

--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 09:47:26PM +0100, Martin Jansa wrote:
> fwiw: you can probably add .inc too, but some people will probably
> find it conflicting with some other ftdetect.. :/

*.inc and *.conf are already defined in the lines 16 and 19. I haven't
had any problems with them as I don't have conflicting files.

I wonder why *.bbinc isn't used instead of such a generic name *.inc :)
With a lot of recipes referencing *.inc, changing the suffix just for
vim plugin wouldn't be suitable. However, for the sake of consistency
with bb{class,append}, changing the practice of using *.inc to *.bbinc
could be good in some time.

Regards,
Eren

--=20
    . 73! DE TA1AET
      http://linkedin.com/in/erenturkay

--zqjkMoGlbUJ91oFe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)

iQIcBAEBAgAGBQJQyO/2AAoJEOM7bMm6HhcTw4sP/AzvodRRlX2p5XhaDlsPDDWQ
FRTrin6VRvHvCGfu03j/HbCJfzgnXKauXZpc05nzn3/Kz8zPijY4JLBFOzvqlIT5
QLPFfFxwzBpAs9YYJsg5P5Jlq9SQsyQuFg5sBcQsFPxWiMNmH5ZSPSg4CcPYgp2k
xGkR7hFvcX6WKQsgayAJMIx69+265/MXxFIZ9e9Pbdc8wzLb3MGAVzx2idsnbInh
pFIbzmqYkc8W0ekh9MZvYCKeFVir8qcKEm5O0p2jzqnz+91Wju/gbaX470h+ERHc
MaVNAzwP6V8+4MAwRsKyBSQ0z0wef8YTDzez7JiBKEhMK+3L5y/tnUWHlEtLwAWb
PwWqi7azNUw7ag8DbHdbaHMvWvHiJa5qj6ZrgzrZIjrF8DKMD3kKTfghuT6PzpRs
XAJGuRhg+700vft4NlPsxgtV+DYlYUlKcYxSHqVzgujzx5fuEMIo9F6wlmoDzUds
bJsV5clBBi9oZDZaEThaFY7aVQ4OENbsWyP3QIpbQPgmoEwpwja0WEgu3blfgNWg
nknNQUptg5dQOpkXiQKmgB9Ba00+dsmBQzeAGdACOABXIg4sUbezrxfYaVSkJkol
vOLrgXuv8umvRVjKdf1map5h4tVUiAT8eHOglvZZYDzwRSRF1mmDC9UIfhQm3pBV
lh8b2nV3UkGUEQufGGKk
=x1TN
-----END PGP SIGNATURE-----

--zqjkMoGlbUJ91oFe--
