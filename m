Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F4DC282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 12:25:14 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.86])
 by mx.groups.io with SMTP id smtpd.web11.10442.1742300711309699816
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 05:25:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pNSZD5w8;
 spf=pass (domain: siemens.com, ip: 40.107.21.86, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1jVwDdHqNJAEqdu3Dm4/WD3kgDVmIAyliQE/9GlJWWII/Fav3vFAw7oZu6UWMlCK0X5Rtvk/Q7THveb8E7/8db8RGtCqTnWYTYqlh71C85hhS9I5dpK+yde+OnY60d8tBteSXc0JAjRytQpbTUuENpXDElfo9grCV/VGD4bESdOEr6lf4pwt/MqZP2kd2pJfXeQ84Lsn/AQubBPBtDONz1mG7AJ1ORQ+kxRze1q+P5DlO26HhDjCu03UcXvUuw+4L7z4SMf7QDpBN5Zaxgt8PStITT6sd4gMnlOb9NUebzrkqVJ+vEMnnNPMNYO8on6NaRMQjSaac8cRAQgF4VC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEwHmew6e6iVkf8xtsrWRKcKD5a3EhB9W5mmUwa06VE=;
 b=BKcp1dd+lKNh3+wuC4KItz06p/IDkMwOKQSM99Pq0vb1sqBYEpKyeDtdOrsWNHGpGrZ8OWo54ojQZkxeCGs2Txc0wFIh3z0pFzDRFCt2R1Xu/YvudFMxIJ2/Qtvo6V5xkAWcg8I2nDSZP2PaT0hyxk5h5ddlRvnqdxF6KEHlGVDbd1U4W5Xyd+39B51+23+BaY9IwXsKOir777n65AEpbAzmoqoC+uDprdPQkaCdNlgLfB7jKO3cbMP41zU+miH7rHuKKuN2sj/OByYdW5KJ49/kCQXWVzxzxyEUvPARoZ/YNkN3wNw00r072kK/C+6L3uwJtz8EiEDuBjMDfPTpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEwHmew6e6iVkf8xtsrWRKcKD5a3EhB9W5mmUwa06VE=;
 b=pNSZD5w8sB4RoveHuBCGWQ7Oizo44e0KqtS9CWVNHvPm+lAt9JcD83Q2Li5JaARdm4lSAHL/ZdpFoZ7hieaZDiayOdXsT/0+kR1jjxtgp2VVh4fdOpZC6DuJp8oIK6FpLkBqCGR+vTm5bJFCm4IZ8w4P+Yqb9GcdH9CWFVQvmAXrf2OJsLYbSZUhpKWTEOFwVavHWUFg5SfDH97hVYc3EItVmMyJR9Qd5PmBlun9ONuBdRG6ZA/Bi0vxXGRXJTft6GWMaRkehKD8unrSIgNpYIz6ZD8HZeaah6EnLdeJ0QYzn5baa6mGoJQMCUzkgMQMmydRZe9z9z8VSrpSO2H7eA==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by DU4PR10MB9144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:25:08 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 12:25:07 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] fetch/git: Ensure tags work with shallow
 clones
Thread-Topic: [bitbake-devel] [PATCH] fetch/git: Ensure tags work with shallow
 clones
Thread-Index: AQHbl/995y2CzE1TSUSlPvcvSPOlprN4zzZQgAACHtA=
Date: Tue, 18 Mar 2025 12:25:07 +0000
Message-ID: 
 <AS1PR10MB5697E2B23E7EE908D214124DFDDE2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20250318121540.4123354-1-richard.purdie@linuxfoundation.org>
 <AS1PR10MB5697E7F55CD2B6281ECDE6EEFDDE2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AS1PR10MB5697E7F55CD2B6281ECDE6EEFDDE2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=4aeb9c57-ebfc-492e-80aa-f9fa70c73bd1;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-18T12:16:40Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|DU4PR10MB9144:EE_
x-ms-office365-filtering-correlation-id: ea07f4fc-d4d6-4644-9c12-08dd6617eb16
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?t/wFpFCRqeAV8Ij8Ru8gOjh2WoCQWL4Ww09XMO2Hm2QypRX/uzmEWn9446J2?=
 =?us-ascii?Q?cFK++CLF6q2uOCUz+x2usOglH1WW2lBWPZnPtIQsdoMMTBKjsnXZhZy1VP/3?=
 =?us-ascii?Q?zzXkQkmd0S4CLCbNTmJGfp+S0bmcxNQDLg70lFUCm0j9T01ZttkMKU25shDn?=
 =?us-ascii?Q?ksp917qm/O3gDBM/W/N68jMtEaNFVQMnYrDL0Xvc6u0cIs/cwL/Qpb5y0063?=
 =?us-ascii?Q?WNKi+1GkOdfNril63OUMkK8RKxfQ0lAmvHAIaGvBTWxBLB8HcBz5cj906jv1?=
 =?us-ascii?Q?mj0ALKH7G/BjDEPsiXnVcQ6Tr0VRq7pv+sKoaZ2EHmo0dKlll2kLw1G3BGmM?=
 =?us-ascii?Q?k6L030nLXCLy50PCm22Xa3fD6EbNKWBL2HRq7CFz0Znh9YSVdOWBUNxoFfuW?=
 =?us-ascii?Q?Ifv2PEtvUgywjnw1uKP+9Yd1WkdFxUd+aha2eS/4B+QyZaR79LDkDOChhXRX?=
 =?us-ascii?Q?Qm3F3/H4ylzHa6q2ZpN9ELczNNuqX4LjzXbTyXyUt3WawklG2FG5lWuFxUTO?=
 =?us-ascii?Q?pjv6eiL7rVSdUmDn6u5Mcm3/SWF2naxL3DsfDFtaqenQDtr6kaXPy2Yutsa0?=
 =?us-ascii?Q?m8uLJ83LJS52q6/WwGP94lqIftDjQcxoExGLmXxhUf+XhFvD1+2cW1PDNNie?=
 =?us-ascii?Q?Z3DKKalXE+C0DKe/NUIR6sHArbZSYWyXjsC1vxN3I8HydOP80ZinEGSZ68kp?=
 =?us-ascii?Q?Si599yTrU3GWf0NB6UlqZrk+UXgAu95hJ+gixzKNrbvBp8O+9aIv9tm5N+Gi?=
 =?us-ascii?Q?FP6h13YFXQYfA3RUl8ZSMkLjD870db540FgXQFRz96x5lHvjIBVI/9TxCinp?=
 =?us-ascii?Q?iSb1/aaxbA4/ag2TpJ9EtsRnFpEk9j/VbJbg4CxTpSD8EHkLRQ9dAkzcr11l?=
 =?us-ascii?Q?5G7D+lgXR38duyYRkxRy+RV0b6n/K2/1OIbFbEE/szGdKcFNeiRJoH26+4y6?=
 =?us-ascii?Q?jwaRHp/ezHO0MKVfV5bbnUq6aWv2Trz15124jB51MI6ccsh5oa+flNc23kbE?=
 =?us-ascii?Q?+lfM1+vhqmiWVaEPpeK01sW83BcklAZ467IDgv/04lQwiWnTYVo4NcxSxpyv?=
 =?us-ascii?Q?s5ahl1gaVcBbESnTzLpqm3Mln97AnCFKMHyoXIc+R5DU304Wp1IviyRPb6kM?=
 =?us-ascii?Q?ZxecuQr0jQNiDWHi4VtFixOHSFwsCYDHEql38hG4fYAtpHRdtB9uakyDTXoS?=
 =?us-ascii?Q?RgpQKsKAD/WZDkI2YqJpqdeZis58UQZdLTlu8Dqw02qx7Cze+bMCAwD2rWNn?=
 =?us-ascii?Q?FBs2GOObcjgocFPj3vx/SAX4o9IGyitp4cMCW+Oc0TE6xOnaTwrLcP5bbkSA?=
 =?us-ascii?Q?DR0KTpHSyVXbaJWnvx0nX/BEWTAxHdTZ+dgmoNkCrK+W6zv3cW5YpQQHsbst?=
 =?us-ascii?Q?wlAGIp4TqaWNr8L74aEARBvNPMud31jQNb34TYb6iqzBvywPcj1knxAlIY0q?=
 =?us-ascii?Q?ZFRZGvx+YRoTSBpcCFdPWDGKpNIEeoHJ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?czbQ9Wx9Th6cpqyA9kFOeLSAI7KsYaSKDKVK9cGF9+qiuLpSPmVfTo2PlPG4?=
 =?us-ascii?Q?yJWKhLqBfUmUJXkwindyCjOGt0coN6PSsnychdMrNPZMNCwoL7PzIH+ZGty4?=
 =?us-ascii?Q?ASl0e5iRVJWsSgvNoOVM0enxBeQVlxp27zZOrL9fEhTUxU9/tAsL5qpi3EsL?=
 =?us-ascii?Q?zjDHtDd7EVOxRpuhjns+MOxrecSgNSl90EpAO3Dd8SMeVTNuTo5dlBvPNQdl?=
 =?us-ascii?Q?dmMcPGkio5WD6BweiZql7wbHBrVRge9y13HdiQmkFpJiJy1lv2GkD58ei0Zg?=
 =?us-ascii?Q?cP5hRhAYnFv0pz1Bi3YltfMYWyazewquaFz3lmHvabC13YLBzU9V5K1WVHl/?=
 =?us-ascii?Q?A+Hi1Uiien6pfGDBaEmmYHWedYb+Y4r6sbrEIrfuV5j6hctaTtzt2vYnvBup?=
 =?us-ascii?Q?1o0LfoY96nGZtlLDjwYtdEnENmUC+QNQK6a1V0IoSwhBRltEI6eTSbCIQrlq?=
 =?us-ascii?Q?jQhSw4SgxjHmrTVUnq/cuRqXZhUQdtLHzthApYI6DQFgbU6zX+FGuJ9dAS3K?=
 =?us-ascii?Q?HTmMhEEA35ltqFaEQVLSjQCRQwSNTCjKYCHzzYbY28KpaEED0Lcu+XVWw44s?=
 =?us-ascii?Q?hhLDrlwm24DfHIgD4n9fvj8cJCABYfBbSXu/XgTgTg9G5Gz5No2Lpasa74mp?=
 =?us-ascii?Q?QCj112u3PGav58+xFXIzs8uMAOIEGqGe+se7OU4rsBBJ6rgvXcSNyvzkq3wM?=
 =?us-ascii?Q?SxJQc3jalJKgU89dj3pxWIjvEHKSfvdgBJCp7E7q3FpxpnY6atse6sfUGXd1?=
 =?us-ascii?Q?+jr1wZ7gRpRsVNiTbphPrLoBUQph/iIbc0Erq6zrK4XdmhOMioXgAO44p+gW?=
 =?us-ascii?Q?EFtVnCQVzlS4lxOhIlyDpQyp3raL878+9eUxM3pZ7hVDz3EpXoLAfFdNzb8G?=
 =?us-ascii?Q?XDIs9uTMq1NCNjsBPz3eEo/JIQdz6YMD0VH52x2pskY818aaxzsmdFXwjHMt?=
 =?us-ascii?Q?7j6IJH6j2fpR1yIHzP/iHJRgAjSFaKmOgbcJ3g8WGIKqE3Cv5MzeEUkvu58q?=
 =?us-ascii?Q?X4lk9Vf/8r3LVBj5VqgFpahy6ogmHO7XEgziGjsGaqMLW7rskQ2ZUk5PrgyW?=
 =?us-ascii?Q?Mwp7DEoAep2KeJYgevtEQv2Q8tQNLT6d86L/IdauvVedD9MlXmLgSNETrlla?=
 =?us-ascii?Q?jDh04rBRUFmNFnZwHoNlT4fByo7H0d7tHHNBBXbrNDKHlNI/+1BfHpriRitI?=
 =?us-ascii?Q?+XfXgyBIqp0ArpCzaVZTeCSOsPASJ0DcTtDSF6SJO+7gsqLx4I5oXopywr5I?=
 =?us-ascii?Q?l59peP64OrI/KD9p8K4l2ZslcifTOfg85m3ZEjfmAuiNluY1hbukEL0jQ2Ii?=
 =?us-ascii?Q?LrnXG3mKRJP0iABoKal9Ws58nDffHFFbnJwWELekV8PSmsCUDhSW3kLmi3Cw?=
 =?us-ascii?Q?JbY11tUxxgYLP34QGTilJHJrZYobnvukp8AOFpk6yVqTmqKlPsNGI6m6Ci2e?=
 =?us-ascii?Q?dSN8wSN9cEZDFn9l1zsDffEyHFyJ0VKfJML//A3/DKF7o14WS7HLq5eNqWLj?=
 =?us-ascii?Q?o94LheTL0QgPj+BqVgxY3QIybs26ebdOJaSM+33Cf0jBaYYrIZUNGEnfsR6b?=
 =?us-ascii?Q?ZdR6/UAQEwzQ4M9neOO1PgTkvacC+GV9R3KzFOzU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ea07f4fc-d4d6-4644-9c12-08dd6617eb16
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 12:25:07.0637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qp6fNYxkPe17PzvEqZWF7zskDhChJtnHlQNT7fHG4hE5fr9FiFpXfQVqkG85Pw9WPIhG4dDnBrPVVc1j0LkUuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9144
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 12:25:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17458

Thinking about it again, I think it's not necessary to change filename.
Tags will anyway be needed only on upgrades, so new tarball will be generat=
ed.

Sorry for unnecessary spam.

Peter

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1)
> Sent: Tuesday, March 18, 2025 13:23
> To: richard.purdie@linuxfoundation.org; bitbake-devel@lists.openembedded.=
org
> Subject: RE: [bitbake-devel] [PATCH] fetch/git: Ensure tags work with sha=
llow
> clones
>=20
> Hello Richard,
>=20
> Thanks for this patch,
> Could we also add the tag to git shallow tarball filename?
> Or make some other filename change?
>=20
> I don't want to re-write all existing shallow tarballs in our mirror, whi=
ch would be
> now failing to verify the tag.
>=20
> Thanks,
>   Peter
>=20
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <bitbake-
> > devel@lists.openembedded.org> On Behalf Of Richard Purdie via
> > lists.openembedded.org
> > Sent: Tuesday, March 18, 2025 13:16
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH] fetch/git: Ensure tags work with shall=
ow clones
> >
> > If we want to validate a tag when using shallow clones, we need to ensu=
re
> > the tag is imported to the clone. Adding to extra_refs allows this to h=
appen
> > ensuring tag validation in shallow clones works.
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/fetch2/git.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index 53fdc4c3df..7fda9d2753 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -674,6 +674,8 @@ class Git(FetchMethod):
> >          for line in all_refs_remote:
> >              all_refs.append(line.split()[-1])
> >          extra_refs =3D []
> > +        if 'tag' in ud.parm:
> > +            extra_refs.append(ud.parm['tag'])
> >          for r in ud.shallow_extra_refs:
> >              if not ud.bareclone:
> >                  r =3D r.replace('refs/heads/', 'refs/remotes/origin/')

