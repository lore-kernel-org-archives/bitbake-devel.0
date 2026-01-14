Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F9BD29FE7
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 10:46:53 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7398.1768387607457911707
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 02:46:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XFbMgLSN;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014600ad12so8831661cf.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 02:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768387606; x=1768992406; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WwMZLyFd6ipdavoEZKg2mppzXE/6BoIxD0GYb9+qihE=;
        b=XFbMgLSNYK7ESfmEaRxb0EtMx1pVX1TNUwh4c85pzS1QhrtWbrA1zuIasCM0TbNI3t
         /7hk7PzaG8iQIZsDm7w0wDROa2YCEGSEo42v0L36HCTIAj5W3xpAoZkWdTvXrv2v0xcZ
         QDkuZB3uBQdnNeIU3qYYPIefoYLHN82gYeu66m0oHPojzHxyYgkXpya10fDMC2cjxN/V
         aIb71skJbNjkyg5Lr3jD14fhPRU+iogC0sGcl+yiow/kp/YQZBSq7WNZyOOq45LK2SwS
         jMNgQXRTTmXPMi1jsiOyLzACvRD/muppAsaXa1YmfA1E9ns7DgesiRdVNJakhKixoGg9
         NIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768387606; x=1768992406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwMZLyFd6ipdavoEZKg2mppzXE/6BoIxD0GYb9+qihE=;
        b=edMHT8yg5/QM+fvCBjFKKk1Y/v7pveHN1DAYG/cd3LpHXJei74tzDYOyvtNi2HcKH+
         4k1uAOHVecRN0hszEb9tgm0dVryuN2e4pVi5uyoRFdU+MF+17tOojWt0rGPGQgCexqC+
         UWG/IxoR3VDnm8SOLRMWOrn13qONllw6wKMJ8TqjlwEzNlcKABvcX1cZyp0+Qorj7MvQ
         w673KucbzBXYIh2nVAhWCIVT9QrhSvYwOZNX+kNdqm/ixwO4j1gvp53FW6ue8cHUX9+b
         DIpfM0vzLjmK7Ih6Jy8QWKaejDRlG1x54s+kGvhuABykqszeqngdy3tmAdRVJgb8vnhe
         JuIQ==
X-Gm-Message-State: AOJu0Yy83R9dPLMjnpPzEVhJfvI5GHs1HbQFxz9RM8t7bvg2uTf9hd0Q
	rIWMfhrUMbqpfqhGi9l5kBrghtknnRQxnwNH9yVIyJuxEWA37ffLJKDDlM+N1iljyFYK9tyCEBQ
	tk5Yoy+3MRXGqpvyqhiURHFqe8U5/+6M=
X-Gm-Gg: AY/fxX4bZqFPjCcoocdS0PQPr+Y+fhy36MAPnZG9EgLtwt7U4pf/nTLMy/P8GoscAAK
	cHy1eovM0BOegJZwLqNoUFCuNRb/TCifljUcgI5WWs89G+u7GvI8VzkHRU0LkE0MiNAZx0odbco
	udZxdXSGDW3TJ7740jJlYEC/QHj/mZu0grINig+4CIsBkIHMl9D6Hqw3On4/eKUJyEz6MNZ/Jix
	vVIfwCU0DLt+t8dUiOxPkHL8UUq9TfDISa3WYrZ2138IiOr/ADEHkBV62xK9PxK4cxzovNu
X-Received: by 2002:a05:622a:1882:b0:4e2:ea31:1a with SMTP id
 d75a77b69052e-5014a98d878mr14189241cf.68.1768387606214; Wed, 14 Jan 2026
 02:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20260114080414.2927046-1-alex.kanavin@gmail.com> <0adf825db9501818398a9ef04752e4000bd3133e.camel@linuxfoundation.org>
In-Reply-To: <0adf825db9501818398a9ef04752e4000bd3133e.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 14 Jan 2026 11:46:35 +0100
X-Gm-Features: AZwV_QhflXu9gAoREmyfHcJfH5-e6StC8mgU-gg0M1InG8c9b7vk3LaXFBGQajU
Message-ID: <CANNYZj8fqxz+jVu8_eWBaCCGCaZoWA5dO5foPTKWnNOEoH3c4A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: use internal registry if
 run from git checkout, bitbake repo otherwise
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, Rob.Woolley@windriver.com, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 10:46:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18750

On Wed, 14 Jan 2026 at 11:26, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> > +def get_default_registry():
> > +    internal_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
> > +    git_registry = "git://git.openembedded.org/bitbake;protocol=https;branch=master;rev=master"
> > +    if os.path.exists(os.path.dirname(__file__) + "/../.git"):
> > +        return internal_registry
> > +    else:
> > +        return git_registry
> > +
>
> Probably a silly question but why not just check if the default
> registry exists and if not, fall back to the git url?
>
> i.e. why isn't this just if os.path.exists(internal_registry) ?

The idea is to ensure that internal registry is used only from a
bitbake git checkout. If someone makes a tarball, or otherwise
installs bitbake-setup in a way that replicates the tree structure
including the configs, then bitbake-setup should ignore any such
possible in-tree configurations and get/update them from git.

Alex

