Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE9EE706E4
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 08:00:04 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web11.10962.1695283196529280270
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Sep 2023 00:59:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=G8lYUlXR;
 spf=pass (domain: snapchat.com, ip: 209.85.218.45, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9adc75f6f09so70768466b.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1695283195; x=1695887995; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kH0PqKoqMYCPqOC338QsbzL+xo4oZs10eJ19bjbR480=;
        b=G8lYUlXRdJUpTl8pdINfXns7XSZK0yggqsErqXlKycTjEuXLyebNSaU0+3bdlo8CTN
         5EwvFZzcrqGAHt3eAfiUOqNIt9FS8sh7gMrlqbTYOhJCCM7+6GPu9Bv0f2KeRO3fpvWq
         lLDtv+gSY6DYllhhdwwtXjuNMj6pcwLyev5rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695283195; x=1695887995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kH0PqKoqMYCPqOC338QsbzL+xo4oZs10eJ19bjbR480=;
        b=RddC8BO+HvtnnQDapVTEvqDDj+8ojli4e/LnaxZPtCctzL82eMUTJCQ9NI/XWO0eaU
         a2IwlRySw4JHf6EdL7ORbW9xO4356CsXp+VF+REq3ampoI2EJksZUZvz9qsq/ZvPMFvP
         52tPyamom3V+AGM7ioZYJsSNJHFWBFOm0uUbwjy+wl6HAxgbS/zPtDvoIsHIa90afkWT
         9reTjEEFMRDAct/GyhtMCavMQMqA0gT2eT3BKLFUhIsdxU9fKdpBF2MK7OA2dbq1zf+D
         bCfTqwRoLSHFWZ8jcFWixcXObvQf31pid3CmVw0esVEANdqV8n/ONtoj2E0JiVlzFKmE
         yDvg==
X-Gm-Message-State: AOJu0Yy7hA2j5jDae3AV5Xte2mYCBHbcODyEoePG/xBKV+vx0vT29FSS
	0VUsblOs8bzaaRYL8D8HtOhd7AOw2iLBnla9YQW/5Tgi6PWVaQM3yYA=
X-Google-Smtp-Source: AGHT+IFPRgwFYI8xywprMr/ApowRZktw+FbYRPlmyTY/GrRSNCnpj6LbJYO4PGbKcXVJUsXlFegvE08ZcHqTANhE4T4=
X-Received: by 2002:a17:907:77d3:b0:9ae:6196:a4d0 with SMTP id
 kz19-20020a17090777d300b009ae6196a4d0mr928110ejc.17.1695283194746; Thu, 21
 Sep 2023 00:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <1786DAEDA12E3A72.1961@lists.yoctoproject.org>
In-Reply-To: <1786DAEDA12E3A72.1961@lists.yoctoproject.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Thu, 21 Sep 2023 09:59:43 +0200
Message-ID: <CAHUKmYY_8n0YAE+0VVYj+uKru29dZ0qa1WOTyVt2Di5TGQCVAg@mail.gmail.com>
Subject: Re: [docs] [PATCH] bitbake-worker: add header with length of message
To: ecordonnier@snap.com
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000009df93b0605d9e031"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 08:00:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15098

--0000000000009df93b0605d9e031
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This was intended for the bitbake mailing-list only (not for the doc
mailing list).

Etienne

On Thu, Sep 21, 2023 at 9:57=E2=80=AFAM Etienne Cordonnier via
lists.yoctoproject.org <ecordonnier=3Dsnap.com@lists.yoctoproject.org> wrot=
e:

> From: Etienne Cordonnier <ecordonnier@snap.com>
>
> The IPC mechanism between runqueue.py and bitbake-worker is currently
> not scalable:
>
> The data is sent with the format <tag>pickled-data</tag>, and
> bitbake-worker
> has no information about the size of the message. Therefore, the
> bitbake-worker
> is calling select() and read() in a loop, and then calling
> "self.queue.find(b"</" + item + b">")"
> for each chunk received.
>
> This does not scale, because queue.find has a linear complexity relative
> to the size of the queue,
> and workerdata messages get very big e.g. for builds which reference a lo=
t
> of files in SRC_URI.
> The number of chunks varies, but on my test system a lot of chunks of
> 65536 bytes are sent, and each
> iteration takes 0.1 seconds, making the transfer of the "workerdata" data
> very slow (on my test setup
> 35 seconds before this fix, and 1.5 seconds after this fix).
>
> This commit adds a 4 bytes header after <tag>, so that bitbake-worker
> knows how many bytes need to be
> received, and does not need to constantly search the whole queue for
> </tag>.
>
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  bin/bitbake-worker | 34 +++++++++++++++++++++++-----------
>  lib/bb/runqueue.py | 34 ++++++++++++++++++++++------------
>  2 files changed, 45 insertions(+), 23 deletions(-)
>
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 451e6926..a4e78991 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -433,18 +433,30 @@ class BitbakeWorker(object):
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
> -                    workerlog_write("Unable to unpickle data: %s\n" %
> ":".join("{:02x}".format(c) for c in self.queue))
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
> +
> +        index =3D self.queue.find(b"</" + item + b">")
> +        if index !=3D -1:
> +            try:
> +                func(self.queue[(tag_len + 4):index])
> +            except pickle.UnpicklingError:
> +                workerlog_write("Unable to unpickle data: %s\n" %
> ":".join("{:02x}".format(c) for c in self.queue))
> +                raise
> +            self.queue =3D self.queue[(index + len(b"</") + len(item) +
> len(b">")):]
>
>      def handle_cookercfg(self, data):
>          self.cookercfg =3D pickle.loads(data)
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index c88d7129..9afb899c 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1318,6 +1318,16 @@ class RunQueue:
>          self.worker =3D {}
>          self.fakeworker =3D {}
>
> +    @staticmethod
> +    def send_pickled_data(worker, data, name):
> +        msg =3D bytearray()
> +        msg.extend(b"<" + name.encode() + b">")
> +        pickled_data =3D pickle.dumps(data)
> +        msg.extend(len(pickled_data).to_bytes(4, 'big'))
> +        msg.extend(pickled_data)
> +        msg.extend(b"</" + name.encode() + b">")
> +        worker.stdin.write(msg)
> +
>      def _start_worker(self, mc, fakeroot =3D False, rqexec =3D None):
>          logger.debug("Starting bitbake-worker")
>          magic =3D "decafbad"
> @@ -1353,9 +1363,9 @@ class RunQueue:
>              "umask" : self.cfgData.getVar("BB_DEFAULT_UMASK"),
>          }
>
> -        worker.stdin.write(b"<cookerconfig>" +
> pickle.dumps(self.cooker.configuration) + b"</cookerconfig>")
> -        worker.stdin.write(b"<extraconfigdata>" +
> pickle.dumps(self.cooker.extraconfigdata) + b"</extraconfigdata>")
> -        worker.stdin.write(b"<workerdata>" + pickle.dumps(workerdata) +
> b"</workerdata>")
> +        RunQueue.send_pickled_data(worker, self.cooker.configuration,
> "cookerconfig")
> +        RunQueue.send_pickled_data(worker, self.cooker.extraconfigdata,
> "extraconfigdata")
> +        RunQueue.send_pickled_data(worker, workerdata, "workerdata")
>          worker.stdin.flush()
>
>          return RunQueueWorker(worker, workerpipe)
> @@ -1365,7 +1375,7 @@ class RunQueue:
>              return
>          logger.debug("Teardown for bitbake-worker")
>          try:
> -           worker.process.stdin.write(b"<quit></quit>")
> +           RunQueue.send_pickled_data(worker.process, b"", "quit")
>             worker.process.stdin.flush()
>             worker.process.stdin.close()
>          except IOError:
> @@ -1892,14 +1902,14 @@ class RunQueueExecute:
>      def finish_now(self):
>          for mc in self.rq.worker:
>              try:
> -
> self.rq.worker[mc].process.stdin.write(b"<finishnow></finishnow>")
> +                RunQueue.send_pickled_data(self.rq.worker[mc].process,
> b"", "finishnow")
>                  self.rq.worker[mc].process.stdin.flush()
>              except IOError:
>                  # worker must have died?
>                  pass
>          for mc in self.rq.fakeworker:
>              try:
> -
> self.rq.fakeworker[mc].process.stdin.write(b"<finishnow></finishnow>")
> +
> RunQueue.send_pickled_data(self.rq.fakeworker[mc].process, b"", "finishno=
w")
>                  self.rq.fakeworker[mc].process.stdin.flush()
>              except IOError:
>                  # worker must have died?
> @@ -2194,10 +2204,10 @@ class RunQueueExecute:
>              if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']
> and not self.cooker.configuration.dry_run:
>                  if not mc in self.rq.fakeworker:
>                      self.rq.start_fakeworker(self, mc)
> -                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" =
+
> pickle.dumps(runtask) + b"</runtask>")
> +
> RunQueue.send_pickled_data(self.rq.fakeworker[mc].process, runtask,
> "runtask")
>                  self.rq.fakeworker[mc].process.stdin.flush()
>              else:
> -                self.rq.worker[mc].process.stdin.write(b"<runtask>" +
> pickle.dumps(runtask) + b"</runtask>")
> +                RunQueue.send_pickled_data(self.rq.worker[mc].process,
> runtask, "runtask")
>                  self.rq.worker[mc].process.stdin.flush()
>
>              self.build_stamps[task] =3D
> bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=3DFalse)
> @@ -2295,10 +2305,10 @@ class RunQueueExecute:
>                          self.rq.state =3D runQueueFailed
>                          self.stats.taskFailed()
>                          return True
> -                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" =
+
> pickle.dumps(runtask) + b"</runtask>")
> +
> RunQueue.send_pickled_data(self.rq.fakeworker[mc].process, runtask,
> "runtask")
>                  self.rq.fakeworker[mc].process.stdin.flush()
>              else:
> -                self.rq.worker[mc].process.stdin.write(b"<runtask>" +
> pickle.dumps(runtask) + b"</runtask>")
> +                RunQueue.send_pickled_data(self.rq.worker[mc].process,
> runtask, "runtask")
>                  self.rq.worker[mc].process.stdin.flush()
>
>              self.build_stamps[task] =3D
> bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=3DFalse)
> @@ -2500,9 +2510,9 @@ class RunQueueExecute:
>
>          if changed:
>              for mc in self.rq.worker:
> -                self.rq.worker[mc].process.stdin.write(b"<newtaskhashes>=
"
> + pickle.dumps(bb.parse.siggen.get_taskhashes()) + b"</newtaskhashes>")
> +                RunQueue.send_pickled_data(self.rq.worker[mc].process,
> bb.parse.siggen.get_taskhashes(), "newtaskhashes")
>              for mc in self.rq.fakeworker:
> -
> self.rq.fakeworker[mc].process.stdin.write(b"<newtaskhashes>" +
> pickle.dumps(bb.parse.siggen.get_taskhashes()) + b"</newtaskhashes>")
> +
> RunQueue.send_pickled_data(self.rq.fakeworker[mc].process,
> bb.parse.siggen.get_taskhashes(), "newtaskhashes")
>
>              hashequiv_logger.debug(pprint.pformat("Tasks changed:\n%s" %
> (changed)))
>
> --
> 2.36.1.vfs.0.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4280):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_docs_message_4280&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2=
epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D9zDlz2419LTIQ7=
phafiQ_Cg5hIU0WHfv3FI0wWcVZeig4Vtj4OXTnuNgXVJiagui&s=3DwAeqICpU81VrPzMf9mTZ=
mqnFtj4fx9hTm8sNqnQLLHQ&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_101495846_7048771&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D9zDlz2419LTIQ=
7phafiQ_Cg5hIU0WHfv3FI0wWcVZeig4Vtj4OXTnuNgXVJiagui&s=3Db9Stler8eiHf4c73NSA=
Zwhba5FXQFGruaFX3Qc4EbN4&e=3D
> Group Owner: docs+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_docs_unsub&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D9zDlz2419LTIQ7phafiQ_=
Cg5hIU0WHfv3FI0wWcVZeig4Vtj4OXTnuNgXVJiagui&s=3Dh7bLr3egrcXw13Vfp7jrYGVbaLI=
nxulkM-uSjOA5LLM&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000009df93b0605d9e031
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This was intended for the bitbake mailing-list only (not f=
or the doc mailing list).<br><br>Etienne</div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 21, 2023 at 9:57=E2=80=
=AFAM Etienne Cordonnier via <a href=3D"http://lists.yoctoproject.org">list=
s.yoctoproject.org</a> &lt;ecordonnier=3D<a href=3D"mailto:snap.com@lists.y=
octoproject.org">snap.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">From: Etienne Cordonnier &l=
t;<a href=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ecordonnier@sna=
p.com</a>&gt;<br>
<br>
The IPC mechanism between runqueue.py and bitbake-worker is currently<br>
not scalable:<br>
<br>
The data is sent with the format &lt;tag&gt;pickled-data&lt;/tag&gt;, and b=
itbake-worker<br>
has no information about the size of the message. Therefore, the bitbake-wo=
rker<br>
is calling select() and read() in a loop, and then calling &quot;self.queue=
.find(b&quot;&lt;/&quot; + item + b&quot;&gt;&quot;)&quot;<br>
for each chunk received.<br>
<br>
This does not scale, because queue.find has a linear complexity relative to=
 the size of the queue,<br>
and workerdata messages get very big e.g. for builds which reference a lot =
of files in SRC_URI.<br>
The number of chunks varies, but on my test system a lot of chunks of 65536=
 bytes are sent, and each<br>
iteration takes 0.1 seconds, making the transfer of the &quot;workerdata&qu=
ot; data very slow (on my test setup<br>
35 seconds before this fix, and 1.5 seconds after this fix).<br>
<br>
This commit adds a 4 bytes header after &lt;tag&gt;, so that bitbake-worker=
 knows how many bytes need to be<br>
received, and does not need to constantly search the whole queue for &lt;/t=
ag&gt;.<br>
<br>
Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.co=
m" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-worker | 34 +++++++++++++++++++++++-----------<br>
=C2=A0lib/bb/runqueue.py | 34 ++++++++++++++++++++++------------<br>
=C2=A02 files changed, 45 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/bin/bitbake-worker b/bin/bitbake-worker<br>
index 451e6926..a4e78991 100755<br>
--- a/bin/bitbake-worker<br>
+++ b/bin/bitbake-worker<br>
@@ -433,18 +433,30 @@ class BitbakeWorker(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while self.pr=
ocess_waitpid():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0continue<br>
<br>
-<br>
=C2=A0 =C2=A0 =C2=A0def handle_item(self, item, func):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.queue.startswith(b&quot;&lt;&quot; + i=
tem + b&quot;&gt;&quot;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D self.queue.find(b&quot=
;&lt;/&quot; + item + b&quot;&gt;&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while index !=3D -1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func=
(self.queue[(len(item) + 2):index])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except pickle.Unpi=
cklingError:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 work=
erlog_write(&quot;Unable to unpickle data: %s\n&quot; % &quot;:&quot;.join(=
&quot;{:02x}&quot;.format(c) for c in self.queue))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue =3D sel=
f.queue[(index + len(item) + 3):]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D self.que=
ue.find(b&quot;&lt;/&quot; + item + b&quot;&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 opening_tag =3D b&quot;&lt;&quot; + item + b&q=
uot;&gt;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.queue.startswith(opening_tag):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tag_len =3D len(opening_tag)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(self.queue) &lt; tag_len + 4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # we need to receive more data<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 header =3D self.queue[tag_len:tag_len + 4]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 payload_len =3D int.from_bytes(header, &#39;bi=
g&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # closing tag has length (tag_len + 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(self.queue) &lt; tag_len * 2 + 1 + payl=
oad_len:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # we need to receive more data<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D self.queue.find(b&quot;&lt;/&quot; +=
 item + b&quot;&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if index !=3D -1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func(self.queue[(t=
ag_len + 4):index])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except pickle.UnpicklingError:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 workerlog_write(&q=
uot;Unable to unpickle data: %s\n&quot; % &quot;:&quot;.join(&quot;{:02x}&q=
uot;.format(c) for c in self.queue))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.queue =3D self.queue[(index=
 + len(b&quot;&lt;/&quot;) + len(item) + len(b&quot;&gt;&quot;)):]<br>
<br>
=C2=A0 =C2=A0 =C2=A0def handle_cookercfg(self, data):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.cookercfg =3D pickle.loads(data)<br>
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py<br>
index c88d7129..9afb899c 100644<br>
--- a/lib/bb/runqueue.py<br>
+++ b/lib/bb/runqueue.py<br>
@@ -1318,6 +1318,16 @@ class RunQueue:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.worker =3D {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fakeworker =3D {}<br>
<br>
+=C2=A0 =C2=A0 @staticmethod<br>
+=C2=A0 =C2=A0 def send_pickled_data(worker, data, name):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D bytearray()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg.extend(b&quot;&lt;&quot; + name.encode() +=
 b&quot;&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pickled_data =3D pickle.dumps(data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg.extend(len(pickled_data).to_bytes(4, &#39;=
big&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg.extend(pickled_data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg.extend(b&quot;&lt;/&quot; + name.encode() =
+ b&quot;&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 worker.stdin.write(msg)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def _start_worker(self, mc, fakeroot =3D False, rqexec =
=3D None):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(&quot;Starting bitbake-worke=
r&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0magic =3D &quot;decafbad&quot;<br>
@@ -1353,9 +1363,9 @@ class RunQueue:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;umask&quot; : self.cf=
gData.getVar(&quot;BB_DEFAULT_UMASK&quot;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 worker.stdin.write(b&quot;&lt;cookerconfig&gt;=
&quot; + pickle.dumps(self.cooker.configuration) + b&quot;&lt;/cookerconfig=
&gt;&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 worker.stdin.write(b&quot;&lt;extraconfigdata&=
gt;&quot; + pickle.dumps(self.cooker.extraconfigdata) + b&quot;&lt;/extraco=
nfigdata&gt;&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 worker.stdin.write(b&quot;&lt;workerdata&gt;&q=
uot; + pickle.dumps(workerdata) + b&quot;&lt;/workerdata&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RunQueue.send_pickled_data(worker, self.cooker=
.configuration, &quot;cookerconfig&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RunQueue.send_pickled_data(worker, self.cooker=
.extraconfigdata, &quot;extraconfigdata&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RunQueue.send_pickled_data(worker, workerdata,=
 &quot;workerdata&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0worker.stdin.flush()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RunQueueWorker(worker, workerpipe)=
<br>
@@ -1365,7 +1375,7 @@ class RunQueue:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(&quot;Teardown for bitbake-w=
orker&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0worker.process.stdin.write(b&quot=
;&lt;quit&gt;&lt;/quit&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RunQueue.send_pickled_data(worker=
.process, b&quot;&quot;, &quot;quit&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 worker.process.stdin.flush()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 worker.process.stdin.close()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except IOError:<br>
@@ -1892,14 +1902,14 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0def finish_now(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for mc in self.rq.worker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.rq.worker[mc]=
.process.stdin.write(b&quot;&lt;finishnow&gt;&lt;/finishnow&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RunQueue.send_pick=
led_data(self.rq.worker[mc].process, b&quot;&quot;, &quot;finishnow&quot;)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq.worke=
r[mc].process.stdin.flush()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except IOError:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# worker must=
 have died?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for mc in self.rq.fakeworker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.rq.fakeworker=
[mc].process.stdin.write(b&quot;&lt;finishnow&gt;&lt;/finishnow&gt;&quot;)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RunQueue.send_pick=
led_data(self.rq.fakeworker[mc].process, b&quot;&quot;, &quot;finishnow&quo=
t;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq.fakew=
orker[mc].process.stdin.flush()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except IOError:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# worker must=
 have died?<br>
@@ -2194,10 +2204,10 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;fakeroot&#39; in ta=
skdep and taskname in taskdep[&#39;fakeroot&#39;] and not self.cooker.confi=
guration.dry_run:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not mc in =
self.rq.fakeworker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.rq.start_fakeworker(self, mc)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.rq.fakeworker=
[mc].process.stdin.write(b&quot;&lt;runtask&gt;&quot; + pickle.dumps(runtas=
k) + b&quot;&lt;/runtask&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RunQueue.send_pick=
led_data(self.rq.fakeworker[mc].process, runtask, &quot;runtask&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq.fakew=
orker[mc].process.stdin.flush()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.rq.worker[mc]=
.process.stdin.write(b&quot;&lt;runtask&gt;&quot; + pickle.dumps(runtask) +=
 b&quot;&lt;/runtask&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RunQueue.send_pick=
led_data(self.rq.worker[mc].process, runtask, &quot;runtask&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq.worke=
r[mc].process.stdin.flush()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.build_stamps[task] =3D=
 bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=3DFalse)<br>
@@ -2295,10 +2305,10 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0self.rq.state =3D runQueueFailed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0self.stats.taskFailed()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return True<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.rq.fakeworker=
[mc].process.stdin.write(b&quot;&lt;runtask&gt;&quot; + pickle.dumps(runtas=
k) + b&quot;&lt;/runtask&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RunQueue.send_pick=
led_data(self.rq.fakeworker[mc].process, runtask, &quot;runtask&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq.fakew=
orker[mc].process.stdin.flush()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.rq.worker[mc]=
.process.stdin.write(b&quot;&lt;runtask&gt;&quot; + pickle.dumps(runtask) +=
 b&quot;&lt;/runtask&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RunQueue.send_pick=
led_data(self.rq.worker[mc].process, runtask, &quot;runtask&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq.worke=
r[mc].process.stdin.flush()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.build_stamps[task] =3D=
 bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=3DFalse)<br>
@@ -2500,9 +2510,9 @@ class RunQueueExecute:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if changed:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for mc in self.rq.worker:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.rq.worker[mc]=
.process.stdin.write(b&quot;&lt;newtaskhashes&gt;&quot; + pickle.dumps(bb.p=
arse.siggen.get_taskhashes()) + b&quot;&lt;/newtaskhashes&gt;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RunQueue.send_pick=
led_data(self.rq.worker[mc].process, bb.parse.siggen.get_taskhashes(), &quo=
t;newtaskhashes&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for mc in self.rq.fakeworke=
r:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.rq.fakeworker=
[mc].process.stdin.write(b&quot;&lt;newtaskhashes&gt;&quot; + pickle.dumps(=
bb.parse.siggen.get_taskhashes()) + b&quot;&lt;/newtaskhashes&gt;&quot;)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RunQueue.send_pick=
led_data(self.rq.fakeworker[mc].process, bb.parse.siggen.get_taskhashes(), =
&quot;newtaskhashes&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hashequiv_logger.debug(ppri=
nt.pformat(&quot;Tasks changed:\n%s&quot; % (changed)))<br>
<br>
-- <br>
2.36.1.vfs.0.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#4280): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_docs_message_4280&amp;d=3DDwIFaQ=
&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRf=
Px_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D9zDlz2419LTIQ7phafiQ_Cg5hIU0WHfv3FI0w=
WcVZeig4Vtj4OXTnuNgXVJiagui&amp;s=3DwAeqICpU81VrPzMf9mTZmqnFtj4fx9hTm8sNqnQ=
LLHQ&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proo=
fpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_docs_message_4280&=
amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3D=
AhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D9zDlz2419LTIQ7phafiQ_Cg=
5hIU0WHfv3FI0wWcVZeig4Vtj4OXTnuNgXVJiagui&amp;s=3DwAeqICpU81VrPzMf9mTZmqnFt=
j4fx9hTm8sNqnQLLHQ&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_101495846_7048771&amp;d=3DDwIFaQ&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3D9zDlz2419LTIQ7phafiQ_Cg5hIU0WHfv3FI0wWcVZeig4V=
tj4OXTnuNgXVJiagui&amp;s=3Db9Stler8eiHf4c73NSAZwhba5FXQFGruaFX3Qc4EbN4&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_101495846_7048771&amp;d=3D=
DwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D9zDlz2419LTIQ7phafiQ_Cg5hIU0WHf=
v3FI0wWcVZeig4Vtj4OXTnuNgXVJiagui&amp;s=3Db9Stler8eiHf4c73NSAZwhba5FXQFGrua=
FX3Qc4EbN4&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:docs%2Bowner@lists.yoctoproject.org" target=
=3D"_blank">docs+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_docs_unsub&amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvj=
IDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkS=
Ga66m67E&amp;m=3D9zDlz2419LTIQ7phafiQ_Cg5hIU0WHfv3FI0wWcVZeig4Vtj4OXTnuNgXV=
Jiagui&amp;s=3Dh7bLr3egrcXw13Vfp7jrYGVbaLInxulkM-uSjOA5LLM&amp;e=3D" rel=3D=
"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com/v2/url?u=
=3Dhttps-3A__lists.yoctoproject.org_g_docs_unsub&amp;d=3DDwIFaQ&amp;c=3DncD=
TmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1=
DULJTKUkSGa66m67E&amp;m=3D9zDlz2419LTIQ7phafiQ_Cg5hIU0WHfv3FI0wWcVZeig4Vtj4=
OXTnuNgXVJiagui&amp;s=3Dh7bLr3egrcXw13Vfp7jrYGVbaLInxulkM-uSjOA5LLM&amp;e=
=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ec=
ordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000009df93b0605d9e031--

