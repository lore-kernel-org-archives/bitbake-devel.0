Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9056DCA0FE6
	for <webhook@archiver.kernel.org>; Fri,  1 Sep 2023 09:26:37 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by mx.groups.io with SMTP id smtpd.web10.2413.1693560394881156840
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Sep 2023 02:26:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@myneves.com header.s=protonmail2 header.b=WEwWCZP2;
 spf=pass (domain: myneves.com, ip: 185.70.43.23, mailfrom: paulo@myneves.com)
Date: Fri, 01 Sep 2023 09:26:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail2; t=1693560390; x=1693819590;
	bh=0kWiZ3+cc+QMdr+tGajVPsozVRpnpE9mujtx/V4Lp0I=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WEwWCZP2BqHJ/0rssZQnrpTW6PkHGYUSjpX3cgkr5eqoQyYWk0NkfOK98YU3Ypz3m
	 sKjxz2StQj48aK50TZT3dOwTirQSX0mhOeWFQbgZ4uxDbbzuiRWcB9kybRysse/6ax
	 9fH9rvA8A94rj7rcWBTVOxy3Bag3sV9Sb3TGDDzEtl3ZnlrXCjeYbPVDioAzJjULWO
	 a3BMnbb6M4l45KXx6BHdfUYykQ3EG9lvge+m6/vjZGtojqfiWQbat2y+qqHUMyY2Gw
	 YXYl/ngk7/HZhVwBJPKpoF2avj1bsR5IbweYHRiIxMhXX4IHMY7koOW9yaHHslFyWg
	 hDYNvYlB2yXkA==
To: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Subject: Re: [bitbake-devel][PATCH] fetch2: git: Remove useless try..else clause
Message-ID: <65d20360-6ec9-58be-2f4e-b69c1c71b93a@myneves.com>
In-Reply-To: <20230831143032.1463093-1-JPEWhacker@gmail.com>
References: <20230831143032.1463093-1-JPEWhacker@gmail.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Sep 2023 09:26:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15002

On 31/08/2023 16:30, Joshua Watt wrote:
> There is no reason to have the else clause in this try block, as it can
> be moved into the try block, which is clearer.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   bitbake/lib/bb/fetch2/git.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 33895e09b29..e11271b757a 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -373,10 +373,7 @@ class Git(FetchMethod):
>               try:
>                   # Since clones can be bare, use --absolute-git-dir inst=
ead of --show-toplevel
>                   output =3D runfetchcmd("LANG=3DC %s rev-parse --absolut=
e-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> -            except bb.fetch2.FetchError as e:
> -                logger.warning("Unable to get top level for %s (not a gi=
t directory?): %s", ud.clonedir, e)
> -                needs_clone =3D True
> -            else:
> +
>                   toplevel =3D os.path.abspath(output.rstrip())
>                   abs_clonedir =3D os.path.abspath(ud.clonedir).rstrip('/=
')
>                   # The top level Git directory must either be the clone =
directory
> @@ -387,6 +384,9 @@ class Git(FetchMethod):
>                   if os.path.commonprefix([abs_clonedir, toplevel]) !=3D =
abs_clonedir:
>                       logger.warning("Top level directory '%s' doesn't ma=
tch expected '%s'. Re-cloning", toplevel, ud.clonedir)
>                       needs_clone =3D True
> +            except bb.fetch2.FetchError as e:
> +                logger.warning("Unable to get top level for %s (not a gi=
t directory?): %s", ud.clonedir, e)
> +                needs_clone =3D True
>
>               if needs_clone:
>                   shutil.rmtree(ud.clonedir)
> --
> 2.34.1
>
Looks good to me and thank you for submitting a correction :)



