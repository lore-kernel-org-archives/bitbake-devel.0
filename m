Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12ADC02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 21:17:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.87])
 by mx.groups.io with SMTP id smtpd.web10.32110.1739567820614123990
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Feb 2025 13:17:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Dt1LdA3n;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.87, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dim5BfTJSg53kOqOWa9Osf473Lu49/XY5tPBTHonzyWkOYqXQhK9JLsUMEI/cOcZ9VEULJxzLAQs0POuF/s5wj/iz9HCH3cR2XN1gNXku3hZp3VLFMmUxaoLe+qo/2eSOCaR0HgOwRI/4pNwS3z6Uwo6dCA+crjRa0sa/PqxWeFwy5om/YNXZwPdKhCJPWbysB1HqbjKQRuyt5v6X0gGh4uw/EjK+wW9iz5YKsy9kS312/uTPGSSOQB+it46z4oLfIdZu3d5XUrhdCmXEhm8SAAEIIYkgQKi21+0qJ5OPHoD0xtJZlELWM9U3MOw1grqwrcZtOb57ofqjLBNR+i8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd22tORXbVAqa6MKYd7XZeEi/WeLoT2tsRoQDjEN4RA=;
 b=f7TMMLIbAkjAE86C2ez28DA9M2ge/2WqmO1jZ3khwpZ9ZI6OcWqm4sAUGBxwGFB222tRo5j475E8pcvqaccC8YLePbXTJieEwKURGSHKiAGA0piwQzfJidcsN0mvcW4c13unuqU95JjzNj1U7jW/AlOwocQ1xDICo+FZGzkc5JKjobqYiltQ6aELlTLigY72m5trt4+W2wz8VNBgHIjTqI56erDAwqmSjEirrVyPV9ijGWUJ1CUGfz5oyEU6rpV0LHBlcJjINKYG02J/DBPP578w4J2BZPtxngWZpsO2naHi3j9rGXI/ykPywgz0KNhRfQwEMgsD+3MTqT4A9uQwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd22tORXbVAqa6MKYd7XZeEi/WeLoT2tsRoQDjEN4RA=;
 b=Dt1LdA3nKCSAhRomhDOL0GzBaZrPLLqrdigB0F+LTTxJDN26NWIEXNPca4n7QajzItDzg0/X6ZYc0u2F/k2WOiuFKh5uRHJ3QHqZ7xYE/IL4/1H37RLg7RMjHePz44JLBcImeVoo483/GhD0TG8CkhwZ/c+SUFWSjSrCXpxR4tPi/zHUsT+uuIlye5jYDOEbj9/6Cl8wSz1NkDOVhlHdC1Zngy9LdVfqaqX1fqROXpCBj9REjd6KS7urg1RUJCds46wITfbw6i87C/EY4M1mi8KVGHVvPHyGNqfA519+yu+cqAbGxpCzZYOtfn93C7qQzm4lXZZmWCs5epZ8iSF/Gg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 21:16:57 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 21:16:57 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] bitbake: knotty: report cache validity
 checking progress
Thread-Topic: [bitbake-devel] [PATCH] bitbake: knotty: report cache validity
 checking progress
Thread-Index: AQHbfyVpzpwWcMDw9E+iCnaXglfDErNHTNgg
Date: Fri, 14 Feb 2025 21:16:57 +0000
Message-ID: 
 <DM8PR12MB5430D3A1F43FB3D54D6E51938BFE2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20250214211403.493573-1-chris.laplante@agilent.com>
 <18242F9164EACFBB.12113@lists.openembedded.org>
In-Reply-To: <18242F9164EACFBB.12113@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=70dda1f6-576e-4c5d-a792-bebded8352c1;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-02-14T21:15:26Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|IA1PR12MB7568:EE_
x-ms-office365-filtering-correlation-id: f40165a3-4de8-4b06-144a-08dd4d3ce9d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?oK9/8Cdji7oE5WW8HaXR0N9oYfuvrVfjCPCgyc+PT4e9LxEErQxOv/j5NIx9?=
 =?us-ascii?Q?E8uJAZb+C51LNmGenTN2i4sMx89KKW/pCqZvMRVxwdfiiaF80uqYJV3WsnA0?=
 =?us-ascii?Q?Q6YCRq/nXD9iMjzBiGAuq/8769txuGAnbsWjT6onDSHFgTE5uw8883sxClqt?=
 =?us-ascii?Q?+VnjuK5s31nD5VNDF8xPf04IIeCrwD0OR9KVNxYxj/2NSX95gKvngKXtszfM?=
 =?us-ascii?Q?3smO6He/cWRMoq79MpAVS8ptFis8TK9spiK7p8sRkNNXxyZce04+4ngk4f5I?=
 =?us-ascii?Q?fhR0ao3won2QiznsXgtfBIOn7xTCN10PKIoy5W+xtf9dUzGK+y1pXeAliye+?=
 =?us-ascii?Q?gHQWjXsySmI8rvAGI7ad6QBEBf1ZwLgg0jYEPZN9iv/fNaECU2brrIT1fbGT?=
 =?us-ascii?Q?Q18OBFbTa2aU/a7fsE7784RGvuSKy0C8JufrK1zVvkdEIaC0C2uAJy8b1KG3?=
 =?us-ascii?Q?ji3LhgQWtGQe0ts5ZqQj/UGXL+y9w1we0jfSpQsEDZ6TG9ZqlSWuvhflpxNp?=
 =?us-ascii?Q?MvCcEHRBdJ2OaazGHXwtrGEMEIkc8562egMG/FHY1kzfbzpgLLNmvVLBbNvv?=
 =?us-ascii?Q?ynYFP/eWmZzqmUR3V2Y0vDsv4bdWCZerNYpCg0kX2RO59pF5MTepugvjrZfV?=
 =?us-ascii?Q?/Ne7g1LipRidLFIus8ZuWv+2CP0GZQrRLvIqo/xeqq0YebLQCUsNCn4ATzFr?=
 =?us-ascii?Q?FI1hjtj91UU4sHtKkrZHLG4E1CjofInIVoLaMHWcAf7kB4ypPNqqvdF+vp1/?=
 =?us-ascii?Q?Q0ucoJaaq7v4XyjntrvuKeZAhzjtYgb7q2QRNbH32wW+Kw/X5CvO45gv0UYm?=
 =?us-ascii?Q?0OG9DAxzbt65Yoip9jP0jFqbx9oz9ZJFRjEEFBXaI5L411kwKbzCUihDlXML?=
 =?us-ascii?Q?Xk26t4VnVRsoCn7LszPQj6ImDZmzkTuTUc0oKiI/k5lhjeI5IvocJHb4wFmX?=
 =?us-ascii?Q?9KV1jc1pGVxTa3jIASVE0ZsCzr8LXv4By6rRshYcNhm6uhPS1gy6s8yYA8Os?=
 =?us-ascii?Q?eO1xcIqIKeBo73wWC02tjkFjwy6FextIlMmOhOqr73SY7/EDJoZ9//bZzyBe?=
 =?us-ascii?Q?lZA1/DIgKJINsS/xMrdknOleJs0VA7Iw72LQusfosGbYOrg8jZ6btDuqfXnc?=
 =?us-ascii?Q?LjQYgkHVfSRVO5B2q9Q9uhMjVf/WZQjOUJgAD3hSeND4kQZKJTqiJs9drzK3?=
 =?us-ascii?Q?QFVyzgkcMX9t0mCdBbgMAUmwu4+3nlzpQ5EWIHAR04WNd/46RWq2ycQBW90J?=
 =?us-ascii?Q?pBMiotRH38IVnJRFDBg/twzFSxzZfkHli5/lYxjbtEa7EA+cnI9JotDhFgXn?=
 =?us-ascii?Q?w7VH6tVk8Al6zOdbClv3NFtOJAt+8pMHfdJXnKdmirECXN8/jxPt8pEd01xb?=
 =?us-ascii?Q?aydToYoB+gDqEu/hRaj7z1mP495XIwOGQ822/VLuNtwMqofZQ0YPb88cffAw?=
 =?us-ascii?Q?/kU/+7sbwNXtFfRqtOwqlaQOm3wDWnju?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HYQccTIJUFEbednKFSrSZl0aNf7u6Hj6y49up1u8WRDWjLIYZ+g7cqWiz/vE?=
 =?us-ascii?Q?14ZBLlUWM3v5gkvDuIOqX45b96Fl2rqqv9kIiLp2CJ+EAGL9c4G2p6RY96fw?=
 =?us-ascii?Q?qamP4JrH3BE03nahcd5+Mc733v/taW6yJSHGZVZTGczeCnl9M8T648Dtk7Yn?=
 =?us-ascii?Q?Wavma3yV3IqrlT+aaig5mz4BVuDyUWSzBaqBjcuSysGHe1fc7PbK+dmg//Jn?=
 =?us-ascii?Q?yWW+aBt2lNX7UT2K4Wed3KNYiopNhBzJhc//joY15uzsq/Hpys6t6fhTitqX?=
 =?us-ascii?Q?9cEH1jsHEYdvS6Xs0e8T+IUr7w8mxUsEmkkAqMwtJDPgOdUB3EoUj4b+tVWD?=
 =?us-ascii?Q?BwLOvGZoP3NcKhe0+8GzN5jDy58PxHsUvNxUzQrqu9/Eb6bRW9DDTQ8lpfyg?=
 =?us-ascii?Q?mD6GIAxAwOkbc3fwogZjaqrnKPwlN1VJ60/jLxp7FFLTYRh7b7nRogYxOFlk?=
 =?us-ascii?Q?bkCCSJXDCzaerV5M4cYKKdBYzgg6tTyB4lZuu3SJ9/gXoanNsURaFFV7emkw?=
 =?us-ascii?Q?VnaJGwLf6fyCusz6d54NVh8PTUnmlSMcMz/GWHT040CDKH+oiC4M19uX3+F5?=
 =?us-ascii?Q?zmH3k9nJ29NpXRHFCeJbRfY6v0YlAHLexnGq+beX74gOU7Ibi2uIWlaFrA39?=
 =?us-ascii?Q?1LgkX/jEw/lqPf2l9YWgPQQNvcq5WoH9ZgV/1vbJxA80Oz3ek5zMyfNb7Y+Q?=
 =?us-ascii?Q?toFKducdnWOs0RtfUzH2xORdNt6QGAcaBmhtiGO28lcMWE3Y9J1B/g1ROh+K?=
 =?us-ascii?Q?InKKXWcfn2q/QZ83AYAUhnzcvz1E8wQeEiv1kYcDh4C2fQ/zZ3BCVDKW6oPi?=
 =?us-ascii?Q?C87zMzDTAq56VnshqkR2NAB3sQDp7CgX1rLI2wO72RSar3cVaz+8XLUq3NjM?=
 =?us-ascii?Q?S7/sPYVE/ba7t5ep8jcQIMz9g6khFidRykB3O9oQNe7tRupjFCL/HjgAGCJJ?=
 =?us-ascii?Q?8H3ZHMq/COjonn9A2Jk0BgBn8id1gjG1uZKo9J6X9TSLWSkTW+MgJTqgKdoP?=
 =?us-ascii?Q?0yWYWHGweQ3N0s6CUeJbilHrFaAygf6mCnWAsm4Do4NVJlJnolJRMwUc6rZl?=
 =?us-ascii?Q?KUbgBeP/JhbEcu85w66sNxe35ggM8iTZi85o5QcKXwNzisBPOiQgSpaXO/C7?=
 =?us-ascii?Q?YBOOSlL2pIaDx6bbRYbrfUpK8JcLt7pOJVQvI9CUA3//h3D9E/VwXzGOaN7S?=
 =?us-ascii?Q?FJPWHgBd4847KCcPnuy87vUfeD0TktlWQ0pLyGeyqMsIt/+LcvSMM20b5ghi?=
 =?us-ascii?Q?9cgpguTsVH7457XBfMsMvfR8MCU1wGehLs8pYrLbFOy1kDsMJUV5eMEP8I7T?=
 =?us-ascii?Q?328ynNPn1T9quXxIHGMP7La/m1RIAbNSNas1m3cduFLWbBPjszvVv/ANa8vz?=
 =?us-ascii?Q?cfCU/zeltIE3t8zoX2uyF75MPrZ7ygHzIxToQB19yXVUlSlZ1Uk/ioeyg5fg?=
 =?us-ascii?Q?C44dyB2NTC9c3CaEc2p+Zz/jBPYi+gZCEwG4pHqSDeXNH9hDEmt9d27NdPZu?=
 =?us-ascii?Q?9GYieVuWUDj4o4QyWcm283MD0v23mO/sa91hxy88oDmOOd91nB53O7iZ5BY4?=
 =?us-ascii?Q?QlRKznonGb/Q3A3TIYEuH/8YstmAI6VXsSKGiR69?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40165a3-4de8-4b06-144a-08dd4d3ce9d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 21:16:57.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMXCN6WCFJt+iwIpJRbMETSz1LQ1kw40Fy/69k5A53Bq9K4PJlLP8iQjNIxmY1eql79W12Cx6/IKXxcSHBSeXtouZmlFmTvYioVce/ndKLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Feb 2025 21:17:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17231

> Subject: [bitbake-devel] [PATCH] bitbake: knotty: report cache validity c=
hecking
> progress
>=20
>=20
>=20
> External Sender - Use caution opening files, clicking links, or respondin=
g to
> requests.
>=20
>=20
> From: Chris Laplante <chris.laplante@agilent.com>
>=20
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
>  bitbake/lib/bb/ui/knotty.py | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20

Sorry, accidentally sent this patch twice. Please disregard this one.

Thanks,
Chris

