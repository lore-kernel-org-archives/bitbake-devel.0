Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB9DE67818
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 19:18:54 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.86852.1766431128521207151
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 11:18:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dHmtN/RT;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8886fdf674bso49326476d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 11:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766431127; x=1767035927; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lah4QFnUfUuwPUTMkkdUPfl3oUttyqaBbiip96NyB74=;
        b=dHmtN/RTDj64GgsSkJfbq7/xm6kOvjXZo1ezldC6e5+SyDcAySjDHbH8aMLO5HVHD+
         jyTi9V41a+dWADCpTAwP/OAZRY9nepuB2Kk6FtJIbQF8LVuMej0hESIlk0axY8Tw7JUq
         Ytb4bXsVeHUyQt0EC/egnOdyh38jw6gfgLK47NFCpi1RkZPWWWLvA7EQaeGmppVF/vI7
         Iz6RgJ6GTPW+laqGlyaUHG7HiZi7c8EAzMrxqmQorq6pvagmociO+7CfXvRt77YNWHzo
         23bLLMPGrv7MAEJmgx6nnYOQLsMkpIpP4pAhAZp46oJkTM8SfYwplUpay/KllgEyyiLV
         ym4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766431127; x=1767035927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lah4QFnUfUuwPUTMkkdUPfl3oUttyqaBbiip96NyB74=;
        b=cKZXdRgaIwIvQw+uNJ2qFfZlChJUCdJKnrXg5KWZx8nOxHQS198GpzPV1sH3rqccDZ
         RuGgewDPqcGm7ZXfx9HR4hgh1Co/XJpEojzfY2HvaNdd5jqcaiJS01GMnRxt7Qiwmklg
         V+IsjV7RFXR4ua/Tsbdol1QIvo5AXPbx0wX5yYD8kQQa/np/E7WwGvqfMLXoqF41Db3u
         zUPlaNiUgw75rFAHfJv+PdsaO+fvjAvzNLW4TWcSGaVWDggYSmD+V7z0jyNibLhLqLTk
         U8G/JKGiloWSlrjO3EW/oG5/HiCgw57E2xIOkYOePlHUPoDxHo8J0Zxq03NxwCr+Ha5l
         vxKQ==
X-Gm-Message-State: AOJu0Yz8uslKQpK9uUbBsA0fYe9kZGJN6b1Wzcc4xBPOItTyetY76nHw
	uu/kMBxpe5xIWnEf2lxp2nyoOwiHOG9xJEWZDOo2f+nvnaaGwB2X7fXXC9WlS86bt/QrRQdJvgP
	pHUTpMxhRZodSHXd9dO3j/PvVuu58zZA=
X-Gm-Gg: AY/fxX4SwDFf5vsyLTNCH1k0S5qxbg/3EnS2HsetQMt8/PihomBFPzLcOjsCkaN8W07
	3ibYJ9PY23WzEwApHXzEbtlRp6AAwrkkq6Cq5B81xxk1fvCJgsw/S0DS6CpJCQQMleyQmKwNTAk
	518gqOUuOzFqnq9BgNXKTPaI7y+3nnlwayXJxkLLw8j8psC120pS2GZUlz47tYZr/TFDifvh4e6
	X8BHh3ziD73wRNi+dnPK6ieiFxznDs3TywLMy6UXjU9GHy3O+L0YoHkVKUxcWlYULjXWA==
X-Google-Smtp-Source: AGHT+IGf6JL6H4UWk3lnDP56gudMxQ08ByHVaijgzOEI5awp/tR+AmmanMHWe09kLD3rAZms/cMuGYwrcxPUGy4dffA=
X-Received: by 2002:a05:6214:1418:b0:880:4605:b2d3 with SMTP id
 6a1803df08f44-88d8481cd4fmr144385926d6.63.1766431127424; Mon, 22 Dec 2025
 11:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20251222181527.2424323-1-anibal@limonsoftware.com>
In-Reply-To: <20251222181527.2424323-1-anibal@limonsoftware.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 22 Dec 2025 20:18:36 +0100
X-Gm-Features: AQt7F2pyqv2F4_1YTFNac2XYDNET5rb_tmwGAGLPzkbPAoE0sdteZXQt26RAf4c
Message-ID: <CANNYZj-=2r9VFg4AGfKiYbOp5Eh57uvVQt11UTT0xVWPhfxbhw@mail.gmail.com>
Subject: Re: [PATCH] bitbake-setup: _symlink_local fix case when update
To: Anibal Limon <anibal@limonsoftware.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 19:18:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18641

On Mon, 22 Dec 2025 at 19:15, Anibal Limon <anibal@limonsoftware.com> wrote:

> +        if os.path.islink(dst):
> +            if not os.path.samefile(src, dst):
> +                logger.plain("Updating symbolic link {} pointing to {}".format(dst, src))
> +                os.remove(src)
> +                do_symlink = True

dst is the symlink, but os.remove is taking src parameter. Is that correct?

> +        else:
> +            logger.plain("Making a symbolic link {} pointing to {}".format(dst, src))
> +            do_symlink = True
> +
> +        if do_symlink:
> +            os.symlink(src, dst)

Is this logic complete? It seems to cover the use case when one local
path is replaced with another local path in a json config, or when
local path is unchanged, but maybe we should cover the situation where
a git checkout is replaced by a local source as well?

This and the previous patch expose a gap in testing, perhaps
status/update tests should be extended to cover local sources?

Alex

