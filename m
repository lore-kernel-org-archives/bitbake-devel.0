Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB217C021AA
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 14:29:01 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.56])
 by mx.groups.io with SMTP id smtpd.web11.20610.1739888939722262024
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Feb 2025 06:29:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=YR70vGlF;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=YR70vGlF;
 spf=pass (domain: arm.com, ip: 40.107.103.56, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=duG03WoH5lfIcc25W57CcP61pXBt6UG8QA7y5tYfwNZw8WYL4kUKDBdD4JuT0IqjdI38cLae4KYsz/udBAJ6DxoaynmjD6nYMWhng4Er2/dZ5iX0RqBBA5p8nBkagEcWr2/cxzORQ5N1pw26MgXRxdHdCckHrYkK6IB4oenhXKUmEusUk7fSaME22ZHhlvBh4LEubppNg0vvFqgPodnihKyxv7U0c0Y+PwNgYW9GhUsOr7xromVC0/S5dzj6LgePgiS+I9VphRGHci3J3cmLyW5AeFnpNmOyKCAWRhUOAfDXFh219qie5KN2vqtOo+o/rAK9fsc8SOYjEaEhtVxQtg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRI3CIZytci1IZddUvS5492//JgsLu0dlaH3BjXCdT8=;
 b=v/M7aDUv+UjzQxw+O9Tn/gJPlDPcVREUUhP7GKZFBCvDk3VTJTYzXNjEvgKDSdbJJ8CsRijnsHM3QT+86pyxpOuwn8+1C/qT+q+n9Cw2tdCywm5rozrM8w9Nt0/12KVOJ4M9zJBDgkJnXTZcUX2+ee0dLn+Gmt4aonrY7tzgzVLqrLLluAd6+HLtVINn+3p+HrG+rtdLUDZpwaMH4k3mjXC9UOi09i+swTUEVX3BDt5BuBRQ1H/MT78V5h5NGm87U6wIAzUwc8SlFyWitIj4oCTd91yIRwow6DoxW5a1cx/LuovYrh8LfLR8XyNV2QxkNoyB/W7iN5oBjhdkzSXM5w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRI3CIZytci1IZddUvS5492//JgsLu0dlaH3BjXCdT8=;
 b=YR70vGlF5NILdRKKj5Dj4Vf5iQelnjJqaajBP8XnS8EBl8XOS+v1q0Vn+cCnzf82/EZ/HR/XYlZnBwo821pVsDhacX+53U/skw/iCZJD3ZmZvaaayrOFAlDO3kCRxvVvjmV0BLhVdCu2oCGXdRY4Tnr4FZAlSo3Z8LBw17oOacE=
Received: from DUZPR01CA0314.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::21) by DB9PR08MB9921.eurprd08.prod.outlook.com
 (2603:10a6:10:3d3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 14:28:54 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::b4) by DUZPR01CA0314.outlook.office365.com
 (2603:10a6:10:4ba::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 14:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.11
 via Frontend Transport; Tue, 18 Feb 2025 14:28:53 +0000
Received: ("Tessian outbound d73f074635d5:v567"); Tue, 18 Feb 2025 14:28:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1d0655f40ce17a81
X-TessianGatewayMetadata: 6e8oswHgePDX/kN2HZ9yuYV/bMMcdQB3kAa5ZemPuEGMWV0Xcj+g+0gjMVZ2LJHzirLPjyZFCsbUIZdQbZvVJ3f+rsa6iUjN4wCgcOZ34YFQt9XOiIKvNy7vnuIqBPkdZ1cOR4tEUX7lVNaxW1pWU4DcRHdCTn7oBK4fn3lizHg=
X-CR-MTA-TID: 64aa7808
Received: from L0b3bdeb34bcb.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5020E15E-C890-4936-A4CE-100AA130C8BE.1;
	Tue, 18 Feb 2025 14:28:46 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L0b3bdeb34bcb.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 18 Feb 2025 14:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xA1ow2v0iw/cFgjKXYHZP2zcgStzz9rYEMRmtcGwIlJVuELfTYQlixy+nVfRettcuZIb+Wze+xWIul2DGO2A1qK6Bx2NCnDJzxdel9UNNiA7ELhSlBUC46GfZMlwAdf6MFRsYKVzsNHNBetlBR7Oj0tWjTzW1HQux+2qLFOUYs5RDVwniZXJiM9Qtjl4QBlwANpVauSpDf9Dc3vljYf9yp1bY65nGGBf+5VtmWcMgCyZpUMp4IYK8DMcAnfqr3V3PMhL69DfDdi0lK5OGOwHUJNAgl4zswFez/AiO8CpoBXYwyYISvncs9UchmiyElTpvI+IUaZxk75m+cz9WbdvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRI3CIZytci1IZddUvS5492//JgsLu0dlaH3BjXCdT8=;
 b=LOvjs08KBTsitDtbApZ4ICY32JxDLhYzyAlWSs5DiStIvPQiccuMSC3N23U8iWINp4Pxazg1ls6EpGoBQD+QVoBUWvHzS8VAP/OVQqpch+uL3HgP7ncbCds/azM2Fb8J2glZ/OzKshKxDMDl5JmC9GkyTBXsE3KmPeiq+dUMbVhwxhelFTxJ8pV2l14Y5ju5GvKFtetUX4SGc/bRnxvBbAxnXDCpV6tpHCwv/jc9VYyc5Z8XUGGghYV14NAj8Z6BuztD0WUERiYeRzs3t4OR+i/v8mWgJD4N5sPjhN6G27+48BQp2DPpc6Ur1KZEFo0D08c0h/zmg15nxoXctihhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRI3CIZytci1IZddUvS5492//JgsLu0dlaH3BjXCdT8=;
 b=YR70vGlF5NILdRKKj5Dj4Vf5iQelnjJqaajBP8XnS8EBl8XOS+v1q0Vn+cCnzf82/EZ/HR/XYlZnBwo821pVsDhacX+53U/skw/iCZJD3ZmZvaaayrOFAlDO3kCRxvVvjmV0BLhVdCu2oCGXdRY4Tnr4FZAlSo3Z8LBw17oOacE=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by DU0PR08MB8229.eurprd08.prod.outlook.com (2603:10a6:10:3a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 14:28:44 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%4]) with mapi id 15.20.8445.015; Tue, 18 Feb 2025
 14:28:43 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] knotty: report cache validity
 checking progress
Thread-Topic: [bitbake-devel] [PATCH 2/2] knotty: report cache validity
 checking progress
Thread-Index: AQHbfyVr4Jg8p/0HdEKr7JMBxK8x57NNEYOAgAAK44CAAAgVgA==
Date: Tue, 18 Feb 2025 14:28:43 +0000
Message-ID: <F81B3295-404B-45B4-A18E-D76E4E57EC62@arm.com>
References: <20250214211403.493573-1-chris.laplante@agilent.com>
 <20250214211403.493573-2-chris.laplante@agilent.com>
 <8E5BC146-29FF-418E-9B84-DD82B3076D4C@arm.com>
 <DM8PR12MB54306F77D39DB95F838AB7578BFA2@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB54306F77D39DB95F838AB7578BFA2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.300.87.4.3)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|DU0PR08MB8229:EE_|DU2PEPF00028D07:EE_|DB9PR08MB9921:EE_
X-MS-Office365-Filtering-Correlation-Id: 86abc4e7-76f5-4fe4-2635-08dd502891c5
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?Q2E2c0l5ZHg0YmxRZGJnMHVDaGwrakdEYzY1dFdncFB2RjZpaTZ4VHEycE0x?=
 =?utf-8?B?eHpuSU5SWVpNZHVzVzZwa1FrNEpkRVFqc1BMaFBHN1BLd3RObHZzZkQxY0NJ?=
 =?utf-8?B?L0lnZVIvMk9FMnRjSnVDc1NHY09Zb0FUVXI3Z1ZYUFZrWXNGeGU4a3B4Tm9o?=
 =?utf-8?B?UktZbi9mYm03a29hcEt6YW14SjJPZEhTMzI1VGsxOW9JdmRZaVpicnhKS3NZ?=
 =?utf-8?B?Sm00eVJzTGtES1E0ZXRTemZJanJPSkJKSm5lQTd3SXZ4dzVsVFVZNllnRWZu?=
 =?utf-8?B?bzJUdW1YTFRBQ1AwYU9rMURHVkFRb29qbEtBdy9IUnA0MjhBaFJNNDNYMEly?=
 =?utf-8?B?QWZHOWo3TWgva3A4NVE0b2x4em9OMCt0YUNlWWNKR1lTYzQwbm93dy9zNTBG?=
 =?utf-8?B?SzBhTzZuQkRxOThkRnA2aDg2U0piOTNNcjFZSUw2YTVFKzE5cDVFMFRDSkxj?=
 =?utf-8?B?TTRpaVJacWp5Tk1vM2tqa2pIcjgwVzRGa0NhSXRIS0tLTkNqTm1vVklxOXFs?=
 =?utf-8?B?czRTMUIzZnRjWVVjMDludWcvaVpWT1RLaERGNjM4L1pJWStaTzZiWk5GQkVw?=
 =?utf-8?B?UWFETmdIeXBQSzNPdkgwbGg1dTg5alM1Zmk3ZUlVY2VjVm01SkpuUkdTYXBQ?=
 =?utf-8?B?SlE3TW1mcjRCdnpkcVdtNFV3RmM1M1pxZUVaSUR6MWp4cjNzSGtJbUlhSkNN?=
 =?utf-8?B?dFdIZmlWcllQL0EreW5sM2FvOXlyWmtOdGxQckhiTXlGeHZIRndpMmo4NFZB?=
 =?utf-8?B?Qk1NeFBpSGI1c1JJWStNN1hlc2dXaUQveGh2aE45S3Y3K2JYRnIyd2RlYUN2?=
 =?utf-8?B?SWNNT1lwUTlMdWZNUmpISlVRRVBRenBFWFZiUDFlZzlDNkRtNDJrS2w1TWYv?=
 =?utf-8?B?ZzJPblZsbzcwMzZuY2Q2bHE0RmVuTEFFcEVTR0tMOUd2SGhXd1VRVTJEVnJy?=
 =?utf-8?B?OWE0eExETnc5VmpDWUJEV0EreGN1V1F0UnM0QjNIeTR6WnVjMENocnJSVkpW?=
 =?utf-8?B?Y3ZPMUhZaVFFZERydzVsZmsyWURmME1POWkvWG44b1kxdW1idU1TejJsZENz?=
 =?utf-8?B?S2lHOGhXbWY4bHA5WWxBMUlSTXB4OWpFTlF6VFIxOUsvdmRweUhDdGthMSsv?=
 =?utf-8?B?bjFWNHdQMExNSC8yc2lLOHEyd3FlQkhLZjdWeGxKa1hmM2FZYmgwc3hjVnQv?=
 =?utf-8?B?VG5NSkdyNHcrV0NnUEhBZDIxTmRzV2tYWTVXS29MaTlKSm1YWnhoSllrWHRP?=
 =?utf-8?B?TG8yTlhrdXNmVDZLYVNTNW41RXYra2p2S2pkL1FmSmNHamJzMTZzeUtNdVZp?=
 =?utf-8?B?ejBzN3V5bE03SFh3MGRUam5JR1hFSllmSEdTV0hJVDJGTmZlMkZRVXJmMTRK?=
 =?utf-8?B?b3FXdmtDTkl2Z0VWc1lpY0V4blBvMDc2Wk9OMVNsZVlFRzFMWFFuekNrNzRt?=
 =?utf-8?B?R1hqczRkWEI4ZmdXUlo2SzQ0MlRMR3pJbWlCWXpUK3VYRWNnTjRJV3Z3L2VF?=
 =?utf-8?B?cFJ1SnZoYlZuVmFrNmI4WWM4c09SSUZwTzhGVWRzc3dSMFc4WUhDTmUxNTQ2?=
 =?utf-8?B?bHhXcklOL0lXcFdXNVI1S0Q0K3VvQWRXWTFQMUxvK1lpcnpCSXdPMWUrTFEx?=
 =?utf-8?B?TVhSSUoxV1MvMUswWUNydjBicjczS243VzB0MTVtbFd6a2daUks3Tjd3Rnhr?=
 =?utf-8?B?dm1HQlRkbXI1enc5WGRYeVRkL0lFT2ZHSlhrZUVtZGtPbEs3YUluZUZFZUNQ?=
 =?utf-8?B?VVQ3YUgzT1haRW9ZQjQzdG1laklGZ3JYN0FPdnJKNFphWDUvYzRXanNpdWR1?=
 =?utf-8?B?czlPMEhQT2lCYVMrZGtuaXhsckVZRkJPOWl2VUJnMnJUenBuZ294RDk4WTJz?=
 =?utf-8?B?dGVrZXd1MEZ0VjJ0TzllSW8yR3ozWjRuSmVESWpRZEVOcFR4bFk5b1c1UUNY?=
 =?utf-8?Q?zQ33dVGa0zLKqoINHxv0zbR7gFvbY6Tc?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6BFBCF12E29444397F7603125DEC4E7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8229
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: 
 ip=[2603:10a6:102:2a3::12];domain=PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	3ef985ec-93ff-4d15-df0d-08dd50288c31
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|14060799003|82310400026|36860700013|376014|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dzhicGk4YnpweHZ1MUFYKys0QzhTR2JoaTlHSGNMa0JZeDJzR1JZRjljRWlS?=
 =?utf-8?B?dTBiVWRkRlFZcjQ2d051SFd5NC9Ya1lGbGk5VUZlK1pMNm5hTlBJd1hsUTZK?=
 =?utf-8?B?L3p5UkFYWXNDOTlmRUY0RG5kUGdXdlNyY0x4ZXAxRDlSUS9uc1JqRUVtL3FF?=
 =?utf-8?B?QzJsZzhRNld5dXNOK0hoSVJJcVVUZncvVTh3V3Q0RllvZzVmbk40RS9IamN2?=
 =?utf-8?B?NjRPOXowOTJabkxIa1d2VmczMy85L1Y1K2gySEdEQ3d1ZGpFMzJmSm1GK05z?=
 =?utf-8?B?S2g4cmFWOFMwSy9iY21tMUIrK3JBUTFrdWNQN2hSanRQbUdZRTFyWkx6NzQ0?=
 =?utf-8?B?eVJGWGVMZUYwUlk0MlNyS0xsM0RzYkhDUENxSGlpWktkTlpMSWljbFdQcXNK?=
 =?utf-8?B?YWRuRHZNaHI3QS8wamZHTVdvZHFoSEkzNXcxS0VONzZNZENSWjZwQlNrVzZW?=
 =?utf-8?B?dFpuYzVrNmVmK0ZLdnBkRWROZU1zaEh0NGlrL1diOE9yanFEczIzTDRjQmlm?=
 =?utf-8?B?UXVtL3hXOS83d3NrWVZmdHFDd1VLWmJlRWZ1RS9WdnR5elp2N0VlY0k2S3B6?=
 =?utf-8?B?S0o1bjd6WStLZ0c2YmlZT3JFby9SZGM0RUtwVGYrQWhYc2k2a1VZNysrZlJs?=
 =?utf-8?B?aWZoNE5DcXdBVTRwc2g5dU5iRnh3UFJ1cytEeG5WR1lPM1ZQUjNoYVVIODh5?=
 =?utf-8?B?em9sdWFFTG1nTFNUVWtSREtTUmc5dFhyREJPMWRqQzVQQ0dIbVRxamNnT3Rp?=
 =?utf-8?B?T3BlakFzS3FsTHErRElmWGF1UnRzVGpYUFlrRG9qS0g1cit3bVNOWmhuM3pS?=
 =?utf-8?B?Y0dhazNnOWM1aVlqbTNBZkZvYSs5NFlQUHlpRGY1Z2FhaWZTVnJHOU0xeDR3?=
 =?utf-8?B?TkZnM1FtckFjdXV1VlZQclQ3dFU5cGFYV0VpeUlqTTZhcnkxZXluZkJzTzNC?=
 =?utf-8?B?RXBYN09yQWx4KzZTWFJTSnNvSGRJNmV0MUFxb2Rrc0hpUTFSOUxDemRTMmVv?=
 =?utf-8?B?SjhoQ1lWcnhBU2Rac1BobWtmTUluUUFXRnhmNXJsam9zSitlWUR2WW1McGU0?=
 =?utf-8?B?c3pYbnRLTXEyZktuSFBZSk9LVG5Xbklad1JJYzhlS2hHcDd3SUw2ZEJjaTZx?=
 =?utf-8?B?Y091TzM1Vy9xemoxTjVpN0NmK3F4SmpNSlZvN0toQkpiVTZuWlNBbndBWVJx?=
 =?utf-8?B?MHZWNzBhRHpyb2tpVzVDU3YvVXh0MVVkcVVoSzczSEVGQ3FobFhvbmpoTmIx?=
 =?utf-8?B?V216eVQ2WHlBck1TMldXSFdxb1dKcWRHWjNuUTM5NkZKNExBYlF2VnZhb1di?=
 =?utf-8?B?Vk1laWhLKzQ1S21kdTcxTEg4cmhmMW45WHJ3cVU4SkttR2ZVQy8zNGx6R1J3?=
 =?utf-8?B?UGEreTJlMWZxdVU5R1AwTDE4by9Db2g4NGFRVlBERnBSMWFWNTRRU29aQk1X?=
 =?utf-8?B?cC9qL3hFSG9aSzQ3eC9GU20zeTJWc0QwemFYR0RZWjkxdm9yamZxa1o4TWQr?=
 =?utf-8?B?bmQzSGk2VGpjNXNVSG9BK2lzMEh5ejgwWnBuWTNOaEFSUjNPVUhXNWJKQVA0?=
 =?utf-8?B?cE9sRFZRTXcyRGVGM0pzZFkvU29JNmFVR0F1Q1o5bFI4dm5oclhiQW1XTjFi?=
 =?utf-8?B?S3B4by8vZzRKc1BEaVZUZmdzemxWRjhoRFhzMm5wcHFNalRqWjRubmhjWkRj?=
 =?utf-8?B?Z1h2TVJLU2FKMHdXZHJYdE5Zc3dZRDdMOUNiMHFSZTBwZVg3SllKcE5vUTRC?=
 =?utf-8?B?R1g5a0lVTTE2NXV5VzdkZjczUVhLTGM5dWR3eVQ2TWhLM1R4T294Mi9VY0gr?=
 =?utf-8?B?TVU3YjQ0WTl5Yi9DUUx5Tms1QmVjaG1xbmUvWXAzM0kzSWFYUFBqaEdBMEFw?=
 =?utf-8?B?NS9Ra29tYlkxaFd1NldoZ09KNEp1ZXhjL1VGUjNKRHBEamlGTm1PZHB3Rk1x?=
 =?utf-8?B?ZHF5cWZENW5ocWFGcVVxS0xub1lMNmRWb2NnZCtaR2J2RG1vQlRRbDdTUHJQ?=
 =?utf-8?Q?6MSCDd7JXyoi8zrvvh0t5WQU3WJGKk=3D?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(36860700013)(376014)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 14:28:53.1009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86abc4e7-76f5-4fe4-2635-08dd502891c5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9921
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Feb 2025 14:29:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17241

T24gMTggRmViIDIwMjUsIGF0IDEzOjU5LCBjaHJpcy5sYXBsYW50ZUBhZ2lsZW50LmNvbSB3cm90
ZToNCj4gV2hpY2ggbXVsdGlwbGUgcHJvZ3Jlc3MgYmFycyBhcmUgeW91IHJlZmVycmluZyB0bz8g
RG8geW91IG1lYW4gdGhlIHNlcGFyYXRlIHByb2dyZXNzIGJhciBmb3IgbG9hZGluZyBjYWNoZSBh
bmQgY2hlY2tpbmcgY2FjaGUgdmFsaWRpdHk/IElmIHRoYXQncyB0aGUgY2FzZSwgdGhlbiBJIGFn
cmVlIGFuZCB3b3VsZCBiZSB3aWxsaW5nIHRvIGNvbWJpbmUgdGhlbS4NCg0KWWVzLCB0aGF04oCZ
cyByaWdodC4NCg0KUm9zcw==

