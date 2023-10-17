Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED879CDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 13:47:48 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.215454.1697550461681198242
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Oct 2023 06:47:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BbdcK0zn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-307d58b3efbso4607151f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697550460; x=1698155260; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=elpUOyHy7AhRgEtOMD3WU40Z5yviAOdkaaLFpc4i4cA=;
        b=BbdcK0zncRPIq5Z8/KXnEU2yrSG32704EmnC36MKqmHCYPROg1QTgi5B5oVsLm3igN
         qCZLqV/752lQsCud1xZLzLNql1ck0vmRfLL91IdmWNjGVZIf5Wca0D2OM2aAWJw6uZyK
         F800rCqXxaq0xxu6zjjXnZmsE3xzIm9r09LRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697550460; x=1698155260;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elpUOyHy7AhRgEtOMD3WU40Z5yviAOdkaaLFpc4i4cA=;
        b=WeZqb1EetHPHcQT1kLRwtJQoSPF6VQpL3tQ9+9yPyFQRuL9g5YNhp1Vo9va837HxwH
         8Kd4WZhBei7VMDznEoI0JJv72s9crDRenhpWvCASMkWka9itd5TMA4yCvHspt/zBrE3I
         BixFDzuOI+7a8jhhQiRC2PXOAoZ0n+60YQdNV4asA8tVy3rI7txl4pS/jf8o/vBJQfq6
         pRLKnnH2KClfQ+kWyh4tqjrv+q22K12ZJLI08v/0q6iMSWyQslb+yIgS+2qw8bLJlqvT
         D6v/43O6wnQhSqHvWlT2M5rg6E6J5v+9G77h/w+LFXt6J+Iis7FerC/3xepabhiOPbQu
         gbUg==
X-Gm-Message-State: AOJu0YymdyDGbwiY6cmhY+b5JQJk99wxr+UZ2SlrR23iPKpbd9mU4Vp/
	nj3z+M6wfXKBLHfWHJN7ZzS7qA==
X-Google-Smtp-Source: AGHT+IFMjf1eHEaOZk2AwGyg6H1TaRT+YWvaR14rtgvd4ckW9QuoiULmz5uA6YLoRWBJcl5TgDDO9w==
X-Received: by 2002:a5d:66d0:0:b0:32d:7bb1:b05e with SMTP id k16-20020a5d66d0000000b0032d7bb1b05emr1831149wrw.42.1697550460074;
        Tue, 17 Oct 2023 06:47:40 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:81eb:8695:fc05:9038? ([2001:8b0:aba:5f3c:81eb:8695:fc05:9038])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d5187000000b0032da8fb0d05sm1716131wrv.110.2023.10.17.06.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:47:39 -0700 (PDT)
Message-ID: <25cfc0baf8ba2e9b498c3ed6068fc030a24880e8.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue.py: clarify that 'closest'
 signature means 'most recent' (and not closest in its content)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Tue, 17 Oct 2023 14:47:38 +0100
In-Reply-To: <20231017133029.146956-1-alex@linutronix.de>
References: <20231017133029.146956-1-alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 13:47:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15252

On Tue, 2023-10-17 at 15:30 +0200, Alexander Kanavin wrote:
> This is printed by 'bitbake -S printdiff' and more accurately reflects wh=
at
> the code does.
>=20
> Most of the time the most recent item should be what the user wants to se=
e when debugging sstate
> misses, but there could also be printdiff-all (print differences with all
> matching sstate objects), or printdiff-N (N most recent, and not just the=
 latest).
>=20
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bitbake/lib/bb/runqueue.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 56147c50a8a..28b9667c47c 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1769,7 +1769,7 @@ class RunQueue:
>                  latestmatch =3D sorted(matches.keys(), key=3Dlambda f: m=
atches[f])[-1]
>                  prevh =3D __find_sha256__.search(latestmatch).group(0)
>                  output =3D bb.siggen.compare_sigfiles(latestmatch, match=
, recursecb)
> -                bb.plain("\nTask %s:%s couldn't be used from the cache b=
ecause:\n  We need hash %s, closest matching task was %s\n  " % (pn, taskna=
me, h, prevh) + '\n  '.join(output))
> +                bb.plain("\nTask %s:%s couldn't be used from the cache b=
ecause:\n  We need hash %s, most recent matching task was %s\n  " % (pn, ta=
skname, h, prevh) + '\n  '.join(output))
> =20
> =20

One of the reasons I don't like this code is that matching "policy"
comes from 'distant' files and runqueue really doesn't know much about
this.

The patch is probably ok but long term we need to handle this better
and in a way which means if we can improve the matching, the message
and code are more spatially related.

Cheers,

Richard

