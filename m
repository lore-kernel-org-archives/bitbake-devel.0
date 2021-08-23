Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web09.24045.1629726358774523302
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Aug 2021 06:45:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=G2XVx407;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1629726359;
  x=1661262359;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ccapny/qsfoxil/o8GIXmmaCXLAq8/DvHNGE5cykbpI=;
  b=G2XVx407VpnNHtXC5LlHQ7Ny6bIwacYaQPBs6kHF1QJtOgHfMPKQT2NU
   vd15S/RkHtwGxuaRWeq2ODfTm4TUwDGJsmKOl8ANZBvTaBCxct4RckD5q
   kFiniAXrHMcmCZwMwEFWpVsgp2iFhI1iRd1DXx2g0+Ab/dq8h4FcSnLFl
   8YKQqEt1Xiklj6uX7Hk5z7EeE2llw7sShylTtqQyFHc5DcMa6n3E8uk5Q
   7s2g6u0DG4GCuPQzYiB4n9++B7+FXQb4kGIRGjBtVdhHdJ6f2j1ZZiwC1
   rCPxKMD9h/vp26LpRXyezV6UJtajRIGur8AC8Mpx/1cl39xlr6/f3iUCQ
   Q==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] README: Add note about test suite and new tests
Thread-Topic: [bitbake-devel] [PATCH] README: Add note about test suite and
 new tests
Thread-Index: AQHXl5zP9KMppWrIjEucbN0UPFOEYquBGrqw
Date: Mon, 23 Aug 2021 13:45:55 +0000
Message-ID: <ad876f93694a443c867000a9ef17e409@axis.com>
References: <20210822212925.612609-1-richard.purdie@linuxfoundation.org>
 <20210822212925.612609-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210822212925.612609-2-richard.purdie@linuxfoundation.org>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Return-Path: peter.kjellerstedt@axis.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie
> Sent: den 22 augusti 2021 23:29
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] README: Add note about test suite and ne=
w
> tests
>=20
> Document that bitbake-selftest exists and that we appreciate test cases.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  README | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/README b/README
> index 64206de8a8..b9b3762972 100644
> --- a/README
> +++ b/README
> @@ -38,3 +38,11 @@ Mailing list:
>  Source code:
>=20
>      http://git.openembedded.org/bitbake/
> +
> +Testing:
> +
> +Bitbake has a testsuite located in lib/bb/tests/ whichs aim to try and
> prevent regressions.
> +You can run this with "bitbake-selftest". In particular the fetcher is
> well covered since
> +it has so many corner cases. The datastore has many tests too. Testing
> with the testsuite is
> +recommended becore submitting patches, particularly to the fetcher and

Change "becore" to "before".

> datastore. We also
> +appreciate new test cases and may require them for more obscure issues.
> --
> 2.32.0

//Peter
