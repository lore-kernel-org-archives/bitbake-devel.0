Return-Path: <pascal.bach@siemens.com>
X-Greylist: delayed 552 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 12 Jun 2015 12:56:46 UTC
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
	by mail.openembedded.org (Postfix) with ESMTP id D444B74051
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jun 2015 12:56:46 +0000 (UTC)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.1/8.15.1) with ESMTPS id t5CClTCR021391
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jun 2015 14:47:29 +0200
Received: from DEFTHW99ERMMSX.ww902.siemens.net
	(defthw99ermmsx.ww902.siemens.net [139.22.70.142])
	by mail2.sbs.de (8.15.1/8.15.1) with ESMTPS id t5CClTEw020749
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jun 2015 14:47:29 +0200
Received: from DENBGAT9ERRMSX.ww902.siemens.net (139.22.70.197) by
	DEFTHW99ERMMSX.ww902.siemens.net (139.22.70.142) with Microsoft SMTP
	Server (TLS) id 14.3.235.1; Fri, 12 Jun 2015 14:47:28 +0200
Received: from DEFTHW99EH4MSX.ww902.siemens.net ([169.254.2.192]) by
	DENBGAT9ERRMSX.ww902.siemens.net ([139.22.70.197]) with mapi id
	14.03.0235.001; Fri, 12 Jun 2015 14:47:28 +0200
From: "Bach, Pascal" <pascal.bach@siemens.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Allow access to specific git server while
	BB_FETCH_PREMIRRORONLY ="1"
Thread-Index: AdClDZx94akg9l0aSb6IzkPqidxZfQ==
Date: Fri, 12 Jun 2015 12:47:26 +0000
Message-ID: <355BE46A91031048906B695426A8D8E616BEA6C0@DEFTHW99EH4MSX.ww902.siemens.net>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.22.70.40]
MIME-Version: 1.0
Subject: Allow access to specific git server while BB_FETCH_PREMIRRORONLY ="1"
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 12 Jun 2015 12:56:47 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi everybody

I was wondering if there is a way to allow access to specific urls even if =
BB_NO_NETWORK or BB_FETCH_PREMIRRORONLY is set.

The use case I have at hand it that we want to fetch all 3rd party sources =
from a HTTP premirror we have internally. Except for some packages that are=
 hosted on a git server where we would like bitbake to always fetch from th=
ere (no tarball on the pre mirror).

I tried:
PREMIRROR_prepend =3D "git@local/foo.git git@local/foo.git \n"


But this doesn't seem to work.

Is there way to achieve this with the current PREMIRROR variable? Or is thi=
s functionality currently missing?

With best regards,
Pascal Bach



