Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE544FA3755
	for <webhook@archiver.kernel.org>; Fri, 13 Sep 2024 13:35:50 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.83])
 by mx.groups.io with SMTP id smtpd.web11.73440.1726234540207081509
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Sep 2024 06:35:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=XmBf+OdX;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=XmBf+OdX;
 spf=pass (domain: arm.com, ip: 40.107.22.83, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yDOnv/qZJKz7/wmn+3fm82K3uubTTe2/AzsmNVSQPeToPCqWaJXpIt6DaqN84U7pvGURAG2ZbaO2a10hFJ6NYont7wuNWIDGFQgFQ+XzeUeJuNn6neDa316v8ghX6rQGP/tf8RmxhneRmuZz5FbPBgUfgDz5+sEI1+cVKQldDW4hM4HYLrlQAdMXl9SqkKHPSc4y+RA2Jv4F9h5EuL2J7nD8cvIa1Hq33WFGqH1Udtn3dgAh1IrOkiz3e2gw2P6VodbqM3aOTrmZ6EXD0LDL3VxemNPhUiZdWDqScB6MFh+RJamznROVyUMfKIn+PJHv0dTai/9vWKDvaeAgNRpS9g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHJ24b9kScAAqZ5AglHEHqxve6mNephJcmu59ZGK7nk=;
 b=T344/bhXJ5/C9mdjAvriXPZAf6EECgKEVZSswondt92eHFe7hdpflC0TcdWBdUInk9FpaUHx4D8yLDMLKlPKjI75hOlfPAi9ZANe1NpK1oHv3eahqi4tKq8gsBK5VWqKh+IBJEu2rItX1HLWhEV6yGbjMF9modk9HugRUhsjPepadd46ueq7BfBepA/ncn8Ltf8JjOveUpSTBxZaMkEDO7J0/W1Exk4fbXAAxmy5XEp1En+aUHACdQhfvRHzXuNv9a76VlykO53dZywe1mxxXzSzftnlv+tXcdpscrwVlfrH8ZiPHoPrOKqb9aVS9kmlg0HIDZdj9LAUK9S8eSGR/A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHJ24b9kScAAqZ5AglHEHqxve6mNephJcmu59ZGK7nk=;
 b=XmBf+OdXrXcopjrRa1LavTauU6uqPgfm90O/o65vbf5G8dNtUpbsoEtTPicZjBcHI9zBzTuxutXG1cWCg+bAu4Qv6ZjDAcBYnqV8n20HFBWKizxN1LlT40z0i5wxbh68yS9CmYzhNzGoTab1NrhoK8yWkavK049kKceeIDQNecI=
Received: from AM0PR01CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::46) by GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 13:35:34 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:208:10e:cafe::cd) by AM0PR01CA0105.outlook.office365.com
 (2603:10a6:208:10e::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.28 via Frontend
 Transport; Fri, 13 Sep 2024 13:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Fri, 13 Sep 2024 13:35:28 +0000
Received: ("Tessian outbound 70901c2e285e:v441"); Fri, 13 Sep 2024 13:35:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0b80b6e7c42c0084
X-CR-MTA-TID: 64aa7808
Received: from L8c987c506457.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7A6E701B-F4FC-4A16-95C6-63FE41A6183C.1;
	Fri, 13 Sep 2024 13:35:22 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L8c987c506457.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 13 Sep 2024 13:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyD78oGrkd3iig1zyMJG4UpH3ztWYk4AjcfjCNoyiun1s6vehnDHZEcfgNe+YkUPiqPWRgSGvfWiWgoAODGDmlcuSziVBFwmZA/6/wnaBz65uB5sbgouF5kdA64nDOvJnXCYGGdJTEK1cca08JEoJA8f84CHgrJ0RsHCoSoamLGuMPgTBydvgcOHIMtTxEuS8E/DJw49TAuqEvoRFdhClAZvsULJmzI7WUOp8bcOzwnRNvknVU0qKxQOWUsis8lYHX0zDjYT0DqIvf95VhvdcdxCDgb0bLfu2eVn4PiNpKzFV28nFx4cQyWcLHhQ9jtl5xybl7Zpx1OIM3G9odr+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHJ24b9kScAAqZ5AglHEHqxve6mNephJcmu59ZGK7nk=;
 b=arYLeY1/kvuRe2CBbFJdkRahru4esBTquCPA65vxd9P+Mjwv7QZlkHJIT8XnONhSs85auErdEwna6EzxA5WExhj1ObDBOqsXooe6GDXgfDGbrBbqS0l3z0IMfSTP/U0YhgS/KPpS0rPy0eoNyffWMITEeHg3qhVcE6eLfpLeQjnsr7EZwbuv74m8oJk6n0kuxkj7ko84tObjjcjz49RnjHZcqWjJXcyftEXo+6ol6HbYx+pd7p5PBSWjJVQAwrUmQgjC2HsIl+Pg9jsgjfoBFq+7/DwtcKBJorysfskCorscy7kIVuki2QU50TBOb071SYfycrkpj51UW5CXgMaXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHJ24b9kScAAqZ5AglHEHqxve6mNephJcmu59ZGK7nk=;
 b=XmBf+OdXrXcopjrRa1LavTauU6uqPgfm90O/o65vbf5G8dNtUpbsoEtTPicZjBcHI9zBzTuxutXG1cWCg+bAu4Qv6ZjDAcBYnqV8n20HFBWKizxN1LlT40z0i5wxbh68yS9CmYzhNzGoTab1NrhoK8yWkavK049kKceeIDQNecI=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by PA6PR08MB10491.eurprd08.prod.outlook.com (2603:10a6:102:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 13:35:18 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%6]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 13:35:18 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: don't try to preserve ownership
 when unpacking files
Thread-Topic: [bitbake-devel] [PATCH] fetch2: don't try to preserve ownership
 when unpacking files
Thread-Index: AQHbBeFs+0AnU0Mmq0WEv3WUjoD65bJVt7uA
Date: Fri, 13 Sep 2024 13:35:18 +0000
Message-ID: <E631390D-DBF2-4312-BBA4-3B75258B4B53@arm.com>
References: <20240913133232.3363082-1-ross.burton@arm.com>
In-Reply-To: <20240913133232.3363082-1-ross.burton@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|PA6PR08MB10491:EE_|AMS0EPF000001A8:EE_|GV1PR08MB10521:EE_
X-MS-Office365-Filtering-Correlation-Id: fd47c3ad-b038-4f09-dced-08dcd3f8eea7
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|4022899009|366016|376014|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?TkUwN3M4S2MvUThaVVdyd1FlRHA4QVZ5Rk5qdHZVblRNSTVSS0swNElDeVEv?=
 =?utf-8?B?bG5vK21halMwdnpYYUxtVUJiZnp2Sk9wYmFoRTByY29QekZwc3MyK2o0TEVt?=
 =?utf-8?B?QjFSOWIrWWFUUUUwZHZETHN5UG93L1pPTzcwV044ZlRlZTQ4ckNjWXVFUm8z?=
 =?utf-8?B?RjBXVEJtVS8yNk5ZRHBNOU44NjBpNHdGQzc1WUtvamhLdytDV2JOZk9qYmQ5?=
 =?utf-8?B?YU1QYmZiSnYraWRybEZQSWhxaXZFaGhiK0ljVGpLdWZVYkpYNWJFY2ZSajZw?=
 =?utf-8?B?MHQvQk5McHVMemJ2Syt1RXhFNEpEem1sSmVrY1g0Q3Q0em1xYTdkbGlaUVNq?=
 =?utf-8?B?NDBhNzBEN3lsS3BNUHoyU3hkVWMxTzc4Ky9MS2hIZWF4bFIvSnRzTCsvN1lR?=
 =?utf-8?B?RFpnRzIybWxXcXhGbWdKMTYzTGVBNnFJT0g0cHJJYVJXaFRYTWdmWnhXdkkx?=
 =?utf-8?B?NTFhWFBEdkJ3bEVyVEJVbTVRRFRaVlg3cTNQOW1iRHU3QUJ1ZWxqa1d0Smtu?=
 =?utf-8?B?RXJIakFaeFI5YlRKdmtoY0lLU3BCWnJ5UXZQdWpJbS9neXBoUStIQkxrWWtz?=
 =?utf-8?B?YUhRL1lvaUtlZG55SzlybE40dnUxUmxmcVRPbzlyb0RqVHArdnZMYS9oZy9q?=
 =?utf-8?B?S1AyNXN4bVZwV2tTeDF6YVRhV2thL2NLZGFocVFDenhCOGl5Y1plVE84SXJP?=
 =?utf-8?B?T2FiTGVuL2ZldGZ1ZVFEdVFNaGs3clVBZHNHZnhsUm9Bc3JiYzM4OFJvUFdv?=
 =?utf-8?B?T3FPUkR1ZFFFT0cxN21IcVRYRWRWZExpOFBRdkVWNnkvSDBKbk52V0d5MGZi?=
 =?utf-8?B?S2ZjR0xBMDc1MkdaelNvWk1DeWNDTzFyTlNCUXgyMTVFditFL0h3MDZpTXoz?=
 =?utf-8?B?TEx5eGRnS0tNVzhZUWlNRU43aHRpQW9KOWhXdmR0OW9TelhZSldFRXg5SFYv?=
 =?utf-8?B?TlNSWFlMMi9ZR1lvNUdJbjQ4eHRkNjNtZHBUTUdwb1lidEFabXpWbWxNMTIr?=
 =?utf-8?B?ZDN6eDl0T0M2VjFuajk0VGVzU3ZpRE9MYzdTREVoQW9lYTZ1OGRqWG54WHRn?=
 =?utf-8?B?MnNqOE5SbFdvSGdhQXNqTXBPalNrdldDRy9MZTlnb3A3eHlpS0twd1JXLytW?=
 =?utf-8?B?Uktoa2RRMW9Ea3o0MlkrWFBsUzVtNWJBSjU4SENjRHdsVWw2S2tlTmdPVlhQ?=
 =?utf-8?B?NEtjb0tLbkVtVm5GRVlyc1JhbDJVUkVDRHNLOE9CU29QRER2c2dNalc3M2Rm?=
 =?utf-8?B?Uzk4eW9HbzVJNkxZa3QxSkp3OHFsZHBpcHVZditrbkpYTHd3QkVjRzl2Tkdy?=
 =?utf-8?B?emFiTmxBS0pNbXNMcGRNQVVVV2Y4ZHNaN2lDaUNNK0YrdlkwNStPQmk2NEdE?=
 =?utf-8?B?Qi9SSUR0VGk1alo3THN4M29pcklkT0p2Mzk0YlRUbHVFMDZYTklLeXdBZkd4?=
 =?utf-8?B?eG5YOUpZcVFDZFRGdlEySlJIcmkxWHBzNklhSE5mdjRzbS9ZVmVVQ216dnBo?=
 =?utf-8?B?Ri9qYVNQUXBVNVd1MG8rM1kyd0xiWWRoMFFEWVJkMEVLbWZqSitpbmwxaFJ5?=
 =?utf-8?B?b0w0Rm44VzFBUjJNVm4yVCtPZCtGR3ZqQ0RHSzRvU0t3RlJ3RlV5WVphN0s3?=
 =?utf-8?B?K0ZZMnlCdGNLcFlUVjBiVmhXSytLL0dCQURYbngzemdySnUzcG1TR3hCVlZL?=
 =?utf-8?B?dEN4RjdQbXpUVmdPTHhIS1NqaUZtSFpwOW5nZGZ0UFJlSnhPMFRvNkVsSU9k?=
 =?utf-8?B?MW16WlVqTlpoVFdnYzFDL2d0SUR6azRRZkk0cnFuc1pqbHV5bUhVYzRIY2tO?=
 =?utf-8?Q?2Di6r0fZX+lbmq0o/q639eU1MdHRmxDnAhRE4=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7DC37253D6CC740A3E62BC1F0EF254E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10491
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: 
 ip=[2603:10a6:102:2a3::12];domain=PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	2ebab0fd-646f-4991-4e16-08dcd3f8e833
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|35042699022|4022899009|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cElOcDU2YjkrUXg5Z3hhZXVUNHhXMmxab0tMUlNDaEpxZENzTUhmeHJvTVU0?=
 =?utf-8?B?TVJnVWVtRU03V0x0L1grTFpBVFJLNFBQUmdOUldKZVpUY0tPSHVyTldIdHYr?=
 =?utf-8?B?UEpUNVl1L3lrN3pvT3ZRSi9nQ2NuQlZsLzJYZnpiTmhMTFZIY3VxMEczeG55?=
 =?utf-8?B?NnQ4b29IdFViY3B4enk4WnZaNmFrNVorMTltaXhRci9ZcTRaRVJBdFFkMy9j?=
 =?utf-8?B?Q1hWZ2FpZ1JpbHd1RDUwN0JjK1UvMWxzV0RCdXF4M2R0ZmNDNVMzQnVaV3cv?=
 =?utf-8?B?ZkxpUFVibFByVWNJSllrTmRxNVA0ZlRwQlZMTEErZFJ1aUJEeDNlSTcvd2NY?=
 =?utf-8?B?d2lwZDlsWVhSNC9wR0NiZjM0dGo4Snp1OEx3UjZFZ01PN015V09sQXc3V0lT?=
 =?utf-8?B?L2g0Sk96bkI4ek1IUzZ0aWp2bUF4SW54aFN2SlIybW1tQTE0YkR3TW1DampK?=
 =?utf-8?B?Mkd6RStmR21ucnVIbzlXb3NjNy9iU21qY1pieXlJUVlxclVvaC9nKzVoV1Vu?=
 =?utf-8?B?YmlWVUdWUFJyV1BYNVJkbWpaR3JPVGV1UThLdnFmWXNVRFZmTHhrZ0VtcjZF?=
 =?utf-8?B?Vmo2cENEY0hJZVVEMFljWE1VdG9ubVdTZW91VU1uakVVa3VDYmNmS3N3VVJ1?=
 =?utf-8?B?aUlXQ2EwOGg0Q2JmQzBXS0dHUURuVzJXdms1V2c5SFppeWRpUlE0RFk3dnUx?=
 =?utf-8?B?M2tsb3UzdkNnWFQvd0ZlTEYrY3gzNm95cmtNRjJTb1ZKNVRFZUhhYmVBbXln?=
 =?utf-8?B?TlJ1SFlqVElPTngrR0p2T1NPYWVWU1FTNWwyd0wyQkEwTkF1WjZSZGxXcGVI?=
 =?utf-8?B?cjh1cHR1dDZ4ZFdPZ1YyUWJjdTI0eEc5ZzZXRlNtMm5oTGtmQ2JVKzlkTUV3?=
 =?utf-8?B?b3E0bkZEMVBPc3d2TFphbGhUOUZvQXRNeG1sMUNQemdhNE45dzV2VnRuZDZq?=
 =?utf-8?B?bld2amp4cnE4Y1Qwc0JURGtZRUhsUmVJQTI5WjAxdCtkcEdsS0JuY2Z5NmJ6?=
 =?utf-8?B?aTYvcDVSQ09PRTVscGVML2sxcW5vQm51b1YxSHBaWkZFODlSNTNIUDJnckp3?=
 =?utf-8?B?bVJVeVRnaGs5aFRUb1A3azExR3dRYVEyQTVSdkovRTJiVHVXQUh2TDVNTXd0?=
 =?utf-8?B?YnU5NUdiTHRISW1NNlZtbTFtNDVVNFhEYmlUVXdkVVRJNFlnVkllV2FTWHMz?=
 =?utf-8?B?RHFnY1REbkQyejltRmduQk9wSzRKVGcybmp5TGdvZnRoYlVWcmovVDg1cHgv?=
 =?utf-8?B?RndxTml5eDhHSThMMXhtM2V1ckltelIzVjJmT0ptbWlBUGxlUksyYnZVWnFp?=
 =?utf-8?B?bUVFZkVVWVRHOENHbG45MytnbEhPd1gxeURVajNGNmVuNWVxQkVrcTUvS0F5?=
 =?utf-8?B?ZnhWMXVNWTdxenZPa3E0enBBU09xR0hxelhDOGpEeHg3MGxLN016YWd1RXpT?=
 =?utf-8?B?bTVyc1pBWWN6NFdFai9jcWpIZTd3YTZMZjQyZWJTY0pvazhpU2hFUFN1dnBh?=
 =?utf-8?B?QTZvZEYvbHVOZUdSQmtma3kzM1NTU1JBSVJGY0pldm96MDIyRFZyYmFVblp0?=
 =?utf-8?B?Q3NnejNNaGJRYkxabVNDYVZ2MFAvS2JZM3FETERTY2xIb3RYM25Xd1BVRy80?=
 =?utf-8?B?Y0RETzJoWXUxT0RQTnNyWTJ6elhUcDh6VWJlbEZVTVhNVjRoVExaOVYxSlFi?=
 =?utf-8?B?bnVKV1FtQW8ybXZ6SlJTL0hsRStQVGJJQTR5THVkTzBBUnM1THdPMUlXdklN?=
 =?utf-8?B?Z1plNm9SUzAxbVRHVkluQTQ4aUxzNVdVZmhYUkhzbWh3TE1aaE1VdnNVRFhl?=
 =?utf-8?B?UGJaVGliSDE3SlhZTGZxampYNmJuM2ZkUzlFS2lNNmtJZjVMK1lXcm5YaTZx?=
 =?utf-8?B?dEpkanVLS3RFVmpXdnNJR1Q1emNoSElsUmlySjBCSjgrRVE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(35042699022)(4022899009)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:35:28.8002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd47c3ad-b038-4f09-dced-08dcd3f8eea7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10521
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Sep 2024 13:35:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16559

Q29udGV4dDogdGhpcyB3YXMgYSBtaXNndWlkZWQgYXR0ZW1wdCBhdCBmaXhpbmcgaHR0cHM6Ly9i
dWd6aWxsYS55b2N0b3Byb2plY3Qub3JnL3Nob3dfYnVnLmNnaT9pZD0xNTU5NiB3aGljaCBJ4oCZ
dmUgbm93IGNvbmNsdWRlZCBjYW7igJl0IGhhdmUgYmVlbiBjYXVzZWQgYnkgYW55dGhpbmcgcmVs
YXRlZCB0byBwcmVzZXJ2YXRpb24gb2Ygb3duZXJzaGlwLCBidXQgYXMgd2UgZG9u4oCZdCBhY3R1
YWxseSB3YW50IHRvIHByZXNlcnZlIG93bmVyc2hpcCBpbiBhIGJ1aWxkIHRoaXMgaXMgbGlrZWx5
IHRoZSByaWdodCB0aGluZyB0byBkbyBhbnl3YXkuDQoNClJvc3MNCg0KPiBPbiAxMyBTZXAgMjAy
NCwgYXQgMTQ6MzIsIFJvc3MgQnVydG9uIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIDxyb3Nz
LmJ1cnRvbj1hcm0uY29tQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+IHdyb3RlOg0KPiANCj4gV2hl
biBjb3B5aW5nIGZpbGVzIGFzIHBhcnQgb2YgdGhlIHVucGFjayB3ZSB3YW50IHRvIHByZXNlcnZl
IHRoZSBtb2RlDQo+IChzbyBleGVjdXRhYmxlcyBhcmUgZXhlY3V0YWJsZSkgYW5kIHRpbWVzdGFt
cHMgKGZvciByZXByb2R1Y2liaWxpdHkpIGJ1dA0KPiB0aGUgb3duZXJzaGlwIGlzbid0IHJlYWxs
eSByZWxldmFudDogdGhlIGZpbGVzIHNob3VsZCBiZSBvd25lZCBieSB0aGUNCj4gYnVpbGQgdXNl
ciBhbmQgaW4gc2l0dWF0aW9ucyB3aGVyZSBETF9ESVIgaXMgc2hhcmVkIGJldHdlZW4gbXVsdGlw
bGUNCj4gdXNlcnMgdGhlcmUncyBubyBwb2ludCBhc2tpbmcgdG8gcmVwbGljYXRlIG93bmVyc2hp
cCB3aGljaCBjcCB3aWxsDQo+IHNpbGVudGx5IGZhaWwgdG8gcHJlc2VydmUuDQo+IA0KPiBBbHNv
IGV4cGFuZCB0aGUgYXJndW1lbnRzIHRvIGJlIGNsZWFyZXIgYWJvdXQgd2hhdCBvcHRpb25zIGFy
ZSBiZWluZw0KPiBwYXNzZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb3NzIEJ1cnRvbiA8cm9z
cy5idXJ0b25AYXJtLmNvbT4NCj4gLS0tDQo+IGJpdGJha2UvbGliL2JiL2ZldGNoMi9fX2luaXRf
Xy5weSB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYml0YmFrZS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5
IGIvYml0YmFrZS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5DQo+IGluZGV4IGRkZWU0NDAwYmJl
Li43NTNhMWM2Y2E5ZCAxMDA2NDQNCj4gLS0tIGEvYml0YmFrZS9saWIvYmIvZmV0Y2gyL19faW5p
dF9fLnB5DQo+ICsrKyBiL2JpdGJha2UvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KPiBAQCAt
MTYwNiw3ICsxNjA2LDcgQEAgY2xhc3MgRmV0Y2hNZXRob2Qob2JqZWN0KToNCj4gICAgICAgICAg
ICAgICAgICAgICBpZiB1cmxwYXRoLmZpbmQoIi8iKSAhPSAtMToNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgZGVzdGRpciA9IHVybHBhdGgucnNwbGl0KCIvIiwgMSlbMF0gKyAnLycNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgYmIudXRpbHMubWtkaXJoaWVyKCIlcy8lcyIgJSAodW5wYWNr
ZGlyLCBkZXN0ZGlyKSkNCj4gLSAgICAgICAgICAgICAgICBjbWQgPSAnY3AgLWZwUFJIICIlcyIg
IiVzIicgJSAoZmlsZSwgZGVzdGRpcikNCj4gKyAgICAgICAgICAgICAgICBjbWQgPSAnY3AgLS1m
b3JjZSAtLXByZXNlcnZlPW1vZGUsdGltZXN0YW1wcyAtLW5vLWRlcmVmZXJlbmNlIC0tcmVjdXJz
aXZlIC1IICIlcyIgIiVzIicgJSAoZmlsZSwgZGVzdGRpcikNCj4gICAgICAgICBlbHNlOg0KPiAg
ICAgICAgICAgICB1cmxkYXRhLnVucGFja190cmFjZXIudW5wYWNrKCJhcmNoaXZlLWV4dHJhY3Qi
LCB1bnBhY2tkaXIpDQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KPiANCj4gLT0tPS09LT0tPS09
LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBzZW50IHRvIHRo
aXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMTY1NTgpOiBodHRwczovL2xpc3RzLm9w
ZW5lbWJlZGRlZC5vcmcvZy9iaXRiYWtlLWRldmVsL21lc3NhZ2UvMTY1NTgNCj4gTXV0ZSBUaGlz
IFRvcGljOiBodHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvbXQvMTA4NDMxNTcwLzY4NzU4
ODgNCj4gR3JvdXAgT3duZXI6IGJpdGJha2UtZGV2ZWwrb3duZXJAbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZw0KPiBVbnN1YnNjcmliZTogaHR0cHM6Ly9saXN0cy5vcGVuZW1iZWRkZWQub3JnL2cvYml0
YmFrZS1kZXZlbC91bnN1YiBbcm9zcy5idXJ0b25AYXJtLmNvbV0NCj4gLT0tPS09LT0tPS09LT0t
PS09LT0tPS0NCj4gDQoNCg==

