Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13781061B26
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 21:49:57 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6823.1774907387728101482
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Mar 2026 14:49:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=M99d32PV;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8549bf1ce2=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U5DitB138842
	for <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 14:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=guTqtgTMnvEdnPYCLVtU9i
	upM1/pBasGJxjFaavwcCE=; b=M99d32PV6FgWECEltdcz4+Qa2ObnbV5i1xZU0M
	/qUaka35Cw4iz3gvWgsdUlCpAzBeJfDl5iM4/IKLFkWU3Ugy5KPzPwDiFL+vQLp1
	ng/51AkrkY7qyhDp0Q8naZnNZ+MY0R6U0K30aVgyJj3+NH8H6/I7Fg0IO2jUINBP
	UGoUqHyBVPips/EeY6CHhBfCXtcXbM9dsfvKzhS2atl8YCIzpfYtZEs8UymsADpW
	pkR3Mn4tVdG0ASPVRoxNaQbbQ4YvveB0QQZ/+s/5VYmlZzriEaF+DvwdtzPc0ItN
	HB1FGN8AoQVbQCEhQ5QWqRrvmvAwhhIuInk7yobbAS4ZZdzg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d6a8vahgv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 14:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eB/HDwr1GmZ8Eyx2rGwyE5AopNUU3hmHUoZUjkMVaPeTd18NmkGdr0sLuCxVpcR0TlCHBUB4ePrLCeHupNBiiFXtDLoloqTR81HyiyAk3zy4ln05EFK+VUBtxeoOSFsGNxm71FG7JgxgB5Ut/oR2BkPOCjQZvPLX3ah+21AEo2bMbRbj5+jli5YOZJvU68G2IbQR3yoRM3hj5ome4mD3i0a7TgQRQ9GNO8JJvafxGYVPjHiLLuhpXWHo//xHBGZgArLHBhTZPGV5y/myWG6bhc/CNemCBG8Gj/QrU3zy8sZB7SQjDB7Z8F0iZCuFk6pYOTsC1jaWKvp1hx9lCeaUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guTqtgTMnvEdnPYCLVtU9iupM1/pBasGJxjFaavwcCE=;
 b=j1KWtl8jHpiHIFRloz8oWj86xsOfZFPGSOBridANzUDaM86HqPOSDFKmfS1nwaQM9HMKlRMzIlWAgRIiTzREs01mDftTHPJLCiITqj0Iq5e4fsoGRLhxNl4XUm0UV1t0lhlrzldymnWPdd3aDc0mATwcjLH65874VZY+Sz75YkTCcqiFXN9ZSL+jxJpDIJNc+R3QAjpG6JFb99Q9PsWnd3/cC5y4GwuJYIo9ExZiQdzMp3H9xuARBsdf1XHhwsDFFwGw6LZk430hv1scr2JzpX/010Tw7Ekdevj1wAmJYQx2K6WQ676brg6A2fWDUlzumvltQdTV0LGhi9RSly6WtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) by
 PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 30 Mar 2026 21:49:43 +0000
Received: from DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::ce1b:9c1d:d571:9eb8]) by DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::ce1b:9c1d:d571:9eb8%7]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 21:49:43 +0000
From: "Woolley, Rob" <Rob.Woolley@windriver.com>
To: "adrian.freihofer@gmail.com" <adrian.freihofer@gmail.com>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [PATCH 10/11] bitbake-setup: Set function default
 to None
Thread-Topic: [bitbake-devel] [PATCH 10/11] bitbake-setup: Set function
 default to None
Thread-Index: AQHcwGMR2uXfxh2aokyWrmQm43fFUbXHnBNn
Date: Mon, 30 Mar 2026 21:49:43 +0000
Message-ID: 
 <DM8PR11MB56557582516EAE23B0AA187BE152A@DM8PR11MB5655.namprd11.prod.outlook.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
	 <20260326185742.542268-11-rob.woolley@windriver.com>
 <fcac19e4dff25335679496878b691fa73bcb7485.camel@gmail.com>
In-Reply-To: <fcac19e4dff25335679496878b691fa73bcb7485.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-03-30T21:49:42.810Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5655:EE_|PH0PR11MB5046:EE_
x-ms-office365-filtering-correlation-id: 15ae6c2b-2a4e-418a-716d-08de8ea64099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|4022899009|376014|8096899003|13003099007|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 0uaaSlh70rGj7WiJs8+/WvBu2kPYGsni+swINRjioo6VbBgMsF1r0DOjlILkuaYz8tzAkJ2MACXn4Dc/JdDsQRvHWQ3DrIg6gKxDOmPfbP7C8+pjQdu/WalJs+vxVbabE2rgtuhPMah3bBNf4OAMX0uRj3Rxk3isw9aKz+LlU5O9EKzA3xuvQJv9R8PqtTtI1Yr2cFzrl3FFvn2D4J4WiENQoAXHYox+fVv8gkUm6ElR599YnTadrEjECVP/1YZiJy50S9dDWH0oilHc06mDsvZ67AbbTDTZQ5VwLQk8mrN/p9bH+CiqI/N6q5Ek/cvw1gz3RIcKQ/AcuRGtNqqlDN2GfVEh/x4pbqiccMB/mEmDZXaP+u3RXA7pr0v3bjuxp+OItOUoc3irvMcTRETSgs6yy7sjqtekFHsYbgo1oFgc9AknyO0r/nnv4z64PgKBR6Ur66B9qkLsb70wW4lUsfOsy4baEhGzanFcLsKlM3v/XIqJQJs3gHizuhOLRRHU+jnQD1ttuJ26mReyXnpu+YbErfSZ9ebYcxMolAnFFxxMogNYZHlkC+LF1RXlj/Bw0fY+SDgOiiEaCb5m4SC1+42AosaDOB97UlkHBR5hdjaqIadXH9JboifjtjoWuSOuXqF3IsuRZTC4IG3O91TtsF+bqkoQUQlcIdRBZc2SP8M6ZhYIT2Ccn7B3Wkn4jO8YS2C2/Bi5RKpOjC/o4uIxyuUDRqqn5HPPffu8t332cxW4hl6HLr9DJNO8mCVn4wST
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(4022899009)(376014)(8096899003)(13003099007)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Xv4GoLgQbFOZRWaeE0m0OBVrIvy6tzGQfwFJAaZfMfDlY/68qg9oobspKa78?=
 =?us-ascii?Q?QzQ3Lml0VSFAHWeNjYYujyyJgDUqe1bVUo7byWVbRogth/gvBJw/YpyFIpMW?=
 =?us-ascii?Q?iUHk8WmkcOEvyy7VKGk1FOiPu16NncZ/UXzoIHpCFiixKPQYouuZmqmO5o+x?=
 =?us-ascii?Q?YW3q9t6lDAiNsgOmWCK29bcKQP0ktwUmyysYKBtTRtCs+ETlHHLH1mFnPTFo?=
 =?us-ascii?Q?FXW0rQgKX5PFkCqhkLKiqU9qFI5DN4gDIOHg3HvvvF1lh2b8MKoIAKnG1Vtv?=
 =?us-ascii?Q?gewLjgE+oDB/v4TJgehxJVSbdXRASePxTjaz5fdldDFlAqlLeWBNFz0cufeN?=
 =?us-ascii?Q?JypOf3AjGiwRtnGg3T7R6NRxERu3OPRz0zpSUIgxcgzYscmkhzv0AOS+1diQ?=
 =?us-ascii?Q?06kLAq5G5ER4BGW+3Jn6OIPVlKVsi9UUHBmRR7Y/uLsaSfgJdK9NveNGA6qB?=
 =?us-ascii?Q?cJOXyp5XLVbtOXDBOx29EWMeRBujokzQEnCNwglzTQG+aIH2dugnucR65D2N?=
 =?us-ascii?Q?JduqXg47eh/ZxwwUmKVbrcq/nGf6F1AIFg53SW/Pfwvd3OxrH6kfpe34qmr9?=
 =?us-ascii?Q?YqGJTgWF3qMABluUjuL0lscSch5Isq6OL16ICPtUqUsJRfhXFAXqdM2PXezR?=
 =?us-ascii?Q?MwEIRxBdw/c/Lk35d8EZEYr15ZeLYIYVsYTyGgPYYm3UsgzsIoQAWlXU56ot?=
 =?us-ascii?Q?cK4hnqExfxnxInygIVTmO2Y4REl1NH8K1nsiGs/Yw8A2lHmCjuv9FZI8JW3a?=
 =?us-ascii?Q?SwkxkTfu5kCLPYb3FL0QvtpSFiPc4S5kX8rfYEXkXn5E/zxvnQ7YyqkOi25F?=
 =?us-ascii?Q?n6mF2qpRIGHzP4peuyKAIUYFL1BKXa5KwkhFDuj1ggSCgr142h4QvOBVkfz9?=
 =?us-ascii?Q?PUF6+tC1J+Oy9Ss5VMtb3yPOXIRwVSiNFhV580xBbWN0duR7Qq8ZGPUBfgKM?=
 =?us-ascii?Q?tDJzASdcdPRFzY37b7bZC+oiq7QIhUB5ucA2LI6wXkojRNH/eiZ0LIKxwB8A?=
 =?us-ascii?Q?WFtgmL8nqdYuFqJah9EkB3YGIvsHyxeQCtqWrCHsV+c8aZBflVa1grIrR8co?=
 =?us-ascii?Q?JsLOUegFmERn5LHfd2rMz5OADK+DLNCp2wBZ7784xuc+YbN+OrIJ/QDBbBlc?=
 =?us-ascii?Q?gVNnYzR4y2+2KTRX0f09eLLrJ3apsguICM2aIAB+KKHqlAvWlVPKtOJ2jBIT?=
 =?us-ascii?Q?oJZn6b7K8woMO4mQHXBq0a9M5bpp04fQ0BUbCK5fnqlf3/5NyZ2dWG/lTNl4?=
 =?us-ascii?Q?d1saj/Aw6iHZ8TPI7MqR1MGukMJxfU8fgx9+v/uyacmDpj8a32A/mx3yar9Q?=
 =?us-ascii?Q?T3Xr+5S3C2m4EQ6c1C/7k778Mq7HnNUPL7hEjQLeNrgIfbMA+sHnymAvUzGJ?=
 =?us-ascii?Q?hz2mP7pwfqBLrBYuINtMoJjEo7JufE/aaTqylLEGlKZOTjrfoKFj0s20CKJ0?=
 =?us-ascii?Q?o36VrBuR9bsXFYuB7BGFQkioSO+TP0p47x1sM8bOI1Fm+nPA2K2Jwp+k3mgF?=
 =?us-ascii?Q?iz6bV3VldLuS+FYK8cBKOk3ScOPaOeWfDgWhUubRAL9GYZW075+O/8qEtIuH?=
 =?us-ascii?Q?HumSGyIhDN3F0wiI4tt/aejNAtRtuKRK5ZukxzYwR/bnx+TDlLUNH+1CNYPm?=
 =?us-ascii?Q?9aMN8Bpg2FtSNifDuXFGOF/ZWRiqIscTXjukvUwtPBFBa3BGTTLb2au6d4uD?=
 =?us-ascii?Q?lRQypjnhqpD7xApWuk/PC+ncU8NHup67zGro0tAmGXxzCNo/Aa98OgOIfseZ?=
 =?us-ascii?Q?FxI0WugwGg=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR11MB56557582516EAE23B0AA187BE152ADM8PR11MB5655namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	gw1vsquFhcuIkuA0289KMnvEyrSD/KXPwb+SEV1vU6jG/ft36HEPq59W4NdxA8bq6ZKZcWnD395mh/as6KgA4tSk3H+aUv+XqlauePTsvMsKMm+xHm17d//Tr55Ap/g9YOX7EbgXrcNJtN2dS5kRSBMzNrCizYzxZRKs31xdatcuMbalBQN5ditMzKEGy5ws6TwvNxp/pGWSwUVBjl0kl8HZl4QhzhSbApM3d1COOo4B58huGFDF8Sde2EguvCyzrBxIhsjO5Z3lFk4Wk93iu9jfmLP8o7kikyNU0CgJNos9LnZmFBDViWUNGEg2iL1XWIrSwGz7nxRGOUKub8rN1Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5655.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ae6c2b-2a4e-418a-716d-08de8ea64099
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 21:49:43.2408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ICcB09vBUN84mTuHXius9GySgAD24d81pesj+ux359ZOaZ2waMH7H82uV9ILVxgHvuWfKsw7QirPvhFqNBhc2pJy7podpO667zfCj16h+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 8uMXvZnonUiVdrPPivs6SXaRWJE9110B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE4NSBTYWx0ZWRfX4IFSnIe5M5dB
 ZUmD1tDBEG7VWruh8M6GAnxaWPgvXM31tXs9nj7P2b7mEu47Ihd/zwafDKJuwA8N1LUb1YzLoBN
 FY4Qf9/I4wkElDlvr7w9ld1UeN8jrR4o04PB/JUJO0am5InY2CcKJm+OusX1AZS7ZxAM59cQS5z
 KGwBmTWf86s7BalZfoZGmgDWaPXzTnPR/Ug/ji87E5wrd+ImUYsTyiCPPTRoE4RfWqbNwvz5vxj
 ZDg1AdBYWmuGMRBdczwTFREYnNioKi33dLNnIBN7v+3ziWbgpCZISxFtjNfDDl/uTTp0X9ies/n
 FfdyfpsFXhGiuOxcR8i/wVV2g2p5KBEw6Bop76Eub+7djasVQ7FG2Kn/EKB0rjaEs+ERt69WCvj
 ouTcXD6DbIxQvtt4KWBfYq6kOJXDCottZGobQfHEp9vOTlLuHiNS1Q0GL9CQC2UIufr/33eg44A
 vf8vN6nk7GQwD5DS4Yw==
X-Proofpoint-ORIG-GUID: IA-J_fxUR60deOd_S2qLixlyXUSgjdBN
X-Authority-Analysis: v=2.4 cv=ZKHaWH7b c=1 sm=1 tr=0 ts=69caeffa cx=c_pps
 a=KNS8ES/6Vao0xGfhhZwSfQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=Q4-j1AaZAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=yj-aMKAYKbz0kkd27lYA:9
 a=CjuIK1q_8ugA:10 a=fWAf5wWFn0RPBx_G:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300185
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 21:49:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19284

--_000_DM8PR11MB56557582516EAE23B0AA187BE152ADM8PR11MB5655namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for pointing this out.

As far as Python 3.9 is concerned, it went end-of-life on October 31, 2025.=
  I recognize that some supported hosts (like Debian 11 and RHEL 9) may hav=
e it by default.  Do we increment the minimum Python version when the langu=
age runtime goes EOL or when the supported hosts do?

Regards,
Rob
________________________________
From: adrian.freihofer@gmail.com <adrian.freihofer@gmail.com>
Sent: Monday, March 30, 2026 12:34 PM
To: Woolley, Rob <Rob.Woolley@windriver.com>; bitbake-devel@lists.openembed=
ded.org <bitbake-devel@lists.openembedded.org>
Cc: alex.kanavin@gmail.com <alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [PATCH 10/11] bitbake-setup: Set function defa=
ult to None

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

On Thu, 2026-03-26 at 11:57 -0700, Rob Woolley via
lists.openembedded.org wrote:
> The function defaults are evaluated once and use across calls
> can lead to unexpected behaviour.
>
> Set the value to none and let the function initialize the value
> in the case when the value is not set.
>
> Resolves B006 from flake8-bugbear
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  bin/bitbake-setup | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 2e1e347d6..6b210cd3e 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -45,7 +45,7 @@ def color_enabled() -> bool:
>  def get_diff_color_param() -> str:
>      return "--color=3Dalways" if color_enabled() else "--color=3Dnever"
>
> -def print_configs(prompt: str, choices: list[str], descriptions:
> list[str] =3D []):
> +def print_configs(prompt: str, choices: list[str], descriptions:
> list[str] =3D None):

While "=3D None" looks better than "=3D []", this is still a bit wrong. It
should be:
  list[str] | None =3D None

However, this syntax would require Python 3.10+, so not possible.

Other options could be:
- Dropping the type checks from this function
- Using typing.Optional ?

Regards,
Adrian


>      """
>      Helper function to print a list of choices and align the output.
>      Each option name is made bold to stand out, unless color is not
> enabled in
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19255):
> https://lists.openembedded.org/g/bitbake-devel/message/19255
> Mute This Topic: https://lists.openembedded.org/mt/118523930/4454582
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub [adrian.freihofer@gm=
ail.com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--_000_DM8PR11MB56557582516EAE23B0AA187BE152ADM8PR11MB5655namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks for pointing this out.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
As far as Python 3.9 is concerned, it went end-of-life on October 31, 2025.=
&nbsp; I recognize that some supported hosts (like Debian 11 and RHEL 9) ma=
y have it by default.&nbsp; Do we increment the minimum Python version when=
 the language runtime goes EOL or when the
 supported hosts do?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Rob</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> adrian.freihofer@gmai=
l.com &lt;adrian.freihofer@gmail.com&gt;<br>
<b>Sent:</b> Monday, March 30, 2026 12:34 PM<br>
<b>To:</b> Woolley, Rob &lt;Rob.Woolley@windriver.com&gt;; bitbake-devel@li=
sts.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;<br>
<b>Cc:</b> alex.kanavin@gmail.com &lt;alex.kanavin@gmail.com&gt;<br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH 10/11] bitbake-setup: Set functi=
on default to None</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">CAUTION: This email comes from a non Wind River em=
ail account!<br>
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.<br>
<br>
On Thu, 2026-03-26 at 11:57 -0700, Rob Woolley via<br>
lists.openembedded.org wrote:<br>
&gt; The function defaults are evaluated once and use across calls<br>
&gt; can lead to unexpected behaviour.<br>
&gt;<br>
&gt; Set the value to none and let the function initialize the value<br>
&gt; in the case when the value is not set.<br>
&gt;<br>
&gt; Resolves B006 from flake8-bugbear<br>
&gt;<br>
&gt; Signed-off-by: Rob Woolley &lt;rob.woolley@windriver.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; bin/bitbake-setup | 2 +-<br>
&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
&gt; index 2e1e347d6..6b210cd3e 100755<br>
&gt; --- a/bin/bitbake-setup<br>
&gt; +++ b/bin/bitbake-setup<br>
&gt; @@ -45,7 +45,7 @@ def color_enabled() -&gt; bool:<br>
&gt;&nbsp; def get_diff_color_param() -&gt; str:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;--color=3Dalways&quot; if c=
olor_enabled() else &quot;--color=3Dnever&quot;<br>
&gt;<br>
&gt; -def print_configs(prompt: str, choices: list[str], descriptions:<br>
&gt; list[str] =3D []):<br>
&gt; +def print_configs(prompt: str, choices: list[str], descriptions:<br>
&gt; list[str] =3D None):<br>
<br>
While &quot;=3D None&quot; looks better than &quot;=3D []&quot;, this is st=
ill a bit wrong. It<br>
should be:<br>
&nbsp; list[str] | None =3D None<br>
<br>
However, this syntax would require Python 3.10+, so not possible.<br>
<br>
Other options could be:<br>
- Dropping the type checks from this function<br>
- Using typing.Optional ?<br>
<br>
Regards,<br>
Adrian<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&quot;&quot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Helper function to print a list of choic=
es and align the output.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Each option name is made bold to stand o=
ut, unless color is not<br>
&gt; enabled in<br>
&gt;<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#19255):<br>
&gt; <a href=3D"https://lists.openembedded.org/g/bitbake-devel/message/1925=
5">https://lists.openembedded.org/g/bitbake-devel/message/19255</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/11852393=
0/4454582">
https://lists.openembedded.org/mt/118523930/4454582</a><br>
&gt; Group Owner: bitbake-devel+owner@lists.openembedded.org<br>
&gt; Unsubscribe:<br>
&gt; <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsub">https=
://lists.openembedded.org/g/bitbake-devel/unsub</a> [adrian.freihofer@gmail=
.com<br>
&gt; ]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM8PR11MB56557582516EAE23B0AA187BE152ADM8PR11MB5655namp_--

