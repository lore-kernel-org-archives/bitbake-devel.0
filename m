Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB09C61DD9
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 14:59:24 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (SN4PR0501CU005.outbound.protection.outlook.com [40.93.194.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2682.1787929163689962669
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 07:59:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=rci/4iMC;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.194.69, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3fbyaYBVU9MFMzYMSzwM5kVpsYvuSAJfsDiX9MOWaerHfmKnzvSashRroWuGp1iUeYbeAXf2QqsLFuZdrQKYNZixdfd+LiA/pT05Gu2i5ZLZsD+4xGFzskBW7T/96g3rUnQq/hEAvfCO1pjW4QDT8QB6tr3Os8gWk9Om1BLCyONIR/02nC6pli4R+jZvmA4I9Bw2uXJDym7zrQ7zu+yfLp8+abZdQfpD5xQojpN4W0uzArlK+rmclpC9QAbHt2BOUhjlF9tiXSJqLM1otu3jUqEWLAq8PsIBzgj/3lzHH08HP0pYcbsw4mIDjJbvWdM+pKxBMmcvISx2K7390P14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlimArr8fXNtjucQfrAAzHDTXYCVvvrUwY6+PcTx1zg=;
 b=Hqr0tPY/rMWK85Cfpfbq9+D4bQo1BWL+ZJTg+LsHfyq37GXmoBRRKVgMb6rXSTrCsZ1l+CcRk5C9JAWwnOXMNZ/lbUy07P8B6OOKHEEljpnqTiMdjxzoL5hLM2K6L2t8WO891oaMbmY2qbhObnUiYYL3vjMr9cv0sL/0es4oxqFZA8cD6COJdt0HQM44Np3RXAYd76TfqPd1Xik5NHo7B29Y6h6CVNbtySxBsIzD2Jdc4a0lhKZuxSAdi45kEugQTZgdYcDpdbZtvFZMm5I8Aus7CFttkqFoDS6qc4kXBN1PrUqvbupedkmU6K4KldQ4qFC40OmfXRgZHVFQcbbR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlimArr8fXNtjucQfrAAzHDTXYCVvvrUwY6+PcTx1zg=;
 b=rci/4iMC+p1jJvwufIBLg0GWr6Yd1Pfa+w3nfRxqZwp5P6du7AFRkCYyR6IPtaEBmx7XMptZXmDhp2y8RKVDKwT5GBFCgRFFyEV2APZfgTCSq65ErVjL4qJDSA0rghl7frmUXSjyEcsn4DzGlvr/t7l87yLN7QCFjXYZxiqvZx+oTbpTGxxvZjhvNJ7jC9kvIQS9pgXoxmaipaFeorVCHl9zVS1jt5NPGZwyckYymxbx4geu03Rpq0bH6p5r2yEeU3KUlVGj1J2S9QprfTxqheURZYkZnOkroVMw9d1Acl9/aEkIpG1QlSn2KcBvIsZen8S4Gc+0JVsWuFcGagnu9A==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.11; Fri, 28 Aug 2026 14:59:17 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:59:17 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Subject: RE: [bitbake-devel] [docs] [PATCH 1/4] lib: rename fetch2 as fetch;
 invert compat shim to make bb.fetch2 = bb.fetch
Thread-Topic: [bitbake-devel] [docs] [PATCH 1/4] lib: rename fetch2 as fetch;
 invert compat shim to make bb.fetch2 = bb.fetch
Thread-Index: AQHdNjCzG0PhMvCD4UuJ/onN4EB8c7ay9jmAgABnJYCAACt20IAAAjSwgAABhgA=
Date: Fri, 28 Aug 2026 14:59:17 +0000
Message-ID: 
 <DM8PR12MB5430125B330B74A614D61D8A8BAC2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260827142958.547182-1-chris.laplante@agilent.com>
 <DL0CCF115T08.227YUHOXXHLP3@bootlin.com>
 <AS8PR02MB10201CF48B8F8DD1675237AD3EFAC2@AS8PR02MB10201.eurprd02.prod.outlook.com>
 <DM8PR12MB5430838E898C61E85CBF14818BAC2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <DM8PR12MB54305B0839AB4F9311B518AD8BAC2@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB54305B0839AB4F9311B518AD8BAC2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=8530a8f5-d2a2-4334-a00c-ce3a38963b2d;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-28T14:36:26Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DM6PR12MB4251:EE_
x-ms-office365-filtering-correlation-id: af882ce3-aaf7-488b-13ae-08df0514ef12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|38070700021|56012099006|4143699003|5023799004|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 9K+iyAGSpRdsfqk38nC+ufdc8xnv0+WGUG1dNXTxfc1ZLoVIKQrgOkoTQLh3UXNVOqfgrAzf8KIb781T/ftK1+L2NX9x+fRI3zXlXO0pcLaaH2Y0U3VQaO08D9PrMgHVHVeFSaqFJq0mO7trrpXoqWh1lbYz3sMJnLlor+qd6+V/peVg1RbFtRPDsmloVQO/N7AH1LYEpCJ9/Q1JYsCV44blA4e6BYHNsBm7y+oNdoSjvj19DNzBoAjdqZrW5WIifooRj6Ccm/ecAGl1uf1fnoK4MrEMBleP1gXTjGOXH69ONA+K9J6a1qG+X8jtWsqmXVZCnfSZLTF5OmEhZULMn+2cbmaI9jA1ojnhpd2Gkoe2tzsSp1st5TW0+HXKtUtCrFigFHi/V0QcuECOlMq+F2OCtCKEYnsQ/QPfAGR+RET5Gj4jf5rcL8mGJ0SGN4ObAK/5neJ0vRplt3P2UwTlJlN16GNGqitJy0hk2NLbKp5RyM72Jl0GBAe9vUendfRV+ji6JkGJ2ksp+fwrErPfcJr1dYn4/5HxOyYTsG2rbCg3GI4omCr8gUa4Ic1EUEPBli8zYa8frdPvSUQHOLHOnhyCeuxVBVfDq6efZKLqTrA2+GUu1/bSr18KCquSc7+Gcfm1CmfrSvAdICLlzEKv1jnGKKUCYIikLmDmp8feKR1YfwwJ46dhiJuEJRgKUPijOBQ9os9uhGaWSzHNiqc8hx5c3i6o6brw8REiM+NXf7g=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ETaTvjNUKdkknl7rYGvNgBbo9zj8ciYdJ0uEm85nhfN8PueDcN3I6fHBo78X?=
 =?us-ascii?Q?kR3jm8SGT1uMk9FJ+YpxOcs2MJucZ/AjvwwEZI5LM1I0ta1HJBjmo9b/CWaV?=
 =?us-ascii?Q?x5XgPeyAlDLY46qWZ9uWuDN7dFlGYdb5mIDC9zid9siII9b4vWy8blZb83Pj?=
 =?us-ascii?Q?/cf86mKATnfVt51wllMy3shxfkxFYHKW4JuWZFBg7qauuEYBi1niw3Rd22Lv?=
 =?us-ascii?Q?/8xzaJTOwJ3ogoFWZPfEN3rJce9XfLgeil/JjAPrB9E5rAQPMqwWj4e7CAsO?=
 =?us-ascii?Q?OeRruaxUm9pPtSMtziL80578ivW5pVp9FgF/icnXmH38xAz2N9uxd1bI75k+?=
 =?us-ascii?Q?pwkPt/6x5IozEp9Rll1L5Jhe4xU8YZ9G5O2S304Sr7+C/Ap+7UGWyCEAgIkr?=
 =?us-ascii?Q?gx+01bQBOs4asXZoB0+FLdQte0+slnccN/jhOgxifbBIFmyhiiT6YcT0HRxk?=
 =?us-ascii?Q?Wm15OEN9r3K3ruXM366E82OhfWJLUOYtV10crjjALHzl3yYvJXiiD5XRy4XG?=
 =?us-ascii?Q?A6LO/ucx4xJ76RUTOCwjljZXgb5hWs4w5YDMF0obtf+JjjoWZfLPohfPSpln?=
 =?us-ascii?Q?iZiITJ2J8pQQZhfYfpEPH2/OEkfTbDpSpc/YpnG9+BEyaNFc9XIOyH4x/oZy?=
 =?us-ascii?Q?Y5WNR0GhG+vdJO7RkSlNwmSV/h21oj1BVf8V0klKIl9AIYqboc9wizfdpwa3?=
 =?us-ascii?Q?2h1qRF7WVMepMacaPs4F6DadL2dBIxZO7YcV4gZkqMgxrZetTy0ZIjVNGWUy?=
 =?us-ascii?Q?nFrHpUD0XSEx7i/OimtY+z//BQFgoXhq+vX5YAxfIm/r6qT1SL5/+Anxw/6Z?=
 =?us-ascii?Q?2Y1eRwYJtdY7ckpCTU1V1Y112vaG4/uU3f0L/xg8bodTIldOBzo0rixQSRjf?=
 =?us-ascii?Q?MyxzzPDSkhqg5UlPC+9mmLCyJcef19lYszBEoJtox/hTnLOR1Rc4rorTa+hY?=
 =?us-ascii?Q?irdlC4zWTxnVdjNj7a5IgrlzDBEXAKjYGQR3B+OgARd4qjcY11z+dq9ErzFf?=
 =?us-ascii?Q?p19VoSYdbkpthsUyx49cJm4ABwgfYIjRg6A9BPucJYzO++OeLQ+EZEKHsS8f?=
 =?us-ascii?Q?XZbPOdfhKAs4BYSsjE+C4Dz5sfjG/m8M85Vh8rDPgCjMY3dj2u1jkqxKs7eP?=
 =?us-ascii?Q?q7BOZAaH0yTERaPsWoxIPOA2fNFddIAnfLUXheJka7PYoMexF3gFuPuB6jdy?=
 =?us-ascii?Q?yiKMLjWM4u9egORV8AUEpN3K+UM11UruR4qqPZxnZ3b3/FsBl/8YOZ/dOU7S?=
 =?us-ascii?Q?dzciaqwSRzowxRXxHsmwuwkb5I19IAXJFF/G/JLEIBEtv8/2DFyvnczFkYrO?=
 =?us-ascii?Q?32FZNFkIoBZjJZ1Z7Ra7WPTCJvlOzFyey0lEg0JP0qSw/PzaRUcsh3/FcrSc?=
 =?us-ascii?Q?f+se7IRwhaGNMQSAWoFguYN5ObSQPzvS5+R3L18iy9xy87GQWwFKvdD2EkQo?=
 =?us-ascii?Q?Gf9G3mDZ1jRiQCjxptPeTvqvrzLfV6iXTbLDElcRw6IUdEK0CIDdtBSlEtHO?=
 =?us-ascii?Q?vQVdRjDV6LmbLI+lMDevRnto7Fjpe0YvDUjUne+UpXivkwxMhuwiGQgxDho/?=
 =?us-ascii?Q?/B3VG5ESE6V24nvMiB43dZvh1fBmp9bN2elFsELY7NGOXJDeSwxroWC1/xQ8?=
 =?us-ascii?Q?7FpxBpGHM39tDdKG4GtPeOoyJ0284lvOMaTG04bR6qAj3LGapxK/b/x+02GN?=
 =?us-ascii?Q?k1WL8Ru4FXu+6bYRo1/rQgjJpzdqwRoApG9jtLApNOkPWQDLMfoeb8heoR2G?=
 =?us-ascii?Q?Fzu9IqKJGg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af882ce3-aaf7-488b-13ae-08df0514ef12
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 14:59:17.7905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEkyCMsCU0Whk/9O9ROB70RTp2LVTQQwQ/q1a6oogFOLDM3XmDOUao0AseYxGNsVPjSE3o2O6T6x6skL6eAJZbphARhsdXtBAC/wLH5pewo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 14:59:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20105

> >
> %7C&sdata=3DNM5g2OmqXtTBYvIZEK%2BZhXJEgw3kUdwosF6Ptn8heOo%3D&rese
> > > rved=3D0
> > >
> > > Isn't the bb.fetch2 shim expected to take care of that?
> >
> > Yes, this is what the shim is for.  With the full patchset applied
> > things should work (TM).
>=20
> I take that back, the shim should already be in place as of this patch :(=
. I will
> investigate.

I see the issue. Nothing in sanity.py imports bb.fetch2 (or even bb for tha=
t matter), so it's relying on transitive imports and also the fact that the=
 old shim inserted 'fetch2' and 'fetch' into 'bb' as essentially attributes=
.=20

The short-term fix is to just add a __getattr__ to __init__.py that lazily =
makes fetch2 available. Then we can work on manually fixing up things to ac=
tually import bb.fetch, rather than relying on transitive imports. I'll sub=
mit a v2.

Thanks,
Chris=20


