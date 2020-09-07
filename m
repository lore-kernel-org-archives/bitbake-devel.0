Received: from esa2.hc324-48.eu.iphmx.com (esa2.hc324-48.eu.iphmx.com [207.54.68.120])
 by mx.groups.io with SMTP id smtpd.web11.37269.1599467836102330370
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2020 01:37:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=Um2EzSWT;
 spf=pass (domain: bmw.de, ip: 207.54.68.120, mailfrom: prvs=512b25981=mikko.rapeli@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1599467836; x=1631003836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7pgDCxwOJtHp8u2mLqElc7LwzlBonstUhwsS/vwIdFY=;
  b=Um2EzSWTs5/p6MZwh2xW6xr3lKX/AeSuHSczuxmELEATau8ygAPiLiBZ
   +TFdBmispHHOkWa0Es9gAJXcogjpx3jc3gtPAPrcPgVkcdu2naiqjB0bw
   UWseA+ta9eGYYwp9HbfoymNRgOgYNRXZ9iOm4W23mnoabXuQwVsOGfxIX
   8=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa2.hc324-48.eu.iphmx.com with ESMTP/TLS; 07 Sep 2020 10:37:12 +0200
Received: from esabb1.muc ([160.50.100.31])  by esagw6.muc with ESMTP/TLS;
 07 Sep 2020 10:37:12 +0200
Received: from smucm10k.bmwgroup.net (HELO smucm10k.europe.bmw.corp) ([160.48.96.47])
 by esabb1.muc with ESMTP/TLS; 07 Sep 2020 10:37:12 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by smucm10k.europe.bmw.corp
 (160.48.96.47) with Microsoft SMTP Server (TLS;
 Mon, 7 Sep 2020 10:37:12 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
 smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1497.006; Mon, 7
 Sep 2020 10:37:12 +0200
From: "Mikko Rapeli" <mikko.rapeli@bmw.de>
To: <zhangyifan46@huawei.com>
CC: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] an idea about parallel doing do_patch
Thread-Topic: [bitbake-devel] an idea about parallel doing do_patch
Thread-Index: AQHWhPDDDlg+C63ht0yrqWgAHJOICKlcuL+A
Date: Mon, 7 Sep 2020 08:37:12 +0000
Message-ID: <20200907083711.GL2026@korppu>
References: <iYPR.1599467249227446374.EQbU@lists.openembedded.org>
In-Reply-To: <iYPR.1599467249227446374.EQbU@lists.openembedded.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1CE85203A01F1F4EB9F1B7A09D2F4CEC@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 07, 2020 at 01:27:29AM -0700, zhangyifan46 via lists.openembed=
ded.org wrote:
> In our peoject,we have suffered a lot from long duration of do_patch of =
linux kernel(3000+ patches). I found that one do_patch task uses only one p=
rocess. So I modify a llittle do do_patch task. Here is my idea:
> 1.analyse the patches,only getting the modified files of each patch.
> 2.cluster all patches according to the files modified( patch no.1 modifi=
es file A,B ,patch no.2 modifies file A, patch no.3 modifies file C,then we=
 cluster patch no.1 and no.2 as=A0 a group, patch no.3 as another group) , =
here I use union-find to do the cluster
> 3.assign one group on one process
> But I met the problem of probabilistic missing patches.
> Anyone has any comments about my idea?

I think having large patch sets in meta layers and applied with bitbake ar=
e not the
right solution. I would create a custom git repo and branch for large fork=
s/branches
like this.

Possibly it could also be possible to apply patches with git through mbox =
files, but
I don't think this will much faster than bitbake.

Hope this helps,

-Mikko

>=20
