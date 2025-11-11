Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1954FCCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 08:47:37 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13224.1762850827922151340
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 00:47:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=a7uxcG32;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-880439c5704so32239956d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 00:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762850827; x=1763455627; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UVedtTEZBwkffkufXOSrN6IdvyWjsa5HbDr6mlT80Es=;
        b=a7uxcG32/FUWupp+FzK7b8kjIy4y01gXVaq5klsPXodt6VoVt3cWCxAusoLJfm4dK/
         oqsdFGyb1Ed0obEdZvyX2XfC00ih8pjgeqwlL4XQSQ1KVlj5yeygzu3E1KOkTFKnduUW
         3vKG2lCsboaiFM0kl8dWB3npwOBQoWNc3baOWevPLkmQGjK3jr8qhu8UkfjufXR2RByv
         oCT8BfXXD1IRa7XKCfxvM4W16jmMZ7hMC0Kb+30lkPkmbaiLgts1XSyHghAG7O9D7irA
         xIvv9bCaKAx6o51UTH9v+tYHXHQHRwDsJ/GzMXbeG7j51zzlCMPAyOq4kewk1xjxMT++
         hEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762850827; x=1763455627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVedtTEZBwkffkufXOSrN6IdvyWjsa5HbDr6mlT80Es=;
        b=dginnWLOFg8Qu6CmRqZAfG9deycKSFfG3rZ1IB/vLHuCmTxThTIgxEvNAkdG4yyqBZ
         f71wqCRu4WggADYhkmHW9tIsw4DrtNsmFSGi9rxpm59dVChka5/ElpSmLbjMKFCWS8n9
         p1iuaIN8lbvjeooDx2W1a093R1i9lE4OJJRUKUS6p4SmIkUPjsonQIqfXKGrQ3Qk8lJp
         6YjWBhfAfcYp2Se+IcXbLFETKJ1+vlp+44s5Sg4G9OE60Bvv3w9lhRWwIUlx3l6WuvpL
         8Uy7+EJAI5O46Vmvx0FXQQAMbt9FPyqLwmc2dpCMAdSiMx7LXZDyu8ylr2q/PxKoxVbL
         UgjQ==
X-Gm-Message-State: AOJu0YxXJtBlKN9CBjGWg6fXvBd05uVhkTa6r2AQ9gNGUM8JUDiX2SgI
	+j9flJpUP5F3scqkwV7wGtcrP4ZrtIr0to4N0bgf2zzylZ26nc+9K2A2CywkQy1HNz8a+tp4ZUA
	/mESUj6Aspv54qjbg3EaLlQq2Xjzef8zq7aWX
X-Gm-Gg: ASbGncsOOT83w1PhISDhnx6nkBunEZ1BG/VKLYtD58WA4TVIYp/YfEZXDXIkL/W/usu
	SttGbAksy9R98M1ujY0x+pU8AaEl251SSoQxqDIslU5bmq74rGdbGzGf0DiGaTfbgYrUtifFBK/
	ikHqCb2/6h4triOylDalyUaPtxIzaSztSvlEyqU6QPsXK9cuUv/IypwMN5pZLNqBAjRq29qLlkg
	BZHubp57TyzH3ZzPeVdJb5Dk44j1aOm8Q+s+Nl8xYbAmN1dnVwkfAB4C5nlK8Y=
X-Google-Smtp-Source: AGHT+IFaEJ8o4crVkL68pNJpJtPi6m/nSuqkwlZ1kaapXNgGzVOloAXytCMG02avqroT48vy0WMJJnOqYAzetKckQvM=
X-Received: by 2002:a05:6214:aca:b0:880:638f:1a1e with SMTP id
 6a1803df08f44-882386dcce1mr153282306d6.46.1762850826733; Tue, 11 Nov 2025
 00:47:06 -0800 (PST)
MIME-Version: 1.0
References: <CAJdd5GZAzk8DS1UUsOjr0QbOpkpU7XvXCb-9kforSRv0MZ65FA@mail.gmail.com>
In-Reply-To: <CAJdd5GZAzk8DS1UUsOjr0QbOpkpU7XvXCb-9kforSRv0MZ65FA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 11 Nov 2025 09:47:05 +0100
X-Gm-Features: AWmQ_bnvH3UbxpTc5YCkd0DTcIvZW_YHeV-gGI53M-RU6Y91KbkW7W4-hoNiGIw
Message-ID: <CANNYZj_BCHsZuiO4CidLQJ8ofZU3ip77jC3eEy2Po+UiFGsWhA@mail.gmail.com>
Subject: Re: bitbake-setup topdir setting
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 08:47:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18319

On Mon, 10 Nov 2025 at 18:49, Joshua Watt <jpewhacker@gmail.com> wrote:
> in order for this to work as I would like. Based on my understanding,
> I don't think that there is a legitimate use case for setting the
> top-dir-prefix (and top-dir) in any context other than the global
> configuration file. Since this isn't really a valid option, and it's
> pretty confusing if you do the wrong thing, the tool should error if
> the user tries to set these options in any context other than the
> global one.

Yes. I'd even say there's no need to error: just special case the
setting to always go into the global file (and print a special note
about it). Can you make a patch?

Alex

