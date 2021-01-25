Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.343.1611600892313850395
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jan 2021 10:54:53 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com header.s=axis-central1 header.b=ZAx3+mLS;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1611600892;
  x=1643136892;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=60K6QzjT4fO7g2XoQk5smH7bmSuAgzl05o3YOc2mlNU=;
  b=ZAx3+mLSqZ8L8oi98brM9tt1/0famY5nUQpMtE5lnEEUNOgX0RxEaquC
   8/eJ6FODTgucna+hiLnWyvvET77dexY1qa8cBxaSr5WdpD7Kcqn+VvJGw
   +I4M55tXSlHO7PnMB1QJ2ddsz+8b8BKpzJoG2167gtTVdq752xpbi2/7A
   QJGeSeGprYgQXxkpbEaz3jIblUEhX7VmffD1V9pIHOEYcI8EJZaVe5Nab
   daW4zFtWyuaNPOhJAcibVJ/7jeYacIslPuTf5mtLo10Av0KrrgPr+9YTc
   s1PaO1lAEBtI9Oq8VAlZ/mwC2MC9RXdVmwUqs7yeqhis7JmAH+OXJF/9/
   g==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Steve Sakoman <steve@sakoman.com>, "Mittal, Anuj" <anuj.mittal@intel.com>
CC: "BitBake Development (bitbake-devel@lists.openembedded.org)"
	<bitbake-devel@lists.openembedded.org>
Subject: Backport fix to ensure hash reflects vardepvalue flags correctly
Thread-Topic: Backport fix to ensure hash reflects vardepvalue flags correctly
Thread-Index: AdbzSs9iIwSRISEBSdmT28Djb0vF7g==
Date: Mon, 25 Jan 2021 18:54:49 +0000
Message-ID: <d5882aa4c29d4f268dd9312d597538ce@XBOX03.axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Can you please backport 26ccf1575aef2d6e2d7717d3bd10b1ed0d5a777d
(data_smart: Ensure hash reflects vardepvalue flags correctly) to=20
Dunfell and Gatesgarth?

I am seeing errors when building an SDK with 3.1.5 because commit=20
cc2e2c2d065530a5ab33fed139d16fe1dcdca4d9 (metadata_scm: Fix signature=20
handling of METADATA_REVISION and METADATA_BRANCH) was backported=20
to Dunfell in OE-Core. For Gatesgarth, the latter commit should also=20
be backported (once the commit in bitbake has been backported).

//Peter

