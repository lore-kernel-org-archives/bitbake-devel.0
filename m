Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E77C83F03
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 14:28:06 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.23944.1751552883083007931
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jul 2025 07:28:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Tj3k02ys;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso4899740e87.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751552881; x=1752157681; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhE3chwZMHDMoVrv6wZe8YOESwy5vhSPhWFIjLugl4c=;
        b=Tj3k02ysM6yk/y8jcj/AbwU1M+2kXpSJ2wV3KLnrod2sTXXpTtRzCxzi9hHKuc3gGy
         G9YW0gg76P5CrYyUTLrq90KYzDYAQC200T6TYoQiDgJtUNsDcqR2Qy4HFqa9a6ntpElb
         PW6r+NLwKEbud+gIbDnu2Zjvsr8NDcyWoeU7IsvkC2Ru5RjjyOX0E4p8Ytg+9G9nHLjT
         mBDqMDbox35z29kna3ZexmMA/bLsbFBzZCsw7O/shcRseOWVvSZHXHVx8BnQD1umsLFd
         L/IlSOs+BFh4D6PEexpaJ8rRUAxc3gOasxSlUMFoCU5vKLKls0CB7Ha2gZ1DVaELlWIh
         oJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552881; x=1752157681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhE3chwZMHDMoVrv6wZe8YOESwy5vhSPhWFIjLugl4c=;
        b=l5COkPhGzJEJ/sGrChgZW0MLzd+w8YuUXQIYiGyRrjLqzvlS3Sv+qFSglHSKtvce4e
         bkWdZJ+wissi5lcyQT6Y1DAh9y16kjT6IRG33p2kKXnOilBS/nXTEpiCAb/mVK/D5I5R
         712Htx4U+6JJ4exsMKDjVeXlXphCyqxE8r+PYInsblOCFtJD8bTAZJe5HC7CGN5wTYbA
         86N4YtRdW29QtRoon+flJ/X/HWSjk1a/hNBz1Jj3/zSNMfr/hnnD+BA9N2cgB3xHbhsT
         XHapL3DI5wZO+N72DfG/OGW/X12cM8HGsHdKna7b8BUkXgCDeqHQH/4TMH7DNTXKMhGM
         LzHA==
X-Gm-Message-State: AOJu0Yx7/zVwtzYEvjbO+khjJiPjKIiEArDji2/1K2IbVxL0cYEBW4xU
	Z9iNh0mfuT0NhmG0xxpnCgcr/R0vNRA2v0pkCHiSwRvGhY62z3wy+FuYT5vKnCBP94pi7wSJniM
	KwmW1zwxKm1dQ8NEvtS0p6bT8HrZ3m7E=
X-Gm-Gg: ASbGncvfqMB7uj8y/YLtkaG5p5wn6NuLBlsootgRVQxYjL4NFdu46W0hL3cjykgWSHH
	mtgev66LLQ1dHqxVmMNcMRrTbpNA9/yF9Q0NU07AbSlPZx4U0BTRarYebmxYh6zoPXVkl5EJsA3
	CeCskln9CVevSSrltEzKobvfYR4NQStCy8NiREOAdrGz9f3ghkvjQQi9/45g==
X-Google-Smtp-Source: AGHT+IG5E0lNyF0YPN+ztwG9/z2ykpqkbRJEpWwBVluIsZA1vslh3Znv3RkF0zp26uQ4zGZIl03QNF1/CO0rN2iR1KQ=
X-Received: by 2002:a05:6512:3b89:b0:553:252f:adf8 with SMTP id
 2adb3069b0e04-5562ee21626mr1194954e87.9.1751552880715; Thu, 03 Jul 2025
 07:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250702222437.3733042-1-richard.purdie@linuxfoundation.org> <20250702222437.3733042-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250702222437.3733042-2-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 3 Jul 2025 08:27:47 -0600
X-Gm-Features: Ac12FXz5x2-psA16m6uvk4FwpRh0TtkuljvGV5yO5Xy7doFlB8TbXYcC3ATKWqE
Message-ID: <CAJdd5GaLejWT50QFYGazeh2zDnBOALWVsgEiRcfGw2-J=RWKXw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] cooker: Use a queue to feed parsing jobs
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 14:28:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17744

On Wed, Jul 2, 2025 at 4:24=E2=80=AFPM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> Curerntly, recipes to parse are split into equal groups and passed to
> each parse thread at the start of parsing. We can replace this with
> a queue and collect a new job as each parsing process becomes idle
> to better spread load in the case of slow parsing jobs.
>
> Some of the data we need has to be passed in at fork time since it
> can't be pickled, so the job to parse is only referenced as an index
> in that list.
>
> This should better spread load for slow to parse recipes such as those
> with many class extensions.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cooker.py | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 91e3ee025ea..e88ad24cf61 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1998,8 +1998,9 @@ class ParsingFailure(Exception):
>          Exception.__init__(self, realexception, recipe)
>
>  class Parser(multiprocessing.Process):
> -    def __init__(self, jobs, results, quit, profile):
> +    def __init__(self, jobs, jobid_queue, results, quit, profile):
>          self.jobs =3D jobs
> +        self.jobid_queue =3D jobid_queue
>          self.results =3D results
>          self.quit =3D quit
>          multiprocessing.Process.__init__(self)
> @@ -2064,12 +2065,14 @@ class Parser(multiprocessing.Process):
>                  if self.quit.is_set():
>                      break
>
> -                job =3D None
> +                jobid =3D None
>                  try:
> -                    job =3D self.jobs.pop()
> -                except IndexError:
> +                    jobid =3D self.jobid_queue.get(True, 0.5)
> +                except (ValueError, OSError):
>                      havejobs =3D False
> -                if job:
> +
> +                if jobid is not None:
> +                    job =3D self.jobs[jobid]
>                      result =3D self.parse(*job)
>                      # Clear the siggen cache after parsing to control me=
mory usage, its huge
>                      bb.parse.siggen.postparsing_clean_cache()
> @@ -2082,6 +2085,7 @@ class Parser(multiprocessing.Process):
>                      except queue.Full:
>                          pending.append(result)
>          finally:
> +            self.jobs.close()
>              self.results.close()
>              self.results.join_thread()
>
> @@ -2134,13 +2138,13 @@ class CookerParser(object):
>
>          self.bb_caches =3D bb.cache.MulticonfigCache(self.cfgbuilder, se=
lf.cfghash, cooker.caches_array)
>          self.fromcache =3D set()
> -        self.willparse =3D set()
> +        self.willparse =3D []
>          for mc in self.cooker.multiconfigs:
>              for filename in self.mcfilelist[mc]:
>                  appends =3D self.cooker.collections[mc].get_file_appends=
(filename)
>                  layername =3D self.cooker.collections[mc].calc_bbfile_pr=
iority(filename)[2]
>                  if not self.bb_caches[mc].cacheValid(filename, appends):
> -                    self.willparse.add((mc, self.bb_caches[mc], filename=
, appends, layername))
> +                    self.willparse.append((mc, self.bb_caches[mc], filen=
ame, appends, layername))
>                  else:
>                      self.fromcache.add((mc, self.bb_caches[mc], filename=
, appends, layername))
>
> @@ -2159,22 +2163,25 @@ class CookerParser(object):
>      def start(self):
>          self.results =3D self.load_cached()
>          self.processes =3D []
> +
>          if self.toparse:
>              bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgd=
ata)
>
> +            self.toparse_queue =3D multiprocessing.Queue(len(self.willpa=
rse))
>              self.parser_quit =3D multiprocessing.Event()
>              self.result_queue =3D multiprocessing.Queue()
>
> -            def chunkify(lst,n):
> -                return [lst[i::n] for i in range(n)]
> -            self.jobs =3D chunkify(list(self.willparse), self.num_proces=
ses)
> +            for jobid in range(len(self.willparse)):
> +                self.toparse_queue.put(jobid)

It's generally not a good idea to assume you can push all the items on
the queue before there are any consumers; if the queue fills, this
will deadlock. It would be better to push the items to the queue after
creating the processes. If you do that, I also don't see any reason to
push the indexes instead of the jobs directly; basically instead of
"chunkifying" and pre-determining the assignment of jobs to processes,
have them all pull from one queue of jobs.

>
>              for i in range(0, self.num_processes):
> -                parser =3D Parser(self.jobs[i], self.result_queue, self.=
parser_quit, self.cooker.configuration.profile)
> +                parser =3D Parser(self.willparse, self.toparse_queue, se=
lf.result_queue, self.parser_quit, self.cooker.configuration.profile)
>                  parser.start()
>                  self.process_names.append(parser.name)
>                  self.processes.append(parser)
>
> +            self.toparse_queue.close()
> +
>              self.results =3D itertools.chain(self.results, self.parse_ge=
nerator())
>
>      def shutdown(self, clean=3DTrue, eventmsg=3D"Parsing halted due to e=
rrors"):
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17738): https://lists.openembedded.org/g/bitbake-deve=
l/message/17738
> Mute This Topic: https://lists.openembedded.org/mt/113957083/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

