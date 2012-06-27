Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Sjz8C-0000v2-KG; Wed, 27 Jun 2012 22:46:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RKZena019480;
	Wed, 27 Jun 2012 21:35:40 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 16914-10; Wed, 27 Jun 2012 21:35:36 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RKZT1e019473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Jun 2012 21:35:31 +0100
Message-ID: <1340829332.23146.86.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Wed, 27 Jun 2012 21:35:32 +0100
In-Reply-To: <1340808774-24884-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
References: <1340793253.23146.19.camel@ted>
	<1340808774-24884-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
X-MIME-Autoconverted: from 8bit to quoted-printable by tim.rpsys.net id
	q5RKZena019480
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [PATCH 20/20] fetch: allow regexps in mirror protocol
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
X-List-Received-Date: Wed, 27 Jun 2012 20:46:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-27 at 16:52 +0200, Enrico Scholz wrote:
> Last mirror rewrite caused a regression not accepting
>=20
>    .*://.*/.* file://${DL_DIR}/../local/
>=20
> like specifications anymore. Patch restores old behavior by using regex=
p
> matching when checking protocol.
>=20
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---
>  lib/bb/fetch2/__init__.py |    2 +-
>  1 Datei ge=C3=A4ndert, 1 Zeile hinzugef=C3=BCgt(+), 1 Zeile entfernt(-=
)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 6f3d88c..75ce01b 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -207,7 +207,7 @@ def uri_replace(ud, uri_find, uri_replace, d):
>          elif loc =3D=3D 0:
>              # Principle of least surprise. We could end up with https =
matching against http and=20
>              # generating "files://" urls if we use the regexp engine b=
elow.
> -            if i !=3D uri_decoded[loc]:
> +            if not re.match(i, uri_decoded[loc]):
>                  return None
>              result_decoded[loc] =3D uri_replace_decoded[loc]
>          elif (re.match(i, uri_decoded[loc])):

I'm not picking on you (Enrico) here, there is a problem with my change
and we probably should revert my change in this area.

However the above patch fails "bitbake-selftest" and introduces a
regression. I wrote regression tests for the fetcher for a reason.

The trouble is its sees:

https://.*/.* file:///someplace/

but returns a url like files:// which the fetcher doesn't understand.
Suggestions on how to fix this are welcome.

Cheers,

Richard







