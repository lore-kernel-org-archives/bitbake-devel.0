Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <koen@dominion.thruhere.net>) id 1R6np1-0002fm-7N
	for bitbake-devel@lists.linuxtogo.org; Thu, 22 Sep 2011 20:16:31 +0200
Received: by fxi1 with SMTP id 1so3031126fxi.6
	for <bitbake-devel@lists.linuxtogo.org>;
	Thu, 22 Sep 2011 11:11:11 -0700 (PDT)
Received: by 10.223.40.145 with SMTP id k17mr3458464fae.76.1316715071490;
	Thu, 22 Sep 2011 11:11:11 -0700 (PDT)
Received: from [172.20.0.96] (ip545070eb.adsl-surfen.hetnet.nl.
	[84.80.112.235])
	by mx.google.com with ESMTPS id b21sm8257504fab.8.2011.09.22.11.11.09
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 22 Sep 2011 11:11:10 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1244.3)
From: Koen Kooi <koen@dominion.thruhere.net>
In-Reply-To: <1316681904-10860-1-git-send-email-koen@dominion.thruhere.net>
Date: Thu, 22 Sep 2011 20:11:08 +0200
Message-Id: <6D9C8F1E-3C96-40D0-9667-1BC2950B34C1@dominion.thruhere.net>
References: <1316681904-10860-1-git-send-email-koen@dominion.thruhere.net>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
X-Mailer: Apple Mail (2.1244.3)
Cc: bitbake-devel@lists.linuxtogo.org
Subject: Re: [RFC] fetch2: introduce BB_GENERATE_MIRROR_VERSIONED_TARBALLS to enable classic versioned scm snapshots
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
X-List-Received-Date: Thu, 22 Sep 2011 18:16:31 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Op 22 sep. 2011, om 10:58 heeft Koen Kooi het volgende geschreven:

> When enabled fetch2 will generate tarballs with the SRCREV embbeded =
like so:
>=20
> 	=
git2_git.pingu.fi.xf86-video-omapfb_28c006c94e57ea71df11ec4fff79d7ffcfc486=
0f.tar.gz
>=20
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
> lib/bb/fetch2/git.py |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index fb6125c..f889562 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -93,7 +93,7 @@ class Git(FetchMethod):
>=20
>         ud.nocheckout =3D ud.parm.get("nocheckout","0") =3D=3D "1"
>=20
> -        ud.rebaseable =3D ud.parm.get("rebaseable","0") =3D=3D "1"
> +        ud.rebaseable =3D ud.parm.get("rebaseable","0") =3D=3D "1" or =
((data.getVar("BB_GENERATE_MIRROR_VERSIONED_TARBALLS", d, True) or "0") =
!=3D "0")

Apart from the objections raised by Richard I've found 2 other problems =
with it:

1) it will force a cache invalidation each build
2) fetch2 witll *always* try to access the remote git repo, even if the =
SRCREV is already present in the local copy

Those aren't really bugs in my patch, but in the rebasable fetch2 code.=


