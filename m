Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3488D609DE
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 19:18:19 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2093.1765912697994922829
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Dec 2025 11:18:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DxwSNcdP;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88a346c284fso28739806d6.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Dec 2025 11:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765912697; x=1766517497; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6k4ogg30Y+OgVr7I3TqKBeq9JfxXwqEOuY7LkQNxkA=;
        b=DxwSNcdP5/kCZ0JVyFj9doVQ9FqSzKCQl3YzP8F0lQ/jTTFS2DsojeAUfFh8p6OYPC
         xd0b8UapERYwkabHtDgwn4PkeKSrxssqjbMqeUoQ8cXsCsaA2eHscCQgEwzOOMzkhXuW
         20tUTyIcJ6yo0QpBPEo/WBE5eFwJjB0WKaFX9RgfUt1EnsSVG46hlVNQUF55/nilHaDQ
         1T5LfTctjKmtwW1zeFARNidvRY/Q4qfLy0fyocwYdJd75kGptb2g7nqbnL7kEeUM1+xX
         IhVUQyQXtWUbrta5l9CyosIsviGEHQn4Vg9atI10ortciBgjxpbqUkKw23TFmugnNGU0
         j50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765912697; x=1766517497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6k4ogg30Y+OgVr7I3TqKBeq9JfxXwqEOuY7LkQNxkA=;
        b=iB1T+7+LoVpLwtYByWq6YW2VuC1e8sDZpCylRPy0y3zB1Hq4BYXGo9vT6bi6I7zUkz
         wlLLOeZVmvPWwAU6TlnMg2pihbS6xyK6Rf7KDTA/MRK6YDQmHcm4x06dGB2MiIUEUmqy
         nxhhyNaJFInIiftLDTB6awbu6RMC7l6UiMus4JJnG5hg/UfoFAYiLyfr8RW/biKSmMcT
         icqcXG2T7CVpdqK046bNnTcP3KTKjmOjBHeGouvQ6tX03+ZyrD6xNHFMYDfQE19rswij
         UfDJQ6chgfpNCu6GLsgP0f12dN6IwaxstyCl+XN0lIALyGhwRx0vlEYPeceq5CQYDA0/
         PeBg==
X-Gm-Message-State: AOJu0Yyf8TPBeuBtEIn2HY1rBcKmc+yumEN9CrzXDIJoeyHYWbvySX6g
	9OTBTRsxDyZsmXM3bfN3+Fz3wmXlKz7pvehE2Ayo4t4ulQogkSO4iLxdVELOZv2JQxxeG54wk6Z
	8ooECkUKNGFy8/OgJmb9d5QHGmanCMxg0NA==
X-Gm-Gg: AY/fxX5U6mOwg0cX0CYBXLqlW26NEXRKsZNNm/P2ykTBwXTy8vg+mpLpOu9BIRfLKrg
	YG0NwGbFxAJRDP88z0P1WADapG7gRO4TK2GN+F9guIT2HPxnq+w/TbgMQ6z9qALEbNTDMf5Ow32
	qQwTFvYKx7Bn6PcrGF3qRF+QhupHBG/5X0tF1Bb3cAAFFD8ZKptf1TOa6xHKlvu671Nk3OBgE+B
	wKbMgKzDsmqFzJHZrrfDITu92/w0pLhufO+zVHT9WrkNszotB/9gQSXySZU6mLm7GpBhIsn2q5a
	x5USwJCUIRshBOIC9q0J61nxXqLnaQ==
X-Google-Smtp-Source: AGHT+IF+EegmUU0vY6Uh/sY1rcWwRzkd0jOfvIHgbxJm57Q7ns47oR8ahnhi8VHyUiNqworTzCSaeJk4f/Lb0UHsdW4=
X-Received: by 2002:a05:6214:2c10:b0:880:5a06:3a64 with SMTP id
 6a1803df08f44-8887e169dcbmr263382826d6.66.1765912696865; Tue, 16 Dec 2025
 11:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20251215103256.902711-1-corentin.guillevic@smile.fr>
 <CANNYZj_4XFj2Sgv1Q4_=BwDBCAtCpj5X=XfQ2=CuiJjoqOrA4w@mail.gmail.com> <CAMFqQmq8G-JLzZ6zfkrXThSnCYQq16jjLY0spUhOrHv+=xA0DQ@mail.gmail.com>
In-Reply-To: <CAMFqQmq8G-JLzZ6zfkrXThSnCYQq16jjLY0spUhOrHv+=xA0DQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 16 Dec 2025 20:18:05 +0100
X-Gm-Features: AQt7F2oDZHzss8vCxD17d9p3pQkG7TzlF5Ik_WYa2uq4jR5oWZaNjqZMrg1PHd0
Message-ID: <CANNYZj8yH_5zB7rR=Xu-gb5B7XJe65yaeW9m4E23zz9f1vBegg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/3] bitbake-setup: add inline URI
To: Corentin GUILLEVIC <corentin.guillevic@smile.fr>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Dec 2025 19:18:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18602

On Tue, 16 Dec 2025 at 17:11, Corentin GUILLEVIC
<corentin.guillevic@smile.fr> wrote:
> However, what is it expected of the registered remote(s) once the source =
has been cloned? When using several remotes for one source, I discovered th=
at they are all cloned but only one is registered in the final layer (in th=
e layers/ directory). For example, we can add another remote to the bitbake=
 layer in the 'oe-nodistro-master' configuration, but this results in only =
one remote in bitbake-builds/oe-nodistro-master/layers/bitbake/.

Hello Corentin,

bitbake-setup is using bitbake's git fetcher to perform fetch/unpack:

        fetcher =3D bb.fetch.Fetch([src_uri], d)
        fetcher.download()
        fetcher.unpack(dir)

 and I think that doesn't have support for multiple remotes that
unpack into the same directory.

It isn't entirely clear how to map multiple remotes (when specified in
json) into bb-setup's behavior, but I think the current behavior at
least makes sure they're all cloned into DL_DIR, so DL_DIR has a local
copy for all of them. We could probably add some after-the fact 'git
remote add <some-remote> ...' operation to the directory that gets
unpacked by the fetcher, but that's a separate issue, and probably a
fairly marginal use case. I have a hunch almost everyone will put just
one remote per source into the json config.

Alex

