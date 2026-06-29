Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9DEC43327
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 14:41:19 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39027.1782744074040996020
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2026 07:41:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=CBv0Gs0q;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=1640d110f4=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAW9512544206
	for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 07:41:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=5IrXCP3gao+hSfsQ7yT1l8gtrCIQN4VYluDl2+YbkSY=; b=
	CBv0Gs0qxQmaE/g7X12e6ml7Oi5I/zcohpEHVik5YWTWQcL7iR0DYTPJmNqwaTOx
	RlJ5K0YgdcI8b/cyUD8qxa99aKl6IL0AZEny3k5DCGQEC00tle2JhGYWK35nNeFE
	7c33HLk26JjnI4GOL4X1lTeUUVjbo+n1A3waab7iviUXCyma7ieTBm895ztPvxzW
	m9UR1drFfO6cTDufukdcY+MrQ76HZktcDnFA0y9TmUbwNOoYVasl2UvL483pfpHW
	+67kc3j5mnupaNgzWAU1cEUiBvy/6+oozRcHDZVPC0g9DbE8SX/RBgj1S/Mid6jz
	QU+ehF/a6gwg77ljkGr+FQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f2e1gt1e2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 07:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lpkw1NcRIZCny+7q884Rt91cpTr92pmFJLGycpAt7dsjaxYBoIuLIrfQTS6hqliZKLQ1Iav9UrVyUK7tDg5iPE/QvdCuqysRiJ2hF+rO4wUo1L3hUYyxdikhndgEY+/LMXLnWzIJhy79LOdL0amqGhlFV93R56lBqlriYinREwMcvqFnHYWMd4InCuQaPXFdXrvMx5wg3EMbSCV8igmY3agxvFlHd3zZ4kUqzDQc+73TBSFmI6JKFIgQmw/uAnU58578dMW//cU8s+vOqViynPzW91Fmria9HPzSgRJ4YSgiUYpUa/ghjqfYsiZi+cbQfMbtarH+7VvO5RDzxtxlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IrXCP3gao+hSfsQ7yT1l8gtrCIQN4VYluDl2+YbkSY=;
 b=gSU0pzL/u4+BzXorTHX2RbwzVMjiuzatiPxP3PPwQq5zVV/xRmXAYJQZ5khuyAf6lpnqLbaM4IKcoN5J5H/BfceWlIP7pF3XtI3bk6nfhmg2MGxbDfx1fs0BKfnpooyoMOUbEUe9fwKmC3u8gX6b8MSO58UOWpxvNf+gBbyahzWy1W4gHBR9bkTCc4AXxcAMZMZmHgg3NiEB50C6YPgw9zQgksu4oKZ1WenXaR9AVHtGnxVK1nN8FDMHiP1tD+KxVWvGNqvq5cFwvJlUYbSPjpQDrVb86H3SilpHeuMY20h30jYGrpY+J3DLMQLCobuV5WaFmE6cwy/3nyoA/VfNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) by
 LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Mon, 29 Jun
 2026 14:41:09 +0000
Received: from DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::ce1b:9c1d:d571:9eb8]) by DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::ce1b:9c1d:d571:9eb8%7]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:41:09 +0000
From: "Woolley, Rob" <Rob.Woolley@windriver.com>
To: Paul Barker <paul@pbarker.dev>,
        "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "ross.burton@arm.com"
	<ross.burton@arm.com>
Subject: Re: [bitbake-devel] [PATCH v4 00/11] bitbake-setup PyPI Packaging
Thread-Topic: [bitbake-devel] [PATCH v4 00/11] bitbake-setup PyPI Packaging
Thread-Index: AQHdA/25DdIZvFVeJESryUg9cByoq7ZVRRcAgABEfD4=
Date: Mon, 29 Jun 2026 14:41:09 +0000
Message-ID: 
 <DM8PR11MB56556BA962530E3947666CF9E1E82@DM8PR11MB5655.namprd11.prod.outlook.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
 <638e859d9a5d3c4c53b8f471930f11a458c20581.camel@pbarker.dev>
In-Reply-To: <638e859d9a5d3c4c53b8f471930f11a458c20581.camel@pbarker.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-06-29T14:41:08.625Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5655:EE_|LV3PR11MB8768:EE_
x-ms-office365-filtering-correlation-id: db135394-4fc7-44df-20d7-08ded5ec7558
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|4143699003|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 
 0qOS/qKq6jV0Ojz53B1znSR9P4gj7W1k9DETvHoYVT7uhOXH5wuGHl2vGmg1fjq2o0JYhIKMOCa2GrVUkUgWc8RtKIxTYSJ16F6xX8Al3eH28v50tSXmjmhcl9Vl/kR2qvzVyk03vaBIkf5aY5lPn2WXmgL0gKr7b9QQHbU0JOmXViOvDA9g8De7V4cIXfU6sh9EDkIxjPs2p/pT/8FtSyXF8W2rIpcQyssTpmzfMA3kB3LXdd6daDVomUKOlpkjsPFDk77TuLT6/pwD0H/0yhgyrfCA9MnoeG1zqbRc6JvuZgIRgdH2LhND70gMEA11WfSA4u2wbSa8TDhpuADY35pewYr458q8XwpsTzRd5+nhRlDYIakKyiu2AQ3mB08oAQ8pSzPJUWL9oIz+GTctEoRpSGWx9SFxl1oKo7Hg3mcNeEskRlMq/HCXAIEC5qxvF01KDN8HmtxfxPZfnXYdhy9Iy8D2CPYs9wLRxUEuvSJQtfIOkZZtBjfpoworgqyLAFe220HShIG8dPApJBVYFUPD4Ogt4frIko3wblGojbP3yBnHFuJ5mboqbzfvp/LXy/IZqaQ6Xt92wOg5ktyMKOwuksehceSAUn056cJ+vdxkj/4w5xzyOr21uAlUHy9d3iX1kotonFERYS+pr9o9zXH6sGw4vD60tyOC9f2qngZMf+AtMhEb9PeRTNfwtWyfQgrmy8azhH1i6mMsJy/DFEsRBttXlBUa0SSPToegjGg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ebrCMqxxBjCPunSF9piA4Ai1rjZZjr4c/n4LwrEwQjDKOd3gpzEWHmnUCz?=
 =?iso-8859-1?Q?GtSG3i6BIl6y+EmeG1iZgfungGD4Wd5G/u0bznt6z7JJIM8gM7q5cxufl6?=
 =?iso-8859-1?Q?CC6NuVoKU6KK9ZVdPp/IqKET3W86dxVbdCT5Y8gy3RGBMhkDky60tZFg3P?=
 =?iso-8859-1?Q?wa8WjEAtQ6eIougSM8QFjVKDo0M1cirLMzycHg1U1bbVLiowOhrtfonU5i?=
 =?iso-8859-1?Q?tTovIqGcjAwhD4Sd/qUSiQ+VSoWsiD3LW+Lni0PDnCYVu1EgJMmQcI8GIu?=
 =?iso-8859-1?Q?UGuVgrV/Hs0pAx1JYDZvwOSTHk1yV2FEQvssjxY+Cv2f37QEEmqSZrweEP?=
 =?iso-8859-1?Q?WG9beFYiE42+SxsGTJ2ZBn/YvKz/qLAIyJyl8lqO4Q44IuI45R2cRfyJX5?=
 =?iso-8859-1?Q?4UiUo041uoGN5s0YXqzqs2vbn7xgEaQPsP5jN4lSZTTl3a08vzDaqFwcBs?=
 =?iso-8859-1?Q?LRltlnUM6LVtjBksc/bU3gF+2pMNEzcJL3ELn+27wP56Su4PIVHS5BTeUI?=
 =?iso-8859-1?Q?KWeXYNaWRSZa10WMj4DAbmh7XRSg/KtZNL9uYsjymF2QmxkgqcECm5sthW?=
 =?iso-8859-1?Q?cDFIv+BrKwy9qScYHOKXt3aZ5RiQ9FEzJ+IbQ4QTqiNRW09aUoDMVMFGca?=
 =?iso-8859-1?Q?IfCKPpy2HZ4Vr6kEpTANMEseh5Br6B2YImqEjtdgb/8WF+nAzfYyu4TVh0?=
 =?iso-8859-1?Q?6Raw4qq4sGmCXZdfpvBk+B4g83WjVpwcuWRJtCmkg5fLYfE3FHKdI+a7kF?=
 =?iso-8859-1?Q?ix8zH2VCRMTV5cEOgWFnpE6fF/nqRHGWnVcXqRW9wlHNX4acoGZ+lzxqoh?=
 =?iso-8859-1?Q?NXFccSE9QEWkYx+c+I6LkST+hjCEzwII3UKRyEB18pIuBqnA1sgknjo9++?=
 =?iso-8859-1?Q?ifABeNWfXOnNvXJAkHgjUaLIlwaxqxZFWpTDcZwXPgAwmkWjIaQEg234UR?=
 =?iso-8859-1?Q?0PK5JzEaeq1R99wRWC+z+okJMG2cUDHR9ZWBO2D7Q2imuVIPIX1kDGup/7?=
 =?iso-8859-1?Q?oSe8NMtqNNdz9NdTfhjZ6LpOtHUxeHO83OHM1AjcEJaXovsEOmLvwic2fX?=
 =?iso-8859-1?Q?cmCrqnRbRHN6QnAZNobt/xRfQQ37cJDy3K3cEqLA2IhEYbPkpXD2pNYfSs?=
 =?iso-8859-1?Q?9Fq/MQCUpNzKgOH/Q4YBgfEFn2UqNvBjoVrJG8rORI7R52m3wsa9+PvM3h?=
 =?iso-8859-1?Q?UG+xh0XMQmQvQb5S+5wr70Lf1qQ443LQacN+57Y3awydVwWdDlsqCFArrq?=
 =?iso-8859-1?Q?WRHqh0FgUjzKtMGBBTVTiV3Bgxfa7uqWFcUeW3mhyKp6Y22FZ7PgMNGC8q?=
 =?iso-8859-1?Q?9M1bRjcJZzwNtCEdG6p6Vl9hJqqaWjb9Apv1RuGGFFimzNJMtUu5TcoAfc?=
 =?iso-8859-1?Q?zhE7j4wVKA76OVodQiFnmcWW05XtXKFvFr9WYHbcI+c7y7Ll2iP8fiTZVo?=
 =?iso-8859-1?Q?pa7LXwvx8n5cGaOawxPxIBSxEu3f/2NWVKfaPEsTvQqctNO1ndkgmMSGU5?=
 =?iso-8859-1?Q?w3IpiZ+NsbBZ8JP9kUwafPj7jNSe+zU4Rq441LFYFN516emhFVo1T5rMKE?=
 =?iso-8859-1?Q?gahpqpEgKWcOrKgw1MjXLCADc0FzkJfGaLX3gMh6/r2jX9t/FswNJAAVBY?=
 =?iso-8859-1?Q?9q/gNavNO5jaVZrLFNePhSuRA0+DbkUNfq9RVgx0I/cQbxcBW6yeMkTC50?=
 =?iso-8859-1?Q?4jk8yePyETdJH0ECrlqnu1PIW3l0vWggS4L9uAAcMvCDrv4PVCE2vTEZn/?=
 =?iso-8859-1?Q?eVS+Kp35NWcFWbyd/60rxevToFNdpZAJ7Fs6A81lyMPalIsW+3GkvpR3te?=
 =?iso-8859-1?Q?7FO9dY+JUw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	tCXXfh00iWoiL0iWgyD0CYUAQ41D0F4ptNoEhqCG0mfM4ADuxG/FAFRF2j1swTbRQrsZ/Ve+fLb9ptQ5zz2bvuhE1RzXcCDKe9kKwsz3Pm3q7HayjgYDQEbzQl4jYUuedweBmr/1s/k6TyzaBZRkLA86CUWlZEFNdc91YkVu4z992y4Y76+D4YMZWvEfTKWJ7ypFU7ueOyYl2s1IZQy67i9WIxPc58clEMH3banNPWHH3rySsK57XihKjwsd4wFH5B8xBVvoViklcysbfoJ0rBbpTI9LQUaVAdSy6kMQJEr9xFjgdlfjidcKo08303qDTgRXUVESwBJUiYAhTXoUsQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5655.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db135394-4fc7-44df-20d7-08ded5ec7558
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 14:41:09.0130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivy+Gps7RQvCi1AxymfSvGnN9w0ruLVneqBq4G3XDMU0x18j+qzP5Gugrs83oysMvg2N8xyJ5z6GuvYqm/h/QNACOKXlU3Ma6eah5/b1Kns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8768
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: l6YeUQBJITgHdgxLpzoWXY83z7u45juP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfX1aY8Ycli/yDb
 m+2PbeoMeu/rarUfqT+MgnrCHJKZ5S284fYaYAM3DGSLFk2Sle5LMrJSecMqeyMUpAN+4rAXiwY
 3SjMyN1gZLG/aHyMQf4Sa6Bvj/t16G3CWwE/uLGcWoycbKW7Q9o8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfX+8oHKd0iu65O
 GtXadNNlJUkk3hgJyKa75BrYLja7Uu2D9rTpqqYfAB0PAaH2Ju3kqJ4DF0aIA4RJUfBa2UU7TLT
 F3paRi1DQLkVh0vRP94B7Iqv3Ei4pckQlk9JGi7iNywnCjoA3f3XN7Oe/24URFdf0wBayQiqzlT
 5YeiKO3qP1JFpHM+/JEOj9dqglrjT44zqy/0i/vTSCtDOwYO5QXaJ6ORVxtDAEI8vTAGGuWLnA+
 BmH1WIQmtAfbFvkEuc9myn3U6Y75pVGZP9jfhzu9kwBNmkesuchdBdrvCbfXGghbxnav2tYs07s
 HKBJpYpS6FV7nfHKHXAcxA+BZUBwKmPY6hFDiabbqe3LOMBYeuiTzDrEiBK8ExEF/nnfrqk43mN
 ySfRnOlT7A5rMeiFRQZHCbRcXRxXL6gvrj6a3hE7u5GGvnENgfRy0YSY31Q9cd/cNFMCkiGV3EH
 gvuUI86ab6PvDRkCMMg==
X-Proofpoint-GUID: ErRtePinzmrxKOkVudjNAHLOKlc990s0
X-Authority-Analysis: v=2.4 cv=GsByPE1C c=1 sm=1 tr=0 ts=6a428409 cx=c_pps
 a=iil3+hz40n0Eqb4YezF7BQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=NEAV23lmAAAA:8 a=CckQENj0AAAA:8 a=dXvAoEkxAAAA:8
 a=Q4-j1AaZAAAA:8 a=QpAX3DRp-B4f2aFaUWMA:9 a=wPNLvfGTeEIA:10
 a=iJ39DRKJB4kz2P1Iyp3E:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290122
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 14:41:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19807

Hi Paul,=0A=
=0A=
Thanks for the feedback.  I agree with your recommendations to add more exp=
lanation about what is going on.=0A=
=0A=
I don't think we have had a formal discussion on which tool to use for mana=
ging vendored modules.  I went with vendoring for 3 reasons:=0A=
=0A=
(1) that was the one that Ross had mentioned he used before=0A=
(2) vendoring was last updated in May 2026 whereas python-vendorize hasn't =
had an update on PyPI since October 2022 despite changes on GitHub last mad=
e in April 2024.=0A=
(3) it was promoted as having more advanced features and better suited for =
projects that are more than just a simple CLI=0A=
=0A=
My take on the stability promise is that they want to make clear that vendo=
ring is intended for pip itself and they are wisely marking other uses as u=
nsupported.  The result of this is that vendoring will continue to be maint=
ained as long as pip uses it.=0A=
=0A=
I interpreted the general rule of thumb as recommending against vendoring m=
odules if you want to be in PyPI.  However, there is a notable exception fo=
r packages that do bootstrapping (albeit they mean Python bootstrapping) an=
d those that necessitate changes to the vendored modules.  I feel that bitb=
ake and bitbake-setup could argue a case for both.=0A=
=0A=
I asked Claude about what would be involved with switching to python-vendor=
ize. One important difference is that it does not support automatically mer=
ging patches against the pristine source.  If we went to use it, we would n=
eed to add an additional tool to automatically apply the patches.=0A=
=0A=
To the question you asked in another e-mail: these patches came directly fr=
om the git commit history for bitbake.  They were custom changes to the ven=
dored modules that I reapplied after the update.=0A=
=0A=
The vendoring module also takes care of license collection and generation o=
f the .pyi stubs.    We certainly need the former and the latter may be use=
ful for improving good hygiene going forward.=0A=
=0A=
The import rewriting style of python-vendorize is also simply relative (ie.=
 from . import x) whereas vendoring uses absolute imports (eg. import bb._v=
endor.x).  I think the absolute imports would be preferred as they are more=
 readable and produce fewer errors.=0A=
=0A=
The versions of each upstream package is currently being stored in the vend=
or.txt file.  The versions represent the published releases in PyPI.=0A=
=0A=
Hope this helps clarify things.  Happy to continue the discussion and make =
any changes that are required.=0A=
=0A=
Cheers,=0A=
Rob=0A=
=0A=
=0A=
________________________________________=0A=
From: Paul Barker=0A=
Sent: Monday, June 29, 2026 5:06 AM=0A=
To: Woolley, Rob; bitbake-devel@lists.openembedded.org=0A=
Cc: Richard Purdie=0A=
Subject: Re: [bitbake-devel] [PATCH v4 00/11] bitbake-setup PyPI Packaging=
=0A=
=0A=
On Wed, 2026-06-24 at 10:20 -0700, Rob Woolley via=0A=
lists.openembedded.org wrote:=0A=
> This is an update to the previous series to rebase on master. It is also=
=0A=
> available at: https://github.com/robwoolley/bitbake/tree/b4/add-pypi-v8=
=0A=
>=0A=
> This version of the series integrates the vendoring module to update=0A=
> beautifulsoup4, ply, progressbar, simplediff, and typing_extensions.=0A=
>=0A=
> I also included Richard's latest commit to add version variables to the=
=0A=
> bitbake scripts and dropped the mechanism that I proposed.=0A=
=0A=
Hi Rob,=0A=
=0A=
Patches 1-5 and 11 look good to me.=0A=
=0A=
For patches 6-10 which improve vendoring of upstream packages, I think=0A=
we need to document things clearly. I've also made a couple of review=0A=
comments on some of these patches.=0A=
=0A=
Looking at the Python vendoring module [1]:=0A=
=0A=
    Should I use it?=0A=
=0A=
    This tool has no stability promises -- it has only one intended=0A=
    user: pip. There may be unannounced changes to this codebase at any=0A=
    time, as long as the intended user (i.e. the pip project) is=0A=
    prepared for those changes.=0A=
=0A=
    As a general rule of thumb, if the project is going to be a PyPI=0A=
    package, it should not use this tool.=0A=
=0A=
    Many downstream redistributors have policies against this kind of=0A=
    bundling of dependencies, which means that they'll patch your=0A=
    software to debundle it. This can cause various kinds of issues, due=0A=
    to violations of assumptions being made about where the dependencies=0A=
    are available/which versions are being used. These issues result in=0A=
    difficult-to-debug errors, which are fairly difficult to communicate=0A=
    with end users.=0A=
=0A=
    pip is a very special case with a thorough rationale [2] for=0A=
    vendoring/bundling dependencies with itself.=0A=
=0A=
We need to write down why we're using vendoring despite this warning,=0A=
with a rationale (similar to how pip documents this).=0A=
=0A=
We also need to document who's going to run `vendoring sync` and how=0A=
often. Do we automate this or rely on running it manually?=0A=
=0A=
[1]: https://pypi.org/project/vendoring/=0A=
[2]: https://pip.pypa.io/en/latest/development/vendoring-policy/#rationale=
=0A=
=0A=
Best regards,=0A=
=0A=
--=0A=
Paul Barker=0A=
=0A=

