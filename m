Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE11C4332F
	for <webhook@archiver.kernel.org>; Mon, 12 Dec 2022 08:03:28 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.37908.1670832204506694876
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Dec 2022 00:03:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=Glx+6DZj;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1670832205;
  x=1702368205;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=TJPsmdxcGVVLknPcTJg3zF/Jvf11qNZzQkDBtXZxgRg=;
  b=Glx+6DZjMKuz6ir9lf7Bk/l/dR4bH+BSMXQD11OORjOSYrYWrn3/ygmV
   8zz4ITXT52q+dzsclub9kO1bMMeyVv78rQMeZH1Ou1maNEbQqBGDRx7L5
   iX2ue7oABYuWJh4UDtEcSGbK9+7Nvmx7J2xDWYIZrWVPgzxI8TyIXtlAj
   6Bwk/yMcsXH4+HFlh2RSrVdL7HCp1hdG0Ujm42yAMURKX1/VDI7iXY0tD
   OMTDckvaBh/sb+SpASqNMYgApqyUVsdSWMayBhDanJKbGos/utHU5KdDp
   6wzm+5jpckvAdKrdS+95UujDLElftADZEOoDQnGnBG6yQhmxloqBd8bCi
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] bitbake: Bump minimum version requirement
 to 3.8
Thread-Topic: [bitbake-devel] [PATCH] bitbake: Bump minimum version
 requirement to 3.8
Thread-Index: AQHZDYa8iORFtmqcnE2+UEr/W4lY6q5p5Rsg
Date: Mon, 12 Dec 2022 08:03:22 +0000
Message-ID: <e064a3a6420349819788be767f1bdffb@axis.com>
References: <20221211173345.22120-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20221211173345.22120-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 08:03:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14176

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie
> Sent: den 11 december 2022 18:34
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] bitbake: Bump minimum version requiremen=
t to 3.8

Change "version" to "Python version".

//Peter


