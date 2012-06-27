Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1SjttE-00016O-HI; Wed, 27 Jun 2012 17:10:44 +0200
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([99.241.91.63]:47392 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1Sjtif-0006AY-P6; Wed, 27 Jun 2012 10:59:49 -0400
Date: Wed, 27 Jun 2012 10:59:44 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
In-Reply-To: <1340808774-24884-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
Message-ID: <alpine.DEB.2.02.1206271059080.19635@oneiric>
References: <1340793253.23146.19.camel@ted>
	<1340808774-24884-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] [PATCH 20/20] fetch: allow regexps in mirror protocol
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
X-List-Received-Date: Wed, 27 Jun 2012 15:10:45 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1222317525-1340809187=:19635"

--8323329-1222317525-1340809187=:19635
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 27 Jun 2012, Enrico Scholz wrote:

> Last mirror rewrite caused a regression not accepting
>
>    .*://.*/.* file://${DL_DIR}/../local/
>
> like specifications anymore. Patch restores old behavior by using regexp
> matching when checking protocol.
>
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---
>  lib/bb/fetch2/__init__.py |    2 +-
>  1 Datei ge=C3=A4ndert, 1 Zeile hinzugef=C3=BCgt(+), 1 Zeile entfernt(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 6f3d88c..75ce01b 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -207,7 +207,7 @@ def uri_replace(ud, uri_find, uri_replace, d):
>          elif loc =3D=3D 0:
>              # Principle of least surprise. We could end up with https ma=
tching against http and
>              # generating "files://" urls if we use the regexp engine bel=
ow.
> -            if i !=3D uri_decoded[loc]:
> +            if not re.match(i, uri_decoded[loc]):
>                  return None
>              result_decoded[loc] =3D uri_replace_decoded[loc]
>          elif (re.match(i, uri_decoded[loc])):
> --
> 1.7.10.2

  that certainly seems to have solved my issue with using
"own-mirrors".

rday

--=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--8323329-1222317525-1340809187=:19635--
