Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web10.14146.1591372538720005389
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 08:55:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=HfDST4PW;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1757; q=dns/txt; s=axis-central1;
  t=1591372539; x=1622908539;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=bGsXftuQUtq8i/24U/yyqTYQswLwkQE8OFqrty5ifB0=;
  b=HfDST4PWVxbUaOu/UcrrjJyrnjT2cxsoF9tjILXwVq6g7lpyBVq4ql0r
   5teODrHu5CMh8RWcrdOQobLSfJL+KMLtfMmSLzDrNCbgLUaCODbKdHIPl
   Dy3Qsq45K4npgFqFlKcgPFhg9orlzYkBamOO0UuqTUjdBlLAoKBc6Uke0
   hD8ofe0FCd2FEHPUZmjXJqyPaBkOtfaiOIRS3pLghllm47QGEfXlafII5
   7jqoDmHm2WtcL3ZjVJkiuWT0fkb/aEAO0ht4YVbpNW9C0VOwEKi3fAe9t
   TEQzhNWrvRRHP7YE3ioaLZUm3SZ7QEklVzG1xZ9ZtW5qYItyxKeztO02U
   g==;
IronPort-SDR: oJGGHW3o5tlHe4HE855yIiqgbIIpIvxwRiiG6eXENhMHrTcRHNl+V5Wrh2noAeIkPyJCQUNexI
 DMj+8DcLtjkQeu3n8Ouy2db7gaoFejlXo6vRLAtDUBPenV1DLygt/FbQI/m67wPAdFAGSty+M7
 uxc1BgkXoyuPF+rAylj0Xb/iiJRag7mSnYteLMZpSyNozycYF19bUK4mRjY5bwk3gPcGGtklXQ
 NLN/mU6+CkB4d5+7Yi0XwAR9yhOIq9iZEDG8N3w3v0W7l6R50A2a2OAuRfAe+y6tshoDvd7lKm
 9Tg=
X-IronPort-AV: E=Sophos;i="5.73,476,1583190000"; 
   d="scan'208";a="9268040"
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [master][dunfell] prserv/serv: Avoid exception with newer versions of Python
Thread-Topic: [bitbake-devel] [master][dunfell] prserv/serv: Avoid exception
 with newer versions of Python
Thread-Index: AQHWO1Du5jtw8mihHE2bOehK1bVXKKjKLF6A
Date: Fri, 5 Jun 2020 15:55:36 +0000
Message-ID: <d5c2b555d38f4f30b78263b9ba8b371f@XBOX03.axis.com>
References: <1615B08CE92C4E2B.32071@lists.openembedded.org>
In-Reply-To: <1615B08CE92C4E2B.32071@lists.openembedded.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Peter Kjellerstedt
> Sent: den 5 juni 2020 17:49
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [master][dunfell] prserv/serv: Avoid exception w=
ith newer versions of Python
>=20
> The following exception was received when doing `devtool modify ...`:
>=20
>   Exception: ModuleNotFoundError: No module named '_sysconfigdata'
>=20
> This was previously partially solved in OE-Core, in commit 4b26eaf7
> (prservice.py: fix do_package with newer Python in Ubuntu
> 20.04). However, that only solved the problem for some cases where
> prserv was imported. This should solve if for all of them.
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/prserv/serv.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
> index 25dcf8a0ee..48f4b5b05d 100644
> --- a/bitbake/lib/prserv/serv.py
> +++ b/bitbake/lib/prserv/serv.py
> @@ -2,6 +2,12 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>=20
> +# Make sure _PYTHON_SYSCONFIGDATA_NAME is not set in the environment, wh=
ich may
> +# happen for recipes that, e.g., inherit python3native, which sets it. O=
therwise
> +# importing from xmlrpc.server fails with "No module named '_sysconfigda=
ta'"
> +if '_PYTHON_SYSCONFIGDATA_NAME' in os.environ:
> +    del os.environ['_PYTHON_SYSCONFIGDATA_NAME']
> +
>  import os,sys,logging
>  import signal, time
>  from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler

Without this, I can no longer use devtool with neither master nor=20
Dunfell.

//Peter

