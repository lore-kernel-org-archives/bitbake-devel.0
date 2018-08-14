Return-Path: <Rasmus.Villemoes@prevas.se>
X-Greylist: delayed 7206 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 14 Aug 2018 13:09:24 UTC
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr50097.outbound.protection.outlook.com [40.107.5.97])
	by mail.openembedded.org (Postfix) with ESMTP id BE01E79007
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 13:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=prevasonline.onmicrosoft.com; s=selector1-prevas-se;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=EvQfWq7hJ94ENUeiOFt9yCJcV3BwFCL8hXqFxnr14JI=;
	b=TA1MSchxvEO/rYGg1Ng9BzNSDEROD2t+o0wwSHInR+v5MPvsjQ3rxYnVS5aV3qwX4zYTOYZ3fDWwQUS1MzO/ZEfl2xhPptoYB8PB/4+T7y+LkGsLtqeOYcfYbxOEL+0NbJfX7dqcAcDHH+PUExIj/5WYO9jlhhtL4qfZJGc70po=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
Received: from [172.16.11.40] (81.216.59.226) by
	HE1PR1001MB1340.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f5::23) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1017.19; Tue, 14 Aug 2018 08:34:02 +0000
To: bitbake-devel@lists.openembedded.org
References: <20180813180226.18299-1-ross.burton@intel.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <49400e02-454a-42c6-e11c-0d72f9e191ab@prevas.dk>
Date: Tue, 14 Aug 2018 10:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813180226.18299-1-ross.burton@intel.com>
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: CWLP265CA0154.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:52::22) To HE1PR1001MB1340.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:3:f5::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6ed2f06-0254-4e87-b8bc-08d601c0b08a
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:HE1PR1001MB1340; 
X-Microsoft-Exchange-Diagnostics: 1; HE1PR1001MB1340;
	3:izXwYFC1dAooDbJJ7HO48C+sy53tVV4FVbdvbFXryp9P5NCKepJ/CW3oR+kT5+Fpmh+txXfqxXFTzEfIk+IjsNWikjRKZVI3cipx3HDieYGpC16qa6PPJC38wbbq4v1C7tp72AQWHRnKaxNXiDaUjzjLSC0aK9PHlRI+34moa4v+ZNLYxJVGwghhlBtXShg64Z4/Q8L2eqqxcC2Ws9q4DAQVT+EaoBDyxObVxfHzhn/fJUR+1uq99CpNifO1cJ+E;
	25:RGsyhppyrY6w0rnfFgh2qvz5WaDYwTftGH91It8SyUW/vlb41s6DRXmY9pXQpk2WbV2ZY/wa0AcduId6+Vs9/WWo/ik7zMUzl30/oF8TmNw71qFbv8T+9wMCTOshIEQWNq8ltRIpmJt8VcyE48vhLR2ED2AYMdr+iPM08FWQYNviU7/AkHIFJlrrYwd40LcIA7Ae/hxFvae1Et3oOJNU1qseOKp1QOIi1RDppAtgGqB11HgXyYHzaavJ8341TWf6yZhAQ9rQEGWDpgaw+Ubzlb15RG9CazP+9fESJLwl1TMV1M/4oxjIsot+lL2qUeOE25cEq9/sWM+MGn/4wZcOyw==;
	31:Jg0UoezDRYUUKg1yTDhbDRwgYk2aKDdMt9yA9kUe/+fk3+TG1DIj2Mi1rj2WNJITMEn+8MjOpsSt+I33tp4q2/ZIncSVnL1VzXnev/Qw8R8i80gmG1yN9F6UUQkEymKyr/hSm9zWMAqW3+ti7pzykI0bhEAYCVZlmgPueJRb4UnA3y/OTA4fEeLHlPXG0hFJNZMdsGY6b/z6OPYZfyQ84GZi2ru56t2oIyjjVor86j8=
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1340:
X-Microsoft-Antispam-PRVS: <HE1PR1001MB1340BB64611F4DB58F8ECACA8A380@HE1PR1001MB1340.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(264703809997249);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);
	SRVR:HE1PR1001MB1340; BCL:0; PCL:0; RULEID:;
	SRVR:HE1PR1001MB1340; 
X-Microsoft-Exchange-Diagnostics: 1; HE1PR1001MB1340;
	4:92BlilOEHwNXnu5OZ1+EFz9h/uM29yxj4yuCb4BXcqc/j+zR7E46z/E9aDe4tbAuWNQRsNxq++MAuGG9N/+9h/vkP+KNRePwVAu7AqyJXYImIJdLLGHBoGfc06Ck+3o76C9+3klnQWgDyZ6vESPG7K6eiK7DWFraSm+n1cOzZY2hvGJCsYACMFD1lbkbNrPMiA8ofIlniv6fSbLKEH8xk8QOgzjaugVY4h3Zg+9+EBHC4vj1gv5rIKsnAnuiAl9bUZ8VJiw5LvoYYdYzpSV5Xcdhr9eVwKesHavldeWSGNPTfNVmCLoqJy5Z8NKiRoB1
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(6049001)(366004)(396003)(39850400004)(136003)(376002)(346002)(189003)(199004)(65826007)(186003)(6916009)(5660300001)(4326008)(66066001)(386003)(53546011)(65956001)(2351001)(44832011)(76176011)(64126003)(6666003)(53936002)(2616005)(956004)(8976002)(26005)(68736007)(2361001)(65806001)(47776003)(16526019)(6246003)(77096007)(97736004)(25786009)(6486002)(8676002)(305945005)(11346002)(966005)(6116002)(74482002)(478600001)(36756003)(42882007)(81166006)(446003)(3846002)(2906002)(72206003)(230700001)(31696002)(31686004)(486006)(50466002)(81156014)(476003)(229853002)(52146003)(105586002)(58126008)(2486003)(106356001)(8936002)(52116002)(316002)(7736002)(16576012)(6306002)(23676004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR1001MB1340; H:[172.16.11.40];
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: prevas.se does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjEwMDFNQjEzNDA7MjM6eTJxTXExMXRjQ3hlQ3JhTlU0Zjh1Qkx0?=
	=?utf-8?B?UDk4MERUaEpWTE45UDk0WWJqWk9VMUdXNjJsa05Yc2N2RVVkRlN5RUZwUU4z?=
	=?utf-8?B?TlNXeVpqeEhtUzc2SjNSeGphSU5PRGRPMTk0YnZaUzJWUVNES1pVVmRjNUkz?=
	=?utf-8?B?czlsOXhvZHp3WEhlcVV4Z1N6YXRwZTRtVjJSL3BHdi8vbm5ZbXlNNEI2ditv?=
	=?utf-8?B?K0ZjZlp4dzZENG9rZGdmSUkzK21qQWszRXkzUUlRWmdWSkFpSHN0b3kvSDdO?=
	=?utf-8?B?YUZXeXdUR0pCREhWMkJRU3JHY3VkWENIMzBKTjkwTzlkYWtFRXUvNlh5WFds?=
	=?utf-8?B?QzRnTTRJZ1RPUW5GWFhuM0xWeXV0TkdBQjN5RHZNMndsa2dlc0hCWlloOXlP?=
	=?utf-8?B?UWVhRlZxUG5SL3ZGNWYyekw5MUIwWjFlaWV4QUZuZEFvemYyRHZISUdOeUt3?=
	=?utf-8?B?TktZYVJPZE9DcmVYTVNSTzRaTmNFOFZsLzE5dFFPajJabk1PSDlNTGQ5bHhi?=
	=?utf-8?B?NXRXRUM2ejV5bHpKaWc0SW05cERYWVhLKy9zZkNTdmM1U2VNYzd4YlVJRUFn?=
	=?utf-8?B?VFR5N3c0UGl0WFZjb2R2TzJIbXRzNWtOTGZvd0xRbTFDa0pqOHJVeXlDdnQ3?=
	=?utf-8?B?NFFEdnlaaCtJbm9hajloWXhNMm1wc2FHOEdtL2k2cHBjY2VnendYdHJMeHRD?=
	=?utf-8?B?bEkwRW5lbURQT3I1a1VoZmdYY05VSTNpL3dJNzA4UXd0a1JFam0rNUxEOVNP?=
	=?utf-8?B?RlE0eThRSFBPaloyc2drQjJEZ2ZGSmxGRnYwVS9qeS9hNHRQamxvT1hQNHBS?=
	=?utf-8?B?N3hWU2JiT3pHWUJJK0J4TDJXaVlycmpKK2dzdWpTTTNOWGE2QW00R0FMdUdC?=
	=?utf-8?B?NHN3UWZ4ZUYxRXRVM2FKTzhDZ2U4L1BENW1EdTg2L1JZYk1MVFR3V1d2UTN4?=
	=?utf-8?B?aG1CRk5xd09hemw2NVVmUDROeEt3RzEvbmt2OTNINjZobS9QWWZjZE01RFhh?=
	=?utf-8?B?Y2tqL1RKTUpnc1lHVkVrWjMrVC9BQ2FVRkZ2alN5ZXJ4MUptVHJlNGtlUnJx?=
	=?utf-8?B?bk10RTlMWnd1T1Jrc1p0cDUzS1lwbXcxcm5KUUN0MmR4c0o1cWdSTEFDa2Jt?=
	=?utf-8?B?OFFaTXpYY3BVQlI2UGRSS1lvZ0VRVXN3STc1WFB2cUNXaXZuUWd0a2lUdXhq?=
	=?utf-8?B?MzB4cTNHSzdrZklwcm5ITHlST3NBdkhJdGh5NkhHZnFLa0RRbTlQRDJpRkt1?=
	=?utf-8?B?NDh5bC8wNlVPRnhBemlrbUxJcCtRNkFDRnQ0ak53ZHRIWlJBT281SlRabGV5?=
	=?utf-8?B?eTVXa1VkY0RoK0pSWm9wVkFjaXRTaVlZT1lqT3QzQ1RWckJJeVJUcU5OdjVP?=
	=?utf-8?B?R29iNUVmSjlXNzlLeG9udlZ4WUkxTTlucTk5V2JUZXZjRGtqRnQ0dnBpKzkw?=
	=?utf-8?B?L1NQMFFON2JDSWhCMFVIYjQydUJvL1lES1hsSjhaUUpaVjkzenBZS1k1NFly?=
	=?utf-8?B?cVZNNndoZTFUZC9ZbE40RFZTRzVFQ2xlQUkwVEpZYzdnb3NnNkNDQU02R2xk?=
	=?utf-8?B?RE1HcnRIL0VlRnR6eHBWWVNBRGtYNWlrN2hFUGVzc0lEN3Z3KzZOU2poay82?=
	=?utf-8?B?b3NaMzVYdmduZHNFbHBacGRBZ3Q5eVFyaVUyWFBxMHkxQTJoemRjaTVGMThr?=
	=?utf-8?B?VkNQV2dlNlFEYzNSY2VFYVhOK2ZFcHNsR0cwNlJlRElxYWdmbHpId0YrR0dD?=
	=?utf-8?B?UzNEQlhpQXRBV21GaERIVEN5ZlpENWdSN2tEZnZ4Z3RrV05RUjlCeVlSdmpt?=
	=?utf-8?B?Um9JYTZXTFdCUXlEWEF0dEVKeFZRd1FDYzNSN2p6cGx2ZmF2WmNrclFZNy8r?=
	=?utf-8?B?RTN4VTBGdGtCdlZEWlFQYjZWakltWjl6aWZ4b2h5aHZ3M1RRaStUU1dWaU96?=
	=?utf-8?B?SEVuVVN4RFh4Q3dpdm5EUFJDSVBrVzFIVGlKQTN2Z2xNYk9USy8rNFovQm56?=
	=?utf-8?B?UThQdDFkaTRHSnJ2bTJQZWt1T3RwRnpCdmJ4NWtzT1lmSC8rcHYrZkZpRkVm?=
	=?utf-8?B?TUFKcHJ0elZ4ZFB1NHJ2bHJBdGZCdDNPdXhzTUFGZkRmdDN5WmloSUVoVXZx?=
	=?utf-8?B?V3IwZz09?=
X-Microsoft-Antispam-Message-Info: Mk++6CCtHxBi0pxQnxFWt4uFtTZK8PuccH3TUlHbDCIPf+bkaCJ04PXSI3mWf6MJW9jeCn2uo4Cxdph94L/8fiSlQzUV0MTYev1ZjwVv4jAEn30X0s+o3TnFhP0C0CAcQB1MPBeqjgLI/mMUdz7dIIByFx7aGZaRsJ4FNm1bLvOfqO7ISdo/1fV6O9DIPAL1A4tjqZEXYgs3dkc4AuQ4FSVqYp7xc1vXps7YDC9yz3YYLn48PvCsFy4UDIhUfnoURExtugYh4Ph7DSTYyJ9tusNoHNveRc9yi9kQzAg3VVOQnf+//jhszzRYwZzmnNdBu8bwVeK1cYzANC2RquLq6bHH3aqL3uUKv9CcLOt31cE=
X-Microsoft-Exchange-Diagnostics: 1; HE1PR1001MB1340;
	6:U8i6qXZx757P1pdqmxPJsxfMLgv0UQB7Uv0DVYLfazVABtfTtpZ1BuXiZyWMuedJZz8hmb1mHq02GHw4YWwNUiOyn2d2+Qo/qkfzPibV3Z94JaGmgfp5Qe7uLdAPozl1GMSwbZqiTI9eSzqh2h13w9Dmtc8AKhgzPKOB5O3oYE8HJ7v0BNGeXxOWCxr47WzwVm32wcwXIoIEm6uvtsklAya3oinOKXG4WGsa/ZVIVdzOmWt58m3Xocz69FwzojItyOtorVIkJ7C2v4NoyrHL5HQhJ3vBDJHvR5B+wno8SfqC6nvF9claUbHkOpsm15QJuxwtgXeD96TUnct3PMix89TVfOyvxSqyugHHADBzT2SYBUixLavZkjFYNtLn8wpYI/r4Ma6sKvq7YOXyEovMjVsOA942E+pD2RP6mjb78V0Jl/L/SZtgrH2juFTO1Qy84Ft+N1rVpPVVsuptPwE2uQ==;
	5:f3M7G35i4flmCAVM4IQOJx38OavJJQfKfZwgUOOPNN21mGAwsievltJv2XDu0DkAbWbGPpGYVYKz96GKU+XceshYqhjTpcOgU11KrTMgWVFCuKfXvSiLh5b+5UYb7+0LcvyfRRYuBYmXY84cM9mtWg0+/PhouGqeKIRcL+5J2Hg=;
	7:5Q+huLTLaun3kDulAyE6zFD4J/TrWO7CoE7z9eJWuftDkBnFWLfQKzIZFcfzalU23DABvnzcYGHzQsIz2K5RN4nz0fGNChE52ohTujW1ex+smGEEJWOcjouv7U+gGU33P6/HNvEjQSIoDv1dYUGnyloQabfFUsqhceKevi80fjW68zPo91Guwa8Q27iqhIO9P1V8XlDk2Hq+UUwnnyZRcN9dc+Nhl7AL+mObSNg8CCNb0TIYdwqBJdKhcxfHxBCx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 08:34:02.2410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ed2f06-0254-4e87-b8bc-08d601c0b08a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1340
Subject: Re: [PATCH 1/2] utils/md5_file: don't iterate line-by-line
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
X-List-Received-Date: Tue, 14 Aug 2018 13:09:25 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2018-08-13 20:02, Ross Burton wrote:
> Opening a file in binary mode and iterating it seems like the simple solution
> but will still break on newlines, which for binary files isn't really useful as
> the size of the chunks could be huge or tiny.

And what exactly was wrong with

http://lists.openembedded.org/pipermail/bitbake-devel/2018-July/009407.html
http://lists.openembedded.org/pipermail/bitbake-devel/2018-July/009409.html

? I have lots of patches and ideas for performance improvements in
bitbake, pseudo and other components, but I'm not getting any response
at all, which is rather frustrating.

Rasmus

