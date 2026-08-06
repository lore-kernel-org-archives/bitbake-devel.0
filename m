Return-Path: <fjpedrazag@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68417C56208
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 16:14:30 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23081.1786032863581655560
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Aug 2026 09:14:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CZ+XjoAi;
 spf=pass (domain: gmail.com, ip: 209.85.221.171, mailfrom: fjpedrazag@gmail.com)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bfb1151c8aso148492e0c.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Aug 2026 09:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786032862; cv=none;
        d=google.com; s=arc-20260327;
        b=JoQy5FWo/UMSa4VfhU7CgLyFvQU5C9vpL8xFgLKg17GEz90/ugxtVq1bkgRpEbkDmP
         84TJ59W0VLqUFZKTG/YREhKXLnSlx6ZX5zSzrq9AZJjsamQvTv4rKaq+X1OxRLaawSVH
         Zv//ArDdlQ1deepuMf2XvahuqKWCBejU8WxAprRRz99rKUxkJ6/uvfUCI0m2kqXdclG9
         khGuLAiZo4k7pG+22sDJIIAmBOMdTc8nYSm/+aQXFXuTb74IbIBYwPVh2NRk1FAVOsgf
         V+WTqT+MRCyyNvSNE7vOV1K3Dr8ysF8/zXSU70jFRS/JwGYEvw2lo3pyaKigb46NM5oV
         S18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q1RZDpbXbPDQxPsUDxppgCUg3WhzslZnAF/WHn9srXE=;
        fh=gTVkUnL3FnX9JHTAY0+xyxQ0+AjtwFKEFhdivB6fyeo=;
        b=l4iDR6gh/ihi5b3/arnM4mTbM5a9aLTMyyjpS9YZQ5Xtukrv4/DPcf3WF7yzRUNkao
         /C3nrIBSQIgtkYEcTB2PknPocvY32/f00RMNNrvKecrZgbTjbyw3h2bhnayozz3xhvbm
         vdqquKJ6kWTceHOi2rnXtpTKq0ab7J2B81jhUmqO1J14Jt9Lm0Z8Sxc0KpMK+zPbdvAi
         XRwkBULeOs1+Z9jkGK1pccIFNSaMXNDwECQgHw8QnRgoPFuEvIhTFcqDogADSRrC0xjJ
         sagRGPDIM1ZSUdUlWKSizMptN+vJ8YVIsR3kTERYpcwyzBOSA9O5Qetk3zTwCR6hM8ZF
         wXDQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786032862; x=1786637662; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q1RZDpbXbPDQxPsUDxppgCUg3WhzslZnAF/WHn9srXE=;
        b=CZ+XjoAijdSrvYcaZmLHmUBhN85u17Fu5jsUgiyUk2xpcNyJsJEuYvskPeV4bfs9C3
         +gqq1jZ6Z74OnA/IyEuZFuL1z5mQsHG8Bbq4RNpfH1ZVl61L0r8SZ93TsTNULNkc8R2N
         QPf1dWjH7Hguryu1CMnameErx5GoMx9Nvta5brc6HkpeiJcpafN1wxmJnfQwGWhcHqkZ
         NfuwO9U6+RC8QvebEMGUCpwgelNiwUwvOA3wyPl+/v7nASZAfQTDbPfkqk8dEXbyeikJ
         wgeN174z5d/KGamtunXoN7+eADaR3oEQIs5n7aF0VxX8FV7P8OWlKfiGsKzherDMftFu
         Lk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786032862; x=1786637662;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q1RZDpbXbPDQxPsUDxppgCUg3WhzslZnAF/WHn9srXE=;
        b=eOI+MzEhyIjCfLRAW5eu75EfU7pPe431UcNdzT5Hh1Tp7NsG23KplIrQ2tq5H0k1Ha
         YTC0OxdTFjlOwb8TKQ0iCYQVc9VKYf8wWvXKHANGfqwluMA25RPlw3UIqJ8cMZV2GeZP
         N/pkytxTQk1Bmsu0fZIfW1gQu+EzaDygOjwGKNNgihTZuKtzQjoC68OH1llHzBVG/942
         0GCR//al9Y7Xer/GJFQehUyYSsKwLffnvIc35WP+uKDjYdFxQGU80vqgEevfnAhzXmmb
         chfXobDHLjYkFxqAzhe2Rn/+I3RsaNgjQfCJMdFKpwwjE5QzSOPijwGzEkeU+TSY99TA
         cPow==
X-Gm-Message-State: AOJu0YyT7cG0dU61OTWPFA8cbiaMsl/3PC9o7sHpAFx6ghMx2LjDA3Re
	qmVk0Ae62270tQKRIkcS7J45+2Vn5zNecjFiw4Q0ehGfMPnhkMcvbEL2YzU9CVMOnwloCxuo2Rg
	2CB94ZK+pfa2Ml1S9l9nZ6Ny/jtnUnWKAuo5ZnTg=
X-Gm-Gg: AR+sD12dl7ej2Uo5aAOLdOgAaA3/4k1gVrHF1DW0v0t9Ya1at+FsMDqWXRYzWin3kAP
	LOa7xdK+QlJ1p5L4Fbpi2ODW7uQ5/T1cqQJ6PdKaXufm0HhwIMpP+DNQ6l50MhRF2g8Bj6hi6+Y
	3dZvKc877Yci+UEox9Yj+/cO+UfDwxQJY5aV+wWMHlQy7bDOKJs1xo5QSNmDyiOO/s+fi6A7BVm
	X6yKboxYvnD9YkF4pryghyrD5zR81sKcoU1pWEyzFfl1R5EUznuxsjJm1o0zehzTUP46bxnhQ9O
	KtWvJONvNYDB62ZX9vEwO0BoI43Y70O4WmZgUmJcufzydt/8Do4yYghL
X-Received: by 2002:a05:6122:6851:10b0:5c1:24b6:a1e1 with SMTP id
 71dfb90a1353d-5c3d9216ad2mr1319546e0c.2.1786032862297; Thu, 06 Aug 2026
 09:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <18C9435B69834F73.3556697@lists.openembedded.org>
In-Reply-To: <18C9435B69834F73.3556697@lists.openembedded.org>
From: Francisco Pedraza <fjpedrazag@gmail.com>
Date: Thu, 6 Aug 2026 09:14:11 -0700
X-Gm-Features: AUfX_mx_hh8rWXRzIvwwIKcqBRpUZ_HrQ8uLA2EdzHM2uH7vAnZt7PHOwkvEv7c
Message-ID: <CANoLGeM+f570iDbh3ARbT6ALCDoCkdsATpeUxE0k7kdjRxi4MA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] asyncrpc: Close the client event loop
 when the client is collected
To: fjpedrazag@gmail.com
Cc: bitbake-devel@lists.openembedded.org, limon.anibal@gmail.com
Content-Type: multipart/alternative; boundary="0000000000005082fc0658632ee8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Aug 2026 16:14:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19905

--0000000000005082fc0658632ee8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 9:13=E2=80=AFAM Francisco Pedraza via lists.openembe=
dded.org
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
> Mute This Topic: https://lists.openembedded.org/mt/120629140/10567948
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> fjpedrazag@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000005082fc0658632ee8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 6, 2026 at 9:13=E2=
=80=AFAM Francisco Pedraza via <a href=3D"http://lists.openembedded.org">li=
sts.openembedded.org</a> &lt;fjpedrazag=3D<a href=3D"mailto:gmail.com@lists=
.openembedded.org">gmail.com@lists.openembedded.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Client creates its own e=
vent loop and installs it with<br>
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
tdown_asyncgens())<br>
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
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/120629140/105=
67948" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/=
mt/120629140/10567948</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:fjpedrazag@gmail.com" target=3D"_b=
lank">fjpedrazag@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000005082fc0658632ee8--

