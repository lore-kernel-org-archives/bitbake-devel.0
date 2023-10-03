Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE08E8FDB4
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 20:28:12 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.1317.1696364884087628323
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 13:28:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=F6mckh8j;
 spf=pass (domain: snapchat.com, ip: 209.85.218.50, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9b2a3fd5764so242830466b.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1696364882; x=1696969682; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zYqdAT2SIfdyN2OvNTr8n6RTxakbOso6N5d5sLIAZBg=;
        b=F6mckh8jkv1lPrYMT5PKj6j5ebRzveyQnVs9wa84u+EE/yyW5XWER1eMJ+FRk+dBah
         UBZqBGfgsSHeMpb6KSdcotT0PmwsIy0KSeqo605A5+5c/7zgQKizk6UoVGVZI9zN1uSI
         4AuM9REtKlUBiYQMCym7H4oM8dhAgg/DaHgNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696364882; x=1696969682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYqdAT2SIfdyN2OvNTr8n6RTxakbOso6N5d5sLIAZBg=;
        b=aeiXvkyzpNaUbGBMGWaLfXtxxr5smTLNreXV5VHxPRLXh8cPYtVvLadIWNkLabhd7L
         /W/7M4LpBl643x8NhpaVKJE0uAo3LOUkQ7dv3x+GCzB87mgrBkCazhvJXGSDqetZHWF7
         47fpYAm+MwGtY6HDHy5Eaiv+KOfY9V6YVsxd9Up9FG4ocMV9/5XNp/1OmrYv3xMgCn3w
         J2BlTpGeRnErG+oVm3lMwczU7xWa12FX6RKdC7pJr2z3lttdaowYsyLypN95o4UJcfse
         yYtOI1A+a5/iEumVGfvKQZYiwvec5MfzC6AGNS2FEmuhI7gsdrj5hD2pX7chio5Iqoc9
         fAHA==
X-Gm-Message-State: AOJu0YxIEu6boGlZf7VNNBJWN1z1AZUNLFT3qnhBaHKRXSeC7V2e42lw
	gNogJyjXCbuGIiyci9e6K9Ff5yO1jQC3DWRUzuPf7qrQCq80ZPjw
X-Google-Smtp-Source: AGHT+IHEd7eIuUdZFccZln11dB41FPGPktU80Uf6oQ/3z4qBTYWNkWg1Ug6bfgHlNywOTYad5hfo07aiEYDhgYd+Qg0=
X-Received: by 2002:a17:906:2258:b0:9aa:25f5:8d95 with SMTP id
 24-20020a170906225800b009aa25f58d95mr266166ejr.59.1696364882067; Tue, 03 Oct
 2023 13:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230922085146.2997927-1-ecordonnier@snap.com>
In-Reply-To: <20230922085146.2997927-1-ecordonnier@snap.com>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Tue, 3 Oct 2023 22:27:51 +0200
Message-ID: <CAHUKmYax2bL7hcD9kra-Md2oTy3CjkFGt0N-qgF-SWpnSHafsw@mail.gmail.com>
Subject: Re: [kirkstone][2.0][PATCH] bitbake-worker/runqueue: Avoid
 unnecessary bytes object copies
To: bitbake-devel@lists.openembedded.org, Steve Sakoman <steve@sakoman.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="00000000000034de870606d5bac3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 20:28:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15178

--00000000000034de870606d5bac3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Steve in CC.

--
Etienne

On Fri, Sep 22, 2023 at 10:51=E2=80=AFAM <ecordonnier@snap.com> wrote:

> From: Etienne Cordonnier <ecordonnier@snap.com>
>
> declaring queue=3Db"" creates an object of types bytes().
> bytes() is an immutable object, and therefore doing "self.queue =3D
> self.queue + r"
> creates a new object containing "self.queue" concatenated with "r".
>
> On my test setup, we are passing 180MB of data of "workerdata" to the
> bitbake-worker,
> so those copies significantly slow down the initialization of the
> bitbake-worker.
>
> Rather use bytearray() which a mutable type, and use extend() to avoid
> copies.
> In my test setup, byterray.extend() is 10.000 times faster than copying
> the queue,
> for a queue size of 180MB.
>
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bin/bitbake-worker | 14 +++++++-------
>  lib/bb/runqueue.py |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 5e62bc20..e02f2532 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -91,19 +91,19 @@ def worker_fire_prepickled(event):
>  worker_thread_exit =3D False
>
>  def worker_flush(worker_queue):
> -    worker_queue_int =3D b""
> +    worker_queue_int =3D bytearray()
>      global worker_pipe, worker_thread_exit
>
>      while True:
>          try:
> -            worker_queue_int =3D worker_queue_int + worker_queue.get(Tru=
e,
> 1)
> +            worker_queue_int.extend(worker_queue.get(True, 1))
>          except queue.Empty:
>              pass
>          while (worker_queue_int or not worker_queue.empty()):
>              try:
>                  (_, ready, _) =3D select.select([], [worker_pipe], [], 1=
)
>                  if not worker_queue.empty():
> -                    worker_queue_int =3D worker_queue_int +
> worker_queue.get()
> +                    worker_queue_int.extend(worker_queue.get())
>                  written =3D os.write(worker_pipe, worker_queue_int)
>                  worker_queue_int =3D worker_queue_int[written:]
>              except (IOError, OSError) as e:
> @@ -338,12 +338,12 @@ class runQueueWorkerPipe():
>          if pipeout:
>              pipeout.close()
>          bb.utils.nonblockingfd(self.input)
> -        self.queue =3D b""
> +        self.queue =3D bytearray()
>
>      def read(self):
>          start =3D len(self.queue)
>          try:
> -            self.queue =3D self.queue + (self.input.read(102400) or b"")
> +            self.queue.extend(self.input.read(102400) or b"")
>          except (OSError, IOError) as e:
>              if e.errno !=3D errno.EAGAIN:
>                  raise
> @@ -371,7 +371,7 @@ class BitbakeWorker(object):
>      def __init__(self, din):
>          self.input =3D din
>          bb.utils.nonblockingfd(self.input)
> -        self.queue =3D b""
> +        self.queue =3D bytearray()
>          self.cookercfg =3D None
>          self.databuilder =3D None
>          self.data =3D None
> @@ -405,7 +405,7 @@ class BitbakeWorker(object):
>                      if len(r) =3D=3D 0:
>                          # EOF on pipe, server must have terminated
>                          self.sigterm_exception(signal.SIGTERM, None)
> -                    self.queue =3D self.queue + r
> +                    self.queue.extend(r)
>                  except (OSError, IOError):
>                      pass
>              if len(self.queue):
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 56952070..46ff30a7 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -3101,7 +3101,7 @@ class runQueuePipe():
>          if pipeout:
>              pipeout.close()
>          bb.utils.nonblockingfd(self.input)
> -        self.queue =3D b""
> +        self.queue =3D bytearray()
>          self.d =3D d
>          self.rq =3D rq
>          self.rqexec =3D rqexec
> @@ -3120,7 +3120,7 @@ class runQueuePipe():
>
>          start =3D len(self.queue)
>          try:
> -            self.queue =3D self.queue + (self.input.read(102400) or b"")
> +            self.queue.extend(self.input.read(102400) or b"")
>          except (OSError, IOError) as e:
>              if e.errno !=3D errno.EAGAIN:
>                  raise
> --
> 2.36.1.vfs.0.0
>
>

--00000000000034de870606d5bac3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Adding Steve in CC.<br><br>--<br>Etienne</div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 22, 20=
23 at 10:51=E2=80=AFAM &lt;<a href=3D"mailto:ecordonnier@snap.com">ecordonn=
ier@snap.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap=
.com" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
<br>
declaring queue=3Db&quot;&quot; creates an object of types bytes().<br>
bytes() is an immutable object, and therefore doing &quot;self.queue =3D se=
lf.queue + r&quot;<br>
creates a new object containing &quot;self.queue&quot; concatenated with &q=
uot;r&quot;.<br>
<br>
On my test setup, we are passing 180MB of data of &quot;workerdata&quot; to=
 the bitbake-worker,<br>
so those copies significantly slow down the initialization of the bitbake-w=
orker.<br>
<br>
Rather use bytearray() which a mutable type, and use extend() to avoid copi=
es.<br>
In my test setup, byterray.extend() is 10.000 times faster than copying the=
 queue,<br>
for a queue size of 180MB.<br>
<br>
Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.co=
m" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0bin/bitbake-worker | 14 +++++++-------<br>
=C2=A0lib/bb/runqueue.py |=C2=A0 4 ++--<br>
=C2=A02 files changed, 9 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/bin/bitbake-worker b/bin/bitbake-worker<br>
index 5e62bc20..e02f2532 100755<br>
--- a/bin/bitbake-worker<br>
+++ b/bin/bitbake-worker<br>
@@ -91,19 +91,19 @@ def worker_fire_prepickled(event):<br>
=C2=A0worker_thread_exit =3D False<br>
<br>
=C2=A0def worker_flush(worker_queue):<br>
-=C2=A0 =C2=A0 worker_queue_int =3D b&quot;&quot;<br>
+=C2=A0 =C2=A0 worker_queue_int =3D bytearray()<br>
=C2=A0 =C2=A0 =C2=A0global worker_pipe, worker_thread_exit<br>
<br>
=C2=A0 =C2=A0 =C2=A0while True:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 worker_queue_int =3D worker_queu=
e_int + worker_queue.get(True, 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 worker_queue_int.extend(worker_q=
ueue.get(True, 1))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except queue.Empty:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (worker_queue_int or not worker_que=
ue.empty()):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(_, ready, _)=
 =3D select.select([], [worker_pipe], [], 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not worker=
_queue.empty():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 work=
er_queue_int =3D worker_queue_int + worker_queue.get()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 work=
er_queue_int.extend(worker_queue.get())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0written =3D o=
s.write(worker_pipe, worker_queue_int)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0worker_queue_=
int =3D worker_queue_int[written:]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except (IOError, OSError) a=
s e:<br>
@@ -338,12 +338,12 @@ class runQueueWorkerPipe():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if pipeout:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pipeout.close()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.nonblockingfd(self.input)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue =3D b&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue =3D bytearray()<br>
<br>
=C2=A0 =C2=A0 =C2=A0def read(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start =3D len(self.queue)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue =3D self.queue + (sel=
f.input.read(102400) or b&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue.extend(self.input.rea=
d(102400) or b&quot;&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except (OSError, IOError) as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if e.errno !=3D errno.EAGAI=
N:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
@@ -371,7 +371,7 @@ class BitbakeWorker(object):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, din):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.input =3D din<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.nonblockingfd(self.input)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue =3D b&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue =3D bytearray()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.cookercfg =3D None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.databuilder =3D None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.data =3D None<br>
@@ -405,7 +405,7 @@ class BitbakeWorker(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if len(r) =3D=3D 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0# EOF on pipe, server must have terminated<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0self.sigterm_exception(signal.SIGTERM, None)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.queue =3D self.queue + r<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.queue.extend(r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except (OSErr=
or, IOError):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pass<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if len(self.queue):<br>
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py<br>
index 56952070..46ff30a7 100644<br>
--- a/lib/bb/runqueue.py<br>
+++ b/lib/bb/runqueue.py<br>
@@ -3101,7 +3101,7 @@ class runQueuePipe():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if pipeout:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pipeout.close()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.nonblockingfd(self.input)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue =3D b&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue =3D bytearray()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d =3D d<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq =3D rq<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rqexec =3D rqexec<br>
@@ -3120,7 +3120,7 @@ class runQueuePipe():<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start =3D len(self.queue)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue =3D self.queue + (sel=
f.input.read(102400) or b&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue.extend(self.input.rea=
d(102400) or b&quot;&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except (OSError, IOError) as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if e.errno !=3D errno.EAGAI=
N:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
-- <br>
2.36.1.vfs.0.0<br>
<br>
</blockquote></div>

--00000000000034de870606d5bac3--

