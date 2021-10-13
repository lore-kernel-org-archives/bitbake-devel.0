Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D3C433F5
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 14:57:09 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web09.9214.1634137028078760403
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 07:57:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=pT6f0q76;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.222.182,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qk1-f182.google.com with SMTP id bi9so2422190qkb.11
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xV6at43Gigk6IgUcjIebQboG4iMYU/aRK4MotZjBaNs=;
        b=pT6f0q76KOcuHjHR2FUR+HVtWLjmlQvRgtyPbmUc0ZQg5T80QSDvgCwvNhFU3etGQ4
         0fFrWNZXw4RqyVibMxk1cWEJK+h4DX7xxcDjN8AI8+HXmiSDIvo50w1nXRN14JU0Brb7
         l1Ya92i9XMWOkkX10QJ0gX+oLhSXUJfYCKGE+Jw/ug+XAlYIcUu9I3f2kCbIEzna2sC0
         eVQgJ/8usRQaWlZY5QL8dkCc6jYXIV3tYoXQQxfjRoAvmkQlSNhz0uYN/8xxXO1s4jXx
         uvOL9KWXjI2k2sdARp0GK0cNcnZNZcDTnf4tWiYkWVPVudifMl0xwgkGgj1yKVjYEuk1
         Iw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xV6at43Gigk6IgUcjIebQboG4iMYU/aRK4MotZjBaNs=;
        b=aLl6TvYYlnXdWQHq0BjJRqX/n6Fze0T0hEnUKGDoq1HLlxrqnDOZg9D2U2BvdyhtkY
         Lu+lLe3D7hVgnOxvxHsqNuEqu2l3CU1vqTgF9VM3nhpEGR0pSdRNuoMhVebtd5SXpH5l
         IoCV2ityF+Jcw+InTBaqj0yfLNPfwqcKQkGjV6bIvZ6SSYClzeOxrnf41qIfHNzpMFnl
         bDb1ujKxOASeVAQoJRXqqblIeLu7l4j4KRZAF3H8cMwZh2UCwXG2JzwujpJZJTqraJ7Q
         tSBPmvCJ3xHeCqZE8ckMXFdtjpL+Y/3cw3yOD1g405XGvoIHe5j6A4zLytemf6yEEu2a
         BzOg==
X-Gm-Message-State: AOAM530irkx0S0G15pSMZMpb1DCq/18SKnUQVTttBsSlkVZnUmthLaca
	mgpWGm69NNN9gjzANa1La0r6GEj8+ll/SG811UrcbQ==
X-Google-Smtp-Source: 
 ABdhPJx+Ad3NF6AoyOjMagj2B5kXn7FaqGd4GdD44XMGrPJ72IygmjM4RfGjx6YM5cbj6B+vPvEUFWadpZUf4qIXmKU=
X-Received: by 2002:a37:b7c2:: with SMTP id
 h185mr26448909qkf.311.1634137027181;
 Wed, 13 Oct 2021 07:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211013143630.21266-1-jdmason@kudzu.us>
In-Reply-To: <20211013143630.21266-1-jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Wed, 13 Oct 2021 10:56:56 -0400
Message-ID: 
 <CAPoiz9xr_yixYu1LfdjSbDOD7TSYd+iB4R2QmgiAL22nU2xhdQ@mail.gmail.com>
Subject: Re: [PATCH] runqemu: add DEPLOY_DIR_IMAGE replacement in
 QB_OPT_APPEND
To: Patches and discussions about the oe-core layer
 <openembedded-core@lists.openembedded.org>, docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Oct 2021 14:57:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12768

Apologies to docs and bitbake mailing list for the unnecessary noise

On Wed, Oct 13, 2021 at 10:36 AM Jon Mason <jdmason@kudzu.us> wrote:
>
> Add the ability to replace DEPLOY_DIR_IMAGE with that path in
> QB_OPT_APPEND.  This allows for anything present in DEPLOY_DIR_IMAGE to
> be passed into the qemu parameters.  This is especially useful if you
> want to run multiple flash images (as -bios only allows for one).
>
> Signed-off-by: Jon Mason <jdmason@kudzu.us>
> ---
>  scripts/runqemu | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/runqemu b/scripts/runqemu
> index 3268bb18ada6..54f2336ba977 100755
> --- a/scripts/runqemu
> +++ b/scripts/runqemu
> @@ -1412,7 +1412,7 @@ class BaseConfig(object):
>          if not os.access(qemu_bin, os.X_OK):
>              raise OEPathError("No QEMU binary '%s' could be found" % qemu_bin)
>
> -        self.qemu_opt = "%s %s %s %s %s" % (qemu_bin, self.get('NETWORK_CMD'), self.get('QB_RNG'), self.get('ROOTFS_OPTIONS'), self.get('QB_OPT_APPEND'))
> +        self.qemu_opt = "%s %s %s %s %s" % (qemu_bin, self.get('NETWORK_CMD'), self.get('QB_RNG'), self.get('ROOTFS_OPTIONS'), self.get('QB_OPT_APPEND').replace('@DEPLOY_DIR_IMAGE@', self.get('DEPLOY_DIR_IMAGE')))
>
>          for ovmf in self.ovmf_bios:
>              format = ovmf.rsplit('.', 1)[-1]
> --
> 2.20.1
>

