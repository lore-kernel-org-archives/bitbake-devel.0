Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C7C5475B
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 15:23:59 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web10.14512.1709738636331156941
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Mar 2024 07:23:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=C/gbYwmx;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d23114b19dso88879671fa.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Mar 2024 07:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709738634; x=1710343434; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe9xQRPHWtTcK0qMHfTcZKm7+U0dVPw7Exdd2YE8hHc=;
        b=C/gbYwmxDMchjoWqkVXEcY+evsYHt2w+NbghqWku1dNhp6BDPrxKPoH0oEPnq93ie9
         7wOmXu/fvuwOveIyNN3KYi5PEZjHJ05Owrbjca49gCeTNiGuKz9Q/G02vODEEim3E/cM
         DRLpFcC/OeFJ7kGZ5xEJw9wo/k1z7OgDNmcdvrsJBgle/jdVoj1wmZRrVCHA9dHp8IeO
         hBDwIebiiGMazkVIaRr6ekxJGXsdIy58fV7HV2ngyP+94n+SmDBZg4Vw80D7XUXW+Oli
         8pC9mG7Gpgy27v0RhZDEDF8uByjyx/+Cu2pcCtuvsacyJFCLbHDouMDrSJTIuEK48t32
         EogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709738634; x=1710343434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qe9xQRPHWtTcK0qMHfTcZKm7+U0dVPw7Exdd2YE8hHc=;
        b=L9wWiBQBU2p6G+y48lGTaUMHEdnMrbKmRVNwPyaWtqYS1MH8hceO+8s5nZgUFfQ3yR
         qzacJ/z/6PdOZvO9TuoA5yTiwCQSgbLUB4aWZRZgfYau6G3kNI8/LDmO8F2kiFACCOVK
         4Xv9yUCpMgS05XfQcNRJAKdFC6NNee97Sr1iTCmyAlenK1vT4KbrH0eL8ShQMzlGrhG7
         KOKRsfh2C6I6EFbihNfsMpfnNOAeim1BW6+6Wuogk2Bm8QsytJ15RASFCrwVsjcSbPEa
         L8dG+Qtu27vw0GPw9MdXQlGAN73vH1H9w6WroshCTZ5uuESdCMfmifCAUgxCfTH+as3Q
         fQ+g==
X-Gm-Message-State: AOJu0YxRnjeLtiPPOD3sN2t8Dt1RTmE+snqcL6ZVFK75j0Hm5wNWdab7
	A9/SgGwPXajwC/YYld1gQMU93sL9C80aUdF1lkSCkIV1vQNEdU2bkd0IrZ3Z9TR36DRRgMlBrso
	vXQW13IfK9JMZVEYOexocTfHdU3E=
X-Google-Smtp-Source: AGHT+IFrrVlNBs64FWDXNf/0FwciLZnFFYv8gPLEgTtska+s3DOlxiC9Ob9mE5xRdqqDPzsSuQXqK0WJ/iAcWBPmULg=
X-Received: by 2002:a05:651c:10a9:b0:2d2:284d:3ae5 with SMTP id
 k9-20020a05651c10a900b002d2284d3ae5mr3411853ljn.45.1709738634047; Wed, 06 Mar
 2024 07:23:54 -0800 (PST)
MIME-Version: 1.0
References: <f1ddb6b8-fd5f-435f-8b20-ef60f62066db@bootlin.com>
 <CAJdd5GZgPcC2Oy+V=+eEq0YAB8R-Z1+31SSySgG8kmOJP2uc8g@mail.gmail.com>
 <17B9E3910B366E1C.13906@lists.openembedded.org> <f6c4573f-e6cc-4565-8c85-c16c57dd59c8@bootlin.com>
In-Reply-To: <f6c4573f-e6cc-4565-8c85-c16c57dd59c8@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 6 Mar 2024 08:23:41 -0700
Message-ID: <CAJdd5GZewkEVDXS7jCimT6_N-EUPtmUBgBcC7dWGNeCBns7Frg@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake: how to create a client to an asyncrpc
 server from another server?
To: michael.opdenacker@bootlin.com
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Mar 2024 15:23:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15989

On Wed, Mar 6, 2024 at 4:28=E2=80=AFAM Michael Opdenacker via
lists.openembedded.org
<michael.opdenacker=3Dbootlin.com@lists.openembedded.org> wrote:
>
> Hi Joshua
>
> On 3/5/24 at 15:09, Michael Opdenacker via lists.openembedded.org wrote:
> > Hi Joshua
> >
> > On 3/4/24 at 20:27, Joshua Watt wrote:
> >> Michael,
> >>
> >> Create an async client instead of a blocking client:
> >>
> >>    conn =3D client.PRAsyncClient()
> >>
> >> You'll want to do this anyway because you want to make async calls to
> >> the "upstream" server. If you use a blocking client it will block the
> >> entire server process during the call which means the server won't be
> >> able to process any other clients while waiting for a response.
> >
> > That was exactly what I needed, thanks! Now, the "upstream" server is
> > receiving the connections from my local server. The received requests
> > are still invalid (investigating) but this is already a nice leap
> > forward.
>
>
> Actually, I'm struggling to reproduce this, as the upstream server
> doesn't seem to receive connections any more.
>
> Anyway, I'm not sure what you're suggesting is what I want. The
> connection to the upstream server is attempted from the start() function
> of the PRServer class, which is synchronous, so a synchronous connection
> to the upstream server should be fine too, right?

The PRServer and clients are only implemented asynchronously; in both
cases the "synchronous" version is just a wrapper around the async
version that makes a loop to handle requests for your (and in the case
of PRServer, I think it also runs that loop on a thread in the
background). In the case of using a client from the inside the server,
you won't be able to use the "blocking" start() function to create the
client, because any blocking calls run on the server will block the
entire server and all clients it's currently processing (e.g. the
server has a single thread and uses cooperative multitasking to
service the clients, so it should never make truly blocking calls as
they block everyone). Instead, in the server you'll need to create an
async client and the manually connect it to the server using the
correct connection function, e.g.:

  client =3D PRAsyncClient()
  await client.connect_websocket("http://my-upstream-server/websocket")

See the AsyncClient class in bitbake for all the connect functions; it
might be worth moving the address string parsing logic in
bitbake/lib/hashserv/__init__.py in that class so it can be shared by
all the async clients.

>
> However, this makes we wonder whether the local server start is the best
> place to establish the connection to the upstream server. It may be
> better to attempt to establish the connection for each client, as the
> upstream server could be temporarily unavailable. This way, some clients
> will get a failure, but later other clients will succeed, when the
> upstream server is back. This would work without having to restart the
> local server.

Yes. This is what the hash equivalent server does also. You'll
actually have to do it this way because the PRAsyncClient() (or any
AsyncClient for that matter) is not designed to have concurrent or
interleaved requests. In the PRServer, each connected client gets its
own "thread" (although remember it's cooperative multitasking, so
there aren't actually threads). If you tried to share a single client
connection between all the client "threads", it could end up
interleaving requests to the server on a single client, which will not
work. Instead, create a PRAsyncClient() for each client connected to
the server. In the hash equivalence server this is done in
hashsever.client.ServerClient::process_requests(). I'd recommend doing
similar in the PRServerClient class

FWIW, process_requests() is basically the "thread" entry point for the
client. In the AsyncClient class, it goes into a loop reading requests
and sending responses until the connection closes, so you override
this in your class to make the upstream client, then call
super().process_client() to go into the normal request handling (as in
the HE example).

>
> This looks like a better solution, right?
> Cheers
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15988): https://lists.openembedded.org/g/bitbake-deve=
l/message/15988
> Mute This Topic: https://lists.openembedded.org/mt/104727453/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

