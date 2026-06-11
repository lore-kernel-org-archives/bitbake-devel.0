Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF7CD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 22:58:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.59085.1781218681544064442
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 15:58:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=iSI+d9vP;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=06224ea6e2=david.reyna@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BMWxHx048883
	for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 22:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=ZQcuJrSQoOc/vJi80Dhf
	EKbWR9/bwyjF1KpGnj45MRU=; b=iSI+d9vPLIfulGvDh5Qp8DoR5HWYMqZG45LS
	v3dhOCQpt730Ig2iojrBltEo4tyzYYHgv4oniInrHUDelk2xnaYqoz9N5Cxk2N/B
	YzHTQj7p9TEPDFN3rx6exVinO2NffAlBN0j7eW7+ljbJfjDQnBNueubCukcKhTee
	SV6uoTUVM4MTP9NpNnesVpXHM0JJSadB+p2vSbpacYT9AxyBZHuKzQsNCOpTeQub
	d9QBsLfqBrcBtJxcORSbzQPiRNVogKsXnxET7goLXkqIo0WyvV0E/CMZQORmPaTm
	YrPyE8MjhYrJDMjT1MfuWlB8za5kht1Qp8H7J8d8QcAw3rbGCQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eqe7ehy85-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 22:58:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzOO81iLfmOMmgpnXSpyiONxiWcl/nonD6vKIAn0pWTpz3ah8n1VRFYfm5dVtcJyj8yEnE06lfUO1wH1D8V2QVsdkAbIFxIeG8iNfCZ6TNe+w6T5++gZGI9tt2EF87dl7QstWvuzu0GH0VN0tmYip5KvZUALQMlystfAWmEtf6msP/CC5nk2ZYNXzqjihtA7aHwj2YmRb065InsQgqgiG1oytTRMxr6ARQwRpjwLYuN+WO6MbJVEqpTiJjCGK0ZsreVJdbrITRiODoYu/80TScnOs+VlO17/NRkiazOea33YwxGE4nC/9mWmDTLGoti8bA/UpZ5RSgXXV39P6mf31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQcuJrSQoOc/vJi80DhfEKbWR9/bwyjF1KpGnj45MRU=;
 b=RSTsZHM+eV8h8lTOSV8enJwiX/2dm7yhV7/08Ov6sN2moNcp+gJ6wFDrI1WDffJSn5OoEpxDRe8cPGDNX8TvJ/GsY9yerJ4GIi6yKd/IIOZ/VR+3/i3r+eURa3NE1kRiV2zLsx/SL1aHdRMVjHKnoTPuBPpQ9mNSdiNG7BCSZlxVnu3hUTsBHD4bigkA++bVqEjCoZqbFnPtUVnzQc8XUxEK/sK5IUub6pg1+zEIl+bExiBxR6j4cT+0NwWLgYhNDW+MARkzFSwFmZTl4ZqAcktNl1xSYf53JH31a4WGij33fo9RDjlP+ajcdy/AICh3jvSI/Zbzj2jkqJR37ClBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5)
 by CH3PR11MB8362.namprd11.prod.outlook.com (2603:10b6:610:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 22:57:56 +0000
Received: from IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::d8e5:e930:6a48:871e]) by IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::d8e5:e930:6a48:871e%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 22:57:56 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [bitbake-devel] [PATCH] toaster: sync release list for Toaster, test,
 and Layer Index
Thread-Topic: [bitbake-devel] [PATCH] toaster: sync release list for Toaster,
 test, and Layer Index
Thread-Index: Adz59UhWicdUV+FoTkSGYBfpyaZh4w==
Date: Thu, 11 Jun 2026 22:57:56 +0000
Message-ID: 
 <IA1PR11MB767743DDC0B4E26265566228EA1B2@IA1PR11MB7677.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=69d5b206-ef2e-4cae-a76e-4b25b8ea1520;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-06-11T22:54:27Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7677:EE_|CH3PR11MB8362:EE_
x-ms-office365-filtering-correlation-id: 70e178cc-7dae-4076-361b-08dec80ce097
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10070799003|38070700021|3023799007|11063799006|56012099006|6133799003|18002099003;
x-microsoft-antispam-message-info: 
 3Vall6NARwu6qWNnMJCCHF14uHClPfrsAyeRIgWWWzUjv3hgDhfAuHTLv7qfVpdoqwd26W+4c0hMbnDBsy9EbcRG1m/+Qg++iV6wSnqGCTs+QXoLNN7PRqYG0zDCYmUUgh3FDSdaVXrfVb7k+YgA1sPJN+0ZGFw/bZ3bI8KTbU7MdVwY4C9EbzD3VTw4iR0Sq8QEhSeZ7heMfhrR0kzf0cF8HC/P+6gZBhQzx8eRitKYdv7JYOgRZoYBljC6hge4CdHh6jqUbJznjHtY9xSp0j7Axk4RsorSdQl8ZqzpF5xhR+8i0/NOS3JMf3NqmRqyaySVhANrjhPYwt/5mTFLAbfiUT7Mcoq5Yn8XqrLhZPjNKw5NR4ZJZLG6hBDfFTEGGVdR6HXsgdtzjCyNPq795lD9BrZO95OQ9YK2wcm5YTuo0bdRkpScg+ClRluUDBZ4FdeDvkpeOwRgpP8dL5yCIL3HnFY6RY2mWCl0SbFqluZ31CyNHdc5g2YJyNz3F2E3T46VMI7H8HVn+SwKk9OLdZtsaZt2NT03hMTJMATk1hFZgzkEuQIYHbW6c4OQtCNBZ4HDRvwPN+U76fZ59Tzns9SPKJDmcmzfZjYrUC1qv89BEWJhKi+sA3jdSfE6Gc40yeSEf8SZ716YPRSAeaz34XRwBmJhOAIKAahhmf6A3YBdaS03hiDp498OLkBhtUqqvcGo+K3IJMfbKSCcE2hGMA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7677.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10070799003)(38070700021)(3023799007)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Sn1tK2SFgXEy6QksWIC/zQjt0rj32HJxUk6K7DOI/a7dPQLB2WWcbscuav94?=
 =?us-ascii?Q?FQNEGrnJVHoOlFWqZaANhlUoBaOgx4QTAbLrlQP3vhxWnk4YJb/aYzEjidEn?=
 =?us-ascii?Q?0WEyJIugqHNccoT1+a2ZhA0Ce7XXTi+fVnjykTwluCUJaJ8y4Yfr87otMLFy?=
 =?us-ascii?Q?CGd4b/5EWeTOdFCsi0fxHJe+pTQYzO6ssv6uaZwx68NhWu5V30ultIvkJ1DB?=
 =?us-ascii?Q?Ac55MfTFZXFJE7o8mPO/fktrvZcqXY4OqPGsrBNdrzaxmvT+QALBZMzSX2Ww?=
 =?us-ascii?Q?sZ2TtWrEcWdSVTY/G5RZsXNX82ytXyhXHJ0s7mHwitzQef3scDd5MAdxvPzq?=
 =?us-ascii?Q?LbmCXU8UHlqBV1KDiZ9AnTniDVW7lgVG6MIVzWZdNW9+GPBX0udtxANDs5qo?=
 =?us-ascii?Q?I9zaoMZid/UDD+Ah+5IRfWdJIWhy1hOqk+G1K96qiAVAEuGXTyq6lHFNxPt7?=
 =?us-ascii?Q?l6MpX+/o0U158R5X8xYZEf344qeIzVYn4xSnCF9H7eZobUgRTVwZ/f/izW4R?=
 =?us-ascii?Q?gWpDUMcb3Ah1WUnrgYdlPu4tMfV9iwlQOkn9ROr/rJcd/XePTVRs+QDYCpHO?=
 =?us-ascii?Q?yXTHO8k81vACm9sROIKCNIubUhacklCwlfnZmH1D7LecEy2noGQLS/ww2qyZ?=
 =?us-ascii?Q?DAKySoV3UFYzNctaDGSNmWjNZ9eMKSesuyGhkbYSBuaO40XgbpKyGk1ang/o?=
 =?us-ascii?Q?8zfavT/Ynh5McdAqbMUW32FJNoY3OyNtfLgRKCm7ROD8XAtmYiyK8Occ46wH?=
 =?us-ascii?Q?Dhcy32otizoKfaYXh5bVxAK2j12X3xlxWmt+2tgzc0QRFV1H60up+YLd2pho?=
 =?us-ascii?Q?RcsoIJ3MvgMVZ+E60YhzPH68IzMGI3J9BrbKuEM2/SX2Mgq2hFF4Wy7BfobV?=
 =?us-ascii?Q?lsFWRpEw7puI6M4kqvvNoTUv2y+wuaoD/YpxIPadMlCLKMUx+S1zD1V/yGOY?=
 =?us-ascii?Q?gJ1TwMVBcPoe5RxW4eBj9kyIMWcF9rlnKGSYTGFaVbgY0Z+G29jVVTuyEHai?=
 =?us-ascii?Q?+K1mlx1yZ7dlH+9oSE08d+mf8MlpvWqysStZDgOooS0E4/3zqruQtAI/f6l2?=
 =?us-ascii?Q?cCr1PG/L0JgXCs6g4cvEBWYezR2D4jFI1r/EmIZ5Tzwf+Ltz8KOyz9lRJ+KF?=
 =?us-ascii?Q?jpapFnSUplfhROGu5C/bnSKzkHgiCYatQaH05yuzUj8skyDqv/NYaet4lrts?=
 =?us-ascii?Q?ZfrOMa5zQdPbKw23uIAZbJr1i8+fdMms7D9Fejm9vlzZEOlOfkSIam5G7RPq?=
 =?us-ascii?Q?YuM8Va6qmUtJitO/ohLsoqVTJQ3ftR9NyQ/aF3KU0mfJJDnjEHnIId0goNhi?=
 =?us-ascii?Q?8qpWUjsL/tIuUqdAtnFe8VB3s3G56VBGkbFwgF3M55StAcLNcuqV0z2xIWb7?=
 =?us-ascii?Q?EGf0HLeWZlg2RjvQTYGaHJX+ekGLtyD9qbMml8HbJuycbo4D1ghmkeA6CeZI?=
 =?us-ascii?Q?2lq0ZhxuuOcTPSuEWPbhxoGyY4IDC5GNUPBroSL3mnbh+FSePpMrdFHHRu0Z?=
 =?us-ascii?Q?5iA6Dy0Ac+JhuQvu9XaTTM4O86/ylMf/kFpCuWzF+3ANbiIzS0z8MiNDsLgf?=
 =?us-ascii?Q?H/ycxaqK6m5LQ6r9cypIlV8kH32hYlsMVThYJRH+7C8rVx+1wMVFRN/1y072?=
 =?us-ascii?Q?zlgnbUyc6fMp/DZ+QKesfSvIezftB0X5tADVF6P79OlLijuXqwmtP7uJtikh?=
 =?us-ascii?Q?StmjVESiyh/bGsWmXIyCDxTxsuawoEJKuhCHWlUBwL9o3PbxlxVCDz3+oDhI?=
 =?us-ascii?Q?zMda2ujvsyycWbFNNp3oBcd4I2XwzHC6e7TN9Mp6c5pjYEy8R04VrOt9io5+?=
x-ms-exchange-antispam-messagedata-1: cS+tayc7rFytMA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	SZLbiiCGBataqkEMctkIRnwr28rP1Sw/gix3JKK7vV3vSJmYOjFQQjdmYe3gLOy+8QQvmGFfDwrfxSlOj3fBujc1OrO68vcrw20+vk5EsN73JiE0QDLql4pSYDSHs1aVB/ylfpIsrAqtD6Sl9pcKTbWGQx1K1TbLCvz/8o1TpL9gkN8CiRxJmfAObEo7lZRHsJxDWRYfYXstOeejxZ/D1Bkwwl0IndHNQp9YWjyPXCeyAE5CcAV1S9jx/NEsDtSLShsJ1lXnHQO8YZeUdhwdneO8fF1YWqts/W+R3RVZE41obF1Mhhu1nSui2TEKYMsXQlf334z7tSopyfapp9fQwA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7677.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e178cc-7dae-4076-361b-08dec80ce097
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 22:57:56.6051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hb1h0WGpuMJHKvv7HOMk9rDYzIJ9EQcARU7ABTJ+nbuCMZLdo8+tAZDn2oNcfeJSjCOsFMRig6fshNIOtIeo7yiDeTu6gn31gyQLQL6WHGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8362
X-Proofpoint-ORIG-GUID: VO8ZbSHThFaRhTjvl6mDYPCHnxgemyFq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMCBTYWx0ZWRfX5g91b0INMPD6
 sFL6Prsf2//+XWm1UD6iDxcRxouCWIf4rZigcNYVDiI1sszmCIrt/GmITczBRMhNl2vsEH8euyi
 nW/nHM1aA1J9ZMj9Ayd42BPXTNXzJ7No0AVwzXpfhfecw6gpcM6AFZD2A4jcg7v2wR1hrMLccap
 wp9iXaHSzY6Nwr5ng8tT+0J/BgqzuwpJdXKFR8ILvpAGW+tim85o1wuZUphCEgnp2oicDmFZKfD
 8J4yfGIWPJl66TfXTPQay4mCZT1lvUhtTHzosxbOtuHZfnEaH7lZyj1RIAgmlH47pdfkyx5gm28
 ge5J/Ojyk6mnkbQTU/UHuThJj8GX7JMWbv3a885KAZcVvhuq3PAlLIZM0K3nEyWDsHpsN4Y1vQX
 kQxb4WyZkPNY01oq+ThEWAd7vU+GQXrgtNPeggpN3zrnpiZPQaFrPRunXs3P3NVKuaHAFdBUh5M
 bBYK3B3d0YFAJdmEmTg==
X-Authority-Analysis: v=2.4 cv=cN/QdFeN c=1 sm=1 tr=0 ts=6a2b3d78 cx=c_pps
 a=vzv6YJZFwQv9rWyERtU3yg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=iGHA9ds3AAAA:8 a=Q4-j1AaZAAAA:8
 a=tt5wVNDdC-oIfNQn2ysA:9 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10
 a=FdTzh2GWekK77mhwV6Dw:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMCBTYWx0ZWRfXy3i0BxoHF/+L
 HWpDLDRkFJVCWhFyMhyO3CaISnAq0cVPpUShZa84X2waJH7FRGwmp67Dk0nHnP9FgrboZmMh3T8
 s9l/6nhCDjbu/9diXMLoeMyxCmXjwXfe0tHcgFp55BOumQPRzFVr
X-Proofpoint-GUID: VO8ZbSHThFaRhTjvl6mDYPCHnxgemyFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110230
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 22:58:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19670

From 21858028a7448ff2d92e388f96da7127cfd7048e Mon Sep 17 00:00:00 2001
From: David Reyna mailto:David.Reyna@windriver.com
Date: Thu, 11 Jun 2026 14:55:37 -0700
Subject: [PATCH] toaster: sync release list for Toaster, test, and Layer In=
dex

Details:
  * check_fixtures.py: ignore releases not yet in Layer Index (e.g. 'blacks=
ail')
  * gen_fixtures.py: also sync 'test_create_new_project.py'
  * test_create_new_project.py: now a generated release list, in slot order
  * toaster: remove 'exit()' from this sourced script

[YOCTO #16280]

Signed-off-by: David Reyna mailto:David.Reyna@windriver.com
---
 bin/toaster                                   |  2 +-
 lib/toaster/orm/fixtures/check_fixtures.py    | 55 ++++++++++----
 lib/toaster/orm/fixtures/gen_fixtures.py      | 74 +++++++++++++++++--
 .../functional/test_create_new_project.py     | 49 ++++++------
 4 files changed, 133 insertions(+), 47 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index d20cbe90b..16a64bab6 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -236,7 +236,7 @@ for param in $*; do
                 manage_cmd=3D"$manage_cmd $param"
             else
                 echo "$HELP"
-                exit 1
+                return 1
             fi
     ;;
=20
diff --git a/lib/toaster/orm/fixtures/check_fixtures.py b/lib/toaster/orm/f=
ixtures/check_fixtures.py
index ae3722e0f..386c2da40 100755
--- a/lib/toaster/orm/fixtures/check_fixtures.py
+++ b/lib/toaster/orm/fixtures/check_fixtures.py
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 #
-# Copyright (C) 2025 Linux Foundation
+# Copyright (C) 2026 Linux Foundation
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
@@ -10,29 +10,52 @@ import urllib.request
 import gen_fixtures as fixtures
=20
 RELEASE_URL =3D https://dashboard.yoctoproject.org/releases.json
+LAYER_INDEX_URL =3D https://layers.openembedded.org/layerindex/api/branche=
s/
+
+# Load a JSON file via REST
+def fetch_json(url):
+    with urllib.request.urlopen(url) as response:
+        if response.getcode() =3D=3D 200:
+            data =3D response.read().decode("utf-8")
+            return(json.loads(data))
+        else:
+            print("Couldn't access %s: %s" % (url, reponse.getcode()))
+            exit(1)
+
+# Grab the existing release branches in the Layer Index
+branches =3D fetch_json(LAYER_INDEX_URL)
+index_branches =3D [
+    e["name"].lower() for e in branches
+]
=20
-with urllib.request.urlopen(RELEASE_URL) as response:
-    if response.getcode() =3D=3D 200:
-        data =3D response.read().decode("utf-8")
-        releases =3D json.loads(data)
+# Grab the recent release branches and add master, so we can ignore old br=
anches
+releases =3D fetch_json(RELEASE_URL)
+active_releases =3D []
+active_but_not_index =3D []
+for e in releases:
+    if e["series"] !=3D "current":
+        continue
+    release =3D e["release_codename"].lower()
+    if not release in index_branches:
+        active_but_not_index.append(release)
     else:
-        print("Couldn't access %s: %s" % (RELEASE_URL, reponse.getcode()))
-        exit(1)
-
-
-# grab the recent release branches and add master, so we can ignore old br=
anches
-active_releases =3D [
-    e["release_codename"].lower() for e in releases if e["series"] =3D=3D =
"current"
-]
+        active_releases.append(release)
 active_releases.append("master")
 active_releases.append("head")
+active_releases.sort()
+
+if active_but_not_index:
+    print(f"Note: Active releases that are not yet in the Layer Index: {ac=
tive_but_not_index}" )
=20
+# Get the list of releases instantiated in the Toaster fixtures
 fixtures_releases =3D [x[0].lower() for x in fixtures.current_releases]
+fixtures_releases.sort()
=20
+# Report the resulting status
 if set(active_releases) !=3D set(fixtures_releases):
-    print("WARNING: Active releases don't match toaster configured release=
s, the difference is: %s" % set(active_releases).difference(set(fixtures_re=
leases)))
-    print("Active releases: %s" % sorted(active_releases))
-    print("Toaster configured releases: %s" % sorted(fixtures_releases))
+    print(f"WARNING: Active releases don't match toaster configured releas=
es, the difference is: {set(active_releases).difference(set(fixtures_releas=
es))}")
+    print(f"Active releases: {sorted(active_releases)}")
+    print(f"Toaster configured releases: {sorted(fixtures_releases)}")
 else:
     print("Success, configuration matches")
=20
diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fix=
tures/gen_fixtures.py
index dda0b8196..937f1ff88 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -4,7 +4,7 @@
 #
 # Generate Toaster Fixtures for 'poky.xml' and 'oe-core.xml'
 #
-# Copyright (C) 2022      Wind River Systems
+# Copyright (C) 2026      Wind River Systems
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Edit the 'current_releases' table for each new release cycle
@@ -413,6 +413,68 @@ def generate_oe_core():
     print_str(epilog_template,fd)
     fd.close()
=20
+#################################
+# Update test project list
+#
+
+def generate_test():
+    this_path =3D os.path.dirname(os.path.abspath(__file__))
+    test_script =3D os.path.join(this_path,"../../tests/functional/test_cr=
eate_new_project.py")
+
+    is_copy =3D True
+    out_lines =3D ""
+    with open(test_script, 'r') as file_fd:
+        lines =3D file_fd.readlines()
+        for line in lines:
+            if 'test_create_new_project_without_name' in line:
+                is_copy =3D True
+                out_lines +=3D '\n'
+            if is_copy:
+                out_lines +=3D line
+            if line.startswith('class TestCreateNewProject'):
+                is_copy =3D False
+                # Insert new project entries
+
+                for id,release in enumerate(current_releases):
+                    release_id =3D id + 1
+                    release_name =3D release[0]
+                    release_merge =3D 'True'
+                    release_version =3D ''
+                    if 'Master' =3D=3D release_name:
+                        release_name =3D 'Master'
+                        release_title =3D 'Yocto Project master'
+                        release_merge =3D 'False'
+                    elif 'HEAD' =3D=3D release_name:
+                        release_name =3D 'Local'
+                        release_title =3D 'Local Yocto Project'
+                    else:
+                        release_title =3D f'Yocto Project {release[1]} "{r=
elease_name}"'
+                        release_version =3D f'{release[1]} '
+                    # Insert project
+                    test_release_def =3D f'''
+    def test_create_new_project_{release_name.lower()}(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Yocto Project {release_version}"{release_name}" (opti=
on value: {release_id})
+          - Merge Toaster settings: {release_merge}
+        """
+        release =3D '{release_id}'
+        release_title =3D '{release_title}'
+        project_name =3D 'project{release_name.lower()}'
+        self.create_new_project(
+            project_name,
+            release,
+            release_title,
+            {release_merge},
+        )
+'''
+                    out_lines +=3D test_release_def
+
+    with open('test_create_new_project.py', 'w') as file_fd:
+        file_fd.write(out_lines)
+    print(f"Output: 'test_create_new_project.py'")
+    os.system(f"mv -f test_create_new_project.py {test_script}")
+
 #################################
 # Help
 #
@@ -431,8 +493,9 @@ def main(argv):
     global verbose
=20
     parser =3D argparse.ArgumentParser(description=3D'gen_fixtures.py: tab=
le generate the fixture files')
-    parser.add_argument('--poky', '-p', action=3D'store_const', const=3D'p=
oky', dest=3D'command', help=3D'Generate the poky.xml file')
-    parser.add_argument('--oe-core', '-o', action=3D'store_const', const=
=3D'oe_core', dest=3D'command', help=3D'Generate the oe-core.xml file')
+    parser.add_argument('--poky', '-p', action=3D'store_const', const=3D'p=
oky', dest=3D'command', help=3D"Generate the 'poky.xml' file")
+    parser.add_argument('--oe-core', '-o', action=3D'store_const', const=
=3D'oe_core', dest=3D'command', help=3D"Generate the 'oe-core.xml' file")
+    parser.add_argument('--test', '-t', action=3D'store_const', const=3D't=
est', dest=3D'command', help=3D"Update the 'test_create_new_project.py' fil=
e")
     parser.add_argument('--all', '-a', action=3D'store_const', const=3D'al=
l', dest=3D'command', help=3D'Generate all fixture files')
     parser.add_argument('--list', '-l', action=3D'store_const', const=3D'l=
ist', dest=3D'command', help=3D'List the release table')
     parser.add_argument('--verbose', '-v', action=3D'store_true', dest=3D'=
verbose', help=3D'Enable verbose debugging output')
@@ -443,11 +506,12 @@ def main(argv):
         generate_poky()
     elif 'oe_core' =3D=3D args.command:
         generate_oe_core()
+    elif 'test' =3D=3D args.command:
+        generate_test()
     elif 'all' =3D=3D args.command:
         generate_poky()
         generate_oe_core()
-    elif 'all' =3D=3D args.command:
-        list_releases()
+        generate_test()
     elif 'list' =3D=3D args.command:
         list_releases()
=20
diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/=
toaster/tests/functional/test_create_new_project.py
index 6e22bdee3..f290f8b3e 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -15,31 +15,31 @@ from selenium.webdriver.common.by import By
=20
 class TestCreateNewProject(SeleniumFunctionalTestCase):
=20
-    def test_create_new_project_master(self):
+    def test_create_new_project_wrynose(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Yocto Project master (option value: 3)
-          - Merge Toaster settings: False
+          - Release: Yocto Project 6.0 "Wrynose" (option value: 1)
+          - Merge Toaster settings: True
         """
-        release =3D '3'
-        release_title =3D 'Yocto Project master'
-        project_name =3D 'projectmaster'
+        release =3D '1'
+        release_title =3D 'Yocto Project 6.0 "Wrynose"'
+        project_name =3D 'projectwrynose'
         self.create_new_project(
             project_name,
             release,
             release_title,
-            False,
+            True,
         )
=20
-    def test_create_new_project_wrynose(self):
+    def test_create_new_project_local(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Yocto Project 6.0 "Wrynose" (option value: 1)
+          - Release: Yocto Project "Local" (option value: 2)
           - Merge Toaster settings: True
         """
-        release =3D '1'
-        release_title =3D 'Yocto Project 6.0 "Wrynose"'
-        project_name =3D 'projectwrynose'
+        release =3D '2'
+        release_title =3D 'Local Yocto Project'
+        project_name =3D 'projectlocal'
         self.create_new_project(
             project_name,
             release,
@@ -47,32 +47,31 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
             True,
         )
=20
-
-    def test_create_new_project_scarthgap(self):
+    def test_create_new_project_master(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Yocto Project 5.0 "Scarthgap" (option value: 4)
-          - Merge Toaster settings: True
+          - Release: Yocto Project "Master" (option value: 3)
+          - Merge Toaster settings: False
         """
-        release =3D '4'
-        release_title =3D 'Yocto Project 5.0 "Scarthgap"'
-        project_name =3D 'projectscarthgap'
+        release =3D '3'
+        release_title =3D 'Yocto Project master'
+        project_name =3D 'projectmaster'
         self.create_new_project(
             project_name,
             release,
             release_title,
-            True,
+            False,
         )
=20
-    def test_create_new_project_local(self):
+    def test_create_new_project_scarthgap(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Local Yocto Project (option value: 2)
+          - Release: Yocto Project 5.0 "Scarthgap" (option value: 4)
           - Merge Toaster settings: True
         """
-        release =3D '2'
-        release_title =3D 'Local Yocto Project'
-        project_name =3D 'projectlocal'
+        release =3D '4'
+        release_title =3D 'Yocto Project 5.0 "Scarthgap"'
+        project_name =3D 'projectscarthgap'
         self.create_new_project(
             project_name,
             release,
--=20
2.43.0


