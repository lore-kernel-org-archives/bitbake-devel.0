Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE02C5AC7C
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 17:43:31 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25107.1786038204025267237
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Aug 2026 10:43:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20251104.gappssmtp.com header.s=20251104 header.b=pcXeeynN;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.172, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81e9f7491ffso38545957b3.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Aug 2026 10:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786038203; cv=none;
        d=google.com; s=arc-20260327;
        b=OtAGvhFCUlQx/Ep5cLaKKmcNSPWOYM43vZCoO+kxVM5JDiiikmDLzCvLUk3PlwtMW/
         uCMApmejbemSjzMi+1sZ3dzxXf8+u2praqzlonjYYQX2iH3rzNBHT5WJGDFqXxS1GKVo
         hVTOw4B3b0ni7/TWQK9CO0rnwFMNb7U4cNZDC1F9zDGDB9VWAc/NityG9tUt4c1opKpf
         Ha1fyvdhpQDr0R6rgVsYkLLOs92DrChVm4NBgxO2VtYim0gLgAqbm82MbBbDytJd+Ar8
         gtkBMBKJ9Bm37nIk8MMp1zMGmrgiH0Wr2p1w87f+6vYeeFhqv+u7tzhqQZ38lb3XLC4l
         hLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=680W1VhxnTJoU6QKNFFibVtOHMyHJp4n5e5JZy/tn5I=;
        fh=kWj4CD2Qyq9Hx4Tqu+8PaaNpMzg0FurgEt+AK4hIWyU=;
        b=sXzJSfgmFV2j6xUKHHLSF1//Zo6I/b3Fh/TG7O+/xg5bgqRC7h8MITNHc9wKgjB/hf
         U30KmS7GNargRAwS2NGBarf/HplA85vhWfLgsLACzmgTFrqSfi5bJMT2kA1nJaW+xzH+
         Jjt/u7TYKQQvukea7NopbnSPoFffpKtBKWxt19XAQ82ZBZUfXZtgl2gTU0KLFIDpGHpV
         SLmLX7GpZ/BRLMyL42pmq3Ui4hPnQR3uhTRsYNajPsRa23HrDb+VvwFwlNmftOWeGBEA
         LS5fdslJVLsu3GHxXv9BtN2uSXP2qOUctuo1qAmd/RVUGM7WVZTwDMd/vwFOoDFK2O1u
         s7JQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20251104.gappssmtp.com; s=20251104; t=1786038203; x=1786643003; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=680W1VhxnTJoU6QKNFFibVtOHMyHJp4n5e5JZy/tn5I=;
        b=pcXeeynNv00QertBTIRqQoB4KiMVv4r/5E2nqPtIQaw8vJv64pv3E0iLFMyyJ7sQvi
         kJjrJrB68a8kgJ5HR5LDtgitlUAa5jTBkcmUGxfw7FjblDA/iJ4TIKSDsOe32N4ASqzn
         x65inKmwIDXlAfQh8LqBTVx9Sc8HpycJzLiF9NM0FmSqo8V+YREDhI5KA/o+YAbphFwt
         qreLpT2g58PQGOomJgXp1i1+bhcAB355zHEdkD7naEGOiJfPqwif3LCRL3OG5mvnJ5Tf
         IY6S5Sat8rR0n4nwlWvQq0gkboBm04bxD6Cs5iPjeHX7t9xnskJjf5D4ZvosjaZcaCJx
         Oqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786038203; x=1786643003;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=680W1VhxnTJoU6QKNFFibVtOHMyHJp4n5e5JZy/tn5I=;
        b=SXru9/VZsEc7WybBJGtdSZxJykjJ2VoEUdNN+F5GKnEPI071nJEhb/e7nhotKq5Jkp
         eo4VCDyJKtkgm+cqeB87cNIhyv718DRfIzP7n+auK7g3QR/zSy845I9MUBnCWOiswGut
         98l6tG9cCuyiXS4B2WXMB3Y/7N5U2ZXBUdrMa3sn6I2M3uDvsTxP7pE7fxppP8p9JQN5
         jDXpnRzboxQbBcnt6Kk6fChTOSgUFbMwOLX8ivdas67iEKQG3IIUTcHiPU0TbuRtRN+F
         /c/3dty/drbpfplikb1v6yh8SiwJ55t2S1K7iYKYPMWA4bmgjOiui+5CHPum+vmWYEA2
         dqVA==
X-Gm-Message-State: AOJu0Yzc+pbYMwtFb6nsFLF11HZCmmlo+/xVBQmqWwoDKo8j/q/uvUvv
	Uaz6/FiWHDsDvPZ+h/EAubU/u1qbJYjvJgEJAZldDTucWfMgjhL+t46teRm3qM8r3i36T1ZqmIq
	ovJ1HM4h2aVSDPpD5Hpox5QLbZNNKay5x84rzH/TD68yZTVabZoznXWw0Yw==
X-Gm-Gg: AR+sD10Z1iJ48gt/c0PRDmjNb8apPpdv96w8HUzO3sFoWebcFDxvQvHzDXRrNUcJdVc
	mtvnFczaK0R0nnlmyZ1i2peazfF6ZmQDl0n4mK8IeUSHbT0tqRfnFhK9++y1pRWW5ycZMxFfPfh
	uASvFQCDFdFaZlVtcBcvrMJ1vWvh7lDkbLLqrTEq88zIB2pcEh3l8fWV0/ra3boz9NhCdfu0ImA
	ZNBIj80PW8zopTS4a50lcyRE6W2MWHp/wFG/blC9HGoj0XJSxi7fuS5RXKGxZN0iaKPxQCtEZOB
	Pm4Gcmqufw3mXTeiyUlBPCPP4sSWCWHHSBu1eF/LzzE2SrQdbJejU4/YX6OPBgGSFjCbSFpL/QF
	Vu00oQ4xaKfaiWnd5u+ua/b5JiXRNYE8L
X-Received: by 2002:a05:690c:dd0:b0:80b:9f4e:a70 with SMTP id
 00721157ae682-8202250ee6fmr98181467b3.26.1786038202903; Thu, 06 Aug 2026
 10:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260806161258.3815426-1-fjpedrazag@gmail.com>
In-Reply-To: <20260806161258.3815426-1-fjpedrazag@gmail.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Thu, 6 Aug 2026 11:43:10 -0600
X-Gm-Features: AUfX_mwwj24dNKMwHByvoEhxHGbMxCUcCFKMrBZPJ1uRRQqCb60q_5FWJOGAqAY
Message-ID: <CAOU5ZMsdhMkOULLwYqsCh3BFLRT71ohRLi7kcoH1cmquh2SfLg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] asyncrpc: Close the client event loop
 when the client is collected
To: fjpedrazag@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000a3be370658646cf8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Aug 2026 17:43:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19907

--000000000000a3be370658646cf8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Only a small comment below.


On Thu, Aug 6, 2026 at 10:13=E2=80=AFAM Francisco Pedraza via lists.openemb=
edded.org
<fjpedrazag=3Dgmail.com@lists.openembedded.org> wrote:

> Client creates its own event loop and installs it with
> asyncio.set_event_loop(), so a client dropped without close() being
> called keeps the loop, and any transport that loop owns, alive. The
> loop only becomes collectable once a later client replaces the global
> reference, and asyncio then reports the transport and the loop as
> unclosed:
>
>   ResourceWarning: unclosed transport
> <asyncio.sslproto._SSLProtocolTransport object>
>   ResourceWarning: unclosed event loop <_UnixSelectorEventLoop
> running=3DFalse closed=3DFalse>
>
> This is why the warning shows up at an unrelated later point rather
> than where the client was leaked.
>
> SignatureGeneratorUniHashMixIn caches its client and only closes it
> from reset() and exit(), so any teardown path missing those leaks it.
>
> Register a weakref.finalize() to close the loop when the client is
> collected. close() detaches the finalizer first, so the explicit path
> does the same work as before.
>
> Reproduced with two clients where the first is never closed, on python
> 3.10 with websockets 10.4 and on python 3.14 with websockets 17.0.1.
> Both report the warnings without this change and neither does with it.
> bitbake-selftest hashserv.tests passes.
>
> Fixes [YOCTO #16236]
>
> Signed-off-by: Francisco Pedraza <fjpedrazag@gmail.com>
> ---
>  lib/bb/asyncrpc/client.py | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
> index 17b72033b..115acd456 100644
> --- a/lib/bb/asyncrpc/client.py
> +++ b/lib/bb/asyncrpc/client.py
> @@ -12,6 +12,7 @@ import socket
>  import sys
>  import re
>  import contextlib
> +import weakref
>  from threading import Thread
>  from .connection import StreamConnection, WebsocketConnection,
> DEFAULT_MAX_CHUNK
>  from .exceptions import ConnectionClosedError, InvokeError
> @@ -224,8 +225,29 @@ class Client(object):
>          # required (but harmless) with it.
>          asyncio.set_event_loop(self.loop)
>
> +        # The loop and its transports must be closed even if the caller
> never
> +        # calls close(). Since set_event_loop() above replaces the
> reference
> +        # held by the previous client, an unclosed loop only becomes
> reachable
> +        # for collection once another client is created, at which point
> +        # asyncio reports "unclosed transport" and "unclosed event loop"
> +        # ResourceWarnings. The finalizer is detached by close() so that
> the
> +        # normal path is unaffected.
> +        self._finalizer =3D weakref.finalize(
> +            self, self._close_loop, self.loop, self.client
> +        )
> +
>          self._add_methods("connect_tcp", "ping")
>
> +    @staticmethod
> +    def _close_loop(loop, client):
> +        if loop.is_closed():
> +            return
> +        try:
> +            loop.run_until_complete(client.close())
> +            loop.run_until_complete(loop.shutdown_asyncgens())
>

Maybe it's a good idea to add an exception to handle certain types of
errors and log when they happen.


> +        finally:
> +            loop.close()
> +
>      @abc.abstractmethod
>      def _get_async_client(self):
>          pass
> @@ -258,9 +280,8 @@ class Client(object):
>
>      def close(self):
>          if self.loop:
> -            self.loop.run_until_complete(self.client.close())
> -            self.loop.run_until_complete(self.loop.shutdown_asyncgens())
> -            self.loop.close()
> +            self._finalizer.detach()
> +            self._close_loop(self.loop, self.client)
>          self.loop =3D None
>
>      def __enter__(self):
> --
> 2.55.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19904):
> https://lists.openembedded.org/g/bitbake-devel/message/19904
> Mute This Topic: https://lists.openembedded.org/mt/120629140/8181911
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> anibal@limonsoftware.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000a3be370658646cf8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Only a small comment below.<br></div><div><br></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Aug 6, 2026 at 10:13=E2=80=AFAM Francisco Pedraza v=
ia <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt=
;fjpedrazag=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gmail.com=
@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Client creates its own event loop and installs it wi=
th<br>
asyncio.set_event_loop(), so a client dropped without close() being<br>
called keeps the loop, and any transport that loop owns, alive. The<br>
loop only becomes collectable once a later client replaces the global<br>
reference, and asyncio then reports the transport and the loop as<br>
unclosed:<br>
<br>
=C2=A0 ResourceWarning: unclosed transport &lt;asyncio.sslproto._SSLProtoco=
lTransport object&gt;<br>
=C2=A0 ResourceWarning: unclosed event loop &lt;_UnixSelectorEventLoop runn=
ing=3DFalse closed=3DFalse&gt;<br>
<br>
This is why the warning shows up at an unrelated later point rather<br>
than where the client was leaked.<br>
<br>
SignatureGeneratorUniHashMixIn caches its client and only closes it<br>
from reset() and exit(), so any teardown path missing those leaks it.<br>
<br>
Register a weakref.finalize() to close the loop when the client is<br>
collected. close() detaches the finalizer first, so the explicit path<br>
does the same work as before.<br>
<br>
Reproduced with two clients where the first is never closed, on python<br>
3.10 with websockets 10.4 and on python 3.14 with websockets 17.0.1.<br>
Both report the warnings without this change and neither does with it.<br>
bitbake-selftest hashserv.tests passes.<br>
<br>
Fixes [YOCTO #16236]<br>
<br>
Signed-off-by: Francisco Pedraza &lt;<a href=3D"mailto:fjpedrazag@gmail.com=
" target=3D"_blank">fjpedrazag@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/asyncrpc/client.py | 27 ++++++++++++++++++++++++---<br>
=C2=A01 file changed, 24 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py<br>
index 17b72033b..115acd456 100644<br>
--- a/lib/bb/asyncrpc/client.py<br>
+++ b/lib/bb/asyncrpc/client.py<br>
@@ -12,6 +12,7 @@ import socket<br>
=C2=A0import sys<br>
=C2=A0import re<br>
=C2=A0import contextlib<br>
+import weakref<br>
=C2=A0from threading import Thread<br>
=C2=A0from .connection import StreamConnection, WebsocketConnection, DEFAUL=
T_MAX_CHUNK<br>
=C2=A0from .exceptions import ConnectionClosedError, InvokeError<br>
@@ -224,8 +225,29 @@ class Client(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# required (but harmless) with it.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0asyncio.set_event_loop(self.loop)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # The loop and its transports must be closed e=
ven if the caller never<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # calls close(). Since set_event_loop() above =
replaces the reference<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # held by the previous client, an unclosed loo=
p only becomes reachable<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # for collection once another client is create=
d, at which point<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # asyncio reports &quot;unclosed transport&quo=
t; and &quot;unclosed event loop&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # ResourceWarnings. The finalizer is detached =
by close() so that the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # normal path is unaffected.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._finalizer =3D weakref.finalize(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self, self._close_loop, self.loo=
p, self.client<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._add_methods(&quot;connect_tcp&quot;=
, &quot;ping&quot;)<br>
<br>
+=C2=A0 =C2=A0 @staticmethod<br>
+=C2=A0 =C2=A0 def _close_loop(loop, client):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if loop.is_closed():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loop.run_until_complete(client.c=
lose())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loop.run_until_complete(loop.shu=
tdown_asyncgens())<br></blockquote><div><br></div><div>Maybe it&#39;s a goo=
d idea to add an exception to handle certain types of errors and log when t=
hey happen.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loop.close()<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@abc.abstractmethod<br>
=C2=A0 =C2=A0 =C2=A0def _get_async_client(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
@@ -258,9 +280,8 @@ class Client(object):<br>
<br>
=C2=A0 =C2=A0 =C2=A0def close(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.loop:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.loop.run_until_complete(sel=
f.client.close())<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.loop.run_until_complete(sel=
f.loop.shutdown_asyncgens())<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.loop.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._finalizer.detach()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._close_loop(self.loop, self=
.client)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.loop =3D None<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __enter__(self):<br>
-- <br>
2.55.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#19904): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/19904" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/19904</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/120629140/818=
1911" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/120629140/8181911</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:anibal@limonsoftware.com" target=
=3D"_blank">anibal@limonsoftware.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000a3be370658646cf8--

