Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96834C02188
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 18:01:47 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.1358.1738000900586709445
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jan 2025 10:01:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Oano2157;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e1b11859a7so25107756d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738000899; x=1738605699; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dBxMMCak1oGWX6c5hWumRGeF86wKZbkeajJDALM8Lnc=;
        b=Oano2157P5a/TrCO08HfvcpF0oGdY6I4CR2XxbWeQjny6Ifto5OGGW59gpJzAvThF1
         5Dc4HVQzN49Fw3SwkKcmBpLBjHTBX5SR1OrtjhFxoxJskZeVeavBmXdFm7bZAWgg0UY5
         1ouMZsk+IfrvM9yxAcHs+OCpByg7uNbua23hFYi/Xlnify4Ih2UcBJMZpXOQHn69l9fP
         ZRQaeKUjmwH7WJL3WrlDo2Dv4Yt/Gzp+cvkFVTs+e3U8CEr86rqPR41LyNu4klivvRj4
         d7sjyE0CwRZviNIfY3wNP6T+Bi/DcR60c3w3t40lLbtZ/f548x1rwe4R4NsFDKyoZ6pW
         hUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738000899; x=1738605699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBxMMCak1oGWX6c5hWumRGeF86wKZbkeajJDALM8Lnc=;
        b=dYUPLyagebrU0OFNdDkxjHdJ1OiFSL0DhLUj/enTl+pGgp9xA9Whg7Xs0UVtHFNLjm
         mzGLX/xFtGn0i39BgN9x6MQpT1FzmwYKHT2CabXa1ZT9jFnkqn3OylcRYk2fPCU5/Cso
         1KpqBslz7euFfUjEi+fLtCldGhWkXYZWdCccFgMOrSmfhFwlYbBPFb64XB+8EW56cpPS
         K9smc7xG7YtGEgiY5eyPzZmVgHQJHa5t//U7ZatZ7KC4wo5mvQNRL/t+tcNAEVmH4tbx
         2kY6yl7uuMQv4HtTCIwuX07tzome8HgmC136qBb8bFQp7CLWwnht8nuOvMyOm0+d9pql
         OL/A==
X-Gm-Message-State: AOJu0YxKCMRWKK7BF5qDbMrIJ+d+c8eqksV7+AyL6xwjYYn4ZLdgUmuL
	gBwv+UH2FPzkKrBjR5thyubE8RDQNFE5O138mrIpYrfRFdaOW5WYA9QsGc38WJeZ+DrukQn0vq6
	Jfzhzd2HircI149f6wwpC0X63JJg=
X-Gm-Gg: ASbGncuZjdtbXa16DODdz6xe0lxTgg8t6kKaEbh//MPRUA0wPaUBTyyJhVddv+PQ5Qw
	6VBn9bXJSI+aNKc26nfMc3PVMAFbNicYVwkkkVAQj3RhWlTY3SPEsLNL/1Bg2T30WcdfcGnDn3I
	33N6RWSeSd/xg//oMtwIFO
X-Google-Smtp-Source: AGHT+IHTpP/AAM9HBVjvYXs0/61zjuSfRygIFNwc6WKntYwxitL0pN1/GlwWxUKUuMts4nqWX9xe9RzrSgjbGAJ3ik0=
X-Received: by 2002:a05:6214:268d:b0:6d8:96a6:ec27 with SMTP id
 6a1803df08f44-6e1b21c4a85mr614808096d6.35.1738000899432; Mon, 27 Jan 2025
 10:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20250127142918.163-1-eric.meyers@arthrex.com> <CANNYZj-d4EXpM30v+DgY6p=3NjVZG7ThKTBTPSGX70CXh+rjPA@mail.gmail.com>
 <CA+cKJ+HEK9d-tvf-Srz=NwHCrkyikb-ws1u8Bn9kD--EiDF5zQ@mail.gmail.com>
In-Reply-To: <CA+cKJ+HEK9d-tvf-Srz=NwHCrkyikb-ws1u8Bn9kD--EiDF5zQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Jan 2025 19:01:28 +0100
X-Gm-Features: AWEUYZnBq1fFFTYrw5yEso_Zb2S1wDqPzM4af7hGEH1nSexnD8upc0a0Gh5BnjE
Message-ID: <CANNYZj8jjBpFrix4mwYG2SJ1JuvX6MHSmvcrO70WNmuEs=x0rQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/3] NPM/NPM Shrinkwrap Basic
 Authentication Credential Support:
To: Eric Meyers <eric.meyers15310@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	"eric.meyers@arthrex.com" <eric.meyers@arthrex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 18:01:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17105

On Mon, 27 Jan 2025 at 16:44, Eric Meyers <eric.meyers15310@gmail.com> wrote:
> Are you suggesting that instead of username= and password= parameters
> in the npm/npmsw SRC_URI, it should be an "npmrc" parameter that
> effectively the user can point to the location of their .npmrc file
> for authentication on an NPM registry? Then, within a user's
> associated recipe, they would need to create the npmrc file in a
> do_fetch:prepend() step that that corresponds to the path passed into
> the SRC_URI?

The only acceptable solution would be one that takes passwords written
in plain text out of layers and local.conf altogether. And the way to
do it is to write these things into ~/.npmrc and ~/.netrc in a secure
manner (e.g. pass in to users via encrypted email with instructions
that the file must not be readable by anyone but the user), and ensure
that npm and wget are able to pick them up from those files (wget does
this already, npm I'm not sure).

I know we have the password parameter in wget and other 'old'
fetchers, that's a bad mis-feature in my opinion and should be
removed. For git fetcher patches to add the equivalent have been
repeatedly rejected:

https://git.openembedded.org/bitbake/tree/lib/bb/fetch2/git.py#n823

Alex

