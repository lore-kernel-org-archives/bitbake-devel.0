Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id 1353C7A3D0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Oct 2018 05:26:27 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=svr-ies-mbx-02.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1g6qiy-0002oc-DP from Awais_Belal@mentor.com ;
	Sun, 30 Sep 2018 22:26:28 -0700
Received: from SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) by
	svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) with Microsoft SMTP
	Server (TLS) id 15.0.1320.4; Mon, 1 Oct 2018 06:26:24 +0100
Received: from SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17]) by
	SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17%22]) with
	mapi id 15.00.1320.000; Mon, 1 Oct 2018 06:26:24 +0100
From: "Belal, Awais" <Awais_Belal@mentor.com>
To: akuster808 <akuster808@gmail.com>, David Reyna
	<david.reyna@windriver.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/1] [SUMO] toaster: fix bitbake flexible
	path error from Bugzilla #12891
Thread-Index: AQHUWJARCOfE/1J89k20WpzKtqphj6UI/uIAgADeZFQ=
Date: Mon, 1 Oct 2018 05:26:24 +0000
Message-ID: <1538371578584.73841@mentor.com>
References: <cover.1538292172.git.David.Reyna@windriver.com>,
	<bb104247-dc6a-5a1d-6c4d-3f1fef79a9a2@gmail.com>
In-Reply-To: <bb104247-dc6a-5a1d-6c4d-3f1fef79a9a2@gmail.com>
Accept-Language: en-US, en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
MIME-Version: 1.0
Subject: Re: [PATCH 0/1] [SUMO] toaster: fix bitbake flexible path error from Bugzilla #12891
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
X-List-Received-Date: Mon, 01 Oct 2018 05:26:28 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>> yep, this applied cleanly.=0A=
=0A=
>> thanks,=0A=
>> Armin=0A=
=0A=
Thanks a lot David and Armin.=0A=
=0A=
BR,=0A=
Awais=0A=
=0A=
________________________________________=0A=
From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-bounces@l=
ists.openembedded.org> on behalf of akuster808 <akuster808@gmail.com>=0A=
Sent: Sunday, September 30, 2018 10:09 PM=0A=
To: David Reyna; bitbake-devel@lists.openembedded.org=0A=
Subject: Re: [bitbake-devel] [PATCH 0/1] [SUMO] toaster: fix bitbake flexib=
le path error from Bugzilla #12891=0A=
=0A=
On 09/30/2018 12:30 AM, David Reyna wrote:=0A=
> From: David Reyna <David.Reyna@windriver.com>=0A=
>=0A=
> Summary:=0A=
> In the previous patch that implemented flexable bitbake paths, a old defi=
nition=0A=
> of the bitbake path was left in the code, undoing the functionality. This=
 patch=0A=
> addresses that error.=0A=
=0A=
yep, this applied cleanly.=0A=
=0A=
thanks,=0A=
Armin=0A=
>=0A=
> The following changes since commit 3b8dc3a88e28546100a6b0b2f2cc37f44e6193=
71:=0A=
>=0A=
>   glibc: fix CVE-2018-11237 (2018-09-27 12:17:46 +0100)=0A=
>=0A=
> are available in the git repository at:=0A=
>=0A=
>   git://git.yoctoproject.org/poky-contrib dreyna/toaster/fix_bitbake_path=
_12942=0A=
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=3Ddreyna/toast=
er/fix_bitbake_path_12942=0A=
>=0A=
> Awais Belal (1):=0A=
>   toaster: [Sumo] fix bitbake flexible path error from Bugzilla #12891=0A=
>=0A=
>  lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
=0A=
--=0A=
_______________________________________________=0A=
bitbake-devel mailing list=0A=
bitbake-devel@lists.openembedded.org=0A=
http://lists.openembedded.org/mailman/listinfo/bitbake-devel=0A=

