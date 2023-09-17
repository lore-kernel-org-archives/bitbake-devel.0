Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEA1CD37B4
	for <webhook@archiver.kernel.org>; Sun, 17 Sep 2023 09:55:07 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.27278.1694944502186058611
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Sep 2023 02:55:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NCERWh+z;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-31f7400cb74so3084064f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 17 Sep 2023 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694944500; x=1695549300; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ItBCBCCEWte1WrpswZ1UY15La/77YzGJbeBS0f4zqeg=;
        b=NCERWh+zP3bM3jzna3XFOiFDl1DpNzZurb+o4/yfyZdkPCfgzfImNnXynktRL7CJEp
         uPh2q3IXDkzDjgRNzP3FHJnn10kpdDEyy8QzWSGr6189fZPHHhZz9vbkoqqZvC2hs+x2
         F1bcfzoxVKzCbqwSmtOEeUVJ/oob49g+zLirg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694944500; x=1695549300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ItBCBCCEWte1WrpswZ1UY15La/77YzGJbeBS0f4zqeg=;
        b=BWjBcUq6A21fCOlQfWKLn5x0A0LykvkVIAH+PBF62GOWWqqUcS0PrSPevm6xxbE/1M
         FFzasiWuNENKtSze+6cQG80Oy/J3DEv15uyeDnRG8NnIe4+nQFZsOHg2UJRmubHPo3Az
         y8wAdk3SiqFj0rrAsXXn+VPhzqjz9CgzLyfpGpCuL52FgZhIqak6jICXuklzyXwbfPtN
         EI+FDXt+sRvFeliIpcRATy8kulcIOdr6Y8/lFzKIQcf01tGLtTY3VDZYsSlfq/nLStk1
         r806DgwlgVGT5un4baQ+eFUoiYsFPs4rC2bvEPftZwlC3w0gyk7VXYPs4LX+G8NfPPmX
         2bFw==
X-Gm-Message-State: AOJu0Yywht5HS+wOwbBGtEAPDLhlV/dAJV8NAwp9Dlw8jy+FEzYJv1Ma
	Sts0vbNcaPGGCzEhE5PAIhYewA==
X-Google-Smtp-Source: AGHT+IH+My/yYol9Cwl6saZap2GvTk6eUcZQIz0X+FIcgSQIWzY9ezgnLTm65mVfbSTUDMuUiAXUyg==
X-Received: by 2002:adf:ef8a:0:b0:317:5f13:5c2f with SMTP id d10-20020adfef8a000000b003175f135c2fmr6784838wro.0.1694944500559;
        Sun, 17 Sep 2023 02:55:00 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:bff2:f038:1163:aa6c? ([2001:8b0:aba:5f3c:bff2:f038:1163:aa6c])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d5248000000b0031fc4c31d77sm9300760wrc.88.2023.09.17.02.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 02:55:00 -0700 (PDT)
Message-ID: <34de603b56eeca2c364c422ce926c424755ef7aa.camel@linuxfoundation.org>
Subject: Re: [Openembedded-architecture] [bitbake-devel] [PATCH]
 server/process: Disable the flush() call in server logging
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>, openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>
Cc: Philip Balister <philip@opensdr.com>
Date: Sun, 17 Sep 2023 10:54:59 +0100
In-Reply-To: <17852E9ECB514263.22721@lists.openembedded.org>
References: <1784D0C1F5057432.10618@lists.openembedded.org>
	 <49c3f81299d8153f31b09cfd226cb183097e6c8f.camel@linuxfoundation.org>
	 <DB5PR02MB10213747F1C3061D3EC8C116FEFF6A@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <178518DC5E1190FF.14273@lists.openembedded.org>
	 <17852E9ECB514263.22721@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 17 Sep 2023 09:55:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15072

On Fri, 2023-09-15 at 22:08 +0100, Richard Purdie via
lists.openembedded.org wrote:
> Just to follow up with where I got to with this.
>=20
> The problem is that inotify isn't delivering change notifications in a
> timely fashion.
>=20
> With the patch applied and BB_SERVER_TIMEOUT =3D "60", you can show an
> issue with something like:
>=20
> rm bitbake-cookerdaemon.log
> bitbake-layers add-layer ../meta-virtualization/
> bitbake-layers add-layer ../meta-openembedded/meta-oe/
> bitbake -m
>=20
> where the second add-layer fails with the same error as the first with
> a message missing meta-virt dependencies. It doesn't notice
> bblayers.conf has changed and hence doesn't re-parse the base
> configuration. I've locally proven this is due to the inotify events
> not arriving until after the parsing commands.
>=20
> os.sync() isn't enough to flush the inotify backlog. os.system("sync")
> does but that may be the fork overhead. sys.stdout.flush() does too,
> probably as side effects in the kernel IO workings.
>=20
> This basically brings me to the conclusion that it is hard to know when
> the inotify events are in sync with the incoming command stream and the
> current approach is flawed.
>=20
> I'm starting to think that we should drop inotify and go back to stat
> calls and maybe require that UIs send "re-scan cache" events so we can
> avoid the scanning when we don't need to. The client code does have a
> pretty good idea of when it changes metadata, it just doesn't share
> that at the moment. We can rescan at reconnection so it would just
> affect tinfoil usecases.

There are patches in master-next which replace inotify usage with
stat() calls and mtime comparisons.

For "bitbake" commands, I've made it revalidate the cache upon new
commands so that part is relatively easy/safe.

The tricky part is that we'd now require tinfoil usage to explicitly
say when the client has modified metadata (or run all the stat calls
between every tinfoil command which would have crazy overhead).

This means we need to audit the tinfoil command usage to markup the
places where it changes files and expects bitbake to notice.

In master-next, I did audit bitbake-layers and recipetool but not
devtool. I've run an autobuilder build just to get an idea of how close
this gets us to a solution. Unsurprisingly devtool is exploding there
but other areas look more promising.

Ultimately we need to make a few more invasive changes to the way we
control the server from the UI and be a bit more explicit about the
command flow but that should wait until after release.

Cheers,

Richard




