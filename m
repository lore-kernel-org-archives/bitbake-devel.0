Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52A3CCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 08:28:04 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8691.1762936075468799650
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 00:27:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=pSaa9xKU;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3411d00e7a=david.reyna@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC5d4qJ2418514
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 08:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=qOtnJ44TtB5Xf226EZFJKyL06SbDEeahfwOMgbC/L2s=; b=pSaa9xKUHNIv
	4Ic+9iAqNR3ufVc6hRLq+CO4E6o5DWbpjKrJu5Fpjpk0fktlTKNWNq+pkpmy7bG0
	rxSxht+fbdaED8JJBEWXQ/Bn5Sktl1+XjxRNdyn3mr+RvU7MwxE1po+hTaL0pJ9I
	ExMwYTzR6yVxRMOAjD/unUdIWBEwrf6up/OYIbF024Ggd+OSiIVexo0KcOKWtYZ8
	PYLKG79XvjTsmfItRivvm3mmtPRywtKLlWsxH+/UKN46wGVzyO5fN+Job16lWbzX
	CkA56CA2EI2V0OjIdN0bl0p9nLMpaktqHdF4UNB+cZOBxbugRbgMfgIO16TGXbXB
	nsUL+tceqw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012027.outbound.protection.outlook.com [40.107.200.27])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a9vu94t1p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 08:27:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6krm4TurThrezkUv4a4gi5FdZ6dGgTLa15ddPIzV7oChjorJ/HDuS56L5mKVXuP8hx8/4q4LiFRjWScDr0IEYq2IflgqEI/DpuSZfEZnEKYEa6TC1Wl4Bd+HJjXRmDQNiwBHaEPsA0D+p/fxvF5JC6qomRR2OKCUr0Ry/6o+LZ+RXuQfk3XRYeRrKT/uRGgTVm1qDNZkiSoGzM2278KQyZtCXgVfb+PwXapVuwELlq0+UTNoY8sUQYcVDsZ8VfXc8hqqXdNSWUtwHxc6umOWRI13BQrlRe7XXcU2nzSDeeGCNetnQ9qxkygQMWH2joL3VXAZTtIa2+CvPPvdRNbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOtnJ44TtB5Xf226EZFJKyL06SbDEeahfwOMgbC/L2s=;
 b=ynxFbJPHP12Y/Jtiz4O3L/vpH8j08Mn+Tw6rmIr34Qg0MqzpJwYEBHfzIWXjY2TSgz9at/qY4LT1Bb1AV7HZu7tjnO7UnMp2S67xdKOFiYRyX3h7N+JNlRx8ZDtwly8/7/7MfhG2dgGmavnsF4s1AokQBpUFwnYkYZ6HAcxmonUBMVA3uFYAfRLHXPRK8bgw1w3eABoeQ0fhc4stabm1uPB8jdSgzoISRpjMh8hjOd3fEw2HV9DNKfh+ANQA5I06OFji2JmEPlFtH1iV2lX8h3Z7bhqrkC+FBam9SrdOVC5Y/eCMAWygW18bKQ3h1C8iqEG+e7cBAk0c3w1sj1UKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5)
 by BL4PR11MB8848.namprd11.prod.outlook.com (2603:10b6:208:5a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 08:27:50 +0000
Received: from IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::bad7:2979:d07b:ccd8]) by IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::bad7:2979:d07b:ccd8%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:27:47 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [bitbake-devel][PATCH] toaster: remove dependency on poky distro
Thread-Topic: [bitbake-devel][PATCH] toaster: remove dependency on poky distro
Thread-Index: AdxTrfmEPZ7NmOYcSfyQYZc+agZ0IQ==
Date: Wed, 12 Nov 2025 08:27:47 +0000
Message-ID: 
 <IA1PR11MB76778274C592752D2D2E9993EACCA@IA1PR11MB7677.namprd11.prod.outlook.com>
References: <20251030141904.69494-1-JPEWhacker@gmail.com>
 <18736230F0A57013.18972@lists.openembedded.org>
In-Reply-To: <18736230F0A57013.18972@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=9667a3ba-c71c-4012-aeaf-597ab9cc4b43;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-10-30T21:21:41Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7677:EE_|BL4PR11MB8848:EE_
x-ms-office365-filtering-correlation-id: 756f85b1-25e2-4bd9-2771-08de21c55c8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?EFrRCwEnL4nDvPQKeAUpcdAnrlnK7IvwkmICe0n1bH5oyAA05jAXdr/RakFv?=
 =?us-ascii?Q?bs8YXk/90EzJqCSYJFc2w5P/MQqcC/hswmNg4GxrgbOPHVQmQ6ZvGtACJMC0?=
 =?us-ascii?Q?TLKlyKf/XoEPILoqgSL+n6rp67JbXO5VeuuyQ2wRPiuaTFExrqYv3y11jX1W?=
 =?us-ascii?Q?+XGyuW6IVTU+Ekv7hKnrtOC87VEKDR9Q1n3a+R9GxelXU4Qo0mKkCL9bvFhJ?=
 =?us-ascii?Q?N5zlXKpgN/XzOam5CTq1RaSPbaIslTu65WqQ2namlb0mGTMmJcDXG9P6h0Rd?=
 =?us-ascii?Q?OOEkURNma2vcdBTsKRVK4a031SieFF+aRMA7HPwnR/77T3+c8rRpTEAei1Wv?=
 =?us-ascii?Q?fxsSqpB62knTsWPgZ9lCRdSivgD8PPI1YAOveDD5rrE5Zn0jxBWN9CUov2GK?=
 =?us-ascii?Q?1Bda6Xk7oSbcnXhlOIBAy8xijcPad8bOuYB3Fd1OfTlQDFubSBLvgOcMGeMT?=
 =?us-ascii?Q?KMA+Zahkgo+XUsIxMO+GeUyw4tbFdo6LZAoMT3+fJUSXi4BKNzR7vxOTLQ4w?=
 =?us-ascii?Q?fokVXoPPsS8kpp9om1zbuadls+XJGiyi6A+2nAxwpwAb6MqWqOwfovqreQmH?=
 =?us-ascii?Q?ahO90MsdYmsBXkLX6zhMMQsqAXyKhocO13zBzzygNLGYZNuu3gP8IBBQ7lMk?=
 =?us-ascii?Q?KVPyHPdfa0k9b4q50wnEMvKy5gEHzPGf61B0TlmcpvXTwL0y/pcP0Uoj+GHi?=
 =?us-ascii?Q?/XgSdwIU+RCNGgPMIsVUWHCMOlmk0dJEWEckdmHmDxoKM7TO0jT0x0tEchEb?=
 =?us-ascii?Q?1jx0LftVwEiLo6aUlwLefeHlOh3eAytQxK7KbRNJoLH8gZDnbTnJRFeW0ega?=
 =?us-ascii?Q?hWBqhRRhVuTAaOeMeE3YBurnCP9fnNrQ3c8W0WqtyP3tMGTvWTOPg5DFNHi3?=
 =?us-ascii?Q?DkTDAa++8Cv8rNdXgZNCoFcR5cCqephZLnaKXx1AZYNVbikmvs0f7xOGckt6?=
 =?us-ascii?Q?/jnWpv9hSrtE/CUpU06uAL6LcVxlf0wZL6zSYFaAIYixnpLhl1m3iRLa7DKU?=
 =?us-ascii?Q?8oorwMXsFSvGgxU8hSzWKU9EMKb8ItoeWIMY3tuDjv7EULraHnJFD34utwdT?=
 =?us-ascii?Q?8GaRlqIWx5LNE+OH8WNc6NZC9ZxQyd/OkNiE7Q4Sz/t+QQMy6lasrEQkYiAE?=
 =?us-ascii?Q?ta6k2AvpuHGve1DK11QJaHVNC+9ddjWSI6KbjNNDTu0/+LArlmWocn2IiyVZ?=
 =?us-ascii?Q?UDdVeLf/8iR2+dkYtZTIWgumvfEhAmbFNcAaUM6UP0vcMEt8bhCiNdxnyPNq?=
 =?us-ascii?Q?h/kaO90OHAUcqXQFHdlFLgjU/o9q3maDZ1buXNhrL3kE8s++/Jz4OyyimKVP?=
 =?us-ascii?Q?ECct5P5mnOdsf17Tl044YT2Z5gIbGiq5zu9CHE92dgeI5EWCP8O51X20lQ+B?=
 =?us-ascii?Q?4NckOOfJMq/PfvWc2E9pQqjl5s6TBVTfyJY6a3Fzk7YEISvzkNQi0sHZ7RFI?=
 =?us-ascii?Q?j8ofyi/EiJqK8SJJu33/HZlwgvsyYu3BwzWerxl9bSL6IB66dUlv0oJEDghS?=
 =?us-ascii?Q?+u2J1euhY/mMN4QmVQQ0oSl8ORvqzoq4Ma7J?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7677.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7iwI9AokAY0KRwaGKuCel9+7lEfoHSprFQMn+ZktwLYmAOUgWgn+N87WhkRI?=
 =?us-ascii?Q?LOZAzsEz0X5j+Lx0To4QAkkRisQtGsdUNOtwrqSXBnpJepzTUldxeNMw3hlV?=
 =?us-ascii?Q?vnYXBaSLWOoLLgK/nTZtgBfuynoDhRawxC1hAOi5aMhGZAbaywviid8d1pds?=
 =?us-ascii?Q?IzD7g9ye7X33ZVyXnf+Fp7CYK9tb+VIPxpFbQNFA2xoBbJrNuHK08iw2+7Ip?=
 =?us-ascii?Q?n7MFUzP87hD6CIIA2L6JtjqlnsuOQOFVxwlsyCnuxMFs+EKH3uzjyp9XqjCu?=
 =?us-ascii?Q?vu9SPYUMdZ3wpfY563YGOIBxK+IORfEsGcq4M1y3GoeDHjtnFcfwAQ0/FTTk?=
 =?us-ascii?Q?db9J1qJ0n+W1DGkn2s5W3J6cpyCu1cQo8Kb9GVTiF39JpXUDHf9XQOWDEJBE?=
 =?us-ascii?Q?fKRbwlzJThXuLqJkPO73KHQx/FOsnoDVRM8uN30cc345XTJNpyFX20B2k+01?=
 =?us-ascii?Q?3zKOoXfUyI8UMcvhgTmCuszedhNbZSjyS0T8QqS75Tf85VfcBw2PMti3U5hl?=
 =?us-ascii?Q?eCpIyAoN5QvNUnZaO2DgyO9PW2MksK69BT7bTHDaqmP23bX8xx8WTe29zGMG?=
 =?us-ascii?Q?8C3zKsONtR6/oTGnKitM4Z2f/u3PVDnt2E1EeAy2D853pHLVOvFFvx095X28?=
 =?us-ascii?Q?mYc/UWAHVVyLuEpNPV6uuybp09yepHu/w+w8pAtnB9lYOfzDXzYzRT7LgL6c?=
 =?us-ascii?Q?sD0IMG5AyA90sBQV5hBVOtib5wqMTB36U6ymAqr4RmXwjjWuw9FJz1INQQm9?=
 =?us-ascii?Q?m1ybEU7gouQV2G+Y04QPDieaEQPs+vjW3zqdFz/kQB8fbWBFnf5WY0lX7IGz?=
 =?us-ascii?Q?53brfVbMVoJCO3Tcku/e4gw+wOVXkdUIl3wANxOqaZ6JUz14B17x9W7HSMEZ?=
 =?us-ascii?Q?yQaqPDheaPoYPfRzuryfvwgiSXPDlCZANct0zx3FBjRL3yRuP1wK3XXVBOG6?=
 =?us-ascii?Q?RlYskwSG82iVWPttq4KaqTPeyUVltOGVVU8FS5+MS+KPo88W2XWAwQDEdy2i?=
 =?us-ascii?Q?txVY7xbOgDnq6EJQ8ceyxZu1vyHqtYAkpatoo/BvuVy7HwwdU8ltVpQ7ehh3?=
 =?us-ascii?Q?UgaeLdiGZGuLm84obElL5e5eeWYSnQEzPpfYroxJ+gZgqRIr/gpJHNoVWSqL?=
 =?us-ascii?Q?WfGvyfXTf2nZ7ULjUQoHl0D7Cck8VlYiL52mRdwikUlGtqPNJ8OE11jqCqJp?=
 =?us-ascii?Q?/k/Ssvmrk5E0TWaRASzPDQhqOdUf0h9dki/OOeQBDKcDU13fPBP/qLKAlEu4?=
 =?us-ascii?Q?y0sMUebiWUVjgNV4lhe9EyKaNLNby22Kf9L3WTZtPRtxAQ0DuMytYhX/q7w8?=
 =?us-ascii?Q?Pch+etfZWxz+cOhmBd3+rHHs8ToTJpfhL3iYFLLPcjL3E4SR+lRg7oi7uq16?=
 =?us-ascii?Q?FPqWFL/5eU9AjvkKEZPY1tjcOcsmGShifqMg7hmX+aliD7hxs1Gk5l1CItC1?=
 =?us-ascii?Q?egy6i0/1RfjBOhAtXgTtZw4sQCyykXfFP80Zj+9n0pQNfCyi5XXtN7cvx4ZU?=
 =?us-ascii?Q?D9UqOddm01NjSqNcCkV+g5Igb69KmUtt8JgG7juJf6DBnDzms6EwJeK3MQVW?=
 =?us-ascii?Q?FQQwiyKAtwU/iv6nEwpLxvt0Gl5T8tHvneg6/nsrEqgZbSug1j7/HQDCGsM0?=
 =?us-ascii?Q?AiXrFGvw9vrLNkHbL+kyZQT2/aAxTPBdUIL3OeieyG3bJyLb//gvVHJIBuJO?=
 =?us-ascii?Q?ZWxB8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7677.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756f85b1-25e2-4bd9-2771-08de21c55c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 08:27:47.7982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQhh8iYwcXCmIT/sVodzVrTcH0UokgqFWW1HTr/vV40pcX2KbxoMKZzOX2Shn5o3RFDGAQ13924jZClOujS1LQLpfbn05jFIXNMfeARhsnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8848
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA2NiBTYWx0ZWRfX7vWP8xfxFgHg
 Ah62+B+1V7vrEXRU4ZO5n0XRxMYdqqWnGmX8JSguE4x25+31yvwEtZV/X6K6vPw6ydXXs/ri89g
 vK4dwm5y9WKPkv+JJZC9iYU+d+LTW/T6ZE1aVlW12sNdxK7BR6RbjrDd2dx1jBVa7JFJUylBoIC
 92+pnMqTwoziJHkyzR8SEoF6RJfoHXD6n/fDwWl4u1Hx89GtOcV8yrZY/Qd6oTX7NKYs4N4KwAQ
 8HPg+sahQaFyAXgAVADmy+dVpWWk7IFSKDF9m71d04jKNMlAcPOUdnbvAWnv/tZNQwYV+Q8t2wf
 wV0ZdKuML5naoRJDoyHlqkyFpGM4jl/J9hRe9wPCGlNIOJgZTkE6/ntMn4Ltuxq0Jaq83MgXb7M
 xVN28uZ4VEuU/ALaXHJcIcxT5FBTiw==
X-Proofpoint-GUID: Zi6EFb0L4s9letQthEKfKJCY2qQ0q7vF
X-Proofpoint-ORIG-GUID: Zi6EFb0L4s9letQthEKfKJCY2qQ0q7vF
X-Authority-Analysis: v=2.4 cv=CMknnBrD c=1 sm=1 tr=0 ts=6914450a cx=c_pps
 a=ScYCyfYCeG8NXYeL6jRcjA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=2V6DY6BgAAAA:8
 a=iGHA9ds3AAAA:8 a=Q4-j1AaZAAAA:8 a=FwK0Ds_eDNupwi_8XucA:9
 a=08cUWbsiBBr0L5i7:21 a=CjuIK1q_8ugA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=ldqKKs2zR4t-S6fqr-1n:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=poXaRoVlC6wW9_mwW8W4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120066
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 08:28:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18348

From 12b96eba959f298bb8edcbcbd9b35a53d104ecea Mon Sep 17 00:00:00 2001
From: David Reyna <David.Reyna@windriver.com>
Date: Wed, 12 Nov 2025 00:04:24 -0800
Subject: [PATCH] toaster: remove dependency on poky distro

The poky distro is now stripped of its repositories. Toaster had used that
repo as both a quick way to get the three core layers (openembedded-code,
meta-poky, and meta-yocto-bsp) but also a way to get the related bitbake,
which was important because bitbake is not in the Layer Index. Now, Toaster
must explicitly clone each of the core layers plus the proper bitbake layer=
.

Notes on "orm/fixtures":
  * The "orm/fixtures" files used to hard code the three core layers to
    point to the poky distro, ignoring the Layer Index values
  * The script "lsupdates.py" is now allowed to use the Layer Index to
    properly initialize these layers.
  * The fixture files are still used because (a) they define the supported
    releases for Toaster, plus (b) they now define the proper bitbake repo
    path and branches to associate with the YP releases.
Notes on "localhostbecontroller.py":
  * Always insert the proper bitbake into the layer clone list
  * Insure that both 'BBBASEDIR' and 'BITBAKEDIR' are defined in the
    sub-shells so that oe-init finds the right bitbake (e.g.
    'oe-buildenv-internal')

[YOCTO #16012]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 .../bldcontrol/localhostbecontroller.py       | 67 ++++++++-----------
 lib/toaster/orm/fixtures/gen_fixtures.py      | 10 +--
 lib/toaster/orm/fixtures/poky.xml             | 38 +++++------
 .../orm/management/commands/lsupdates.py      |  6 +-
 4 files changed, 55 insertions(+), 66 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/=
bldcontrol/localhostbecontroller.py
index 37b0a7519..dafda7e16 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -40,7 +40,8 @@ class LocalhostBEController(BuildEnvironmentController):
=20
     def __init__(self, be):
         super(LocalhostBEController, self).__init__(be)
-        self.pokydirname =3D None
+        self.bitbake_dirname =3D None
+        self.oecore_dirname =3D None
         self.islayerset =3D False
=20
     def _shellcmd(self, command, cwd=3DNone, nowait=3DFalse,env=3DNone):
@@ -100,7 +101,7 @@ class LocalhostBEController(BuildEnvironmentController)=
:
         # 1. get a list of repos with branches, and map dirpaths for each =
layer
         gitrepos =3D {}
=20
-        # if we're using a remotely fetched version of bitbake add its git
+        # We are using a remotely fetched version of bitbake - add its git
         # details to the list of repos to clone
         if bitbake.giturl and bitbake.commit:
             gitrepos[(bitbake.giturl, bitbake.commit)] =3D []
@@ -154,12 +155,20 @@ class LocalhostBEController(BuildEnvironmentControlle=
r):
         clone_total=3Dlen(gitrepos.keys())
         self.setCloneStatus(bitbake,'Started',clone_total,clone_count,'')
         for giturl, commit in gitrepos.keys():
-            self.setCloneStatus(bitbake,'progress',clone_total,clone_count=
,gitrepos[(giturl, commit)][0][0])
+            layer_name =3D gitrepos[(giturl, commit)][0][0]
+            self.setCloneStatus(bitbake,'progress',clone_total,clone_count=
,layer_name)
             clone_count +=3D 1
=20
             localdirname =3D os.path.join(self.be.sourcedir, self.getGitCl=
oneDirectory(giturl, commit))
             logger.debug("localhostbecontroller: giturl %s:%s checking out=
 in current directory %s" % (giturl, commit, localdirname))
=20
+            # Capture local paths to release's bitbake and openembedded-co=
re layers
+            if 'bitbake' =3D=3D layer_name:
+                self.bitbake_dirname =3D localdirname
+            # Capture local path to release's openembedded-core layer (for=
 'oe-init-build-env')
+            if 'openembedded-core' =3D=3D layer_name:
+                self.oecore_dirname =3D localdirname
+
             # see if our directory is a git repository
             if os.path.exists(localdirname):
                 try:
@@ -192,16 +201,6 @@ class LocalhostBEController(BuildEnvironmentController=
):
                 # prevent inserted debugging commands from being lost
                 self._shellcmd('git fetch && git reset --hard "%s"' % ref,=
 localdirname,env=3Dgit_env)
=20
-            # take the localdirname as poky dir if we can find the oe-init=
-build-env
-            if self.pokydirname is None and os.path.exists(os.path.join(lo=
caldirname, "oe-init-build-env")):
-                logger.debug("localhostbecontroller: selected poky dir nam=
e %s" % localdirname)
-                self.pokydirname =3D localdirname
-
-                # make sure we have a working bitbake
-                if not os.path.exists(os.path.join(self.pokydirname, 'bitb=
ake')):
-                    logger.debug("localhostbecontroller: checking bitbake =
into the poky dirname %s " % self.pokydirname)
-                    self._shellcmd("git clone -b \"%s\" \"%s\" \"%s\" " % =
(bitbake.commit, bitbake.giturl, os.path.join(self.pokydirname, 'bitbake'))=
,env=3Dgit_env)
-
             # verify our repositories
             for name, dirpath, index in gitrepos[(giturl, commit)]:
                 localdirpath =3D os.path.join(localdirname, dirpath)
@@ -215,21 +214,11 @@ class LocalhostBEController(BuildEnvironmentControlle=
r):
         self.setCloneStatus(bitbake,'complete',clone_total,clone_count,'')
         logger.debug("localhostbecontroller: current layer list %s " % pfo=
rmat(layerlist))
=20
-        # Resolve self.pokydirname if not resolved yet, consider the scena=
rio
-        # where all layers are local, that's the else clause
-        if self.pokydirname is None:
-            if os.path.exists(os.path.join(self.be.sourcedir, "oe-init-bui=
ld-env")):
-                logger.debug("localhostbecontroller: selected poky dir nam=
e %s" % self.be.sourcedir)
-                self.pokydirname =3D self.be.sourcedir
-            else:
-                # Alternatively, scan local layers for relative "oe-init-b=
uild-env" location
-                for layer in layers:
-                    if os.path.exists(os.path.join(layer.layer_version.lay=
er.local_source_dir,"..","oe-init-build-env")):
-                        logger.debug("localhostbecontroller, setting pokyd=
irname to %s" % (layer.layer_version.layer.local_source_dir))
-                        self.pokydirname =3D os.path.join(layer.layer_vers=
ion.layer.local_source_dir,"..")
-                        break
-                else:
-                    logger.error("pokydirname is not set, you will run int=
o trouble!")
+        # If self.bitbake_dirname still missing (e.g. 'local' build), use =
local bitbake
+        if not self.bitbake_dirname:
+            self.bitbake_dirname =3D os.environ.get('BBBASEDIR','')
+        if not self.bitbake_dirname:
+            logger.error("bitbake_dirname is not set, you will run into tr=
ouble!")
=20
         # 5. create custom layer and add custom recipes to it
         for target in targets:
@@ -352,8 +341,11 @@ class LocalhostBEController(BuildEnvironmentController=
):
         try:
             # insure that the project init/build uses the selected bitbake=
, and not Toaster's
             del git_env['TEMPLATECONF']
-            del git_env['BBBASEDIR']
             del git_env['BUILDDIR']
+            # Insure that oe-init finds the right bitbake (e.g. 'oe-builde=
nv-internal')
+            git_env['BBBASEDIR'] =3D self.bitbake_dirname
+            git_env['BITBAKEDIR'] =3D self.bitbake_dirname
+
         except KeyError:
             pass
=20
@@ -362,7 +354,7 @@ class LocalhostBEController(BuildEnvironmentController)=
:
             builddir =3D bitbake.req.project.builddir
         else:
             builddir =3D '%s-toaster-%d' % (self.be.builddir, bitbake.req.=
project.id)
-        oe_init =3D os.path.join(self.pokydirname, 'oe-init-build-env')
+        oe_init =3D os.path.join(self.oecore_dirname, 'oe-init-build-env')
         setup_init =3D os.path.join(builddir, 'init-build-env')
         # init build environment and build directory structure
         try:
@@ -376,7 +368,7 @@ class LocalhostBEController(BuildEnvironmentController)=
:
                 os.makedirs(builddir, exist_ok =3D True)
                 build_init_script =3D os.path.join(builddir,'init-build-en=
v')
                 os.system(f"cp {os.path.join(toaster_run_dir,'init-build-e=
nv')} {build_init_script}")
-                os.system(f"sed -i -e 's|^cd .*$|cd {self.pokydirname}|g' =
{build_init_script}")
+                os.system(f"sed -i -e 's|^cd .*$|cd {self.oecore_dirname}|=
g' {build_init_script}")
                 os.system(f"sed -i -e 's|^set .*$|set {builddir}|g' {build=
_init_script}")
                 # Execute the init
                 self._shellcmd(f"bash -c 'source {build_init_script}'", en=
v=3Dgit_env)
@@ -476,10 +468,10 @@ class LocalhostBEController(BuildEnvironmentControlle=
r):
=20
         # run bitbake server from the clone if available
         # otherwise pick it from the PATH
-        bitbake =3D os.path.join(self.pokydirname, 'bitbake', 'bin', 'bitb=
ake')
+        bitbake =3D os.path.join(self.bitbake_dirname, 'bin', 'bitbake')
         if not os.path.exists(bitbake):
             logger.info("Bitbake not available under %s, will try to use i=
t from PATH" %
-                        self.pokydirname)
+                        self.bitbake_dirname)
             for path in os.environ["PATH"].split(os.pathsep):
                 if os.path.exists(os.path.join(path, 'bitbake')):
                     bitbake =3D os.path.join(path, 'bitbake')
@@ -494,18 +486,18 @@ class LocalhostBEController(BuildEnvironmentControlle=
r):
             # Use 'init-build-env' model
             if not is_merged_attr:
                 self._shellcmd(f'{env_clean} bash -c \"source {setup_init}=
; BITBAKE_UI=3D"knotty" {bitbake} --read {confpath} --read {bblayers} --rea=
d {toasterlayers} '
-                               '--server-only -B 0.0.0.0:0\"', self.be.sou=
rcedir)
+                               '--server-only -B 0.0.0.0:0\"', self.be.sou=
rcedir,env=3Dgit_env)
             else:
                 self._shellcmd(f'{env_clean} bash -c \"source {setup_init}=
; BITBAKE_UI=3D"knotty" {bitbake} '
-                           '--server-only -B 0.0.0.0:0\"', self.be.sourced=
ir)
+                           '--server-only -B 0.0.0.0:0\"', self.be.sourced=
ir,env=3Dgit_env)
         else:
             # Use 'oe-init-build-env' model
             if not is_merged_attr:
                 self._shellcmd(f'{env_clean} bash -c \"source {oe_init} {b=
uilddir}; BITBAKE_UI=3D"knotty" {bitbake} --read {confpath} --read {bblayer=
s} --read {toasterlayers} '
-                               '--server-only -B 0.0.0.0:0\"', self.be.sou=
rcedir)
+                               '--server-only -B 0.0.0.0:0\"', self.be.sou=
rcedir,env=3Dgit_env)
             else:
                 self._shellcmd(f'{env_clean} bash -c \"source {oe_init} {b=
uilddir}; BITBAKE_UI=3D"knotty" {bitbake} '
-                           '--server-only -B 0.0.0.0:0\"', self.be.sourced=
ir)
+                           '--server-only -B 0.0.0.0:0\"', self.be.sourced=
ir,env=3Dgit_env)
=20
         # read port number from bitbake.lock
         self.be.bbport =3D -1
@@ -551,7 +543,6 @@ class LocalhostBEController(BuildEnvironmentController)=
:
         log =3D os.path.join(builddir, 'toaster_ui.log')
         local_bitbake =3D os.path.join(os.path.dirname(os.getenv('BBBASEDI=
R')),
                                      'bitbake')
-
         if not is_merged_attr:
             self._shellcmd([f'{env_clean} bash -c \"(TOASTER_BRBE=3D"{brbe=
}" BBSERVER=3D"0.0.0.0:{self.be.bbport}" '
                         f'{bitbake} {bbtargets} -u toasterui  --read {conf=
path} --read {bblayers} --read {toasterlayers} --token=3D"" >>{log} 2>&1;'
diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fix=
tures/gen_fixtures.py
index 6201f679b..c5b0ab7a7 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -32,7 +32,7 @@ verbose =3D False
 # It is also policy to include all active LTS releases.
 #
=20
-# [Codename, Yocto Project Version, Release Date, Current Version, Support=
 Level, Poky Version, BitBake branch]
+# [0=3DCodename, 1=3DYocto Project Version, 2=3DRelease Date, 3=3DCurrent =
Version, 4=3DSupport Level, 5=3DPoky Version, 6=3DBitBake branch]
 current_releases =3D [
     # Release slot #1
     ['Scarthgap','5.0','April 2024','5.0.0 (April 2024)','Long Term Suppor=
t (until April 2028)','','2.8'],
@@ -43,7 +43,7 @@ current_releases =3D [
     # Release slot #4
     ['Whinlatter','5.3','October 2025','5.3.0 (October 2024)','Support for=
 7 months (until May 2026)','','2.14'],
     ['Walnascar','5.2','April 2025','5.2.0 (April 2025)','Support for 7 mo=
nths (until October 2025)','','2.12'],
-    #['Styhead','5.1','November 2024','5.1.0 (November 2024)','Support for=
 7 months (until May 2025)','','2.10'],
+    ['Styhead','5.1','November 2024','5.1.0 (November 2024)','Support for =
7 months (until May 2025)','','2.10'],
     #['Nanbield','4.3','November 2023','4.3.0 (November 2023)','Support fo=
r 7 months (until May 2024)','','2.6'],
     #['Mickledore','4.2','April 2023','4.2.0 (April 2023)','Support for 7 =
months (until October 2023)','','2.4'],
     #['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for =
7 months (until May 2023)','','2.2'],
@@ -81,9 +81,9 @@ prolog_template =3D '''\
 bitbakeversion_poky_template =3D '''\
   <object model=3D"orm.bitbakeversion" pk=3D"{{bitbake_id}}">
     <field type=3D"CharField" name=3D"name">{{name}}</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.yoctoproject.org/p=
oky</field>
+    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
     <field type=3D"CharField" name=3D"branch">{{branch}}</field>
-    <field type=3D"CharField" name=3D"dirpath">bitbake</field>
+    <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
 '''
 bitbakeversion_oecore_template =3D '''\
@@ -224,7 +224,7 @@ def generate_poky():
             params['release'] =3D params['release'][0].lower() + params['r=
elease'][1:]
         params['name'] =3D params['release']
         params['bitbake_id'] =3D str(i+1)
-        params['branch'] =3D params['release']
+        params['branch'] =3D release[6]   # Bitbake branch
         print_template(bitbakeversion_poky_template,params,fd)
     print_str('',fd)
=20
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/p=
oky.xml
index 6cf4f0687..34b83e971 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -9,45 +9,45 @@
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model=3D"orm.bitbakeversion" pk=3D"1">
     <field type=3D"CharField" name=3D"name">scarthgap</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.yoctoproject.org/p=
oky</field>
-    <field type=3D"CharField" name=3D"branch">scarthgap</field>
-    <field type=3D"CharField" name=3D"dirpath">bitbake</field>
+    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
+    <field type=3D"CharField" name=3D"branch">2.8</field>
+    <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"2">
     <field type=3D"CharField" name=3D"name">HEAD</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.yoctoproject.org/p=
oky</field>
+    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
     <field type=3D"CharField" name=3D"branch">HEAD</field>
-    <field type=3D"CharField" name=3D"dirpath">bitbake</field>
+    <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"3">
     <field type=3D"CharField" name=3D"name">master</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.yoctoproject.org/p=
oky</field>
+    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
     <field type=3D"CharField" name=3D"branch">master</field>
-    <field type=3D"CharField" name=3D"dirpath">bitbake</field>
+    <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"4">
     <field type=3D"CharField" name=3D"name">whinlatter</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.yoctoproject.org/p=
oky</field>
-    <field type=3D"CharField" name=3D"branch">whinlatter</field>
-    <field type=3D"CharField" name=3D"dirpath">bitbake</field>
+    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
+    <field type=3D"CharField" name=3D"branch">2.14</field>
+    <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"5">
     <field type=3D"CharField" name=3D"name">walnascar</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.yoctoproject.org/p=
oky</field>
-    <field type=3D"CharField" name=3D"branch">walnascar</field>
-    <field type=3D"CharField" name=3D"dirpath">bitbake</field>
+    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
+    <field type=3D"CharField" name=3D"branch">2.12</field>
+    <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"6">
     <field type=3D"CharField" name=3D"name">styhead</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.yoctoproject.org/p=
oky</field>
-    <field type=3D"CharField" name=3D"branch">styhead</field>
-    <field type=3D"CharField" name=3D"dirpath">bitbake</field>
+    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
+    <field type=3D"CharField" name=3D"branch">2.10</field>
+    <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"7">
     <field type=3D"CharField" name=3D"name">kirkstone</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.yoctoproject.org/p=
oky</field>
-    <field type=3D"CharField" name=3D"branch">kirkstone</field>
-    <field type=3D"CharField" name=3D"dirpath">bitbake</field>
+    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
+    <field type=3D"CharField" name=3D"branch">2.0</field>
+    <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
=20
=20
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster=
/orm/management/commands/lsupdates.py
index 6d64830eb..0ee00aa15 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -138,9 +138,7 @@ class Command(BaseCommand):
                 l.summary =3D index.layerItems[id].summary
                 l.description =3D index.layerItems[id].description
=20
-                if created:
-                    # predefined layers in the fixtures (for example poky.=
xml)
-                    # always preempt the Layer Index for these values
+                if True: # (if created:) always override fixture defaults =
now that poky distro is stripped
                     l.vcs_url =3D index.layerItems[id].vcs_url
                     l.vcs_web_url =3D index.layerItems[id].vcs_web_url
                     l.vcs_web_tree_base_url =3D index.layerItems[id].vcs_w=
eb_tree_base_url
@@ -179,7 +177,7 @@ class Command(BaseCommand):
                     index.layerBranches[id].layer_id)
                 continue
=20
-            if created:
+            if True: # (if created:) always override fixture defaults now =
that poky distro is stripped
                 lv.release =3D li_branch_id_to_toaster_release[index.layer=
Branches[id].branch_id]
                 lv.up_date =3D index.layerBranches[id].updated
                 lv.commit =3D index.layerBranches[id].actual_branch
--=20
2.43.0


