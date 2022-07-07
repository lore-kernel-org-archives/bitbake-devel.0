Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF88C433EF
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 16:55:57 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web09.106.1657212952239581891
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Jul 2022 09:55:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ebPsjKOk;
 spf=pass (domain: gmail.com, ip: 209.85.215.170,
 mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pg1-f170.google.com with SMTP id r22so12677773pgr.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Jul 2022 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S46gnYs25+DeRIYPO1RmkG8d4pwb/3e/tgusSvxCIyg=;
        b=ebPsjKOkJcQekB2Hc3tMcjpqZaVXC0OiXElpAFqq/B1mp6zAICZqNH9e8jhdsILzcR
         ziFziJn1Pd3qRC3IAkj3yh8wJJCJjLKgYKHjM5iKd6hDn5B9mq0wJcRkiBlltfanYoac
         asqwVby+cp0PIcBj9kNAWcDM8vKCbWWSgu6Dh1h/JspRQ0ALL01j8WcNRnF5zE1ZV92P
         e499jtUZVpIWOw/ATox3dnbO5NIdlOqjj+1d3BdecrowOIw84Dyl4CGPVJmfR7MjZiwN
         ryQ3GMNz35pEP6tQot3xlkkrSP12IRmxwVHMxu1Js/ZWisfaXeqGrnmIUELnhbqSs3j0
         W3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S46gnYs25+DeRIYPO1RmkG8d4pwb/3e/tgusSvxCIyg=;
        b=Q1qk/36rBQQqjFCfoRMjnyre4kh0OLTBiGDxkdsdKaJ1c4aFkcsYFtJOVhgANGgYWG
         j6ipPVt7DHxieqeCb/fzzm0eOQFX0iLk6LjrcxecHs00tL1TQtzPHB2B0xCfQX2Sezu5
         d2P3+j4feLdSEca/ZIZ9ObgnnRrz0n8tWJ0wtc1rHXYfJv41u8ZSHhzilzJ/VHWHlkkJ
         anNwH6mF4Us/UJi8BsApP7VOv9OBoX0H6a6gqkKm/zqrtZBJQpA16yVPBVU/pnUYScxu
         6mJZgZXfSYZhWbAXvMtQzFy802yeqe8J9heTLn1ggn3lMMbFy/pwbUuCoKpAMBP2UaAK
         hZag==
X-Gm-Message-State: AJIora+8rZSIE+YzA7wZWF33Inf2YRcQas77B7KgEkQsarsJu0ge61Mq
	SjG1T4/Hp3zIHNIvVkY9rk+5t3djLxR79hXGe4k=
X-Google-Smtp-Source: 
 AGRyM1tbE7vz88j9F5JVDOFkdeDvEvHV1V3natvJmgJG0jT876Mkj89ULBiwGs/kVxjTkC0b6CNP8jUgnxj+w2hO1B4=
X-Received: by 2002:a17:90b:1807:b0:1ef:8aa5:1158 with SMTP id
 lw7-20020a17090b180700b001ef8aa51158mr6408567pjb.163.1657212951538; Thu, 07
 Jul 2022 09:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220705174630.13360-1-t-maiaxiao@linux.microsoft.com>
 <CADkTA4O_bxHU9hdEiMRo=yKoY1HMd-OCzX2ey9VFJqDs08coJQ@mail.gmail.com>
 <CADkTA4P_9hfBFO1Pbj+cMpiaBQPL3xaCOPgnRYnO=tyKVS0n-g@mail.gmail.com>
 <970e2ed4c836e291aa9845849c0d3d86b57f849c.camel@linuxfoundation.org>
 <d6f373c-eb88-e765-7973-9d4af6de40ee@linux.microsoft.com>
In-Reply-To: <d6f373c-eb88-e765-7973-9d4af6de40ee@linux.microsoft.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Thu, 7 Jul 2022 12:55:39 -0400
Message-ID: 
 <CADkTA4NaD1SKgOpMdM4ap=Gv7g7KXc_MjUt1eLe-J2=i9_KEUQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Check srcrev exists in
 checkstatus()
To: Maia Xiao <t-maiaxiao@linux.microsoft.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Jul 2022 16:55:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13808

On Wed, Jul 6, 2022 at 4:14 PM Maia Xiao <t-maiaxiao@linux.microsoft.com> wrote:
>
> >> Actually never mind on this first point, assuming that this isn't run on
> >> all fetch paths (I didn't check that).
> >>
> >> But my second comment about the depth is something to consider.
> >
> > Yes, I'm also remembering comments someone made to me recently that
> > many git servers don't support limited depth clones because of the load
> > they put on the server.
> >
> > I appreciate this was moved to a newcomer bug as I think we assumed
> > there was a straightforward way to remotely ask "is revision X in the
> > repo" but it is looking like that might not be that easy :(
>
> Going off what Bruce said, a potentially "softer" way to do this is to
> keep self._lsremote(..) as the True condition, but we additionally try
> to fetch the specified srcrev and just log a warning if that didn't
> work.
>
> If we feel reluctant about the additional fetch, another thing that we
> could still do is to log a warning if the srcrev isn't a tag / at the
> top of some branch (i.e., not in the ls-remote). I'm not sure if it is
> (un)common enough for that check to make sense, though.

Either of those options makes sense to me. As I mentioned in my
follow up, I wasn't sure if the revision checking was in the hot path
(i.e. run on every git fetcher opportunity) .. if it is in that path, then
we have to be more careful.

I thought the 2nd option you mentioned sounded interesting, but
it is quite common for branches to move on quickly, while we build
an older tag that is a release point. So it could potentially generate
a lot of warnings.

Bruce

>
> Happy to offer a v2 patch if there is interest in either. Thanks for the
> discussion, folks!
>
> ~maia
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13806): https://lists.openembedded.org/g/bitbake-devel/message/13806
> Mute This Topic: https://lists.openembedded.org/mt/92190251/1050810
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [bruce.ashfield@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

