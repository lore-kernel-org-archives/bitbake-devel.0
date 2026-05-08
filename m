Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC15CD3436
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 05:26:55 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7043.1778218013830458203
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 22:26:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=TA/Y62A8;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95881349f0=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6484hMds1901625
	for <bitbake-devel@lists.openembedded.org>; Fri, 8 May 2026 05:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Vj64EA+vNYc3YGAvzUlJfqfc/LaVJsvYLXKxr3/uHfM=; b=
	TA/Y62A8HlM7uRdXfGjYP/T7MSyw2g5U+NbJLHjD7WONzXUrb25y4hLsZF5DFI4k
	D+qKux65CnPxVq5V7STfvhZwnczH7LoBzHiplodhb4UOuv78iXEqgI2uUlf4UXYR
	YDtiKLOPQqt6pdkqiqyPQtDUyS2Mm1GykkwwvuslFpLlWrwUudiDYNj5I6ZOKiTC
	GcZRkS3ZXGMwrtc+s4OQICg6Tbg5uq27nXNL0kAMVGqoefA3p23uiw39iwN4aQ4h
	ChDeX1FcMukI45YeEUDr4jg/H9uSWzaiHSF5PQ+aWkVi+lYHw42SNyck4Dv0bHX6
	GUO9EYwXdputIxKEHm9Ezg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dw8pu7ruu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:26:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tflqlxpe2t31IUAfFWh+gGo2YeRkX3DB8UaD0/awo5+k1Y8FYUnIaPX71XHbex92W3JNjUJLkUE4M6jCY6tvmvrGdPzfna3C36kPPlepkFksnkzcpZS2lxfUqsxtivcaK0OryvtKmT9m9BGKf1RwWgj6Jnj5SMcdSgXCswavye4XfLWdzIAnlhj8i0Iu0W1yt03eYlb8PfneFipmptH1cueGHwy6ICCm8Rhmit/Ktyq+omeFmTFBh1fqDrKJLAeezmdTOrWiHkzfDyupyWHbfLJsPF3vt4M5ywp01x9/u6PQVZzJBT+QaKsBkbKwUs3d2EqcXVY63ouROo8tCqokSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj64EA+vNYc3YGAvzUlJfqfc/LaVJsvYLXKxr3/uHfM=;
 b=YpKwbsHUy54TNIXCuaZvzZjf5jlGFUxeqtBLSMWiCC2/1KrC11oodvVMauI+fIdkrbUI8MtbxgaaKfFySLtVuLM8c2dCTfY/xtK+MxdQQ8KAf21MA6RrI4hSw+tLwIsk3vic3OHAaqUMqG61M5zUXI24npvnX43s0lsG0k5venibTKli6DVmel+86cfWsodrVlXJRMYKk49CakBRQH87Pg1aST6fiUIXHqWUvMAR0yLGBcULrFtfF9VMDE5UEdyng9lvcyg6/QJV2bIfSZpOdVlkq7NKGcEfBEvwwk6PPS0QXJUwN3gSiE3KE07pM77cwWjASXB+49WdfGGoAKIFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SA2PR11MB4985.namprd11.prod.outlook.com (2603:10b6:806:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 05:26:50 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 05:26:50 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
        "MacLeod, Randy"
	<Randy.MacLeod@windriver.com>
Subject: RE: [bitbake-devel][PATCH V2 3/5] fetch2/crate.py: add filter_regex
 parameter to latest_versionstring
Thread-Topic: [bitbake-devel][PATCH V2 3/5] fetch2/crate.py: add filter_regex
 parameter to latest_versionstring
Thread-Index: AQHc3elqnGQt8EiEMU+K4dajH0ke4rYCYzmAgAE3WOA=
Date: Fri, 8 May 2026 05:26:50 +0000
Message-ID: 
 <CO6PR11MB5602D7FE3E775800610A6FA2ED3D2@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20260507061845.1460893-1-Qi.Chen@windriver.com>
 <20260507061845.1460893-3-Qi.Chen@windriver.com>
 <CANNYZj_=Zo78eVodPtrAuRtkNyb1sMkmVjxf-VA43fpPBYFRRA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_=Zo78eVodPtrAuRtkNyb1sMkmVjxf-VA43fpPBYFRRA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=86925cdf-7c56-4371-b0a4-d788630a1a9f;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-05-08T05:26:17Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|SA2PR11MB4985:EE_
x-ms-office365-filtering-correlation-id: 99ca8291-9c13-4e81-3369-08deacc26829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: 
 4lwnuFgd0gWfh9kb7SZXN+M2CiaU9MOD3PVlpfgVe4kA/YQFnUJ5Q6+iwH1UmTsvR0J6wriWRV+qr7/mxmLsyWCZIx6ZwyMQ5dWx0e812z5uSAmU0Arup9Kop20P6BQkg2w3J/lw9fWRlhfNBSzWBo3J4ZgcY8C9ISftsHAUU82069o6ERyXxOnk7hsHPyXsrJHp2pbt9wFvhpLUPq1JA0wuF3msVuRB2mNJ4bWl0IruvLTLiukqo621H5urRI+MXKdIhwSF2be8AzCwVpFQpLfxRYAKmYx9f52aq1M165Vlse5ZQ46QNQDNUiWRypPK533/5GI2BWsAVYwqTs4XLOdrZVYWH8txTOIbgNoumxshA632Qs8QB1b/IhO0agHaSLGudBeKdMMvMCSNCQvFjo24kw1sjY+dzph4GFlVKYvZz9Z/g/xOJAnVEz/d1tXJzB/+WMK8onZ3Uz5EpSpQUnW3IWYzWIUgg/enSNGV23eR1BvQ6EEVm5nFRjW0h4iQwReEn2ZbIwQQkCIEpn0NqoDBIr8hM8M2oOzWjBE43UJrkYCIdlQftogFNiBw7DFA6aese4w6MT3Vpb8AOUebuTYmZWKqo/C9lSGEnwEUAhYyHmZXbNBRdOa1j9OVoyDGIDZCNv20la2YbsIaNW4/6ZV+OgMa5TG6OQbpcurEuKWYUIDuc897qbLbRAxs1c/HpSeaj4TOY1rx3adrgz2kA7mA3tTyzWvLCE2FsWPC2xXSd7qNnyiwXwU6MU3Om+Bn
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Yll5RWxwS1E1L1I4UVRvQkdTNmdhWDlYampvU0trc24xTm5wZlprUVlvYnVV?=
 =?utf-8?B?SXR5SnFGNHlaQ1BXVDd2ZGlaemxpUWE2MmpmT200aVlSZlNXdHZQb1JzdjJE?=
 =?utf-8?B?ZnBXaEl1TkIwU1BNNXpZcGhtSXFJclRKZUFlZXZydkY3R3hkZHNkcnlkcW83?=
 =?utf-8?B?R2UzNThvNVo3UmZoQWwvSUd1QTRrMGdza0xDT3Z1WE94UWpxSW9Vbll3VkRQ?=
 =?utf-8?B?V05iYXNDK1FRVWxZL2Nsd1UzUVVrMmJ5Qm92SmtCblpzUnlKZjc2dURJV09U?=
 =?utf-8?B?b0Z2MFBRc095Qno3OXYvRXkzVG1Sak83WVV4UmxHUGhPMjZsbndISElwYjcy?=
 =?utf-8?B?cTUrT0dTZ0Q1ZFJRVTJHNjNJRjJvdzBGYVZ3anZLcUl3aGdHMkIyUE82akJD?=
 =?utf-8?B?ZW9oVi9rYWRuV0VacnNRMDJ4NWpsNHlPaWdEK3o3QnBFYjNSZmFpQUtVZk1v?=
 =?utf-8?B?b21sNmRSMGFUd3BTL0NLQ2RIcEQrMnRXNWVPenNxRmdYbGlDU1dHYU9JaVpM?=
 =?utf-8?B?UzZGR0VSbEtoUmtWWmJkclptUVc5Nk1NQWk3SUR6MERxMnd0TUYvTHlWM01r?=
 =?utf-8?B?dThTYkpqY0E0ak5yeEUzNTVWOFJ5eCthWGFZWnUzNXdzMklJWGxTdTBNaEN4?=
 =?utf-8?B?emtKbFpFaW90a3AwRjl6UEFnK1RvQXRRdW9lWVhYODl5ZW5LejhZNTYxN05p?=
 =?utf-8?B?c3lvejAwVkVZWnJUcFRFTFY3QXZ3MkNqOGFtdTg2VHpuR3haT0lZb2V0WlNh?=
 =?utf-8?B?RGxieU1mdnprWXJFSkYzNW95Q0d3THNUcTVPQVArSzRUanJGdTZHZnNkYkJ5?=
 =?utf-8?B?eDNFb0hZem5XVG5hRzlETm9aNkI5dlllOHBJNFFNb1BXS3VaWU85TThVcnF6?=
 =?utf-8?B?ZWVoYzluVStsZ2l4ejF2S0NlUmVER2NTSC9kQTY4NjlMYXVoeVEydFRlT3cz?=
 =?utf-8?B?N0JwVTJDVXJ6OUtCbHJLWEYvRExPTWF3cm1lbjFNUzJZYzZEcFRrb05CcXpa?=
 =?utf-8?B?TnNHRkpPZ0ZkRXRlTGR0ZlV0NGxpZWFyaUw1blZHd0dLNjYrYlI2WDVKVWsv?=
 =?utf-8?B?ZTlQY21xelhXMjFHbWpxTDF5SGw3Nm91eWpTK3lwcFdOUmxpTHEva0lMclJY?=
 =?utf-8?B?N2dqamNrbm10U2YrS1RSeTRxK2pHTm1sWVJrUHZjVW5rQmkyWHVRS0hLOUJS?=
 =?utf-8?B?WkZFNllJdEdrMDZ2UU5HV1g5S0QzWDNmMEE0YmpFVFJTZDV4cy9sZy9lTmNV?=
 =?utf-8?B?eW9Dd0I2N1phbGJhVnYzUXpYdHVQS05BRURjNEdhM21NWnFMMjZ6eEhTSnJy?=
 =?utf-8?B?Q3lIZlpKd1ZoZFY5WXdqN3VsampqYzVOUnlqQXQ1WU1MSXlPbHJXSFNJbWZY?=
 =?utf-8?B?c1lqN0JVSVRQMjZMQk5DS0kzMGRPd0FjOTgyTnVUUTUyeENoVVpieVZNckE4?=
 =?utf-8?B?dkYwc1FTQU1IaE9DUnNPQ3lhbmlCTG1sTUR2dTFvZFVpU0JiOW05bm5EdVpC?=
 =?utf-8?B?T3g3N1MxZUtsYm8rdGgxSjdvRVk4UUFlQ0QyUzZQNWt0a2xNdmJrU2o4Y2NG?=
 =?utf-8?B?L1AyankwM0laclQ1ZnBvcXlnRkNYMFZUTk50b2ZmWHY4OGRKQm9lQUxsYjRo?=
 =?utf-8?B?cEw3RVJuakRrQXdZbW9RSXRSRi9pd0xkTnZwNUF4WUtsKy9IdCtwd3RuU0oy?=
 =?utf-8?B?N25pQzhHMXZNWWMwVm1wVmNjMDNTZmFDcUFhYWQ3WW1EcnBhcHZQeC84bG9C?=
 =?utf-8?B?MnVzRVdWWkJjdkFwRUpGdGdVUjNmZU5qU0ZkUVBDQW9yeW5xbDlFRmVYbjlB?=
 =?utf-8?B?T3l2ZjJGTkR6L0RuNnZhK0YrcUsrNGh2andLWnRKQXFYYms1T1VWRmpMdlhq?=
 =?utf-8?B?U1gwWkpwMjR4Y3JaQ3FnK0FtbGd1NFBINFh3MFRyd1lBdzk1QWZNVkhESEN4?=
 =?utf-8?B?dFhTZ2M2M3FZRldTdkpqUlVxRExhRzFnL2UwcFp6cXN4ekVML3FDL1BpVVFw?=
 =?utf-8?B?cWVlTDZacERXaGl1RFY4dVlaMVpYUWs4RVBzODVrMG5FWUFsZFhkSUVDbHFl?=
 =?utf-8?B?MFFkc01qaTFZSzk1aWJZRmMvYm1SUFBXbEhVbmZvcjNvb0FKYWVOMHNhUVlC?=
 =?utf-8?B?clJUYWxwQ1Fod0J0SS9USGUrRzFJNC9WUXFqb3FFbEhOY25kUGJ0U1F3b0x4?=
 =?utf-8?B?ZlI2WFFSMlJBVzc0ZnEwUzhGelN0YWJkeWRuTHVGT29xdVBQTWJHRCt5SGF4?=
 =?utf-8?B?TGxycXM0MGY2UExQNjRHOEZ1UWRuQ0xDVHhNWkNQc3VlK0FuK21CbTBVTDZx?=
 =?utf-8?B?blVGMWlDbmFndjdYZEFxOG1uYlFsZ0xiWnBjQmNvSU1VY2pZUmlWZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	CQHj0jZmIFQI1eQV5E5EL/hDwDfMMp4qSgNH/9qoHkt5eBGnj9SFYY04uCIiyKBAZ6WqZyE1S58jkl2CQzNmrotW0q3Ser3MvLEw20QXaU/CV83VlluoNguo7dTp/uqamxDhtg3uuS3h1fXiyFdLXOG02+RuT1ZtJBlhd/HyUDn0nQNS7DqBLAXSTqaIf1fWsw2xIGemTYiWjKWf/dx9SzvaJ9Q3D5NqfRa+XijvachFdM0EyHdTJdsiVvc/UlEXtkR77bbRf5MfQDxTpsvrUuDAFxPlL/dtKYQ+WZxtcN7AILBnXhUcFN2OMsOTTIMzrfZ285t2soWvkeEwIPpipw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ca8291-9c13-4e81-3369-08deacc26829
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 05:26:50.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZFsMV4MH3rNSZQ64Tntbj6lmWhkKVcjPeQJLjicMK5jLsqpdIqzRYxUaeEURtwyAM8crLyUU9n1JyLUcIO1NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4985
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AdaB2XXG c=1 sm=1 tr=0 ts=69fd741c cx=c_pps
 a=0Za+SRInewOPUeHoNPGlYA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=Q4-j1AaZAAAA:8
 a=BeRkx5RZls45bj6nLcIA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA1MSBTYWx0ZWRfXxXlbeghm9nP8
 JRKxwjHm0A6iCAaf7zKnOr2E07tv5Ku3WibBQxJlcW8iwGNSHJIi4S0wICZx158V8kGZTE91VNb
 cty8wTJ8O2vMDzTt2xBRIyeoeTWpBF7VmWC3LlsEBmH3Q7XzWEIAO9xoXEuKf7TOTFuGZMffF1z
 Xs3pUM37eL1G/iiM4jf6eHI5PCBl8PKx1CLNfNeaK1Hf2BS9ddH97CLQJtX1U3M6iV5bJn6Siay
 pzwtsp88hNdj59MmqeT1ffukRUJymuIEB2Gq1l4rdQcZYDw525wuSCroXDpBmNk3gxChOVp+wwA
 efNTo1VN+SrDhoxtIUstdVoabPoq5ZW7xXNc5iKWAdYzbmtlxBabcYtXAJdKmFTzHsce7zSujzY
 XRy9UVeZ6jgDv4pyqZrEnB/CMf9eKzfXi7qo6qIiVAJ/ok0kqGtX3GyifR3tJNf4fS4i9i8AWhe
 lm1VoNq8/JXeQPJsqyg==
X-Proofpoint-ORIG-GUID: H5tXpSLcv1AivD9Y6-JqqpiRIJLV38-W
X-Proofpoint-GUID: lI4_kKy5fZFEotz-wNvAcV7WZyt6MvnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080051
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 May 2026 05:26:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19473

VGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4gSSdsbCB1c2UgbGlzdCBjb21wcmVoZW5zaW9uIHRv
IG1ha2UgY29kZXMgY2xlYW5lci4NCg0KUmVnYXJkcywNClFpDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBBbGV4YW5kZXIgS2FuYXZpbiA8YWxleC5rYW5hdmluQGdtYWlsLmNv
bT4gDQpTZW50OiBUaHVyc2RheSwgTWF5IDcsIDIwMjYgNjo1MiBQTQ0KVG86IENoZW4sIFFpIDxR
aS5DaGVuQHdpbmRyaXZlci5jb20+DQpDYzogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRk
ZWQub3JnOyBNYWNMZW9kLCBSYW5keSA8UmFuZHkuTWFjTGVvZEB3aW5kcml2ZXIuY29tPg0KU3Vi
amVjdDogUmU6IFtiaXRiYWtlLWRldmVsXVtQQVRDSCBWMiAzLzVdIGZldGNoMi9jcmF0ZS5weTog
YWRkIGZpbHRlcl9yZWdleCBwYXJhbWV0ZXIgdG8gbGF0ZXN0X3ZlcnNpb25zdHJpbmcNCg0KT24g
VGh1LCA3IE1heSAyMDI2IGF0IDA4OjE5LCA8UWkuQ2hlbkB3aW5kcml2ZXIuY29tPiB3cm90ZToN
Cj4gICAgICAgICAgdmVyc2lvbnMgPSBbKDAsIGlbIm51bSJdLCAiIikgZm9yIGkgaW4ganNvbl9k
YXRhWyJ2ZXJzaW9ucyJdXQ0KPiArICAgICAgICBpZiBmaWx0ZXJfcmVnZXgNCj4gKyAgICAgICAg
ICAgIGZpbHRlcmVkX3ZlcnNpb25zID0gW10NCj4gKyAgICAgICAgICAgIGZvciB2IGluIHZlcnNp
b25zOg0KPiArICAgICAgICAgICAgICAgIGlmIHJlLm1hdGNoKGZpbHRlcl9yZWdleCwgdlsxXSk6
DQo+ICsgICAgICAgICAgICAgICAgICAgIGZpbHRlcmVkX3ZlcnNpb25zLmFwcGVuZCh2KQ0KPiAr
ICAgICAgICAgICAgdmVyc2lvbnMgPSBmaWx0ZXJlZF92ZXJzaW9ucw0KDQpUaGlzIGNvdWxkIGFs
c28gdXNlIGxpc3QgY29tcHJlaGVuc2lvbjoNCg0KaWYgZmlsdGVyX3JlZ2V4Og0KICAgIHZlcnNp
b25zID0gW3YgZm9yIHYgaW4gdmVyc2lvbnMgaWYgcmUubWF0Y2goZmlsdGVyX3JlZ2V4LCB2WzFd
KV0NCg0KWW91IGNhbiBldmVuIGZvcm0gdGhlIGxpc3Qgd2l0aCBhIHNpbmdsZSBzdGF0ZW1lbnQg
Ynkgc2V0dGluZyB0aGUgY29uZGl0aW9uIGxpa2UgdGhpczoNCg0KLi4uIGlmIG5vdCBmaWx0ZXJf
cmVnZXggb3IgcmUubWF0Y2guLi4NCg0KYnV0IGRvaW5nIGxpc3QgY29tcHJlaGVuc2lvbiB0d2lj
ZSBpcyBwZXJoYXBzIG1vcmUgY2xlYXIuDQoNCkFsZXgNCg==

