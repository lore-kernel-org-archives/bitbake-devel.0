Return-Path: <Rasmus.Villemoes@prevas.se>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr20099.outbound.protection.outlook.com [40.107.2.99])
	by mail.openembedded.org (Postfix) with ESMTP id 57DAF745F4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Aug 2018 02:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=prevasonline.onmicrosoft.com; s=selector1-prevas-se;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=rxULKeMiJzNiXNUyjEPI+6f0eSpZfJ6b75rgd/8iAoc=;
	b=shAb3+Mg5mZnSv2/xgmJGd7KlqgqEhgWvyLeWmt9zKmhnge3nt+0eE31WPvr6f8fRQlDDO3Q/cQ4ln7He82ukjBlI6YQyEepG2uXGm2KCV97qklII4zGxoeqk9rbW+L6gf4ws1SzXaRnx/YtrOeuDMCO5RifrgYcWtj08Q3cGUE=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
Received: from [192.168.0.189] (5.186.120.115) by
	VI1PR1001MB1342.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:e5::11) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.24;
	Thu, 16 Aug 2018 08:57:44 +0000
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
References: <20180710120334.9609-1-rasmus.villemoes@prevas.dk>
	<52a52d2a-3f64-812b-2582-2808abaa78b5@prevas.dk>
	<62b7406a8c5edf06dccdc39acf2a5c5741e5d09e.camel@linuxfoundation.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <b2fac879-03f3-03f6-4746-382f319ae37b@prevas.dk>
Date: Thu, 16 Aug 2018 10:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <62b7406a8c5edf06dccdc39acf2a5c5741e5d09e.camel@linuxfoundation.org>
X-Originating-IP: [5.186.120.115]
X-ClientProxiedBy: VI1P195CA0084.EURP195.PROD.OUTLOOK.COM
	(2603:10a6:802:59::37) To VI1PR1001MB1342.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:800:e5::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d63578d-38db-4fef-3c30-08d6035654f6
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:VI1PR1001MB1342; 
X-Microsoft-Exchange-Diagnostics: 1; VI1PR1001MB1342;
	3:xgJry+HnAEowwGMIhjX0tFOK4M1swff4UorYLcZntcOGbn/mkCxxc7fGb6JxRuWCko09YLBtHSzzycdU1e044MEoTB/t5AZ9n10RqwC4KyJbImuOVnO7cAbmSInekBgbGRUZcZ/Oq8rGqfQfomABf6QSlS/ouTMdhf/lSou/GnQj4bc87IRytYNxaLPEVEUKNfj3vQvv6Q7wb/l6W1Qc2CwR15BH1ZOeWvrmqTMAAE2AV3PyD27ubXIm4ftRGpwV;
	25:BtMi+O94vXZHjFcYT/GKdRBFKQLY/vyzkS5AUp8JsiE2WFoGZeovlsbk/qH2vQ/vGgQszdZMlMUhZL6FsOegahltMtaAxa6N10A+zv6pJntCewUpGobUhFNNaE0HNe09TCBiPutH4ys8LQVnNgiAXcgc/OULXxS5/0PQSsmCzw3tC8tW5M9sO555fpTok4FkGIZcggcw7FAK06cxp7q9CC/Vqzvgj9LnaIoeNwO/0UoWgFWgpvn+B6BB4474HcMXyXn0IfQzKv53QAfL0htc+ug/WeL3EVkD55B2fLD5H/9TIxfkbnqsKwNsXK3n0sZkp0L8HJsrduw2ERtPjGA8Lw==;
	31:RLngjpjRxvvs5YB3CVf6mhaAvagYtPg5UD2GWsYg6bTDnW2YZ8Gc9h4CQjx1l1CrRIKGWhN5ALgWFU5zuBMobaSAjE8ufalg4QenwZEljl4pC4rQMDIuOH/uCbXavDTab+8ErQRUC/gZrMYjQ8k2dn2wZk2USEYhccTdb6ympZxwm3d2e0J+fbVyfa0YMgExAMLS6Vuy3ag6AliHo5IxV8FBKvcLTnnDvG3Gm5kTenQ=
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1342:
X-Microsoft-Antispam-PRVS: <VI1PR1001MB134276997475764A1F906FC58A3E0@VI1PR1001MB1342.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699016);
	SRVR:VI1PR1001MB1342; BCL:0; PCL:0; RULEID:;
	SRVR:VI1PR1001MB1342; 
X-Microsoft-Exchange-Diagnostics: 1; VI1PR1001MB1342;
	4:xFj0hpidv8USRsga9nPp9O/P4pM8AFg4Vo8/sHAAB/dvdOgvjBjrdThg5JnNAGf2qlVUnkv8RErLjW7Mgo4IEDEPBVK8Rnvb3V3EWPY558kxtBurAuEMGOmIIGrdILr4csCWs20vnuVD4zaBCPuvQYccH1kKXpZYGdcpEoyGBd/MPUx3RFXvWcHZPl1qkK0aTubnnyBPRU6l0q12jgmD049QEwo9pt+ujO7Cva+jzqtQc/vxuJ7nBTDVGZ2DMdUjGnCVisns/q4pnQ5r4oUy/Q==
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(6049001)(136003)(376002)(396003)(366004)(346002)(39850400004)(189003)(199004)(7736002)(31686004)(74482002)(77096007)(68736007)(16526019)(65956001)(66066001)(47776003)(305945005)(65806001)(6486002)(478600001)(36756003)(476003)(486006)(44832011)(386003)(105586002)(53546011)(956004)(81166006)(81156014)(8676002)(42882007)(446003)(2616005)(11346002)(26005)(106356001)(186003)(6246003)(52116002)(23676004)(2486003)(64126003)(53936002)(52146003)(72206003)(71446004)(117156002)(58126008)(97736004)(8976002)(50466002)(76176011)(25786009)(316002)(16576012)(2906002)(229853002)(3846002)(230700001)(31696002)(5660300001)(6666003)(65826007)(6116002)(8936002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR1001MB1342;
	H:[192.168.0.189]; FPR:; SPF:None; LANG:en; PTR:InfoNoRecords;
	MX:1; A:1; 
Received-SPF: None (protection.outlook.com: prevas.se does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjEwMDFNQjEzNDI7MjM6WTh1MlJ4aXAwVnZFQUtnQnhrNUlGRW1I?=
	=?utf-8?B?eUgzSkZlemE5dmowZVF3SDlUUVYxT1EyUk1TVkxXSGlvZ3FxMlVzOFpFNEFH?=
	=?utf-8?B?VGc1dDZ1bXRpTGN2ZFpwQUJhTWJpTzNIU1VpS3Mxb2VTREgwS29vRGx1TDFY?=
	=?utf-8?B?SlBobDNxV1djREp3UW55VHVjWEFuMmtwVFJVaDlmVzhxL3lBSGtIQ2E1TmRU?=
	=?utf-8?B?cGttT3Bjd0liUGI1blN2VHc1UVlPN0s5anVET0tTeTBYQ2p3bFROdnNacCtp?=
	=?utf-8?B?Q29pc3N6M3ZDa21tdml6ZCtUaUF1cGQ0WDNsUjZZS1hNNEtXNy9rMzQ3SlhX?=
	=?utf-8?B?aCtZQXhWSDA4cmhkWXpNSDMwek9zdmU1cnlibXBMR2dXbFVNazdQQ0hyZWdn?=
	=?utf-8?B?V3pJWmY1Q0lPbndORk0vU3BEMHdna0NjT0xoc0dWQmFEV3RTNVo0bXNYZU1Y?=
	=?utf-8?B?bEpyc2xWUkwvTnM4VmxWRW1lajIwQ3ZwVmhGK2hMM1VQVFg2RkQrd1J3dC9Z?=
	=?utf-8?B?UHhjTHRST1loaExVRVhvKzhlR09sbVpKcnVlRFptaHNFOVlGYzI4YlZqcXhr?=
	=?utf-8?B?Q2Q1ZjNoT3lMN3Qwb1hDMFo0Y04zVXJ4QURLUTJuS3czaVBYalc2SC9sSWIx?=
	=?utf-8?B?NWpCL1lPQXFLSmp3MzhrTmlOdFhIbExQeXYySjJxYlVBVXFCMEpEWnBoUVUw?=
	=?utf-8?B?L0hsekRXOGJ4UzhobmlQLzFJSHdDWlVaZWZKRkxHSGxqNkRSeGtlc05zMjRu?=
	=?utf-8?B?S1gvOUpKL3NONWFMUkV1TS9aL2h0aFBaUC9sRUpDRTEwaEFjb1prWmREbG1D?=
	=?utf-8?B?cjZtK3dGa0VkZ3dmc2VUczJFWFRBWlFVVmo1L0k2aVIrUjFOTjEzUU51OWxL?=
	=?utf-8?B?MERkcnJTcEtZNitpM0plL3NZSDBJellwOVVlaDdFWko0TXJ0d05kOFh1TGZR?=
	=?utf-8?B?U2JUN1RjMXJPUHFUazRNQ2FqOFRzeXpId0pKZEZwV21HMTg1SjJ4TUgyVFRt?=
	=?utf-8?B?aWxYZkY5ZllsU3BtcVRuTmhSRFpDdXl0OVpNTU9vQ2FCcm9kTnBVQVh0ZnFT?=
	=?utf-8?B?VmFnQ05GSHhGTks0WUg2VTVyZkVkazZkT0N5YXBNSnFIajY2aWluRDFDVGhU?=
	=?utf-8?B?WTJBb0VDVkVHZ3VFUXZlbStYcjlCQWVldUpiSEoySmpuVFlqNHFuQmpWaTNq?=
	=?utf-8?B?WFM1cW5Jakl1aFZ6Nzk0UFN2OUh3Z2xGRFRiTlNoSjRmUVJJYUFSU2RKSWhB?=
	=?utf-8?B?MlJSVWVwTCtDQXk2amNTQXJOdmp5N2tjWlBzQmU5WkNQZDN2aDV6bEU0UDRR?=
	=?utf-8?B?YW1ybUY1dzRYd0ZjcXpGdDZDM0tubG9seDFEajZXVE5SczRqbW0wYUpYcXBI?=
	=?utf-8?B?dElIOVJsNk9lWFZRLzI2UWhJMkRRTG1GZloyQW1IQ0Rkem1XanVoaTNpanBz?=
	=?utf-8?B?Unk1VlRXUFo0dS9Tby9NR3Fwc252SFFsT0dtWXBsaHJOY2N1Qm5QQUhxSGpI?=
	=?utf-8?B?VWNKWk5kdW5hQUgwT1hHL3hvUWRpQnVvaHB2dVZWK0NJVG9pTmREdkdxNW9s?=
	=?utf-8?B?dnlsZGQ4Y1M0ZjJhWTJQSEN4TERDU0x0NDhMNkdZQUtna0tEeVpHVWFPUjZv?=
	=?utf-8?B?VmJSeUtSb3NqY1BsWVRLZGFTbnd1Zm5rRkE0TVhpNUNNSjByb2lweTY2c24v?=
	=?utf-8?B?clBFMjJ0NXhkZitUSFdYTDVGUlM0ZHVOTzJGVUNsT05rWGNWcVNPWDdLVmN0?=
	=?utf-8?B?ekVkVlA3WTVFZEgzay96ZmJwSmxaSkhhTTJiNmJMQ0pWU3pIUk5EbmhPV29P?=
	=?utf-8?B?b2dGUktqMFV0akJyRURNbGNsWk1wTWJYU1NDZ3Q4cUZha3ZHSVBsOFJoZDUv?=
	=?utf-8?B?OGhJY2ozc0ZkSGhrQnJFQVFvOU5lbGF5QW5ybDVZZ2FPQmo2cmRoTzFpVlhl?=
	=?utf-8?B?UkZwWXJiU2NLTkZ3dkxEcXdSY0p1bDArampCKzlWeEZoOFcyeXhxZkYzVTV1?=
	=?utf-8?B?U1VSLzFOTmtUZEozSStHR2JRL200VzRVeis4V3RnPT0=?=
X-Microsoft-Antispam-Message-Info: NHkXL8K+4awjWx0XAOJ5Q/HHdg7p6y2Rqoo9flRQIHSOrVl4wqH8eGFpp8pDTvPtNXZ0cFrdcJCyiZLOXrFRx7RnzY/eVBO/IYbGNpYn02hIWx2KoKbzrDFK8JXg3OaT/ZVLFpOTcDe1Qa7tAJJglnPWliwRWSlHtZdiH0novdxXqZpQp5+i6Lq7VGyMHxOr7TjtzwedGJrpTkXdl7/uMYP1LBvJ1jJseNdOmeuvmUPs+HyoiqvilujA0zVE4jDKSb2VDI6dC5WRBaUEG9SOrEreZYkOnagYVqvrF3Nh3BZiJ+mYefY2w3z/s/vJfrjVHEscSp+PXDPN9Cjx8DIYHl3cHnVDVAxAkOFNeTDHBWg=
X-Microsoft-Exchange-Diagnostics: 1; VI1PR1001MB1342;
	6:/5LbVGNl7nf1lP8NMJHdzn6ukWmq8YoUXslXErqT3EiqbSbSN7OalQZklrkQCQJxklALA1xtgnDEqfvOFsWpW7a+Ob0+PNj4EqRknhJiJ2uHYSSpiTCIP02HKfPB1P3JrOvIR2re4SU1+sutpU1it0fA+SQCYuG0fcj5kWe2wTwf9q+Ansn7dL2CtCelQwRhtXscDFxy8AUoDRwDVX9tgkhX49NWHGP4HKOEAUgVFtVlkszjT9oZTvyShkmJm0bhOOALJyV7oODYihDCcrAUH1cICQLsnO+xMsVIxIK+sx85oVk4Hxz9FfoXCRNvYcxTMQBP+Q1ubUK8hyQslBgNcq8uG8ytH8mXkjIpOmaGyYctl9lSAekpGZfNu03kAaiM4aEKDtJF/RoqKb2woYKgSVD7EuCBiRgupx4XIDtj2GiYZKnlGn926NzUkCb440/RmzEOroWUU+4M2riaTTct2Q==;
	5:uwk2DVQYd1a4ZrL/DGd5tgu6K0hiIa2GedKLVxPEPI3fIcP3i8RM5OkerJXpOm6Z5Vh5ZqdT0ntBWGZH7vrHyEgNb03Y0gdG3ak1IUFiTixUgW9IFDgPcbHumDhm5id7TqiT6a/fnVbwvbfV5dhqHcRopmszw6jB5hhcveqOQcU=;
	7:rcbXto9SYWdXe8gYN2b31LvRC7VzuGiNbrGAIGceEERwjWtuOHnV5H4fYAbRA6sjaz6qHbUshEpS8yOCbeZWLqNttJC71VcCeHl2bgPusEGOS2V1FmBxsrt5Xa596oF2aS6IfPFKVvhXtSa6JPeP9UY6iM+N0GKsFXPdoENltXaZKhb++anFh9kO8Cj+iB8QnR+gAbap5I1I9ZrQ/hXmJ8GYyYiONsKLijJ2O2o12Jp+ZUcawEn2pzyvdzXs5NeL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 08:57:44.5666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d63578d-38db-4fef-3c30-08d6035654f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1342
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
X-List-Received-Date: Fri, 17 Aug 2018 02:30:46 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2018-08-16 10:52, richard.purdie@linuxfoundation.org wrote:
> On Thu, 2018-08-16 at 10:38 +0200, Rasmus Villemoes wrote:
>> On 2018-07-10 14:03, Rasmus Villemoes wrote:
> 
> Merged, sorry about the delay. Was there a corresponding OE-Core patch?

No, I didn't think I could send such patches before this landed in
bitbake (since any automated test would just flag those as breaking
everything). What's the normal/proper way to handle such dependencies?
On my end, I've just been running with the patches applied to the
combined repo.

> Also, for new API like this we might want to consider adding some tests
> to bitbake-selftest...

I'll look into that.

Rasmus

