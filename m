Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0653CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 20:49:14 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web10.477.1755722945534976878
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Aug 2025 13:49:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nCFD25YV;
 spf=pass (domain: konsulko.com, ip: 209.85.160.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c63e84so4124021cf.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755722944; x=1756327744; darn=lists.openembedded.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DoADsamzXDGQ+36t99EvTUNOtLETiphPFGhqb0IKxf4=;
        b=nCFD25YVm2unJcC02C8a4hClu3JSKWAzZ5FAnfoxm9poMCkfNyzksculm/NalACV7M
         zRcxfIoKcZ61i3RwUeH3mYVR6MYTq4EEsIdY7x0e4U+ax5EmXOB8pFXxE4AgccqsPioO
         Wjthv3jR59bAOPktjjLfxh342Sje2EK8m1GlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755722944; x=1756327744;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoADsamzXDGQ+36t99EvTUNOtLETiphPFGhqb0IKxf4=;
        b=vpvMjPxERrd67BqWtRvDTtNlbCHCaDZZDc6vfyI+XKA6gbuEEgaQ9WdFVfJ1qEV00G
         wvVbZ+2BT/xyuI4U8A3Wb9pD/uDXwYheo0MxJ4qWvWlRnO32slW15weuwOSI0vEPdM3P
         zfxeNZXIKgnPr8PwloGTMpMxJ8fXCB6KcRNarqGqB0YwBwxU6jfFhf81EV/+GG/bo5TA
         LsYO3SboCE197r3LoznNH5vcKX0T/f9niFNZYVquPd4KL7wpL/XkoShtow9l37CVtQBy
         G1hZ2sZ3aCmWH0YLCP6+BkBKicyYGbcjEc3dBrv8Ng/aUY+iB62/cKHeBSyNYyB5D+6V
         XvKg==
X-Forwarded-Encrypted: i=1; AJvYcCVkoBeMn3/uCvPNPx0pepotq9ALNQdU9uyEnOch2wD2zhoEFV5JYGgYVR81TxKNvB/8ou/aFeOqPFc9pYWj@lists.openembedded.org
X-Gm-Message-State: AOJu0YwSxMktWdWfPl7wDrkMcW9Y1tGZu/R8JuSbgvzit7UmfK6VTPSI
	AbH6XF+yCuumydsTOm+XcMqB2RGpxsZ5qoBPtmR2b0LURoF2z87y0T233UlWAOqgEBg=
X-Gm-Gg: ASbGnctF2G00BCBejkmr2/p5Sxl9ujr47uSgH80bSHq5uFCOMlVN1+Lke55f0h0uLUm
	77dZEFI/wIhW7m5gqj8FuP1sEX3TmsNLgzxM0NcTppps3xr/PbO67JPzwcW3T+5wOyiNdPv3HUf
	9qKfiYeOxmWqgnVZZOX8S0GkuRz/TVTKqhUumGJXRrWJg2DqO5cyZTVX4M8BzqpGm+p0BEWwjfX
	6i7VqO8gSCI09M+SWNyChhn1Vqu+GzOdhZBmSD+MG+DooFhJEGZ81/dqA54aWIKFFNavbfSQNZh
	35RjzHugT0UhFp9gR4YShAGoaMlz5v2io+uPp8xvinXJZSM+L9igoVcL0PvgXiFDBrEuuF0EV+D
	Y1dkXZw6bGxDib6Wmsz4BEbblJ/eTOfE6J5+X2OnXS/8vDXSxIJrFinIe
X-Google-Smtp-Source: AGHT+IH+TIjXjHkfvSQEWIQMgv4cD1C8BKZBXX+qlCqT5vMLBqeA7okS3tC07RN3/FLvBwFIgsuKcA==
X-Received: by 2002:a05:622a:5c93:b0:4a9:7a4e:7e93 with SMTP id d75a77b69052e-4b291a35ed6mr57847521cf.8.1755722944360;
        Wed, 20 Aug 2025 13:49:04 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e9fd9176a3sm188908485a.40.2025.08.20.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 13:49:03 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:49:03 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
    Tim Orling <tim.orling@konsulko.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
In-Reply-To: <CANNYZj_RWrJxXx6+WZ_px_EWOd9+Wr1TgUEHgGg3rspY5wEECw@mail.gmail.com>
Message-ID: <8db52408-8867-0b10-bc23-114ea02bdd66@konsulko.com>
References: <20250813151523.1855287-1-alex.kanavin@gmail.com> <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org> <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com> <0a06fda681c8b5d94cbccc000e661451c1c49251.camel@linuxfoundation.org>
 <6e562ea3-ea7e-7e27-54ef-5fabc05888b5@konsulko.com> <CANNYZj8y-VCKnzUD2OLihbt4KtYPqdBK4zE3-5mQE84844fYjw@mail.gmail.com> <647b238c-cf12-eb7b-d243-038854180192@konsulko.com> <CANNYZj_RWrJxXx6+WZ_px_EWOd9+Wr1TgUEHgGg3rspY5wEECw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 20:49:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17899

On Wed, 20 Aug 2025, Alexander Kanavin wrote:

> On Wed, 20 Aug 2025 at 22:15, Scott Murray <scott.murray@konsulko.com> wrote:
> > Sure, but my point is that's what I'll be doing every time I set up
> > any project (and maybe reconfiguring it?), so effectively for me the
> > default behavior is not useful.  I doubt I am alone in doing all my
> > development work on a different disk than where /home is on my dev
> > and build machines.
>
> Then there's the option of setting BITBAKE_SETUP_TOP_DIR in environment.

I'll not bother pressing this further since you seem set on the current
design, but my original concern that I pointed out was that I'll always
having to configure that, and likely document doing the need to do so for
users of any project I may want to use bitbake-setup for.  The default
behaviors of other tools in this space do not require that.

Scott

