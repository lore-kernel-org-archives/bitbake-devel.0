Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E08C88E50
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 10:21:04 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17240.1789381254626176173
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 03:20:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AUn9U6Q4;
 spf=pass (domain: gmail.com, ip: 74.125.230.205, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb769ca02so30848711cf.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 03:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789381253; cv=none;
        d=google.com; s=arc-20260327;
        b=eFHX1pZEJ3UfkgwzyR/YKxjGOx3vS+onhFpohv94gUje3bRXm8kSYTLJBcrmuV/kWj
         XILgyCc8WzpFqYKLsXhhneb86T0tNm5hvjdtzxVtNIdeRTwsvNKqapcMUPuNfmhK9gvY
         lM9n9BSDbG1F0kCBhn6EXoch9ak+7ymU5uCmXDtNsepWdH043bxs5zt+8PyYwRtqVsJ1
         DbhH2hQ/x73Xag7iv3buJiQ83QqUo4auYDA1hYqcJtnYweKbY9uK36MgfVGVlhXh+crr
         cMrV0nZze9A3GpJ/Z2LMftA1ZPvlr7X7OfNBUQshGNZG7RtlY69uSXrVkK777VX+YIT0
         5e1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0KdNkOq2iWGODPBaxeyGL2ZdRPOe8zcLH/Kcj/Rsco=;
        fh=eRokByQaZkTNRZ8JV2rlYIZDj9Xmguf/xRbiAkF628o=;
        b=LToKdRokZXgWlmuhbbuMFAJ6XHw27PuPI8kNxwHPuE1a3oa9pIWN1EZKp+cL+8Luy7
         B2k+zhdK5kH++2ix402VdAIIjRrXSwdCSsJ5sR8BZqwdJ5Te1AHarPknsCkS0045nEE0
         Z5l8tjjr5uW9Crvpsqot7++AELUawXncIbWkEzj64+cvPozi8XV/Ck/revcKiAXpOvde
         GGX+LPASzk/j/ur+s3f0IvIe1OcYroXSvIQ5QYnEUbKVlKxIwk091HPFPBLEHqLfpnlE
         vTaM453AtzG4N6oRdZGkYu8NHlBltaBOTHLgTiYHDBa73kC4F1DxA1Nesm53UM6Vgcu8
         Ia5Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789381253; x=1789986053; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U0KdNkOq2iWGODPBaxeyGL2ZdRPOe8zcLH/Kcj/Rsco=;
        b=AUn9U6Q4QYt1ntmOUUkuErShOB8vILT+ATEyAI4SBTKhih5J8Rai5OKHeVb7YX/pAy
         fyjCUPvzgUCQM2vHhxPrmwN244616katp8+tC6qMFmOBQKq+8DOAwtG2ZYEPSR81CnOJ
         wXfyT5HmtgoVwKxHR1Kmq3rHeGCuzaFrNlWrzwcAraweMsCN+44EFCbBu0KQg6jdE8Hf
         kbO/k+0qx/PMxB9AhJ2yLC+EDV0YCJvbOQ1cEFzFnjZSotNh3cT7Nx8LQ+j3F5FnnDvW
         jsgvoK+T4MZPEGUAU5VsUJ++JLOc8ef0mLl5stN+WdZNLlTt7WOV3wJ9bQr9BE+1viB8
         kKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381253; x=1789986053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0KdNkOq2iWGODPBaxeyGL2ZdRPOe8zcLH/Kcj/Rsco=;
        b=QZPW5hs7HPsXF+zOo8vG7erQMvHkOp2dDA4ncHVy81Jk3MdVv3kyNsFZd5bxXN765x
         qUnOfP5Z//ncwtZE69fsK4uBqF6cog6yFcNANJvW4qQBYybpHqTXBOBQQuus828GLWXu
         lxRreDGBeV8sbjlR9PybWlcmxRYNYOgbjcvIUdAS9kws+K2vjZx14VZA70IO7cc7bXWe
         qZ4ukmjgsFk6QGeFIjTGxU7tpethYsuL4qTCWtmcD9oI9LvYQrf1peNmp70vEKvnB8zX
         K7heMxVCasQMdUWX9RwXw49v66aFMkL/4hggB8Px8LVQFkDBld3wCbGyw2SLrxx9m8Ao
         PQPA==
X-Forwarded-Encrypted: i=1; AKwUvBzAkGdSBpzp4HwltPIoc1H79gYm4rmu5b8SSkS0K5u4sjwDHbo7R73JzkFtx5v7dgleCqQkhipz7UV9Fnaz@lists.openembedded.org
X-Gm-Message-State: AFuF++m6fkn7rsThcA+kV6K/QOBrKGctcHQ7JZ6Q3M6JW8z0SCwu+DMo
	MDufNP4INPqmu6Fg/11Fj4JMqwPIvd5QhaciQBv443dlfti9zV1wwD2Ub/jRcczWRY06LsPhUJd
	nWWdXbU0+dbwblpTg/EVsGlP56gT90Xo=
X-Gm-Gg: AYBFou2o/QWP7xVN8o1XK/aPhVkA6NPc5zHBmtRForgXg8f8jqiIRHPXe0OsZlpHrwA
	97amvAkn5R2pJiuqRfTUiIQZ/qPMBAgL4IQytyvfkf47mmdT+KdKcfpzEbeEEyhCJnlw3nWDDww
	VDDi5hMt3GENp3VpyU/b4iDx/5/AK5ZTRtHq9EP113BBJZ63lyAOotRahcVjDqYp+60sDcYYQ8f
	ywNsVqG31/TCPH1Du1ph1T5PzT0obJx+lIXgVQauWuUR+0wVgYiyf2hypQzFplfdFfmYb94J6/r
	30qc3BP4884iUMofRPmzRERI61XKkzV/TyVPJuCytnpJIqsvX+WCtQNePB7U3VxyxflQlPQ4QjC
	SnRO42hk4cQMoBQ==
X-Received: by 2002:a05:622a:1e11:b0:530:42e4:1b5e with SMTP id
 d75a77b69052e-5310d079a92mr29981231cf.43.1789381253494; Mon, 14 Sep 2026
 03:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260914051148.1445323-1-zhangqiang.zq307@gmail.com>
 <1166440fd2b4a63232ad5959369f7602a43de82f.camel@linuxfoundation.org> <CAFb4brP7OpopstkUKCCGyFPEaGwjab+AR+FFPh0pvGjK+Uhsxw@mail.gmail.com>
In-Reply-To: <CAFb4brP7OpopstkUKCCGyFPEaGwjab+AR+FFPh0pvGjK+Uhsxw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 14 Sep 2026 12:20:39 +0200
X-Gm-Features: AcwNN1VwUbwl019E1jJWnZD1IWz_ZNGOD0v8e98MSd4bjz1qz1fgFH2uLADoEwc
Message-ID: <CANNYZj-2Wxevg8NM5ODrztE6rh3NrvjAwFR=BPcBWFffM0zsUQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch: Add log_errors parameter to Fetch.download()
To: zhangqiang.zq307@gmail.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 10:21:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20194

On Mon, 14 Sept 2026 at 12:04, =E5=BC=A0=E5=BC=BA via lists.openembedded.or=
g
<zhangqiang.zq307=3Dgmail.com@lists.openembedded.org> wrote:
> Both keep real mirror problems loud while not failing a build over a
> network blip. Happy to respin the patch in whichever direction you
> prefer.

'Network blips' are just as real problems as missing cache objects.
They're not 'problems that can be recovered from', they're
infrastructure errors that need fixing and should be reported as such,
regardless of whether the build process can find a way to produce the
needed artefacts in the end.

Alex

