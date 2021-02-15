Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.35455.1613413894744331168
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Feb 2021 10:31:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=AdDesPBG;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1613413895;
  x=1644949895;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VMh8wFcQsqNyO0/OOJ1djcMfnKlxVdG8XnjP/foJxBI=;
  b=AdDesPBG7Up0uiU8HmwPpjD430MsTSlCW79tq37VJZqD4iq2yKR2hp1M
   DRmMGz6rKyJ2+4HNogJii7UckKgCVlVtmwYimSkjavgpNVniF3Q+pKFN/
   atEgBN+3y5/+aMpvKbQmPU6eGShx1Hsi2OhJaGhy5Y/X4aaUDa9MI5XP9
   OFKt/GdIEm/IIi6xoBpm2ETrw81vg7r4VNyMoljFm1/8Jb2k3LYhsndVx
   R7q/xq1hthCvuoeeVIaL11zySfH+zTQo8Ik2XJ2Z8H8GrqyoVYT0uLxjs
   tcHcMh+SxCf1s52LLflppOQledrPK7eLGKTYZ4Sc1JMW+LQCJ7TAdQumP
   g==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker/runqueue: Add support for BB_DEFAULT_UMASK
Thread-Topic: [bitbake-devel] [PATCH] bitbake-worker/runqueue: Add support for
 BB_DEFAULT_UMASK
Thread-Index: AQHXAsYXLl/jI6ZjpE+akKfA4b9bNapZixxw
Date: Mon, 15 Feb 2021 18:31:31 +0000
Message-ID: <a0140273172a4572acf7ce865011a59a@XBOX03.axis.com>
References: <20210214113913.1960305-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210214113913.1960305-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie
> Sent: den 14 februari 2021 12:39
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] bitbake-worker/runqueue: Add support for=
 BB_DEFAULT_UMASK
>=20
> Currently each task has to have a umask specified individually. This
> is leading to determinism issues since it is easy to miss specifying
> this for an extra task.
>=20
> Add support for specifing the default task umask globally which
> simplifies the problem.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bin/bitbake-worker                                        | 8 ++++++--
>  .../bitbake-user-manual-ref-variables.rst                 | 4 ++++
>  lib/bb/runqueue.py                                        | 1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 6c37967513..7765b9368b 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -150,11 +150,15 @@ def fork_off_task(cfg, data, databuilder, workerdat=
a, fn, task, taskname, taskha
>=20
>      taskdep =3D workerdata["taskdeps"][fn]
>      if 'umask' in taskdep and taskname in taskdep['umask']:
> +        umask =3D taskdep['umask'][taskname]
> +    elif workerdata["umask"]:
> +        umask =3D workerdata["umask"]
> +    if umask:
>          # umask might come in as a number or text string..
>          try:
> -             umask =3D int(taskdep['umask'][taskname],8)
> +             umask =3D int(umask, 8)
>          except TypeError:
> -             umask =3D taskdep['umask'][taskname]
> +             pass
>=20
>      dry_run =3D cfg.dry_run or dry_run_exec
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 74a3eb8095..a0c56a4bc3 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -108,6 +108,10 @@ overview of their function and contents.
>        command line option). The task name specified should not include
> the
>        ``do_`` prefix.
>=20
> +   :term:`BB_DEFAULT_UMASK`
> +      The default umask to apply to tasks if specified and no task speci=
fic
> +      umask flasg is set.


Correct "flasg" to "flag".

> +
>     :term:`BB_DISKMON_DIRS`
>        Monitors disk space and available inodes during the build and allo=
ws
>        you to control the build based on these parameters.
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index b8b217c64a..54ef245a63 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1271,6 +1271,7 @@ class RunQueue:
>              "date" : self.cfgData.getVar("DATE"),
>              "time" : self.cfgData.getVar("TIME"),
>              "hashservaddr" : self.cooker.hashservaddr,
> +            "umask" : self.cfgData.getVar("BB_DEFAULT_UMASK"),
>          }
>=20
>          worker.stdin.write(b"<cookerconfig>" + pickle.dumps(self.cooker.=
configuration) + b"</cookerconfig>")
> --
> 2.27.0

//Peter

