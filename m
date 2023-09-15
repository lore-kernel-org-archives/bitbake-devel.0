Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6ECEE645E
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 14:20:25 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.21592.1694787617242980690
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Sep 2023 07:20:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WnGsZUV2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-402d499580dso23801885e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694787615; x=1695392415; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wf0izSyEAXCO8lXfDwj4EWVyM+Ay0auLvmgI+LHorNg=;
        b=WnGsZUV2/5KhMLONMSZmDmCZfvTxPumhZrMVIzV45yoJneg47XjVxfrmHW6JRNhB+Y
         bQvmZ0lNRoVc2Urn+kkGIEUUjhl8CiexQ/uTlTNKIOyitk+I+4zmZpCTbN5E5r1pV1ym
         p6ud8YHR1FOhNQn/XH5yWJ8rwh4Hd77lb7MVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694787615; x=1695392415;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wf0izSyEAXCO8lXfDwj4EWVyM+Ay0auLvmgI+LHorNg=;
        b=S7wqknmDIIeI951/m8zSyhpxlS2he0FMXt/PMMID/RHgmm31wUh5wzz4jFI3GJTpwI
         Rf40puqaveBNTaBdTr1tYYJPiV6KEM7yL+eChS5SUwFkF8/tAaFxFSzk0MGRyZObzFPh
         UWAGmPfXE67JSNRfocCQdA5GR1AIAT5umjxsq9Akt4X97ZKkCaUFbmAPoI/bcUhBaAm5
         /6ZL3fLrpDTRj8SMzOeAqhbux/P5NXg2SJlw+SmwjCyX1SCptyYJ2H5iQrrFZoobnASZ
         2I7t1xRownNngu/1MtjPgh/2pjxuqWeytWhJwWI7yp2BcYmNXXG1qeB7NuST/ITjEH8V
         5Ejg==
X-Gm-Message-State: AOJu0YxQ9aRXOy77QCuvDG+Sj00PFzOOjNrV74jfPTClh7tJ0ZxEUMsD
	2L2F1/VeBE4/Ak822bvPuSoiiG3QH6sjJpS8KAw=
X-Google-Smtp-Source: AGHT+IEcjtnbqWVfSk9+qyKYLSQVEqWgBvlcMI153Ta6GZsiW9D8YDO9+fwbkQt9dvHxNCWXy073Vg==
X-Received: by 2002:a05:600c:245:b0:3fe:111b:7fc4 with SMTP id 5-20020a05600c024500b003fe111b7fc4mr1968925wmj.21.1694787615001;
        Fri, 15 Sep 2023 07:20:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:93a7:bb97:496b:8932? ([2001:8b0:aba:5f3c:93a7:bb97:496b:8932])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b0031fc9402b47sm4581895wrv.4.2023.09.15.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 07:20:14 -0700 (PDT)
Message-ID: <9dd8da9041e275804f5370eecaa2fc1ace1cada2.camel@linuxfoundation.org>
Subject: Bitbake server file coherency problems
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org, openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>
Cc: Philip Balister <philip@opensdr.com>
Date: Fri, 15 Sep 2023 15:20:13 +0100
In-Reply-To: <178505D2F19E1AE4.14273@lists.openembedded.org>
References: <1784D0C1F5057432.10618@lists.openembedded.org>
	 <178505D2F19E1AE4.14273@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 14:20:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15068

On Fri, 2023-09-15 at 09:40 +0100, Richard Purdie via lists.openembedded.or=
g wrote:
> The question at this point is what do people want me to do. We clearly
> have a really nasty bug in here. The patch is "right" and we do need to
> fix this. If I merge it, I suspect I'm going to end up having to chase
> this down before we can release and I am going to struggle to find the
> time to do it and I suspect my sanity will suffer. This does look to be
> a significant issue though.

I've spent some time digging into what is going on and I really don't
like what I'm finding.

The existing .flush() call in the server logging path is basically
injecting a "sync" equivalent in the main command loop within bitbake.

That "sync" is effectively by accident maintaining our cache coherence
and it is also significantly damaging certain kinds of build
performance.

If we remove it, bitbake fails to see file changes. In theory nothing
should be changing files when builds are running however tinfoil users
have already assumed bitbake manages it's cache correctly and with
memory resident bitbake, there are signs of cache invalidation misses.
Exactly what/where/why I still haven't quite worked out. Since we run
oe-selftest with memory resident bitbake, it is particularly badly
effected but back to back normal builds are also failing.

The challenge is that the sync flushes the inotify watches and without
that, writes to files may have not triggered the inotify report which
we rely on to invalidate the caches. Even adding os.sync() calls into
bitbake isn't solving the problem as we only want to do this when
needed for performance and it isn't clear when it is actually needed.

What is really needed is a step back and a re-design of the cache
management within cooker, there is too many weird code paths that
aren't actually that useful any more and we've tried to retrofit cache
handling to something which never had it originally which isn't working
out so well. Given the release I'm worried about undertaking something
like this at such a time, equally, now I've seen the sheer amount of
problems and the fact it is just luck things happen to work, I'm very
very worried.

I've been asked who knows this area of code with a view to working out
who we could lean on to help fix it. Sadly, I think I'm probably the
only one who does.

Cheers,

Richard



