Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F277CAC5B5
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 12:53:25 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web10.52950.1759150398967968554
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Sep 2025 05:53:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZEqaAGKs;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4df60ea79d1so20203851cf.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759150398; x=1759755198; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f5qoD6qP+C+jGW8SWA1GqeCCIrmN5vk7/YxHsapwoWc=;
        b=ZEqaAGKslnBOzf53NgvOJi56D0OmsMeiFwWWiQ5w1Cvk+E7k4UQJMBQrsYSvpkg3MN
         4TcUAD2uz9Zs9+WV8IzJ9Iddg+yWmRXWTEzXx3ba8Cq/rQ2Hv3C18DcwF2xVi75eBVGI
         PPnTyJzQrERuXeepL4h93QyyfRywizSvbJBhQHjiPaGvY+X/6mSV6K29BZznzrydATEB
         fO/xkyX+GZGI7RlKvu4OLJAACHBy6fpY8tQ63lFl2Gt11OSZTJn+gPnmop+9XRWRBk3q
         XoPLTmFwPHUX69uDp23TB1fDikh2IG+Un+SNjUpPIsKS+GEK7XcXZuVtlCe2zG0Raww8
         wfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759150398; x=1759755198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5qoD6qP+C+jGW8SWA1GqeCCIrmN5vk7/YxHsapwoWc=;
        b=gpzm+kWAlaKRtWLjkYTVKp4OL5ErJz5IDXdCQa2KwAuW3bj+gjk+eRmW2673e+bLer
         gvsIgZV6hOXISa7eMJ349SXT6ClFMEj4hJbk2qhH/evC9+8Ng2RdC55BQfJyfgkH7DX2
         63TojL+epLuc/PM7BUXX9MYlluHHVqFRjftkB36/fRZiXxOIY95xJdyBTzDu3yG+HRot
         TymAbH2w3tWrd2jph8MkeqbGsqFC4LLLXOSp2kjXjwEh/vCjdH1jCCdLCE+e9bb0R2O2
         APgPVhElG2mhdkTwQIlWw59GhCp/j6zlKIi+9GnP/3VWg82R8uJK/SkwQ+xf1YQUn6ig
         /JOQ==
X-Gm-Message-State: AOJu0YxkCk5BX1OZKy5ekRYx5EUsVewBC1bPsRVWlVcXik7VMvx/vx/R
	ACGpWRKZUTVtR8eFJIeYKITJHPxwjX7yKtF6hysrqZqdzH5WzBBzoF01G9CpMOom9yLs1lateIM
	XrYmhE+aQgXN0Ltsg0CzDriUdQB0v/aU=
X-Gm-Gg: ASbGncv7B4o6ks+YrX9sgydv4M8BtzoyzckshXSeokGxQxnB4JH6mQNCwcdPG1c+z+Z
	swroBgPnO/z462c9w5jUPnWqDE6IFHF/E5gSYKUeMGnzDeLm/+kn6WMATpwlrhe/81vIcHX4dde
	+cyaRg+kjdXJ3y1F9gxV0vtfO04O2XSnhON2nw70VLyyDmqZnA/uLbAQuLydg+kxTprOEvy6LY9
	N0ODzOldzfINcXFwSr5OsQkQkV3rqC7jj9CDElsHvRVC9S7EYTpe0J8IhWY6imGXymDMqW8J2SQ
	YzcM/I14N9R4Kd0mgNlI7ZlvCGdwjagwncxiykrQoA2haw3iEjI=
X-Google-Smtp-Source: AGHT+IF8VZvP9mz15mSS6Ry/cYU9iVTx8//931Sk3vckrs2aMJ9RHNSZxWmS9JboCL2laiuUS29hB6DFKH4WYbe91EA=
X-Received: by 2002:a05:622a:c8:b0:4d4:a43d:316c with SMTP id
 d75a77b69052e-4da4c39b390mr182018291cf.62.1759150397567; Mon, 29 Sep 2025
 05:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250922092731.1993813-1-alex.kanavin@gmail.com> <f2766447a2c7e3f9f036e02aa2c1913205e54191.camel@linuxfoundation.org>
In-Reply-To: <f2766447a2c7e3f9f036e02aa2c1913205e54191.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 29 Sep 2025 14:53:06 +0200
X-Gm-Features: AS18NWCay7scKw8RXc1LjCCMdT2I7W73N8Xj_e5uVCSS6pKL6zQ7uI8sr3GzCd0
Message-ID: <CANNYZj_akHKLjdKJ_LFbi3V-qb5D5NYULOkxAs-Jer5cBbUR=A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/4] bitbake-setup: add the initial implementation
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 12:53:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18099

On Thu, 25 Sept 2025 at 14:47, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> a)
>
> "bitbake-setup --global-settings /tmp init"
>
> gives
>
> KeyError: 'default'
>
> i.e. if --global-settings is something which exists like a directory,
> you get a KeyError

This has been fixed.

> b)
>
> For <reasons> I tried to set an empty --top-dir-name to flatten paths
> however '' didn't work, nor did an empty parameter to the option.

I'm not sure I understand the use case, but maybe this can be
addressed differently by removing the last component from
--top-dir-prefix (or the corresponding entry in the global config),
and putting that component into --top-dir-name?

> c)
>
> If you have the global and build settings in the same file, you hit
> KeyErrors.

At the moment global settings and build settings cannot be mixed like
that. They're two separate sets with two separate load/write/change
functions for each,  and one does not default to the other. Perhaps
describing a use case first would help.

Alex

