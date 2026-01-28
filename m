Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B994D25B59
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 13:30:23 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13205.1769607015397990013
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 05:30:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Mr1Y/fBr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6488bb3565=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SBuQMi3523939
	for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 05:30:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=Zn71WErWj3FUYMDYqtcFby
	XHzA1T5fvzGgSA7bY1li0=; b=Mr1Y/fBrxsVOy5slCfk/xi9zzCxz7bLMdYV3Uq
	GiFi1dumorf+Pae5p7aJbhaVZSHs3ZiFlyeJX1V0WQWnijNlrz1XwK+M+95B6iGf
	bfywjcyoMlLwviCPMMmgottWARZrccGKuXN7rqKi5iHvzsGVwiVLonheBjGMYYns
	iLAsWLFb8ho8uacKGDDW0whTEKIwSJyhv4Val714JaEk/3NuKlUwfvXmwSD2GXv5
	Poh0zdtwz6RUWIAYenUE/iXwkl7sSNgLZpEyGt1H2A0ntg9cYfKZg2DAliCvqp2F
	JfAwARVP336n6vsbBBNzhfWhNVIv3IRXy2arWGkvyiWLebAQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvt85cxpd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 05:30:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTn2k/1tznFXjYi4G9CMCiMAaABl9mtNZPYJnp2L4W+xhNPANAkNBhjnK3LDx4aC3eTYWIOm4xq6RKOhgWfowMk8Rn/xh84Yfj3ANUeOwUh0GgTwezv6PN4zMuVt2pMYEwpu7j1EyczHU1DvBnQ/SRWEncY7XYeyxWj2etjjxt28uNVz0uaPYaUmjeCyKoIhi+HdbRkM99kwPmzrT32e491T6ARP29CR4IP0Xj+xiwvEF0uEnU0YOxM5URY8bssgfXvKJwpxPm7iJIjWl7128pItZx1eXvPuMJ7Bg8Ufauy6fEvekyxAuVDEk+cyGjTaNNim9Ap2g4A3hWdmjf5TbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn71WErWj3FUYMDYqtcFbyXHzA1T5fvzGgSA7bY1li0=;
 b=FWkXhNz5booTLZuw/v3m1mggR4J+cuhLdvF4+FUYN2wrK8PfE3hdiuVYuP+krsxSOHbbnnGLGBdpPdGXOa62+ZGiYunvm24GTAqhvZPK+19EQXGJj6TCleUUrfBl8S7NnFXLjEwEr4gReVXRsu4cH9T16ToBHOxdHNve0YsDENnRRNWzNcLMkcsEk9ZucbdrcX68Sl3iG5LVGge0IyKnD5ZpfNKHfiol1iV/+DA7AIOmjLcRxnsTHHNTaIaJGYa7IZnKzAzDVfUW+mmOTN0l3cPxIzhFjt2ULYPnsgw7uzeTsmO/wOoOuSHVMO8zKQcyrwPsMjDWq68FBdgBnIdfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) by
 DM3PPFB7F00E099.namprd11.prod.outlook.com (2603:10b6:f:fc00::f47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 13:30:11 +0000
Received: from DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::ce1b:9c1d:d571:9eb8]) by DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::ce1b:9c1d:d571:9eb8%4]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 13:30:11 +0000
From: "Woolley, Rob" <Rob.Woolley@windriver.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 02/10] bitbake-setup: Add pypi
 packaging
Thread-Topic: [bitbake-devel] [PATCH v2 02/10] bitbake-setup: Add pypi
 packaging
Thread-Index: AQHckFFp3LNIEmqnkEScmDVJWKFAfrVnkbQF
Date: Wed, 28 Jan 2026 13:30:11 +0000
Message-ID: 
 <DM8PR11MB5655BCC1A88B3774C374959AE191A@DM8PR11MB5655.namprd11.prod.outlook.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
 <20260127160508.3392732-3-rob.woolley@windriver.com>
 <CANNYZj9YWviJ=JDR7On+LfK2RHBs1X77J6UzxPQDzVUV2rxnag@mail.gmail.com>
In-Reply-To: 
 <CANNYZj9YWviJ=JDR7On+LfK2RHBs1X77J6UzxPQDzVUV2rxnag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-01-28T13:22:37.2305639Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5655:EE_|DM3PPFB7F00E099:EE_
x-ms-office365-filtering-correlation-id: 911449e0-853c-44e2-a1a2-08de5e715ced
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|4022899009|1800799024|8096899003|13003099007|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?YxFioFgDihXqdc5OniMppvaoLlCR7q8N3iTIefUL1eMPp9XMTZoi60yoV4XJ?=
 =?us-ascii?Q?85yJBtTOYPhBSbd1OQ1879M3Z7T8C90DtR6HDFRoBPVbKvf26RDJkDNACr2S?=
 =?us-ascii?Q?YUiHADjg/PP9WDPDuj8DS40fVAT+Fg3WB/GtlRF+Wj8aqVrupjzdTvRDdFzZ?=
 =?us-ascii?Q?9u8CXIp0oDORt1AjFRA2sFvoa5tqJFrnT7L/EXKaEtq3LUUJ71FWa8B1/p1f?=
 =?us-ascii?Q?JND5+VY8hFAz/LFl9d+R0NMD6waGV89B4na9O9d2wdgk2taxgU/94qomTXf0?=
 =?us-ascii?Q?ZnDWTbghwyj9+tqHT00JmEdBOoR5uuVrEFXEWw3pzFvUAe9af/Y9bnayqby2?=
 =?us-ascii?Q?+DqbfiRrlRedHR3GdMsUG9U+atKIXTejn4X6f8Wq4FlziZGzh9el4LuRBdj2?=
 =?us-ascii?Q?u63LEU8z8nbxKf7cbd/PqN7s83tpS3sOlyj42mnjvAcaZ8v/z8Mj3dM39ex+?=
 =?us-ascii?Q?aHDYd37+q/uXxICGgNKY2r1I8wpvjpsk5zVzQ+pHHv7AFDh+Q0ytG87TgamZ?=
 =?us-ascii?Q?ox8v4NCrxcmRg5HlxGktEtyefnjoqzUMxgzNYTwrFCLWMlB/rD7vwQpAG7lC?=
 =?us-ascii?Q?hPfnWSmhUbjGU4r8XQKyBYpOB1XR6o+dsEuIeGtK5tXCRaoA18+lzkvtdOmQ?=
 =?us-ascii?Q?ViocscVFJdFexEeAnNbc+4MA7t7GyOQCsQPN627BTYaqJmOyNw2Bgxf9zu4a?=
 =?us-ascii?Q?jSzJxxI31TVzBS/iT258+eVahPQ74G9qNzLhZjtKkWgCefotwX3/1HUAYKGc?=
 =?us-ascii?Q?BzfHH+nMaC6vs1r8BKDaSRI+X6xJ//w4wuzL5LA/CpbsKoQYM4WZ/0MXxW/G?=
 =?us-ascii?Q?jcLV835yuotxmj+7OrBGHgAFWus2TvtbkFldcJcAENuK9RYdSFNoe4vMovKN?=
 =?us-ascii?Q?TGk/xrw34/FgF5P81Qu73BM5Mu5mVM/TcSEPoHZsu3fpatr7nE5raNz0N2w3?=
 =?us-ascii?Q?zF0U5oPTzvAxaRhYVaRY3EkakDdwCzCQkPtJSwOPKkksOXqwhG0NTyBObYzI?=
 =?us-ascii?Q?C79FvG/WsuxZDiWW5Tj43oFbINzU6E2TLBszSHmdkIIOFNufc1gha2vGnYIb?=
 =?us-ascii?Q?mPRuntPj+fGNGaxggLPnhm/7NY03n4PdiZ6BT/L440Qatac7HPYX+JAgQe0F?=
 =?us-ascii?Q?ya73Y9P2MdKHtlLFz0eaFeYTrfpJTfFfJ99QFKE6h7aPg4NkkLMbXCTdgQMq?=
 =?us-ascii?Q?ygMefAGKaCg6U1wYGAK2ID4pOJLSgVUc/6xmwvgEN84vTp9wvgF8ogNoNTbG?=
 =?us-ascii?Q?PykfX/zeFze9FDoDu6heunoPFcSW4Er8ObToy7NppJHf+9hgK42iG+Lmsi3a?=
 =?us-ascii?Q?GZYFb9QkdQ6/jvoXe2w9baj3f4GAI2nrSGOIC1wTlt+ennHfYOLI8j+7Km56?=
 =?us-ascii?Q?HJwqaNHqimgyTz2lF7tmo/iAHOyZu+A6l8Fz1+J85X1Ftd//pVZeZBOjB3vh?=
 =?us-ascii?Q?hRbqV+b/iIIk1a/8mMFlq66rlThYn3ulnAedxCLQDtnSh+Do5rJxWZkI2XT1?=
 =?us-ascii?Q?UvJ1qRWmyTTlm6WQKj31qdWPDpjFiDRaj2EjmqduC2GWyIcKntisABNsxOfC?=
 =?us-ascii?Q?/MmDsJH2p3CJLSd7+QC59odhD1xQ7WqaemvucBJL?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(4022899009)(1800799024)(8096899003)(13003099007)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?xMQWOZCNx8eCbtFfZk5mINyZ89lWxAFgw2+67JuoOQzNzG5S4v+/7yDmtss+?=
 =?us-ascii?Q?0tKvq3dwFUDu6bwzd1KIXMvYtnxr/5/pbHa+d0SXjeO2QQW4rTteSawagN7z?=
 =?us-ascii?Q?AMG95b9pMLZ4TEs9yrAQDahZk7reL3RHPxK/OD7tAKMR1ZmaQYX4x5ZLJHIc?=
 =?us-ascii?Q?ZIEGgp/wlFIvJtkhZ9vTPpXKmPz4VZfbmcxSW8OQearM0RRf2rpcyjEoaHPk?=
 =?us-ascii?Q?alP8M2Y1i0TsmwpmGLNdx2KEq0Dyht5aZjM8ABit01PAcpqry+XV87QDYx4w?=
 =?us-ascii?Q?P5AIe6JefdBuyY9WCzs4W4xoIAK0NDSX2t8dTvX3K7y00XpSOgWbd6uLuN0w?=
 =?us-ascii?Q?FakreC/rDl5McywLoqJGd6vlIOWrNKyaqp439HX2q5z/qO6yWVgHYF18HeaO?=
 =?us-ascii?Q?NZ8cfyS2iG/9Tk0cKHXv0mrMu2EzGsmOvaR8Mq4FVDA1iI+PqS5d2qkV/Qm5?=
 =?us-ascii?Q?bxvMY2WuFHJNi6kSLJoGLQV451dliG51dQVHcQsSc3yjdyueMWxwpVn+VMNA?=
 =?us-ascii?Q?5X3zW3CwfRLs8Iorb72Zva0oZ1mgQBouhRpXEwqowbYrrm3LKRnNpcRZRbPO?=
 =?us-ascii?Q?ZIVKa1l5CEJ7rzPZ6L5cgr2VkGCt9ePthXR3q/fxAdv+RoFsn93TU8kAOtAZ?=
 =?us-ascii?Q?rTMrnl9IQFXdQ3ylQ6CaiofDWoxxlZay7wu5Hn4SEMR02rNH+Jqt46ZHRwHQ?=
 =?us-ascii?Q?tTZtIE3UnrEu6i/SXq13YTe3SYpVSy/dV4UUI+fERV592bDaSHCosKiYqBKp?=
 =?us-ascii?Q?//fft5qpLDWSmHthX/9eznZ+dBg92uJazzY1CV92u7l0Ye5Qdmrbh7eXnQGH?=
 =?us-ascii?Q?r5oDf7Mt58XG43KjtD8TEvXMyZafDT8Pz/kuLILJ5yxWi5+QCZAPHbzmAqvy?=
 =?us-ascii?Q?+ZtVUhIjCLYXxyEYiEAdon1YAOi/O+gCZBatFgap+xAEdXckOlQ/aLwUeSC1?=
 =?us-ascii?Q?VUTT+aZ8/urIkoZ39qsy9LfED/0FZyEweh2A2Fk8u4BBqBJ9g/eY2iHFft2b?=
 =?us-ascii?Q?pZOzKiUHAiO5JPpO4xQml92p1669/iLS/9Qd0OEJI+rf8FkNGhgls8UCKrD0?=
 =?us-ascii?Q?fZXExP3Fk28J1ckOCXdT6978tlLPrXGnBt9Fmkjnrn7avBLJri2HTbcjDLCI?=
 =?us-ascii?Q?M+7cH5vPc7yMDUVqd/QNMeXQ3MizvwCP9LonLT5cQIe66l2GN9OAhBL8wqqC?=
 =?us-ascii?Q?y09VJKekXOUMsPxvcF5xJ5jmXSrxuwVTRYgBuoA5f2MIg70waXJZ2jjcFsCo?=
 =?us-ascii?Q?PTVfSgfEsks8DAxrMBmkhl8MuCQVfgHDrpoxEAdZ/xorKw32e9II8x107ylm?=
 =?us-ascii?Q?xBEAvmxejBvF2ti9cFkwB2rPfKrwpcUxng6N4/RWXbe94KO9Kify8i9j6wVp?=
 =?us-ascii?Q?EJ76bq1WrT6QjLrfT4k0Emitx5hp5UGFjXYcFJYzBkxbM24yy8/r2V49LJXE?=
 =?us-ascii?Q?K+TEoFzUxb6r3S2yxm3TE6iFmmolQYvODXZt9x4kaDlRlop15/ocd0gVxVy1?=
 =?us-ascii?Q?9A+yZBKI8K5yvLh4l/tJswA1vfn+STGvsJFwA1/Bg297y/YBBDwCbhy2CH5w?=
 =?us-ascii?Q?dmlXuhq0KMAl2iDvzSwNOZskA+zBHjB2Vz0kee9bzYQhxb4rGLygto4ouJqs?=
 =?us-ascii?Q?mRwaWSCu14im9tNqWGqW63YmfXqZH3EURFAeJD6c/Qq9IlRtFR9x7HD23v2Z?=
 =?us-ascii?Q?bbwSlvbrU7C/A1UWs1s7RcVRih3Zuu0m7gTlXKeTTFpaJvdemC2tDD9ak4np?=
 =?us-ascii?Q?JaLVq3a0N+ZenDMEUnGBrS/phBy85Bc=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR11MB5655BCC1A88B3774C374959AE191ADM8PR11MB5655namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5655.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911449e0-853c-44e2-a1a2-08de5e715ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 13:30:11.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vmNzdvt93k80xzACvOC2VUVP4rfb93fUMFzUHrvbzJG/cZr6p6R0J++w5SLE/fLcI+pX0TaG9bgTrRYmCWT6md3Y/DrO8APqgV0vcYCr/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB7F00E099
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDExMCBTYWx0ZWRfX9NjZiOdzb/3X
 YyBBn09vnZnj9udrPgE3624odcYVLiffIn/oUXTrf1Fkg2TBoes2vQu07IlS6po+KJOYEpa73Yl
 q/F1bv/EyP36H+j7LfJ9Lg9+VyWJgzvVLicAzfRg9+rlcHUzvwq9vmBmj9igzcFTmt1CBjtkaNh
 Eanf2zZ0/Y8V86x36g6QrnAcrN8cjdwyZdlpZcVGpZxqRKU6t0+mm4eTKSdcGYmHAKJm5mj4bPt
 YJ3GhkKOy4y0HUOjlIpLTQz9gYBgCB3Yu1ay3Xm4wvIwvmYPKGBP6rFElK2yHuec9gcd6pjyhWg
 bQmKduKdOyDqynYFOTyRtK4VXlQhRB3vD/0W7C5anuv2AY8xq6Ma0I8RnhgM39wMutfbIDFza8l
 kmCKJNeL80zH3UNI+BDCcJPxnVSBML4ASeXZEDKm1WPZWp5R/9VqIL2RdjtfpMYSWE9mAn37fJc
 D4JUWaSlYm7sCGgLVcw==
X-Proofpoint-GUID: kG1AJUH9R8OLbHzS70V5aaKSRFcZF9jL
X-Authority-Analysis: v=2.4 cv=M6lA6iws c=1 sm=1 tr=0 ts=697a0f66 cx=c_pps
 a=xqAAW0zfUN0YSepx5EhcMA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=_EeEMxcBAAAA:8 a=24AZYWMyAAAA:8 a=iGHA9ds3AAAA:8
 a=Q4-j1AaZAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=qV09NasGAAAA:8
 a=j9Gkw3vXnVuGLMuZa8UA:9 a=CjuIK1q_8ugA:10 a=abPTvJue_RwA:10
 a=Jx3ILz0mQCufb8_XMIEA:9 a=O4W4ueYsJzW6-3gh:21 a=_W_S_7VecoQA:10
 a=bG88sKzkDEFeXWNnvthB:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=GlicbclHOgpI_Rq0ze_Y:22
X-Proofpoint-ORIG-GUID: 9IRGuneETVYkIjvhZJ_lLSRKz47d7vln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280110
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 13:30:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18914

--_000_DM8PR11MB5655BCC1A88B3774C374959AE191ADM8PR11MB5655namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Sure, I can look into extending the lib/bb/tests/setup.py.

There are system tests using pytest and nox.  The 2 pytests confirm that al=
l the imports succeed and that bitbake-setup --help returns 0.

Nox runs the pytests as well as bitbake-setup --help and bitbake-setup list=
.

 Should I replace the nox tests with pytest or create new tests?

Regards,
Rob

Get Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Alexander Kanavin <alex.kanavin@gmail.com>
Sent: Wednesday, January 28, 2026 7:26:46 AM
To: Woolley, Rob <Rob.Woolley@windriver.com>
Cc: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.=
org>
Subject: Re: [bitbake-devel] [PATCH v2 02/10] bitbake-setup: Add pypi packa=
ging

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

Thanks! This does look much cleaner, my only concern is that there are
no tests. Is it possible to produce the .whl such that the steps and
the output are contained entirely in some temporary location, or (less
good) bitbake repo itself, e.g. nothing gets written in $HOME? I see
that contrib/pypi/package-bitbake-setup.py takes a -d parameter, so
perhaps that could be used?

I'd really like to extend lib/bb/tests/setup.py with a new class (e.g.
PypiTest) that does it.

Alex

On Tue, 27 Jan 2026 at 17:05, Rob Woolley via lists.openembedded.org
<rob.woolley=3Dwindriver.com@lists.openembedded.org> wrote:
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  .gitignore                            |  1 +
>  contrib/pypi/BUILD.md                 | 57 ++++++++++++++++
>  contrib/pypi/LICENSE                  |  9 +++
>  contrib/pypi/README.md                | 42 ++++++++++++
>  contrib/pypi/noxfile.py               | 30 +++++++++
>  contrib/pypi/package-bitbake-setup.py | 93 +++++++++++++++++++++++++
>  contrib/pypi/pyproject.toml           | 97 +++++++++++++++++++++++++++
>  contrib/pypi/tests/test_install.py    | 17 +++++
>  8 files changed, 346 insertions(+)
>  create mode 100644 contrib/pypi/BUILD.md
>  create mode 100644 contrib/pypi/LICENSE
>  create mode 100644 contrib/pypi/README.md
>  create mode 100644 contrib/pypi/noxfile.py
>  create mode 100755 contrib/pypi/package-bitbake-setup.py
>  create mode 100644 contrib/pypi/pyproject.toml
>  create mode 100644 contrib/pypi/tests/test_install.py
>
> diff --git a/.gitignore b/.gitignore
> index a6a256b2..9a5c4ec4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -17,3 +17,4 @@ lib/toaster/contrib/tts/backlog.txt
>  lib/toaster/contrib/tts/log/*
>  lib/toaster/contrib/tts/.cache/*
>  lib/bb/tests/runqueue-tests/bitbake-cookerdaemon.log
> +packaging_workspace/
> diff --git a/contrib/pypi/BUILD.md b/contrib/pypi/BUILD.md
> new file mode 100644
> index 00000000..3c50b6e1
> --- /dev/null
> +++ b/contrib/pypi/BUILD.md
> @@ -0,0 +1,57 @@
> +# Development Instructions
> +
> +## Requirements
> +
> +- Python >=3D 3.9
> +- pip >=3D 19 (for installation)
> +- git (for SCM-based versioning)
> +
> +## Automated testing
> +
> +The steps to lint, build, and test the bitbake-setup pypi packaging have=
 been automated with the nox tool.  This tool automatically creates a Pytho=
n virtual environment for you.
> +
> +To run the linters do:
> +```bash
> +nox -s lint
> +```
> +
> +To run the build do:
> +```bash
> +nox -s build
> +```
> +
> +To run the tests do:
> +```bash
> +nox -s tests
> +```
> +
> +## Manual Steps
> +
> +### Building
> +
> +To install the development tools manually run:
> +```bash
> +python3 -m pip install -e '.[dev]'
> +```
> +
> +To build a wheel (.whl) then use:
> +```bash
> +python3 -m build
> +```
> +
> +This produces a wheel (.whl) file in the dist directory.  This may be in=
stalled using pip.
> +
> +### Testing
> +
> +```bash
> +python3 -m pip install -e '.[test]'
> +pytest
> +```
> +
> +### Linting
> +
> +```bash
> +python3 -m pip install -e '.[lint]'
> +
> +ruff check src/bitbake_setup
> +```
> \ No newline at end of file
> diff --git a/contrib/pypi/LICENSE b/contrib/pypi/LICENSE
> new file mode 100644
> index 00000000..f9b44182
> --- /dev/null
> +++ b/contrib/pypi/LICENSE
> @@ -0,0 +1,9 @@
> +bitbake-setup is licensed under the GNU General Public License version 2=
.0. See
> +LICENSE.GPL-2.0-only for further details.
> +
> +Individual files contain the following style tags instead of the full li=
cense text:
> +
> +    SPDX-License-Identifier:   GPL-2.0-only
> +
> +This enables machine processing of license information based on the SPDX
> +License Identifiers that are here available: http://spdx.org/licenses/
> diff --git a/contrib/pypi/README.md b/contrib/pypi/README.md
> new file mode 100644
> index 00000000..a6dd99e0
> --- /dev/null
> +++ b/contrib/pypi/README.md
> @@ -0,0 +1,42 @@
> +# bitbake-setup
> +
> +This package provides the `bitbake-setup` command and the Python modules
> +required to support BitBake setup and configuration.
> +
> +## Usage
> +
> +Instructions on uses of bitbake-setup can be found in
> +[Setting Up the Environment With bitbake-setup](https://docs.yoctoprojec=
t.org/bitbake/dev/bitbake-user-manual/bitbake-user-manual-environment-setup=
.html) from the Yocto Project manual.
> +
> +List the available configurations;
> +```bash
> +bitbake-setup list
> +```
> +
> +Show the help for the bitbake-setup init subcommand:
> +```bash
> +bitbake-setup init --help
> +usage: bitbake-setup init [-h] [--non-interactive] [--source-overrides S=
OURCE_OVERRIDES] [--setup-dir-name SETUP_DIR_NAME] [--skip-selection SKIP_S=
ELECTION] [-L SOURCE_NAME PATH]
> +                          [config ...]
> +
> +positional arguments:
> +  config                path/URL/id to a configuration file (use 'list' =
command to get available ids), followed by configuration options. Bitbake-s=
etup will ask to choose from available
> +                        choices if command line doesn't completely speci=
fy them.
> +
> +options:
> +  -h, --help            show this help message and exit
> +  --non-interactive     Do not ask to interactively choose from availabl=
e options; if bitbake-setup cannot make a decision it will stop with a fail=
ure.
> +  --source-overrides SOURCE_OVERRIDES
> +                        Override sources information (repositories/revis=
ions) with values from a local json file.
> +  --setup-dir-name SETUP_DIR_NAME
> +                        A custom setup directory name under the top dire=
ctory.
> +  --skip-selection SKIP_SELECTION
> +                        Do not select and set an option/fragment from av=
ailable choices; the resulting bitbake configuration may be incomplete.
> +  -L SOURCE_NAME PATH, --use-local-source SOURCE_NAME PATH
> +                        Symlink local source into a build, instead of ge=
tting it as prescribed by a configuration (useful for local development).
> +```
> +
> +To initialize a workspace for the Poky reference distro using the develo=
pment branch (ie. "master") of OpenEmbedded:
> +```bash
> +bitbake-setup init poky-master
> +```
> \ No newline at end of file
> diff --git a/contrib/pypi/noxfile.py b/contrib/pypi/noxfile.py
> new file mode 100644
> index 00000000..ab226547
> --- /dev/null
> +++ b/contrib/pypi/noxfile.py
> @@ -0,0 +1,30 @@
> +#!/usr/bin/env python3
> +
> +import glob
> +import nox
> +from pathlib import Path
> +
> +nox.options.sessions =3D ["lint", "tests", "build"]
> +
> +@nox.session
> +def lint(session):
> +    session.install("ruff", "mypy")
> +    session.run("ruff", "check", "src/bitbake_setup")
> +    # Ignore mypy for now as there are too many errors in imported modul=
es
> +    # session.run("mypy", "src/bitbake_setup")
> +
> +@nox.session
> +def tests(session):
> +    session.install(".[test]")
> +    session.run("pytest")
> +
> +@nox.session
> +def build(session):
> +    session.install("build", "twine")
> +    session.run("python", "-m", "build")
> +
> +    # Verify the wheel installs cleanly
> +    wheels =3D list(Path("dist").glob("*.whl"))
> +    session.install(str(wheels[0]))
> +    session.run("bitbake-setup", "--help")
> +    session.run("bitbake-setup", "list")
> \ No newline at end of file
> diff --git a/contrib/pypi/package-bitbake-setup.py b/contrib/pypi/package=
-bitbake-setup.py
> new file mode 100755
> index 00000000..3a07e911
> --- /dev/null
> +++ b/contrib/pypi/package-bitbake-setup.py
> @@ -0,0 +1,93 @@
> +#!/usr/bin/env python3
> +
> +import argparse
> +import logging
> +import os
> +import shutil
> +from pathlib import Path
> +
> +def create_packaging_workspace(directory):
> +    # Create the directory for packaging workspace
> +    if len(directory or "") > 0:
> +        workspace_dir =3D Path(directory)
> +    else:
> +        # This script is located in contrib/pypi/package-bitbake-setup.p=
y
> +        workspace_dir =3D Path(__file__).parents[2] / "packaging_workspa=
ce"
> +
> +    if not workspace_dir.exists():
> +        logging.debug(f"Created packaging workspace at: {workspace_dir}"=
)
> +        workspace_dir.mkdir(exist_ok=3DTrue)
> +    else:
> +        logging.debug(f"Packaging workspace already exists at: {workspac=
e_dir}")
> +
> +    # Copy packaging files to the workspace
> +    files_to_copy =3D [
> +        "contrib/pypi/pyproject.toml",
> +        "contrib/pypi/README.md",
> +        "contrib/pypi/LICENSE",
> +        "contrib/pypi/noxfile.py",
> +        "LICENSE.MIT",
> +        "LICENSE.GPL-2.0-only"
> +    ]
> +
> +    for file in files_to_copy:
> +        src_path =3D Path(__file__).parents[2] / file
> +        dest_path =3D workspace_dir / Path(file).name
> +
> +        if src_path.is_dir():
> +            shutil.copytree(src_path, dest_path, dirs_exist_ok=3DTrue)
> +            logging.debug(f"Copied directory: {src_path} to {dest_path}"=
)
> +        else:
> +            shutil.copy2(src_path, dest_path)
> +            logging.debug(f"Copied file: {src_path} to {dest_path}")
> +
> +
> +    # Copy necessary modules to the workspace
> +    modules_to_copy =3D [
> +        "lib/bb",
> +        "lib/bs4",
> +        "lib/ply"
> +    ]
> +
> +    for module in modules_to_copy:
> +        src_path =3D Path(__file__).parents[2] / module
> +        dest_path =3D workspace_dir / "src" / Path(module).name
> +
> +        if src_path.is_dir():
> +            shutil.copytree(src_path, dest_path, dirs_exist_ok=3DTrue)
> +            logging.debug(f"Copied module directory: {src_path} to {dest=
_path}")
> +        else:
> +            shutil.copy2(src_path, dest_path)
> +            logging.debug(f"Copied module file: {src_path} to {dest_path=
}")
> +
> +    # Create bitbake_setup module
> +    bitbake_setup_dir =3D Path(workspace_dir / "src" / "bitbake_setup")
> +    bitbake_setup_dir.mkdir(exist_ok=3DTrue)
> +    Path(bitbake_setup_dir / "__init__.py").touch()
> +    shutil.copy2(Path(__file__).parents[2] / "bin" / "bitbake-setup", st=
r(bitbake_setup_dir / "__main__.py"))
> +
> +    # Create codegen module
> +    codegen_dir =3D Path(workspace_dir / "src" / "codegen")
> +    codegen_dir.mkdir(exist_ok=3DTrue)
> +    Path(codegen_dir / "__init__.py").touch()
> +    shutil.copy2(Path(__file__).parents[2] / "lib" / "codegen.py", str(c=
odegen_dir / "__main__.py"))
> +
> +    # Copy tests
> +    tests_dir =3D Path(workspace_dir / "tests")
> +    tests_dir.mkdir(exist_ok=3DTrue)
> +    shutil.copytree(Path(__file__).parents[2] / "contrib" / "pypi" / "te=
sts", str(tests_dir), dirs_exist_ok=3DTrue)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    logging.basicConfig(level=3Dlogging.INFO, format=3D'%(asctime)s - %(=
levelname)s - %(message)s')
> +
> +    parser =3D argparse.ArgumentParser(description=3D'Package bitbake-se=
tup for PyPI')
> +    parser.add_argument('-v', '--verbose', action=3D'store_true', help=
=3D'increase output verbosity.')
> +    parser.add_argument('-d', '--directory', type=3Dstr, help=3D'specify=
 the directory to create the packaging workspace in.')
> +
> +    args =3D parser.parse_args();
> +
> +    if args.verbose:
> +        logging.getLogger().setLevel(logging.DEBUG)
> +
> +    create_packaging_workspace(args.directory);
> diff --git a/contrib/pypi/pyproject.toml b/contrib/pypi/pyproject.toml
> new file mode 100644
> index 00000000..53d5ffc1
> --- /dev/null
> +++ b/contrib/pypi/pyproject.toml
> @@ -0,0 +1,97 @@
> +[build-system]
> +requires =3D [
> +    "setuptools>=3D64",
> +    "setuptools_scm[toml]>=3D8",
> +]
> +build-backend =3D "setuptools.build_meta"
> +
> +[project]
> +name =3D "bitbake-setup"
> +dynamic =3D ["version"]
> +description =3D "bitbake-setup"
> +readme =3D "README.md"
> +requires-python =3D ">=3D3.9"
> +license =3D "GPL-2.0-only AND MIT"
> +authors =3D [
> +  { name =3D "OpenEmbedded BitBake Developers", email =3D "bitbake-devel=
@lists.openembedded.org" }
> +]
> +classifiers =3D [
> +  "Programming Language :: Python :: 3",
> +  "Operating System :: POSIX :: Linux",
> +]
> +
> +dependencies =3D [
> +  # BitBake is mostly self-contained
> +]
> +
> +[project.optional-dependencies]
> +test =3D [
> +  "pytest>=3D7",
> +]
> +
> +lint =3D [
> +  "ruff>=3D0.3",
> +  "mypy>=3D1.8",
> +]
> +
> +dev =3D [
> +  "nox>=3D2022.11.21",
> +  "pytest>=3D7",
> +  "ruff>=3D0.3",
> +  "mypy>=3D1.8",
> +  "build",
> +  "twine",
> +]
> +
> +[project.scripts]
> +bitbake-setup =3D "bitbake_setup.__main__:main"
> +
> +[project.urls]
> +Homepage =3D "https://git.openembedded.org/bitbake/"
> +Documentation =3D "https://docs.yoctoproject.org/bitbake/dev/bitbake-use=
r-manual/"
> +Repository =3D "https://git.openembedded.org/bitbake/"
> +
> +[tool.mypy]
> +python_version =3D "3.9"
> +warn_unused_configs =3D true
> +ignore_missing_imports =3D true
> +no_implicit_optional =3D true
> +check_untyped_defs =3D false
> +
> +[tool.ruff]
> +target-version =3D "py39"
> +line-length =3D 88
> +src =3D ["src"]
> +
> +[tool.ruff.lint]
> +select =3D [
> +  "E",   # pycodestyle
> +  "F",   # pyflakes
> +  "B",   # flake8-bugbear
> +  "I",   # import sorting
> +]
> +ignore =3D [
> +  "E501",  # line length (handled by formatter)
> +]
> +
> +[tool.ruff.format]
> +quote-style =3D "double"
> +indent-style =3D "space"
> +
> +[tool.setuptools]
> +package-dir =3D { "" =3D "src" }
> +zip-safe =3D false
> +include-package-data =3D true
> +
> +[tool.setuptools.packages.find]
> +where =3D ["src"]
> +include =3D [
> +  "bb*",
> +  "bitbake_setup",
> +  "bs4*",
> +  "codegen",
> +  "ply"
> +]
> +
> +[tool.setuptools_scm]
> +fallback_version =3D "0.0.0"
> \ No newline at end of file
> diff --git a/contrib/pypi/tests/test_install.py b/contrib/pypi/tests/test=
_install.py
> new file mode 100644
> index 00000000..26c28261
> --- /dev/null
> +++ b/contrib/pypi/tests/test_install.py
> @@ -0,0 +1,17 @@
> +import subprocess
> +import sys
> +
> +def test_imports():
> +    import bb
> +    import bs4
> +    import ply
> +    import bitbake_setup
> +
> +def test_console_script():
> +    result =3D subprocess.run(
> +        ["bitbake-setup", "--help"],
> +        stdout=3Dsubprocess.PIPE,
> +        stderr=3Dsubprocess.PIPE,
> +        text=3DTrue,
> +    )
> +    assert result.returncode =3D=3D 0
> --
> 2.49.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18891): https://lists.openembedded.org/g/bitbake-deve=
l/message/18891
> Mute This Topic: https://lists.openembedded.org/mt/117490846/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

--_000_DM8PR11MB5655BCC1A88B3774C374959AE191ADM8PR11MB5655namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Hi Alex,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto"><span style=3D"font-family: Aptos, Aptos_MSFontService, -=
apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color:=
 rgb(33, 33, 33);">Sure, I can look into extending the
</span><span style=3D"font-family: Aptos; font-size: 14.6667px; color: rgb(=
0, 0, 0); background-color: rgb(255, 255, 255); text-transform: none;">lib/=
bb/tests/setup.py.</span></div>
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px; color:=
 rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255); text-transform: none;"=
><br>
</span></div>
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px; color:=
 rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255); text-transform: none;"=
>There are system tests using pytest and nox.&nbsp; The 2 pytests confirm t=
hat all the imports succeed and that bitbake-setup --help returns 0.</span>=
</div>
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px; color:=
 rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255); text-transform: none;"=
><br>
</span></div>
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px; color:=
 rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255); text-transform: none;"=
>Nox runs the pytests as well as bitbake-setup --help and bitbake-setup lis=
t.</span></div>
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px; color:=
 rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255); text-transform: none;"=
><br>
</span></div>
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px; color:=
 rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255); text-transform: none;"=
>&nbsp;Should I replace the nox tests with pytest or create new tests?</spa=
n></div>
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px; color:=
 rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255); text-transform: none;"=
><br>
</span></div>
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px; color:=
 rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255); text-transform: none;"=
>Regards,</span></div>
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px; color:=
 rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255); text-transform: none;"=
>Rob</span></div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, =
-apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"font-family: =
Aptos, Aptos_MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-s=
erif; font-size: 12pt;">
<span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robo=
to, Arial, Helvetica, sans-serif; font-size: 12pt;">Get
</span><a href=3D"https://aka.ms/AAb9ysg" style=3D"font-family: Aptos, Apto=
s_MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-=
size: 12pt;">Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alexander Kanavin &lt=
;alex.kanavin@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, January 28, 2026 7:26:46 AM<br>
<b>To:</b> Woolley, Rob &lt;Rob.Woolley@windriver.com&gt;<br>
<b>Cc:</b> bitbake-devel@lists.openembedded.org &lt;bitbake-devel@lists.ope=
nembedded.org&gt;<br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH v2 02/10] bitbake-setup: Add pyp=
i packaging</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">CAUTION: This email comes from a non Wind River em=
ail account!<br>
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.<br>
<br>
Thanks! This does look much cleaner, my only concern is that there are<br>
no tests. Is it possible to produce the .whl such that the steps and<br>
the output are contained entirely in some temporary location, or (less<br>
good) bitbake repo itself, e.g. nothing gets written in $HOME? I see<br>
that contrib/pypi/package-bitbake-setup.py takes a -d parameter, so<br>
perhaps that could be used?<br>
<br>
I'd really like to extend lib/bb/tests/setup.py with a new class (e.g.<br>
PypiTest) that does it.<br>
<br>
Alex<br>
<br>
On Tue, 27 Jan 2026 at 17:05, Rob Woolley via lists.openembedded.org<br>
&lt;rob.woolley=3Dwindriver.com@lists.openembedded.org&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Rob Woolley &lt;rob.woolley@windriver.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; .gitignore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&gt;&nbsp; contrib/pypi/BUILD.md&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 57 ++++++++++++++++=
<br>
&gt;&nbsp; contrib/pypi/LICENSE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 +++<br=
>
&gt;&nbsp; contrib/pypi/README.md&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 42 ++++++++++++<br>
&gt;&nbsp; contrib/pypi/noxfile.py&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 30 +++++++++<br>
&gt;&nbsp; contrib/pypi/package-bitbake-setup.py | 93 +++++++++++++++++++++=
++++<br>
&gt;&nbsp; contrib/pypi/pyproject.toml&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; | 97 +++++++++++++++++++++++++++<br>
&gt;&nbsp; contrib/pypi/tests/test_install.py&nbsp;&nbsp;&nbsp; | 17 +++++<=
br>
&gt;&nbsp; 8 files changed, 346 insertions(+)<br>
&gt;&nbsp; create mode 100644 contrib/pypi/BUILD.md<br>
&gt;&nbsp; create mode 100644 contrib/pypi/LICENSE<br>
&gt;&nbsp; create mode 100644 contrib/pypi/README.md<br>
&gt;&nbsp; create mode 100644 contrib/pypi/noxfile.py<br>
&gt;&nbsp; create mode 100755 contrib/pypi/package-bitbake-setup.py<br>
&gt;&nbsp; create mode 100644 contrib/pypi/pyproject.toml<br>
&gt;&nbsp; create mode 100644 contrib/pypi/tests/test_install.py<br>
&gt;<br>
&gt; diff --git a/.gitignore b/.gitignore<br>
&gt; index a6a256b2..9a5c4ec4 100644<br>
&gt; --- a/.gitignore<br>
&gt; +++ b/.gitignore<br>
&gt; @@ -17,3 +17,4 @@ lib/toaster/contrib/tts/backlog.txt<br>
&gt;&nbsp; lib/toaster/contrib/tts/log/*<br>
&gt;&nbsp; lib/toaster/contrib/tts/.cache/*<br>
&gt;&nbsp; lib/bb/tests/runqueue-tests/bitbake-cookerdaemon.log<br>
&gt; +packaging_workspace/<br>
&gt; diff --git a/contrib/pypi/BUILD.md b/contrib/pypi/BUILD.md<br>
&gt; new file mode 100644<br>
&gt; index 00000000..3c50b6e1<br>
&gt; --- /dev/null<br>
&gt; +++ b/contrib/pypi/BUILD.md<br>
&gt; @@ -0,0 +1,57 @@<br>
&gt; +# Development Instructions<br>
&gt; +<br>
&gt; +## Requirements<br>
&gt; +<br>
&gt; +- Python &gt;=3D 3.9<br>
&gt; +- pip &gt;=3D 19 (for installation)<br>
&gt; +- git (for SCM-based versioning)<br>
&gt; +<br>
&gt; +## Automated testing<br>
&gt; +<br>
&gt; +The steps to lint, build, and test the bitbake-setup pypi packaging h=
ave been automated with the nox tool.&nbsp; This tool automatically creates=
 a Python virtual environment for you.<br>
&gt; +<br>
&gt; +To run the linters do:<br>
&gt; +```bash<br>
&gt; +nox -s lint<br>
&gt; +```<br>
&gt; +<br>
&gt; +To run the build do:<br>
&gt; +```bash<br>
&gt; +nox -s build<br>
&gt; +```<br>
&gt; +<br>
&gt; +To run the tests do:<br>
&gt; +```bash<br>
&gt; +nox -s tests<br>
&gt; +```<br>
&gt; +<br>
&gt; +## Manual Steps<br>
&gt; +<br>
&gt; +### Building<br>
&gt; +<br>
&gt; +To install the development tools manually run:<br>
&gt; +```bash<br>
&gt; +python3 -m pip install -e '.[dev]'<br>
&gt; +```<br>
&gt; +<br>
&gt; +To build a wheel (.whl) then use:<br>
&gt; +```bash<br>
&gt; +python3 -m build<br>
&gt; +```<br>
&gt; +<br>
&gt; +This produces a wheel (.whl) file in the dist directory.&nbsp; This m=
ay be installed using pip.<br>
&gt; +<br>
&gt; +### Testing<br>
&gt; +<br>
&gt; +```bash<br>
&gt; +python3 -m pip install -e '.[test]'<br>
&gt; +pytest<br>
&gt; +```<br>
&gt; +<br>
&gt; +### Linting<br>
&gt; +<br>
&gt; +```bash<br>
&gt; +python3 -m pip install -e '.[lint]'<br>
&gt; +<br>
&gt; +ruff check src/bitbake_setup<br>
&gt; +```<br>
&gt; \ No newline at end of file<br>
&gt; diff --git a/contrib/pypi/LICENSE b/contrib/pypi/LICENSE<br>
&gt; new file mode 100644<br>
&gt; index 00000000..f9b44182<br>
&gt; --- /dev/null<br>
&gt; +++ b/contrib/pypi/LICENSE<br>
&gt; @@ -0,0 +1,9 @@<br>
&gt; +bitbake-setup is licensed under the GNU General Public License versio=
n 2.0. See<br>
&gt; +LICENSE.GPL-2.0-only for further details.<br>
&gt; +<br>
&gt; +Individual files contain the following style tags instead of the full=
 license text:<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; SPDX-License-Identifier:&nbsp;&nbsp; GPL-2.0-only<=
br>
&gt; +<br>
&gt; +This enables machine processing of license information based on the S=
PDX<br>
&gt; +License Identifiers that are here available: <a href=3D"http://spdx.o=
rg/licenses/">
http://spdx.org/licenses/</a><br>
&gt; diff --git a/contrib/pypi/README.md b/contrib/pypi/README.md<br>
&gt; new file mode 100644<br>
&gt; index 00000000..a6dd99e0<br>
&gt; --- /dev/null<br>
&gt; +++ b/contrib/pypi/README.md<br>
&gt; @@ -0,0 +1,42 @@<br>
&gt; +# bitbake-setup<br>
&gt; +<br>
&gt; +This package provides the `bitbake-setup` command and the Python modu=
les<br>
&gt; +required to support BitBake setup and configuration.<br>
&gt; +<br>
&gt; +## Usage<br>
&gt; +<br>
&gt; +Instructions on uses of bitbake-setup can be found in<br>
&gt; +[Setting Up the Environment With bitbake-setup](<a href=3D"https://do=
cs.yoctoproject.org/bitbake/dev/bitbake-user-manual/bitbake-user-manual-env=
ironment-setup.html">https://docs.yoctoproject.org/bitbake/dev/bitbake-user=
-manual/bitbake-user-manual-environment-setup.html</a>)
 from the Yocto Project manual.<br>
&gt; +<br>
&gt; +List the available configurations;<br>
&gt; +```bash<br>
&gt; +bitbake-setup list<br>
&gt; +```<br>
&gt; +<br>
&gt; +Show the help for the bitbake-setup init subcommand:<br>
&gt; +```bash<br>
&gt; +bitbake-setup init --help<br>
&gt; +usage: bitbake-setup init [-h] [--non-interactive] [--source-override=
s SOURCE_OVERRIDES] [--setup-dir-name SETUP_DIR_NAME] [--skip-selection SKI=
P_SELECTION] [-L SOURCE_NAME PATH]<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; [config ...]<br>
&gt; +<br>
&gt; +positional arguments:<br>
&gt; +&nbsp; config&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path/URL/id to a configuration file (use=
 'list' command to get available ids), followed by configuration options. B=
itbake-setup will ask to choose from available<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; choic=
es if command line doesn't completely specify them.<br>
&gt; +<br>
&gt; +options:<br>
&gt; +&nbsp; -h, --help&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; show this help message and exit<br>
&gt; +&nbsp; --non-interactive&nbsp;&nbsp;&nbsp;&nbsp; Do not ask to intera=
ctively choose from available options; if bitbake-setup cannot make a decis=
ion it will stop with a failure.<br>
&gt; +&nbsp; --source-overrides SOURCE_OVERRIDES<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Overr=
ide sources information (repositories/revisions) with values from a local j=
son file.<br>
&gt; +&nbsp; --setup-dir-name SETUP_DIR_NAME<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A cus=
tom setup directory name under the top directory.<br>
&gt; +&nbsp; --skip-selection SKIP_SELECTION<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Do no=
t select and set an option/fragment from available choices; the resulting b=
itbake configuration may be incomplete.<br>
&gt; +&nbsp; -L SOURCE_NAME PATH, --use-local-source SOURCE_NAME PATH<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Symli=
nk local source into a build, instead of getting it as prescribed by a conf=
iguration (useful for local development).<br>
&gt; +```<br>
&gt; +<br>
&gt; +To initialize a workspace for the Poky reference distro using the dev=
elopment branch (ie. &quot;master&quot;) of OpenEmbedded:<br>
&gt; +```bash<br>
&gt; +bitbake-setup init poky-master<br>
&gt; +```<br>
&gt; \ No newline at end of file<br>
&gt; diff --git a/contrib/pypi/noxfile.py b/contrib/pypi/noxfile.py<br>
&gt; new file mode 100644<br>
&gt; index 00000000..ab226547<br>
&gt; --- /dev/null<br>
&gt; +++ b/contrib/pypi/noxfile.py<br>
&gt; @@ -0,0 +1,30 @@<br>
&gt; +#!/usr/bin/env python3<br>
&gt; +<br>
&gt; +import glob<br>
&gt; +import nox<br>
&gt; +from pathlib import Path<br>
&gt; +<br>
&gt; +nox.options.sessions =3D [&quot;lint&quot;, &quot;tests&quot;, &quot;=
build&quot;]<br>
&gt; +<br>
&gt; +@nox.session<br>
&gt; +def lint(session):<br>
&gt; +&nbsp;&nbsp;&nbsp; session.install(&quot;ruff&quot;, &quot;mypy&quot;=
)<br>
&gt; +&nbsp;&nbsp;&nbsp; session.run(&quot;ruff&quot;, &quot;check&quot;, &=
quot;src/bitbake_setup&quot;)<br>
&gt; +&nbsp;&nbsp;&nbsp; # Ignore mypy for now as there are too many errors=
 in imported modules<br>
&gt; +&nbsp;&nbsp;&nbsp; # session.run(&quot;mypy&quot;, &quot;src/bitbake_=
setup&quot;)<br>
&gt; +<br>
&gt; +@nox.session<br>
&gt; +def tests(session):<br>
&gt; +&nbsp;&nbsp;&nbsp; session.install(&quot;.[test]&quot;)<br>
&gt; +&nbsp;&nbsp;&nbsp; session.run(&quot;pytest&quot;)<br>
&gt; +<br>
&gt; +@nox.session<br>
&gt; +def build(session):<br>
&gt; +&nbsp;&nbsp;&nbsp; session.install(&quot;build&quot;, &quot;twine&quo=
t;)<br>
&gt; +&nbsp;&nbsp;&nbsp; session.run(&quot;python&quot;, &quot;-m&quot;, &q=
uot;build&quot;)<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; # Verify the wheel installs cleanly<br>
&gt; +&nbsp;&nbsp;&nbsp; wheels =3D list(Path(&quot;dist&quot;).glob(&quot;=
*.whl&quot;))<br>
&gt; +&nbsp;&nbsp;&nbsp; session.install(str(wheels[0]))<br>
&gt; +&nbsp;&nbsp;&nbsp; session.run(&quot;bitbake-setup&quot;, &quot;--hel=
p&quot;)<br>
&gt; +&nbsp;&nbsp;&nbsp; session.run(&quot;bitbake-setup&quot;, &quot;list&=
quot;)<br>
&gt; \ No newline at end of file<br>
&gt; diff --git a/contrib/pypi/package-bitbake-setup.py b/contrib/pypi/pack=
age-bitbake-setup.py<br>
&gt; new file mode 100755<br>
&gt; index 00000000..3a07e911<br>
&gt; --- /dev/null<br>
&gt; +++ b/contrib/pypi/package-bitbake-setup.py<br>
&gt; @@ -0,0 +1,93 @@<br>
&gt; +#!/usr/bin/env python3<br>
&gt; +<br>
&gt; +import argparse<br>
&gt; +import logging<br>
&gt; +import os<br>
&gt; +import shutil<br>
&gt; +from pathlib import Path<br>
&gt; +<br>
&gt; +def create_packaging_workspace(directory):<br>
&gt; +&nbsp;&nbsp;&nbsp; # Create the directory for packaging workspace<br>
&gt; +&nbsp;&nbsp;&nbsp; if len(directory or &quot;&quot;) &gt; 0:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; workspace_dir =3D Path(dir=
ectory)<br>
&gt; +&nbsp;&nbsp;&nbsp; else:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # This script is located i=
n contrib/pypi/package-bitbake-setup.py<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; workspace_dir =3D Path(__f=
ile__).parents[2] / &quot;packaging_workspace&quot;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; if not workspace_dir.exists():<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logging.debug(f&quot;Creat=
ed packaging workspace at: {workspace_dir}&quot;)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; workspace_dir.mkdir(exist_=
ok=3DTrue)<br>
&gt; +&nbsp;&nbsp;&nbsp; else:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logging.debug(f&quot;Packa=
ging workspace already exists at: {workspace_dir}&quot;)<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; # Copy packaging files to the workspace<br>
&gt; +&nbsp;&nbsp;&nbsp; files_to_copy =3D [<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;contrib/pypi/pyproje=
ct.toml&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;contrib/pypi/README.=
md&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;contrib/pypi/LICENSE=
&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;contrib/pypi/noxfile=
.py&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;LICENSE.MIT&quot;,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;LICENSE.GPL-2.0-only=
&quot;<br>
&gt; +&nbsp;&nbsp;&nbsp; ]<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; for file in files_to_copy:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src_path =3D Path(__file__=
).parents[2] / file<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dest_path =3D workspace_di=
r / Path(file).name<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if src_path.is_dir():<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sh=
util.copytree(src_path, dest_path, dirs_exist_ok=3DTrue)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lo=
gging.debug(f&quot;Copied directory: {src_path} to {dest_path}&quot;)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sh=
util.copy2(src_path, dest_path)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lo=
gging.debug(f&quot;Copied file: {src_path} to {dest_path}&quot;)<br>
&gt; +<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; # Copy necessary modules to the workspace<br>
&gt; +&nbsp;&nbsp;&nbsp; modules_to_copy =3D [<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;lib/bb&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;lib/bs4&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;lib/ply&quot;<br>
&gt; +&nbsp;&nbsp;&nbsp; ]<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; for module in modules_to_copy:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src_path =3D Path(__file__=
).parents[2] / module<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dest_path =3D workspace_di=
r / &quot;src&quot; / Path(module).name<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if src_path.is_dir():<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sh=
util.copytree(src_path, dest_path, dirs_exist_ok=3DTrue)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lo=
gging.debug(f&quot;Copied module directory: {src_path} to {dest_path}&quot;=
)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sh=
util.copy2(src_path, dest_path)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lo=
gging.debug(f&quot;Copied module file: {src_path} to {dest_path}&quot;)<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; # Create bitbake_setup module<br>
&gt; +&nbsp;&nbsp;&nbsp; bitbake_setup_dir =3D Path(workspace_dir / &quot;s=
rc&quot; / &quot;bitbake_setup&quot;)<br>
&gt; +&nbsp;&nbsp;&nbsp; bitbake_setup_dir.mkdir(exist_ok=3DTrue)<br>
&gt; +&nbsp;&nbsp;&nbsp; Path(bitbake_setup_dir / &quot;__init__.py&quot;).=
touch()<br>
&gt; +&nbsp;&nbsp;&nbsp; shutil.copy2(Path(__file__).parents[2] / &quot;bin=
&quot; / &quot;bitbake-setup&quot;, str(bitbake_setup_dir / &quot;__main__.=
py&quot;))<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; # Create codegen module<br>
&gt; +&nbsp;&nbsp;&nbsp; codegen_dir =3D Path(workspace_dir / &quot;src&quo=
t; / &quot;codegen&quot;)<br>
&gt; +&nbsp;&nbsp;&nbsp; codegen_dir.mkdir(exist_ok=3DTrue)<br>
&gt; +&nbsp;&nbsp;&nbsp; Path(codegen_dir / &quot;__init__.py&quot;).touch(=
)<br>
&gt; +&nbsp;&nbsp;&nbsp; shutil.copy2(Path(__file__).parents[2] / &quot;lib=
&quot; / &quot;codegen.py&quot;, str(codegen_dir / &quot;__main__.py&quot;)=
)<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; # Copy tests<br>
&gt; +&nbsp;&nbsp;&nbsp; tests_dir =3D Path(workspace_dir / &quot;tests&quo=
t;)<br>
&gt; +&nbsp;&nbsp;&nbsp; tests_dir.mkdir(exist_ok=3DTrue)<br>
&gt; +&nbsp;&nbsp;&nbsp; shutil.copytree(Path(__file__).parents[2] / &quot;=
contrib&quot; / &quot;pypi&quot; / &quot;tests&quot;, str(tests_dir), dirs_=
exist_ok=3DTrue)<br>
&gt; +<br>
&gt; +<br>
&gt; +if __name__ =3D=3D &quot;__main__&quot;:<br>
&gt; +&nbsp;&nbsp;&nbsp; logging.basicConfig(level=3Dlogging.INFO, format=
=3D'%(asctime)s - %(levelname)s - %(message)s')<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; parser =3D argparse.ArgumentParser(description=3D'=
Package bitbake-setup for PyPI')<br>
&gt; +&nbsp;&nbsp;&nbsp; parser.add_argument('-v', '--verbose', action=3D's=
tore_true', help=3D'increase output verbosity.')<br>
&gt; +&nbsp;&nbsp;&nbsp; parser.add_argument('-d', '--directory', type=3Dst=
r, help=3D'specify the directory to create the packaging workspace in.')<br=
>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; args =3D parser.parse_args();<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; if args.verbose:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logging.getLogger().setLev=
el(logging.DEBUG)<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; create_packaging_workspace(args.directory);<br>
&gt; diff --git a/contrib/pypi/pyproject.toml b/contrib/pypi/pyproject.toml=
<br>
&gt; new file mode 100644<br>
&gt; index 00000000..53d5ffc1<br>
&gt; --- /dev/null<br>
&gt; +++ b/contrib/pypi/pyproject.toml<br>
&gt; @@ -0,0 +1,97 @@<br>
&gt; +[build-system]<br>
&gt; +requires =3D [<br>
&gt; +&nbsp;&nbsp;&nbsp; &quot;setuptools&gt;=3D64&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp; &quot;setuptools_scm[toml]&gt;=3D8&quot;,<br>
&gt; +]<br>
&gt; +build-backend =3D &quot;setuptools.build_meta&quot;<br>
&gt; +<br>
&gt; +[project]<br>
&gt; +name =3D &quot;bitbake-setup&quot;<br>
&gt; +dynamic =3D [&quot;version&quot;]<br>
&gt; +description =3D &quot;bitbake-setup&quot;<br>
&gt; +readme =3D &quot;README.md&quot;<br>
&gt; +requires-python =3D &quot;&gt;=3D3.9&quot;<br>
&gt; +license =3D &quot;GPL-2.0-only AND MIT&quot;<br>
&gt; +authors =3D [<br>
&gt; +&nbsp; { name =3D &quot;OpenEmbedded BitBake Developers&quot;, email =
=3D &quot;bitbake-devel@lists.openembedded.org&quot; }<br>
&gt; +]<br>
&gt; +classifiers =3D [<br>
&gt; +&nbsp; &quot;Programming Language :: Python :: 3&quot;,<br>
&gt; +&nbsp; &quot;Operating System :: POSIX :: Linux&quot;,<br>
&gt; +]<br>
&gt; +<br>
&gt; +dependencies =3D [<br>
&gt; +&nbsp; # BitBake is mostly self-contained<br>
&gt; +]<br>
&gt; +<br>
&gt; +[project.optional-dependencies]<br>
&gt; +test =3D [<br>
&gt; +&nbsp; &quot;pytest&gt;=3D7&quot;,<br>
&gt; +]<br>
&gt; +<br>
&gt; +lint =3D [<br>
&gt; +&nbsp; &quot;ruff&gt;=3D0.3&quot;,<br>
&gt; +&nbsp; &quot;mypy&gt;=3D1.8&quot;,<br>
&gt; +]<br>
&gt; +<br>
&gt; +dev =3D [<br>
&gt; +&nbsp; &quot;nox&gt;=3D2022.11.21&quot;,<br>
&gt; +&nbsp; &quot;pytest&gt;=3D7&quot;,<br>
&gt; +&nbsp; &quot;ruff&gt;=3D0.3&quot;,<br>
&gt; +&nbsp; &quot;mypy&gt;=3D1.8&quot;,<br>
&gt; +&nbsp; &quot;build&quot;,<br>
&gt; +&nbsp; &quot;twine&quot;,<br>
&gt; +]<br>
&gt; +<br>
&gt; +[project.scripts]<br>
&gt; +bitbake-setup =3D &quot;bitbake_setup.__main__:main&quot;<br>
&gt; +<br>
&gt; +[project.urls]<br>
&gt; +Homepage =3D &quot;<a href=3D"https://git.openembedded.org/bitbake/">=
https://git.openembedded.org/bitbake/</a>&quot;<br>
&gt; +Documentation =3D &quot;<a href=3D"https://docs.yoctoproject.org/bitb=
ake/dev/bitbake-user-manual/">https://docs.yoctoproject.org/bitbake/dev/bit=
bake-user-manual/</a>&quot;<br>
&gt; +Repository =3D &quot;<a href=3D"https://git.openembedded.org/bitbake/=
">https://git.openembedded.org/bitbake/</a>&quot;<br>
&gt; +<br>
&gt; +[tool.mypy]<br>
&gt; +python_version =3D &quot;3.9&quot;<br>
&gt; +warn_unused_configs =3D true<br>
&gt; +ignore_missing_imports =3D true<br>
&gt; +no_implicit_optional =3D true<br>
&gt; +check_untyped_defs =3D false<br>
&gt; +<br>
&gt; +[tool.ruff]<br>
&gt; +target-version =3D &quot;py39&quot;<br>
&gt; +line-length =3D 88<br>
&gt; +src =3D [&quot;src&quot;]<br>
&gt; +<br>
&gt; +[tool.ruff.lint]<br>
&gt; +select =3D [<br>
&gt; +&nbsp; &quot;E&quot;,&nbsp;&nbsp; # pycodestyle<br>
&gt; +&nbsp; &quot;F&quot;,&nbsp;&nbsp; # pyflakes<br>
&gt; +&nbsp; &quot;B&quot;,&nbsp;&nbsp; # flake8-bugbear<br>
&gt; +&nbsp; &quot;I&quot;,&nbsp;&nbsp; # import sorting<br>
&gt; +]<br>
&gt; +ignore =3D [<br>
&gt; +&nbsp; &quot;E501&quot;,&nbsp; # line length (handled by formatter)<b=
r>
&gt; +]<br>
&gt; +<br>
&gt; +[tool.ruff.format]<br>
&gt; +quote-style =3D &quot;double&quot;<br>
&gt; +indent-style =3D &quot;space&quot;<br>
&gt; +<br>
&gt; +[tool.setuptools]<br>
&gt; +package-dir =3D { &quot;&quot; =3D &quot;src&quot; }<br>
&gt; +zip-safe =3D false<br>
&gt; +include-package-data =3D true<br>
&gt; +<br>
&gt; +[tool.setuptools.packages.find]<br>
&gt; +where =3D [&quot;src&quot;]<br>
&gt; +include =3D [<br>
&gt; +&nbsp; &quot;bb*&quot;,<br>
&gt; +&nbsp; &quot;bitbake_setup&quot;,<br>
&gt; +&nbsp; &quot;bs4*&quot;,<br>
&gt; +&nbsp; &quot;codegen&quot;,<br>
&gt; +&nbsp; &quot;ply&quot;<br>
&gt; +]<br>
&gt; +<br>
&gt; +[tool.setuptools_scm]<br>
&gt; +fallback_version =3D &quot;0.0.0&quot;<br>
&gt; \ No newline at end of file<br>
&gt; diff --git a/contrib/pypi/tests/test_install.py b/contrib/pypi/tests/t=
est_install.py<br>
&gt; new file mode 100644<br>
&gt; index 00000000..26c28261<br>
&gt; --- /dev/null<br>
&gt; +++ b/contrib/pypi/tests/test_install.py<br>
&gt; @@ -0,0 +1,17 @@<br>
&gt; +import subprocess<br>
&gt; +import sys<br>
&gt; +<br>
&gt; +def test_imports():<br>
&gt; +&nbsp;&nbsp;&nbsp; import bb<br>
&gt; +&nbsp;&nbsp;&nbsp; import bs4<br>
&gt; +&nbsp;&nbsp;&nbsp; import ply<br>
&gt; +&nbsp;&nbsp;&nbsp; import bitbake_setup<br>
&gt; +<br>
&gt; +def test_console_script():<br>
&gt; +&nbsp;&nbsp;&nbsp; result =3D subprocess.run(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&quot;bitbake-setup&quot;=
, &quot;--help&quot;],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stdout=3Dsubprocess.PIPE,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stderr=3Dsubprocess.PIPE,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; text=3DTrue,<br>
&gt; +&nbsp;&nbsp;&nbsp; )<br>
&gt; +&nbsp;&nbsp;&nbsp; assert result.returncode =3D=3D 0<br>
&gt; --<br>
&gt; 2.49.0<br>
&gt;<br>
&gt;<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#18891): <a href=3D"https://lists.openembedded.org/=
g/bitbake-devel/message/18891">
https://lists.openembedded.org/g/bitbake-devel/message/18891</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/11749084=
6/1686489">
https://lists.openembedded.org/mt/117490846/1686489</a><br>
&gt; Group Owner: bitbake-devel+owner@lists.openembedded.org<br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel=
/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [alex.kana=
vin@gmail.com]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM8PR11MB5655BCC1A88B3774C374959AE191ADM8PR11MB5655namp_--

