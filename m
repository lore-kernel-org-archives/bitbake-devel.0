Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10C7C83F03
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 14:50:46 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web11.24511.1751554246281476034
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jul 2025 07:50:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=axFMuxsg;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553b60de463so6506551e87.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751554244; x=1752159044; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmhFjQqC9p9Ci7w6q9SSUcGEYsBHanK/oUqOsJ0PHmQ=;
        b=axFMuxsgd7g5SRwvOcsTjN13MoxVppnI9wGCxl/chvvHyzotX0/loCuSPQ0zgflhZF
         37oQheqncal1jAx8wT7AI5dqTdRFzG2KVaoBTGHKM8AVne9X1/7IjJQp4Ut5DEcxddp8
         /JMCEch9TDIZkk3OceqGZ9neBCUWzl4Kh301AsQHNp7dWjHfg4122FA4wqw0bGRE7jLh
         DHXjNOdOLjlz4G3XvnNY6hayRwsuWkrqHh42NOQconpkVuYgv+i/BCSljs571df8T3eB
         m0rS/0jbL+roZ6LixXGCgWBlSt3ZGMSWmqDbun4Affs20uaiQ1+GQBZ4C+zlK42r4lYc
         xpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751554244; x=1752159044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmhFjQqC9p9Ci7w6q9SSUcGEYsBHanK/oUqOsJ0PHmQ=;
        b=NvM+qUzacQ2iQDP7KdYLl0Lr+7rtOpqkKurqHTxErtXdBI9We4SG4knhuvOIdMg/3c
         FlyfEuNAGbFSQO7RNSl274FFcCvUeSJdDayMFlTfFV6yvKs16wJ/bVtIlM3Ir+7+Kgqx
         S1jV95lRUqInJkvrkDeXaBmrKpNgSjbY0lJzMc+LpJ1ERWDh2AjlSIx5Jm/2BYK10sDD
         Awr5UPcBHyk013Es7AFTKiHKuFMroifv90wNAwTxJndRXNead+7ALsvIBCX5Wczuih7M
         03Rhy2SxVDX3v4h9u2JXq3YZ69UAVup2hkJKqdxgnYATDtl9ie++LFu7vDfDzdnDcH7l
         Y4Kw==
X-Gm-Message-State: AOJu0YzgZokJVrde2rM8R0QyToe/xUFlJXQqu/QLaxUsO/msW0j8gGa2
	j+i/lGhareVJNixmvIMuM7gOLPc2XAAYgy7/ke2YLCiax9kmEPYAc+WWJfQJsiRcJKt6QBNwC0k
	JerG3+q6GlAjwHt6pHxubHHP8a9BNqgQ=
X-Gm-Gg: ASbGncvZKRz4TEIZUbolAADVE82o95akadafJ6LM9wO+QMN/y575RH3zt+ZqZpHgyxg
	g1LIZhzQklOePLmlsAe/qE2QMqDv5JSm6hA5JFSF6aOwwnM8wslWnWzQr4gojqfuZ2UDnd8jVuW
	QW6Nq9q6tzUCgTW0xx7uQXI17VcaKBRR2kBBAy3CJ0IZPtgMdhLgNoX+DCNg==
X-Google-Smtp-Source: AGHT+IGqCDvIVp4xKYf/AaTFJwpuUgHM+GsV+z7NDq9jhl90zGoVYHHVcf6JmdYiOFHEGMQd7OXkjQXOUfLuNR4QH6A=
X-Received: by 2002:ac2:4f13:0:b0:553:268e:5019 with SMTP id
 2adb3069b0e04-5562ee20e2dmr1404706e87.11.1751554244172; Thu, 03 Jul 2025
 07:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250702222437.3733042-1-richard.purdie@linuxfoundation.org>
 <20250702222437.3733042-2-richard.purdie@linuxfoundation.org>
 <CAJdd5GaLejWT50QFYGazeh2zDnBOALWVsgEiRcfGw2-J=RWKXw@mail.gmail.com> <56c5d0bae69179225664f2bff11fb38b7094f2ed.camel@linuxfoundation.org>
In-Reply-To: <56c5d0bae69179225664f2bff11fb38b7094f2ed.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 3 Jul 2025 08:50:31 -0600
X-Gm-Features: Ac12FXyP63pKkUYRA8RvytPeKLiwsoA5M0EedssHA4VibAiOSzZgD8UIE_XM7JE
Message-ID: <CAJdd5GZWuSCVCNOc5mFH08_Og3SbNrvbBvPpHPFcmaM1uMYJ5w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] cooker: Use a queue to feed parsing jobs
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 14:50:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17746

On Thu, Jul 3, 2025 at 8:30=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Thu, 2025-07-03 at 08:27 -0600, Joshua Watt wrote:
> > On Wed, Jul 2, 2025 at 4:24=E2=80=AFPM Richard Purdie via
> > lists.openembedded.org
> > <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
> > >
> > > Curerntly, recipes to parse are split into equal groups and passed to
> > > each parse thread at the start of parsing. We can replace this with
> > > a queue and collect a new job as each parsing process becomes idle
> > > to better spread load in the case of slow parsing jobs.
> > >
> > > Some of the data we need has to be passed in at fork time since it
> > > can't be pickled, so the job to parse is only referenced as an index
> > > in that list.
> > >
> > > This should better spread load for slow to parse recipes such as thos=
e
> > > with many class extensions.
> > >
> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > ---
> > >  lib/bb/cooker.py | 29 ++++++++++++++++++-----------
> > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> > > index 91e3ee025ea..e88ad24cf61 100644
> > > --- a/lib/bb/cooker.py
> > > +++ b/lib/bb/cooker.py
> > > @@ -1998,8 +1998,9 @@ class ParsingFailure(Exception):
> > >          Exception.__init__(self, realexception, recipe)
> > >
> > >  class Parser(multiprocessing.Process):
> > > -    def __init__(self, jobs, results, quit, profile):
> > > +    def __init__(self, jobs, jobid_queue, results, quit, profile):
> > >          self.jobs =3D jobs
> > > +        self.jobid_queue =3D jobid_queue
> > >          self.results =3D results
> > >          self.quit =3D quit
> > >          multiprocessing.Process.__init__(self)
> > > @@ -2064,12 +2065,14 @@ class Parser(multiprocessing.Process):
> > >                  if self.quit.is_set():
> > >                      break
> > >
> > > -                job =3D None
> > > +                jobid =3D None
> > >                  try:
> > > -                    job =3D self.jobs.pop()
> > > -                except IndexError:
> > > +                    jobid =3D self.jobid_queue.get(True, 0.5)
> > > +                except (ValueError, OSError):
> > >                      havejobs =3D False
> > > -                if job:
> > > +
> > > +                if jobid is not None:
> > > +                    job =3D self.jobs[jobid]
> > >                      result =3D self.parse(*job)
> > >                      # Clear the siggen cache after parsing to contro=
l memory usage, its huge
> > >                      bb.parse.siggen.postparsing_clean_cache()
> > > @@ -2082,6 +2085,7 @@ class Parser(multiprocessing.Process):
> > >                      except queue.Full:
> > >                          pending.append(result)
> > >          finally:
> > > +            self.jobs.close()
> > >              self.results.close()
> > >              self.results.join_thread()
> > >
> > > @@ -2134,13 +2138,13 @@ class CookerParser(object):
> > >
> > >          self.bb_caches =3D bb.cache.MulticonfigCache(self.cfgbuilder=
, self.cfghash, cooker.caches_array)
> > >          self.fromcache =3D set()
> > > -        self.willparse =3D set()
> > > +        self.willparse =3D []
> > >          for mc in self.cooker.multiconfigs:
> > >              for filename in self.mcfilelist[mc]:
> > >                  appends =3D self.cooker.collections[mc].get_file_app=
ends(filename)
> > >                  layername =3D self.cooker.collections[mc].calc_bbfil=
e_priority(filename)[2]
> > >                  if not self.bb_caches[mc].cacheValid(filename, appen=
ds):
> > > -                    self.willparse.add((mc, self.bb_caches[mc], file=
name, appends, layername))
> > > +                    self.willparse.append((mc, self.bb_caches[mc], f=
ilename, appends, layername))
> > >                  else:
> > >                      self.fromcache.add((mc, self.bb_caches[mc], file=
name, appends, layername))
> > >
> > > @@ -2159,22 +2163,25 @@ class CookerParser(object):
> > >      def start(self):
> > >          self.results =3D self.load_cached()
> > >          self.processes =3D []
> > > +
> > >          if self.toparse:
> > >              bb.event.fire(bb.event.ParseStarted(self.toparse), self.=
cfgdata)
> > >
> > > +            self.toparse_queue =3D multiprocessing.Queue(len(self.wi=
llparse))
> > >              self.parser_quit =3D multiprocessing.Event()
> > >              self.result_queue =3D multiprocessing.Queue()
> > >
> > > -            def chunkify(lst,n):
> > > -                return [lst[i::n] for i in range(n)]
> > > -            self.jobs =3D chunkify(list(self.willparse), self.num_pr=
ocesses)
> > > +            for jobid in range(len(self.willparse)):
> > > +                self.toparse_queue.put(jobid)
> >
> > It's generally not a good idea to assume you can push all the items on
> > the queue before there are any consumers; if the queue fills, this
> > will deadlock. It would be better to push the items to the queue after
> > creating the processes.
>
> True. I did make sure the queue was large enough above however it would
> depend on the size of the job entries.
>
> >  If you do that, I also don't see any reason to
> > push the indexes instead of the jobs directly; basically instead of
> > "chunkifying" and pre-determining the assignment of jobs to processes,
> > have them all pull from one queue of jobs.
>
> I added this comment to the patch in master next:
>
> # Have to pass in willparse at fork time so all parsing processes have th=
e unpickleable data
> # then access it by index from the parse queue.
>
>
> As if you don't do that, it can't rebuild the data as the cache objects
> aren't pickleable :(

Ah, OK. We must be relying on the multiprocess being implemented with
fork() then to pass the data. That's reasonable and the indexes make
sense (but we should still push them after creating the process to
avoid the possibility of deadlock)

>
> Cheers,
>
> Richard

