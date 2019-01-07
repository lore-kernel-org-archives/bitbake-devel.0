Return-Path: <alejandr@xilinx.com>
X-Greylist: delayed 103601 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 08 Jan 2019 20:13:17 UTC
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr790077.outbound.protection.outlook.com [40.107.79.77])
	by mail.openembedded.org (Postfix) with ESMTP id E206F7BDA5
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jan 2019 20:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=HK8WZ2JE1AsHLiO5W3yp2VyAVie3AtAVRSNqyf29yPM=;
	b=wrZkabYc2mz7+8KOVkzlAxbsa8AdJFD9DtgdIKN93eOigXS6IxGX8gvyhkiv8SWssC7UeIbT0hUBP6f8OCgs1ADSB+X8BOM/k1kB/FtUYVteBMUa7fUeNdmG3t0c7iQyln4XRxbm0FEr4awQk5R/HHret2i5QrkDNbH9sK4UrUQ=
Received: from BL0PR02CA0104.namprd02.prod.outlook.com (2603:10b6:208:51::45)
	by DM6PR02MB4332.namprd02.prod.outlook.com (2603:10b6:5:2a::29) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.6;
	Mon, 7 Jan 2019 06:52:58 +0000
Received: from SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
	(2a01:111:f400:7e44::207) by BL0PR02CA0104.outlook.office365.com
	(2603:10b6:208:51::45) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via
	Frontend Transport; Mon, 7 Jan 2019 06:52:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
	smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
	header.d=none;gmail.com; dmarc=bestguesspass action=none
	header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
	149.199.60.100 as permitted sender) receiver=protection.outlook.com;
	client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
	SN1NAM02FT013.mail.protection.outlook.com (10.152.72.98) with Microsoft
	SMTP Server (version=TLS1_0,
	cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
	via Frontend Transport; Mon, 7 Jan 2019 06:52:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46772
	helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
	(envelope-from <alejandro.enedino.hernandez-samaniego@xilinx.com>)
	id 1ggOmN-00071m-6i; Sun, 06 Jan 2019 22:52:55 -0800
Received: from [127.0.0.1] (helo=localhost)
	by xsj-pvapsmtp01 with smtp (Exim 4.63)
	(envelope-from <alejandro.enedino.hernandez-samaniego@xilinx.com>)
	id 1ggOmI-0005eE-3H; Sun, 06 Jan 2019 22:52:50 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
	by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id
	x076qmLU002150; Sun, 6 Jan 2019 22:52:48 -0800
Received: from [10.23.119.100] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <alejandr@xilinx.com>)
	id 1ggOmG-0005e4-4W; Sun, 06 Jan 2019 22:52:48 -0800
To: Joshua Watt <jpewhacker@gmail.com>, Alejandro Hernandez
	<alejandro.enedino.hernandez-samaniego@xilinx.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
	<20181219031033.28045-4-JPEWhacker@gmail.com>
	<d41b6e89-8450-58c9-13fb-6437332f3f20@xilinx.com>
	<CAJdd5Gbik0fCVCoWYzwYF7ND6G35ADeX0UdAk1_2X7k2TcnPQw@mail.gmail.com>
From: Alejandro Hernandez <alejandro.enedino.hernandez-samaniego@xilinx.com>
Message-ID: <db1592d6-4400-09ee-4428-8b3702ef8987@xilinx.com>
Date: Sun, 6 Jan 2019 22:52:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJdd5Gbik0fCVCoWYzwYF7ND6G35ADeX0UdAk1_2X7k2TcnPQw@mail.gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(446003)(186003)(106466001)(110136005)(63266004)(67846002)(93886005)(23676004)(2486003)(9786002)(54906003)(50466002)(336012)(426003)(106002)(11346002)(486006)(5660300001)(36756003)(126002)(2616005)(65826007)(31686004)(2906002)(81156014)(64126003)(58126008)(36386004)(8936002)(81166006)(6246003)(53546011)(476003)(229853002)(76176011)(4326008)(47776003)(39060400002)(65806001)(14444005)(65956001)(305945005)(26005)(31696002)(316002)(8676002)(230700001)(77096007)(478600001)(356004)(107986001)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB4332; H:xsj-pvapsmtpgw02;
	FPR:; SPF:Pass; LANG:en;
	PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com; A:1; MX:1; 
X-Microsoft-Exchange-Diagnostics: 1; SN1NAM02FT013;
	1:v7/7VVk8ZOSFqIFr/4qirN+onbrSXVSzEOKzOngar8mLeWSf35MQe98p9/t5crZ4e62L3+gNI/8Y/V572BSLRRe3XbGBkIhKxSDYWspnZC36JW7U0TZN1rWh3KXdqSCF
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d341acd2-1a2b-4a2e-7a0d-08d6746cc17f
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);
	SRVR:DM6PR02MB4332; 
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
	3:JlIhz2INdQ79Hqt0RHQTxC929/bgz5/UcbSCSKW91Op5iwDts/+yE7FIOCI6pvl3XFgR9GgOdIA3j15Peo8qtjefzWxrOO+GwZ0Elwc8f7ewmGqZ0AJ34n7kItrj5mdHzVdgH/N7u48Px9w+hl5jWgQ0fRwiwYtxkai+sWoe9awA0cGkuBn0awsUGYlJGwxPWioKf3wU0EwxPbsB+0A3fR38gBwYwnhSq0lEX+fbTYTWMzSuR1PfrA56cKMHFRIqGk0l2yrvPG59k054nF0GeLtM3Q/PhemwE3DqXhPZDKZOulAZ4Fo1x02oW4U0nLs2hA6iAHTNgppEoibsr3dw9j4/LOO9yaPpOH4RvCjD/GvSSU5hlr7ZAQ09c4TFjED0;
	25:W2G/yCPZgrGu0viSOhzCtHJxMB+EKZWpth7EQCS28pegha6NyGOtzRJA4LOzwCYfOvjbSDZ1ZQ+DRhNcsWWuxgqB0VRVj6zfHPKAZbMKVkDdDwqK7c7SKzIJfm/kV2NGUwoGldkIfzWIArjmSwF++12SFW5QMMFyTFaq/zQ5luQnOee/GYHvbf2y9Gj+vmarUt5z4PX3rG5Vy3WB0o/tv4CtzlRzMzaDvw7PVH4NEeGrWnjBNiEIkdRjJ3DFo/ZE+MKXY9a8TrxI4HjGXTpRPc9uQv+T1VP0BfhGslta1u709BzaNURwbYOyNibn5CXkIgsi9pOOUCO+W2SeSra2og==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4332:|DM6PR02MB4332:
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
	31:rXmRe1jidbK73RK6XD0u6PMc0sSbVY8q5BqO+6Mqblfc+RfAGM5X3PShgX69xayY7hMJfXm1/pfYjunoDuQmiX6X36N1PcIQJhVP/RDCsUwqRCYebdM+wsmX2r0W11nvIuYD44HMWPJ7c+LJb4P11fBmyj+9qruFiwH62O67C9OPJmwfCWGInQ++3NuOmmd+1m7v6+4cF50vbXZpyN/HzzLP3n8MlMYB8J90MjGvP+Y=;
	20:yJVY4aa1CDoBmUeR5C2+cgpy+EdEhpwRwhY+xHENDu+saspPAEn/nsidPb/6ZHy0C0nfv8fTgvlTC/8+RCrWy9HJgKbzI+AQwN8+CSAt5y0Nq3loOM+2TFz1Ciuh3C5W8TtZQEByLJPzLaVEYhAo61qF0sDUJsM9yqvwYilIxuzXj56yr2ILc0tca2RStoDrH/7iNPOoMxW17oywgs4w4o6pSw+V+GEbdv8YGRxnQRlG5PhL38EJoKMyraoA+u0ABDqNYsZJh8O58BEKzX2QzO4Q5gMTtF7ufRoB0s/oY3LqjusItuFV4qcVuSBZfvfc2EeP377C2LkafOlexrxXZYYpOCu3xQcXnyl9Wydroh14twGF3WrFT8KYyyn/r2JW7bFn0Ny23kkDrtp9Pm6X/NYGR/yG6YyPPBVRL6zJCOEvNaw7DsgZXUiHPprRfBxG/93QJVVXH16IrIpzwlfUYeUqeoMUH3peyuwFk7RNolIWU4HP1tDtK7TQLwy1W9vV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB43324F8AC1F09103F082C01AAC890@DM6PR02MB4332.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93004095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
	SRVR:DM6PR02MB4332; BCL:0; PCL:0; RULEID:; SRVR:DM6PR02MB4332; 
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
	4:Wy+o0dgP6lYDCBXq3aNZbSXHBbCvZgc0Jf0WgGH1DbYRoYi5HIpZU+2E3X/i2Sex7qRH7jaaE+EcEfnZdJpH7yr5ZTU16gn9ab1jnQBmH1rIJBANsKI8XIbOcWxsG1yMDPUS97M73c2pwYhiYJLNYfNUJhQHkBgdcuryzivDrRKklj/3C1FYFE5N/Aeo9NULgE9prr8AxX3JI2jq/XVfWT15DcW1ejjgV8BTolFKUxPXuyui7IcZeI32Wen5VUFWuBBph95/7hqcGyQGI9809gNsOONIrJGhClpvC5luGlDIejOyRiYjQkSepVgFePI9
X-Forefront-PRVS: 0910AAF391
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI0MzMyOzIzOkFYd3VFZE1aSG9wYlk0aThkYnRkN3IyWlFZ?=
	=?utf-8?B?bmZwRWtmRWFWb1l5MGt2WGRKRmhEZ0FhY2V3anZnMmd1dzNFN1lkQlV5YmdO?=
	=?utf-8?B?VkREd096OTZGbDYxekxDTkNZQ29jUVpqdkJTTkVsbWNNQUdSVW5vUmN3SzRl?=
	=?utf-8?B?dk5jMDVIS1NvSklmeWhld1RPQ1BscGlrd1dXYkxJbGRXZTg5T0pDbi9YNTJy?=
	=?utf-8?B?WkJIY1JIYzMxc2dGWTQyejNuV1FUeTQvekVXUlpBQkVXVjhqSTVrQWllTEd2?=
	=?utf-8?B?ZVJoTW1TU0pGRVExbmVvNXBTZGYwK0pkVEN2L043ZXg1MlNOS1RmaXhZa21m?=
	=?utf-8?B?WTdKaGlwTEZDTlZqZWIzRDkwVXh1SWJGMi9YbStseDhrczFBSW00Y3ZDay80?=
	=?utf-8?B?WW5uVTh2Sm1pU2YwZXVQMEVPMklCcnZtN2tXaXhFZXYrU1RlMUJKalpnd1FL?=
	=?utf-8?B?SFZLZFljZXBrdnVlTDhUbWtOYTc2cHFFS0ZIdTFpSkFzTStCTStlTWkyNGYz?=
	=?utf-8?B?QXVmZURNWDdnd1hDb0d4WmVld2VtSFhvRnJ6MnA2WTcrZldZTytWVUpHdUpn?=
	=?utf-8?B?cEFPTnpkZElMaldReGR1SFdHZVR0OUkySlNLcGJFRDRhbXdlMUtyamZUeGhX?=
	=?utf-8?B?QmxUd1BoQjNLVldwbFU4VUJXc1Z1S1l5cmVoMEMxSGVIeDR4MGtsTFJ0bVBv?=
	=?utf-8?B?dHNuZU8vNjAwYXh1WFJBUGtmNklGUVZMaHVWNjMvUERGR0lOamFPanRDRml4?=
	=?utf-8?B?STMwYXRTanAydWFrN0s2ekk2Tkdrb3N0NElMTElFOXJEVjJkenlnTFE4QTZ4?=
	=?utf-8?B?YVFSUW1HZzVDcGhSYlNLaGVaT25WNzZVeTZZWEJ2d3FwV241eUE2ZzJaeEc3?=
	=?utf-8?B?MFpicUtQRC9rUW1jRk5zSHJ4QVUyTlQwK2JLQmltb1Rka3RRUVFHRDV0T2Vr?=
	=?utf-8?B?YTZXZE1yQjl2b2VpTnA0R0ZpaHdSa2lVVXA5Z0tybGZZUlVWNU1PSk93TjE5?=
	=?utf-8?B?dStWcVJOSDdHdm03NUFYc2p4cnNkZlFGd1BKUUFXVk5nblNGRFczT2RUTzFZ?=
	=?utf-8?B?UWs0UkhjbGNkd2ZGaDNjRnhNY3BxeEMxMUpWQnlhdm5vRVp5QlpPYi9HYmQx?=
	=?utf-8?B?VVU4Vzhick54NE9tSXVVWUJ4NFpTSnUvMThJZ1Q3RXJPeFhIMnNkem1IZjlL?=
	=?utf-8?B?UW9ld2VwVGQyVFluYWplRkpacEdMeFpHM3IzeXVOd1RpWEdOUnVwMnNoVmk0?=
	=?utf-8?B?ZUdKREJJTm44QS92OHc4a05lUTVYTUczWkNaY0tIZDlZYWs0dVZjeW5FZ285?=
	=?utf-8?B?QW1PSyszWjEzQ1EwOTBmWjVaYXl0NUNRMk0vcXJBenZqazIrR2U3WWdYOUhJ?=
	=?utf-8?B?U0wrMHlVZXlXaWxqMDNvV1BMR1piZWhadHl6QjNvWGx2T3Z1Zldsa0dHcDhG?=
	=?utf-8?B?N2djeGhYTSt1SjlVWWd1Ni80azU2Vy9uK0YvODFxUHloc0p4NWNhZzRlaE1h?=
	=?utf-8?B?eXFLRlRrSk5iR3ZlTnF0eHplTERhNVJvWXRmU3hUTGtaa2NOeExmcEZSNVpD?=
	=?utf-8?B?QWU1OUtoL2ZpaGUxZlh0RnhlaDd4Q09US1lzV1BCRDh2VjU2NlRHckYrVGo2?=
	=?utf-8?B?S0xyN05vNjIzb2U0OWpvQmEvUTJTeHBSZnZaSndXazFYYWhTWkV5M0tsSWV1?=
	=?utf-8?B?ZUJkRWRrcHB4ZGl4MzN2Ulo1WElnQWV5VnJ5NmRPVkJtY2UxVXg1ZzFYQzRX?=
	=?utf-8?B?ZlBFR0tBSHJFS2ZaWndiY0RNdVN5NlE4VzJHTGwzZzY2SDFkU2xLZzNmVXY4?=
	=?utf-8?Q?0vS/T/fctP/mo?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: P2TrC9h3iIaHuQ+DqHGZ96Cgmj5D8SAo98Bowhe2722uSx2+n1nW5sW32q1Ldd63ATGWdBpxoLR805UA04bqZ1E342yWDxj4bUQNDHPJwLOJ4iM3AuG4FQFgA2PzdnBfFeKBaBiGLaTWH9bCsuCpz2ZjXJKFt7GdBVLdoNFJ4Vy1buiYuZp/Iv+m4vsO0NoOGjhx/jMcX7xU1UD7xgYdqWz0rYITo2BsbaxTK7jatlLYzCY3v+CQCHR807JxN9ngy/9eGZD7DufDHg2XQ0T9DR9t0UypRxOKWxudMc4Mr56Nd1Zqt+0Z8TRZaQiBv5pV
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
	6:vLwHbSqrz3DiUk80kgFRvaFiRpbrW5+z2yiFda7GcfBHI/Ia93NWhRCEwDpOH6M/eDGZP/BfB3htLJIGI/kJxC4ROhsMWdRz/8I+9IqWEUFLTio9+jxC/XwfpoB+LQc1bKG9ykCmYtjWwf7v5J9Yq8MVyvTqSm8FjtFVSdeNKsdAeE/KQPO+tWcEP9tB+N2yXxVEIpM4R8FjboDJLM5++PkCC3neOaqU7Vszqpc/Do8ZISmxf+HggmbGgwgxNV3UHcml086hmvrzjwS917wLE8Mev6KS2/Mh7Uuty31UuiitWFjGIUCkTkRdXoaVJLLkLsE+I1K1MZS8PD2+R4lExeIgWJYqDrYmi/tIRkzF8b0bKpxqP0WUEwwjf5v5QIMXpicxG9qInm3J9L3UbyJJbkNB2UOEgKupVAZBdvfSl0WoBcdTYSD0MaSJ1Ru1x76zkuk8duWwdT75MmEcnk3dIw==;
	5:LGhLc20JfH+fSltkR1G9EoBp8MirTVW3jRtmPHF6nWRHunBdFekuRpaCnMCG1q/GLiM1zdMe0XCQYliyTj7QYvQhzfPFkCY5Rorth9qJLr5RsRfeUCw6wqs0q16FwJwMRh2sjHRP293Gg0XxdcAIkQYs3R8INOQQPBaz7H77rAtIPnifML2Um6kZc7MDY11yQ3GjZq7tfCC4TVS6Jlw+ZQ==;
	7:SvAX8BWUMHafJ6WxSULHvQPneM0fJ0Ph2M2Rprz+rFa3BVdET3k2E7hS0EEjOyEo18AI7qZERI4xkiNfLFen1OMKhT3JIlyQTqLDd1WDT2ZbQZTipMWQUwoYt3xD0rMtzbn6wilshYCc828TEf2hxg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2019 06:52:55.8963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d341acd2-1a2b-4a2e-7a0d-08d6746cc17f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;
	Ip=[149.199.60.100]; Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4332
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
	23:A2mlGqmouzsM8J0UeQYzzmjPGpBlGLjymypecPjSyOulV+DBGEQyljXvK0O58PesKM366vOfovZ9AUwqru3kZsv1UokJxu5fBwDoihwY1bScLWxjvDezS3FbwkLIYRrSsitmzio2IUX/oeTAbiCIYA==
X-OriginatorOrg: xilinx.com
Cc: bitbake-devel@lists.openembedded.org,
	OE-core <openembedded-core@lists.openembedded.org>
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
X-List-Received-Date: Tue, 08 Jan 2019 20:13:18 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

On 1/5/2019 7:09 PM, Joshua Watt wrote:
> On Sat, Jan 5, 2019 at 1:50 AM Alejandro Hernandez
> <alejandro.enedino.hernandez-samaniego@xilinx.com> wrote:
>> Hey Joshua,
>>
>> This is breaking multiconfig builds with the following error (trimmed),
>> I believe it is not taking into account that the Key could contain
>> "mc:..." if it is a multiconfig build.
> Hmm, yes that seems likely. I'll take a look, would you mind opening a
> bug in Bugzilla and assigning it to me? I'm not very familiar with
> multiconfig, so some instructions to help reproduce would be very
> helpful.
Sure thing
>
> Does anyone know if mutliconfig is tested on the autobuilders?

Nope, it is not tested yet, I've been meaning to add a buildset that 
tests it but I haven't found the time tbh

Cheers,

Alejandro


>
>>
>> ERROR: Running idle function
>>    File "poky/bitbake/lib/bb/runqueue.py", line 1170, in
>> RunQueueData.prepare_task_hash(tid='multiconfig:x86:poky/meta/recipes-support/attr/acl_2.2.52.bb:do_fetch'):
>>                self.runtaskentries[tid].hash =
>> bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
>>       >        self.runtaskentries[tid].unihash =
>> bb.parse.siggen.get_unihash(fn + "." + taskname)
>>
>>     File "poky/bitbake/lib/bb/siggen.py", line 45, in
>> SignatureGeneratorOEBasicHash.get_unihash(task='poky/meta/recipes-support/attr/acl_2.2.52.bb.do_fetch'):
>>            def get_unihash(self, task):
>>       >        return self.taskhash[task]
>>
>> KeyError: 'poky/meta/recipes-support/attr/acl_2.2.52.bb.do_fetch'
>>
>>
>> Cheers,
>>
>> Alejandro
>>
>>
>> On 12/18/2018 7:10 PM, Joshua Watt wrote:
>>> Requests the task unique hash from siggen and tracks it
>>>
>>> [YOCTO #13030]
>>>
>>> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>>> ---
>>>    bitbake/lib/bb/runqueue.py | 25 +++++++++++++++++--------
>>>    1 file changed, 17 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>>> index f2b95a9829b..27b188256dd 100644
>>> --- a/bitbake/lib/bb/runqueue.py
>>> +++ b/bitbake/lib/bb/runqueue.py
>>> @@ -346,6 +346,7 @@ class RunTaskEntry(object):
>>>            self.depends = set()
>>>            self.revdeps = set()
>>>            self.hash = None
>>> +        self.unihash = None
>>>            self.task = None
>>>            self.weight = 1
>>>
>>> @@ -385,6 +386,9 @@ class RunQueueData:
>>>        def get_task_hash(self, tid):
>>>            return self.runtaskentries[tid].hash
>>>
>>> +    def get_task_unihash(self, tid):
>>> +        return self.runtaskentries[tid].unihash
>>> +
>>>        def get_user_idstring(self, tid, task_name_suffix = ""):
>>>            return tid + task_name_suffix
>>>
>>> @@ -1150,18 +1154,21 @@ class RunQueueData:
>>>                    if len(self.runtaskentries[tid].depends - dealtwith) == 0:
>>>                        dealtwith.add(tid)
>>>                        todeal.remove(tid)
>>> -                    procdep = []
>>> -                    for dep in self.runtaskentries[tid].depends:
>>> -                        procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
>>> -                    (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>>> -                    self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
>>> -                    task = self.runtaskentries[tid].task
>>> +                    self.prepare_task_hash(tid)
>>>
>>>            bb.parse.siggen.writeout_file_checksum_cache()
>>>
>>>            #self.dump_data()
>>>            return len(self.runtaskentries)
>>>
>>> +    def prepare_task_hash(self, tid):
>>> +        procdep = []
>>> +        for dep in self.runtaskentries[tid].depends:
>>> +            procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
>>> +        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>>> +        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
>>> +        self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(fn + "." + taskname)
>>> +
>>>        def dump_data(self):
>>>            """
>>>            Dump some debug information on the internal data structures
>>> @@ -2081,7 +2088,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
>>>                    deps = self.rqdata.runtaskentries[revdep].depends
>>>                    provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
>>>                    taskhash = self.rqdata.runtaskentries[revdep].hash
>>> -                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
>>> +                unihash = self.rqdata.runtaskentries[revdep].unihash
>>> +                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
>>>                    for revdep2 in deps:
>>>                        if revdep2 not in taskdepdata:
>>>                            additional.append(revdep2)
>>> @@ -2524,7 +2532,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
>>>                    deps = getsetscenedeps(revdep)
>>>                    provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
>>>                    taskhash = self.rqdata.runtaskentries[revdep].hash
>>> -                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
>>> +                unihash = self.rqdata.runtaskentries[revdep].unihash
>>> +                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
>>>                    for revdep2 in deps:
>>>                        if revdep2 not in taskdepdata:
>>>                            additional.append(revdep2)

