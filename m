Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F05C02190
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 12:43:06 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.11229.1738154582291607841
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jan 2025 04:43:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jRqUoqMo;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8e8cb8605so34706396d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 04:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738154581; x=1738759381; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ6UtPrD9602aPjTk5b/AQN/dUeBNKMH7itzLMumKXM=;
        b=jRqUoqMom6i+R3KU4sW+JCpNQUYabn2yhxNVfFchkmy/kb6U6IxV6s317Womc+lWO4
         SzAyZf5GvC/uslKnWxqkK/WlXr+mwEPdS6k3veY1/u3AKHJWCS13V3uD14MziUnukpNd
         2nlWFogl9YRDfM+1rR4mctzcdOJTvSfA4fPpwhvMI7pH1Zq3kdvNEKyMorJaXCTINMCG
         DXpFNNiAvD2l4pZC52Ktup2xSUPqFl5TvqFhLZjwHu1jq5AA30hXH6XoAAnACIP7PTA7
         EtDKsoAg9yNAXAIjGD5OjCCfWLndZ5HTB+mqcjnffk8Vbdd/bGT+hBV1yQB9SQksFiVR
         1iVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738154581; x=1738759381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJ6UtPrD9602aPjTk5b/AQN/dUeBNKMH7itzLMumKXM=;
        b=FgUjtotKn5jFp4NwK2FqJ/I3xmaS23UffDI4rwwgl9L14Wzqml0GiWnAxt6pS4udhr
         gQzM0yLLAnvtgGhakPvNgywPhKbcLkZ/gAbRuhqJyMijHprugWSRb6SUfsSOUl+3VhME
         Hx2cdHwzXI/+jxUI9NXHP+YZLNe50SPNPM9vUIKvqzBs3WX1cd/nud+UMZO7aQesbBr+
         MK3e7bjtGgJzsHuJULRNWR0/WO+qfm5e8o4Jaj7EAT1fcplqkbnt4CtPbbye85NVMy/I
         OkUijzypSLoHw2DMjCRFVa/Buv2S6esjxRzS+XTfkIP2YmlJXlW7nwkUramk0uqU015P
         X1KQ==
X-Gm-Message-State: AOJu0YzQx3u9ZdN5eboxhlGcHqgWcOJmepAFXwefNwckhjS7QeuA0OGq
	H17KaTFC69ocbDI18/ZKgnrY7N6RoXwE2lXDIQDVA4TM8Kj2PG/5UE5/1SdhunER8xoS4n6SPlI
	Gfkycb/N+RE6LW7r4qAGUxHCTTF4=
X-Gm-Gg: ASbGncsfgF9m7D9z65+cMatTgjRX/GFPnwDMkFzsUIpCCKgQaiQL6k8qZqpJt3S1zp4
	NQje6X6VWIeNXndBHj3Mmst4JQpsCjupcEpxZd1hWDX5vH9uFus/DNBSl5I4EKBnlqmYJmRp5ft
	CwgHvfJZ1GZX1OdjzBxI7zF1t/Ea4c/ms=
X-Google-Smtp-Source: AGHT+IEmrWYiGKYx+/lIA+PcSkX0n9gRsWrZ+hW9YJvROtzXCMZSE3JWRmIO1YbHDjxGa/UoBEfEtWvu6In3FrJ8SOs=
X-Received: by 2002:ad4:5f08:0:b0:6e1:5076:c400 with SMTP id
 6a1803df08f44-6e243c7e239mr35183186d6.39.1738154581320; Wed, 29 Jan 2025
 04:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20250129112406.1660522-1-stefan-koch@siemens.com> <20250129112406.1660522-4-stefan-koch@siemens.com>
In-Reply-To: <20250129112406.1660522-4-stefan-koch@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 29 Jan 2025 13:42:49 +0100
X-Gm-Features: AWEUYZkfPcb5Qxefbbcu_WGfBJqGYIyZWk9hE4IiouP6_PQwn4TcplASMlbcR0s
Message-ID: <CANNYZj-gmzhd+=fC1fd0fbcgHGODLqWtK=8tis6jhqpm-RV_wQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/3] fetch2/git: Add offline build support
 for LFS
To: stefan-koch@siemens.com
Cc: bitbake-devel@lists.openembedded.org, simon.sudler@siemens.com, 
	jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 12:43:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17115

This needs a slightly better explanation. What kind of breakage is
happening currently, and how does the change address it?

Alex

On Wed, 29 Jan 2025 at 12:24, Koch, Stefan via lists.openembedded.org
<stefan-koch=siemens.com@lists.openembedded.org> wrote:
>
> This adds support for offline builds for repos that use git-lfs.
> Offline building is enabled when `BB_NO_NETWORK = "1"` is set.
>
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  lib/bb/fetch2/git.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 7ac690bbe..b7d36c3f3 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -507,6 +507,7 @@ class Git(FetchMethod):
>              # Create an initial regular clone
>              if not shallowstate:
>                  runfetchcmd(clone_cmd, d, log=progresshandler)
> +                self.lfs_fetch(ud, d, ud.clonedir, ud.revisions[ud.names[0]], progresshandler, True)
>
>          # Update the checkout if needed
>          if self.clonedir_need_update(ud, d):
> --
> 2.39.5
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17111): https://lists.openembedded.org/g/bitbake-devel/message/17111
> Mute This Topic: https://lists.openembedded.org/mt/110876223/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

