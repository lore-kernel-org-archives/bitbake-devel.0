Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEE9CA5512
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 08:51:43 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.7190.1694595102561760233
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 01:51:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XH6EEY7n;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so3307830f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694595101; x=1695199901; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yiyRjQhcADPALtMyHkq4D2gaX/8k5cnF/qAkM0dIhn4=;
        b=XH6EEY7nawFGYDO4OMrxd/LiO+O+XOpwpwBctBOdUJl6EudJhB7I9QAq2xiHhp9iMH
         utSgZc6RlgMj/0UVCjbMlTc9POvD5x7dW84syTET5IEvqthuL6+VO1Cbs2plLadoOLB4
         pSPUx/tolyvTMBXe0VdqFJnG6y9fl0RtJK5kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694595101; x=1695199901;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yiyRjQhcADPALtMyHkq4D2gaX/8k5cnF/qAkM0dIhn4=;
        b=lhi3tv4oGBFTLxyl0Fu73jdTdzng92vlyEwh1CRFUopn6ACJ5f0LodNMrb/SRdseph
         nUFY/yeCbHfZQGsmvnnVdoDOGRkzZYle1e4Y6GvRoJ2nfP9HYbKkDUg/VPo7Zm1wZA83
         2xpmRgIpOEcAFLG+kkMPUqekV6/1Tk07jOJg8F/gpy7DoTAXZgd2ce1FjReyR605iEE4
         23bJwpDbsubnq46PVpCJbGU7nt1acTxqAbDA8IQj7BeIgKYEu39HFutR8ZpJlfPjel/e
         cl19anNVJYeOGYWpPyiZAeuIWTk1qUm/UQWypRIsoINBwtBD6Bxo+jtDPIrjvbJUDO8V
         tUrQ==
X-Gm-Message-State: AOJu0YwJquTbZhDM0MtFCyiR01rY/isgrOMyEUk1XbeAz3u49CHvhpKu
	4IynmQ/C62QXGK2itER1ijzUWA==
X-Google-Smtp-Source: AGHT+IFvT/VYXfKE40FSmStk78JPVEOV3hycH13hbbU4QxtiWkMKAQ0EjoEz2wDIVhTS0DFfZFw1Qw==
X-Received: by 2002:a5d:4bc3:0:b0:31f:b91f:23ef with SMTP id l3-20020a5d4bc3000000b0031fb91f23efmr1518471wrt.51.1694595100880;
        Wed, 13 Sep 2023 01:51:40 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2a8:4888:9029:4207? ([2001:8b0:aba:5f3c:2a8:4888:9029:4207])
        by smtp.gmail.com with ESMTPSA id j6-20020adfb306000000b003142c85fbcdsm10336988wrd.11.2023.09.13.01.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:51:40 -0700 (PDT)
Message-ID: <969bbf65ba6459eedd8df5a3b2cc3f378fdf05d2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: git: revert path checks
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mikko Rapeli <mikko.rapeli@linaro.org>, 
	bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Date: Wed, 13 Sep 2023 09:51:39 +0100
In-Reply-To: <20230913084344.29928-1-mikko.rapeli@linaro.org>
References: <20230913084344.29928-1-mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 08:51:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15043

On Wed, 2023-09-13 at 11:43 +0300, Mikko Rapeli wrote:
> Commit 10f38157a069cb6938323cadd5e523037a29ace9
> triggers re-clones of uptodate repositories when their
> access path changes. This is wrong. It is enough that
> needed commits are found from the git repo. For example
> when same DL_DIR is accessed using two different paths
> due to a symlink, then the resulting absolute paths will
> differ but the content is the same. Trust the content.
>=20
> Avoids extra downloads of large repositories like linux-yocto
> for kernel when the local cache was already uptodate.
>=20
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  bitbake/lib/bb/fetch2/git.py | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index e11271b757..0c547ea303 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -371,19 +371,7 @@ class Git(FetchMethod):
>              # The directory may exist, but not be the top level of a bar=
e git
>              # repository in which case it needs to be deleted and re-clo=
ned.
>              try:
> -                # Since clones can be bare, use --absolute-git-dir inste=
ad of --show-toplevel
> -                output =3D runfetchcmd("LANG=3DC %s rev-parse --absolute=
-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> -
> -                toplevel =3D os.path.abspath(output.rstrip())
> -                abs_clonedir =3D os.path.abspath(ud.clonedir).rstrip('/'=
)
> -                # The top level Git directory must either be the clone d=
irectory
> -                # or a child of the clone directory. Any ancestor direct=
ory of
> -                # the clone directory is not valid as the Git directory =
(and
> -                # probably belongs to some other unrelated repository), =
so a
> -                # clone is required
> -                if os.path.commonprefix([abs_clonedir, toplevel]) !=3D a=
bs_clonedir:
> -                    logger.warning("Top level directory '%s' doesn't mat=
ch expected '%s'. Re-cloning", toplevel, ud.clonedir)
> -                    needs_clone =3D True
> +                runfetchcmd("LANG=3DC %s rev-parse --absolute-git-dir" %=
 ud.basecmd, d, workdir=3Dud.clonedir)
>              except bb.fetch2.FetchError as e:
>                  logger.warning("Unable to get top level for %s (not a gi=
t directory?): %s", ud.clonedir, e)
>                  needs_clone =3D True

Doesn't this give rise to some of the original issues (it could find a
parent git repo instead of the one being cloned)?

Cheers,

Richard



