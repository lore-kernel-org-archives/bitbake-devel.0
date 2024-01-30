Return-Path: <joe.slater@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEC9C46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 21:59:14 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.55.1706651946240172372
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jan 2024 13:59:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Pl5cKO6J;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=27595d2623=joe.slater@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U4m7RX032261
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 13:59:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=GDlZcRT+AB6y9NK9lAm5cZSNdxSyKOM1AFgis8DG5ws=; b=
	Pl5cKO6JwCtlt2Nsw4pYGqgCNWhAWkJ3ePeoKf9SSzGO40PwPVB2WP8a/N33hp+S
	tRa1es24sZ+NZ9hKmdPnCU/vQG5zfO8aFkMYO62gOk+HVTd9HF8iO2tyOMZtG8LG
	bne6ZkebZ/H7GNsn3WXWtPpJNNbj2LaJp1O+vrdOictEOTdf7E7qeI656jJGFLOV
	qIz4OYDxGeytZV4mWPwWVd32Q/W+Hms9CVw6z4YX/ORp2RXeyKALY/RHwx56csyR
	et01YK87aMjmQqt4sMIQi73B+ijVSKpnrted2PLmFmMOUwoHkIRJPm6Wr8u3xyKA
	TSqsYbIz+q7f34Mc5kS2Pg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vw27ku1bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 13:59:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLlmpn9jd37aUDj18bBC1NsUnhOZeHC8DQiTxMub4mQTYWZlwy5V8aC225LDe3FyXShGhBVIZ/JUjYrlgnDqGgQxmXwbOoywL/YjoLtOgQOa+DVjcs/VeOQMTlv4kEA0WKoo+r4H6MGllTG5PoQ5tRuGPnXOkF5qKP8TsDx49RJCkkeUWnmCslbwokqW53gi2fOos4Wb9IYhcNwX3x9PY11bcMpL5xQX+67oZeYEedCjac+OJL1RdP2E5uiAzHlqQuA+WbqH6FvP+45+L51NqYyCF9cX784FYifPRGQ/NCNae0mAuDrX0RrzMm2ktP3bT3creR22Oht+R7bdorzq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDlZcRT+AB6y9NK9lAm5cZSNdxSyKOM1AFgis8DG5ws=;
 b=JObjPoPdFJWhjZqtNzcsMz9skNQ51MewsEn0el45CzwpWfH0SOld1kVXf9EkslphzEl8cmBmpchyFy+uCXHGbJDJ0zbiXw6SwnnwpUGAx1erVSB6MRBpiR8xz7U5jR565Fx60Gr6zKVrnNvQI3dU2/g65zakEdZoynlRv5pTmF6DTNSdCZZ7LhtuDfoDWARqncMRjtSDa1ckh3gqwm6TXiFilk3lie9SsVIHUIXBq7f9HSTizUL4ow3oOpm+Y0Q7B7ap/SBZ7HtLzpc8miUfxHqTcShgFr4RUtVU1thxCQfWVcJ0VTjzNVa/3JJibeVulqNPLKkLgqTLl+CxfZ1YZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB3992.namprd11.prod.outlook.com (2603:10b6:a03:188::10)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 21:58:58 +0000
Received: from BY5PR11MB3992.namprd11.prod.outlook.com
 ([fe80::36e7:fda7:1bfb:b7cf]) by BY5PR11MB3992.namprd11.prod.outlook.com
 ([fe80::36e7:fda7:1bfb:b7cf%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 21:58:58 +0000
From: "Slater, Joseph" <joe.slater@windriver.com>
To: "Slater, Joseph" <joe.slater@windriver.com>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "MacLeod, Randy" <Randy.MacLeod@windriver.com>
Subject: RE: [bitbake-devel] [bitbake][PATCH 1/1] utils.py: add
 var_in_numeric_range()
Thread-Topic: [bitbake-devel] [bitbake][PATCH 1/1] utils.py: add
 var_in_numeric_range()
Thread-Index: AQHaU8c9+qC5FqgYBUWJV+Z37H8FR7Dy52qw
Date: Tue, 30 Jan 2024 21:58:58 +0000
Message-ID: 
 <BY5PR11MB3992D11AC5B903288D54F1F3887D2@BY5PR11MB3992.namprd11.prod.outlook.com>
References: <17AF3EC76BAFDAE9.24874@lists.openembedded.org>
In-Reply-To: <17AF3EC76BAFDAE9.24874@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3992:EE_|MN0PR11MB6134:EE_
x-ms-office365-filtering-correlation-id: ab548acc-4871-4672-9243-08dc21dea93a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9Ky1ayxo+2pvohy0vDIehToDiG/U0VfWmC5Prb8s2g+O0bZG0+P6P1vFyDe2/erf5xMDUeYn6el3PGzootQoID6Nf3Wp1ux0dMReKaIU7Pqp4xqhK7hWp8xc6hssGqyP7bHlQV6ouZukU5BOkbRlMAsiMikiREhiz2rhEqtRTt3vFllHET0jkuy8MMY+cWeeQ47UYl/E2p9oqg25LHjP+LCQ+FPx6eMwkCGWa/G13woaXD4qc8M4UwI/D9jwX8zeGZ5pUahPXl6kmJDVOrDsg11EPWYmRhC9Verobp8b8n4yAl3NGVab74wA0l90ylPvhiieN0q4Idlp4ZedQuhDVYd1ElDSrcT49sXzo8WJOiCB15SeUE9fMUPX1wzViYlL/BgxLDV/LYjKYFOMjtCvdQbwykJNdM2U2on7f5Wt/4MFQ46OOlO4xs1slGXE78oYMbfstv0lAkjMuAWvVhIA5q2DI6NYPE49MxgsGLdvXblemNW5kyD2YZYBzvnyWJPfahwRgclIsm75N95jyr6ipF50aQeK2loErge4bbCjgoe7FSHLXT0tiBVI/Pd+LXu6aHIE10YdLaZ0U54RB6xoMrUg9E6pYpMDF4PGx8APL/QuzF2J9+T4TcqG+Y0neJHO
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3992.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39850400004)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(33656002)(9686003)(71200400001)(7696005)(478600001)(6506007)(8936002)(107886003)(26005)(4326008)(76116006)(2906002)(83380400001)(64756008)(5660300002)(55016003)(66476007)(66446008)(66946007)(66556008)(52536014)(8676002)(316002)(122000001)(53546011)(38100700002)(110136005)(86362001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4QJDD+hY3ml1zU/aQjlkScVvw5/qJZH2TqrfizQ/DYzbgosc0Z1HnSWI8wPY?=
 =?us-ascii?Q?2eNWqQt1A51Dr/v7KAVIn0lldQITRXkP7F5D81cSFo+YzkQqOE7dQY+Qu65D?=
 =?us-ascii?Q?Jg5UeKXBGp5VvuXR1iyRRcTBdyo4pPllAwS2NVhj8KTxJm9M4ZmsCdXr3tTu?=
 =?us-ascii?Q?vhKB2OMZp5Z93d1b3imH17Wb3jYWGZX3iS/vDzMaqlJfIZwbtajINHeQuhNY?=
 =?us-ascii?Q?1GhH4ZLuucTRKSS/TLndUXhhX61Qhw//LjsQ04XTmNsbTVSS0fdbj4vzIZzh?=
 =?us-ascii?Q?lrrMtrDkYLErwrPJ+bwW/JvUD47PA/L+UALovdSTnkiQ+h9viivGgN3ymjJB?=
 =?us-ascii?Q?ny6jjc0+jC/uSfwFxApm4XEi4RHHt+ZbiXv3VCMBiI2KFyh7XJCvIWUXmskA?=
 =?us-ascii?Q?CUMDDFQH6JHScg0Qjn/lnoPiNpl01CrLTvhuNhUF5nUecq68S3vJksXxDORj?=
 =?us-ascii?Q?Bj0k7vgqNDf1kqBDwcug8DULMJOqfH6QuB3G357MK96yd3P5vu4HZRQk1xA/?=
 =?us-ascii?Q?qPatU3JaSm9UfJ8ELaNBnV78b+n+GZi0LIEOQiluJOI7XvfRDNXAxLojZt5c?=
 =?us-ascii?Q?ltc6/An0nE+UvPFMS9OWCAn7fW4atA5Cy7IIdTwu6sAwl8qmSRAOdQJHg2cU?=
 =?us-ascii?Q?i0RRtTUvFgXcWmw2EgXwYbstl6ntMhmUR/9g62YiJaZhWixpHIGaypP6QS2P?=
 =?us-ascii?Q?wPV9BpcUMJa1sCAVXfCWHAumYdRnaLh0RmaY1T0gaHEJ2Ec5RBkzfjJpZM7k?=
 =?us-ascii?Q?IsaTCK2EI0Jqw2DFIlod9qFNUsi6317Mk3tY30VaVMiJmeaROVWF2ABjGUMN?=
 =?us-ascii?Q?QYhf0aW3YvWDc/81DSE8lL60k5VdFKGeToi8vTikCYhfC02xiB1wo6MuwefJ?=
 =?us-ascii?Q?5yJFjKHef+sLUeZ+cDnZZpnFSuk6w7CwCrDkXMTAtrvsuHTwVQb+qqbrvfg3?=
 =?us-ascii?Q?4S38pLzB2/GTdrdLmIGLW9SfpXIF1EEjlsFXdSsBGcnDXyan39g2rGE66Uf8?=
 =?us-ascii?Q?c/evrfLgDumaK28L0epLbYqEIK/DI/9BXNOnqtEKKSb+F7sqv57XbC7c8E4o?=
 =?us-ascii?Q?RedxRq25OEBl0JKhd+83wxHrW9B0KFgiJ4iN7XHSlQGvq57koVb6+7gfbekd?=
 =?us-ascii?Q?fIez0xF6vze6RgTmafLBVKLS+BgQBFBP/MyQac/NiZmld9rXIEmosP7SrdCA?=
 =?us-ascii?Q?9JQB2CJXrS6sjdtCwtgg1uZh4sxRFC9K7DCl+L7xfLhATSbv2n3ar7++lVD4?=
 =?us-ascii?Q?l4l2bcYPtvkYVZ63A3nZBP/9oR0oXNIZOZRwtqqV4WFzl+senfCbnxBuevey?=
 =?us-ascii?Q?XVdYH+F3ktn20OBdIO+DNkTAOYyj4DsKykunwojzWQw9FFEeMk7sqOB72aSu?=
 =?us-ascii?Q?0M4lLzb+aklX+PWPU+0BwdjxDeq+c2ClFm5HRsYlT5kKXIa/Nz/y17YdugUX?=
 =?us-ascii?Q?z1NVEyUNFt0jxkOU7/QbgGaPHCVJXuqWZNFAELXjGs8oauD7IzcdvznEJ6ix?=
 =?us-ascii?Q?yja8zRpvOjJr7jXjRd4ZHzEwP+LaNHtievI7A4PAJHibGL9C6oKmrP9GX9jV?=
 =?us-ascii?Q?mM+lcL53LI0OMGCdUj4B9QfmL9D/d99mUnoY0KBJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3992.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab548acc-4871-4672-9243-08dc21dea93a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 21:58:58.4570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLuC8PHzqeydCDd6gnxbgCWVNqvlSarsKCQwGZI6OLtGrcBVGgr6QJ0/ajX/6K/vnU49CS0NZvMeqIsLWlu8lOog8UVSpeLRhHIBjOqWJWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-Proofpoint-GUID: gsWta5dx-utlWHIPWQREpm6xHfrtWjFR
X-Proofpoint-ORIG-GUID: gsWta5dx-utlWHIPWQREpm6xHfrtWjFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_12,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300164
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 21:59:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15810

Oops, needs a little editing.

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Joe Slater via
> lists.openembedded.org
> Sent: Tuesday, January 30, 2024 1:57 PM
> To: bitbake-devel@lists.openembedded.org
> Cc: Slater, Joseph <joe.slater@windriver.com>; MacLeod, Randy
> <Randy.MacLeod@windriver.com>
> Subject: [bitbake-devel] [bitbake][PATCH 1/1] utils.py: add
> var_in_numeric_range()
>=20
> From: Joe Slater <joe.slater@windriver.com>
>=20
> Add a function returning a value based on whether a bitbake variable is i=
n a
> numeric range.
>=20
> Issue: LINUXEXEC-29701
>=20
> (LOCAL REV: NOT UPSTREAM) - sent to bitbake/master
>=20
> Signed-off-by: Joe Slater <joe.slater@windriver.com>
> ---
>  lib/bb/utils.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py index 3f7f82d17..04b406ab1=
 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1780,6 +1780,17 @@ def is_local_uid(uid=3D''):
>                  return True
>      return False
>=20
> +def var_in_numeric_range(d, var, first=3D1, last=3D0, truevalue=3D"", fa=
lsevalue=3D""):
> +    """
> +    Return a value depending on whether a bitbake variable is in a numer=
ic
> +    range.  Conventionally, 0 as the end of the range matches all values=
.
> +    """
> +    try:
> +        v =3D int(d.getVar(var))
> +    except:
> +        return falsevalue
> +    return truevalue if v >=3D first and (v <=3D last or last =3D=3D 0) =
else
> +falsevalue
> +
>  def mkstemp(suffix=3DNone, prefix=3DNone, dir=3DNone, text=3DFalse):
>      """
>      Generates a unique filename, independent of time.
> --
> 2.25.1


