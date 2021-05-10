Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.5068.1620687904300808345
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 May 2021 16:05:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=DjGifPhf;
 spf=softfail (domain: sakoman.com, ip: 209.85.221.53, mailfrom: steve@sakoman.com)
Received: by mail-wr1-f53.google.com with SMTP id v12so18204485wrq.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 May 2021 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZmqHrpuTbr34dp+vy6ImZ5v1k3au4ZnrOrx4FiKjsE=;
        b=DjGifPhfxxtd2lDYM/wP0a65yH90qbyF0llqf5mh+GMNWnETOhlNJNJ1cqcYm2ecnA
         hC0X1OwcKUDZLZ44+SJYHjCU6whlrvfqSEtOIbr2m/eCS3xpjao5NuZm2q6jQS0/kBkH
         6jFw1e76IwSFnY2Zq1cHc10GKUpKliAmRDxatxxZ/UqnEftnsHoRFAgXHOODHSbCeuLp
         2LLV7JQ4bK3qc1GgLPuh/v7ouzDt4d5ydMqyadKTjOeWnuuswJlIK9GwdUPSgO+Rl9Al
         SkK/5AUpEMZDFdSNarSu9y8/Kn58QbbDL/L6X2ggxwlPKYTSBn9ryKnXXd7y0/eSnSbI
         vroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZmqHrpuTbr34dp+vy6ImZ5v1k3au4ZnrOrx4FiKjsE=;
        b=G4VX5kUug4WUxLgHqMoXoJQfeRKzdPrlwWwHfVRKrmkAxXsJKmcIRR8OeThQ0ecAH+
         pWpB4R/n/z2uovFr/Fw3EndBZd/WMuead+49fiIOZ49sVbegB02AFJkLfVKloN7wiaLq
         c5PVPCKIp5gQ3o9cT2r75auMbPkm4kIn2P54NuGiMcz2AaO/VSBkjSg9kc128uDfhn/5
         I3LRVOLWqsyOt3U6PhrO4iw+lAAZiT2zMhozayyI80wO2W8jLEQXkC9CT3MuzZC4Asab
         dSvPhA75Jm/M8mqs8L0LSVAFYbDjj4oWX5fz6RrZWSNAQ4zuh/FRvz8lcTwLi25iRvdi
         FOVA==
X-Gm-Message-State: AOAM531pobWmw6DOvyR0/Cao/odeUbs0hWnJzUyxqJDybapOrVTfzEuQ
	Hb8U4YO4Ey5u1zFNzWU3gVv4OQ+oDzj1U1bH5VpztA==
X-Google-Smtp-Source: ABdhPJwHGcxS8krbKZ8ws9fYbT1VDmXsgGV8p1u2mdkKAV+vY6KAyeXQwG1ylxT8klxfu4Z7zvlzHekE50wxznCukZU=
X-Received: by 2002:a05:6000:136b:: with SMTP id q11mr33299710wrz.350.1620687902814;
 Mon, 10 May 2021 16:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620655927.git.steve@sakoman.com> <99fa63415cabf3129f149c2cdb557ec18b06b98a.1620655927.git.steve@sakoman.com>
 <008ee8e752e12b71edeb2b59062bec7a32a22bac.camel@linuxfoundation.org>
In-Reply-To: <008ee8e752e12b71edeb2b59062bec7a32a22bac.camel@linuxfoundation.org>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Mon, 10 May 2021 13:04:50 -1000
Message-ID: <CAOSpxdaEY81mPPHWSD+ncL_=DBRkrC6J-vK7Wy-S_2HWpnKPFA@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 3/4] runqueue: Fix deferred task issues
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, May 10, 2021 at 11:11 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Mon, 2021-05-10 at 04:15 -1000, Steve Sakoman wrote:
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> >
> > In a multiconfig situation there are circumstances where firstly, tasks
> > are deferred when they shouldn't be, then later, tasks can end up as
> > both covered and not covered.
> >
> > This patch fixes two related issues. Firstly, the stamp validity checking
> > is done up front in the build and not reevaulated. When rebuilding the
> > deferred task list after scenequeue hash change updates, we need therefore
> > need to check if a task was in notcovered *or* covered when deciding to
> > defer it. This avoids strange logs like:
> >
> > NOTE: Running setscene task X of Y (mc:initrfs_guest:/A/alsa-state.bb:do_deploy_source_date_epoch_setscene)
> > NOTE: Deferring mc:initrfs_guest:/A/alsa-state.bb:do_deploy_source_date_epoch after mc:host:/A/alsa-state.bb:do_deploy_source_date_epoch
> >
> > where tasks have run but are then deferred.
> >
> > Since we're recalculating the whole list, we also need to clear it before
> > iterating to rebuild it. By ensuring covered tasks aren't added to the
> > deferred queue, the covered + notcovered issue should also be avoided.
> > in the task deadlock forcing code.
> >
> > [YOCTO #14342]
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > (cherry picked from commit 3c8717fb9ee1114dd80fc1ad22ee6c9e312bdac7)
> > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > ---
> >  lib/bb/runqueue.py | 4 ++++
> >  1 file changed, 4 insertions(+)
>
> I've now got mixed feelings on this one. We are seeing problems in master
> and this change isn't 100% right.
>
> Sadly I don't have a patch which is working in all cases either. I'll aim
> to try and work on it further this week. There is a better patch in master-next
> but it isn't right.
>
> Equally, the behaviour in dunfell isn't right either :(

True, but this patch does seem to improve the behaviour in dunfell.
I've carried it for a few weeks now and haven't had any further
covered/not covered issues.

So I am OK with including it now, and cherry-picking your final fix
when it hits master.  Any objections?

Steve
