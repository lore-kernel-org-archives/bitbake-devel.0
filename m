Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA07106ACF3
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 22:54:47 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3505.1773356079722432062
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Mar 2026 15:54:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KuSAzcul;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48541edecf9so16078245e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773356078; x=1773960878; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/MUcEonrn7/m5e/Vds304YzHv7pVCwl4yPrlaLVRiI=;
        b=KuSAzculvB302dw9xzHAIQ0z8YsvBgG0NBwTGimbyiYhJKHhCSsFjriUp0P6HLXDne
         Ki9fplfViixZB5RqRyvwRftjTIb7Qui3Fgo8QWx5prmRO60755Lw9UL5hungW+51oh+u
         lfHgdzsBkA5e0v/ZoMIH/kSvbo9ZOpw5DNdPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773356078; x=1773960878;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/MUcEonrn7/m5e/Vds304YzHv7pVCwl4yPrlaLVRiI=;
        b=VSt0lRdr7DFMZIuVkk0uvkVx0jYyTlvHOpyfJI8CXud6wIenDt5G23EwbYrjTU40pX
         es+1zSgkxlNr2wtkB+T0jNHQEglLoQw/WA5x0r7TKiMkVsDnghy7caG4of11m/v1m/EK
         z6yyW2G+ESpkkToaeGCJH1dFQNfh/hAwI2qpKMxOkn3JZ/7qeHSnXPNh6zJUecEDkCsf
         5c1mqNxfKz9OkBs0xBV8Xn/Pb+d3yOpPxoYvSEomnkGUa1MRLpW40ztEgG3yN58eEleA
         LWQCXyshdiwSEaXMdHRtfQ4jvZjvxSGrKoGSF8iJYS/pegxtI0iyX6L4lZVN13dQqumd
         do4A==
X-Forwarded-Encrypted: i=1; AJvYcCVP7JdsUVtR6kdeDESuKmHNGuDpynnX+TxFBKi9J+JfmNZCowjZMM47yHG0WG3uXnhU+GQOMBJP24i0tiX+@lists.openembedded.org
X-Gm-Message-State: AOJu0Yyz9v+LffvgydSArs7K0ocJRo5sROXEtvEFFiewxypbclI/cNXm
	u5r3e5V/8pCe4rFy6YMbH7BqJeRcgzXwQ4LOVJWPEJRK9kdKqzd7TdnfY4Du4sUewNc=
X-Gm-Gg: ATEYQzyGc87I0muKp4pbYi+eLe9kks9sPCARPPLN2q893jPztlVrCaSwbRxAJcDXDE8
	weN90NIsQncp37ZKq0DRPG9K7Uaa0gpN48m++Bmu5ExogZLGzGh0Eur9HuHdOLqwV/Dr4aG0B32
	WRhbCNqhwO/+13OMLxQen8Z/cildHpf9B3WJ7oQ/Uv7wu16cWneAh9+tuPkYq3LHD06yRj4ErdY
	zYijmTRgs/BSHTOf8QJTx9Rl5PCrRoNDFzM8DHBSdgJ3mIWdnrYyfc5urYJm8KMsUAFoC2vwTwC
	NNMeVfA8ktQqZWkTsaw5JAewjK2i9RPAoOQSMD3Iykp3j4jEgQLr59uOFSO2HVw/JkuSMUTha6Z
	oDXJQ6YJsWSC+H3rTM3r+rjyOOwxWwiQBXCGT2FpnlDrs7G3yoQJ1czsrfmcGjL0xEkqpmWK/E0
	FdrvnZ0niauuPco76lMtbQt6S9uetlOQ5wcfjrAqhqSKVDUZsMrrQu+wBCqeO/s/Nuh5MCzl0od
	dUNVVlqydW7
X-Received: by 2002:a05:600d:844f:10b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-485567029cdmr12539765e9.26.1773356077950;
        Thu, 12 Mar 2026 15:54:37 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5251:8788:f414:2fc? ([2001:8b0:aba:5f3c:5251:8788:f414:2fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm11660155f8f.4.2026.03.12.15.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:54:37 -0700 (PDT)
Message-ID: <aa8b1c9f77f111226e7bfdac39b0771ca3871656.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/wget: Improve connection error
 handling
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Yoann Congal <yoann.congal@smile.fr>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2026 22:54:36 +0000
In-Reply-To: <DH165OCUN8F6.287ALBTBP6H0@smile.fr>
References: <20260312223619.3735215-1-richard.purdie@linuxfoundation.org>
	 <DH165OCUN8F6.287ALBTBP6H0@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 22:54:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19154

On Thu, 2026-03-12 at 23:49 +0100, Yoann Congal wrote:
> On Thu Mar 12, 2026 at 11:36 PM CET, Richard Purdie via lists.openembedde=
d.org wrote:
> > We see occasional connection errors in wget testing of sstate mirrors.
> >=20
> > It appears there is a case where http.client.RemoteDisconnected is
> > returned against getrepsonse() which the current code doesn't handle
> > well.
> >=20
> > Rather than trying to handle very specific error cases, catch any error=
s
> > and drop the cached connection in those cases in the do_open() code.
> >=20
> > Similarly, try again, once in the case of errors in all cases rather
> > than trying to handle a specific exception list.
> >=20
> > The traceback from the logs is included below for reference.
> >=20
> > Traceback (most recent call last):
> > =C2=A0 File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/li=
b/bb/fetch2/wget.py", line 415, in checkstatus
> > =C2=A0=C2=A0=C2=A0 with opener.open(r, timeout=3D100) as response:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^=
^^^^^
> > =C2=A0 File "/usr/lib/python3.11/urllib/request.py", line 519, in open
> > =C2=A0=C2=A0=C2=A0 response =3D self._open(req, data)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^
> > =C2=A0 File "/usr/lib/python3.11/urllib/request.py", line 536, in _open
> > =C2=A0=C2=A0=C2=A0 result =3D self._call_chain(self.handle_open, protoc=
ol, protocol +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > =C2=A0 File "/usr/lib/python3.11/urllib/request.py", line 496, in _call=
_chain
> > =C2=A0=C2=A0=C2=A0 result =3D func(*args)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^^^^^^^^^^^
> > =C2=A0 File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/li=
b/bb/fetch2/wget.py", line 178, in http_open
> > =C2=A0=C2=A0=C2=A0 return self.do_open(HTTPConnectionCache, req)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > =C2=A0 File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/li=
b/bb/fetch2/wget.py", line 249, in do_open
> > =C2=A0=C2=A0=C2=A0 r =3D h.getresponse()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^
> > =C2=A0 File "/usr/lib/python3.11/http/client.py", line 1374, in getresp=
onse
> > =C2=A0=C2=A0=C2=A0 response.begin()
> > =C2=A0 File "/usr/lib/python3.11/http/client.py", line 318, in begin
> > =C2=A0=C2=A0=C2=A0 version, status, reason =3D self._read_status()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^
> > =C2=A0 File "/usr/lib/python3.11/http/client.py", line 287, in _read_st=
atus
> > =C2=A0=C2=A0=C2=A0 raise RemoteDisconnected("Remote end closed connecti=
on without"
> > http.client.RemoteDisconnected: Remote end closed connection without re=
sponse
> >=20
> > During handling of the above exception, another exception occurred:
> >=20
> > Traceback (most recent call last):
> > =C2=A0 File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/li=
b/bb/fetch2/wget.py", line 228, in do_open
> > =C2=A0=C2=A0=C2=A0 h.request(req.get_method(), req.selector, req.data, =
headers)
> > =C2=A0 File "/usr/lib/python3.11/http/client.py", line 1282, in request
> > =C2=A0=C2=A0=C2=A0 self._send_request(method, url, body, headers, encod=
e_chunked)
> > =C2=A0 File "/usr/lib/python3.11/http/client.py", line 1328, in _send_r=
equest
> > =C2=A0=C2=A0=C2=A0 self.endheaders(body, encode_chunked=3Dencode_chunke=
d)
> > =C2=A0 File "/usr/lib/python3.11/http/client.py", line 1277, in endhead=
ers
> > =C2=A0=C2=A0=C2=A0 self._send_output(message_body, encode_chunked=3Denc=
ode_chunked)
> > =C2=A0 File "/usr/lib/python3.11/http/client.py", line 1037, in _send_o=
utput
> > =C2=A0=C2=A0=C2=A0 self.send(msg)
> > =C2=A0 File "/usr/lib/python3.11/http/client.py", line 998, in send
> > =C2=A0=C2=A0=C2=A0 self.sock.sendall(data)
> > OSError: [Errno 9] Bad file descriptor
> >=20
> > During handling of the above exception, another exception occurred:
> >=20
> > Traceback (most recent call last):
> > =C2=A0 File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/li=
b/bb/fetch2/wget.py", line 415, in checkstatus
> > =C2=A0=C2=A0=C2=A0 with opener.open(r, timeout=3D100) as response:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^=
^^^^^
> > =C2=A0 File "/usr/lib/python3.11/urllib/request.py", line 519, in open
> > =C2=A0=C2=A0=C2=A0 response =3D self._open(req, data)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^
> > =C2=A0 File "/usr/lib/python3.11/urllib/request.py", line 536, in _open
> > =C2=A0=C2=A0=C2=A0 result =3D self._call_chain(self.handle_open, protoc=
ol, protocol +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > =C2=A0 File "/usr/lib/python3.11/urllib/request.py", line 496, in _call=
_chain
> > =C2=A0=C2=A0=C2=A0 result =3D func(*args)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^^^^^^^^^^^
> > =C2=A0 File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/li=
b/bb/fetch2/wget.py", line 178, in http_open
> > =C2=A0=C2=A0=C2=A0 return self.do_open(HTTPConnectionCache, req)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > =C2=A0 File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/li=
b/bb/fetch2/wget.py", line 246, in do_open
> > =C2=A0=C2=A0=C2=A0 raise urllib.error.URLError(err)
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
>=20
> Could that be the fix for bug #15945?
> AB-INT: fetch/sstate/CDN - Missing objects in the cache: Bad file descrip=
tor
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15945

I'm hoping so! I forgot to put the bug number in here but this is
aiming to fix that.

Cheers,

Richard

