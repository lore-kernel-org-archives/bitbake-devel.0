Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E48106ACF2
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 22:49:47 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3534.1773355777677097507
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Mar 2026 15:49:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=VQ4oqMdV;
 spf=pass (domain: smile.fr, ip: 209.85.128.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483487335c2so13511775e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 15:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773355776; x=1773960576; darn=lists.openembedded.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elbyslg/79ZSU+h8vWWWoryp+GFXe8zVAlys4wFSM78=;
        b=VQ4oqMdV7XMZTM9CA4gdWLaurdWgD9wq6DhVjXKQkTHHz/vW9xnBZ2oYSCHFaPT89J
         1WnkrdL2j+1W6Lqz6/7ST+V6l0qDk7Ud6BcbRrMXoIgPsrj2p9RsS77cagP3xEswMq+s
         jaJXLxO9bn92s1rqWlekoMCVuuvZwpntfQ2Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773355776; x=1773960576;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elbyslg/79ZSU+h8vWWWoryp+GFXe8zVAlys4wFSM78=;
        b=PvgmNNLSjLHLzMmnvYHnVguqx2oP3waLP1fY/6AycmEcWzvRKWnuyRU/ky+HBP2IkY
         d9vyBWgSqFppm77JV/Sx/yrOjsspGuxMcAmf/vtKhVyjsS+JIKSstEJl+NCNjqHUy6KA
         f9PGDEJtnD/vDt+OYfO6fx4k7CCfIIoH7DHgSlbcxNd+JSE1UWbOYpeIiDVciJrRgq2k
         6BmdCUYOb67gKIHj6K113WxBvlXth8+F93HsUdOcQdFVLqSEVkYQ3e8ifsqwKJzPLmuq
         awFj8Utchhbss0PsGTbs+OJyIR1fUZPdQjMlxlA72rGeZdLQD83laL1kWWkU3zrumHcB
         Qw0w==
X-Forwarded-Encrypted: i=1; AJvYcCWdiz1NO2LZ+ZAvny9uf05tD81N3w6YKRA7soY4UP0T6KnbzlyIYjXFzpys5C4DAIMZe23QCnzHdhU6lrpJ@lists.openembedded.org
X-Gm-Message-State: AOJu0YwqMl2apUNmt9IsaMjHbvH8jrjHM9rwJWPFMPT4ayMO8MAclJ48
	MKsKwONdGz9ONgtdaXPtFrb1Tab63HoZZxSDY82ZsxbK8H0cIdtW8OwCA4M8/Z7pH7o=
X-Gm-Gg: ATEYQzzkrE1lRbTjHibrJRZNLiHW0E6lhosmrYvZgXppNGrTBZag5CYjX3NkBnCwFaG
	fBjUZ3qK7yQggW4GAkM5lxk222b9/EmrvKKkCN1eKjiSaiNwPnRzu1mJ+2KtrSVAJfep+oKHAdp
	nTpGz+c5tt6ujLpCuFcz4hItITfVTif+VqoeVtl5NwqxZCc7UvNXoqBXZNsQZNUpxiJ0XgkxFtO
	wJj9dGPuSYHs6CU8BoBc06g/hp+1obN7PGCYYSaxKsBIMuc6z+PiiPppVtwKs8tdziYFCXTmySw
	3XkfU7gfiEkSt80Pk1+lDHmwZvzOIuMTWaffdq8o8dvfsMqtOrIaMi2hwxj4DngtCAl+tcP0lm8
	DRlIkm2whRQZToHHHbu3sgAL33Rz2BhG+rKb4UJ19aSm93ecEGmh7lEPc6DYYNJ8tvIOvCApo6i
	2iASqDchKG5s8srMLdgV0za7K9vFFwGzy48XAPYMEmvmlIGRGkdctPx1oY/PiHFKS0Xz1Xsloys
	VmYVMycuROBe3eX
X-Received: by 2002:a05:600c:4753:b0:485:3a93:3aa3 with SMTP id 5b1f17b1804b1-485566d3094mr16182035e9.12.1773355775725;
        Thu, 12 Mar 2026 15:49:35 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a9a19e6457d4ef2f.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a9a1:9e64:57d4:ef2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aac28bsm247114995e9.1.2026.03.12.15.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 15:49:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 23:49:34 +0100
Message-Id: <DH165OCUN8F6.287ALBTBP6H0@smile.fr>
Subject: Re: [bitbake-devel] [PATCH] fetch/wget: Improve connection error
 handling
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.0
References: <20260312223619.3735215-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20260312223619.3735215-1-richard.purdie@linuxfoundation.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 22:49:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19153

On Thu Mar 12, 2026 at 11:36 PM CET, Richard Purdie via lists.openembedded.=
org wrote:
> We see occasional connection errors in wget testing of sstate mirrors.
>
> It appears there is a case where http.client.RemoteDisconnected is
> returned against getrepsonse() which the current code doesn't handle
> well.
>
> Rather than trying to handle very specific error cases, catch any errors
> and drop the cached connection in those cases in the do_open() code.
>
> Similarly, try again, once in the case of errors in all cases rather
> than trying to handle a specific exception list.
>
> The traceback from the logs is included below for reference.
>
> Traceback (most recent call last):
>   File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fe=
tch2/wget.py", line 415, in checkstatus
>     with opener.open(r, timeout=3D100) as response:
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/urllib/request.py", line 519, in open
>     response =3D self._open(req, data)
>                ^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/urllib/request.py", line 536, in _open
>     result =3D self._call_chain(self.handle_open, protocol, protocol +
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/urllib/request.py", line 496, in _call_chain
>     result =3D func(*args)
>              ^^^^^^^^^^^
>   File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fe=
tch2/wget.py", line 178, in http_open
>     return self.do_open(HTTPConnectionCache, req)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fe=
tch2/wget.py", line 249, in do_open
>     r =3D h.getresponse()
>         ^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/http/client.py", line 1374, in getresponse
>     response.begin()
>   File "/usr/lib/python3.11/http/client.py", line 318, in begin
>     version, status, reason =3D self._read_status()
>                               ^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/http/client.py", line 287, in _read_status
>     raise RemoteDisconnected("Remote end closed connection without"
> http.client.RemoteDisconnected: Remote end closed connection without resp=
onse
>
> During handling of the above exception, another exception occurred:
>
> Traceback (most recent call last):
>   File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fe=
tch2/wget.py", line 228, in do_open
>     h.request(req.get_method(), req.selector, req.data, headers)
>   File "/usr/lib/python3.11/http/client.py", line 1282, in request
>     self._send_request(method, url, body, headers, encode_chunked)
>   File "/usr/lib/python3.11/http/client.py", line 1328, in _send_request
>     self.endheaders(body, encode_chunked=3Dencode_chunked)
>   File "/usr/lib/python3.11/http/client.py", line 1277, in endheaders
>     self._send_output(message_body, encode_chunked=3Dencode_chunked)
>   File "/usr/lib/python3.11/http/client.py", line 1037, in _send_output
>     self.send(msg)
>   File "/usr/lib/python3.11/http/client.py", line 998, in send
>     self.sock.sendall(data)
> OSError: [Errno 9] Bad file descriptor
>
> During handling of the above exception, another exception occurred:
>
> Traceback (most recent call last):
>   File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fe=
tch2/wget.py", line 415, in checkstatus
>     with opener.open(r, timeout=3D100) as response:
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/urllib/request.py", line 519, in open
>     response =3D self._open(req, data)
>                ^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/urllib/request.py", line 536, in _open
>     result =3D self._call_chain(self.handle_open, protocol, protocol +
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/urllib/request.py", line 496, in _call_chain
>     result =3D func(*args)
>              ^^^^^^^^^^^
>   File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fe=
tch2/wget.py", line 178, in http_open
>     return self.do_open(HTTPConnectionCache, req)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fe=
tch2/wget.py", line 246, in do_open
>     raise urllib.error.URLError(err)
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---

Could that be the fix for bug #15945?
AB-INT: fetch/sstate/CDN - Missing objects in the cache: Bad file descripto=
r
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15945

>  lib/bb/fetch2/wget.py | 41 +++++++++++++++--------------------------
>  1 file changed, 15 insertions(+), 26 deletions(-)
>
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index 4e3505599b4..a9d432b25d3 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -216,31 +216,20 @@ class Wget(FetchMethod):
> =20
>                  try:
>                      h.request(req.get_method(), req.selector, req.data, =
headers)
> -                except socket.error as err: # XXX what error?
> -                    # Don't close connection when cache is enabled.
> -                    # Instead, try to detect connections that are no lon=
ger
> -                    # usable (for example, closed unexpectedly) and remo=
ve
> -                    # them from the cache.
> -                    if fetch.connection_cache is None:
> -                        h.close()
> -                    elif isinstance(err, OSError) and err.errno =3D=3D e=
rrno.EBADF:
> -                        # This happens when the server closes the connec=
tion despite the Keep-Alive.
> -                        # Apparently urllib then uses the file descripto=
r, expecting it to be
> -                        # connected, when in reality the connection is a=
lready gone.
> -                        # We let the request fail and expect it to be
> -                        # tried once more ("try_again" in check_status()=
),
> -                        # with the dead connection removed from the cach=
e.
> -                        # If it still fails, we give up, which can happe=
n for bad
> -                        # HTTP proxy settings.
> +                    r =3D h.getresponse()
> +                except:
> +                    # This can happen when the server closes the connect=
ion despite the Keep-Alive.
> +                    # Apparently urllib then uses the file descriptor, e=
xpecting it to be
> +                    # connected, when in reality the connection is alrea=
dy gone.
> +                    # We let the request fail and expect it to be
> +                    # tried once more ("try_again" in check_status()),
> +                    # with the dead connection removed from the cache.
> +                    # If it still fails, we give up, which can happen fo=
r bad
> +                    # HTTP proxy settings.
> +                    if fetch.connection_cache:
>                          fetch.connection_cache.remove_connection(h.host,=
 h.port)
> -                    raise urllib.error.URLError(err)
> -                else:
> -                    try:
> -                        r =3D h.getresponse()
> -                    except TimeoutError as e:
> -                        if fetch.connection_cache:
> -                            fetch.connection_cache.remove_connection(h.h=
ost, h.port)
> -                        raise TimeoutError(e)
> +                    h.close()
> +                    raise
> =20
>                  # Pick apart the HTTPResponse object to get the addinfou=
rl
>                  # object initialized properly.
> @@ -404,9 +393,9 @@ class Wget(FetchMethod):
> =20
>                  with opener.open(r, timeout=3D100) as response:
>                      pass
> -            except (urllib.error.URLError, ConnectionResetError, Timeout=
Error) as e:
> +            except Exception as e:
>                  if try_again:
> -                    logger.debug2("checkstatus: trying again")
> +                    logger.debug2("checkstatus: trying again after excep=
tion %s" % str(e))
>                      return self.checkstatus(fetch, ud, d, False)
>                  else:
>                      # debug for now to avoid spamming the logs in e.g. r=
emote sstate searches


--=20
Yoann Congal
Smile ECS


