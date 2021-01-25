Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.557.1611601758824700012
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jan 2021 11:09:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=pcN5rjdW;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1611601759;
  x=1643137759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YKxk/ZhlhN7VDwHRD4Ta1eASWDSwHJExT+Iwd142aAw=;
  b=pcN5rjdWKgtzFZ76IKIL7fISl3ctUcHB4hHHSKfD1BWeWfoOJj5xqhsP
   +sN+kBv5/10F3jf3o7yRUlKQWQxC8/q6RHRkSMpC98ud1HOUB/f8MXhAT
   EdjJZ/2/oFw1THa5wFna1eik2oeibgMBHua2potrMiRZafCIT48CRbLB0
   M4ydU3VJK+R/8fvf/W3cFYAOZpNHzKxJNG1oaqtHajSP5JGcrirJCXeZ0
   z7jIB+NnMQXyaTfNd+NVZHb+S1Ax47cAOiKgQOzDHuGWjmNXo12qPT19H
   JeYO9IGPRaJpWelJnRgyEruQxzr6KiRnOjGQz6PSC+M1B8ZS4npK3K0ar
   g==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Steve Sakoman <steve@sakoman.com>, "Mittal, Anuj" <anuj.mittal@intel.com>
CC: "BitBake Development (bitbake-devel@lists.openembedded.org)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Backport fix to ensure hash reflects vardepvalue flags correctly
Thread-Topic: Backport fix to ensure hash reflects vardepvalue flags correctly
Thread-Index: AdbzSs9iIwSRISEBSdmT28Djb0vF7gAAoJeQ
Date: Mon, 25 Jan 2021 19:09:17 +0000
Message-ID: <5f5368d3b152494381b94644bcdebc41@XBOX03.axis.com>
References: <165D8E7951114F3A.15892@lists.openembedded.org>
In-Reply-To: <165D8E7951114F3A.15892@lists.openembedded.org>
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
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> Sent: den 25 januari 2021 19:55
> To: Steve Sakoman <steve@sakoman.com>; Mittal, Anuj
> <anuj.mittal@intel.com>
> Cc: BitBake Development (bitbake-devel@lists.openembedded.org) <bitbake-
> devel@lists.openembedded.org>
> Subject: [bitbake-devel] Backport fix to ensure hash reflects vardepvalue
> flags correctly
>=20
> Can you please backport 26ccf1575aef2d6e2d7717d3bd10b1ed0d5a777d
> (data_smart: Ensure hash reflects vardepvalue flags correctly) to
> Dunfell and Gatesgarth?
>=20
> I am seeing errors when building an SDK with 3.1.5 because commit
> cc2e2c2d065530a5ab33fed139d16fe1dcdca4d9 (metadata_scm: Fix signature
> handling of METADATA_REVISION and METADATA_BRANCH) was backported
> to Dunfell in OE-Core. For Gatesgarth, the latter commit should also
> be backported (once the commit in bitbake has been backported).
>=20
> //Peter

Sorry, commit cc2e2c2d refers to the backported commit in Poky. The=20
original commit is 005651dc782859c01f170fb974811b2a13cb2cef in OE-Core.

//Peter

