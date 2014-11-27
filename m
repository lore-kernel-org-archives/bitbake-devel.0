Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 475CE72373
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id B0BFC1806B;
	Thu, 27 Nov 2014 10:20:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id uSThrhy6v0Tv; Thu, 27 Nov 2014 10:20:22 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 45E2718092;
	Thu, 27 Nov 2014 10:20:22 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 192D510A9;
	Thu, 27 Nov 2014 10:20:22 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 0C704578;
	Thu, 27 Nov 2014 10:20:22 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 09C5334289;
	Thu, 27 Nov 2014 10:20:22 +0100 (CET)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail2.se.axis.com
	([10.0.5.74]) with mapi; Thu, 27 Nov 2014 10:20:21 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Cody P Schafer <dev@codyps.com>
Date: Thu, 27 Nov 2014 10:20:20 +0100
Thread-Topic: [bitbake-devel] [PATCH] git: allow use of HEAD
Thread-Index: AdAHaMSoHR40+OcBSNGy8ss3wOjT8QCuh2jQ
Message-ID: <A612847CFE53224C91B23E3A5B48BAC7ACF1536B55@xmail3.se.axis.com>
References: <1415755576-4571-1-git-send-email-dev@codyps.com>
In-Reply-To: <1415755576-4571-1-git-send-email-dev@codyps.com>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] git: allow use of HEAD
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
X-List-Received-Date: Thu, 27 Nov 2014 09:20:30 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Cody P Schafer
> Sent: den 12 november 2014 02:26
> To: bitbake-devel@lists.openembedded.org
> Cc: Cody P Schafer
> Subject: [bitbake-devel] [PATCH] git: allow use of HEAD
>=20
> ---
>  lib/bb/fetch2/git.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 66a77a8..84c7268 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -339,7 +339,9 @@ class Git(FetchMethod):
>          """
>          Compute the HEAD revision for the url
>          """
> -        if ud.unresolvedrev[name][:5] =3D=3D "refs/":
> +        if ud.unresolvedrev[name] =3D=3D "HEAD":
> +            search =3D "%s %s^{}" % (ud.unresolvedrev[name], ud.unresolv=
edrev[name])
> +        elif ud.unresolvedrev[name][:5] =3D=3D "refs/":
>              search =3D "%s %s^{}" % (ud.unresolvedrev[name], ud.unresolv=
edrev[name])

You could write the above as:

        if (ud.unresolvedrev[name] =3D=3D "HEAD" or
            ud.unresolvedrev[name][:5] =3D=3D "refs/"):
            search =3D "%s %s^{}" % (ud.unresolvedrev[name], ud.unresolvedr=
ev[name])

>          else:
>              search =3D "refs/heads/%s refs/tags/%s^{}" % (ud.unresolvedr=
ev[name], ud.unresolvedrev[name])
> --
> 2.1.3

//Peter


