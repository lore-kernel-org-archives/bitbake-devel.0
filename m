Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F41E7E625
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 11:30:42 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.16464.1695727832076350028
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Sep 2023 04:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AofojAKX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4053cf48670so73521665e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695727830; x=1696332630; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVLz8AqcZ8a+auzeN/dGwmXstueJavMjz2eJ232lX9k=;
        b=AofojAKXOfZUL6FymQyiOg1Hw196drbTVcTwEBir8T15s3fsWBiXyOWTXOtWOWuSDJ
         6yNdIFtiGPOBPWBFEqm340iUVZoSXiNZutNCa8wQHRoAXygtlN+qaO2DTcAkR/yMxddY
         QySSU2vBc5eq0NmOD/k144BPTxxMLHIkax1lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727830; x=1696332630;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iVLz8AqcZ8a+auzeN/dGwmXstueJavMjz2eJ232lX9k=;
        b=SbS3dblqRxNQ3cXdUpZwbmNLTZmTLIg4tG6oNl58SR9KWDZkPW/NuSbzCQr69HBZvM
         PfjlKy3Zn5xea6O4vt4NRN/BNELJrnoeYVC5h4yv9Y8t0kfPoc9PNTM07oVqX3N5zQes
         zaBV6831DtA5pJJz61YsE50+jNt6MMHr0ITWXme1HWK+M8bYsEmostxdSDNDZz2q66wU
         mL1rQ+EvTEwNtW0PZUGJp6VglKA5fDDjceuR/5JZbOO0OWGos8XJyy9jeTe3YrM1x89C
         qFi/FHNG/mbEkB7Zlc2krq7LNXKvTcpd1Enff/RXL35zm/GU6NuayPl9cJRkEQ9VpgBy
         yGlg==
X-Gm-Message-State: AOJu0YwCRoylPJbDqgKSkVf1LAQSBVbfU+ozxNsvsZtXONwBJ6z4otAY
	PH1x5S8FVBc0kJ/FaGlv3MBtWR0YY1LOL666NPg=
X-Google-Smtp-Source: AGHT+IHLlGWrXupDVPCUrBRd80atIzMGpOs26J2cIST0kL68bCt+8xbOs1bNayhYEpDwjCJ4GcwMEQ==
X-Received: by 2002:a5d:498b:0:b0:31a:ccc6:b8de with SMTP id r11-20020a5d498b000000b0031accc6b8demr7693561wrq.50.1695727830329;
        Tue, 26 Sep 2023 04:30:30 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:25bd:4a27:c3da:a228? ([2001:8b0:aba:5f3c:25bd:4a27:c3da:a228])
        by smtp.gmail.com with ESMTPSA id k10-20020adfd22a000000b0032320a9b010sm6594301wrh.28.2023.09.26.04.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:30:29 -0700 (PDT)
Message-ID: <9fffc17ec1ff6a4248f5d9eb8cd6a7243f93d899.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] runqueue: Fix task execution
 dependency issue
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Gowrishankar Saminathan <gowrishankarstg@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 26 Sep 2023 12:30:29 +0100
In-Reply-To: <20230924203958.35361-1-gowrishankarstg@gmail.com>
References: <20230924203958.35361-1-gowrishankarstg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 11:30:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15130

On Mon, 2023-09-25 at 02:09 +0530, Gowrishankar Saminathan wrote:
> When the recipe metadata is updated, and the Sstate cache remains unchang=
ed,
> a problem arises where tasks dependent on this particular task are found =
in
> both the 'covered' and 'notcovered' lists within the runqueue.
>=20
> For instance, consider the example of 'base-passwd.bb:do_populate_sysroot=
',
> which serves as a dependent task for both 'systemd.bb:do_populate_sysroot=
' and
> 'dbus.bb:do_populate_sysroot.' Due to the lack of ordered task ID storage=
 in the runqueue,
> it often leads to the execution of 'systemd.bb::do_populate_sysroot' prio=
r to
> 'base-passwd.bb:do_populate_sysroot.' This results in 'systemd.bb:do_popu=
late_sysroot'
> being erroneously flagged as 'notcovered' by the runqueue.
> Nevertheless, sstate later marks it as 'covered' if there is no change in=
 the task output.
>=20
> To address this issue, this commit enhances the runqueue to store task ID=
s in an ordered list,
> ensuring tasks are carried out in their correct dependency order.
> This adjustment will execute 'base-passwd.bb:do_populate_sysroot' as the =
initial
> task and then 'systemd.bb:do_populate_sysroot.'
> This strategic execution ensures that 'systemd.bb:do_populate_sysroot' wo=
n't
> receive an incorrect 'notcovered' status, as 'base-passwd.bb:do_populate_=
sysroot'
> will have already been executed beforehand.
>=20
> Signed-off-by: Gowrishankar Saminathan <gowrishankarstg@gmail.com>
> ---
>  lib/bb/runqueue.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index c40a3be2..446b1667 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1789,7 +1789,7 @@ class RunQueueExecute:
>          self.sq_live =3D set()
> =20
>          self.updated_taskhash_queue =3D []
> -        self.pending_migrations =3D set()
> +        self.pending_migrations =3D []
> =20
>          self.runq_buildable =3D set()
>          self.runq_running =3D set()
> @@ -2422,7 +2422,7 @@ class RunQueueExecute:
> =20
>      def process_possible_migrations(self):
> =20
> -        changed =3D set()
> +        changed =3D []
>          toprocess =3D set()
>          for tid, unihash in self.updated_taskhash_queue.copy():
>              if tid in self.runq_running and tid not in self.runq_complet=
e:
> @@ -2492,7 +2492,7 @@ class RunQueueExecute:
>                      #logger.debug("Task %s hash changes: %s->%s %s->%s" =
% (tid, orighash, newhash, origuni, newuni))
>                      self.rqdata.runtaskentries[tid].hash =3D newhash
>                      self.rqdata.runtaskentries[tid].unihash =3D newuni
> -                    changed.add(tid)
> +                    changed.append(tid)
> =20
>                  next |=3D self.rqdata.runtaskentries[tid].revdeps
>                  total.remove(tid)
> @@ -2510,7 +2510,7 @@ class RunQueueExecute:
>              if tid not in self.rqdata.runq_setscene_tids:
>                  continue
>              if tid not in self.pending_migrations:
> -                self.pending_migrations.add(tid)
> +                self.pending_migrations.append(tid)
> =20
>          update_tasks =3D []
>          for tid in self.pending_migrations.copy():

Thanks for the patch. Which release of bitbake did you find this issue
with? There were fixes for issues like this which were made in master.
I'm worried this patch was developed against an older release and isn't
applicable to master.

Cheers,

Richard


