Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1289AC25B08
	for <webhook@archiver.kernel.org>; Sat, 20 Aug 2022 12:07:07 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.5872.1660997218416580587
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Aug 2022 05:06:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=JCHT0hHF;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1660997218;
  x=1692533218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jRVvNyiDAbISBEz9sIe6Z4qxBLRlMgK20tUAIp1U9D8=;
  b=JCHT0hHFTTvS01jvjO5cid9c5PEXnIytF1ui6kQejUm31eGIyy2V2cYo
   4Of2+J2TsaJTqlzDb3KlxqMx2ssX2aQjO2+Q5p/RK9Rsddg92RahfrdhU
   F/U6ZyENtKOfyGHTf0rNiMJBBS10MAH3nAtk1RdPIqrw0UBOP+FRAqd0c
   +4FT+P5NRP1WfmklkWg7Cx4Ql5yMZQ3MaYne/EE1Nsqafn/EXXTW8aEhV
   ujg8tHqulUXMuU/4m0JfF5XjMBN04ZVFgkfeKwAtv6lMG70R7DWF/6gJg
   vfNI4SeIV2fpzx2Zt1IYovykXCAEAY++vcvha6bfZkaMlzDWUmfsyIkMk
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Marek Vasut <marex@denx.de>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Martin Jansa <Martin.Jansa@gmail.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Subject: RE: [PATCH] [RFC] fetch2/git: Prevent git fetcher from fetching
 gitlab repository metadata
Thread-Topic: [PATCH] [RFC] fetch2/git: Prevent git fetcher from fetching
 gitlab repository metadata
Thread-Index: AQHYs+xv6Ur3otLigUKfkUpnMtN9z623q2hQ
Date: Sat, 20 Aug 2022 12:06:55 +0000
Message-ID: <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com>
References: <20220819165455.270130-1-marex@denx.de>
In-Reply-To: <20220819165455.270130-1-marex@denx.de>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 20 Aug 2022 12:07:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13908

> -----Original Message-----
> From: Marek Vasut <marex@denx.de>
> Sent: den 19 augusti 2022 18:55
> To: bitbake-devel@lists.openembedded.org
> Cc: Marek Vasut <marex@denx.de>; Martin Jansa <Martin.Jansa@gmail.com>; P=
eter Kjellerstedt <peter.kjellerstedt@axis.com>; Richard Purdie <richard.pu=
rdie@linuxfoundation.org>
> Subject: [PATCH] [RFC] fetch2/git: Prevent git fetcher from fetching gitl=
ab repository metadata
>=20
> The bitbake git fetcher currently fetches 'refs/*:refs/*', i.e. every
> single object in the remote repository. This works poorly with gitlab
> and github, which use the remote git repository to track its metadata
> like merge requests, CI pipelines and such.
>=20
> Specifically, gitlab generates refs/merge-requests/*, refs/pipelines/*
> and refs/keep-around/* and they all contain massive amount of data that
> are useless for the bitbake build purposes. The amount of useless data
> can in fact be so massive (e.g. with FDO mesa.git repository) that some
> proxies may outright terminate the 'git fetch' connection, and make it
> appear as if bitbake got stuck on 'git fetch' with no output.
>=20
> To avoid fetching all these useless metadata, tweak the git fetcher such
> that it only fetches refs/heads/* and refs/tags/* . Avoid using negative
> refspecs as those are only available in new git versions.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Martin Jansa <Martin.Jansa@gmail.com>
> Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 4534bd75..b5fc0a51 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -382,7 +382,7 @@ class Git(FetchMethod):
>                runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=
=3Dud.clonedir)
>=20
>              runfetchcmd("%s remote add --mirror=3Dfetch origin %s" % (ud=
.basecmd, shlex.quote(repourl)), d, workdir=3Dud.clonedir)
> -            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/*:ref=
s/*" % (ud.basecmd, shlex.quote(repourl))
> +            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/heads=
/*:refs/heads/* refs/tags/*:refs/tags/*" % (ud.basecmd, shlex.quote(repourl=
))
>              if ud.proto.lower() !=3D 'file':
>                  bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
>              progresshandler =3D GitProgressHandler(d)
> --
> 2.35.1

Seems like the right thing to do. We use Gerrit, which also has its=20
metadata in special refs/ spaces. One repository I tested with grew=20
from 3 MB to 35 MB when I fetched using refs/* while another grew=20
from 20 MB to 120 MB, so there is definitely space and time to be=20
saved by only fetching the refs/heads and refs/tags spaces....

Reviewed-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

//Peter


