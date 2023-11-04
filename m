Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02116C4332F
	for <webhook@archiver.kernel.org>; Sat,  4 Nov 2023 02:55:33 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.3360.1699066530222800535
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 19:55:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=H4y2OMfq;
 spf=softfail (domain: sakoman.com, ip: 209.85.208.50, mailfrom: steve@sakoman.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso4469734a12.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1699066528; x=1699671328; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1ooE2uvmYRf+kFHfzH38RK4BT5UIxb3Uyw+i9Sx94U=;
        b=H4y2OMfq5HCZP+jyPpCYsfE5vGARfgGygSjXMg+WXg+3yY8/dS+XUo8lTKWuiVxB4i
         H/1BuKc+yzXqt3lGOl/hrOtazVUEQUlGY3gNO2+A+sxiD4GuCUVjAl++btKWNDiIOTaP
         piHoOlbNq12PE5ILPyn3GoED+Nsa95Ofa3LNCLr1fZagnRwbO2RwbXhLDBp0NOYsBbbn
         bwrcJ55x0p0ofXip12kgvuEBOR8Jm27EdxV4Y+mmTwgKLGmINjRAKu7vQ6R2u1oCnqtZ
         exn+leAIRfpNzlhiOBI1XzGlAJLxBIBLC8WItymYIOrbHRbNEHfoXOXEcsJgwhm+uvrY
         fhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699066528; x=1699671328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1ooE2uvmYRf+kFHfzH38RK4BT5UIxb3Uyw+i9Sx94U=;
        b=To0+ie8WfoGR694rr5NByileF6NU1+te6WVwuQ5G/wlGgo1R1yezUojjdHj3b5nKW+
         Dec/OjRRr+SOcQOr/xiaxKuwUM6WFoamiZLjDUwyPh1tQ10HMCIKmtUJBd3oPNb7/dig
         NOK3Avylo4qKTkE7xZnRyH8GoirRw5dNJPu3ioeyYUQFY8DwGzlt5VOlrtuOm8FNj8oZ
         nso/F95m/eQAUcQJeAKj1W6HXHv3FIN3cCj/Nq+kCenq0c0WkGFsWeMvI44XEZyOGFA6
         MMv8D/uODTmLclp96chngOnHa0rYa6JBK/EQNyj7haVB2RJ7hgyWMA3hRS6fksoOpmj+
         +DTA==
X-Gm-Message-State: AOJu0YykuOMYAGplQAjpxvLpn0JSKIAS1S3+/KyeIg/b0g4+tSjplsPg
	BG395fgGe6hsHqE0EPBeiOHrJYQKbOrWmZbaU3Q6Sw==
X-Google-Smtp-Source: AGHT+IGDmIzXsyfin/tTBBPXlpaPyHnEjnYIcV8PcYanbG06C2dC/SuP5TaMtLuv9TcLCldcvxTJhtGVJ3rgos4GIxY=
X-Received: by 2002:a17:907:70c:b0:9bd:d7bd:1a52 with SMTP id
 xb12-20020a170907070c00b009bdd7bd1a52mr9932214ejb.20.1699066528484; Fri, 03
 Nov 2023 19:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <179211EB2D3696F8.3183@lists.openembedded.org> <20231104021633.GP2408@denix.org>
In-Reply-To: <20231104021633.GP2408@denix.org>
From: Steve Sakoman <steve@sakoman.com>
Date: Fri, 3 Nov 2023 16:55:16 -1000
Message-ID: <CAOSpxdaJdJiB6FjEt3LvaBmFjN976qJR138JKqEK7Zxh+CzzyQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [kirkstone][PATCH] runqueue: convert deferral
 messages from bb.note to bb.debug
To: Denys Dmytriyenko <denis@denix.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 04 Nov 2023 02:55:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15449

On Fri, Nov 3, 2023 at 4:16=E2=80=AFPM Denys Dmytriyenko <denis@denix.org> =
wrote:
>
> Steve,
>
> FYI, sorry I missed copying you initially...

I've got it now, thanks!

Steve

> On Fri, Oct 27, 2023 at 08:48:19PM +0000, Denys Dmytriyenko wrote:
> > Using multiconfig to target baremetal pieces of the system and building
> > corresponding toolchains for them results in hundreds and hundreds of
> > "Deferring %s after %s" and "Deferred task %s now buildable".
> >
> > To clean up the output and to reduce risk of missing important warnings=
,
> > convert these notice messages to debug messages.
> >
> > Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> > Signed-off-by: Denys Dmytriyenko <denys@konsulko.com>
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > (cherry picked from commit 64bc00a46d1aacc23fe7e8d9a46a126f3a4bc318)
> > Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> > ---
> >  lib/bb/runqueue.py | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> > index 46ff30a7..8605c46c 100644
> > --- a/lib/bb/runqueue.py
> > +++ b/lib/bb/runqueue.py
> > @@ -1980,12 +1980,12 @@ class RunQueueExecute:
> >                  # Allow the next deferred task to run. Any other defer=
red tasks should be deferred after that task.
> >                  # We shouldn't allow all to run at once as it is prone=
 to races.
> >                  if not found:
> > -                    bb.note("Deferred task %s now buildable" % t)
> > +                    bb.debug(1, "Deferred task %s now buildable" % t)
> >                      del self.sq_deferred[t]
> >                      update_scenequeue_data([t], self.sqdata, self.rqda=
ta, self.rq, self.cooker, self.stampcache, self, summary=3DFalse)
> >                      found =3D t
> >                  else:
> > -                    bb.note("Deferring %s after %s" % (t, found))
> > +                    bb.debug(1, "Deferring %s after %s" % (t, found))
> >                      self.sq_deferred[t] =3D found
> >
> >      def task_complete(self, task):
> > @@ -2892,7 +2892,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, coo=
ker, stampcache, sqrq):
> >                  sqdata.hashes[h] =3D tid
> >              else:
> >                  sqrq.sq_deferred[tid] =3D sqdata.hashes[h]
> > -                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[=
h]))
> > +                bb.debug(1, "Deferring %s after %s" % (tid, sqdata.has=
hes[h]))
> >
> >      update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cook=
er, stampcache, sqrq, summary=3DTrue)
> >
> > --
> > 2.25.1
> >

