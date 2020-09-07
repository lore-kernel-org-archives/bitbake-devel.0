Received: from esa1.hc324-48.eu.iphmx.com (esa1.hc324-48.eu.iphmx.com [207.54.68.119])
 by mx.groups.io with SMTP id smtpd.web10.37308.1599469101883724437
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2020 01:58:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@bmw.de header.s=mailing1 header.b=Ki2T2ziB;
 spf=pass (domain: bmw.de, ip: 207.54.68.119, mailfrom: prvs=512b25981=mikko.rapeli@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1599469101; x=1631005101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4aVdcivc2/hxKaaEeVatTML/wQbeiMl9qdHSypje4bM=;
  b=Ki2T2ziBTcCIxs90RXl0ZyIEv5g6BepaD+wykd+D9h+L5FjwI9ecuy+E
   4Im0VUkaa/yXe7HjuOW7viVwnfUKqXcpFpWyoPw2PvV83PxTJJ2mPM94c
   gAdvbdVHMFF/Gd8KdCqay3KAnH0jyZI1MFxpRvbZwqquMKrsEpSxIZWRF
   0=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa1.hc324-48.eu.iphmx.com with ESMTP/TLS; 07 Sep 2020 10:58:19 +0200
Received: from esabb6.muc ([160.50.100.50])  by esagw6.muc with ESMTP/TLS;
 07 Sep 2020 10:58:19 +0200
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp) ([160.48.96.49])
 by esabb6.muc with ESMTP/TLS; 07 Sep 2020 10:58:19 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by smucm10m.europe.bmw.corp
 (160.48.96.49) with Microsoft SMTP Server (TLS;
 Mon, 7 Sep 2020 10:58:19 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
 smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1497.006; Mon, 7
 Sep 2020 10:58:19 +0200
From: "Mikko Rapeli" <mikko.rapeli@bmw.de>
To: <zhangyifan46@huawei.com>
CC: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] an idea about parallel doing do_patch
Thread-Topic: [bitbake-devel] an idea about parallel doing do_patch
Thread-Index: AQHWhPDDDlg+C63ht0yrqWgAHJOICKlcuL+AgAABzICAAAQYAA==
Date: Mon, 7 Sep 2020 08:58:18 +0000
Message-ID: <20200907085816.GO2026@korppu>
References: <20200907083711.GL2026@korppu>
 <20610.1599468217725892636@lists.openembedded.org>
In-Reply-To: <20610.1599468217725892636@lists.openembedded.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2CC664E8B6FF934FA33B88164AB7BD68@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

Hi, please reply to mailing list too.

On Mon, Sep 07, 2020 at 01:43:37AM -0700, zhangyifan46@huawei.com wrote:
> Sure using git repo is best solution.
> But I am working in a company=A0 and we use local codes(tar + patches).
> right or wrong, I think if we can improve the efficiency of patching, it =
is better than nothing.

Well, here I would really move away from tar + patches approach and move th=
ings to git.
I've been there and forced BSP vendors to provide full git trees with prope=
r commit messages
and history linked to upstream kernel.org stable point releases. We have th=
ese
in our project and product requirements. I suggest talking to the vendors a=
nd moving
to git.

Tar and patches was ok in the 90's but not anymore large change sets.

Parallelizing do_patch() could be a nice addition but needs serious testing
and validation because bugs could have really serious effects.

Cheers,

-Mikko=
