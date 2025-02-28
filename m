Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79204C19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 15:01:19 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web11.17701.1740754874875554700
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Feb 2025 07:01:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=j8kPVnBu;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5495177fcbcso629863e87.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 07:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740754873; x=1741359673; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szPP7JVRo6yQc3u1ZO7DGJYvfacFyhEoaGg4kTlqAyU=;
        b=j8kPVnBuAmg+TKyl8Qk3YC0YQ+Qfb4Z35K8xmlRuCyprkehryNVTORWacTotaWdAbu
         CJSZQ5t4aSwYqVWLs8QRZhyNqa+eJPK24F7bCPTpu9StiarZEU9t9viGqCpQDNVuOaqY
         NjLa4oyG3tzil55a5XxCMwY+X4EcIp4Yrmh70dh/IYTTYcRMdLq+xer/QKuzi2IIogOu
         MfL53P7AIHpqiG+EB1/Nqub633feRlI0IeNbDI4lj/+PJDEqj8zLucFgPDOSR6NHkJQO
         AxZgwfK5NgyjTn9Wh0+4bSu4NNmHoGrYeDO2bR0pGih4vZQu0pDRd/kGQ3/bLuFNYhye
         nNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740754873; x=1741359673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szPP7JVRo6yQc3u1ZO7DGJYvfacFyhEoaGg4kTlqAyU=;
        b=ojqzeAHAb14GHd2K8remH6l/395vAcXj4dNNlM94vlYluybdQIrNT1Fet4DVVg7jP1
         ZXx1BL6a1Uir8/E1qY0Kcsms4f4Xy22WT57TYJsPgVS63h/27pk2M0dL3waJSM3i1SLE
         3s1DYD+VoMlJQrOybtFdHQDgjy05X4nAlhKyOpUc2fQBgLcao4vzY6tzuAMmQveFDMCy
         d7ikHR4JNrFWS47BXbQrsJ0tcAeaJYvHomh7QpaXKvOgdL4PqjPnKvUES6CnIB7b42sJ
         3TbJTrg/IV6BurOIw0Qt0zLg641I+99aTIhS1KPfprf3iUZvrRaL8xEidtBDsehLSxNH
         bNwQ==
X-Gm-Message-State: AOJu0YyVpsZzEDod6Q5qy01dAhVyqXLfifCGwU18q58S+p+yjt7ynWxm
	jdrIkc3ZC8Pxh0mvnSiPd8i8mJygNipkA6JXHZjxKvQ+sJ0NCkGIWtFJWU9T1vPvoJF5dwezPtD
	vpxOUnY8dAmPhwKuRJiGcIfMpU+0=
X-Gm-Gg: ASbGncvWb/wCaYTRMG4QgAshY43WedDZBfD1LwYv7WlHkwS47Ji6o1X91sStE/1beUa
	xivgthJIleXvpr/TicDxGNzyrNUcyck7GdXlg4847EghKghnMtQf+LTaDxq1VsE7Ovffwin+Y7o
	BnuBQcyMDLuU2xXcut6L2R/A==
X-Google-Smtp-Source: AGHT+IEKjhS90BtelQRmhosliI1Dyi5KoPCTSTmXKESgRTAsCrVnhLe1vJbxg5WlytRfXCwv32SX34lTNjM8zU70+q4=
X-Received: by 2002:a05:6512:68b:b0:549:39b1:65d4 with SMTP id
 2adb3069b0e04-54943166b27mr3448185e87.0.1740754870956; Fri, 28 Feb 2025
 07:01:10 -0800 (PST)
MIME-Version: 1.0
References: <CAJdd5GZtxMRQB=VyEms8cS+1BjHxpDWZ8BZgPdvwQmYA8oy=7Q@mail.gmail.com>
 <16993.1740616945379904359@lists.openembedded.org>
In-Reply-To: <16993.1740616945379904359@lists.openembedded.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 28 Feb 2025 08:00:56 -0700
X-Gm-Features: AQ5f1JrztSEcm7YATUfqkbH32pcFZK3zu7i0t_dhw2Vrf4XAjNj6saFGHKzA5N8
Message-ID: <CAJdd5GZ5S9EwR+pw3qX8tHRo-t6dC0Rxaf2vWM7TxNz1t5ZpjA@mail.gmail.com>
Subject: Re: [bitbake-devel] Clarification on Cleaning Up a Remote Hash
 Equivalence DB
To: Alexandre.Marques@criticaltechworks.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 15:01:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17361

On Wed, Feb 26, 2025 at 5:42=E2=80=AFPM Alexandre Marques via
lists.openembedded.org
<Alexandre.Marques=3Dcriticaltechworks.com@lists.openembedded.org>
wrote:
>
> On Wed, Feb 26, 2025 at 08:08 AM, Joshua Watt wrote:
>
> On Wed, Feb 26, 2025 at 2:51=E2=80=AFAM Alexandre Marques
> <Alexandre.Marques@criticaltechworks.com> wrote:
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
> $ ./bitbake-hashclient --address localhost:8688 gc-mark alive --where tas=
khash 9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece0
> New hashes marked: 1
>
> $ ./bitbake-hashclient --address localhost:8688 gc-mark alive --where tas=
khash f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a9879e0
> New hashes marked: 1
>
> $ ./bitbake-hashclient --address localhost:8688 gc-mark alive --where tas=
khash 9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece0 --wh=
ere taskhash f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a9879=
e0
> New hashes marked: 1
>
> $ ./bitbake-hashclient --address localhost:8688 gc-mark alive --where tas=
khash 9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece0 --wh=
ere taskhash2 f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a987=
9e0
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
> $ ./bitbake-hashclient --address localhost:8688 gc-mark alive --where 9cd=
45da f1c4cca
>
> Server Side:
> {'mark': 'alive', 'where': {'taskhash': ['9cd45da', 'f1c4cca']}}
>
> No, you aren't missing anything, I was incorrect :)
>
> There are 2 approaches here.
>
> The first would be to improve bitbake-hashclient to add the input
> stream command, but keep the existing API with the server. Each mark
> sent through the file/pipe would result in a separate `mark` command
> being sent to the server. This should still be faster since it will
> reuse the same connection to the server as long as bitbake-hashclient
> is running, which will save the overhead of establishing and
> negotiating a connection. This also has the advantage that it doesn't
> require server side changes, but it does mean a round-trip for each
> `mark` command
>
>
> I have a simple POC for this first approach, and seems to be working fine=
.
> I still need to test with the remote server to have a better sense of how
> much faster it is, but based on my tests with a local server, I expect it=
 to
> still be in the "minutes".
>
> The second is to make a new server API to allow streaming of marks.
> The protocol between the client and server allows commands to go into
> a "stream" mode (which to be clear is distinct from the "input stream"
> discussed above, the name overlap is unfortunate). This mode allows
> the client to send newline delimited messages as fast as it wants
> (usually is some large batch size), and asynchronously read the
> responses from the server (see send_stream_batch() in the client
> code), allowing multiple messages to be in-flight at once.
> Implementing a new mark API on the server using this mechanism would
> be the fastest possible way of communicating the marks. Of course the
> disadvantage here is that it would require new API on the server, so a
> server upgrade would be required to use it. That said, it may be
> possible to make bitbake-hashclient intelligent enough to know if this
> new API exists and if so use it for the "input stream" and if not
> fallback to the older messages as described above
>
> I haven't tried the "stream mode" yet, but had a quick look at the code a=
nd I
> don't see any obvious reason for it not to work. :) so thanks!!
>
> I've been trying to tackle this "make bitbake-hashclient intelligent enou=
gh to know
> if this new API exists" and tbh I'm struggling a bit..

Right, sorry about that. Every time I've gone to add new API to the
server I've though: The server should really be able to communicate
it's version to the client, so the client knows what API is
available.... but I'll do that next time :)

I was certain I had actually done it last time, but I was wrong. I
might have a patch, let me check

>
> Whenever I use a command that isn't available on the server I just get "E=
rror talking
> to server: Connection closed". So far I'm not really seeing a way of gett=
ing more
> info on the particular error, and blindly assume a "connection closed" me=
ans the
> new API is not available does not seem right.
>
> I was thinking of adding a new command to the server to "request the API"=
, or check
> if a particular command is available, but that in itself changes the API =
:,)
> so its a bit chicken and egg, which makes me think this might not be the =
away to go..
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17334): https://lists.openembedded.org/g/bitbake-deve=
l/message/17334
> Mute This Topic: https://lists.openembedded.org/mt/111382632/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

