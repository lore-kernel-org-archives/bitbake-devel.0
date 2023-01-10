Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A19C46467
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 16:35:26 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.108935.1673368521569126720
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Jan 2023 08:35:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UzsVLGwU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso10527130wms.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 08:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QW793CoB/geSwyAdwoXwdPXK9npMw9m601+i69WeldA=;
        b=UzsVLGwUlHxZwBE6fl1Qu2YCdPBCoWj8yu7uu+ODTEsSC3UqYwhjtYo1Rv9O+tp5Xl
         QdP4AWqMuP816mleFGtgyLBWLPn7x8n8ikmCWEQ4KYq+8COr7GxbjBPjPQJw+1j2zCmx
         WYasDM/QVPykMAsOzzVjizHQ+Mr0wnM+ONubM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QW793CoB/geSwyAdwoXwdPXK9npMw9m601+i69WeldA=;
        b=HLysP5SmtgVJMdZKCMmzTikesh3Wq4TPKKCcjiJu13Qyx9yjhYfERamMwGipT44ZRh
         0s1GO3AVcE7qy8re2xgIObTZP0J2wsKfObauliW7/Dcx7xryKasAI+JXvbY6U3sEceT8
         Y6XmOUE4/ZdNDLqDN6oFYe3yuM+bb82lRAY14bnFKJ7n2HwOkMtZIvYXvQ3USxrGSIpG
         HN/ZFsr282kO5e1fU+1g42w3p4aZMvXcI95WtzLBRKMN4ul8rlql7PD9IjAaNXnug1zB
         0RuANWcNZYvAiRFoP5u6Q5txxZOuvTTMAqL/klSq26PW3K9i8m/rNCrTby5NMoaXi3vI
         qOxQ==
X-Gm-Message-State: AFqh2krhLFdx4q4WQ5MyDA4UiHXLlfvtV2ShypZ52xLM8to8z55//GJo
	olteiD0t+XeIalCHatYwgej06w==
X-Google-Smtp-Source: AMrXdXsl6BzV6PQqGiIQB+5wmIOuuP2CG3IPaae7l7l02FNGNzOWQbMvBRza+hNG+i0j3bgFZl/XZw==
X-Received: by 2002:a05:600c:54ef:b0:3d0:5254:8a43 with SMTP id jb15-20020a05600c54ef00b003d052548a43mr60615586wmb.38.1673368520005;
        Tue, 10 Jan 2023 08:35:20 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ef35:464f:aac3:7a? ([2001:8b0:aba:5f3c:ef35:464f:aac3:7a])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b003c71358a42dsm26921009wmq.18.2023.01.10.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:35:19 -0800 (PST)
Message-ID: <0dd00c361543bf405a2e61bdf2aa512d8712b776.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] process/cooker/command: Fix
 currentAsyncCommand locking/races
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Jan 2023 16:35:18 +0000
In-Reply-To: <CAJdd5Gbd5YCE1AFMsiRh7NkDWBzB60jubdVJEMPbaNdrdKddrA@mail.gmail.com>
References: <20230110160302.1470163-1-richard.purdie@linuxfoundation.org>
	 <20230110160302.1470163-2-richard.purdie@linuxfoundation.org>
	 <CAJdd5Gbd5YCE1AFMsiRh7NkDWBzB60jubdVJEMPbaNdrdKddrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 16:35:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14299

On Tue, 2023-01-10 at 10:11 -0600, Joshua Watt wrote:
> On Tue, Jan 10, 2023 at 10:03 AM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >=20
> > currentAsyncCommand currently doesn't have any locking and we have
> > a conflict in "idle" conditions since the idle functions count needs
> > to be zero *and* there needs to be no active command.
> >=20
> > Move the changes/checks of currentAsyncCommand to within the lock
> > and then we can add it to the condition for idle, simplifying some
> > of the code.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/command.py        | 28 ++++++++++++++--------------
> >  lib/bb/cooker.py         | 12 ++++++++----
> >  lib/bb/server/process.py | 19 +++++++++++++------
> >  3 files changed, 35 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/lib/bb/command.py b/lib/bb/command.py
> > index c325abbcda..c3dc872d0d 100644
> > --- a/lib/bb/command.py
> > +++ b/lib/bb/command.py
> > @@ -51,13 +51,14 @@ class Command:
> >      """
> >      A queue of asynchronous commands for bitbake
> >      """
> > -    def __init__(self, cooker):
> > +    def __init__(self, cooker, process_server):
> >          self.cooker =3D cooker
> >          self.cmds_sync =3D CommandsSync()
> >          self.cmds_async =3D CommandsAsync()
> >          self.remotedatastores =3D None
> >=20
> > -        # FIXME Add lock for this
> > +        self.process_server =3D process_server
> > +        # Access with locking using process_server.get_async_cmd()/set=
_async_cmd()
> >          self.currentAsyncCommand =3D None
> >          self.lastEvent =3D None
> >=20
> > @@ -100,18 +101,16 @@ class Command:
> >                  return None, traceback.format_exc()
> >              else:
> >                  return result, None
> > -        if self.currentAsyncCommand is not None:
> > -            # Wait for the idle loop to have cleared (30s max)
> > -            process_server.wait_for_idle(timeout=3D30)
> > -            if self.currentAsyncCommand is not None:
> > -                return None, "Busy (%s in progress)" % self.currentAsy=
ncCommand[0]
> > +        # Wait for the idle loop to have cleared (30s max)
> > +        if not self.process_server.wait_for_idle(timeout=3D30):
> > +            return None, "Busy (%s in progress)" % self.process_server=
.get_async_cmd()[0]
> >          if command not in CommandsAsync.__dict__:
> >              return None, "No such command"
> > -        self.currentAsyncCommand =3D (command, commandline)
> > -        self.cooker.idleCallBackRegister(self.runAsyncCommand, None)
> > +        process_server.set_async_cmd((command, commandline))
>=20
> You have a TOCTOU bug here; your wait_for_idle() should be atomic with
> the set_async_cmd().
>=20
> In my PoC, I split apart set_async_cmd() from clear_async_cmd():
>=20
>  def set_async_cmd(self, cmd):
>    with self.idle_cond:
>      self.idle_cond.wait_for(self._idle_check)
>      self.cooker.command.currentAsynCommand =3D cmd
>=20
>  def clear_async_cmd(self):
>    with bb.utils.lock_timeout(self._idlefuncsLock):
>      self.cooker.command.currentAsyncCommand =3D None
>      self.idle_cond.notify_all()
>=20
>=20

Right, it is definitely a TOCTOU bug in theory. In practise since we
only have two threads and only one of them ever sets this, I don't
think it can break with the current code.

We should really fix it. I might do it in a later patch, not sure. How
to combine this nicely with the "return busy" piece isn't entirely
trivial.

Cheers,

Richard



