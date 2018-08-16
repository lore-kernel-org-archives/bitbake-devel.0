Return-Path: <Rasmus.Villemoes@prevas.se>
X-Greylist: delayed 1126 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 16 Aug 2018 09:14:10 UTC
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr20099.outbound.protection.outlook.com [40.107.2.99])
	by mail.openembedded.org (Postfix) with ESMTP id 697E479297
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Aug 2018 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=prevasonline.onmicrosoft.com; s=selector1-prevas-se;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ROd/5iGyMhB91K5xNl7onABJXNxC0TdYZDVCijUGXG8=;
	b=UJVBMUqG75r9lvQBK4QSNfG/MDTPkJTu2WLZoFrAiWLo3gHz922GYb2paCFUUlMbYi/Dji6wa8soXCswKIjGFzcYvQ4JmOely3QgZeRQHAj74JBbtsJiZcOidsXqmAkslqCt+6vnVSQUvnOPw4XrBXhijDMbRClqHx6p08qZzi8=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
Received: from [192.168.0.189] (5.186.120.115) by
	AM4PR1001MB1329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:98::19) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.22;
	Thu, 16 Aug 2018 08:40:33 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: bitbake-devel@lists.openembedded.org
References: <08a61d76-d0b7-ce93-180c-5c4eab3ee150@prevas.dk>
Message-ID: <1fd3956c-d7c9-445a-b8ad-6770998801d3@prevas.dk>
Date: Thu, 16 Aug 2018 10:40:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <08a61d76-d0b7-ce93-180c-5c4eab3ee150@prevas.dk>
X-Originating-IP: [5.186.120.115]
X-ClientProxiedBy: AM0PR0402CA0002.eurprd04.prod.outlook.com
	(2603:10a6:208:15::15) To AM4PR1001MB1329.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:200:98::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ce0f577-5cc1-45d4-b07e-08d60353ee4b
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM4PR1001MB1329; 
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1329;
	3:qenC7v5VJB3Z/ZzOAZZKG+SMyajobJOkjY6piLV+CxObZdzgxMlxv4fQd0qGAmBUQb++ZJIzhj1fIok/6mAfHI4D+7ykzVTihgRyeTmwUEaxB1NWO93bNEQhCRQgd1PCkPBdOMQ1GWuBfEM8LvH1LMGr2kttBKqCSjbZhlfJYTiwU8yf/Z2P3QDDcAzAtz9XAKnCZQbnb7+fJ0oqpUbX9ppwExF6EfDUVPQ0WeAKIuxASiduklsdllE1pHiXmJdv;
	25:9dwuKdE6q30mJlZZTfOrzIfmmqgMMz44u+2bh3OUe6TyH4AblK4c6VyuSiAyz7LgBdsDQbA+MC33gzbsROgReRGiqmHYk32PDWrCV/7WRu89Jg87On3c6ZIPV5p+e5CiXu0lvreMA30l0wpyY+TlJ3sTW5mQq6D3ygkvr89Xis5DYEX4gYipAGJXh887ytVqODJrlhPLdlcwuieVlUl1UFeN0faabgpTGjzo7wmoCIH/Mh8iOYHfgHsAfNyeeK38G4BZZCZbhOdZ/VKK4y+zqOLUT5LvkBwxNwL+YjrP5InEAOVTNut/fqtYdhgfX7C4V3+MCvxkentX8tDdQPIybg==;
	31:idbvOG7jRo1fQmwI5+WnV0sRP48u3Qpe4YXw+3KmqSKHCn/I3MUicQAA9UOkH6XvdVlopPmPjgxhBKT5whkwbobmy9uQFOi1HeatJzCo3HsSNfcbj+GXuYv/lJAD6ZU+IF9ORqVtOgbG3Ms3uETm5nhF3F35Sg+bX1/UyvU3GxqK+8H1AGOynpdjl97KP3/PNACUSlZW2CkUpKB0Tm4bn1rxiVdc3HdisR1MCLl+128=
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1329:
X-Microsoft-Antispam-PRVS: <AM4PR1001MB1329C15383DADF74E8C74ECB8A3E0@AM4PR1001MB1329.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);
	SRVR:AM4PR1001MB1329; BCL:0; PCL:0; RULEID:;
	SRVR:AM4PR1001MB1329; 
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1329;
	4:cFTabm0QoTEwTNAG5PFZDX2ljDuXuUpCqSrcuiI9SA4lIltotqNbvyP2RAfIgB70u9avriNNmr4y+Btc8pMR1thNRxmv+rNze2AIG9h/ufCBkI7lVyjb5/t14cp+mzoRqUozKmE1vTqh9xXzJtxnPIb4s9nV6WkosozkBcvZU0JuVgI+AFGAaRe8ZSHRLeNR29odTHG+JZjO4th6oUiyMuRZi3nPvHq4If18UOyaknPe9kwD6NnHB8PTF6XE7SAww2ghi8zL5/AQvf6xodcRCw==
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(979002)(6049001)(366004)(136003)(396003)(376002)(346002)(39850400004)(189003)(199004)(47776003)(50466002)(81156014)(53936002)(31696002)(6916009)(64126003)(31686004)(97736004)(6246003)(8676002)(8976002)(105586002)(478600001)(72206003)(2361001)(68736007)(106356001)(52146003)(23676004)(2486003)(25786009)(71446004)(76176011)(52116002)(8936002)(81166006)(66066001)(65806001)(65956001)(229853002)(36756003)(74482002)(65826007)(2906002)(6116002)(4326008)(117156002)(5660300001)(3846002)(305945005)(53546011)(6486002)(7736002)(446003)(77096007)(16526019)(26005)(14444005)(58126008)(476003)(44832011)(11346002)(230700001)(386003)(486006)(2616005)(42882007)(186003)(956004)(316002)(2351001)(16576012)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM4PR1001MB1329;
	H:[192.168.0.189]; FPR:; SPF:None; LANG:en; PTR:InfoNoRecords;
	MX:1; A:1; 
Received-SPF: None (protection.outlook.com: prevas.se does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjEwMDFNQjEzMjk7MjM6Mk9qeE9SVmFyZHBWRFpzN1dTeE5yOTl3?=
	=?utf-8?B?cFk0b0FPeVpVZjQzRjAyNDU4WnkwZGZhb0xkQ3lkbStFMlZmODRSQnRiUER5?=
	=?utf-8?B?aGZUSFI1bUloSlIrNVNKZmJ6WW15SDBxOTlKSlJ3akljaUE4elpZNU9Ddm0v?=
	=?utf-8?B?NTRJUXdJRnJ6bFE5K1AwZEVUTElycTcwc3c4d0xVcXhxLzhTamM3cG5hTVJu?=
	=?utf-8?B?Q2xqUnlibXNNN1hacjhRUlJ6TXQwSE5EZktEdTYvUDZHY0Q2cUY3YmVJWEhL?=
	=?utf-8?B?VEI4RC9PRDF6MmpnZGZJYzRhL1I2bGpVVnh4SWtEdkljR3BqQVRBSzRoOGVr?=
	=?utf-8?B?aGx5d1lVQ3VqNndMNXpMWWcza0xmYTJMSkdaMi82amNxRWs2aEc4RnQrbVVn?=
	=?utf-8?B?T3A0aVViaGNDUk9mRlpPYzdhd3BEa0FWQkQ1UGM0UWxpdU9FTUhmQ3lWUTEx?=
	=?utf-8?B?d2h6M2ltYWVkQWVrWmlWaDVra2pvWjNLRWFlWXg3NWg2Q0tvN0oxQmtXVW9T?=
	=?utf-8?B?VEM3S1dNMWFYRlIzRU54bFlPL0tYVmVueGxIb1VHTlhQSWorY0YzZFExSzVI?=
	=?utf-8?B?VThVUWpOYkQrS3NPbURPYUE4c1gwNDFMSDBqaVZRRzY4Nk8zeHc0eDZzYTdw?=
	=?utf-8?B?OG82T3AxaGcreC9IZHJLNU05N3Z3bHB3RXZnRVo2elVVajVkQ0xXejdDWWla?=
	=?utf-8?B?WU1NVmhyYXhrOXRwZUdTVkVsTm8rZjA2VnlhRnptYURQU1lHMFhLekM0am9s?=
	=?utf-8?B?R0RSdm9ndHY4dDU5bEl6M3VVUHQzK0Y2bWgwdm5HVGhyTlJvd2sweUF2NzRG?=
	=?utf-8?B?ZjE4U3RGV2JkUUMyTnJvbEY3dXBJLzBjZFBvaDhQMWp5VU5YZVM0THNQRzhp?=
	=?utf-8?B?L0tHMkVwRHVLZXhseVBMYmdZWnBkaktaaWpNUkhJQzE3MVQ1eEFOYjE3aG9k?=
	=?utf-8?B?NEI4a3pCUFdHd1k1aWJBZzhZMHBISk5pOGRLUDg2QVhqT3E3bjJaUThKYjdD?=
	=?utf-8?B?M0xZWmFQU2U0WkZJajc2NlY3OUcvbnl5OTNreG5ycHFXSG1xdHRhd0NGTmQ3?=
	=?utf-8?B?dzJ4c1k4eUNCanVXSU9HZXlGd05YeWdHZUZ1SFQrMkY2cUdwVkRuR2Y5ZmFF?=
	=?utf-8?B?WHFIc1FrejlzeXg5akNRTXNKR3R0V2VZMUFpLzBLYnhLM2c3VDJTREQveW95?=
	=?utf-8?B?NkRRaU5EV3NPVWN0b2hyUENlS0cwRC84ZGV6TzJicml2bTFxVjdjYWhYT1ZN?=
	=?utf-8?B?MExXWE9OcmFMQjZjNGRuTExHLytGT2VlcGxTb0NkOGtrUzRIOE01QVJNdzRB?=
	=?utf-8?B?UzRDTUh4TTQzVDIxMVBaOWNoWFIvVFZBdWJiT3NDNmFCVzJFSk9DemtURmxX?=
	=?utf-8?B?ZGxzcXROaUM1L21WS1JJbDRqVE9lK0s3NTY5NkYxa1g1MGVrTldRazF2UUN0?=
	=?utf-8?B?ZG1IYW9BcDV5cTBYS1NwQ3dNR0lNajRwNXhmbGMzalJZTUM0b0VydEQ4dkpP?=
	=?utf-8?B?K0x6b1hkNDNNTEdxSFFlcTl2emdFT0ZHaUJrb2kram5UOFN5czQ0L3JmT1FT?=
	=?utf-8?B?UnNEd3ljd2ZhWTB0b3RoK1ZzTHZhcXgzSU1mSFhLUWNWdk9JMXZwdmVsU3Yz?=
	=?utf-8?B?eTZnVk9aUjRwajJlRFM0Q0pCWEtzakpIU0F5bGQ3ajZHVnptU0V1YmFCZzNy?=
	=?utf-8?B?UnRVVVJGb1htR2d4TDZpSnZocVZJcEVLN0JCRjZIMDk2US80c1ZCcFlCQlJV?=
	=?utf-8?B?UURpa041eVIzcm10WDFUdHM3RE9XeVdSb1dJQ3I1OVVSQXRpTDFWd3hQelRk?=
	=?utf-8?B?bFV0Wjk0Y3hkZnlEMDFNSlJNNnNMS0hIYVhLTUs1ZVgxNlVMTk1sdVcvMThK?=
	=?utf-8?B?dmRPM0RWQzJCbWgzemtDdjE3VWkxVFl3dzV3cjFRd1ZWL0tUTGVzbE84Qlo2?=
	=?utf-8?B?WXc1R2k2NVJYS2VUWnJxZWhzQnlzcFZBZnJLc0VxTVg1blAvQlBZdGF2VUVi?=
	=?utf-8?B?SkhNNnZYOWw1ZlBsTXJsdWlJK3BTQ05DL2wyM2dJaHkvbVc0S016QWdmeUc0?=
	=?utf-8?B?cnRtTU1mckNscEt4RkVyd3VNbHF0LzRyZ2FFVC9IVk9jVUNOYjFOWGFzYzdR?=
	=?utf-8?B?cVJMM3E2L3RPbWNYNjBZdXFFYlZVc1JtVWVSb3NWcWtiSEk3TmpySG1haFNP?=
	=?utf-8?B?THFwdE5TMExNbmMzN2R0KzZjM0J0bCtienZhaW02YjZQRE9rU25sbklZb1Ny?=
	=?utf-8?Q?AMTVzb6BbWcpdoQC3lUK?=
X-Microsoft-Antispam-Message-Info: /sY35iLR3GT1JTS7CmEPtT1KtZo34gosQZLfgx5FFrSjVMvqTmx4XG+risAPJAhX75sKSa4nQMLePRIOXo9fIjTM6L1vdqSbIn7iRbiUTjWVBiPw8ta8uIwp92instTznguf/ZFTxa5GeTM5KIuuXZEqN3mfR+nRZ5RvcEvATGm+t3E0OCepkOya/+M+Q+GWaCUJHLy8HAPF70vzpRQ1PakrXN/MgswRX7tz2Qm3/G2bPIIhsAO9zOki+riWROUOVc4CNC28UXs9+WyEKnojDKOjJsh+FFKMTjSX9nLeurcDW0gYrnJfpKFX00iDwxYOnXc1hFaQr9J6KKN8z6lLlklCvbEOZWNbNkZO8yiMpU4=
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1329;
	6:F0vmIJZDJyfmubqdT/pJFrvl/+OufkAwMUIi6L+PrBTX2LzqLS7DmFRVU1txyzrFsQtmSRa13wRhKYUb91Ue1ndjHcXtKUjOKxAjNlJ4skiaAP+kNRGTnfzj6LuCgcvJIaKKjRxwAje93J5CN74Hu+9FZ5sUQbSCps8x56OaZrHWuKiF3XPZjVSYq5Ofi0PbpbDmBYm/SX6iA596rEkPrd9dasY5VojNzFIg1OG3fZYbMeXOZcQchCMyyqKHIWS24TuNmtNbx3Px1SKKBjvkz7nEI5N2AFgqgoBRxmk+w5+i68bRb3dfFtC60AYCdHmzp6rayqJYcF7cJDfycHuf3XsnzWOQ2Y5ZRHEj+hmV0IuqZDLgJDNmy85/7dEzNuVRRS5KGa+AlAqhH8FXqqofM0/nrnOCuleeTYvhtT7Nmdg3JA+3MYVhJiWHUWEX1KixbDwIKwCpOeDJ8asEqkjAhA==;
	5:3CRvOtB3zNOwdVnvjrNfeEVPtTpJVI+YC4w08uN5l+Vo8HUyEJdu1UGtv/4qhwoNdHCexjfC2WnxuMB+rhP/WDMYDol78s3CFLFJLEJVl3X9Q4fUa6FTvC9Bk47v5SNf0b2L9gKI7SnyK7Uy9sj/iQ5O6/O7KTpD/vJsnh0Z9qc=;
	7:flvo5aA0BIGLoIXtWT2BRZEf2GJnMutM9qj0sQg81qV0Q2DDwT5l8JsPtptlY8dUQTbDWCxUrgFFjf/vK3MBLmNP1LxlCxM0SKErl030OQFU4eQrucYzwc37MlECsUiMPRAafGujPsf1T/UyaEoek3HmrKZ9UvmxaApwXPeczuCAeEsRH2WQNCiXxVUC1LpYAyeVlVRXteOaSFhhXa8t1mTbG3Yb87+u5+t87g82D4tkEWMqrk8n7+A9nnhO1m6y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 08:40:33.3360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce0f577-5cc1-45d4-b07e-08d60353ee4b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1329
Subject: Re: commit 6c3281a14 / set_context broken?
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
X-List-Received-Date: Thu, 16 Aug 2018 09:14:11 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2018-07-10 11:31, Rasmus Villemoes wrote:
> AFAICT, set_context in lib/bb/utils.py doesn't actually set the
> module-global _context variable, but just assigns to function-local
> variable by the same name. Hence it is effectively a no-op.
> 
> The python fix would be to add a "global _context" declaration, but
> since things have apparently worked for 5 years, perhaps one can simply
> delete set_context and remove the calls?

Ping.

