Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE791C636CC
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:07:55 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.11818.1676455671296100654
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:07:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cEwaMFzA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id p5so509070wmg.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 02:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWFrTM7c/tytkk8E29MOD5hp3QKD9xp4s4ZD/Nrra/Q=;
        b=cEwaMFzA53JTQG9f4/QnmQpZXgEdtVmXwOvpYhqPaV2uaqWUURBECdB7o+iXyscB7v
         TnDoK1GLecLm2wAE/pm+ktaw6WSEj6m5U3edOL7WcMMRhH5JltAgYycwYcCB0mU17mRi
         AmC1uSd+bFdQX4Uzh0Uj15bVTq4lThdO7yg40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XWFrTM7c/tytkk8E29MOD5hp3QKD9xp4s4ZD/Nrra/Q=;
        b=Ia+I5wprHKv0rKl2hu5JwGLNDLnsuyAlQG5kpnGZDKCuj5tk/qP+ctC67ZPYYkPVTa
         IK5+f68q77uVY3UhgSkpBjpGxdKLWrbfo3FhN7kHKUhcz7irYEGaHVoOphaU9moRd9tB
         tlqII3V9g/976d9lMSKj+4elM7JGRyStElSOikq8zbqMq1mdqo9HD8SYUhqlvAnSgUB3
         DIFGwJ6wLc9G+csymQovkzIc8roMm3WshrtTzqgVoDEREd5uAaUmvOQOC3iUmw+SiORM
         0Adfc5NJphjhrAm3uSuYWbW/9g3/uX5yp2a21VTTo3KkEBO9FurFgg+L+9ywOzF5MRZ0
         tMEg==
X-Gm-Message-State: AO0yUKXYlM3f8j23HfEBcmEHZXvZHJFw6Diy1CYSQpGWox6unwbTNtf7
	86MvjfKDXEkrPVoJx89h48iKl974ohxz7B65
X-Google-Smtp-Source: AK7set+fZwQWwwSuArIBT5Apll3Nvx7wuD0/XtZ/CEAJ3PJx925jOpcfLFvSHVt+SC5vArFdhe+EPw==
X-Received: by 2002:a05:600c:2ad6:b0:3df:eea8:1fe5 with SMTP id t22-20020a05600c2ad600b003dfeea81fe5mr1459979wme.14.1676455669350;
        Wed, 15 Feb 2023 02:07:49 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:fcb8:24dc:acf7:61c1? ([2001:8b0:aba:5f3c:fcb8:24dc:acf7:61c1])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c4f9400b003e200dc15f5sm1463333wmq.42.2023.02.15.02.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 02:07:48 -0800 (PST)
Message-ID: <fafd04281c6ac41f410a7217ac8983746a534abe.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [bitbake][PATCHv2 1/2] action.py: add BBPATH in
 bblayers_conf path for add-layer
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Pedro Baptista <pedro.miguel.baptista@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 15 Feb 2023 10:07:48 +0000
In-Reply-To: <20230213135525.3650-1-pedro.miguel.baptista@gmail.com>
References: <20230213135525.3650-1-pedro.miguel.baptista@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:07:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14423

On Mon, 2023-02-13 at 13:55 +0000, Pedro Baptista wrote:
> From: Pedro Baptista <pedro.miguel.baptista@gmail.com>
>=20
> By including the full path to bblayers.conf the add-layer
> command can be executed from any location, not only from the
> build directory.
>=20
> Signed-off-by: Pedro Baptista <pedro.miguel.baptista@gmail.com>
> ---
>  bitbake/lib/bblayers/action.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action=
.py
> index 454c251410..a2208db0bc 100644
> --- a/bitbake/lib/bblayers/action.py
> +++ b/bitbake/lib/bblayers/action.py
> @@ -37,7 +37,7 @@ class ActionPlugin(LayerPlugin):
>                  sys.stderr.write("Specified layer directory %s doesn't c=
ontain a conf/layer.conf file\n" % layerdir)
>                  return 1
> =20
> -        bblayers_conf =3D os.path.join('conf', 'bblayers.conf')
> +        bblayers_conf =3D os.path.join(os.environ['BBPATH'], 'conf', 'bb=
layers.conf')
>          if not os.path.exists(bblayers_conf):
>              sys.stderr.write("Unable to find bblayers.conf\n")
>              return 1

Whilst that is an improvement, I was really suggesting using something
like lib/bb/cookerdata.py:findConfigFile() as done in findTopdir() in
that file.

That way we use the same behaviour everywhere.

Cheers,

Richard


