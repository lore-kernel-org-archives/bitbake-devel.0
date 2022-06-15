Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38D5C43334
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 07:23:33 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web09.1738.1655277808292597305
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jun 2022 00:23:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Qj4521Nv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id m24so14057514wrb.10
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jun 2022 00:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=Vr4uLi8MLAlE4Iqevd2lm2jBAhIfID+Yo/taOapsa2c=;
        b=Qj4521NvYOREK5ccFJygZ0On36fraT0st7e0Bt0U6ppj3MFW1YHenRfVAPAd8y/Gj1
         xmhF9VbrZm57Au5UE30zdnl2nD0tyOvlwl4BXueB3PT9ZMt87JQpr7iOJQpfEMeAsGYY
         p741UWcOcj5+za8n3bGEIS41x52IkDYoU9ifc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Vr4uLi8MLAlE4Iqevd2lm2jBAhIfID+Yo/taOapsa2c=;
        b=ghTcP4uGPiQ80sBTYYuu9PKHe+fdFxkiDcoTcjyFA9aJwZZGHTEvpbsVrrZbxMmDJV
         HqgN/HO/3WjxyacqkvYGLAhTZHMwVMdoxWUvVdDUBFuysHE+SHzsGoMZeNn0YTT/ZLM0
         zds30v7gwxRZmC5TcaxnvIXsLzK1/KFFkX3uAHkPMqnGvCAh9CGcQnYrRklB/yOVNuzR
         vixUbGWfDMNkvUN84MXWXQ+emGMwBwG38czzEb7saKiI03LM72cp9cuIynbQqVuMqgGq
         Hz1Vl3I+ruN+gTxn6PZVaJGGqQNkFfk/5evBBHTT6QgThXpDl7roYZjNAmVJ9DG2aTsJ
         8fuA==
X-Gm-Message-State: AJIora9b8FPiK3rzj9JzqzLHzIHypTzyO6U5FsH9QHtkD4FvWa/wEDGj
	efGhn0ZracNTYX3U4qXUHHeopg==
X-Google-Smtp-Source: 
 AGRyM1sIGw/Tw0JTdbr4lY/vXERTDeWKiP2erWVWSfXRjhinp3zWom/6VriQR3ZM8E7TymgvBM6BZw==
X-Received: by 2002:a05:6000:152:b0:216:160:2e60 with SMTP id
 r18-20020a056000015200b0021601602e60mr8448923wrx.663.1655277806517;
        Wed, 15 Jun 2022 00:23:26 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5217:2b74:ee57:d3bc?
 ([2001:8b0:aba:5f3c:5217:2b74:ee57:d3bc])
        by smtp.gmail.com with ESMTPSA id
 c6-20020a5d4146000000b00213ba3384aesm14604052wrq.35.2022.06.15.00.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 00:23:26 -0700 (PDT)
Message-ID: 
 <d4dd89aa32ad3c7829d8f79e11bd35486397a9c9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v4] bitbake-user-manual: Correct
 description of the ??= operator
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Date: Wed, 15 Jun 2022 08:23:25 +0100
In-Reply-To: <20220615042424.7606-1-jacob.kroon@gmail.com>
References: <20220615042424.7606-1-jacob.kroon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Jun 2022 07:23:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13763

On Wed, 2022-06-15 at 06:24 +0200, Jacob Kroon wrote:
> Stating that the assignment is done at the end of parsing is misleading.
> The weak default value is the value which a variable will expand to if no=
 value
> has been assigned to it using any of the assignment operators.
>=20
> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> ---
>=20
> Changes in v4:
> * Mention that "??=3D" operator overrides previously defined weak default=
 values
> * Add examples when appending/prepending, with and without override-style=
 syntax
>=20
> Changes in v3:
> * Update commit message
> * Change "... via one of ..." to "... via any of ..."
>=20
> Changes in v2:
> * Add comment to line with immediate variable expansion
>=20
>  .../bitbake-user-manual-metadata.rst          | 55 +++++++++++++------
>  1 file changed, 39 insertions(+), 16 deletions(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index af4b1358..3250c205 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -195,22 +195,45 @@ value. However, if ``A`` is not set, the variable i=
s set to "aval".
>  Setting a weak default value (??=3D)
>  ----------------------------------
> =20
> -It is possible to use a "weaker" assignment than in the previous section
> -by using the "??=3D" operator. This assignment behaves identical to "?=
=3D"
> -except that the assignment is made at the end of the parsing process
> -rather than immediately. Consequently, when multiple "??=3D" assignments
> -exist, the last one is used. Also, any "=3D" or "?=3D" assignment will
> -override the value set with "??=3D". Here is an example::
> -
> -   A ??=3D "somevalue"
> -   A ??=3D "someothervalue"
> -
> -If ``A`` is set before the above statements are
> -parsed, the variable retains its value. If ``A`` is not set, the
> -variable is set to "someothervalue".
> -
> -Again, this assignment is a "lazy" or "weak" assignment because it does
> -not occur until the end of the parsing process.
> +The weak default value of a variable is the value which that variable
> +will expand to if no value has been assigned to it via any of the other
> +assignment operators. The "??=3D" operator takes effect immediately, ove=
rriding

Generally looks good but I'd replace "overriding" with "replacing"
since overriding means something very specific to bitbake!

Cheers,

Richard

