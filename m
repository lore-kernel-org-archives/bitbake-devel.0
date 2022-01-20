Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC62C433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 13:50:25 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web12.11801.1642686623591431834
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 05:50:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=MKudR/q1;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1642686624;
  x=1674222624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VIU4q/EQ+sKCcb7FSOa8pIuC+FH+Yz/9NOHR315AOaU=;
  b=MKudR/q1MwcK4AouUSYZCkQi1vu/FSm+YsMg/0stPzJPQbkj/eS5N14U
   7C5veQ469Rwqu1uIrmoJyNScYUzdQrESzKF/ggjmhYXw1lQ7ggB2lwr9Q
   Cejb8pGfMwIrYVC5H6PvBzr+HgIbY25WxRnMWCZNz57X/KlX4Tl4m6HHP
   QAUHZxbSd1NDOTWCug6nt8rv6+sh/Yy43Dfz3p8Bqal0bYZbYqtAco6al
   AoHs3Uc6B4s+NT3vH7smmg9vY7HXalmThrjPW8Aj0POEvlr7mmQvGtmQ8
   VuDvY5gYY2CYgq6hlKZtML8jg4V1Y7cO6ub4n+WT3C4ea50q/sZ4KcUOb
   w==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Robert Yang <liezhi.yang@windriver.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "quaresma.jose@gmail.com" <quaresma.jose@gmail.com>
Subject: RE: [bitbake-devel] [PATCH 1/1] bitbake-worker: Check BB_TASK_NETWORK
 before disable network for task
Thread-Topic: [bitbake-devel] [PATCH 1/1] bitbake-worker: Check
 BB_TASK_NETWORK before disable network for task
Thread-Index: AQHYDc8shCHXyO6szEiPlZDWwnt6pKxr503A
Date: Thu, 20 Jan 2022 13:50:21 +0000
Message-ID: <db841326fc6647919a2ee07a82693e30@axis.com>
References: <cover.1642663574.git.liezhi.yang@windriver.com>
 <75af98ed9992aad08e6fadc64d1985a165529828.1642663574.git.liezhi.yang@windriver.com>
In-Reply-To: 
 <75af98ed9992aad08e6fadc64d1985a165529828.1642663574.git.liezhi.yang@windriver.com>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 13:50:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13255

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Robert Yang
> Sent: den 20 januari 2022 08:27
> To: bitbake-devel@lists.openembedded.org
> Cc: quaresma.jose@gmail.com
> Subject: [bitbake-devel] [PATCH 1/1] bitbake-worker: Check BB_TASK_NETWOR=
K before disable network for task
>=20
> The NIS user can't work when task's network is disabled, so check
> BB_TASK_NETWORK before disable it, the conf files can set BB_TASK_NETWORK=
.
>=20
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/bin/bitbake-worker | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
> index 3aaf3c2444b..3d7a781d35c 100755
> --- a/bitbake/bin/bitbake-worker
> +++ b/bitbake/bin/bitbake-worker
> @@ -261,7 +261,8 @@ def fork_off_task(cfg, data, databuilder, workerdata,
> fn, task, taskname, taskha
>=20
>                  bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN=
"), taskname.replace("do_", "")))
>=20
> -                if not the_data.getVarFlag(taskname, 'network', False):
> +                bb_task_network =3D bb.utils.to_boolean(the_data.getVar(=
'BB_TASK_NETWORK'), False)

Why use False to getVar() above?

> +                if not (bb_task_network or the_data.getVarFlag(taskname,=
 'network', False)):

I can't speak for others, but I find "not (foo or bar)" a lot harder to=20
parse than "not foo and not bar".

>                      logger.debug("Attempting to disable network")
>                      bb.utils.disable_network(uid, gid)
>=20
> --
> 2.31.1

//Peter


