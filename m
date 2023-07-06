Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09630EB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 08:16:19 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.16925.1688631377112239963
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Jul 2023 01:16:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=T7+hUg47;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fba74870abso468765e87.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Jul 2023 01:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1688631375; x=1691223375;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RBjN63KVWSaHJyJXJb/edOYREB91gMgWBc/eYMMHu8A=;
        b=T7+hUg47bwGDfvKuGhmpITpz5V+KUE3DEWiftGaQz6EFAk/qCfKcdgXMSrHsPL8R7f
         a2gRZ94iKuc5eJ1pZIQ5oV5mIpOSjRKzRYTHQpKexb+UlR1mrz37qGCzRZfOyL6x5BmS
         h6+wVGpfhLEnyH4zNvFlOfZoPMQjjM++ae0yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688631375; x=1691223375;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBjN63KVWSaHJyJXJb/edOYREB91gMgWBc/eYMMHu8A=;
        b=dFDzq+iFHZBbZRdLv0w6EEQ6KyZpgrqi1llOuwDxO1OXdx+Mork2L24OwZKBgTSmCq
         +ZlunC3l06fp8OQXevwPD/LFQ1FvhJmISxytXE/np3D3dEOGYKxg2fkTETuLoFe/GInS
         mx14j/QvuxhooaPNlL4wZhxBK+igFh6HmzQRe5kWcmEC6TI31gaTzfuxVeExZepd0bHz
         uCME9EpudDLSyE4xAzPAyAydrQuliWhnR3tZ3yztGHdM32Fv6150Tj+8ifuuo5mDUHJ6
         /hkY1df95bAckPLQI3vSyo82+Fpj5D0Q1uA55OkSd81yUa+nVVZ6q1pflV2pYjuPrvjv
         KHuA==
X-Gm-Message-State: ABy/qLb8hZ+F2cBvmBMQl0cDVfoHoQnXRteDb0Pu6K4sd6TziWCtIjt+
	t8gM+LsFHTUZhnzqmKBHWT9apw==
X-Google-Smtp-Source: APBJJlFH+7/R+6K2eegITGbv8c8hQUO9c/BuQHCaYEbthKLmE0WC+6iReoVY0fkKAK/1XeQa3rF1nA==
X-Received: by 2002:a19:6504:0:b0:4fb:8b78:4a93 with SMTP id z4-20020a196504000000b004fb8b784a93mr963363lfb.7.1688631375226;
        Thu, 06 Jul 2023 01:16:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:be52:cea0:32f2:b43b? ([2001:8b0:aba:5f3c:be52:cea0:32f2:b43b])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b003fbb1a9586esm4335721wmc.15.2023.07.06.01.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:16:14 -0700 (PDT)
Message-ID: <1b3ad9fe0c72c03275ec31e74bfd32750b6f3d2c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: convert deferral messages
 from bb.note to bb.debug
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Denys Dmytriyenko <denis@denix.org>, bitbake-devel@lists.openembedded.org
Cc: Denys Dmytriyenko <denys@konsulko.com>
Date: Thu, 06 Jul 2023 09:16:14 +0100
In-Reply-To: <20230705215533.327107-1-denis@denix.org>
References: <20230705215533.327107-1-denis@denix.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Jul 2023 08:16:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14876

On Wed, 2023-07-05 at 21:55 +0000, Denys Dmytriyenko wrote:
> Using multiconfig to target baremetal pieces of the system and building
> corresponding toolchains for them results in hundreds and hundreds of
> "Deferring %s after %s" and "Deferred task %s now buildable".
>=20
> To clean up the output and to reduce risk of missing important warnings,
> convert these notice messages to debug messages.
>=20
> Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> Signed-off-by: Denys Dmytriyenko <denys@konsulko.com>
> ---
>  lib/bb/runqueue.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 241a746e..a5164c9e 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1997,12 +1997,12 @@ class RunQueueExecute:
>                  # Allow the next deferred task to run. Any other deferre=
d tasks should be deferred after that task.
>                  # We shouldn't allow all to run at once as it is prone t=
o races.
>                  if not found:
> -                    bb.note("Deferred task %s now buildable" % t)
> +                    bb.debug(1, "Deferred task %s now buildable" % t)
>                      del self.sq_deferred[t]
>                      update_scenequeue_data([t], self.sqdata, self.rqdata=
, self.rq, self.cooker, self.stampcache, self, summary=3DFalse)
>                      found =3D t
>                  else:
> -                    bb.note("Deferring %s after %s" % (t, found))
> +                    bb.debug(1, "Deferring %s after %s" % (t, found))
>                      self.sq_deferred[t] =3D found
> =20
>      def task_complete(self, task):
> @@ -2940,7 +2940,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooke=
r, stampcache, sqrq):
>                  sqdata.hashes[h] =3D tid
>              else:
>                  sqrq.sq_deferred[tid] =3D sqdata.hashes[h]
> -                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]=
))
> +                bb.debug(1, "Deferring %s after %s" % (tid, sqdata.hashe=
s[h]))
> =20
>      update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker=
, stampcache, sqrq, summary=3DTrue)
> =20

You realise that we've had a long standing bug in this code, which you
have run into and asked me about fixing. The only reason we were able
to fix it is due to these kinds of debug messages? Hiding them isn't
going to make that any easier in future :(.

Cheers,

Richard




