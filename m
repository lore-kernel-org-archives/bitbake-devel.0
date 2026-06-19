Return-Path: <Gabriel.Smith@belden.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5FCD4F26
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 15:32:56 +0000 (UTC)
Received: from mx0a-00015a02.pphosted.com (mx0a-00015a02.pphosted.com [205.220.166.249])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45392.1781883168656089890
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 08:32:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@belden.com header.s=podpps1 header.b=L0Bw+q61;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: belden.com, ip: 205.220.166.249, mailfrom: prvs=6630782132=gabriel.smith@belden.com)
Received: from pps.filterd (m0264209.ppops.net [127.0.0.1])
	by mx0a-00015a02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JD8Amr025015;
	Fri, 19 Jun 2026 11:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=belden.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=podpps1; bh=EO
	S78s9srkvYdy/cOWjGyLZ6tSo88wVN+yAXASWp/2U=; b=L0Bw+q6139opodUy9m
	AkFl3iGawiTcjLXOCc93sc16PKU0a85jZ8lndNffPmj+pEL3eVWdGGfyrhwyH/Yi
	8fw/sZ4UuvahPNZDYSYu9L1iaySp6gohlwYyuOGlBd3yCmcN50kX1icsUcizJ+4y
	5DtfYoWm6rfZR02nvewP3zzoin97LTegX7oyMYcuz/fSApMqzXoQVtLgbtBr+djJ
	QZ364K/UH5w+V7xEwSVQEWZNw+IQMiafeEzAUJMzIcue6i0NdirtSLEUg7m3WeZ7
	7fYWxpIMvC0YY9TKv8oPq1VgvPawgePKxWQ0ucIOk0h+2TB4JvM6ue6AnkPxAhzF
	0rhw==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
	by mx0a-00015a02.pphosted.com (PPS) with ESMTPS id 4euefp8c9n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 11:32:47 -0400 (EDT)
Received: from LV8PR18MB5783.namprd18.prod.outlook.com (2603:10b6:408:1ee::7)
 by BN9PR18MB4329.namprd18.prod.outlook.com (2603:10b6:408:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 15:32:46 +0000
Received: from LV8PR18MB5783.namprd18.prod.outlook.com
 ([fe80::29ac:d0ba:6581:49c9]) by LV8PR18MB5783.namprd18.prod.outlook.com
 ([fe80::29ac:d0ba:6581:49c9%5]) with mapi id 15.21.0113.020; Fri, 19 Jun 2026
 15:32:45 +0000
From: Gabriel A Smith <Gabriel.Smith@belden.com>
To: Paul Barker <paul@pbarker.dev>,
        "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] fetch2/crate: support user-defined
 protocols
Thread-Topic: [bitbake-devel] [PATCH] fetch2/crate: support user-defined
 protocols
Thread-Index: Adz+it1ciEWyYGSUR4y0gnoqQpn2SABWpN4AAAZ0L8A=
Date: Fri, 19 Jun 2026 15:32:45 +0000
Message-ID: 
 <LV8PR18MB5783D430D2D2328AB49B035C82E22@LV8PR18MB5783.namprd18.prod.outlook.com>
References: 
 <LV8PR18MB5783EC1D3247161CBB9FFFB482E42@LV8PR18MB5783.namprd18.prod.outlook.com>
 <8754f7cae81e11a3fe2f1c7bee93d07464c5679c.camel@pbarker.dev>
In-Reply-To: <8754f7cae81e11a3fe2f1c7bee93d07464c5679c.camel@pbarker.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR18MB5783:EE_|BN9PR18MB4329:EE_
x-ms-office365-filtering-correlation-id: a6e30f86-6bde-4fd8-a5c3-08dece180309
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003|3023799007|4143699003|38070700021;
x-microsoft-antispam-message-info: 
 BG9Ga/PM0qYMvcnb/Mm9UaO7sWt8KSOdLSbFKk+Xjybnkd79t9MyOcM4vEWP0cZKesXt57Cqunz28jNXCfcobEFkhQFs35YS2pAdIs1EJhsB3PsnL4ShwyiPd04sqnQBlM+U98Dsr449u9qf/c8NQqRY3qaI3wstNTs2ir12nPRVTeeh176MD6sBMVgE0iCuu/Vg+MgyLSzLcYFAkZ812IPEFnZKW24xoEaBuFXSBbVdmBV5oC/otEFt9GjwRzCPfrOw1oMdkelbUXQZdyHNLLVkg2JqZoylcxVptYuVMoaQQEUi4bgBz6coIe78JHZhBfKg4nMqkCKHNN4uAEIh7QbOACPMJ/NBXnrcHY+pCnl6SL+3pgLl51Cv3rd+uC158FFrRRGPZpG9ELaA6uvaHSPt1cJbHANrgQicTjlCytu0FePnRXTL3gvq+RyxWVI3OOrs8HLJFzXBmjYgRLwB9q6/eXg39l925IJQPTOmFLArcFw03CB40opdHAwGmBjgaFEnmFO/Q8JmcHJP+gUB/TYuTqA3m/e2qI2feuG6Z1SSU376eJ/0SSGwuQhMkPE1yqONs8efRm5KSJ+TwXMqx2zVVK6IFSC7K7K3mtYlnolyHKCWSEUEnUM3KG+lddo+kXJGMFHLiuOmZNtybfrwCDZzoxF8KF/IzXZ5ejke4r2bbe6ex+xFHs2HK3Xs9Aj/TEkMQ48ODQ9Q5rUFYvQ+YRi1Hmm2dgcFnRI/+6Ns3UU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR18MB5783.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(3023799007)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QjFyVTlmaGY0WW1pK1Qwc0h2Uk5uczRiN3pseUY3cUhvdXhrQ0tMWDViOTZE?=
 =?utf-8?B?c211MlVFRThyYVJQM20vYmYraTVURDl2N0VUTWFweVVueWJlSWJyc21iQU9z?=
 =?utf-8?B?VGg1Q2NDTE5TRFZURzgrZ2ZJK2xhOUZPdGduSkh3c2lqYzZCVHZnM2VQOWM4?=
 =?utf-8?B?b0crSm1hc2l4eVRQRTh4czBOZk00ckVvZUxkZkFSc0dKMUJXd0FLNjZ2WlUw?=
 =?utf-8?B?b1lQOEYyWkVxNVNDVTVnVE9nNVd1SjFic3hUMmlWZEtmZW9ZM3JTZW1keU54?=
 =?utf-8?B?eE8wWHMvN25XWW9zeUxMcUYySXVvd3NrRlY5RkJHV3ZQYndRZGNZeDJCL2p3?=
 =?utf-8?B?bG1uczZkQ2MwUi9YVm5Oa21FT3gyYmVONE95bkNCak85dnNJWTNDRUg2NStu?=
 =?utf-8?B?ZENiQWR5TjB3bEVJeDBNcHhLeDJhMzJyWk1CZEJIWWZpTGRPWlNLbW5sNElZ?=
 =?utf-8?B?cS9heUVJT3V5czZwRzEwS1hKbTViTEZ0UThQVXZ3STR0RTZFVTNoM3VqMGRx?=
 =?utf-8?B?ZHI2MVZUOUU5QVpDMkZRd2FsbzFRS0hYbmcrZFRSUlBBN0Noa0VBYWZOQkh2?=
 =?utf-8?B?K1QzU3ozQXRQc3lKalJjTWxDeVE1Z2E5bFdMVGJxZFlXOXhyZHpCTUU1RUsw?=
 =?utf-8?B?cmpxZjBiU0hIRk5wZmVrdHpCRFZiUFd6YTZuRjEzWXNORzc3elB5TkdOM1M2?=
 =?utf-8?B?NTRBbVJGcWRyZW9kM0Y0VmI3QkpTQitRZVZVdVVxakNna1lRZzExdkd5N3JI?=
 =?utf-8?B?VVZaOFNNTlRteUFlakJwNDFWMlltaVk1c2lVZEp1Nm5TbFc3TzJ3eVBoMWdU?=
 =?utf-8?B?OEFaWUo3RE0vdmhOS0VZT2lTQmY5SEhrNEtwS1FhMEt5UkFSVmFWRHEwbGdV?=
 =?utf-8?B?SE5oTXdxT1lncVh3d2ZmemxEd0ZVLzdFNE1QTUlQMTRBcHdPUWRJSGFBRCs2?=
 =?utf-8?B?cERMQUNGcHlKQlc3Z1pIQ2xYWG4yZGd5empNSVBpR3N1RTFBb0xKazBRU3RW?=
 =?utf-8?B?YWExbzJvVGdZVndxMklHZmprVVpMM25ocVZ4djhwVzREZmRqRFJtS0U2Kzd0?=
 =?utf-8?B?UzkyaXFpZE96WnpKT1MyeVRrcnJHS3FCa1I4RkFzbWZrY0xLdmdWSlV3aVBx?=
 =?utf-8?B?TERrbmxzTExCU1pFUkpscmE4ZHNpSEwxK2RsTDE5dDFzTEMrem4vYmN6VHJm?=
 =?utf-8?B?S1VVQ3ArRU9pcDhQMDBicnFKUWpFZGRTZjVCUXdha0dKOHNJVHMwUDJNb1Iw?=
 =?utf-8?B?VzVUd2VaMnN6a2taT1ZjTEVUNVVIeUltYndUNDJkUHdLM1A5UGRQOVFVMFRS?=
 =?utf-8?B?RVFlbGdPR3dTSkE0ZTZrS05SaThuQmViZXFaZzRnVnJlY21NSGd5Tk1ySlp0?=
 =?utf-8?B?YlloQ2tWTEpaR05SYXF4K21PdDBZYTZ2a2o3dU84aDgra3RlcElXUmR3T0NF?=
 =?utf-8?B?ejNDbmxuWGQyZ2M4bXB1akhBNHEzbDg5UDgxVVhrZEorOFE3c1VxaWtCMzFB?=
 =?utf-8?B?akc4WGE2Qi9FaDg4OGhuL0V2YkRPZnNpYXl2R0xSTC91Y1JWWnVFQURRSUlM?=
 =?utf-8?B?UFhaV2NGNUs4WXFDV0RBV0Z6WmxCWFpMZkpQeVV4MEdMTzVscU5IcmpGRDFT?=
 =?utf-8?B?UmFwMnYzY1A2MGxSU1IzbXdaQ0JUZnF0V1VyLzZEc2FUMnV6bXNGTW9lS1ow?=
 =?utf-8?B?V1dPNi9QUUNoZzNGRUdaNmgyelhYQ2Rhb3NGSkhPN2RWcks3c1FJd1VLUHho?=
 =?utf-8?B?UEJYeVdLbmJaMUNvdU9oenZhcnVRMEdXc3czZnN0N20rbU40ZHFRanlYOTk0?=
 =?utf-8?B?aHVnUVBGeFZtU01BZWpzaUNiVVpUQlBESjZQdmJmSFpNY2FlWWg4dU50MUI3?=
 =?utf-8?B?OVNHLzlPVjFzK0Z6RnJybXVHMmZqY1ZIdnhZVGdkR2I1SWxhRXZtUDdjdHJv?=
 =?utf-8?B?cnRNQW8wUTBkazdXSVZRWmEvOTZNOXptdm12WndZeU5sdWlKVzFVTWRZK2Vj?=
 =?utf-8?B?VFRkbTdZTUQyUFZNRC8xWXRUL3ZFVmwwK0Z4NGJVYjVKQWpBay8xN2Raei9W?=
 =?utf-8?B?VU1veHlrd1hZMGJ2R0pURWRYSkNVVFk3YzNPQkZZOEQxUjVzN1NFM0huVGJD?=
 =?utf-8?B?RFpZb0dvR0c2N1dOU29xa3FZVkJrT3R4NXcyMHBTbFA2bTUxVmhDc3BJNGlo?=
 =?utf-8?B?Y1VKZHdUV25LUDBTQ0htaTNDY3VCcDRwUDlNQnZOVHg1QUgyZjRTcEluRkNq?=
 =?utf-8?B?MzlLeGo4T0RrWmwzUG5YS0NzZVMreFlET3B0VmJQNDQ4bVJsNnN4SkFUWXhD?=
 =?utf-8?B?Z3hFN3h4WUlqTGFjMFVJc2hMbVlYVVBkTGU5WHA5ZENheVZaYzMxdz09?=
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	b9XefnqX8LfYj6VTXmbVix+wHtGyzJHzTOTqiiEkuJftgxdyCyBLGKMk6V/qitI/NdCAHgIFvp1vKYgt9YqB2llTUEnKlcpjOUFCDqHTmA3l9WxiAC2NX8aqZFf3oBQ5JOv2iSncioOzUC71wX7RSPlknBXxpPNqmOM+//EByfYHVKR4bn399Y+1YvfA2AzsWevHOeryWzeQubPsnHTZcM11ZpAeukJ3pcYDqLlUGJveCazkz+KXO5ItFZUGU4ynLtxSTlu1xYo8Poidlz0ircQueaxVRX0zcI1YR0FirrqPLhjPqNMKowga4m9CyoYC6Pr2dsq1fCXkCSPpLzq6rw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BvrpqEzAWsOXvDh8Wg687hrQAQKpmJC22O6BToQ6N+dU/Fj8ru12XIqC5eT6A/RucxphSVbD8CtXI8KO5jkqMPoITcM+yRKtdSLiarNshCr7rtsXY4crVJWwwT1lUT+c9WvJLq+a+XjMx35cq3hsx9nG4C/F3jjo1NU5HLUgo5KpZFSZ+792bjKyZCllfPDr81Ow5s6k+4ERXGxIB031fun43NbZ7lAInnpxXzEjqEI5l+r4Hfq1rTWp5nRRltpDt0i+p7DVPaU6uXk3Pv/xZSpVT9ZiGXKsnm13jycD2QDfpQrB5c1yp7JfwnJRHtuaaVwNECTTJRaFABTczk6QkLSCddB4ORMLriX0ORdQOh0zPEKmt1DrfkI+uFb3dBitm3BgTQxamwmP6J+HeblTJE1xm5fLmISZu2BMU66lov7B2DfYCmZkjbPnNXISB7XX6HxHGuZywQrdMfHP95tCMICqo7afGeBTd75yp6uppUbJhB614M+8gfGTP1IvTqpEdQbD+mPibpN57N4R2MdY7UUAIEKl/aqWWNRDn2v08QzI28y56HqqV5pTod079c24dOZHbk1NBixgT4xTTI0qzuB8epIQ/8Aj5I9SOs9wl6fOCnmaxeTczHrc5pTPHYNXb+tTTLp0dkGEQTwSAmOFeA==
X-OriginatorOrg: belden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR18MB5783.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e30f86-6bde-4fd8-a5c3-08dece180309
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 15:32:45.8161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0f7367b1-44f7-45a7-bb10-563965c5f2e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sk3SwRV4F/qFd9cVctjW1GIqX2Wl/SFEIw9q1mr+VgZG2TqvTj47vH57dmMK5QvouPjN0wgY2V8RMVNg9ZMXucrOrBMPFNxq06ydHwn8JAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4329
X-Proofpoint-GUID: gLrzGHzPCjHtX69GgF3AimWtPJF-7ZUu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE0NyBTYWx0ZWRfX6qsXq8sVbsfh
 7h6CsYiV1kcZvcqCM4k5f2M7zJIvex6hpnELnAOgjONLpxw4t5ZplQbteiXQGxuhCTZm2ixojTP
 YVrYP6J48HuoW0m8ZH4jS4o7t1neWsB/WozmCQcgyNa8vxSRjfGl
X-Authority-Analysis: v=2.4 cv=X5pi7mTe c=1 sm=1 tr=0 ts=6a35611f cx=c_pps
 a=ynjcjXHaqbEn4NYQb+mZsg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=mCf63rc527wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l-oUmhW3RMErs0E8rZCB:22 a=a2ZsPtzfcP7D9cjObsVI:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=WDlp8lUfAAAA:8 a=Q4-j1AaZAAAA:8 a=4z9Zy9h_yXJVJ1K-MBoA:9
 a=QEXdDO2ut3YA:10 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE0NyBTYWx0ZWRfXxPb/drFrzu4a
 bNNnFCao8cycyn2bV19kkWWl+yiK8dDCvxNrv9tNjf/i8XUuP3Yo2xz3t1wZWPOhrDfBlQVXtnW
 /vDdtwDDTbdlwQOV5N1dDrtF4AXsk8GMNKek3xJGwNu9/6qpc/+g2nZijJd8ix5+YOdIuWzLF3l
 T70uyfms7R0i4swcyhBWCXmzfMqXGyvEP4dtuZdnx8LWoc6plfEhxx2Dz8FSLa/sWdSHraxzYny
 79K77CTxHMd+yZy0nV03MfcMrpLlJnlwOqm/60CKKtrLVV4XhS0RMJnWwlQUlH84IAXP/Aei7et
 J6E1EyUGgRNAwO0+uT+d1fe9PDKYF15u+88vvBB7MWWrozMuB82k9mlO7f/eJIM8h7pbVYHLzfX
 mxYGcxu+Mxzu8dAIiRJeoFuse9Ammu39fzaFa10uuwdgXNWnvhwl+ZPotZV6flAUFDw3vRzRWob
 7IRuhAoEoZd5O2cL2Kg==
X-Proofpoint-ORIG-GUID: gLrzGHzPCjHtX69GgF3AimWtPJF-7ZUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190147
X-Proofpoint-TriggeredRule: module.spam.rule.outbound_notspam
Content-Type: text/plain; charset="utf-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 15:32:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19751

TXkgY29tcGFueSBoYXMgYW4gaW50ZXJuYWwgcmVnaXN0cnkgdGhhdCBpcyBzZXJ2ZWQgb3ZlciBI
VFRQLiBXZSBjYW4sIGFuZCBkbywgZXhwb3NlIGl0IGFsc28gb3ZlciBIVFRQUyB1c2luZyBhIHNl
bGYtc2lnbmVkIGNlcnRpZmljYXRlLCBidXQgaW5zdGFsbGluZyBzYWlkIGNlcnRpZmljYXRlIGlu
IHNvbWUgbG9jYXRpb25zIChtYWlubHkgQ0kgcnVubmVycykgY2FuIGJlIGRpZmZpY3VsdCBhbmQg
d2UgZG9uJ3Qgc2VlIG11Y2ggb2YgYSByZWFzb24gd2hlbiB0aGUgcmVnaXN0cnkgaXMgYWxyZWFk
eSByZXN0cmljdGVkIHRvIGludGVybmFsIHRyYWZmaWMgYnkgZmlyZXdhbGwgcnVsZXMuDQoNCkFs
bCB0aGF0IHNhaWQsIEkgYmVsaWV2ZSB0aGUgcGF0Y2ggeW91IGxpbmtlZCB3b3VsZCByZXNvbHZl
IHRoaXMgaXNzdWUgZm9yIHVzIHdpdGhvdXQgdGhlIG5lZWQgZm9yIGV4cGxpY2l0IEhUVFAgc3Vw
cG9ydC4NCg0KVGhhbmsgeW91LA0KR2FicmllbCBTbWl0aA0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogUGF1bCBCYXJrZXIgPHBhdWxAcGJhcmtlci5kZXY+IA0KU2VudDogRnJp
ZGF5LCBKdW5lIDE5LCAyMDI2IDg6MTYgQU0NClRvOiBHYWJyaWVsIEEgU21pdGggPEdhYnJpZWwu
U21pdGhAYmVsZGVuLmNvbT47IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0K
U3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0hdIGZldGNoMi9jcmF0ZTogc3VwcG9y
dCB1c2VyLWRlZmluZWQgcHJvdG9jb2xzDQoNCk9uIFdlZCwgMjAyNi0wNi0xNyBhdCAxODo1OSAr
MDAwMCwgR2FicmllbCBBIFNtaXRoIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOg0K
PiBGcm9tIGNkODlmMGM4NDFkOTYxMWQ3OTA0N2M3MDA0NWEwNWY2YWM0MWRhNTYgTW9uIFNlcCAx
NyAwMDowMDowMCAyMDAxDQo+IEZyb206IEdhYnJpZWwgU21pdGggPGdhYnJpZWwuc21pdGhAYmVs
ZGVuLmNvbT4NCj4gRGF0ZTogV2VkLCAxNyBKdW4gMjAyNiAxNzo1Mzo1NiArMDAwMA0KPiBTdWJq
ZWN0OiBbUEFUQ0hdIGZldGNoMi9jcmF0ZTogc3VwcG9ydCB1c2VyLWRlZmluZWQgcHJvdG9jb2xz
DQo+IA0KPiBCeSBkZWZhdWx0IEhUVFBTIGlzIHVzZWQgZm9yIGNyYXRlIGRvd25sb2FkcywgYnV0
IGJvdGggSFRUUCBhbmQgRlRQIA0KPiBhcmUgYWxzbyBzdXBwb3J0ZWQgYnkgd2dldC4gRlRQIGlz
IG5vdCBzdXBwb3J0ZWQgYnkgY3JhdGUgcmVnaXN0cmllcyANCj4gc28gaXQgaXMgbm90IHJlY29t
bWVuZGVkLiBUaGlzIGFkZHMgYSBwcm90b2NvbCBwYXJhbWV0ZXIgc2ltaWxhciB0byANCj4gdGhl
IGdpdCBmZXRjaGVyIHRvIGFsbG93IGEgdXNlciB0byBzcGVjaWZ5IGEgZGlmZmVyZW50IHByb3Rv
Y29sLg0KPiANCj4gRG9jdW1lbnRhdGlvbiBoYXMgYmVlbiB1cGRhdGVkIHRvIG1lbnRpb24gdGhl
IG5ldyBwYXJhbWV0ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHYWJyaWVsIFNtaXRoIDxnYWJy
aWVsLnNtaXRoQGJlbGRlbi5jb20+DQoNCkhpIEdhYnJpZWwsDQoNCldoYXQncyB0aGUgbW90aXZh
dGlvbiBmb3IgdGhpcyBwYXRjaD8gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgZW5jb3VyYWdlIHVz
ZSBvZiBpbnNlY3VyZSBwcm90b2NvbHMuDQoNCklmIHRoZXJlJ3MgYSBzdHJvbmcgcmVhc29uIGZv
ciBzdXBwb3J0aW5nIHRoaXMsIHBsZWFzZSBhbHNvIHJlYmFzZSBvbiB0b3Agb2YgdGhlIHBhdGNo
IGZvciBjb25maWd1cmFibGUgcmVnaXN0cnkgYW5kIGluZGV4IFVSTHMgc3VwcG9ydCBbMV0gYW5k
IHNlbmQgYSB2Mi4NCg0KWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9iaXRiYWtlLWRldmVs
LzIwMjYwNTIxMTYzMDMzLjQwODcxLTEtbXM5OC5jaG9AZ21haWwuY29tLw0KDQpUaGFua3MsDQoN
Ci0tDQpQYXVsIEJhcmtlcg0KDQoKKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgpESVNDTEFJTUVSOgpQcml2aWxlZ2Vk
IGFuZC9vciBDb25maWRlbnRpYWwgaW5mb3JtYXRpb24gbWF5IGJlIGNvbnRhaW5lZCBpbiB0aGlz
IG1lc3NhZ2UuIElmIHlvdSBhcmUgbm90IHRoZSBhZGRyZXNzZWUgb2YgdGhpcyBtZXNzYWdlLCB5
b3UgbWF5IG5vdCBjb3B5LCB1c2Ugb3IgZGVsaXZlciB0aGlzIG1lc3NhZ2UgdG8gYW55b25lLiBJ
biBzdWNoIGV2ZW50LCB5b3Ugc2hvdWxkIGRlc3Ryb3kgdGhlIG1lc3NhZ2UgYW5kIGtpbmRseSBu
b3RpZnkgdGhlIHNlbmRlciBieSByZXBseSBlLW1haWwuIEl0IGlzIHVuZGVyc3Rvb2QgdGhhdCBv
cGluaW9ucyBvciBjb25jbHVzaW9ucyB0aGF0IGRvIG5vdCByZWxhdGUgdG8gdGhlIG9mZmljaWFs
IGJ1c2luZXNzIG9mIHRoZSBjb21wYW55IGFyZSBuZWl0aGVyIGdpdmVuIG5vciBlbmRvcnNlZCBi
eSB0aGUgY29tcGFueS4gVGhhbmsgWW91Lgo=

