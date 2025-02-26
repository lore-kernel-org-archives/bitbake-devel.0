Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86EDC18E7C
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 16:08:02 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web10.9409.1740586081170562480
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Feb 2025 08:08:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RWyWcIrr;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-547bcef2f96so7163589e87.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 08:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740586079; x=1741190879; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMFfbYfB8Ft3HJMbnmIVe8Yshy7Nb95up9qu0MjhAec=;
        b=RWyWcIrrzjqHRK4VI1MRIcjCb91W+EB93eezvlho7a49rwgsrgU05nj1VNeU0bxWre
         sUr7umpgP/T5RSiwYo3ebgucha4udONyb3H2hSWMKyVd34bXxPRc9gcwT6GhEBhTkrsu
         AVeikEmbMSdCVV2Lgb32HN8gy92nDFI9osnIn33gFKjxYT2VbUEDOYzmtqUEuq9e1FJR
         gQXurZDhD1E5waCv6DmStIoWu7lNRbOxVSbC/9FO6Dgcz9qNS1ChEUlutKFH6gT48scF
         zhugCBfis73E4fmL6qH6ZNtq49Dkbwb0GkMQJh/3Z8hlbhoGigJlvnzMJV/EX3NGyGu/
         WseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586079; x=1741190879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMFfbYfB8Ft3HJMbnmIVe8Yshy7Nb95up9qu0MjhAec=;
        b=ukIMazWpvvORwwrfje6M8cEallEtO2NA/b7xkYAQzfA1VLztK/AbJo8qvKZbw0MdfS
         ck5VYTHC8iaX5ewcfPnzcGbXSi5WOTd16CKOIy4EwXrMbCJ7nHwBmHtLYlV9ZXuoRO+p
         /opB5Zp9/tVS8aUkEHUKuGl4SeT+MTDwX9WSLerP5iFE3Agz6PkNZz4wBfPoeltyp5oy
         EpDBESi1gtWaBm9J7Y5G3Txh6f/0pqUYd16sJPIgEbBhqWhB/jPL4s4yD/o+Jsi4itFF
         LtYRCt10w9T80irGhkgXcHz39eKz8pMN2pgKeRRlDCKuQHWtEwA/xG+fFIG7ZOQUOfG+
         nEmg==
X-Gm-Message-State: AOJu0YzCgF8wZxu8ZnYK0ksCLdUOAjZFAtqRfr5RrDhy2beWWEkghK62
	wDJMExR+Iazbr17r01XEUHzHjXEh64+rS+h0MLtYZ3FeB4ETJ7lBhPm2wA5k8AACURl48VKUdRz
	d2zH8hmLitDGeREdQxSacQeQtflo=
X-Gm-Gg: ASbGncu2x1YkvByTV5Mc9hbgtIfRdQvuLvfbNmAoyO6/XDJXV8+hNb6a47tipRosSLi
	4ikxoBAuaqqYLAtQHpAuF1kGLluYFzUUAqBPTuL3tpCU5Q1jO8YBkpVFL1kxJPhTIcsuXOfpqqF
	wC4FqdKdo=
X-Google-Smtp-Source: AGHT+IEt0JLM/V7gUILfKdHf+pX5K5/YRB/9Lwp+unIyerI2WiDsl9O3fIDJ4qmhRaqomq4REyxSVSoJQsbMCXUixkc=
X-Received: by 2002:a05:6512:3e20:b0:545:2f5d:d5ab with SMTP id
 2adb3069b0e04-54838f4c9cdmr11908096e87.37.1740586078845; Wed, 26 Feb 2025
 08:07:58 -0800 (PST)
MIME-Version: 1.0
References: <GV1P193MB2055A662964438F153F844E5F8C32@GV1P193MB2055.EURP193.PROD.OUTLOOK.COM>
 <CAJdd5GY94n1iwg6F=33gZEJDCMJg_qEobTxSwtbcQSjvLfk1Mg@mail.gmail.com> <GV1P193MB20558AACD38226FBB04D62DAF8C22@GV1P193MB2055.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P193MB20558AACD38226FBB04D62DAF8C22@GV1P193MB2055.EURP193.PROD.OUTLOOK.COM>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 26 Feb 2025 09:07:45 -0700
X-Gm-Features: AQ5f1JrUuOqEflSG40sGmTIkWoNq0IQK-rHvUqeDzCX5XjlCSITKM_-l9lMyY10
Message-ID: <CAJdd5GZtxMRQB=VyEms8cS+1BjHxpDWZ8BZgPdvwQmYA8oy=7Q@mail.gmail.com>
Subject: Re: [bitbake-devel] Clarification on Cleaning Up a Remote Hash
 Equivalence DB
To: Alexandre Marques <Alexandre.Marques@criticaltechworks.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Helios <Helios@criticaltechworks.com>, 
	"node0-integration-build@list.bmw.com" <node0-integration-build@list.bmw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 16:08:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17331

On Wed, Feb 26, 2025 at 2:51=E2=80=AFAM Alexandre Marques
<Alexandre.Marques@criticaltechworks.com> wrote:
>
> It already does this. If you specify multiple KEY VALUE pairs on the
> command line, it will send all of them to the server in a single
> message.
>
> Well yes, but as far as I understand, keys get overwritten, and the key i=
s the actual db column, meaning we can't really pass multiple hashes, just =
"refine" the query.
>
> For example:
> Client Side:
> $ ./bitbake-hashclient  --address localhost:8688 gc-mark alive --where ta=
skhash 9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece0
> New hashes marked: 1
>
> $ ./bitbake-hashclient  --address localhost:8688 gc-mark alive --where ta=
skhash f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a9879e0
> New hashes marked: 1
>
> $ ./bitbake-hashclient  --address localhost:8688 gc-mark alive --where ta=
skhash 9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece0 --w=
here taskhash f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a987=
9e0
> New hashes marked: 1
>
> $ ./bitbake-hashclient  --address localhost:8688 gc-mark alive --where ta=
skhash 9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece0 --w=
here taskhash2 f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a98=
79e0
> New hashes marked: 1
>
> Server Side:
> {'mark': 'alive', 'where': {'taskhash': '9cd45da2fb6aa303a7828ec3cad7709b=
de2882422792e696016663f390aeece0'}}
> {'mark': 'alive', 'where': {'taskhash': 'f1c4cca2ea1fc1181c40afc8518d75db=
42d5c5e841fc4a4dbdcba30e1a9879e0'}}
> {'mark': 'alive', 'where': {'taskhash': 'f1c4cca2ea1fc1181c40afc8518d75db=
42d5c5e841fc4a4dbdcba30e1a9879e0'}}
> {'mark': 'alive', 'where': {'taskhash': '9cd45da2fb6aa303a7828ec3cad7709b=
de2882422792e696016663f390aeece0', 'taskhash2': 'f1c4cca2ea1fc1181c40afc851=
8d75db42d5c5e841fc4a4dbdcba30e1a9879e0'}}
>
> Perhaps I'm missing a something..
> What I was proposing would be supporting something similar to this:
> Client Side:
> $ ./bitbake-hashclient  --address localhost:8688 gc-mark alive --where 9c=
d45da f1c4cca
>
> Server Side:
> {'mark': 'alive', 'where': {'taskhash': ['9cd45da', 'f1c4cca']}}

No, you aren't missing anything, I was incorrect :)

There are 2 approaches here.

The first would be to improve bitbake-hashclient to add the input
stream command, but keep the existing API with the server. Each mark
sent through the file/pipe would result in a separate `mark` command
being sent to the server. This should still be faster since it will
reuse the same connection to the server as long as bitbake-hashclient
is running, which will save the overhead of establishing and
negotiating a connection. This also has the advantage that it doesn't
require server side changes, but it does mean a round-trip for each
`mark` command

The second is to make a new server API to allow streaming of marks.
The protocol between the client and server allows commands to go into
a "stream" mode (which to be clear is distinct from the "input stream"
discussed above, the name overlap is unfortunate). This mode allows
the client to send newline delimited messages as fast as it wants
(usually is some large batch size), and asynchronously read the
responses from the server (see send_stream_batch() in the client
code), allowing multiple messages to be in-flight at once.
Implementing a new mark API on the server using this mechanism would
be the fastest possible way of communicating the marks. Of course the
disadvantage here is that it would require new API on the server, so a
server upgrade would be required to use it. That said, it may be
possible to make bitbake-hashclient intelligent enough to know if this
new API exists and if so use it for the "input stream" and if not
fallback to the older messages as described above

>
>
> That said, the streaming command outlined above might be sufficient,
>
> Sounds reasonable.
>
>
> That said, if you do write a front end
> script like that, please consider sharing it with the rest of us :)
>
> Most definitely :)
>
> Thanks for the quick reply.
>
> ________________________________
> De: Joshua Watt <jpewhacker@gmail.com>
> Enviado: 26 de fevereiro de 2025 02:11
> Para: Alexandre Marques <Alexandre.Marques@criticaltechworks.com>
> Cc: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedde=
d.org>; Helios <Helios@criticaltechworks.com>; node0-integration-build@list=
.bmw.com <node0-integration-build@list.bmw.com>
> Assunto: Re: [bitbake-devel] Clarification on Cleaning Up a Remote Hash E=
quivalence DB
>
> Notice: This e-mail has originated from an external email service, so do =
not click on any links, nor open any attachments unless you know who the se=
nder is and are sure the content is secure.
>
>
>
> On Tue, Feb 25, 2025 at 11:44=E2=80=AFAM Alexandre Marques via
> lists.openembedded.org
> <Alexandre.Marques=3Dcriticaltechworks.com@lists.openembedded.org>
> wrote:
> >
> > Hello there,
> >
> > We are using a remote hash equivalence server and need to clean up irre=
levant hashes. Currently, we
> > iterate over a list of hashes, marking each as "alive" using "bitbake-h=
ashclient gc-mark", followed by
> > "bitbake-hashclient gc-sweep <marker>." This process is inefficient, ta=
king about 9 minutes for 12,000
> > hashes.
> >
> > We are wondering what would be the best way to go about improving this.=
.
> >
> > We propose extending "gc-mark" to support a "bulk-mode" for efficiency.
>
> It already does this. If you specify multiple KEY VALUE pairs on the
> command line, it will send all of them to the server in a single
> message. Granted, this is not the most useful on the command line. It
> might be possible to extend the command to take a file/stdin list of
> KEY VALUE pairs and automatically "chunk" them into the appropriate
> number of messages (maybe, 50 - 100 at a time?). Then you could
> probably have some script that finds all the files you want to keep
> and do something like:
>
>   find-sstate-files | bitbake-hashclient gc-mark-stream
>
> >
> > Additionally, we obtain hashes from sstate files and were considering a=
dapting the client to also accept
> > a list of files, possibly through a new command or flag. However the cl=
ient seems to act as a one-to-one
> > frontend to the server API calls. It's unclear if this is intentional o=
r by design, and if it would be of interest
> > adding such a feature?
>
> It's useful to be able to invoke individual server APIs with the tool,
> but the intent was not to limit it to just that (see the stress test).
> That said, the streaming command outlined above might be sufficient,
> and would mean that different users could implement a different filter
> on the front end instead of trying to code one logic that works for
> everyone in bitbake-hashclient. That said, if you do write a front end
> script like that, please consider sharing it with the rest of us :)
>
> >
> > Thank you,
> >
> > Best regards,
> > Alexandre Marques
> >
> >
> > The information in this communication may contain confidential or legal=
ly privileged information. It is intended solely for the use of the individ=
ual or entity it addresses and others authorized to receive it. If you are =
not an intended recipient, you are hereby notified that any disclosure, cop=
ying, distribution or action in reliance on the contents of this informatio=
n is strictly prohibited and may be unlawful. If you have received this com=
munication by error, please notify us immediately by responding to this e-m=
ail and then delete it from your system. Critical TechWorks is not liable f=
or the proper and complete transmission of the information in this communic=
ation nor for any delay in its receipt
> >
> > This e-mail is environmentally friendly, just like Critical TechWorks, =
which lives in a paper-free atmosphere. Therefore, please consider the envi=
ronment before printing it!
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#17322): https://lists.openembedded.org/g/bitbake-de=
vel/message/17322
> > Mute This Topic: https://lists.openembedded.org/mt/111382632/3616693
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEW=
hacker@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> The information in this communication may contain confidential or legally=
 privileged information. It is intended solely for the use of the individua=
l or entity it addresses and others authorized to receive it. If you are no=
t an intended recipient, you are hereby notified that any disclosure, copyi=
ng, distribution or action in reliance on the contents of this information =
is strictly prohibited and may be unlawful. If you have received this commu=
nication by error, please notify us immediately by responding to this e-mai=
l and then delete it from your system. Critical TechWorks is not liable for=
 the proper and complete transmission of the information in this communicat=
ion nor for any delay in its receipt
>
> This e-mail is environmentally friendly, just like Critical TechWorks, wh=
ich lives in a paper-free atmosphere. Therefore, please consider the enviro=
nment before printing it!

