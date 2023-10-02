Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752E4E776C4
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 20:49:28 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.93896.1696279767732872809
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Oct 2023 13:49:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HOu3HBym;
 spf=pass (domain: gmail.com, ip: 209.85.167.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-504b84d59cbso158577e87.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Oct 2023 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696279766; x=1696884566; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXa/HykbT0kmeUHeQ5ICX9YJ4YKXDZ4x6325CTe6vT0=;
        b=HOu3HBymhd2Yn7ZLm9iExbmLfWV/9kHePqOcnZbb7mSrph3cW2d6SKzFTr+XPnoHAI
         1yxEgEE5GgEfE0SO+vYdVvntUKwij5DTWD7eDj8updRW4lhNc2lSrJsEcnZf/ZG/1idT
         fmEfYCAy2jNpC6gu7wjv/erpdfLwOZWuEOTLPQN9alZsuysWk7K1FCjzRbQ3vKkm3jdU
         OKnGxuAWeFXrnfsMwXQzi0VIWmOyQR3KIPRuYuKHVGL6LojsmUU773R2FtctiGY2iBnA
         v9hEuJ5atHe65iRaemUy7iOu/BzpdnQxOTVY5tfmAE833nMXmyVW9Rlv1HnsTOHohHtG
         NOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696279766; x=1696884566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXa/HykbT0kmeUHeQ5ICX9YJ4YKXDZ4x6325CTe6vT0=;
        b=AxjrDi/2jYfVVb3oNJui3FHZjZLVbtPaHiKbKugE4QFVgIv8sj73R+ybAKxseZkd0y
         8L9IsKCx5mI9GRO8NXnBjaaJ9L5S2oh+VUjJ4bAC5V5Marqyw8vsw+5iEviLJkkijeud
         G70Ryd5jG02KIeX3UIFYqQqTOK0auMEARULWYC20ojI9RgUAZ2i4hj4ZNHtzXSDJxW3E
         vKIvIlfwxHWR/j2gHxlNT1P/7nkLGfV4ZjmEcSRwPmsAdgv6popCJHF8h39fOxeBom7O
         dweiw+T8xNBjhh4z34M8QTbW5V7SgHCiuNQvjhIu3RTcMu8qN6I5mqEcJBEBPcx27rsL
         NPEQ==
X-Gm-Message-State: AOJu0YwFU8BwB2OVgkOCbTtMMucGs9fWnGX+2E4H4ihBsgbZb3kw+HNR
	ZQH1Z0gCcZtwd0+jibYdnSEaqzaeWbMNujZjDTU=
X-Google-Smtp-Source: AGHT+IGNezsLfcENH44aKN970M3Lr/rPmz825N+lEY2DOFR2dP+r+PLPPsr4U82MMge1ftAPB07uYIlrXExHjvWAHmQ=
X-Received: by 2002:a05:6512:31d0:b0:503:186b:e0a8 with SMTP id
 j16-20020a05651231d000b00503186be0a8mr14142247lfe.60.1696279765538; Mon, 02
 Oct 2023 13:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230929123706.454384-1-karim.benhoucine@landisgyr.com>
In-Reply-To: <20230929123706.454384-1-karim.benhoucine@landisgyr.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 2 Oct 2023 14:49:13 -0600
Message-ID: <CAJdd5GZaEn9c-ZR2rtK_-Z=fp5oZXZsK2VhxHZVGqQxMJBEcyg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] hashserv: Fix read-only mode.
To: "Ben Houcine, Karim" <Karim.benhoucine@landisgyr.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Oct 2023 20:49:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15158

Seems fine to me other than the comment below and the tests being fixed.

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

All the above lines to with .. cursor are unnecessary. They are
constructing the insertion data, which is not being used here.

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

