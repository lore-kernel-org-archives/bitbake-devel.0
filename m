Return-Path: <Rasmus.Villemoes@prevas.se>
X-Greylist: delayed 172114 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 16 Aug 2018 08:38:26 UTC
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
	(mail-he1eur01on0131.outbound.protection.outlook.com [104.47.0.131])
	by mail.openembedded.org (Postfix) with ESMTP id 238BD79260
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Aug 2018 08:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=prevasonline.onmicrosoft.com; s=selector1-prevas-se;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=AFtA3yS0CtIf9RhSbpYzyKkBNr4Ukbhxl/8E3lZtiBk=;
	b=nThd7myJ+ga0FIxQReJwqtiosKn3KB7cohu9gc5/U8EIgaYiBBa0xiq8SUPzIBbQ9rpy6la/8izW8ZHi4dCM2q3a+Po9lVvlHPmxE+thDMKwbNV8+VbqtpxCVxYgKoqG+DmOvzS5u+wJ5UqjHVS9SG/X9KyXkCp8yjMDmK88if8=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
Received: from [192.168.0.189] (5.186.120.115) by
	DB6PR1001MB1333.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b4::20) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1038.20; Thu, 16 Aug 2018 08:38:26 +0000
To: bitbake-devel@lists.openembedded.org
References: <20180710120334.9609-1-rasmus.villemoes@prevas.dk>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <52a52d2a-3f64-812b-2582-2808abaa78b5@prevas.dk>
Date: Thu, 16 Aug 2018 10:38:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180710120334.9609-1-rasmus.villemoes@prevas.dk>
X-Originating-IP: [5.186.120.115]
X-ClientProxiedBy: AM0PR0402CA0020.eurprd04.prod.outlook.com
	(2603:10a6:208:15::33) To DB6PR1001MB1333.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:4:b4::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a287229-0c7c-4c26-09fb-08d60353a281
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:DB6PR1001MB1333; 
X-Microsoft-Exchange-Diagnostics: 1; DB6PR1001MB1333;
	3:4xqPGNspwfcikL/m9p0yru03rCEYUAzL6Q2YtgU8YYRT55Rt9Z3Khb6Y2esSncwatMKwEo0hkPvu6IVZFHbFwZBNRdNojdhq6hLUGjj142W5CpKQr+ygJJcyFGbvJuqJC8lmNwqsPpNS0qrjXj8HjBEN4LSWm5b/6vPvIxZ51UkUCsYA9vhZKdCH59tEuie5Z0cYnacbz/5ps3FHGXYyywavbVrKOlNd27hgAeGJG41tW8BTlB/c08W51KpF4AOx;
	25:CL1186E2NVszgjLWcT0KHXRDv0CVuN/rJ/E+JTFfvk0IIsiGGF4QNIDRnJt+KDIoxRXYK7OsQmMUuIJaheD5g2z/P0tYkExPGhxJJT6WmjVpXcs14qS40DqZCPZGmkI9UN1C3cnBI108EDZsJLBXfP4raQ445B+RQrIBweqXgz8yIqTALmlQ+302NhW+poYUgAmyeCL34dh5sBfpKb5NEmbybGj/U53weDlwjALA8mPIJ9ylzOq7NSQjPJGlLcGJN0yE8JTrOlMpyTpoOCGfLX0W3nZccZKIbGAGv1LL1LKR6tJ3PoutM3IByv8RpXwOU6M9lpKmM70Rx1MoFB1hxA==;
	31:OXsGtY7D2V30XtrclQ4VQ8IZNsW4Bvpc16BM0BZPGBpCnpxtzZuExoLN0wc+N07WaVZmDXcoYFTgWDsSGGW9Xkiz7dG2F3YIehcGchTN+zavCeJaDUkHpEfdFnPDW0//o69DeeGUSUUBO8jyy9wze43NXBD4YRll1+37yE5rnKvAUkma2f2LTKJ3mgMh5Su9sIpFRBIA460QAvU7iV+RNDssY/xatfY3tqCphn0w/HI=
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1333:
X-Microsoft-Antispam-PRVS: <DB6PR1001MB133316C6021D5608050EE7AC8A3E0@DB6PR1001MB1333.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);
	SRVR:DB6PR1001MB1333; BCL:0; PCL:0; RULEID:;
	SRVR:DB6PR1001MB1333; 
X-Microsoft-Exchange-Diagnostics: 1; DB6PR1001MB1333;
	4:CgSZvsdnyX6noC9xoiciRa/KmHyPk21A28FV3atTfe7czA2duTzU7zeYxVa4K5TXFERZ6QRBzj4QDX9Ri43PZTk/brHquM2c1DRqZnY/zqHiiEmT2CfyXNtKtN2g6HxrvfEQCwQN8EH1N7kksEjqSikWYp1xs8KrHBI/XlGXAjgTRIo8EN4fVw8kKI2P2iw3S7oHAKbJ6JjEoW0BmKcx/X3DAHS8S9y2zoubByoAiw4zNFnwuzsA845kNd+arNQ//tDK4AW8syQ6IIU4INHt5A==
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(6049001)(376002)(396003)(346002)(39850400004)(136003)(366004)(189003)(199004)(229853002)(117156002)(64126003)(478600001)(11346002)(58126008)(446003)(16576012)(6486002)(316002)(386003)(26005)(6116002)(105586002)(25786009)(3846002)(2351001)(230700001)(2906002)(77096007)(97736004)(16526019)(53546011)(72206003)(74482002)(956004)(8676002)(186003)(476003)(305945005)(486006)(76176011)(81166006)(6246003)(106356001)(6916009)(65956001)(66066001)(2616005)(81156014)(44832011)(71446004)(14444005)(7736002)(36756003)(53936002)(31696002)(42882007)(50466002)(2361001)(8976002)(6666003)(68736007)(2486003)(5660300001)(52116002)(4326008)(31686004)(23676004)(52146003)(65826007)(8936002)(47776003)(65806001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR1001MB1333;
	H:[192.168.0.189]; FPR:; SPF:None; LANG:en; PTR:InfoNoRecords;
	MX:1; A:1; 
Received-SPF: None (protection.outlook.com: prevas.se does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjEwMDFNQjEzMzM7MjM6RHk4b3dzWU1qaUpzQi9lcWxqRzE1QTF3?=
	=?utf-8?B?bEpXME1JazhRcmRSU3VKVUhjWXlZMjJJbGJBaWMxWnRIQTVEUkZIRW11TFFm?=
	=?utf-8?B?TE04cDFVbTJFNGphWmRZSllRdHVzL0ZpK2hrWStpRm4zUFFpQXhmSm94c1g1?=
	=?utf-8?B?VGxOM3p0TVBlczcxbmI2VWM2WWc2U2laTnl4bnNRNEhXeG5JSGZCeXl5eWJq?=
	=?utf-8?B?d1d5N1VjaDBoTkpMYVNOcXVLZXFWMnMzQzY3OHQwellkMG9mZTd4VHloTnZQ?=
	=?utf-8?B?WHB0NC9QN1BMOXhMbEY3OUVGSDh1eGZ1bmsxdW1TS2IyMmlxbCtoT3VrUlFF?=
	=?utf-8?B?eHJoSnRLbStwd09FNFlRMFZGMHBrZU9UeWx0cnBYaTViQnRKRHNMV3JjMlVr?=
	=?utf-8?B?L2lnQ2FJOEt3ZEtlc3ZTY0xoTnFMUnJ3TTJldlpNMERieUJ0RGF4VFpHOHZN?=
	=?utf-8?B?QWIyZkh0Yk94QWRuckxxaXcvbVV3eTBsWEk0cTNuNjZKS010ZzFOVXV5QVVz?=
	=?utf-8?B?WVVJVzlobUk1TFA1WkFZMkRZSE05WTYyMDZHYXFsaXMvOFlJMHh0dEhiUVMw?=
	=?utf-8?B?dTQ4alpIVmZKQlFiTXBzV0xMYU5DemNYcHMyRDhhbjNaYXRoQnlQcUI1QzZt?=
	=?utf-8?B?TlQ1d0l1bkxIRDdzSXBrQTFSMkZIWFpJYThPK1g0RkFZNUc4V0duc1RTSTFD?=
	=?utf-8?B?eWpHVFFkd0dsNmlRUGVDRmNJaDFXWVF5MHpmSzg2ZlQ2azdSQVV0anV5ZExX?=
	=?utf-8?B?UTl4OG84VGhBT21NWExKVnJTbXJDUmI3SGx1aWJ3S09qTDRWUktzRHJiMEdW?=
	=?utf-8?B?ZUVQVFJMa08ydW8zaFcySS9xUnlQMkxaNGJqaXE3MXpWWkZQc1lHZVJaYWtL?=
	=?utf-8?B?N1I0d0R4eGZYVitDdCsyZEN3NWpoTGRFY2tHbjlEZDJoRDB4UWtxekVqdTc5?=
	=?utf-8?B?VlM5ZUp3N0gzNzEwMHB0bWRldDZzZUs1MGRLSGNNenBsMFVYeDBmSVIweUIr?=
	=?utf-8?B?YU52ajYrUDUzTkNQNVByZzV0aTF6bmRSckxrZjFjazJITXFMMDRYNGZpV0Rx?=
	=?utf-8?B?Z1gxQmQ5aEFBS1BWcnE4cC9RZkFPVVRIQitkR1BnQVFmVkdLbUs4Y3VGNXM1?=
	=?utf-8?B?SkkzbHcyei8zWUF0V2dXZ0o0Rzl4dDh5eUF0N2ZRWDkydng4Q1YwcWxtdkNX?=
	=?utf-8?B?Qll4bGNtSVV3WEhJMjI1NTg3YXN4MnJzdE1mVkc0bHZYUUp0ZVJIZmRYTG5T?=
	=?utf-8?B?OG9xd0ZiakRUdGZJVXBqWG82WDBsTlBFU3RwdEhXM2pHRWFMNWQ1NWNzc0hr?=
	=?utf-8?B?Y2U3NGd3Q084VlVCVU9JWElZdGJQUVpYRCs4bTZNRW1mWXUxUGdWUU40cmZS?=
	=?utf-8?B?YXgwY01JNnJaa1l5S2pTZWw1a3FXem1KOWR5OUp6ZE1KSldSNUQxT0RsaUlY?=
	=?utf-8?B?dk4wNEYxRFBGWXJpM2hEME5zOFhDOVMwcHNOVjZyeGF3d0hvT2p0WFN3UGls?=
	=?utf-8?B?MEh3R014aS81N0tEb2E4ekt3aEFDRGtkU2lHS3NSY2VHR3NNL2hhVlRsbUtM?=
	=?utf-8?B?Y2VaQW4wbkhkNWROS2M3eGlxUVhPQS84ZTFyeXhKZXFqWGkwcUJQU281UzJT?=
	=?utf-8?B?ZVV6OE9NblpRMWJKb3phNTlsaTdERmhKSDVBeU5rVm1mWDdZU0tHdEg1RmFp?=
	=?utf-8?B?NXhzMGpwcHpRTkFXd3I2cnl4UHZCUG5WOXU5MENob1VqWUthcnY3bWpkcVRR?=
	=?utf-8?B?Z2tJcktiSDVkQ0syZHVWM0MrREloRUgxeGlzcEpmbXk2b2JWRXZUZXU1enk4?=
	=?utf-8?B?SU5uM1dLTXpUYTVyanVMZVBza0ZQTkxXUlpzUzBxeUxzVVEyd3dCUlVjbEt2?=
	=?utf-8?B?UWFETVhiMk5SaC9tVWdNMVAvL2NMSC94dElSZ0dnRDh4cnhqV3Zncjl0WlRV?=
	=?utf-8?B?Mi8zWVQ0MFQ2Yml5QzR3blRaL3BYMXBnZ05sS3ZreWdLTk00bGNLRHdMaVI2?=
	=?utf-8?B?eW10bUFOT1B3bVhBY2ZjMWJySU53TFR0Ym5LeU5DRnNhN1lpVENVa3VmMnp1?=
	=?utf-8?B?eWcxNTFkeDcwVEVqemVYZnhmR3pEZk80RUdabURyZFZEZjZjbVh1Q1BCYlBU?=
	=?utf-8?Q?ETaktzCKQlH4seZVwtWYS8txYjJheXYpEuYo/22wxpC1M3?=
X-Microsoft-Antispam-Message-Info: Bpg/Zal4DsDk8Y2lGHXawIRU11zLOZmGmzm34VCRaQ86nDwMKJoLhs2yfZ2nPXvaj6A4/ocDuQijijF4L1nEocuT92zWi6Nx+JTthEvlwHkjIsBiv0Vud0GrlEe+krNyeV5EaLJIQgupiEjWeKqWXIRNYbkmZ5gt26fH/cTy0TpVB3tC1z9XRaM7lD4tbPtC42jynrW9WiTSKjMkByoD7EW60mcmn0XC3HIH7CQMmN/ERQxjaXKXWoD7a74UkqpbRcR68Mf99SIorVSQBVpr8Vqc3u68eVNEynmUVDLSDGbVSJ3Vum9JGUAzRRSpRV6N9WkH2MLmDE+yzxRt9vutps8LfcnFYfS1lAi8vd8c7Tk=
X-Microsoft-Exchange-Diagnostics: 1; DB6PR1001MB1333;
	6:shhgnKKMnzlp4K4n6i+Tnc9w3BbPuZlj7KPvz5Z5aV5kaE5i7T4UF26eqSw0BRk1mBrj6OAFR4ZVbnAnYYgddoOs5mW/Pd8KvTNyFuoTc7wSNjg0Rqdq5lju2n2YZGe2bJlAPHBrwh0LAl7wcthR/VuapT3MsEQQr1bPvX3tNJMVROrKD1NvnZhN499J6A7DMxJc/x6GHCRBOn5tAN4yxDGio0czk01H3LRKQxw9u9UT/vrICDFBt63Sy+GmsVMoLDQIlvw1MF8FQXIay335J+uwFu/bikWnNG4DsvpbULxrk/bDWazkSx+awTBcTWITVhUcrYVAUW0GDHjynbgucqhAWVrXa1oceS4mSongFTzoKjth/93XXsFzGO2ycxUuJc7mUisMoWye65xW8O3gGw5++WC6T9AGhQYTqotNtzJmvGLEOkpc/7VblKFb57Ea7Bwuupr6bIFTCqEuY62Mog==;
	5:DMrQpNSXIoTYmwmYkpMM/CucHt/ad6ROT+vUcCxKejCJ8u59QxSCBkpYAwCJ03rpH7asLXHcw0BbxSsXbPrRdncne7yBVPBdvXiMWOVrX4wfpeoGbOBuHmpjIWi8TNClZRL3lEWajOXlFBIiGmbRIpTsEEKXfy+tjpexyajEiYQ=;
	7:AwA7fijluLkhGPbWFNcLr2fUcq6ODF0wBA3rn0ehmu/XPE+YLsgB5P5QzVtoMfL89xkhSBEue1lwmoyC2yRqso7xzYIHm8NP+jHFO0TdQa1uThWokC8Ij5nHxMjcMDHJ8rEKnWp6N2/6GtjHx9PfE4mSBvX7anN5yY8TYs8eMsRP3+OB8XbvIYLfndZOLPTSXJaK7TpnLGoUU0seq1wpis3Z0Ym9DTGEQEhPCCqhDaqxsVXDIC7tqnjWft8uNdw4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 08:38:26.0746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a287229-0c7c-4c26-09fb-08d60353a281
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1333
Subject: Re: [PATCH] bb/utils.py: add break_hardlinks helper
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
X-List-Received-Date: Thu, 16 Aug 2018 08:38:27 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2018-07-10 14:03, Rasmus Villemoes wrote:
> bb.utils.copyfile is called in a few places with identical src and dst
> in order to create an st_nlinks==1 version of the file. That that even
> works relies on an implementation detail of copyfile (namely, that it
> creates a temporary file and then does a rename). Moreover, it's a waste
> of time if the file already has st_nlinks==1.
> 
> So create a helper that optimizes away the copy in the st_nlinks==1
> case. Of course, this helper relies on the same implementation detail,
> but that's now contained within bb.utils itself.
> 
> To test that we do at least sometimes hit the no-copy path, I tested
> locally with
> 
>      if sstat[stat.ST_NLINK] == 1:
> +        bb.note("Woohoo, 2*%d bytes I/O avoided" % sstat[stat.ST_SIZE])
>          return True
> 
> (and the obvious places in oe-core patched), and the do_package log files
> are indeed filled with woohoo notes.

Ping.

