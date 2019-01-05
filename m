Return-Path: <alejandr@xilinx.com>
X-Greylist: delayed 8283 seconds by postgrey-1.34 at layers.openembedded.org;
	Sat, 05 Jan 2019 10:23:23 UTC
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr790070.outbound.protection.outlook.com [40.107.79.70])
	by mail.openembedded.org (Postfix) with ESMTP id 1E4626C494
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  5 Jan 2019 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ikxCD+2E0Bp3s4ZgQgKsDQzqSnP5OqE8+7SQqkfP6RM=;
	b=iDrCqIe71clgIawHFCK00shXX11FdkhNkAV9H9UuHwklMrneHq/9eRElJemdXRAWOlejRCeaVcL41nd145YxbCDu5y8xr0L5TKAvNg41i8YclDOBLTrK38eGR6C+AmiM7n3E/QL1B4aW0Nkaq+o8Y2pcRjhZTTIo3GqCL4HCtK8=
Received: from CY4PR02CA0035.namprd02.prod.outlook.com (2603:10b6:903:117::21)
	by DM6PR02MB5227.namprd02.prod.outlook.com (2603:10b6:5:48::12) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.9;
	Sat, 5 Jan 2019 07:50:05 +0000
Received: from CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
	(2a01:111:f400:7e45::201) by CY4PR02CA0035.outlook.office365.com
	(2603:10b6:903:117::21) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via
	Frontend Transport; Sat, 5 Jan 2019 07:50:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
	smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
	header.d=none;gmail.com; dmarc=bestguesspass action=none
	header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
	149.199.60.100 as permitted sender) receiver=protection.outlook.com;
	client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
	CY1NAM02FT013.mail.protection.outlook.com (10.152.75.162) with
	Microsoft SMTP Server (version=TLS1_0,
	cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
	via Frontend Transport; Sat, 5 Jan 2019 07:50:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35792
	helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
	(envelope-from <alejandro.enedino.hernandez-samaniego@xilinx.com>)
	id 1gfgiY-0005o6-FB; Fri, 04 Jan 2019 23:50:02 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <alejandro.enedino.hernandez-samaniego@xilinx.com>)
	id 1gfgiT-0005T9-B0; Fri, 04 Jan 2019 23:49:57 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
	by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id
	x057nuEN003129; Fri, 4 Jan 2019 23:49:56 -0800
Received: from [10.23.119.110] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <alejandr@xilinx.com>)
	id 1gfgiS-0005T6-Ez; Fri, 04 Jan 2019 23:49:56 -0800
To: Joshua Watt <jpewhacker@gmail.com>,
	<openembedded-core@lists.openembedded.org>,
	<bitbake-devel@lists.openembedded.org>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
	<20181219031033.28045-4-JPEWhacker@gmail.com>
From: Alejandro Hernandez <alejandro.enedino.hernandez-samaniego@xilinx.com>
Message-ID: <d41b6e89-8450-58c9-13fb-6437332f3f20@xilinx.com>
Date: Fri, 4 Jan 2019 23:49:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181219031033.28045-4-JPEWhacker@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(2980300002)(189003)(199004)(8936002)(31686004)(65826007)(5660300001)(6246003)(31696002)(81156014)(81166006)(39060400002)(305945005)(2201001)(8676002)(478600001)(63266004)(2906002)(2870700001)(110136005)(58126008)(106466001)(426003)(50466002)(65956001)(64126003)(316002)(446003)(23676004)(106002)(65806001)(76176011)(229853002)(2486003)(14444005)(36756003)(11346002)(47776003)(9786002)(26005)(186003)(77096007)(53546011)(476003)(356004)(2616005)(486006)(67846002)(336012)(126002)(107986001)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB5227; H:xsj-pvapsmtpgw02;
	FPR:; SPF:Pass; LANG:en;
	PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com; MX:1; A:1; 
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02FT013;
	1:UPbyeFBAI2zMmx0HZehwfbJhkOWTJvDmhHE879FcQOA11NtQQeTFbOO/vtXneOs6ESRlmY1YTIc0wdQFsjBkESjU618MB/ESgNQPeOSV3QYGsnzYe1ITrODXPvAxsGf/
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f2c6603-1fa0-487c-e856-08d672e26774
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);
	SRVR:DM6PR02MB5227; 
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB5227;
	3:dNYkYMQrutOfa+doEi9JhRNStVnvlEu8vrB564NjyfcaZMTC9WXW4rj0YJgKrHkaCbwFXHYSjO+db9BFZaT9lfI9CH5iKy9lWLnsV9XKhjjvEsOLiwdTFEEg8bQZvismJ4h4/249A7Dzelwl6KtrhGB3zZ9mVOYc4MYQaCnoNqlemGGxyf9iuUK+Y5KzKP53mszzVIzQgU9BtDYXeZF0d5d0D38ELydR5gFUjRZVYgyKw/aiTXPy85MeaBQrOXVniOlAPhk7Svz5eCh//7InnJ1TQOuqQ1xUAUrEAiOsJNoG1XJTJBGHJ+N974Ap313OJHEUpT1erCiIAp/2puA76h1OYV5dmtxRPjdpbpgtr9D0WVHuXwRutINc5dEUTs3x;
	25:kCKPg+mZKKfwY/E+JmgFolIqd1pAZ+J1c66FWdfuxKJCSk/s2sVqhfu+keRp944oZrv9C/mIxEuFFKKIJVNgjF/DTNpqLmOvjhRuRNFqThAySrJnJlLqS5jo8eY8XGgcEHbzob0za7BtNnpVMUexSKCU1Ev7DFqxTF0ODmFi1wzDNfLUe1xw5PRXFyrLXkL5mksESUNMLZ+6SfawOCbv96EoQUgxWhosIjqWSmV7f3tC87+PX2nPRBw4Mc8P8jNE1L+82iWh8CY6BqqZA11D8muxf+atcOkFaRnm134r+OWMWcPHBL9tBLkop3mBIHo/T3Ox8mgXqNfUtSwAv3XV4w==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5227:
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB5227;
	31:hl/ccpycAXU/zXERFOthICJ4DKwxYtPFJrDA0XFoDaGqT51JpTFv0FEuCViICGazxniZ0RBo1gxrmtYL4EkTMwX0B9o8aTu8bS3HbAD84PXLi/5K4aFoQIbmQB/ARBCUFOxAUDBrHUYbX+LUD9vipYeiKCqnzc3qCiMu6EvF8rD7PnUHu5AJQ05zhIajR0jcjWeVuR9wJ+YJJ+hMwXull2F+udIN+7Vc/RO6pJ7Nt58=;
	20:9RA4piz39TGE3qjSElCfmrqmO/tNAROyy2lJat65Qb6nGzc27DDP+hdhQqgRkRMacTT+gsDyQutOL4VKlYBtguu/+vjLX7AxYS9YFfKjsD/TmTN4piAFFEeCAdACo59Zg3GQGfMDiB97wTKiFhKAwhd833OU+ZCxl+XlL2j6umS6lSWuuReut7HIbyQAXUPKhqf3z+jNfyvRgfkXOdr4HrJD6pXmweJIhLSk+8f32KaZ5wuq59prd2lZtvaLabgZhL9JKFWaoUrfPOdd79yNmgi9vF4HPQ8LoLdNWbPpa88cHid3iulgTHqy6c5ex607giCV55Y2GUMCaxGxnd7hQgyja0FqzLoOxOscuwCMYG+e0CJSKlaXLDI5dyiDMMOsW4XSDIu6dz2pAtQ2qciZE499N5xhC2jQ4+shDrlcIURJhN4hST3O23196kF0eegp+pbE2B77TJBcdctB9yDZyymrcWS8RzIGC2XzENYnbh9SpQ1L98+wLsB2RPdvlgC5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB5227CB8D556C51C485EABE07AC8F0@DM6PR02MB5227.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(93006095)(93004095)(3231475)(944501520)(52105112)(10201501046)(6055026)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
	SRVR:DM6PR02MB5227; BCL:0; PCL:0; RULEID:; SRVR:DM6PR02MB5227; 
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB5227;
	4:dp0iLURN1c5aeE1zRx7n7I993e8CGB0KZbr0/qlmwxFmKUcz0l0VVjOfqY1HGgFZO6zpVy6ASd2nzUs8x0VL/crytEGoiD9Unz9FOywbUFF9EWk0x6OY8dG6JqWhtXxDvWpBdK/9dUK02dGiRyeVSOuYeHjqEDOoCAZIK9ZAdXWVMt4K4SrcbQ8beTUW+aFuiDuQKL+0FTcgDL3VHFFnNP3IzIJfl/0h4yfnDTlSKbRgpQGbpK7SZHnILP47O3Hfc+QIDl3JobqulMHhqC51FgLvnI3vJhRlZNO9fXd5x4U=
X-Forefront-PRVS: 09086FB5C5
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI1MjI3OzIzOjFhQW0rdzlCNUlBVkphRExnSkpvd3dTS2w2?=
	=?utf-8?B?NjdjRWgyL0RoSnZlbVNKR0xEYlI1T3o2aC9jV2U1eCtvWW1lTUI3VjNuYlVF?=
	=?utf-8?B?N1U3aHdqZlg2L2JrcXp3cnM4VXNLRUJ0ckgyZkJLbTFBVm52eUNXbGE4eGRr?=
	=?utf-8?B?U1UzRk8rM1ZyV3RLbnFBaE5ORTc5Rjhac3J4Q01OaWZtSjRTWmZVdytTalVv?=
	=?utf-8?B?dEMyTmx0RWltUzNjUjdzWU4zN0Y3aHNCT0F1ZjQ5SXBSMlNxalJpTUh2MTg1?=
	=?utf-8?B?dGlLbVZzeTM3cGQxd0xKTEE2WUwrcFk4UEJNWFRLeDY2VFViZ3F6RlRJNW1p?=
	=?utf-8?B?RnRndGJDOUxyc1JvSzYwVmNlQVR1ODR3SndJL3FhMWNzZWJtb0g5ZDVlZVBM?=
	=?utf-8?B?WTN0d0xwbjVZNFdiT3ByYmNGa3RhTENqRXFoWXZmanl0YUN1QTAycERuSGFs?=
	=?utf-8?B?OVFVTWQ5YUxMK3J1STJVSHpCRDJKMGlkZDFNRGoxczI5NTRZZVhFWVhXMzc3?=
	=?utf-8?B?aTJoTmRHRnFSa2hEdVRZTWc5bms0cXI2RlRWRkkrRHJFa294b0hUd3hCTUs0?=
	=?utf-8?B?TlA5ZkdieXM0UnNpVzI0Q0wyUGF1Y1pMdkN1YVp6VmlkQVFRYVN3azRTWFJL?=
	=?utf-8?B?aWU5a3ZjNnNTSytpcnl1ZVhxVG9KbGRnREthOVY2eGtuNUxrMUxwTnNrNXBw?=
	=?utf-8?B?RkFKRm1HRVExRnpQQzI0ZW9zT0kxZjVjcVByYVMxREtRMzBuWGpmVVNzZGNL?=
	=?utf-8?B?VHMvbUROU2ZsQmlILzFabVRsWFVSZjNxbFFKVVBkVnZGRUlsTFYvaHNqSkZs?=
	=?utf-8?B?cmtDVHR0anZqQ3UvdlB3RU0zcHl3dmtzTDBlSjdJSVNxM1kwRG8yaDY0REJm?=
	=?utf-8?B?QmQ5MlJMbmtVQUZqQlRCNGl6alJiUjIwVzVuU2xLdjlZVUloSW1OZjd1RmNM?=
	=?utf-8?B?MHRodkx1N0pmV21iZzRnczUvMmUvMkxaUmMyMEhHeTZZaUt5aHNjZWpYTGxZ?=
	=?utf-8?B?YnNXOUVjTGlWbEFuTnBxQWVtTVF2UjJQTmZjS2lUWG5LaFQrczlWTzgxWURW?=
	=?utf-8?B?b09Nbjc5cG9WREMzUk5OT3NRdW9DZ2NEWFk0R2V6alJmTzJVdDNGUXptSVNx?=
	=?utf-8?B?bDJ1cE5oK1FKQnFxcHdzcUhuSTZwOHAzbEozeU5FVzl2em5iM0FDMktvbkMv?=
	=?utf-8?B?QzZFamdWem1NQkFNYjcwQXVyYmpIbmwrQThJaEFNaUpPTTZydHBkV1ZlbEVZ?=
	=?utf-8?B?WHJySnBxRjM3QzhnMm9uTlUvQWtwY1A0dWFkVmFtSnN2QkNSalpCMHJ5d256?=
	=?utf-8?B?YnYvbFNvM0psTHJ4amtyWTBpWkxvdFZOVndESXpDNDRwMGRHaklscFFYdHRp?=
	=?utf-8?B?OTl1VGlDYmxCZzRQaUdCWlFnTnp2Wjc0cXd5bTIwcWRReStvLzdwT1pKL2Mz?=
	=?utf-8?B?NHNldFVxOWZmSmRiaTU2cXF5dSs1cmdwNlhSeGorR3JKNE5HZzM1U0QyQlE3?=
	=?utf-8?B?UzVzTnBsY3pFSDBWR1I1RmhpZzRjQU5nM0tuU2QwUmtGUHJQOGZSWTZWcVRp?=
	=?utf-8?B?MFJXTTd1ejhHd3N4RXgzcXZsNmpxTzRZd2dRWEtESWFuZVY0RGJyN2FpZWdx?=
	=?utf-8?B?WDVIUm5ncU1LVXRIVDNuczNHWWJENGw4YWJJOHNIdG04THkxcFExZkRoblN0?=
	=?utf-8?Q?W3Da90HaSKk8ylRzg0xESWz4hsrZuEfKf5wZxrN?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 1EQuM2hoFefhuPC293mgcr6/OIG67p/6jUE9KweotNPeH2q0R1+B0YbqxZL+rbj2u5vlozocQ70jxnA/OLEnZl5V5eGctYpFB52HMj3hz3Qz+KS+wm61yfAlpsBmb+kBY7aLDkSLmAHTdu8W1B7dusQ9w8f7h1ongRI+hV69vFSCtPVSiWOsiTfjlnfXN18Tuo/JLpmA/zuWrgp1PmgzTD3Ui9uRyxltsmlt070K9dqloNX0GdlAhhIKDN1Yn3HFRWvFmxs7BM/waJsQkv/otziai9OBh+WzsNMXc7NnCLsSJt4nT9HvesP7Q/91Vwn1
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB5227;
	6:mZl6dpw84pu/vbFVGQ6l3D31hirSGCm6a0o/cvviSdhDggwK/yTGu5QiHD2CrxrAnoneYMoFuwWFpYPnqn8WcIhN7gnlTMjqkGpgCh4qFX5CGSdou/QDeLH1icbdUevwkdQSpUE1hjOw+AhbLVW4+CjlJRZ9brr3seyBCFjIU1aGDVhu1bFqV2BLbQAfcroQSUcMuo4UbdikRvJZGeqDAsHDfANDW10k9X8XX4NOkfnP5v4jEhVW61q64DAo915ePER0ByhpeQ/hWhD6J493P2JUAKZiitc+zjkGrpAYsvXxVr3MR1S5DZKcjTs18yFCE3eRoDjYUcbII2IjWewtjDHt8ptuX8aZ+8ssA6P3/r7OjB2RHXiEvSfuarorxQPzEFc+a14bX4H0kOg3dDJa2Fy2DGk0PxsKoR3Qp9Dc6wWdSRSb/queiLQdsTArwfqC6bNAr1bbqReUaoRULqfUgw==;
	5:6gSBqDin0WsnZaKDYPkBm8tFNFOhrNo3hOK9fGa+bzvMY0wD+wGGVnMlYUvm9ZXvFnoPtUSeR665P9xz+76Jl1deRqZiBF472jY+qDoHE8onDN9zV0fLC7T8tH2myoiON98i3zgySYA37r/dRMWqZDPJYB9wDY3eOhAar8PgTthlTnJEwm29ARB0oTuYhzGpQCMAJNzlQpC3cmAxaaghGw==;
	7:86QZARorLufg8nVTXoNhpWDlbSfibcg2u2oiAm1zVUXvVr0QYWNpwUJ76Uzcb2OsHfboa18czgUrwMRqDN+meSJs5lKV5CQ6q6s7b1pUhlL91KORe57KiX6Q6r3J6epGKUj8w5LFBno1b+oU7fg5AQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2019 07:50:03.1362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2c6603-1fa0-487c-e856-08d672e26774
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;
	Ip=[149.199.60.100]; Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5227
Subject: Re: [OE-core] [PATCH v5 3/8] bitbake: runqueue: Track task unique hash
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 05 Jan 2019 10:23:24 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US

Hey Joshua,

This is breaking multiconfig builds with the following error (trimmed), 
I believe it is not taking into account that the Key could contain 
"mc:..." if it is a multiconfig build.


ERROR: Running idle function
  File "poky/bitbake/lib/bb/runqueue.py", line 1170, in 
RunQueueData.prepare_task_hash(tid='multiconfig:x86:poky/meta/recipes-support/attr/acl_2.2.52.bb:do_fetch'):
              self.runtaskentries[tid].hash = 
bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
     >        self.runtaskentries[tid].unihash = 
bb.parse.siggen.get_unihash(fn + "." + taskname)

   File "poky/bitbake/lib/bb/siggen.py", line 45, in 
SignatureGeneratorOEBasicHash.get_unihash(task='poky/meta/recipes-support/attr/acl_2.2.52.bb.do_fetch'):
          def get_unihash(self, task):
     >        return self.taskhash[task]

KeyError: 'poky/meta/recipes-support/attr/acl_2.2.52.bb.do_fetch'


Cheers,

Alejandro


On 12/18/2018 7:10 PM, Joshua Watt wrote:
> Requests the task unique hash from siggen and tracks it
>
> [YOCTO #13030]
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   bitbake/lib/bb/runqueue.py | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index f2b95a9829b..27b188256dd 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -346,6 +346,7 @@ class RunTaskEntry(object):
>           self.depends = set()
>           self.revdeps = set()
>           self.hash = None
> +        self.unihash = None
>           self.task = None
>           self.weight = 1
>   
> @@ -385,6 +386,9 @@ class RunQueueData:
>       def get_task_hash(self, tid):
>           return self.runtaskentries[tid].hash
>   
> +    def get_task_unihash(self, tid):
> +        return self.runtaskentries[tid].unihash
> +
>       def get_user_idstring(self, tid, task_name_suffix = ""):
>           return tid + task_name_suffix
>   
> @@ -1150,18 +1154,21 @@ class RunQueueData:
>                   if len(self.runtaskentries[tid].depends - dealtwith) == 0:
>                       dealtwith.add(tid)
>                       todeal.remove(tid)
> -                    procdep = []
> -                    for dep in self.runtaskentries[tid].depends:
> -                        procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
> -                    (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
> -                    self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
> -                    task = self.runtaskentries[tid].task
> +                    self.prepare_task_hash(tid)
>   
>           bb.parse.siggen.writeout_file_checksum_cache()
>   
>           #self.dump_data()
>           return len(self.runtaskentries)
>   
> +    def prepare_task_hash(self, tid):
> +        procdep = []
> +        for dep in self.runtaskentries[tid].depends:
> +            procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
> +        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
> +        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
> +        self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(fn + "." + taskname)
> +
>       def dump_data(self):
>           """
>           Dump some debug information on the internal data structures
> @@ -2081,7 +2088,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
>                   deps = self.rqdata.runtaskentries[revdep].depends
>                   provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
>                   taskhash = self.rqdata.runtaskentries[revdep].hash
> -                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
> +                unihash = self.rqdata.runtaskentries[revdep].unihash
> +                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
>                   for revdep2 in deps:
>                       if revdep2 not in taskdepdata:
>                           additional.append(revdep2)
> @@ -2524,7 +2532,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
>                   deps = getsetscenedeps(revdep)
>                   provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
>                   taskhash = self.rqdata.runtaskentries[revdep].hash
> -                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
> +                unihash = self.rqdata.runtaskentries[revdep].unihash
> +                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
>                   for revdep2 in deps:
>                       if revdep2 not in taskdepdata:
>                           additional.append(revdep2)

