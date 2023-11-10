Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03129C4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 14:32:26 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.28733.1699626735458766632
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 06:32:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Xxmrz5tL;
 spf=softfail (domain: sakoman.com, ip: 209.85.218.44, mailfrom: steve@sakoman.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9d2c54482fbso346124566b.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 06:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1699626733; x=1700231533; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOOcd9iEa3kx3CEPFx9I8zeP2Mhq+DOUFED+fof11Og=;
        b=Xxmrz5tLIFLKtXMB2iIzqC866e+Vv6xTyfeXdiBv04oIEqit2IfxVYh6tlIsNgTabd
         jIwwHWCPHSp1urCM3nUQQH04LB6pn5CtxtN05UZj5XpXS95i5VRDjWSlkzLbhYPE4ORx
         +1nd2HXvc4FuLIfiI4bcwaupU9EZW9hel1ZWfMi2lDglZ4InoOg/edu4ttqjZzNL64+Y
         7tuuEaYhERLyH2q6yTK6H8svDe1jZSiifK674EWQj65a+/CuvVSjo9+zPraRL7PIf3vq
         D89c9PcDfl7eRSKhtSLiVfN6LGugeZPe/rIYSzYqLZSTChsRQWQvtbbqFgKnoF2W7OUt
         h+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699626733; x=1700231533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOOcd9iEa3kx3CEPFx9I8zeP2Mhq+DOUFED+fof11Og=;
        b=OxdTx/LJP4yt323EFzsswa6nDpS+LypedR046IJnJoZ+buzS+xEkKmKPcO0ysZmOpE
         S6bOfLkuo9KTEBVYLpZqXUOrd2jzhO9Hz472LOCGCsBw43ZVoMe9AMH66M9KIbNW6Gne
         WpY1aljbEWhCpb0ILV9yXkkedA6Ez9jJFBOj6RAHW/KaCu7PCkDhooAj4fsEp5OBupnU
         4SwegOi6xoDsD6gwYTyxYkeQnVquwHox0cDuj+nIaZZBdcM5vqhSpE1mAcRfrGeHOgRl
         ZB11B+pJ2VuHYgziXO+jPvazgZy2+EDSDqlfGQ5qRwyFTMFfI4mrw7VHolDMaBY2L0k9
         agoQ==
X-Gm-Message-State: AOJu0Yx6TNCU744KPDF2fFdLc75Iz60balMIo9k96eN01Lz1GpJF7Cev
	7fJG0NFo/bpcrH5NtDwaKtxg+h2iKmu69Wt6TbPskQ==
X-Google-Smtp-Source: AGHT+IHsiyqPOCi/2YA2tu4MRxs97xtE+dEzmzc4T4Q0lAFs/35qnElwewl5C1XhbK0h/EFA4bHsGpV5PLOyp0jVqw0=
X-Received: by 2002:a17:907:7f9e:b0:9d3:f436:61e5 with SMTP id
 qk30-20020a1709077f9e00b009d3f43661e5mr7885825ejc.29.1699626733316; Fri, 10
 Nov 2023 06:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20231110133324.3168418-1-ecordonnier@snap.com>
In-Reply-To: <20231110133324.3168418-1-ecordonnier@snap.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Fri, 10 Nov 2023 04:32:02 -1000
Message-ID: <CAOSpxdY_XcYYxwQh5u6sKLWhM0O+tjM8HGZNBy4ACnD-61taRw@mail.gmail.com>
Subject: Re: [bitbake-devel] [2.0][kirkstone][PATCH] bitbake-worker: add
 header with length of message
To: ecordonnier@snap.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 14:32:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15502

On Fri, Nov 10, 2023 at 3:34=E2=80=AFAM Etienne Cordonnier via
lists.openembedded.org <ecordonnier=3Dsnap.com@lists.openembedded.org>
wrote:
>
> From: Etienne Cordonnier <ecordonnier@snap.com>
>
> The IPC mechanism between runqueue.py and bitbake-worker is currently
> not scalable:
>
> The data is sent with the format <tag>pickled-data</tag>, and bitbake-wor=
ker
> has no information about the size of the message. Therefore, the bitbake-=
worker
> is calling select() and read() in a loop, and then calling "self.queue.fi=
nd(b"</" + item + b">")"
> for each chunk received.
>
> This does not scale, because queue.find has a linear complexity relative =
to the size of the queue,
> and workerdata messages get very big e.g. for builds which reference a lo=
t of files in SRC_URI.
> The number of chunks varies, but on my test system a lot of chunks of 655=
36 bytes are sent, and each
> iteration takes 0.1 seconds, making the transfer of the "workerdata" data=
 very slow (on my test setup
> 35 seconds before this fix, and 1.5 seconds after this fix).
>
> This commit adds a 4 bytes header after <tag>, so that bitbake-worker kno=
ws how many bytes need to be
> received, and does not need to constantly search the whole queue for </ta=
g>.

Sorry, this is an API change and therefore not allowed for backporting
to a stable release.

Steve

>
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bin/bitbake-worker | 33 ++++++++++++++++++++++-----------
>  lib/bb/runqueue.py | 34 ++++++++++++++++++++++------------
>  2 files changed, 44 insertions(+), 23 deletions(-)
>
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index e02f2532..f8be973d 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -425,18 +425,29 @@ class BitbakeWorker(object):
>                  while self.process_waitpid():
>                      continue
>
> -
>      def handle_item(self, item, func):
> -        if self.queue.startswith(b"<" + item + b">"):
> -            index =3D self.queue.find(b"</" + item + b">")
> -            while index !=3D -1:
> -                try:
> -                    func(self.queue[(len(item) + 2):index])
> -                except pickle.UnpicklingError:
> -                    workerlog_write("Unable to unpickle data: %s\n" % ":=
".join("{:02x}".format(c) for c in self.queue))
> -                    raise
> -                self.queue =3D self.queue[(index + len(item) + 3):]
> -                index =3D self.queue.find(b"</" + item + b">")
> +        opening_tag =3D b"<" + item + b">"
> +        if not self.queue.startswith(opening_tag):
> +            return
> +
> +        tag_len =3D len(opening_tag)
> +        if len(self.queue) < tag_len + 4:
> +            # we need to receive more data
> +            return
> +        header =3D self.queue[tag_len:tag_len + 4]
> +        payload_len =3D int.from_bytes(header, 'big')
> +        # closing tag has length (tag_len + 1)
> +        if len(self.queue) < tag_len * 2 + 1 + payload_len:
> +            # we need to receive more data
> +            return
> +        index =3D self.queue.find(b"</" + item + b">")
> +        if index !=3D -1:
> +            try:
> +                func(self.queue[(len(item) + 2 + 4):index])
> +            except pickle.UnpicklingError:
> +                workerlog_write("Unable to unpickle data: %s\n" % ":".jo=
in("{:02x}".format(c) for c in self.queue))
> +                raise
> +            self.queue =3D self.queue[(index + len(b"</") + len(item) + =
len(b">")):]
>
>      def handle_cookercfg(self, data):
>          self.cookercfg =3D pickle.loads(data)
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 8605c46c..4e48c944 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1289,6 +1289,16 @@ class RunQueue:
>          self.worker =3D {}
>          self.fakeworker =3D {}
>
> +    @staticmethod
> +    def send_pickled_data(worker, data, name):
> +        msg =3D bytearray()
> +        pickled_data =3D pickle.dumps(data)
> +        msg.extend(b"<" + name.encode() + b">")
> +        msg.extend(len(pickled_data).to_bytes(4, 'big'))
> +        msg.extend(pickled_data)
> +        msg.extend(b"</" + name.encode() + b">")
> +        worker.stdin.write(msg)
> +
>      def _start_worker(self, mc, fakeroot =3D False, rqexec =3D None):
>          logger.debug("Starting bitbake-worker")
>          magic =3D "decafbad"
> @@ -1328,9 +1338,9 @@ class RunQueue:
>              "umask" : self.cfgData.getVar("BB_DEFAULT_UMASK"),
>          }
>
> -        worker.stdin.write(b"<cookerconfig>" + pickle.dumps(self.cooker.=
configuration) + b"</cookerconfig>")
> -        worker.stdin.write(b"<extraconfigdata>" + pickle.dumps(self.cook=
er.extraconfigdata) + b"</extraconfigdata>")
> -        worker.stdin.write(b"<workerdata>" + pickle.dumps(workerdata) + =
b"</workerdata>")
> +        RunQueue.send_pickled_data(worker, self.cooker.configuration, "c=
ookerconfig")
> +        RunQueue.send_pickled_data(worker, self.cooker.extraconfigdata, =
"extraconfigdata")
> +        RunQueue.send_pickled_data(worker, workerdata, "workerdata")
>          worker.stdin.flush()
>
>          return RunQueueWorker(worker, workerpipe)
> @@ -1340,7 +1350,7 @@ class RunQueue:
>              return
>          logger.debug("Teardown for bitbake-worker")
>          try:
> -           worker.process.stdin.write(b"<quit></quit>")
> +           RunQueue.send_pickled_data(worker.process, b"", "quit")
>             worker.process.stdin.flush()
>             worker.process.stdin.close()
>          except IOError:
> @@ -1867,14 +1877,14 @@ class RunQueueExecute:
>      def finish_now(self):
>          for mc in self.rq.worker:
>              try:
> -                self.rq.worker[mc].process.stdin.write(b"<finishnow></fi=
nishnow>")
> +                RunQueue.send_pickled_data(self.rq.worker[mc].process, b=
"", "finishnow")
>                  self.rq.worker[mc].process.stdin.flush()
>              except IOError:
>                  # worker must have died?
>                  pass
>          for mc in self.rq.fakeworker:
>              try:
> -                self.rq.fakeworker[mc].process.stdin.write(b"<finishnow>=
</finishnow>")
> +                RunQueue.send_pickled_data(self.rq.fakeworker[mc].proces=
s, b"", "finishnow")
>                  self.rq.fakeworker[mc].process.stdin.flush()
>              except IOError:
>                  # worker must have died?
> @@ -2156,10 +2166,10 @@ class RunQueueExecute:
>              if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']=
 and not self.cooker.configuration.dry_run:
>                  if not mc in self.rq.fakeworker:
>                      self.rq.start_fakeworker(self, mc)
> -                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" =
+ pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooke=
r.collections[mc].get_file_appends(taskfn), taskdepdata, False)) + b"</runt=
ask>")
> +                RunQueue.send_pickled_data(self.rq.fakeworker[mc].proces=
s, (taskfn, task, taskname, taskhash, unihash, True, self.cooker.collection=
s[mc].get_file_appends(taskfn), taskdepdata, False), "runtask")
>                  self.rq.fakeworker[mc].process.stdin.flush()
>              else:
> -                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pi=
ckle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.co=
llections[mc].get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>=
")
> +                RunQueue.send_pickled_data(self.rq.worker[mc].process, (=
taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[mc=
].get_file_appends(taskfn), taskdepdata, False), "runtask")
>                  self.rq.worker[mc].process.stdin.flush()
>
>              self.build_stamps[task] =3D bb.build.stampfile(taskname, sel=
f.rqdata.dataCaches[mc], taskfn, noextra=3DTrue)
> @@ -2243,10 +2253,10 @@ class RunQueueExecute:
>                          self.rq.state =3D runQueueFailed
>                          self.stats.taskFailed()
>                          return True
> -                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" =
+ pickle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cook=
er.collections[mc].get_file_appends(taskfn), taskdepdata, self.rqdata.setsc=
ene_enforce)) + b"</runtask>")
> +                RunQueue.send_pickled_data(self.rq.fakeworker[mc].proces=
s, (taskfn, task, taskname, taskhash, unihash, False, self.cooker.collectio=
ns[mc].get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)=
, "runtask")
>                  self.rq.fakeworker[mc].process.stdin.flush()
>              else:
> -                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pi=
ckle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cooker.c=
ollections[mc].get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_=
enforce)) + b"</runtask>")
> +                RunQueue.send_pickled_data(self.rq.worker[mc].process, (=
taskfn, task, taskname, taskhash, unihash, False, self.cooker.collections[m=
c].get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce), "r=
untask")
>                  self.rq.worker[mc].process.stdin.flush()
>
>              self.build_stamps[task] =3D bb.build.stampfile(taskname, sel=
f.rqdata.dataCaches[mc], taskfn, noextra=3DTrue)
> @@ -2448,9 +2458,9 @@ class RunQueueExecute:
>
>          if changed:
>              for mc in self.rq.worker:
> -                self.rq.worker[mc].process.stdin.write(b"<newtaskhashes>=
" + pickle.dumps(bb.parse.siggen.get_taskhashes()) + b"</newtaskhashes>")
> +                RunQueue.send_pickled_data(self.rq.worker[mc].process, b=
b.parse.siggen.get_taskhashes(), "newtaskhashes")
>              for mc in self.rq.fakeworker:
> -                self.rq.fakeworker[mc].process.stdin.write(b"<newtaskhas=
hes>" + pickle.dumps(bb.parse.siggen.get_taskhashes()) + b"</newtaskhashes>=
")
> +                RunQueue.send_pickled_data(self.rq.fakeworker[mc].proces=
s, bb.parse.siggen.get_taskhashes(), "newtaskhashes")
>
>              hashequiv_logger.debug(pprint.pformat("Tasks changed:\n%s" %=
 (changed)))
>
> --
> 2.36.1.vfs.0.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15492): https://lists.openembedded.org/g/bitbake-deve=
l/message/15492
> Mute This Topic: https://lists.openembedded.org/mt/102506319/3620601
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [steve@=
sakoman.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

