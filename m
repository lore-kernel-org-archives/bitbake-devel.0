Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B961C3DA4A
	for <webhook@archiver.kernel.org>; Wed, 14 Aug 2024 13:49:41 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (NAM04-MW2-obe.outbound.protection.outlook.com [40.107.101.66])
 by mx.groups.io with SMTP id smtpd.web10.98362.1723643372282289048
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Aug 2024 06:49:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=tRT4AYgX;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.101.66, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oq+W880RqdKQljsVkB9N2nnDuV1HYj2lHHqLLlIuwggoa/iCYpwMqOzMLGkNBoJget03PIga/8qdbQMjXnaMHmNLUQwyDA4GqP/KNTWq1aDTxOuktbpEpRJXWwTbCnO+uoPYZuaf8h6XrKqHseRJVIhDcycBbmDu8A8FP+8QwHww+0gejR5KWEN3jpw/YW5erUWwWzD18+LcU58SD4Z/jWg6eOsyF5iV4+oYgd1vMwG27FXMLsVzlgcrw7M9GVIsPbhOk+2bqWDRZswJDLeUOjfGqpopm95wcC3INKZkyO6plr/9i3OGlbCcOpcvm7BbG1cqnY44o1Mb1+x1qhIhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCazzgoS0EkVuaCNWYF/43yHeV+RMqVa5NU0fo63aGw=;
 b=RlUL+y8DD0NL1TYjChoR8YpctZjWB6HazMYSnAX0JWMac2TqO4D9lJjQ0j0x0q+aq8e7O/dPYyQmxiZFK+Gh/UuhLjJ26k8pBbBZXxdAhUrfmT68m9NG9S4tWfKXnjW4zRrS59NydjEgIKSr1mTDoTFR119mOJMUNBCa2AH/RRc1VE4lhSYVvA/LzNZruC8Td/2ULvgwBqSi1bw20NKOiiJIgJjBr/osHKiXg3PRwRGebHCvvYworEPtYUq0oOJ7tL3OOSE9RIKUSddDFqZHEIXft14YztbxzSaH7xb47FqfHhRvNmc0IXhq6nDjOGJl5f/BV0M7zcrBAzJuFsfcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCazzgoS0EkVuaCNWYF/43yHeV+RMqVa5NU0fo63aGw=;
 b=tRT4AYgXtN3WGQYKyhAJl8jI5I7On291Gm+UuZ312viBkhR7vEjhuUV27WRzBmkZLRD6FusweBhQITrJ61QC8c7K5VQtUBTqw2h/pkeKvNkfJVKr93y9991c/bs5OtZR8hyn2P7OwrFp78Ovgp+9JjiwMVKfYi8zKLxT5ln9il9cPi/zyjai9yPj1zikWqGKnelMsdjgeIqIS6LzLMvu+l9xsCGF52tCi2qQn0QutRZwOMr826ULBNbjY24SjBYtrCZt5agloSn4buNS8EWT4VcdBkN010wfqG6QFuy0OiFx6cea+Cbx+5WSmVmxQhzja8ItbXu11CThbBHs/Tk02Q==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.18; Wed, 14 Aug 2024 13:49:29 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 13:49:29 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for failed
 tasks in summary
Thread-Topic: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for
 failed tasks in summary
Thread-Index: AQHawPIapS/6pGKeAESDdgOaEDjIOLHNuM1QgDcBcXCAAWQL0IAUakEAgAyW/zA=
Date: Wed, 14 Aug 2024 13:49:29 +0000
Message-ID: 
 <DM8PR12MB5430F40F673CFAF9026C75998B872@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <17D9E3841C981E13.27929@lists.openembedded.org>
 <DM8PR12MB5430FE1BDE5343FD142CA3D78BCE2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <DB5PR02MB10213FAD2E238F7AB9390A4D2EFA92@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <DM8PR12MB54305463A787C28830751D948BAA2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <DB5PR02MB10213C66CEE84882C7B8D12A5EFBF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: 
 <DB5PR02MB10213C66CEE84882C7B8D12A5EFBF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=df634e94-fdaf-4c67-8d26-2b3b695eef37;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-06-18T16:34:10Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DM6PR12MB4329:EE_
x-ms-office365-filtering-correlation-id: 54f7ba22-91a4-4b92-073b-08dcbc67eb39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?TJrtD2oxLpgFUnBAciVxoApjlqgjNDSEtKQyP+i/DpFeOrmXqivpAaeyr9hF?=
 =?us-ascii?Q?HFReKvyukvPo1KfMD5K2PWw2z6f2MxSfKHIxxvy7YviYjMbk4pPPauUWraEC?=
 =?us-ascii?Q?5DAkx7fjrJ7IsC246Iy3bArXGFcUORTfxQXZxe5R7rYrIb9uMZAWhz4a54rX?=
 =?us-ascii?Q?+p+XGCHV+dOC45SPXt/+yLBuZqJ7Zg8nvUFCZ9ZZUagld1fWy+jgiQJ9XpME?=
 =?us-ascii?Q?9Xg5EmIPJRIGeQO+uozWzJHtUbdU6LYDxTJur2xeUNcejWE0d7sTkE7r2tYi?=
 =?us-ascii?Q?xKtb0kbkozt939RE+peqq+J4k85Pz+S+e1pGZl2Ps33JbGtUqSWcUz5Jrt8b?=
 =?us-ascii?Q?HF6yR6rUtyLS4InYLt2fSJl6ojmHLG9xcgHVubngG767yWuJ/ag2UejcIKqA?=
 =?us-ascii?Q?fkEJ9+Enp1Ree1GavSF6IBR8S0z0Hk9Sr3VkRanr5UF5Qq0o0eVSWGrGLVb/?=
 =?us-ascii?Q?/xkFcDVlanpZ7L6iwH0q27Xw/1iJk8f5mlrCxmdgqHXKFi/K+NkwFkGKukbn?=
 =?us-ascii?Q?0r9tg+RRljGP3zYCiNnECINJ6vHY37Zz3KSYazE4HXwszyZAOEex/wKzepye?=
 =?us-ascii?Q?etWEcx9Je8/C86jOGQwPCdUDWQLrxSlw18IqI9rVV+EZC37ywtPA/JzsOjMy?=
 =?us-ascii?Q?mRY3uAztHtdEoi9OUvr+LBlxnZNV0v+EuMLG4sCTjKf4FuhGLNCRMwdfDchN?=
 =?us-ascii?Q?7KMuwaTj0DkHh92lDjB25RjSrnAtK4P4IjElH+xDDBI860mUvUo8RPAYZbDT?=
 =?us-ascii?Q?OJ2maEo2IL/6CGTNhb9ymFguvmH2w3RQR01HxQR3qqF2alQA3WfMgEFbHrfg?=
 =?us-ascii?Q?oF/sK/Z1d42zGB/4MLYw5KQb1vLi37KMhFwSpXHcgawzoe/NJ/fmkVUfLy7b?=
 =?us-ascii?Q?xLVHtwClSjwoOeiUoPRUE7/+O/w2weXpDKCuuC3CAFj+ellr88a5WzXcvR9L?=
 =?us-ascii?Q?FnvHdsmsngV4EgDf8dLrjn0ScFR/v9FEiMC2VIYM2GzgulWcnm979SN8Qppb?=
 =?us-ascii?Q?tIkh/yQlpEJrse9IeEYy3ZeTYdAXuh0I8IN+yG08sPd2t3IwMQay/1L9n+k6?=
 =?us-ascii?Q?NKSInOzw7NjBe94L7cT2ej+d11eHfpnVX9BKFCmGnWXd49rM7LSoiKHU2CJp?=
 =?us-ascii?Q?XdL0+1vFKjN6HczhV2aM/Ffiw3i3Zh1pfGfax2nPgtr0XA8GoeuCpHSYB9Ys?=
 =?us-ascii?Q?Zu/+nTw8Wh/SdRANGrkp3QI6QngMje8X94z9wjIHpHM0iKVBsPgygm5XXvVW?=
 =?us-ascii?Q?UhLxxlJvqerjmSucdoa+YbC5NZlwZM7WxjaQ6Q41eeaiF8EmEA1XSkQJTguh?=
 =?us-ascii?Q?LJeJriexf2QnPIBMnEfIjNivUg1+cpegNLbiJMdFXB6KHbLKxyKLzoQCRh4Y?=
 =?us-ascii?Q?UcQh7elVZ4YFJ8We1va+D6NKc/fRHdieUTMbZgO6Lpoxy4qjzQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?WZuOktEBVv3/a57ZXPL/mwv1npRue60RGeH53EdNlPuTz/la65qF1xYVagEY?=
 =?us-ascii?Q?qPH0EFF2+6qyjdChonJvArEz2lzKDuNXLeIAS7vS10VAUhKNNK1ASIfEspxW?=
 =?us-ascii?Q?3XLMOYHd6v+Kw7MF5qHFCdB42TpWnKT/0i+NIsComu27CUyswzPFnIvl3sbG?=
 =?us-ascii?Q?jyPAdBwyO2kLOjLNEygFZeyIYli07GpH6Cifk1KVJSXzGyfs769yIhPbbne8?=
 =?us-ascii?Q?Y8kVOlGpppIQ+vslMkZ3XP/QiE4hEH1u4vrvzLyyVyv9ZOGslS8lkvEJQRA+?=
 =?us-ascii?Q?BO4rNYbfbDlQqoNFNoXdUebbSuD95uZ9VOJxcF2InRfZkMkeUrMPIijqbAbV?=
 =?us-ascii?Q?UYfjOTX93BR1Hm1M56KQzHTb4kcr9VKH0q5Y5XDkYjxTdlomqstNuZirBHap?=
 =?us-ascii?Q?nZWkJW4qgNRLyPQ6jsQcyO0CQ5pC/BAfSJJDEHCB3T0oCDVR6S0uQRioaSPC?=
 =?us-ascii?Q?Bv9MH6YEPnoN72Nl4609TOverIK3rN6xz115XB7kLajo18dHqWFU46GyaLcI?=
 =?us-ascii?Q?i2D2dlI56ssZUvYhKF5WwFhI+iFkRoNICCe5ktbc4G2P5lk4hpZte6Lj5eo9?=
 =?us-ascii?Q?i/7NPcqdWsYPEpqHTJX9HFqSHdWOSUyCfj/rEBcss6emV5vFnYAt8/LREQua?=
 =?us-ascii?Q?6QrJ/1Yeat0OQyi9oijHVa+Y1E+gn2cY2E4Xv8muBD+yjAJWc/iqgsWrdj0/?=
 =?us-ascii?Q?zcLvsmnm/OstrZiuy4W4nUZse/f/87N4zOQSNlD/d9xjCzZenGledkgtaszg?=
 =?us-ascii?Q?7iINGbTnmrrN8RIKJVrde5OaHWFA7zGD4baoiXWW9MbAgQE0bC1Jmi1inVtn?=
 =?us-ascii?Q?kwSi//4bKM3jjqPVjg3Px1ROGecQZlpJOpmHWnhTz50ABBF4QMPRNau93vtD?=
 =?us-ascii?Q?8fukmgRtFA43+B8gKSrsZKmwwNDItoOem2u+rhJgryRn/ZmyO3HVfkmET4zr?=
 =?us-ascii?Q?AA87WN5W4y7zCartjhQEFDura8e7n/5+BiAySEC4SzDrVC9ftOLtgOQdFi9g?=
 =?us-ascii?Q?D5NVbjjVpxl7oJQ12xsgkdlPXpzX85/T1VYwbR2WyJQHuvLo57ehM5JT7FGy?=
 =?us-ascii?Q?LWdQgtRxgNUhcrjCm5W/9se1QuMwJzW+7TNlLWdoQNX3PV83rOHGzAM77z46?=
 =?us-ascii?Q?9P5CjoDaYksvOpOXnsGe9DRfqEruGU4C+Suam8yt3BJTBQJzznw8ta2G1nZK?=
 =?us-ascii?Q?8ogCIxzX/QO/BcPt8qE5t/Nani/wGwoaB6+yzY892oxGs2w0VBSW1aMW4Uzm?=
 =?us-ascii?Q?2XuTx2hfUN2VvdsZrYg5fP2qXOXieawtuU+iSm3OD2w+oftTIi1kcWNsyJ9Y?=
 =?us-ascii?Q?yH+ZsBzUlqxlUlDlYx8BN55L9Un7AcIpcB8lVmTeC+KzGCzpjgtcmkWsHkV+?=
 =?us-ascii?Q?1/KhMDPDMm2GEJii//xAdfBNT5rvzpTRstmtaa/QyuPBZh77594XvDNlqVcC?=
 =?us-ascii?Q?uezghSuxzkfq+HnblxhE/Xv4D2l4wMj/fSfnqqLwhqHdTpUdX8j+XkURzOH6?=
 =?us-ascii?Q?Yyy5zD4gkH5tyN07S6ZOGOh4PCWW/zgeHMhi1ZjEFYoiOha/XrOsWAjHLywt?=
 =?us-ascii?Q?4cjKqYfY6YeKA+1wpx08DH23UuEi6YURyjbGZt5f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f7ba22-91a4-4b92-073b-08dcbc67eb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 13:49:29.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZH760YVXs4Luw31HArYDKBD4Mtkf9dNzYmTZqkRANWJSMEJVCZ1RURWDkjwI/6p4dxtiWklQbuXWWMBbrzOXZH2MMKuOhoKhHteSFNSC/0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Aug 2024 13:49:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16483

Hi Peter,

> > Did you have to tweak the code to suppress printing the hyperlink ANSI
> > codes, or did your terminal just gracefully ignore them?
> >
> > The feedback is much appreciated, thanks!
> >
> > Thanks,
> > Chris
>=20
> I use MobaXterm (on Windows) and connect using SSH. It silently ignores t=
he
> hyperlink. Same with Xterm running on my Linux computer.
> Gnome Terminal shows the hyperlink properly.
>=20
> //Peter

Many thanks for the info! Submitting the patch to upstream now.

Thanks,
Chris

