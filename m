Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3CDC56205
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 16:33:10 +0000 (UTC)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23960.1786033985712536901
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Aug 2026 09:33:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ZW5ScEDK;
 spf=pass (domain: gmail.com, ip: 74.125.224.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6682259cae6so2624755d50.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Aug 2026 09:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786033985; cv=none;
        d=google.com; s=arc-20260327;
        b=NWnPG8g16VO2c8yDMaSrTX9BuYqm6XwUe0uaXfcwzWL2LwisIwpa+T3UUHDmaCPSqW
         cOfR06xHOCOBTDLdypgv3HJbXdBXqdogz1oa4VpueYUtn2MfxY/FTh5FWdWBhy2DwLTh
         KLAdzY9PhGoBWvM+MnryHu9Km2hgMdrOvY9G8JsTHEFeydNol6beOXGyGSWCj5zmam73
         enBG99sxcRLrXqfiHwznKvibUhtT5li+Le4hS8f7V0y5XVt7QridXHlnV4ZuIxDPd0kc
         0FZKL56e258Kw0t5mpcJW86A7cNGPFLcGgwVJUmx1VogfVIrcFe6cZZ+NAwbQQRVh5W6
         2kGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p3AkDZYIa0QPLqfE7pXI3H1UDKZnlYX5JeUn6MEI5QU=;
        fh=kWj4CD2Qyq9Hx4Tqu+8PaaNpMzg0FurgEt+AK4hIWyU=;
        b=jQPGuvBIiQoQeCKcgcWkK54ZluhT21WHVMdrs2gcpfqfWqV0e46clc8hD+KlRUIHsM
         zMSynBW2JoyTNQbOiS2gODSW+yZVMmHja2oJ2K+zqVm1QMBSdNGyT944f7Jqnh5peVnj
         aEG6CIid5isq/d1zq7a2XxuFQ94WOZj0LU6Jl0r9qMugdcM6qo3UQmj/2BqSAbXJbzD4
         aSF/4pFBeyVIW8osOtOfMCHgNqU8sWCCmxi7D85j+dwL6+9VeQUU5JoiOXgdYJB4o9a4
         Gy742A4NuPvrMYCHE1BsMkRiYk5j+fPCPLZX9VmmjXEfDCwSoUuHjztxvWSLANyM6EQy
         2Q9w==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786033985; x=1786638785; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p3AkDZYIa0QPLqfE7pXI3H1UDKZnlYX5JeUn6MEI5QU=;
        b=ZW5ScEDKfnPLDcVUGju4lZop28TtkUVPbTHZJaDgY9lPF7hQHiPEdrGXVj2vkvbJnE
         G+fG8NCSE0zJ/a4Mc7LAU8ZRl5kBa6+M5waFqyHNAwoOvrT5AJNWNOgP9fTe4t6hTm5U
         txWDY60Mn5TTzoupqKmGmYLVfrXSVnTKBwGRR1Bj+ooOOhcGvj2b6GH0SMI+D5tB6/Ys
         I5iElQG/nX+fSsXVVmArMW7c73SGfUMspXtpqNuc6E8iE8BG1JzyrD/jXC+qgADX4aVK
         nlR0qDJ+rQGbmFKrLRKCW+m7bxQl8rjdX+6xVj/+GQB/UlIwjuJ1Acz8Jaxm6m/eMxPK
         kWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786033985; x=1786638785;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p3AkDZYIa0QPLqfE7pXI3H1UDKZnlYX5JeUn6MEI5QU=;
        b=BUMkX4m9+j48KQxjS+3BDf+fSpht6XewKXdLnLY2Yei1Xab13eyOs9CnOftMW3qoOf
         rPIFA7MfMFZ+i1lWcFvO3Z2EVpVcwH+di+Ld5b+NDm/7L50jQLuA5oBE06fwjDA7SuiF
         Em6OKg937aQsZuJn2uAUFQUUEQ/Qcnzmbqc5XCzvea2f3hzFRAFL8v5WjISz5q4p9YSA
         bvtvm6Bd7of0If8pRY7/9T5uw/KwoJNC6MR6G4AhQWsTQ4l+JnbK1HFz1XKhTF343G+r
         cY5bMg3Q5DUWcYyk+0WRIP5ErfloN91HVQftZs4WkGvkhs76fNhN3OqP/vFYDDjme5XX
         2glg==
X-Gm-Message-State: AOJu0Yz+Sk6AMEeWV1sX6Fihe7q5hpUrmP3Eu85Al7jn6YkCioM2QzfO
	fpHjLUe3R2ChZPCr3VmzY7Z9mRC4dWCqCpJ1FuEEuY2tHbBwTUWWcGEDHkyywvubOvlC/GbsVC7
	y9ApFzAFE9s4Q181rTtuD71PZzdKu2TefIg==
X-Gm-Gg: AR+sD134yHQlFxgZ3aJzRzKer8RPw+/X8G/cPh1nd9iuHlN1TJtr5BoaTnelKm3frmo
	te6imuc5e1h4cMHC5QXl1YA/P9yO8LHtDkT75XBAjDhwYoKPIK/KVPfAnVNkHRZA9dblAfAcTqq
	ccbwC3sEuAAfWCdeG47P/pnn/uE3nGs28gLrgXOzfGvWwLidTFS273FuE8jOCl+PBmNFqgzWxh2
	oir2vaS1ZQxDiOHKxJgNf+Q9t7pVf5CYvcAIZ2TeTwI6q1NFBA8VMRFa2zBBQQGlvzwGWtoLGvc
	jAdcB23PUwVRMuHewXGhWPh2MKP+Sd43pSa3ZKWdGQ+MSqiyDsCTv1EiGRg=
X-Received: by 2002:a53:b647:0:b0:667:b314:aeba with SMTP id
 956f58d0204a3-6699a837161mr6930587d50.5.1786033984538; Thu, 06 Aug 2026
 09:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260806161258.3815426-1-fjpedrazag@gmail.com>
In-Reply-To: <20260806161258.3815426-1-fjpedrazag@gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 6 Aug 2026 10:32:53 -0600
X-Gm-Features: AUfX_mz9oGBDja0AT-zAgOdgUrzDUhgBmvBOrswl0611nqvmRaNpzn6C_TeX1Og
Message-ID: <CAJdd5GZ6oMzBmkPCA7u4hkQEZ_N=2sADV4=78wKOT39K=RfKOA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] asyncrpc: Close the client event loop
 when the client is collected
To: fjpedrazag@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000348cbe06586371c1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Aug 2026 16:33:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19906

--000000000000348cbe06586371c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

LGTM Thanks

Reviewed-by: Joshua Watt <JPEWhacker@gmail.com>


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
> Mute This Topic: https://lists.openembedded.org/mt/120629140/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> JPEWhacker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000348cbe06586371c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 6, =
2026 at 10:13=E2=80=AFAM Francisco Pedraza via <a href=3D"http://lists.open=
embedded.org">lists.openembedded.org</a> &lt;fjpedrazag=3D<a href=3D"mailto=
:gmail.com@lists.openembedded.org">gmail.com@lists.openembedded.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Client c=
reates its own event loop and installs it with<br>
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
bitbake-selftest hashserv.tests passes.<br></blockquote><div><br></div><div=
>LGTM Thanks</div><div><br></div><div>Reviewed-by: Joshua Watt &lt;<a href=
=3D"mailto:JPEWhacker@gmail.com">JPEWhacker@gmail.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/120629140/361=
6693" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/120629140/3616693</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:JPEWhacker@gmail.com" target=3D"_b=
lank">JPEWhacker@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000348cbe06586371c1--

