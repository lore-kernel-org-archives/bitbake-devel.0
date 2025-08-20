Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49729CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 23:58:45 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web10.17.1755734320486779317
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Aug 2025 16:58:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=eu+rvw5m;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b134aa13f5so5524481cf.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 16:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755734319; x=1756339119; darn=lists.openembedded.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CilmZelYAk3rajB/4hIlnAAg1poZ9Wi/7IeQlxpBg+g=;
        b=eu+rvw5moJCQMFxXlYLPCdhIyEIQ9NSaqMMIH47u5FPdPvuiM5ohUA9H52ICeTipl+
         xEOasIH5DBrw6RacJSomdzFwoH7sAzgsy2juxBBEL4rKROcVXvLnrVq92yfKjZxH37sy
         dQSevOhpTXYG89z8nhf4ZzJTdg+HWMFDwkdOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755734319; x=1756339119;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CilmZelYAk3rajB/4hIlnAAg1poZ9Wi/7IeQlxpBg+g=;
        b=EdEm62GJ8O6M275/JHC0d0ge1vK24nfs06rCAnps0s8gCmAiiNc6ihYyD6HNqbaLY6
         nYDut6B6cJQAmdgASbK4rpJQ7XRYT50z6UUEtsfIdaBtF3rhEX02+IicS2xof6QSN+OB
         IPOgn+2QerDHU6kGmqLa6o8Eg9cTVtqoQTR8PH65i1LZ+LFqITqkY/NO90WY8L03dG9n
         t62ECkUiNEzFXEiUCFwfVZfxF4TSqYJDb2DTfujxWFn3woCU6URZ6zurkcnO+/kWUR5o
         aF9VGqvXs3EsJzpmffXSrK0TpYn1ucl6o6bmGzsr+0o8GkmLnru5cNi/0WXEBgycquDB
         mkwg==
X-Forwarded-Encrypted: i=1; AJvYcCUVaWchvgeCshqjIu6xEOb6OjVRICy3FwCLPDfNwyZ8mGkwNw84CAWkLcI1iheZ5IX8MmXmcl6rgdOMn3LJ@lists.openembedded.org
X-Gm-Message-State: AOJu0YyJifh2pQnOyn9oc/ONpA0aANBkp6PYfJa1PFheS1KbVYcI22v1
	XsB7O69U9bnze/FTpHUvPu3F83ykco+ch844VowwA1HIFRptQ80Y6mJbOWNS3jpzKH4=
X-Gm-Gg: ASbGnctfOHxOj6n2tzCV3EB1YWtpgKBpBrksDV59WJRFv970G0NxmiFfIHSw/7cB9vt
	HUT6pluPJquB7fqmyoet7o4doavEUWv5SajTorxJXSrCE+RJmZ3vSzxgJofobcJiWGNuBztjBZk
	7W5YQW5Q0dwiBeZ8hELZSalBB6BCje4W/O9K2fyFM2K9F3GCuhOA9g/aWMmhWxf+AvnhzXWHuax
	FoiGf98bmNe2joKyDoWQLqsUH2LHIBYb1+KeJtH9NOYp6JmoGo7Euzyuk0VQSSpiTnurQxqKisS
	nb331uLHrDov54IjLg3HluDpHgPXdyfdS+MDjdsMb6coqepmiWb/ntt/7KGw4M3Qw7GyQguBzi6
	x5aMRGMyW7gguijqKib/rcf9q//UHQbshthz50DSd5rYg7q14NU2RfXgX
X-Google-Smtp-Source: AGHT+IH8t2+D+d2oAsle2i3cPaApSZrT20ank1/DzyrQsQ+84z2R0OPLUDVLXZHIjt1i/oIrkdOPaw==
X-Received: by 2002:ac8:5ccc:0:b0:4b0:c1c8:ba6b with SMTP id d75a77b69052e-4b29fa3c40cmr5286551cf.23.1755734319446;
        Wed, 20 Aug 2025 16:58:39 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc1aa56sm93946041cf.7.2025.08.20.16.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:58:38 -0700 (PDT)
Date: Wed, 20 Aug 2025 19:58:37 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
    bitbake-devel@lists.openembedded.org, Tim Orling <tim.orling@konsulko.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
In-Reply-To: <3216445584018ee9b8f2b49ff5554624a69c604b.camel@linuxfoundation.org>
Message-ID: <4f3b985b-4b54-7e5d-a21f-887f8587a495@konsulko.com>
References: <20250813151523.1855287-1-alex.kanavin@gmail.com> <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org> <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com> <0a06fda681c8b5d94cbccc000e661451c1c49251.camel@linuxfoundation.org>
 <6e562ea3-ea7e-7e27-54ef-5fabc05888b5@konsulko.com> <CANNYZj8y-VCKnzUD2OLihbt4KtYPqdBK4zE3-5mQE84844fYjw@mail.gmail.com> <647b238c-cf12-eb7b-d243-038854180192@konsulko.com> <CANNYZj_RWrJxXx6+WZ_px_EWOd9+Wr1TgUEHgGg3rspY5wEECw@mail.gmail.com>
 <8db52408-8867-0b10-bc23-114ea02bdd66@konsulko.com> <3216445584018ee9b8f2b49ff5554624a69c604b.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-754103293-1755734318=:30758"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 23:58:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17901

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-754103293-1755734318=:30758
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 20 Aug 2025, Richard Purdie wrote:

> On Wed, 2025-08-20 at 16:49 -0400, Scott Murray wrote:
> > On Wed, 20 Aug 2025, Alexander Kanavin wrote:
> >
> > > On Wed, 20 Aug 2025 at 22:15, Scott Murray <scott.murray@konsulko.com> wrote:
> > > > Sure, but my point is that's what I'll be doing every time I set up
> > > > any project (and maybe reconfiguring it?), so effectively for me the
> > > > default behavior is not useful.  I doubt I am alone in doing all my
> > > > development work on a different disk than where /home is on my dev
> > > > and build machines.
> > >
> > > Then there's the option of setting BITBAKE_SETUP_TOP_DIR in environment.
> >
> > I'll not bother pressing this further since you seem set on the current
> > design, but my original concern that I pointed out was that I'll always
> > having to configure that, and likely document doing the need to do so for
> > users of any project I may want to use bitbake-setup for.  The default
> > behaviors of other tools in this space do not require that.
>
> You'd always have to configure it because you want no external
> interference in builds even if that was limited to sstate/sstate
> mirrors/dl_dir? Or you don't believe dl_dir/sstate can be shared
> between builds/projects?

I will always have to configure it because I don't want those in some
default directory in $HOME, and there's going to be times I don't want
them shared at all.  With respect to sharing, IMO it depends on the
project.  I tend to keep downloads and sstate split by branch, as
master branch has so much churn that it complicates pruning (which is to
some degree an unsolved problem that everyone has their own ad hoc
approach for).  I also tend to not share sstate across significantly
different customer projects that use less common layers, again because
it makes pruning easier.

> I do understand your point but I also suspect there is some level of
> common user setting we should start trying to take account of. If that
> means adding some sanity check mechanism to only allow certain
> variables from site.conf, that is something we can look at.

I'm not sure I follow your train of thought here?  If you mean not
allowing overriding DL_DIR or SSTATE_DIR from site.conf, I'd be strongly
against that idea.

Scott

---1463811583-754103293-1755734318=:30758--

