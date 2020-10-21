Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web08.8344.1603266615393701633
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Oct 2020 00:50:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OZ6I8DTu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id n6so1758932wrm.13
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Oct 2020 00:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FkZ7RnRaWUVzvPobUCc57bcfVaV1uZjLc3dkK+G9nds=;
        b=OZ6I8DTuDdJoRTzrt5Mfg0zvfb6mkXVOud1Zd0rNEXyPJmozZduBTQKcQ74VwiMDNc
         hwhn0OXoJT6EXCJEbRTcwCb07RaPXlbDwWWu3CncQoP3YiVg/X/i63HOQJeX0de2eOY8
         ztJEhlrRKGjrTAHJyMOYPPQkSZ3Rx0rp+81XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FkZ7RnRaWUVzvPobUCc57bcfVaV1uZjLc3dkK+G9nds=;
        b=kYSNit5Wze+6j3yrqUG6He+BlUbLuVvps35LWTpYMiMyrKOmmSw6g75ThUProNZSuc
         DB9DyT/sBGxjzjy97vYxntv77jDsM1VBCPMnENUoYjpVOr2QofT2QO0pWQarLQVqGnCr
         f9ORRpeW8dVBqEFOwpl47/k1J1J/92gNsOIidtLHNU+gPmIKPxR0o2Rx5xDjCir9pzj5
         2REtCpQ3uRVnqGesYtc3DvOrkefykbeLENj3ECDDDPrvAZvPfTBH+MrQpFozba1H/EiY
         oRNFwNslUnxSqoiO17jSHtoOCinFWJAwKKKYBbqigvbVkoucS+Q4WFZ99AA9iL/UXjD1
         X3FA==
X-Gm-Message-State: AOAM531rcupkphnMYg1KUmM+ZaQj5hLyPO7qS7GlA8fzGRXT89cMXrv7
	6KWKtqqEj+CQ11N1IHWvzcRlhA==
X-Google-Smtp-Source: ABdhPJwo+1fHZnd+CJHA9p7GZGrWRo7Kp2C1JxCMoUshmE+i+xYMhIKIItmCii+o1fIdu1+PEzY3/g==
X-Received: by 2002:a5d:5090:: with SMTP id a16mr2903891wrt.281.1603266613793;
        Wed, 21 Oct 2020 00:50:13 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 1.4.2.6.b.f.7.8.7.6.9.2.8.f.1.f.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (1.4.2.6.b.f.7.8.7.6.9.2.8.f.1.f.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:f1f8:2967:87fb:6241])
        by smtp.gmail.com with ESMTPSA id o186sm2018574wmb.12.2020.10.21.00.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 00:50:13 -0700 (PDT)
Message-ID: <c0f56b934c8799be75a2c3269f4303e75fedf4d4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] tinfoil: When sending commands we need to process events
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <bluelightning@bluelightning.org>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Oct 2020 08:50:10 +0100
In-Reply-To: <2890515.CbtlEUcBR6@linc>
References: <20201009165124.3293429-1-richard.purdie@linuxfoundation.org>
	 <20201009165124.3293429-2-richard.purdie@linuxfoundation.org>
	 <2890515.CbtlEUcBR6@linc>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-10-21 at 16:05 +1300, Paul Eggleton wrote:
> Hi Richard
> 
> On Saturday, 10 October 2020 05:51:24 NZDT Richard Purdie wrote:
> > The server may be displaying useful information for the user through log
> > messages so we should display anything that has been sent. Its either this
> > or expecting every UI to implement this code around every command call
> > which isn't good API.
> > 
> > [YOCTO #14054]
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/tinfoil.py | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
> > index 2fb1bb7d27..763c329810 100644
> > --- a/lib/bb/tinfoil.py
> > +++ b/lib/bb/tinfoil.py
> > @@ -461,7 +461,16 @@ class Tinfoil:
> >          commandline 
> > > Cheers> Paul> 
> > > 
> > > = [command]
> >          if params:
> >              commandline.extend(params)
> > -        result = self.server_connection.connection.runCommand(commandline)
> > +        try:
> > +            result =
> > self.server_connection.connection.runCommand(commandline) +        finally:
> > +            while True:
> > +                event = self.wait_event()
> > +                if not event:
> > +                    break
> > +                if isinstance(event, logging.LogRecord):
> > +                    if event.taskpid == 0 or event.levelno > logging.INFO:
> > +                        self.logger.handle(event)
> >          if result[1]:
> >              raise TinfoilCommandFailed(result[1])
> >          return result[0]
> 
> Won't this eat events that aren't LogRecords? I understand the intention, and 
> am happy for this to be the default behaviour, but we have several callers of 
> run_command() which are expecting to receive events by themselves using 
> wait_event(). Should we perhaps add a parameter to disable this and specify 
> that in those callers? I'm happy to cook up that patch if so.

Yes, you're right, we do need to something different here. I was
thinking this didn't clear the queue for some reason but it obviously
does. Making it a parameter depending on whether the caller is handling
this or not would be best as you say.

I was trying to avoid having to change all the callers but I think that
is inevitable.

Cheers,

Richard



