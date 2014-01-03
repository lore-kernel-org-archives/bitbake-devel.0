Return-Path: <zhenhua.luo@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
	(mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
	by mail.openembedded.org (Postfix) with ESMTP id 4EDAD61105
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jan 2014 02:12:26 +0000 (UTC)
Received: from DM2PR03MB399.namprd03.prod.outlook.com (10.141.84.148) by
	DM2PR03MB302.namprd03.prod.outlook.com (10.141.54.13) with Microsoft
	SMTP Server (TLS) id 15.0.851.11; Fri, 3 Jan 2014 02:12:26 +0000
Received: from DM2PR03MB399.namprd03.prod.outlook.com ([10.141.84.148]) by
	DM2PR03MB399.namprd03.prod.outlook.com ([10.141.84.148]) with mapi id
	15.00.0842.003; Fri, 3 Jan 2014 02:12:25 +0000
From: "zhenhua.luo@freescale.com" <zhenhua.luo@freescale.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH 0/2] bitbake: fetch2: Add sanity check for SHA validity
	of tag and adjust SHA define order
Thread-Index: AQHPAH8hUU3FkQsgYk69seRo+O0sD5pyUTOQ
Date: Fri, 3 Jan 2014 02:12:24 +0000
Message-ID: <a34678390a3f4fd6b075154afafa9699@DM2PR03MB399.namprd03.prod.outlook.com>
References: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
In-Reply-To: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.88.158.211]
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009001)(13464003)(51704005)(377454003)(199002)(189002)(19580405001)(19580395003)(83322001)(4396001)(49866001)(47736001)(50986001)(47976001)(87936001)(87266001)(2656002)(81686001)(81816001)(80976001)(74876001)(74706001)(76576001)(76796001)(76786001)(85306002)(81342001)(81542001)(69226001)(74316001)(83072002)(85852003)(56816005)(90146001)(33646001)(74366001)(65816001)(31966008)(74502001)(74662001)(80022001)(54316002)(59766001)(77982001)(63696002)(47446002)(79102001)(56776001)(53806001)(46102001)(51856001)(76482001)(66066001)(54356001)(24736002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM2PR03MB302;
	H:DM2PR03MB399.namprd03.prod.outlook.com; CLIP:192.88.158.211;
	FPR:; RD:InfoNoRecords; A:1; MX:1; LANG:en; 
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: "B40290@freescale.com" <B40290@freescale.com>,
	"ting.liu@freescale.com" <ting.liu@freescale.com>,
	"Zongchun.Yu@freescale.com" <Zongchun.Yu@freescale.com>
Subject: Re: [PATCH 0/2] bitbake: fetch2: Add sanity check for SHA validity of tag and adjust SHA define order
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
X-List-Received-Date: Fri, 03 Jan 2014 02:12:29 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Any comment on the patch to support SHA validate of tag?


Best Regards,

Zhenhua

> -----Original Message-----
> From: Zhenhua Luo [mailto:zhenhua.luo@freescale.com]
> Sent: Tuesday, December 24, 2013 4:07 PM
> To: bitbake-devel@lists.openembedded.org
> Cc: Liu Ting-B28495; Yu Zongchun-B40527; Guo Chunrong-B40290; Luo
> Zhenhua-B19537
> Subject: [PATCH 0/2] bitbake: fetch2: Add sanity check for SHA validity
> of tag and adjust SHA define order
>=20
> * Add the sanity check for SHA valididy when tag is defined in SRC_URI,
> the check is useful for rebased git tree in which the referred commit is
> not valid in branch and is saved in tag.
>=20
> * To allign with above change, the priority of revision needs to be
> adjusted as following, otherwise SHA defined by SRCREV will be overriden
> by rev/tag defined by SRC_URI.
>   a) a source revision if SHA is specified by SRCREV
>   b) a source revision if revision is specified in SRC_URI
>   c) latest revision if SRCREV=3D"AUTOINC"
>   d) None if not specified
>=20
> Zhenhua Luo (2):
>   bitbake: fetch2/git: Add sanity check for SHA validity of tag
>   bitbake: fetch2: adjust the priority of revision definition
>=20
>  lib/bb/fetch2/__init__.py | 19 ++++++++++---------
>  lib/bb/fetch2/git.py      | 29 +++++++++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 11 deletions(-)
>=20
> --
> 1.8.4.2
>=20


