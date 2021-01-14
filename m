Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web08.5606.1610646612780043062
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Jan 2021 09:50:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=QNgYpiH6;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1610646613;
  x=1642182613;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=R38bq4yB0FFjTr9WJw7jc6eWPDLN8vI9kOcVtiIN5J0=;
  b=QNgYpiH6ZnyY8ETTgjUmHFJjKNyTs8SwMIMUHw2zn5aJq2mSdpUh5YcH
   Yzy7hmBFsDS8gsWbLvvwAI3rQFcI3xI5S92NO1Ml8AgWsrjRcK/QOx2fa
   1yVFSE+7h03diKgl0PlN/6lw+61GC9UlM1B05JQlJMdMRuhE/RXPH7T15
   JnI3moQq+ltX80048nOSV9AqZd9wOXxbr77Zu5eeJS9kvAJF7hmw9da9K
   VooPr96MJiLTU0C027ARXzHRevq2VSTVwIgEGSu0ZQkCInVKg3ImNalLo
   FTTBGhod9yf3TDx7Ek9e+h7V5AxZsr8hHczkcK56hYJQ+CZ5DIaqu8jhU
   w==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Steve Sakoman <steve@sakoman.com>, "Mittal, Anuj" <anuj.mittal@intel.com>,
	Armin Kuster <akuster808@gmail.com>
CC: "OE Core (openembedded-core@lists.openembedded.org)"
	<openembedded-core@lists.openembedded.org>, "OE Development
 (openembedded-devel@lists.openembedded.org)"
	<openembedded-devel@lists.openembedded.org>, "BitBake Development
 (bitbake-devel@lists.openembedded.org)"
	<bitbake-devel@lists.openembedded.org>
Subject: Backport changes for _PYTHON_SYSCONFIGDATA_NAME to Gatesgarth and Dunfell
Thread-Topic: Backport changes for _PYTHON_SYSCONFIGDATA_NAME to Gatesgarth
 and Dunfell
Thread-Index: AdbqluypjM9qGzPGT4u0xlyyjXAnKg==
Date: Thu, 14 Jan 2021 17:50:10 +0000
Message-ID: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.20.13.13]
MIME-Version: 1.0
Return-Path: peter.kjellerstedt@axis.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[ Cross-posting since these changes affect all of bitbake, openembedded-cor=
e=20
  and meta-openembedded and need to be made (at least somewhat) in sync. ]

Can the solution for _PYTHON_SYSCONFIGDATA_NAME please be backported to=20
Gatesgarth and Dunfell? We are seeing problems for developers who have=20
updated the python3 version on their hosts when they try to do devtool=20
modify on recipes that inherit python3native. The following relevant=20
changes should cherry-pick cleanly to the respective repositories for=20
both gatesgarth and dunfell:

openembedded-core:
5a118d4e python3: split python target configuration into own class
dadf001c python3-pycairo: use python3targetconfig
9c8f6660 distutils3-base.bbclass: use python3targetconfig
d3a81dd0 meta: drop _PYTHON_SYSCONFIGDATA_NAME hacks
38ecb83c gpgme: use python3targetconfig
c99bb790 python3targetconfig.bbclass: Make py3 dep and tasks only for targe=
t recipes

bitbake:
47b64cfa lib/bb/fetch2/__init__.py: drop _PYTHON_SYSCONFIGDATA_NAME unsetti=
ng

meta-openembedded:
a06cdf5a gedit: Inherit python3targetconfig
59f817bb openipmi: Inherit python3targetconfig
be7d2286 libplist: Inherit python3targetconfig
c499aaee postgresql: Inherit python3targetconfig

I guess there may be some controversy regarding whether these changes shoul=
d=20
be backported to the stable branches since they modify what python3native=20
does and may require existing recipes to be modified to inherit the new=20
python3targetconfig class. However, I believe that having devtool modify=20
fail on random recipes without an easy solution for the user is much worse=
=20
than having to update a recipe or two once due to a build failure after=20
upgrading to a new version of OE-Core (in my book that is pretty normal and=
=20
something I always have to do anyway when we update OE-Core). And based on=
=20
the number of recipes in openembedded-core and meta-openembedded that neede=
d=20
to be updated (2+4), I do not expect there to be many other recipes in the=
=20
first place that actually need to be updated.

//Peter

