Received: from mail-we0-f178.google.com ([74.125.82.178])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1Tzpa3-0002oz-6c
	for bitbake-devel@lists.openembedded.org;
	Mon, 28 Jan 2013 15:21:06 +0100
Received: by mail-we0-f178.google.com with SMTP id x48so1475346wey.23
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Jan 2013 06:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=9seTXyh94/PTZaHc0qkf3rweVxvxcKq0pt1HhcDsfo0=;
	b=xVSVhOqV56Hn3r/KGIK0ty99NFeL9okwX3UjF9HMq++j/w9weVI+CW4pzuW7RqpFeo
	aMRb6A1QnYrJ5AofPFrNyhclibK9JqNappU1RRlz8nqp4LK/v4Zq3LKFaVqlCO/2sJc+
	eRB2FoahNP2OMnPKo9oa6X6mGJSWgydfkBDDpJUaZhGziUMD4Hgkkj7HkJaq6z2A/g29
	iMP4HcKq8DkhAzx76X24T1ntAVGb7Lzw99IB6ZizFjORjwnRJJczqhW31vL2iU4zUVSy
	cK+U2CEJC68x/j7h/XRwSvY9uX4CBjzql70R0WoMRcDksySd3Yo9FJvX+egJwIxqdVec
	YH8Q==
X-Received: by 10.194.108.229 with SMTP id hn5mr21616069wjb.8.1359381923979;
	Mon, 28 Jan 2013 06:05:23 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id gz3sm12264236wib.2.2013.01.28.06.05.22
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Mon, 28 Jan 2013 06:05:23 -0800 (PST)
Date: Mon, 28 Jan 2013 15:05:26 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Olof Johansson <olof.johansson@axis.com>
Message-ID: <20130128140526.GZ16904@jama.palm1.palmone.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
In-Reply-To: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] fetch2: SFTP fetcher and restructure of decodeurl
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
X-List-Received-Date: Mon, 28 Jan 2013 14:21:06 -0000
X-Groupsio-MsgNum: 3186
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vM12nk/63StVgfqY"
Content-Disposition: inline

--vM12nk/63StVgfqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2013 at 10:17:57AM +0100, Olof Johansson wrote:
> Hi,
>=20
> In our early work in migrating to poky we realized that bitbake's current=
 SSH
> fetcher doesn't really suite our needs. It suffers from some specification
> conformance bugs --- some which may be easily worked around. However, this
> patch series instead introduces a new "SFTP" fetcher, meant to in a way,
> replace the SSH fetcher, with stricter conformance to the SECSH URI spec =
[1].
>=20
> The SSH fetcher has its own URI parsing, and can not rely on
> bb.fetch2.decodeurl. I found that decodeurl was hard to extend, with it
> returning a tuple. This prompted me to write a generic URI class, with
> attributes for the various URI components (and some general bitbake kludg=
es,
> like support relative file:// uris).
>=20
> I realize that these changes are a bit bold and non-trivial, but I hope y=
ou'll
> find time to review them and point out problems to fix. If my reasoning is
> completely wrong, please let me know and I can try to solve our direct pr=
oblems
> with the SSH fetcher with minimal changes instead.
>=20
> The changes come with unittests for the URI class; it passes all the test=
s in
> bb.tests.fetch and all other tests under bb.tests, except
> bb.tests.data.DataExpansions, but the same errors are present on master as
> well. I've also tested running bitbake core-image-minimal in a new tree w=
ithout
> any issues.
>=20

Can you please rebase your patchset on latest master?

2nd patch conflicts with
commit 22bd19d208f0251f5a1f9b98f3cac66181f3fc07
Author: Tyler Hall <tylerwhall@gmail.com>
Date:   Wed Dec 19 18:26:50 2012 -0500
fetch2: Sort file checksums by value, not path

Are those patches generated from bitbake repo?
They start with 'lib/' so patch -p0 is needed instead of default -p1 and
cannot be applied directly from pw-am.sh :/.

Or please provide URL to your bitbake branch.

Cheers,

> Olof Johansson (6):
>   fetch2: Remove unused code in wget fetcher
>   fetch2: Add a class representing a generic URI
>   fetch2: unittests for bb.fetch2.URI class
>   fetch2: Adapt encode/decode url to use URI class
>   fetch2: Add editor modelines for bb.tests.*
>   fetch2: Add SFTP fetcher
>=20
>  lib/bb/fetch2/__init__.py  |  262 +++++++++++++++++++++++++++++++++++---=
------
>  lib/bb/fetch2/sftp.py      |  104 ++++++++++++++++++
>  lib/bb/fetch2/wget.py      |    5 -
>  lib/bb/tests/codeparser.py |    2 +
>  lib/bb/tests/cow.py        |    2 +
>  lib/bb/tests/data.py       |    2 +
>  lib/bb/tests/fetch.py      |  228 ++++++++++++++++++++++++++++++++++++++
>  lib/bb/tests/utils.py      |    2 +
>  8 files changed, 553 insertions(+), 54 deletions(-)
>  create mode 100644 lib/bb/fetch2/sftp.py
>=20
>=20
> References:
> 1: http://tools.ietf.org/html/draft-ietf-secsh-scp-sftp-ssh-uri-04
>=20
> --=20
> Olof Johansson
> Tools engineer
> (IRC: zibri on Freenode)
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--vM12nk/63StVgfqY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlEGhaYACgkQN1Ujt2V2gByJkACgnDnPFM39x9t85ceClM2utmrT
1qwAnigz9qp5GKNhxoQqqaBA5O0kDwjk
=83k3
-----END PGP SIGNATURE-----

--vM12nk/63StVgfqY--
