Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web12.2160.1630460743874848484
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Aug 2021 18:45:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=p1PV/0rP;
 spf=pass (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=48786bfbe4=mingli.yu@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1811PL0K010474
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Aug 2021 18:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=uIPAE96KqIlox7XXU1wfZaK7LfXaGrYfVmGI8PQ6jRQ=;
 b=p1PV/0rP3rR/j9nKaYj/GKDEzQF56K4nVhAqjcFqVwwMZULu4OYJYEl0zet+aivyy9re
 SnJmRO30G6wmGPjGLlnGldjFFz+74ob8YqcWpwUKLSefSkQ/6TmfmkqFC/xKeuxIKhrt
 g9MMCg9aFKzkbRAtuj7qdJpF1pGSsGgz/UD4hc1V0ExIs1F5n1vyaop4tHTKcvy43tgO
 kYVzgeMJj61lP4aW9hH7oaEsuIyqsxQiZdBoQerzkwURX+7SW+YQfCG38YkhO+qtarOO
 krgdVkRxNqwD9mc48M9lj3LgvUS8E6dtDqB8IHbUDqHC2GwmP029rM8e2I4vXh6PW7Zq sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com with ESMTP id 3asbdjrsms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Aug 2021 18:45:42 -0700
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1811jfoX010038
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Aug 2021 18:45:41 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
	by mx0a-0064b401.pphosted.com with ESMTP id 3asbdjrsmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Aug 2021 18:45:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWdmz7okdrb3EdSwpt2t84yzeAgKk8JoiYzsP7QVJx3CIP96HibioTs6xj5hV5IkdRSbR6ML6NBPhcoLe9dTcKsOvc9/f1bT4u6WYg3mvaSU/GqNZNgbEOvoO9GrFyBzQvvfkulTZ0/kewfBKFeqyEqpHARiX13oScNHCKN50LMpb5H6FXWyePM1DLR9CcGqAMLdO5PdjXjyshc0HJPvxlOZ9J05khAASzSzNWozAFpuWLz4z1gORQWjCKO7/a0Nk5phqw6VrfqFGxM2wrcu1cbAjflyOqtsn8vOT8xDqQZfJG1b3ID5JSH/TXfXkPZ+/qYGZCq3ROmeJBpgO8/1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIPAE96KqIlox7XXU1wfZaK7LfXaGrYfVmGI8PQ6jRQ=;
 b=DImOFdpynwqNQaE0DhrtssN6hFIkdnnIm2Qs7W5VZOAAFVX0WRuLoU4aM8QuZMoyTNmrlx8+7ow8Z5XcwKB5Idu/YR3FsaW8RnQOI2NxtOfhHI7/Ufd6IMd9iRGNjstYDT0Ts3DXrphlFd+IrLZUbwKkNWNfLnbUqWmWFBRRjapScrzerpfPgBjynULtZfjo5LNbMNmRRX5M2rNHsBJtnuCpyg8sMMne7ahkHQr1CMBvNreEWH2onaBs0jkfnTaYu0QqNz/qTIxyPMR+jaisCCAeOQnt/i1GwzaXDym+pXHHLZiHLhy50qeQz4z1XcaD4h00mUi714RdDm+U39cQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5014.namprd11.prod.outlook.com (2603:10b6:510:31::17)
 by PH0PR11MB4806.namprd11.prod.outlook.com (2603:10b6:510:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 01:45:38 +0000
Received: from PH0PR11MB5014.namprd11.prod.outlook.com
 ([fe80::dd24:d36a:f979:58e8]) by PH0PR11MB5014.namprd11.prod.outlook.com
 ([fe80::dd24:d36a:f979:58e8%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 01:45:37 +0000
Subject: Re: [bitbake-devel] [PATCH] prserv: make localhost work
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Scott Murray <scott.murray@konsulko.com>,
        bitbake-devel <bitbake-devel@lists.openembedded.org>,
        Martin Jansa <Martin.Jansa@gmail.com>
References: <16A04D855643B3E7.30479@lists.openembedded.org>
 <20210831074807.5972-1-mingli.yu@windriver.com>
 <f3b29ae8-7582-4b3b-abaf-8e1eb08bf54@spiteful.org>
 <d3e95bfb-593d-0fd8-bcb8-65af9537f5ea@windriver.com>
 <CAJdd5GaViYYCa6XovSO7n6ceSjBemn28bhN7TjSaCQgXkYpmuw@mail.gmail.com>
From: "Yu, Mingli" <mingli.yu@windriver.com>
Message-ID: <af883af8-192c-0550-76ea-ee5190ba54c1@windriver.com>
Date: Wed, 1 Sep 2021 09:51:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAJdd5GaViYYCa6XovSO7n6ceSjBemn28bhN7TjSaCQgXkYpmuw@mail.gmail.com>
X-ClientProxiedBy: HK2PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:202:17::27) To PH0PR11MB5014.namprd11.prod.outlook.com
 (2603:10b6:510:31::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.173] (60.247.85.82) by HK2PR03CA0057.apcprd03.prod.outlook.com (2603:1096:202:17::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.11 via Frontend Transport; Wed, 1 Sep 2021 01:45:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e333e26c-573c-451e-08ab-08d96cea327e
X-MS-TrafficTypeDiagnostic: PH0PR11MB4806:
X-Microsoft-Antispam-PRVS: 
	<PH0PR11MB480690CD2EDACD84D7E5C042F1CD9@PH0PR11MB4806.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c68slV+A1rpubEJPzYPxXxyGqY7wdbmMt3wpo6uNyeZzUjGteoC6W0aCjCoOdu2JKggzPA35Lmo24nXVVy51IsucV3jlxH6AtaneNecvBTQuFoUTevMNSA7V6t9zmfgnCeH2+rcuULLbefKujQPaYnMpSzM9ocSD7UQWP0Ha3uW8x4C5Fuc6L0Oo+dcac64GTWsMn7AcaPlsM1d2+j6obhMxGMacClZwn1QpnDfPcsP6UOlpAV9cbcGmaLeJ8YC7in0Xc4Fh3X1CoQ/oE3TRNFCgv/UzWBORSwh5fSm9Em7bbWTt5wNO7kJN77kPLD4GaUEd35EcE5rkWzIOrdwrPki9Hy0pWbRavWL3T/krfX87PfrVXpFtEBlNki3k00k5UsEnz25vRhveJTvyhYd1KfPzMgrCo2FszyfXsDe2UsKLyILgarNbwHG2xHByM6z6BfxPYw0DLsnD5wU+qMY+Ur8Dt2Th5J5AmdtfOk0W64lKRHnhFDA2Azp2Ua97qsyJ8A4xTE2vrT2+IUGmottnsOIhZVJZGe50ADFSj2wK5mzr6w62916EVU6bimW6QBcPXu+hVKxG62bGRMoA5owD/wqs+Frt3X2isHWeFg+H4Hqn+Ipoxy47kNk6hu5IHjGd6RLwifZf+01xEkt3I8JBQm05JVSFAanRxMsRD0/aET4zETOwcFhHvZNHo4TUmkjyv8P2/qeycKr8ePDol1PdGelBepH3MgiX7pWfkOpm+uXrvOMZ4q9YrgVd2ZdkAbxR/AAMpcGaT/WY3MWS0bBd9FCcE1HVt9TF8A8PO4QciUqBD3zm0riCh63zh+uJwDKjjzmg09HjbfKru6PKOrvBTI63gXC8+xbfILA7SB/mhCaPaF0PsJaMJ0ZkB2Tjv1eRoJWeIp2ENgOdwqPSLogvmFqzHZ/sAGy1aa+NTpQKr3U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5014.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(38100700002)(956004)(2616005)(26005)(966005)(508600001)(53546011)(38350700002)(6486002)(31686004)(8676002)(36756003)(31696002)(8936002)(6666004)(66476007)(83380400001)(4326008)(6916009)(66946007)(66556008)(6706004)(52116002)(54906003)(186003)(86362001)(16576012)(5660300002)(2906002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWVFK0V0c0s2emxxSmhjOUVHNjJ5TkNoRnd1NHhlaDZtM1c3Zkdxa2VTMHMr?=
 =?utf-8?B?ZTBwSkw0cThwWVlsNTlnRzFWMHBmYjdwQjlycmV1QXI1RlQwNnpFMUxlVGZs?=
 =?utf-8?B?ZUZOZ2RpTnNiZDVCQ3k3N3o5TE9rYmhQM1hhZ1M3T1VKTzJ6cTJTQ3h6MVkx?=
 =?utf-8?B?d3hyQmJBNUViM3B2aitkOThNV0FNcG9CbzJSQlB1Zk9LaGdwZEllRmhVY1BH?=
 =?utf-8?B?OWJHWUNsNDIwRVBNemhMdTlMNXIrYmpXOEdPck8xUlVpWDdqQzlnL2FyVWJ3?=
 =?utf-8?B?VTZXbTMrdldURjhQZkJGbzFBZkcwOFREVGNHMUppOVRUbkNGR1FwWThUSVU4?=
 =?utf-8?B?ZjBUMEk5VmZ3R25TUGV4S0xSWVFTQXYyc25yYm1aOEdDTjA5Ty8yZGxFMnk2?=
 =?utf-8?B?bis1MHdnajRRUlcrSXNWMDlnMWxLQjF3UjVwME9LaUtXZ3hmYzhDZUNrMHhI?=
 =?utf-8?B?a2RnQkdUYkpsRmQvbm1heCsrZkhMYVBWdHdxcVV0RW4rNEZzRi85VzR4Tzlm?=
 =?utf-8?B?ODc4KytwWkZzYlRsb0JBNUM5Tmd1REhzV1hWdFVYa29rM3Fma093RjMxa1lv?=
 =?utf-8?B?L1RHaDZHdGw5RG5WR25ZMVhqZTloem5ZVzE2VFpYcFhFbDRNNDQ1YU5xUDY3?=
 =?utf-8?B?YStMbHFHRkhTTDJmNkhES05vQWpKb2tlcGdZbXBEWmJGM0dVWG12cDNhRjA1?=
 =?utf-8?B?c0I5a21HWkdIelBEZ0IrZ2l2UG0wa0VWRnE0OSt4VThEckQ1dSswYnhWQ0g4?=
 =?utf-8?B?MEhtL2F0a2FGbVJvRnBXVmhkVTB4Q0NKUmFxcWhoZklEam1ZN2FBdHhwOVlu?=
 =?utf-8?B?MG91U2YvVXpHTFNOeG1mWXlId01HeTJxTmpydTJ6VlJoOVp0bTE0dkxpN1Jy?=
 =?utf-8?B?cS9qWGVUNHZCMklabmhtajcrbEVKOElzdm40aVI5Y0hkNFlrcCs4dW1RcThU?=
 =?utf-8?B?T2l5VlF5d0VhWXp5UEViTDcrd2tuVFZNVnp6c2xENXZRMXBMd3p0dDFJbWhE?=
 =?utf-8?B?YXNUT1pVVC8ydHlNUzJUdTRJWS9wVXlRaDJ4K01sZkhvS1dIbjJmdEg5MWVK?=
 =?utf-8?B?dkxCZ09XM1VnaWVPOG1pWDY5c0pwZ05CeW05WkZCclU1eGYvOWRQczdIa3FM?=
 =?utf-8?B?NENIMU5nOXd5eE40Y2NkcW5EY2RMNHJ5VUlZUlluQm1LdXJlRUdWK0t2ajBK?=
 =?utf-8?B?N29BWVBHeVQ4WnV5V0NuRVRPUDU1ZXpwWVZ1SEJZMmNBUEttZkVXNWF0WklB?=
 =?utf-8?B?QVJiRGJaeXVmSEFWLzBlc2Nsa3F6OXc0TVp3cmpERzMyZlV3ZEpxV0lQRTE4?=
 =?utf-8?B?RVNuNVJTSzNoVmhabExxNisrWG83ZGFHOXJJUW16MnZsS085cHYzVkIrbEZR?=
 =?utf-8?B?aDRrVkp4b0pwZ1hEMVBkSXZzUUlYRlFCNVpVNHRvdEEvR1BINnkyNCtHSHBQ?=
 =?utf-8?B?TUEzMnRqZ084ZTJRV2dBUVFJZ3NUZFF6L2NCcm0zYWM3bjA0eFpJZDlTa2Yv?=
 =?utf-8?B?dzJEVG1iRHcxSWtNYVBxYWZSN1YrT2JRVm96blBCQWIvU2daQUU2K3NPS2Fk?=
 =?utf-8?B?SEN2bElWR2hxT1NqNkx5Z3dIc0xBVHJsZ3VFemJVdkFIelVWQkwvMVZIYnVC?=
 =?utf-8?B?WjRCYjA5OFhDYzFTdUcweFdpcHkvMXlBTTJNbEVFNUJ2bDlnQldQZkxOTldU?=
 =?utf-8?B?aFdUUXd4TFpVaDhGRlkrRHRDUzZnSldteUpaVzRIUEZMdHhBNjFWQmFZWk81?=
 =?utf-8?Q?ex9w0Ym6d0T4qbedF9xE7wxyOCS4oJODPnqH0Dr?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e333e26c-573c-451e-08ab-08d96cea327e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5014.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 01:45:37.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YglXMX5gKhdj2Uy8T81xuOaf++OTTtJlRR5lQgWlazgMNLcojtNNqRlyrwHt8c2eMAllvqhHBnUnBBq+MASbgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4806
X-Proofpoint-ORIG-GUID: r7wQQNhY-etVn10YarBui2ZOOJrpMOj0
X-Proofpoint-GUID: lZdE_5KIJb1526mPkRQZBeVKuDTM4yp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-31_10,2021-08-31_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010008
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 9/1/21 9:31 AM, Joshua Watt wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Tue, Aug 31, 2021 at 8:14 PM Yu, Mingli <mingli.yu@windriver.com> wrote:
>>
>>
>>
>> On 8/31/21 11:01 PM, Scott Murray wrote:
>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>
>>> On Tue, 31 Aug 2021, mingli.yu@windriver.com wrote:
>>>
>>>> From: Mingli Yu <mingli.yu@windriver.com>
>>>>
>>>> After [1] introduced, the PR server doesn't work in docker when use
>>>> below setting like before.
>>>> PRSERV_HOST = "localhost:0"
>>>>
>>>> And it's because the localhost is resolved to an ipv6 address ::1 as
>>>> the below bitbake-prserv shows.
>>>>    bitbake$ bitbake-prserv --start --host=localhost --port=42005
>>>>    bitbake$ cat prserv.log
>>>>       Traceback (most recent call last):
>>>>         File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 55, in <module>
>>>>           ret = main()
>>>>         File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 46, in main
>>>>           ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile), options.read_only)
>>>>         File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 226, in start_daemon
>>>>           run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
>>>>         File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 202, in run_as_daemon
>>>>           func()
>>>>         File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 224, in daemon_main
>>>>           server.serve_forever()
>>>>         File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 233, in serve_forever
>>>>           self.start()
>>>>         File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 144, in start_tcp
>>>>           self.server = self.loop.run_until_complete(server_coro)
>>>>         File "/usr/lib/python3.8/asyncio/base_events.py", line 616, in run_until_complete
>>>>           return future.result()
>>>>         File "/usr/lib/python3.8/asyncio/streams.py", line 94, in start_server
>>>>           return await loop.create_server(factory, host, port, **kwds)
>>>>         File "/usr/lib/python3.8/asyncio/base_events.py", line 1463, in create_server
>>>>           raise OSError(err.errno, 'error while attempting '
>>>>       OSError: [Errno 99] error while attempting to bind on address ('::1', 42005, 0, 0): cannot assign requested address
>>>>
>>>> So add the extra logic to make the localhost resolved as expected to
>>>> make the PR service work especially in docker.
>>>>
>>>> [1] 6a2b23e2 prserv: Replace XML RPC with modern asyncrpc implementation
>>>>
>>>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>>>> ---
>>>>    lib/prserv/serv.py | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
>>>> index 68db3d3e..0a20b927 100644
>>>> --- a/lib/prserv/serv.py
>>>> +++ b/lib/prserv/serv.py
>>>> @@ -126,7 +126,7 @@ class PRServSingleton(object):
>>>>
>>>>        def start(self):
>>>>            self.prserv = PRServer(self.dbfile)
>>>> -        self.prserv.start_tcp_server(self.host, self.port)
>>>> +        self.prserv.start_tcp_server(socket.gethostbyname(self.host), self.port)
>>>>            self.process = self.prserv.serve_as_process()
>>>>
>>>>            if not self.prserv.address:
>>>> @@ -221,7 +221,7 @@ def start_daemon(dbfile, host, port, logfile, read_only=False):
>>>>        dbfile = os.path.abspath(dbfile)
>>>>        def daemon_main():
>>>>            server = PRServer(dbfile, read_only=read_only)
>>>> -        server.start_tcp_server(host, port)
>>>> +        server.start_tcp_server(ip, port)
>>>>            server.serve_forever()
>>>>
>>>>        run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
>>>>
>>>
>>> Richard has picked up Martin's patch in master-next, I think that would
>>> remove the need for this one?
>>
>> The patch from Martin is just make the error message specific, but
>> localhost still does't work in docker with Martin's patch and this patch
>> is used to make it work in docker.
> 
> I think that was because IPv6 support had been incorrectly configured
> for Docker, perhaps that is the same thing happening in your setup?

In the same docker, the PR service works with PRSERV_HOST = 
"localhost:0" before, but it begins not work recently after some code 
restructure for prserv part.

BTW, the ipv6 is disabled in the docker of my env.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Scott
>>>
>>
>> 
>>
