Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B14DEA8103
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 11:57:54 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17799.1770724668926339565
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Feb 2026 03:57:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=luwU4zHp;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-896f4627dffso8796136d6.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Feb 2026 03:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770724668; cv=none;
        d=google.com; s=arc-20240605;
        b=bQOigb+DOWdPW1NWfP6bXrAjRg9p6MrYMJPA+wN7gmxbdTpUuN64uZYVaCbwy5v/eK
         gVkAIIpz52vBEmQxXwprG72XA0d6s/ciH0CIhc51BLxYYnZuSHXYRMl/LWfIBArDzgT/
         AwlktCCqSEZlWu02HUfIxRmszKRNtbUx/BQAD0vxe2TsZq136zSuqCQooL5x1d7P71V9
         7cWIjX8v0hsuqRPNNBYcYEX7Vs5HDQw10KnbHHdIVsE1Zex8dvnaTM0O9QkJ1Lg2WPrv
         ht9WITYOkrkbfZu+kw2U0rLh0SZoT2KSeHTTKIZ2JHOqNnwPcTTByd8dNekUB/5cnflv
         3K3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vJB6bXBIlwYjglHYIVNMA6QP+93tH/QiA8cbNlQ+gq8=;
        fh=ipjyoT70VIvOR0iB/vrqcblb8LhgBH+H6fBb7Y+6I3Y=;
        b=Qut2fnEw3896bElNdOf4gHVZGKe5akqmK0teVXIoCjR+yaON6iWK3ncG335dGV6+Ci
         1VcBjGKcJb++csVqzedMW4hOQrWrwW9+8TSeh4EgrQudecK5TbytwaaRZqsEdJkVXTbb
         +VTdKDJHLU8z9dGqenr+7bH0N0Vkd4YcF/ngTG+bU+sGWqG66sC0TTX9fwFLCoEOzxXU
         X8SCcpiV17UDLmxcdAFDio6YshII/JiEc3fLWl7UMV2S+vKEdemKWHFA42QvpFJFGwi/
         F/X6O2FWH/OHxbMVCgXpwpCijdX01fJah1dLTmpupyvzMwj9BK21h7SbuyF92JKpkbHn
         p2Cg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770724668; x=1771329468; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vJB6bXBIlwYjglHYIVNMA6QP+93tH/QiA8cbNlQ+gq8=;
        b=luwU4zHp3VqtcCvtkZo5Oij3s3gHjxFGh7pZ20iVQT9Lh59J0EcyrtRipLzPxyLysh
         ix9kz9Myhh1TpHR3KcgJSCXLUzRhYwqo/uqcQTFKpZqY9q034A64GBdLEVSlzviBcBTS
         d3b0NtC0+mE8PDZ5SO5gtV/3atBQYFh698Cfzg9H74uDXF/bxV7jmpHuGgLPVEfc9yYG
         hie3Ci8ojgS80qnRhAjk4ps23Lw+wSgW7SBD5YFjaPA87e83qZVSMTm02co20wZm7E8k
         JrNSQJFVer3AyTgqFjkAYA28JoR7bYSKNaqw3KXohS+dVncNmX1NMVphw7CawXhwSTWV
         iCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724668; x=1771329468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJB6bXBIlwYjglHYIVNMA6QP+93tH/QiA8cbNlQ+gq8=;
        b=oGr0HtfmGJPcJcORePBK1dUBACHKqG73R98SoH62yAse0z4BcFmzZmaqJw7V4frXbc
         5ONnhO20bYVpryM6m5g6jfAr17Gj81ismEuFEqKAG29+lEQxGCmOHKZTLc4TmFbNFnWT
         5IUNsEgMcJAUbOowvm8UuZSeEONPBpP60ZpPVao4qtM/PqXA6ErYwvR9jQgaIyIFLhZc
         BWvrjRBwAvhm8rgeFLXl1BK3cpBCIl/etnNI2O6/dEdAUKDcgNlLOoOJ4XdNL5I/KHMB
         XTRUUiUyidCo/FsUTeUc/oHrWVV2hem2FBYgnEG33B+Lq+L2iQZqeFiEq8jV07iBacbz
         tnBQ==
X-Gm-Message-State: AOJu0Yw2gYeue+h/ShaQkNys+B+2RgKzmeaMw2wvrHnQeVaBO6Fe/5iJ
	Iab2F7zty7aFAksRDQP4s3+VDJh1vwpHMeORl0ehbxgBfwNqZdhjUOStNfGo3qStreqWHNlvjpL
	BboBlTwnGfaI6P15As37B3sgYhoXqPDo=
X-Gm-Gg: AZuq6aIcmmVtlxO5JS0WGqnz5EVsAFnWe92Ll5fWT6CrAOCJ8KXHFRBHSyD/RIwpM8R
	/LryBqEETrzgnrJuU4XRoEO61ryVkutG7efnJS8hCrycGGnDU1HsJuqtoZmSqE24tQX01ShtX8l
	RokBcOYrco2BFeYbYBNe2YYQOdO2tLi8Mz3/S1Qd089v5Cq85dj4OGIky4nc32kKeZQADdZOsDg
	zeIH3WJgn02E2zI1KsLKn/z042ZKfGEiHsO3K1wkgyckrnQ/sFpuJADLNFN+p8SBriO+1xx9mKn
	sjy1qw3cRGA86omzwTDxKIaY3GYvLCgA/wvVWaURug==
X-Received: by 2002:ad4:5deb:0:b0:895:4c45:a617 with SMTP id
 6a1803df08f44-8954c45ac06mr159901236d6.36.1770724667857; Tue, 10 Feb 2026
 03:57:47 -0800 (PST)
MIME-Version: 1.0
References: <K7wT.1770654725256025131.AKh3@lists.openembedded.org>
 <CANNYZj-pfZ79Uedy0-SNX5Go_gOWy0XpSQDgp7C1a8=kUAPdLw@mail.gmail.com> <660988.1770722998965341769@lists.openembedded.org>
In-Reply-To: <660988.1770722998965341769@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 10 Feb 2026 12:57:36 +0100
X-Gm-Features: AZwV_QhogPcUKNviZ6VLEG_f3PQt7ulgA_9OtD9n_rBeGD3gjVjr9TS7hz-Z5sQ
Message-ID: <CANNYZj-+b-mRistOxuaHFGgrLHG61ff-ZpARmfYOtr85zbNFqg@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][lib/bb/fetch2/git.py] Re-introducing
 --prune option in fetch_cmd #bitbake
To: srbruno@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Feb 2026 11:57:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18998

On Tue, 10 Feb 2026 at 12:29, Bruno Ferreira via
lists.openembedded.org <srbruno=gmail.com@lists.openembedded.org>
wrote:
> If I add back the --prune option that was removed here, "git fetch" will work with the following message
> will appear in log.do_fetch
>
> From https://github.com/org/random-repo
> - [deleted]         (none)     -> foo
> * [new branch]      foo/bar -> foo/bar

The option was removed for good reasons, we can't simply discard those
reasons. I think that change was prompted by mass master -> main
renames?

I'd say you simply have to ask developers to namespace their branches
properly and don't step on each other; once there is a branch named
foo, one cannot anymore create a branch foo/bar, and vice versa. It's
caused by how git stores branch information in .git/refs/heads/ - the
slash-separated parts of the branch name become directories. Usually
branch names are prefixed with developer's nicknames for this reason.

One could also argue that once there is a revision of some recipe in
commit history that refers to a particular branch, that branch should
not be deleted so that the repository with the recipe remains
bisectable.

Alex

