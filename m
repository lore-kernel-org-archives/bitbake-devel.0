Return-Path: <chris.laplante@agilent.com>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
	(mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	by mail.openembedded.org (Postfix) with ESMTP id E48C37F2AD
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 19 Jan 2020 02:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=jaNy5x+kzZ2k4l+RZHkk6sT5EIu++LCXb8W+yvbOeJ8E7qksJLfjrX/CAmeuOtVR9xxAuJ0ACzjkJwcHPCE810FVu4AsZxpHy0M8lQwIyCMVRm2y2VvkJt92jv3Dya4YENFpYYPker+kTAEhuPsb7o7zTIFsfDta8eXiSodVxNhgAjFhZBSsijWhzkIkF2PXYoQoE1sscY5QBZu/IvDQE5cWSUSXduLF8WNQt57Gg46dMRqRqqzypIJut/VUVCFLxpom3ZKfroI5HMnJkJQ4kyGqsjL7SV7HgLE9QL0h3oooUlVmZV3gjJkEFdxObZx06ZEutUOc7hxOppq//FizNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ePwVxzhMaEG8HPSO2f8cPEolhjgVcrT6cguhWYPL4Sg=;
	b=Wde04vyGt9DEthLUrJ05zzYzXyo0nZ9mQiwrsyhFYIV613BkxVWcnSdnJ19xg5g1ZxxzLXsxzydDB/nmJ7ZBC6cyiUiXMdZcbTF5JZDM+g3VcLQFfNL3LU53PIWAN6BV3KaAUDfxlAPxs3BYB2NbpdL+TD6w2JldRoe15X5RUZlyRppjTm4t7B3MqXhlo3rNK9OBeQkSFBJeSw+jHa2KxUJazguHve20COCMcckBrWEShmen2dSUauTOsAxvc0/yrU3xNTx7EF1j1cYHh86y079Vl+K7lu9beDlPYYT9PM+Hfr0QtoYkuzoMEvUibcnvc+mG2ukCI3UbcwPj3G829A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ePwVxzhMaEG8HPSO2f8cPEolhjgVcrT6cguhWYPL4Sg=;
	b=ioLB7dWFme52xJyJD7RS9banb7mlN1W+qhArf33NAQIa/vx0xzvsgePE3CgoRr3BXPIsDd06Xb0oqxhH2jLwlCwAmBrxlFpjCHX8E+yyqKgakkCwU+3I8fL0n9ZPYGgNdeBW09K36ATB47AGi68MCm1gfdCrFHRkFiWBk6oCWUE=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1191.namprd12.prod.outlook.com (10.168.170.142) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2644.20; Sun, 19 Jan 2020 02:14:38 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::3c16:3c42:ee9f:b486]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::3c16:3c42:ee9f:b486%9]) with mapi id 15.20.2644.023;
	Sun, 19 Jan 2020 02:14:38 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] build.py: record time spent executing each function
Thread-Index: AQHVzk/UviyzOepWnki5zcAR3u5NfKfxP3sA
Date: Sun, 19 Jan 2020 02:14:38 +0000
Message-ID: <CY4PR12MB1653C176011A53D5E6A523568B330@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <20200118223705.17230-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20200118223705.17230-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd948165-9d23-4c82-28a6-08d79c8555ff
x-ms-traffictypediagnostic: CY4PR12MB1191:
x-microsoft-antispam-prvs: <CY4PR12MB11914B9166A008C7CD0E8FD18B330@CY4PR12MB1191.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0287BBA78D
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(366004)(29502001)(199004)(189003)(8936002)(478600001)(55016002)(6506007)(81166006)(81156014)(52536014)(110136005)(26005)(186003)(8676002)(9686003)(4326008)(5660300002)(2906002)(316002)(33656002)(66556008)(66476007)(66946007)(64756008)(71200400001)(76116006)(7696005)(86362001)(66446008);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1191;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ewwIPBIZVtBadTBzJ3QowXKQT8AD73ph2+LrrSzjhNAsliWdF9i9aOJh3gM6VZgBprcnddrw9pugq0hLUwRRO/2oPtDH9nKd28gM3kVQmskPA641Vl43fI8M4YLPsIBhJUKSwB6E36f6E470Z+YmAhNifLqxINp+dsPuoFSg5a/hDbhwLgV/svKLhZbicGib6I9jWFiXCS48NIuKBdk+7Lcqdw1ggZCctmWZRSBUyyfjEVPzi24Et3U4QI+tmFUjZhW5+7dbN9gRGhkNc4dHqplBRhfMkJvNP27qO+1AZIdcP8tn0FgBKcnseVc3JiZbhAR38QUJdfBmMZLwBCsdO0pZJ9fG84l7RgeX0XgjB9jPwNyShPN9lJYvDWwY3jA5IVf1RCbwelT3x5GmhjuLrOjTfahFa0gAPNEkVe/jN9B/hLrbDMwSWutQNEomZt7ji3XmnF21vmwNnwDVfY8qv6NneOX6tFkVtunbyiKj20vgLrWcMtHeTH18v9GvRWEr
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd948165-9d23-4c82-28a6-08d79c8555ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2020 02:14:38.2853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAXIw6vVYCH979z7T7JqhMPAHAJvO329YU30XV4UkRSjk+/wDs6GpYIowZf/UiGUdYJGopT/aHiC/Gds3rjU8+0wqkYotjl5uM7ls/t/xoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1191
Subject: Re: [PATCH] build.py: record time spent executing each function
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
X-List-Received-Date: Sun, 19 Jan 2020 02:14:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> In order to have a quick way to see if optimizing some task function
> actually has an effect, add a single line to the log file for each
> function executed listing the wallclock, system and user time
> spent. That can also help figure out which parts of a recipe is taking
> the longest and hence find places that might be worth looking at.
>=20
> bitbake already has the --profile/-P option, but that produces an
> enourmous amount of output, and AFAICT only concerns python code, so
> won't help finding suboptimal shell functions.
>=20
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  lib/bb/build.py | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 3d9cc10c..945efeae 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -19,6 +19,7 @@ import shlex
>  import glob
>  import time
>  import stat
> +import resource
>  import bb
>  import bb.msg
>  import bb.process
> @@ -172,6 +173,14 @@ class StdoutNoopContextManager:
>      def name(self):
>          return sys.stdout.name
>=20
> +def _get_times():
> +    wall =3D time.monotonic()
> +    self =3D resource.getrusage(resource.RUSAGE_SELF)
> +    children =3D resource.getrusage(resource.RUSAGE_CHILDREN)
> +    user =3D self.ru_utime + children.ru_utime
> +    sys =3D  self.ru_stime + children.ru_stime
> +
> +    return (wall, user, sys)

Not sure why you sent this to me, to be honest. But while I'm here... I don=
't think using variable names like "self" and "sys" is a good idea in Pytho=
n. May lead to confusion.

Chris

