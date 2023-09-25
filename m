Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BBFCE7A89
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 09:22:20 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.56986.1695633736506999669
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Sep 2023 02:22:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LhQZyil4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-31ff985e292so5634786f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695633735; x=1696238535; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikfEfmBrPvWEXZ8Uy6WGpzVyAdJPyzZ2daUuYq8IrN4=;
        b=LhQZyil4Jf1waVZGvDbsKkE6aKOY/agyqi/BtxGm7lPJqpf0jc+FpOa4Pcw3ADywYw
         JP97N7uIt30HJdn47IzOfdGWkvF0uJNIeI0VW4/tZ0Rw7aIeApLImkCDfv/BidCAme6T
         ifur7vRmSTO0UzCjCFgakgOxq6MvI1cYsxTr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695633735; x=1696238535;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ikfEfmBrPvWEXZ8Uy6WGpzVyAdJPyzZ2daUuYq8IrN4=;
        b=C22WmrFLgCkXQkWswU9qIeRmoduD4BrXj1kDYWRyLOnu03LsZnXwHEb24z64UH/Soz
         EMDjFV4yTuLk3P1bVcLn+Gb3SotqFidurL7dHhA3t1tSzkbrSK4I3qys+sMzz/lRdNMG
         MnlYnJbR0poxew+2FxBQK+lO0we+UFKHwbgF2iSc03xkJCZ9Xez4Rl256zQxxbv0HNtO
         ybpZ4mLH/Zsi0JYHVegYlHesepTeFe6TuUUbhCvmPDhc1qYTSmZRzp9Gy1YSPbzT2Uaj
         /7ZNUZx69dYPUUPpCmHTxZJAgNU00e/NlehV2iQlnqUQg21ig6RdlLF/RaqHZ4NJNmQG
         hZ9w==
X-Gm-Message-State: AOJu0Yz6T6/bBYc644X125RFNFKPIK7cfA5Z3+WTjtQ2lNfmrRS/RQfL
	/5xa34oTaDrvK0yNwzpIcFjDTw==
X-Google-Smtp-Source: AGHT+IGbuDlsmwUmmJlst8Uj0Sqyyqc5L6Y72/N/VWeniTmT535f/9uYwX8DfbqR2QxTePOUWpfKZA==
X-Received: by 2002:a05:6000:1c7:b0:320:6f4:a200 with SMTP id t7-20020a05600001c700b0032006f4a200mr5976273wrx.10.1695633734795;
        Mon, 25 Sep 2023 02:22:14 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:dc0c:9197:530a:4339? ([2001:8b0:aba:5f3c:dc0c:9197:530a:4339])
        by smtp.gmail.com with ESMTPSA id a3-20020a5d4d43000000b003177074f830sm11438032wru.59.2023.09.25.02.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 02:22:14 -0700 (PDT)
Message-ID: <2dfb0d4ca6650781ad55e6ba164da4e40d7b41f7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not output anything
 with --value and undefined variable
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 25 Sep 2023 10:22:13 +0100
In-Reply-To: <20230925032246.1316597-1-pkj@axis.com>
References: <20230925032246.1316597-1-pkj@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 09:22:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15114

On Mon, 2023-09-25 at 05:22 +0200, Peter Kjellerstedt wrote:
> Rather than outputting the string "None" when an unknown variable is
> used together with --value, output nothing. This is consistent with the
> no --value case where only a comment stating that the variable is not
> known is output.
>=20
> This also means it is now possible to differentiate between an undefined
> variable and an empty variable since the empty variable will be output
> as a linefeed.
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/bin/bitbake-getvar | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
> index 4a9eb4f311..806bbd8e4e 100755
> --- a/bitbake/bin/bitbake-getvar
> +++ b/bitbake/bin/bitbake-getvar
> @@ -43,9 +43,12 @@ if __name__ =3D=3D "__main__":
>          else:
>              tinfoil.prepare(quiet=3D2, config_only=3DTrue)
>              d =3D tinfoil.config_data
> +        value =3D None
>          if args.flag:
> -            print(str(d.getVarFlag(args.variable, args.flag, expand=3D(n=
ot args.unexpand))))
> +            value =3D d.getVarFlag(args.variable, args.flag, expand=3D(n=
ot args.unexpand))
>          elif args.value:
> -            print(str(d.getVar(args.variable, expand=3D(not args.unexpan=
d))))
> +            value =3D d.getVar(args.variable, expand=3D(not args.unexpan=
d))
>          else:
>              bb.data.emit_var(args.variable, d=3Dd, all=3DTrue)
> +        if value is not None:
> +            print(str(value))

Whilst I can see where you're going with this, I'm worried users will
be confused by it.

getVar within bitbake returns None for things which do not exist. Not
many users will notice the difference between linefeed output and no
linefeed. It might be better to do something more obvious like an error
exit code but that also has challenges. Variables not existing when the
user expects them to is something we need to make really clear.

It was issues like this which stopped us implementing bitbake-getvar
for a lot of years too :/.

Cheers,

Richard

