Return-Path: <eekmecic@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913E6C001E0
	for <webhook@archiver.kernel.org>; Wed,  2 Aug 2023 11:48:38 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web11.12509.1690976916670396131
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Aug 2023 04:48:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Bdq7fXRl;
 spf=pass (domain: snapchat.com, ip: 209.85.210.51, mailfrom: eekmecic@snapchat.com)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6bca3311b4fso2634673a34.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Aug 2023 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1690976916; x=1691581716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgges+DRho4phushYTV3223z2tc79qfMiraUwzh/G6A=;
        b=Bdq7fXRlJMJY+SiZoctuhs/44pL02igz89JgVvqWuXB0O939d/QWJQlErfAZlDS6nK
         7aLIVj4cIcO8rx2fmOyToJwd2VeX2BJBKsqMmhF+Vbu7zR3ZPA2qnZJrJzz1VMf87vFc
         glJ74ma+z8wVGCOrGAkomm//rMkKLlsA5itMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690976916; x=1691581716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgges+DRho4phushYTV3223z2tc79qfMiraUwzh/G6A=;
        b=ixg4C8xSdfwE6VTs1LzcPm7IMHJWyMNx/2uYTyJI9xu4Fbk4iXv2kl8Ryb5Jq/4FRK
         wFDIFjA4C7Js6iTMyHhsTQS4GGCQ55CMjrNJw+TMo6f2I3tqm1nUrW3gQQJvE8sTirh1
         HppMSbMQY9OMF7kp/Agdmz+6fM+nEfz6Uj8wMILoiqzPD14KHsdNxSZDVmOsKfuvb2SO
         QEzw1WF4u+nl6+MkfRX9J07z892rfPs0biwC964eT8PF6Msax2Pu+5OEriZZXFnFh4E8
         C5QgsCK8weMzJBTI6nW97u9OcADViPEteSj6OoSXY1bcH+vZjYqO0oeoj4HynW7PXQoc
         c9Pw==
X-Gm-Message-State: ABy/qLZ5dB0Ty2OoAuBGGQBwqwbhwYcaad1AM0v4pB/UEp2wHNZb5ejm
	q/FRdbq10XalAXhuwUI9zqxi2FCFJzNK5jMMrFGsqA==
X-Google-Smtp-Source: APBJJlHd+HTNKtOb3TwgTsklsX8+VkA/o6qwiooYfa3ZgzwRN9nkFpUIlK9fE2ynvZL1i7zXTc+fhkndN3VJMn0wmwE=
X-Received: by 2002:a05:6870:5623:b0:1bf:1346:63e with SMTP id
 m35-20020a056870562300b001bf1346063emr4607444oao.49.1690976915781; Wed, 02
 Aug 2023 04:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230801124715.752243-1-eekmecic@snap.com> <CANNYZj8mkTBNfevYz7eWr45D2renfen5FCLc1C6pMNHpUhd03A@mail.gmail.com>
 <CACjag3tMLM_wHyVbSqD6sDHox-dCRjwNXgv-Q75bqfhLzo5eUw@mail.gmail.com> <CANNYZj-SKotv0PVL_vxcPhX-H+_q8KFQa9Hk4C2Es7kk4hKHPg@mail.gmail.com>
In-Reply-To: <CANNYZj-SKotv0PVL_vxcPhX-H+_q8KFQa9Hk4C2Es7kk4hKHPg@mail.gmail.com>
From: =?UTF-8?B?RW1pbCBFa21lxI1pxIc=?= <eekmecic@snap.com>
Date: Wed, 2 Aug 2023 13:48:24 +0200
Message-ID: <CACjag3vb-U00j2mKpGriS-WZ4srcEd0VWitfx6ix5r9yZuJ4jA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] fetch2: add Google Cloud Platform (GCP) fetcher
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Aug 2023 11:48:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14907

On Tue, Aug 1, 2023 at 7:30=E2=80=AFPM Alexander Kanavin <alex.kanavin@gmai=
l.com> wrote:
>
> On Tue, 1 Aug 2023 at 16:30, Emil Ekme=C4=8Di=C4=87 <eekmecic@snap.com> w=
rote:
>
> > I am unsure of how (if?) BitBake verifies the integrity of source
> > tarballs downloaded from mirrors. We are not using it to fetch source,
> > only prebuilt artifacts. I took a look at the other two fetchers
> > that implement support for S3 and Azure and I don't see any differences
> > in how they would handle a supply chain attack of the type you
> > described. Please correct me if I'm wrong. Likewise please let me know
> > if there's something that needs to be implemented in the fetcher code
> > to prevent such an attack.
>
> Right, I thought you had actual recipes using the fetcher.
>
> I think this bit:
>
>     def recommends_checksum(self, urldata):
>         return True
>
> will require checksumming when the fetcher is used in a recipe. I
> don't actually know for sure what happens when the fetcher is used
> from sstate code and where is the code that prevents tampering with
> sstate objects.
>
> Given that the fetcher is the same 'class' as s3/azure - seems
> primarily intended for sstate mirrors, I'm not sure if it should have
> tests in bitbake/lib/bb/tests/fetch.py. Maybe RP can clarify.
>
> Otherwise, I'm fine with this.
>
> Alex

Yes, that bit will require checksumming. My colleague =C3=89tienne Cordonni=
er
verified this by creating a recipe that uses this fetcher without
specifying a checksum, which returned the following error:

WARNING: uutils-coreutils-0.0.16-r0 do_fetch: Missing checksum for
'/workdir/downloads/sstate:wayland::1.20.0:r0::10:0004d8aa6640ecb43319a1c
2e68111d0522036c86fe0f331c1c830c0e0a30c31_populate_lic.tar.zst', consider
adding at least one to the recipe:
SRC_URI[sha256sum] =3D "16c025cd29bc9eb535676160e0edaf90832b9b07204fe0f5e
180384b66c904ab"

After adding the checksum to the recipe as indicated by the warning, the
warning message went away. Lastly, if he intentionally inputted an
incorrect checksum BitBake threw an error:

ERROR: uutils-coreutils-0.0.16-r0 do_fetch: Fetcher failure for URL:
'gs://< our internal bucket name >/00/04/sstate:wayland::1.20.0:r0::1
0:0004d8aa6640ecb43319a1c2e68111d0522036c86fe0f331c1c830c0e0a30c3
1_populate_lic.tar.zst'. Checksum mismatch!

I will create another revision of the patch that includes documentation
for the fetcher in the user manual. I will also create a patch in
openembedded-core with some small changes needed for this feature
to work. I'll ensure that I mention all the patches so that they can
be integrated simultaneously with minimal breakage should they be
accepted.

Thank you Alex for taking a look.

Emil

