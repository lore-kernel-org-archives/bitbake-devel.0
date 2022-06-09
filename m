Return-Path: <alex.kiernan@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AAAC43334
	for <webhook@archiver.kernel.org>; Thu,  9 Jun 2022 10:33:22 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web12.9292.1654770796809266419
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jun 2022 03:33:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=BT2it2hY;
 spf=pass (domain: gmail.com, ip: 209.85.208.47,
 mailfrom: alex.kiernan@gmail.com)
Received: by mail-ed1-f47.google.com with SMTP id n28so30603037edb.9
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jun 2022 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVODi0UIkK/oomow5ztaEGxMzguEqd90BHvUuNzJefE=;
        b=BT2it2hYyOhqtK03uU/ZttBRswSFS361xU3eL2Xn8nkpnCyCGqbDk+vfOh4Srpf6IZ
         xGdVTYebrRfOn19mm34y6XHjOA1mFO0ELn79cNfe7D4xg/H9llKfGqpt2ZhM26w7geN2
         qfpB9gsWFfVSffmR+Dw123fMS0IS4zH9T3OEFBh4q4yD/AefAPXvWo3LEFrGjChj3mPL
         pvqgFEy3Qpy66UW84A3Pitj38OV9rPxrBrXvrL7uSV5Elh8SBIPcDZrNB7cjVUa7yCjH
         WD04oj9A1r2/2qICcq6OkFWhMbDt7JRxRXuUnBua/RWHSE1qPjUzK5Yt8kEMzhdJcITP
         sAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVODi0UIkK/oomow5ztaEGxMzguEqd90BHvUuNzJefE=;
        b=Xv3BhIOMuvFkNdFO4VLlFru9OHyta4cYI6vfuZhfxuf//byHJnzxrrzL9Cy2PVLtsh
         C8zLPKLlyEEDVwUhWAW4t6y9sa8OSmhXS1//vn5rOHvcUkoCCz+MI7Yv6ooub2dCy+4k
         Coo8wKeAbcLKXYGxN09vE37v9jaXbs0y3Tmtv8l7oDV5tXOrn7FsMZ8JfI+HyP4Y244v
         JgT8nkz7Okee2OjFVAsQV+0B1I/4cmte2lwuavsbQvxrq+Dh84Q4FkDX8HHllJrto7eh
         /3wRUeywkAvcC2v4wFo1wIBlFAWwhAg1lpqmlhFChHgkkBzfUXnzuNH894SwwEPnCBNX
         LYxA==
X-Gm-Message-State: AOAM531R1QZTYw0IE/8ctnRZvh/1qEr7mSYglRku84FThien0bNOjyqK
	i93aGB6l2l4cL9bXDNo7dxpGQELlhbo+JVKgDB4=
X-Google-Smtp-Source: 
 ABdhPJze02uUTtJl0A80nS6ECIeVTCzbzkF/yhQNlkd+l7/+giQM7ulCFuJaYDREkrDlAfMXaP5lta21+VO39h5KiHg=
X-Received: by 2002:a05:6402:1907:b0:42d:e90e:337 with SMTP id
 e7-20020a056402190700b0042de90e0337mr45114352edz.405.1654770795062; Thu, 09
 Jun 2022 03:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220609070631.23346-1-alex.kiernan@gmail.com>
 <5e781972643ed99e2948ac5a908222a190678475.camel@linuxfoundation.org>
In-Reply-To: 
 <5e781972643ed99e2948ac5a908222a190678475.camel@linuxfoundation.org>
From: Alex Kiernan <alex.kiernan@gmail.com>
Date: Thu, 9 Jun 2022 11:33:03 +0100
Message-ID: 
 <CAO5Uq5QPsf8Lj8qYCibMD-m+0R7Na_ipU4WehYL3Oqu_rk4dRA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] data_smart: Pass flags through variable
 rename
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org,
	Otavio Salvador <otavio.salvador@ossystems.com.br>,
 Alex Kiernan <alexk@zuma.ai>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jun 2022 10:33:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13747

Not that I've found, but I'd really like to use it... I've a layer for
s6-rc (https://skarnet.org/software/s6-rc/) and defining the
configuration using this syntax works really well:

S6_RC_SERVICE_${BPN} ?= "longrun"
S6_RC_SERVICE_${BPN}[producer-for] ?= "${BPN}-log"
S6_RC_SERVICE_${BPN}-log ?= "longrun"
S6_RC_SERVICE_${BPN}-log[consumer-for] ?= "${BPN}"
S6_RC_SERVICE_${BPN}-log[notification-fd] ?= "3"
S6_RC_SERVICE_${BPN}-log[pipeline-name] ?= "${BPN}-pipeline"
S6_RC_SERVICE_${BPN}-log[run] ?= "${@ d.getVar('s6_rc_log') }"

Is the kind of thing I'd like to work.

On Thu, Jun 9, 2022 at 10:58 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Thu, 2022-06-09 at 08:06 +0100, Alex Kiernan wrote:
> > During variable expansion, the flags are not passed through but are
> > discarded which makes constructs such as:
> >
> >   ALTERNATIVE_TARGET:${PN}-foo[name] = "value"
>
> This is a tricky one. I don't think we've ever supported overrides and
> flags combined? Is this in use in metadata?
>
> Cheers,
>
> Richard



-- 
Alex Kiernan

