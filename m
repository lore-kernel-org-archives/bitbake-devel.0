Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E555C0218B
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 16:06:54 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web10.19513.1737475611650039989
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 08:06:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=yvqK8GRx;
 spf=softfail (domain: sakoman.com, ip: 209.85.219.170, mailfrom: steve@sakoman.com)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e399e904940so8776797276.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1737475611; x=1738080411; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4D1az8PnG7z2DqZcO+3N7MV1BXiSGropFpvo4PFSek=;
        b=yvqK8GRxTauy7ZXRN2cDpt6Nczu4WEg0k8WSpgLIJYKfOPbWJuYdGGVJ3x9KuLiOjg
         QDraYrDe410rYipiVRILnqK4IjfeVphCufIgjf4eGjcczT6e8uhjfrHCFKxuqLReRXUY
         vjcRpkAFyTkKcRmZAZESuAc0sMMxT6cXdkr5RhsbZL471WkUySYP/GhYEbH/TssakEvZ
         /72sC9ZMcXPJp+y3TJ4zjh+Kz21rzEKTghCr42epFYO0OBTP5E0IhjVZbSM0Ycul1aUb
         wsWMLiBt8xCtiVQvFtjE29AJoK+u1Y069MqUAaGDLgrmJgW2ZoIebRlpWcykFkW9Gmlc
         hqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737475611; x=1738080411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4D1az8PnG7z2DqZcO+3N7MV1BXiSGropFpvo4PFSek=;
        b=gEblF8JxZu4dBEvkxMvYcuDVqhjHrF9WE3Je1IpS014QJ6FOmk9XaaS+evk2RMEjHx
         kILhDs3KGkN6Tsm5uAzAC4rsxy5R4gJTx7feE9Pjy/AAJmKDAElXTnEYcsd+IxsAOOYi
         ggb3nCumQAY8esWIjrL0IE/1M5yonI5WSbQBNjQsadUNCzHvbZDu40DVMw/OpIC0F+0J
         6K0/gNQGs2kVB8dXtzVD/Wzr5RQ4Ste6llRS3wyqIsnjPU/MA17uQad9+BKesgq7aGnR
         8CAm52uJVI+6Qr2BQAWbQFx6vkZziDO4M5xjcnFD1UZ9aztxFn/o+AlnLxKAdVmOm6H9
         vxsQ==
X-Gm-Message-State: AOJu0Yz1y48meX7Bu3kPu4jNhqj3R12ADA6Hy0UodnZQVyNPjPDNLCtc
	1qpMqfRbDzUU0pEH9U4O7nS6J0cUYEC1G8HL+8sFavghR+xSrfpPfsu71eSvoZ83uyqfu1Vjx8m
	jakqb2dvbsEKQ6aVIu9TfOxMAi4qVCCDoQAaXRg==
X-Gm-Gg: ASbGncuVAlyoDQcnLOrbHyp/Y4RysX7n2WqFndGvD3XwTRBQmmMVIgtWtEuhY+AFzQL
	t+PSpmosmrMv9C26ylPKq/UkSFpaCG8yrDWnh3kndlPGzXRn+YGE=
X-Google-Smtp-Source: AGHT+IGGPGeY44pDoR8e0kgtHa0jYLUKtIbDXCXN3yUR66Rt0MKQPCt7KACtc2FppTANvyKpMAbYzqC/qTaY2X2VQzc=
X-Received: by 2002:a05:690c:ece:b0:6ef:a4ec:f69b with SMTP id
 00721157ae682-6f6eb677e0emr155537677b3.10.1737475610714; Tue, 21 Jan 2025
 08:06:50 -0800 (PST)
MIME-Version: 1.0
References: <181887D232995242.18084@lists.openembedded.org> <DM8PR12MB543073B6438DC6E0CA8AAFED8BE62@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB543073B6438DC6E0CA8AAFED8BE62@DM8PR12MB5430.namprd12.prod.outlook.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Tue, 21 Jan 2025 08:06:40 -0800
X-Gm-Features: AbW1kvZ-2ihgMKQNeiWUwz31_OCV-nfNeDh1PVZzhFKrjZOx0uJEF9Bb2GfrJbI
Message-ID: <CAOSpxdam9u2hz_3kn_nz15PN6T68ZZTGfshCKUw_+mkxn_PRxA@mail.gmail.com>
Subject: Re: [bitbake-devel] [scarthgap][2.8][PATCH 1/3] ui/knotty: print log
 paths for failed tasks in summary
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 16:06:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17041

On Tue, Jan 21, 2025 at 7:59=E2=80=AFAM chris.laplante@agilent.com
<chris.laplante@agilent.com> wrote:
>
> Hi Steve,
>
> Just wanted to check to see if you saw my backports to Scarthgap from a f=
ew weeks ago. It's definitely possible I did them incorrectly.

Sorry, I somehow missed them!  Will work on those today.

Thanks for the reminder!

Steve

> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <bitbake-
> > devel@lists.openembedded.org> On Behalf Of Chris Laplante via
> > lists.openembedded.org
> > Sent: Tuesday, January 7, 2025 4:54 PM
> > To: bitbake-devel@lists.openembedded.org
> > Cc: steve@sakoman.com; LAPLANTE,CHRIS (Agilent USA)
> > <chris.laplante@agilent.com>; Richard Purdie
> > <richard.purdie@linuxfoundation.org>
> > Subject: [bitbake-devel] [scarthgap][2.8][PATCH 1/3] ui/knotty: print l=
og paths
> > for failed tasks in summary
> >
> >
> >
> > External Sender - Use caution opening files, clicking links, or respond=
ing to
> > requests.
> >
> >
> > From: Chris Laplante <chris.laplante@agilent.com>
> >
> > When tasks fail, it's very frustrating to have to scroll up to find the=
 log path(s).
> > Many of us have the muscle memory to navigate to the 'temp'
> > directories under tmp/work/, but new users do not.
> >
> > This change enhances the final summary to include log paths (reported v=
ia
> > bb.build.TaskFailed events). Here's an example:
> >
> > NOTE: Tasks Summary: Attempted 856 tasks of which 853 didn't need to be
> > rerun and 3 failed.
> >
> > Summary: 3 tasks failed:
> >   virtual:native:/home/chris/repos/poky/meta/recipes-
> > core/ncurses/ncurses_6.5.bb:do_fetch
> >     log: /home/chris/repos/poky/build/tmp/work/x86_64-linux/ncurses-
> > native/6.5/temp/log.do_fetch.1253462
> >   /home/chris/repos/poky/meta/recipes-
> > core/ncurses/ncurses_6.5.bb:do_fetch
> >     log: /home/chris/repos/poky/build/tmp/work/core2-64-poky-
> > linux/ncurses/6.5/temp/log.do_fetch.1253466
> >   virtual:nativesdk:/home/chris/repos/poky/meta/recipes-
> > core/ncurses/ncurses_6.5.bb:do_fetch
> >     log: /home/chris/repos/poky/build/tmp/work/x86_64-nativesdk-pokysdk=
-
> > linux/nativesdk-ncurses/6.5/temp/log.do_fetch.1253467
> > Summary: There were 3 WARNING messages.
> > Summary: There were 6 ERROR messages, returning a non-zero exit code.
> >
> > Each log is rendered as a clickable hyperlink in the terminal. See
> > https://gist.git/
> > hub.com%2Fegmontkob%2Feb114294efbcd5adb1944c9f3cb5feda&data=3D05%
> > 7C02%7Cchris.laplante%40agilent.com%7C5b537b9495ee47796cca08dd2f66
> > 26a2%7Ca9c0bc098b46420693512ba12fb4a5c0%7C0%7C0%7C63871883797
> > 6736782%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOi
> > IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0
> > %7C%7C%7C&sdata=3DS%2BTUoiFdgIoeVg0J%2F7VWsV91R3Qa14Lcsvff8SjTDlc
> > %3D&reserved=3D0
> >
> > Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/ui/knotty.py | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py index
> > f86999bb0..5956ab177 100644
> > --- a/lib/bb/ui/knotty.py
> > +++ b/lib/bb/ui/knotty.py
> > @@ -640,7 +640,7 @@ def main(server, eventHandler, params, tf =3D
> > TerminalFilter):
> >      return_value =3D 0
> >      errors =3D 0
> >      warnings =3D 0
> > -    taskfailures =3D []
> > +    taskfailures =3D {}
> >
> >      printintervaldelta =3D 10 * 60 # 10 minutes
> >      printinterval =3D printintervaldelta
> > @@ -726,6 +726,8 @@ def main(server, eventHandler, params, tf =3D
> > TerminalFilter):
> >              if isinstance(event, bb.build.TaskFailed):
> >                  return_value =3D 1
> >                  print_event_log(event, includelogs, loglines, termfilt=
er)
> > +                k =3D "{}:{}".format(event._fn, event._task)
> > +                taskfailures[k] =3D event.logfile
> >              if isinstance(event, bb.build.TaskBase):
> >                  logger.info(event._message)
> >                  continue
> > @@ -821,7 +823,7 @@ def main(server, eventHandler, params, tf =3D
> > TerminalFilter):
> >
> >              if isinstance(event, bb.runqueue.runQueueTaskFailed):
> >                  return_value =3D 1
> > -                taskfailures.append(event.taskstring)
> > +                taskfailures.setdefault(event.taskstring)
> >                  logger.error(str(event))
> >                  continue
> >
> > @@ -942,11 +944,19 @@ def main(server, eventHandler, params, tf =3D
> > TerminalFilter):
> >      try:
> >          termfilter.clearFooter()
> >          summary =3D ""
> > +        def print_hyperlink(url, link_text):
> > +            start =3D f'\033]8;;{url}\033\\'
> > +            end =3D '\033]8;;\033\\'
> > +            return f'{start}{link_text}{end}'
> > +
> >          if taskfailures:
> >              summary +=3D pluralise("\nSummary: %s task failed:",
> >                                   "\nSummary: %s tasks failed:", len(ta=
skfailures))
> > -            for failure in taskfailures:
> > +            for (failure, log_file) in taskfailures.items():
> >                  summary +=3D "\n  %s" % failure
> > +                if log_file:
> > +                    hyperlink =3D print_hyperlink(f"file://{log_file}"=
, log_file)
> > +                    summary +=3D "\n    log: {}".format(hyperlink)
> >          if warnings:
> >              summary +=3D pluralise("\nSummary: There was %s WARNING me=
ssage.",
> >                                   "\nSummary: There were %s WARNING mes=
sages.",
> > warnings)
> > --
> > 2.43.0
>

