Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73965E7AD74
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 15:57:13 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.111947.1696348623250973468
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 08:57:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YqZaORQd;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50336768615so1308436e87.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696348621; x=1696953421; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0d0ZtIZ3AZejOyVmU6xLp/XW2qmtA+7tE0RbPYNvMkY=;
        b=YqZaORQdVfwIv44zOdil+eR3F1jcosBdqGW/CpRfbC+uzVcyEQS9B60O/fpakJSYwH
         K2+HFjr8t/L4QD3rPm7DBIMWcLv2pHxX9n8zyBnMQx46Q2QuZ3aITk8BUz53Ak3xxJvD
         bAAvMVi8WJM7j4PtXd+ayRIKlgwrZ9RUrwB9yNoGzQTG9Xb9eLJ/pmDV/1nE3rrQyDTZ
         DEVuxqj8bYigI0TBovoMQ0+yqQxYGu9F3L6t0ixqNUzZ9S0VxOHyJ1aBtATJeXFiQO0R
         5t+7j+qt9rMC4ddMQctS35W+TeEN447ssGWUJ6vwoII7LeOXgb/qb6j7NT3OGynbrlIy
         QgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348621; x=1696953421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0d0ZtIZ3AZejOyVmU6xLp/XW2qmtA+7tE0RbPYNvMkY=;
        b=OETxf6zKRIvg+kno8o9DUMFdfKbOdCLhkx/eG9K7nqYNCEsZvkSuVNfPR1Pr1/ZaPg
         ihH4wzgxgUkWKqBb/HoPN10lPUoBnam80ctvWCpxPrtW+v2k0fGTMwqPlgtMgkSZl3fs
         f3bsmL4TnVZO0AzseZ8W19fJAMFURKe+1+I/ibctuKDM5TlYJSbFWiWhNs6TpZNa6z7z
         7aWoi7bZBs8ycoDA40YXCQRD7A6pWR5bnxey8pXV3XSE23E5ielIALeUVI49iV4OWiwc
         rGUNTgt2Z9O5he9v/RFsuvKi7howYsr8oHUGG6EDW+DraRs3iC7EuJeqUzMjDyfdDkzb
         0aZQ==
X-Gm-Message-State: AOJu0YyeaI/IX2D6gAYpRqKw0qweUWQ+RH7zfDVPMOsD3xkPnNGtKao6
	YwdlS/hLRoSSC1D6gLEfhe2ue1eVkVnIxpX1yYg=
X-Google-Smtp-Source: AGHT+IEQT2G8qF+vZ6MU23gAW8nTLOa409IjM4fVUJq03CoAcZ0yUTRFHU+B09iFvgZcY4/VtQ14T/L78OjlZj/i1bk=
X-Received: by 2002:ac2:57c5:0:b0:503:3447:b704 with SMTP id
 k5-20020ac257c5000000b005033447b704mr10829097lfo.0.1696348621079; Tue, 03 Oct
 2023 08:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230929123706.454384-1-karim.benhoucine@landisgyr.com>
In-Reply-To: <20230929123706.454384-1-karim.benhoucine@landisgyr.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 3 Oct 2023 09:56:49 -0600
Message-ID: <CAJdd5GY4Z004TT9f3n+q3GZo8qKF_FyehEfWO_xENd-WH=nkKw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] hashserv: Fix read-only mode.
To: "Ben Houcine, Karim" <Karim.benhoucine@landisgyr.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 15:57:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15174

On Fri, Sep 29, 2023 at 6:37=E2=80=AFAM Ben Houcine, Karim
<Karim.benhoucine@landisgyr.com> wrote:
>
> Signed-off-by: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
> ---
>  lib/hashserv/server.py | 55 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> index d40a2ab8..56d76f1f 100644
> --- a/lib/hashserv/server.py
> +++ b/lib/hashserv/server.py
> @@ -180,7 +180,11 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection=
):
>              'get-stats': self.handle_get_stats,
>          })
>
> -        if not read_only:
> +        if read_only:
> +            self.handlers.update({
> +                'report': self.handle_readonly_report,
> +            })
> +        else:
>              self.handlers.update({
>                  'report': self.handle_report,
>                  'report-equiv': self.handle_equivreport,
> @@ -453,6 +457,55 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection=
):
>
>          self.write_message(d)
>
> +
> +    async def handle_readonly_report(self, data):
> +        with closing(self.db.cursor()) as cursor:
> +            outhash_data =3D {
> +                'method': data['method'],
> +                'outhash': data['outhash'],
> +                'taskhash': data['taskhash'],
> +                'created': datetime.now()
> +            }
> +
> +            for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginf=
o'):
> +                if k in data:
> +                    outhash_data[k] =3D data[k]
> +
> +            # Check if outhash is known
> +            cursor.execute(
> +                '''
> +                SELECT outhashes_v2.taskhash AS taskhash, unihashes_v2.u=
nihash AS unihash FROM outhashes_v2
> +                INNER JOIN unihashes_v2 ON unihashes_v2.method=3Douthash=
es_v2.method AND unihashes_v2.taskhash=3Douthashes_v2.taskhash
> +                -- Select any matching output hash
> +                WHERE outhashes_v2.method=3D:method AND outhashes_v2.out=
hash=3D:outhash
> +                -- Pick the oldest hash
> +                ORDER BY outhashes_v2.created ASC
> +                LIMIT 1
> +                ''',
> +                {
> +                    'method': data['method'],
> +                    'outhash': data['outhash'],
> +                    'taskhash': data['taskhash'],
> +                }
> +            )
> +            row =3D cursor.fetchone()
> +            if row is not None:
> +                # outhash is known =3D> corrects unihash
> +                unihash =3D row['unihash']
> +            else:
> +                # outhash is unknown =3D> nothing to do
> +                unihash =3D outhash_data['taskhash']
> +
> +
> +            d =3D {
> +                'taskhash': data['taskhash'],
> +                'method': data['method'],
> +                'unihash': unihash,
> +            }

Actually, I looked into this more and the above query is wrong. What
we actually want is to call self.get_unihash() because that's all that
the function would do anyway if the outhash wasn't inserted.
Basically, take the last few lines of handle_report to a new function
that can be called in the "report" RPC call when read-only

> +
> +        self.write_message(d)
> +
> +
>      async def handle_equivreport(self, data):
>          with closing(self.db.cursor()) as cursor:
>              insert_data =3D {
> --
> 2.25.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15149): https://lists.openembedded.org/g/bitbake-deve=
l/message/15149
> Mute This Topic: https://lists.openembedded.org/mt/101656393/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

