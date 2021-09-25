Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CDDC433EF
	for <webhook@archiver.kernel.org>; Sat, 25 Sep 2021 20:07:51 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.10923.1632600469608683245
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Sep 2021 13:07:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=DW4/orP8;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1632600470;
  x=1664136470;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=y2cEDf0uLMWRuei8WDj0ewXyhGXQgq1psob1rbUU5iU=;
  b=DW4/orP83n1m358JkF0aNEVluSoNtyHmnvtac5ax96rualazMXCk3iyM
   MsdS/4QCAI8LZKqf/RZns8WjBzw62eU2jbT/pv8C0kudAAzpP/pwk0QND
   MqDD2wl6Gla2hY9biIr8XapmneWajhuwjdb6zuRseF8tJUdSpBISKV7Su
   DykiFLqP/dA73+BvRmrDsfkfT5EXZHBVF0nNkrT2uD05lN+cfpuiD0mpL
   lq+t4HacZSoHlMn4CfK07sBR6IzGmzXL331zJpBpyLn42Odvy35tUz3T3
   lgLMh7+g/ylW23nFXQJ0Bo8zsfu9HfyaW+oyHzm/sSWDbEfenJ9fEulIm
   g==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] bitbake-worker: Allow shutdown/database
 flush of pseudo server at task exit
Thread-Topic: [bitbake-devel] [PATCH] bitbake-worker: Allow shutdown/database
 flush of pseudo server at task exit
Thread-Index: AQHXsfGFYQYC4FuzzEKhOszLoKmYh6u1Lbxg
Date: Sat, 25 Sep 2021 20:07:41 +0000
Message-ID: <26060299809b41069524ab3f0e48e7ce@axis.com>
References: <20210925094121.1780833-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210925094121.1780833-1-richard.purdie@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Sep 2021 20:07:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12706

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie
> Sent: den 25 september 2021 11:41
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] bitbake-worker: Allow shutdown/database
> flush of pseudo server at task exit
>=20
> We have a problem where pseudo server processes exist ater bitbake exits

ater -> after

> and hold the pseudo database in memory. In a docker container, the proces=
ses
> wll be killed as the container is destroyed with no warning and no opport=
unity

wll -> will

> to write the data to disk. This leads to permissions/inode corruptions an=
d
> data loss.
>=20
> Send a shutdown message to pseudo which in new versions of pseudo will fl=
ush
> the database, thereby fixing some of the issues people using docker conta=
iners
> see.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bin/bitbake-worker | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 6ead2da6d1..24dadd997c 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -17,6 +17,8 @@ import signal
>  import pickle
>  import traceback
>  import queue
> +import shlex
> +import subprocess
>  from multiprocessing import Lock
>  from threading import Thread
>=20
> @@ -146,6 +148,7 @@ def fork_off_task(cfg, data, databuilder, workerdata,
> fn, task, taskname, taskha
>      # a fork() or exec*() activates PSEUDO...
>=20
>      envbackup =3D {}
> +    fakeroot =3D False
>      fakeenv =3D {}
>      umask =3D None
>=20
> @@ -165,6 +168,7 @@ def fork_off_task(cfg, data, databuilder, workerdata,
> fn, task, taskname, taskha
>=20
>      # We can't use the fakeroot environment in a dry run as it possibly
> hasn't been built
>      if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not
> dry_run:
> +        fakeroot =3D True
>          envvars =3D (workerdata["fakerootenv"][fn] or "").split()
>          for key, value in (var.split('=3D') for var in envvars):
>              envbackup[key] =3D os.environ.get(key)
> @@ -283,7 +287,12 @@ def fork_off_task(cfg, data, databuilder, workerdata=
,
> fn, task, taskname, taskha
>              try:
>                  if dry_run:
>                      return 0
> -                return bb.build.exec_task(fn, taskname, the_data,
> cfg.profile)
> +                ret =3D bb.build.exec_task(fn, taskname, the_data,
> cfg.profile)
> +                if fakeroot:
> +                    fakerootcmd =3D
> shlex.split(the_data.getVar("FAKEROOTCMD"))
> +                    bb.warn("Shutting down pseudo")
> +                    subprocess.run(fakerootcmd + ['-S'],
> capture_output=3DTrue, check=3DTrue)
> +                return ret
>              except:
>                  os._exit(1)
>          if not profiling:
> --
> 2.32.0


