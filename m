Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id A75BC798DF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2018 07:37:39 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=svr-ies-mbx-02.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1g5nLH-0001QI-Lo from Awais_Belal@mentor.com ;
	Fri, 28 Sep 2018 00:37:39 -0700
Received: from SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) by
	svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) with Microsoft SMTP
	Server (TLS) id 15.0.1320.4; Fri, 28 Sep 2018 08:37:36 +0100
Received: from SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17]) by
	SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17%22]) with
	mapi id 15.00.1320.000; Fri, 28 Sep 2018 08:37:36 +0100
From: "Belal, Awais" <Awais_Belal@mentor.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Reyna, David"
	<david.reyna@windriver.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller:
	fix bitbake path resolution
Thread-Index: AQHUS0UdM8G0xVWi7EeQqAsalTR7hKTvXz/wgAl59yqACvwpbYAAiJCAgAEHtc8=
Date: Fri, 28 Sep 2018 07:37:35 +0000
Message-ID: <1538120253384.1227@mentor.com>
References: <1536831336527.93802@mentor.com>	,
	<5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6@ALA-MBD.corp.ad.wrs.com>	,
	<1537430385445.98207@mentor.com> <1538034849901.46023@mentor.com>,
	<f3a9349906015f5961c688f27b82fa92967e5510.camel@linuxfoundation.org>
In-Reply-To: <f3a9349906015f5961c688f27b82fa92967e5510.camel@linuxfoundation.org>
Accept-Language: en-US, en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
MIME-Version: 1.0
Subject: Re: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path resolution
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
X-List-Received-Date: Fri, 28 Sep 2018 07:37:39 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>> I'm confused. Does master need the patch? or only sumo?=0A=
Both.=0A=
=0A=
BR,=0A=
Awais=0A=
=0A=
________________________________________=0A=
From: Richard Purdie <richard.purdie@linuxfoundation.org>=0A=
Sent: Thursday, September 27, 2018 9:53 PM=0A=
To: Belal, Awais; Reyna, David; bitbake-devel@lists.openembedded.org=0A=
Subject: Re: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller: =
fix bitbake path resolution=0A=
=0A=
On Thu, 2018-09-27 at 07:54 +0000, Belal, Awais wrote:=0A=
> >> I recommend this for both Sumo and for master as well, so that=0A=
> they stay in sync.=0A=
> Any thoughts here?=0A=
=0A=
I'm confused. Does master need the patch? or only sumo?=0A=
=0A=
Cheers,=0A=
=0A=
Richard=0A=

