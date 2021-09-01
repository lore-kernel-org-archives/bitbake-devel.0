Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web12.1809.1630458884250724572
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Aug 2021 18:14:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=pJhRZ/Mo;
 spf=pass (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=48786bfbe4=mingli.yu@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1810tLaK002264
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Aug 2021 18:14:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=9O1wccTTTtJwXOZrdHKSRmwaoVKrUGlrSBrsTbWOegQ=;
 b=pJhRZ/MoSVW0iLZPrZK5DzY7BTRHLsRcboMwAGiwMaZQ+7FUnd4borwb0KGpUZraNfH6
 mQ+Owvy7PKPmtOJtdWsI4q2VDP6qB4sfVCtuMsEHty79j/mPdEpa2eOUJWh8Bcp6izTE
 mwOjROoG81BBhRGDfet0o+kcO88iHn3lwBVnFFbBauuelUobpbXaloZU0THpmNze02ff
 AZ6RAtd2gkZLIYQ8pMyz9qdUaU47dKQpUtn0S72puH1LN3QLdMMMA8fzAB3ZHG3WsQmO
 xMkSyafkodDhQetxOkaQrJ11+jr/2r7F9qr4bscJ/KfhiCxy7D2LEf43azQwCNGnYXhI vA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com with ESMTP id 3as5qr0yt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Aug 2021 18:14:43 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1811EhWV001347
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Aug 2021 18:14:43 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
	by mx0a-0064b401.pphosted.com with ESMTP id 3as5qr0ysy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Aug 2021 18:14:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5HwRoZJeHaNQrpsN0DI58+WHeDftTGxa4Zny5ihxWRl5Xh575rCCU4izHbk+DEp2+h7qrjPc3aNPdlJka++e/Sk5ORpAhSTQf4h8oxnr8QwhIY6X4weMhyCS3uzoqWx+TQ7GY6iX1y88RWrJFrXMacf3q2ZOcWN4HnWJzkahTaJZeB6bFQYWAbwvqR6ki5JKmnkiBnNV9wSFDag9936J0wGxhbQABpJAfhU22LStAdrnWDxdSM9qHYw15wzHBxNri0uMi8bxQGcv+vX/SX3CVwOGCQQbA1l/qa4XVSg4THhgMnPBPU+IsF2pnQoR0GcrlCiWco5fPvEYnzS75ws2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O1wccTTTtJwXOZrdHKSRmwaoVKrUGlrSBrsTbWOegQ=;
 b=er/zkQc3hn7w0RrX1dtIggSwkt9ghmUZpdcbtdtiV3v4LT4MFzGD6JqRVXqyVoLAznzlDqTUcTWLn2lQOupqnJxmM2Ys+FgMavBvuyUBuNrDKFwpaVAl2i4bTjxMN9f2yhcVN5x0l9zazT3SYJuwhZ8Wfs1uySS+XJWdDxn3/6HQ7wIVQAeEOG/MMm2fv4y1mdnPs5nwy3XmOGWz4kDUug6EhbBfJ5SITfzIRlR6j7F+Qe9Bhrm73kc4DvF8BpnvOlKaxklCeLu+5DrTFCd070GkRKpaU9OIzWldRddsCwBWteM3do4p69Fl+aUBxTwgkquDpAPbxrTEQdiIG48LmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5014.namprd11.prod.outlook.com (2603:10b6:510:31::17)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 01:14:40 +0000
Received: from PH0PR11MB5014.namprd11.prod.outlook.com
 ([fe80::dd24:d36a:f979:58e8]) by PH0PR11MB5014.namprd11.prod.outlook.com
 ([fe80::dd24:d36a:f979:58e8%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 01:14:40 +0000
Subject: Re: [PATCH] prserv: make localhost work
To: Scott Murray <scott.murray@konsulko.com>
Cc: bitbake-devel@lists.openembedded.org, Martin.Jansa@gmail.com
References: <16A04D855643B3E7.30479@lists.openembedded.org>
 <20210831074807.5972-1-mingli.yu@windriver.com>
 <f3b29ae8-7582-4b3b-abaf-8e1eb08bf54@spiteful.org>
From: "Yu, Mingli" <mingli.yu@windriver.com>
Message-ID: <d3e95bfb-593d-0fd8-bcb8-65af9537f5ea@windriver.com>
Date: Wed, 1 Sep 2021 09:20:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <f3b29ae8-7582-4b3b-abaf-8e1eb08bf54@spiteful.org>
X-ClientProxiedBy: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To PH0PR11MB5014.namprd11.prod.outlook.com
 (2603:10b6:510:31::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.173] (60.247.85.82) by HK2PR02CA0168.apcprd02.prod.outlook.com (2603:1096:201:1f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 01:14:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 572f50c9-97e4-42fb-3dec-08d96ce5df62
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:
X-Microsoft-Antispam-PRVS: 
	<PH0PR11MB48557484CDBE8FC59650E692F1CD9@PH0PR11MB4855.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OepvSXdehieOJ55FUAsHYVwkiT+ttum6h/yp/ZdTNPR267srkq48brN4zau3bBieIK1tNg1HXt6dgjsiN6kD7lV181+E+EswdlO48yw6AEwMmrTsYVS5wRUKu/iZOImNjtJWBULSDeD/XP2q4zfWSAK7lu6BMHHrOAiQW9Z9LwSwpWhofDeHutsAmkgmHx1r2LEb+mxPOj87PEhboY9oTTy0FGeuOVumzpCdwMXMaH4h7Y6gz6YdbksqiwNHm1pSMZY+X/CE2miDVw+ujNeZlqBS4JNRSEdSPKE7GDq1plmjv/O0ZWhQwpRGOk9hhHqB7swnGSwWYlE8OnM88HwwdIRXV3IUvJgKOHmWJ8cor0z6uxwzQ7jbpH2oMcNLLkH6jIdOqRwVVMkpx079lQe7Nr0GxJzaQeNM4PJ7DMPhn4qi8GxD/LxfSOxNYJDkpYHM3FMCTGjy93JzCxtd0CWeg6xCMugMfUqBQmjDZwLsb3aa7seOvjrW7PJyYWc+PoVSfz9O5+6DSryfTa8dfpzYFvVYFFNdOFM7q6bXaFiCXLeYm/RZ25WTUsQlQ22azs7TQXzsNyjZT9KEi78y4yx/5ijh6x6yzY/zcuk5LXH68lPb587B6W63XjhqrykHwS7CbPH4doyKYeG0J2QgGmi4Xz0iFvAIXzmN2wwrdtvbF6Y9PlTQVIgzzmhpjnjvj+lUYEqNdD5ni0R4tqVk7Ma0BoeMPfeHvMP10OSzuNzZMXX/c/o8pbHH4fyw7fnttogUUz0rKPPCklXbBAsKe4+HVH8BnCr+dUN4aGoBDYOUvcQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5014.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39840400004)(366004)(396003)(53546011)(6916009)(52116002)(66476007)(186003)(6486002)(66946007)(2616005)(86362001)(8676002)(66556008)(6706004)(8936002)(31696002)(316002)(38350700002)(5660300002)(4326008)(38100700002)(31686004)(16576012)(478600001)(2906002)(83380400001)(6666004)(26005)(36756003)(956004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZExqb2pPV1NzNDlMdmhhaWJ4bDB0UU4zcXpUUGczeGcxazV4R2dIYVhHY1J2?=
 =?utf-8?B?VEZwQm9wbFE5S2xUR2dhNEY3MWRLYzQvWFd0ZEFpYWgwK1QyNFFOeEE4M3Z2?=
 =?utf-8?B?alAzNy9SVFlyQ2FEcEViRFhvbkZnQzJucm5Jd2FldmE5dWNGUkM0LzJGZEtx?=
 =?utf-8?B?RE5MWndKeGRuZTkwY2JJNTNwL0Z5M1NpSmZ0VVMyTHdWNDByNFVvMnkxdUph?=
 =?utf-8?B?Q3hnLzNEcEhNVnloWWdXajFzNWJDalFDbVhKdk12V1hGbXk4VmJBWUFqRWdH?=
 =?utf-8?B?Rmp6YUh6dXhrNHhuSHhESG4waDZNMWNTakt0eFpST1d4c0QzR2o3R25Hbm9u?=
 =?utf-8?B?VE9Cd3JIYm1GUndlUU1KYVhEbTUrT0NHeS8yR2hzL1Y5WTVqOXY1NGlKblJo?=
 =?utf-8?B?eUtXSVF0NGh4Nko5Q0IzaFJsODU5QmFUYk1YbDkzcXlWQ0VnWHNuZG4zdHFF?=
 =?utf-8?B?Zkc4SDFXVXMvUEs2Y2IyTGVBM2F0TnZPYUwxdG5Jd0lvdkxvb3Q4ejBnMDR2?=
 =?utf-8?B?bnRzZ1JpV1pIM0xiM1prbzRxNkZvU3BZSkNQUWRtR1VKYnlDM1dZa1NCOEF4?=
 =?utf-8?B?MGhvdjJXRjZqTXZOamZzMFdtUE0ya3MxeE0rd2U1SnBOL29WTXpYNGRtM3Yz?=
 =?utf-8?B?c0xjQjNIVlN1VEpkNWJVRUpvSXVwRElDYXFNREtKZkcyem12V0dVNHc0anZm?=
 =?utf-8?B?WE9ORCtnSEZ6NHVtY2tEQ055ZE51MHpqNmxQUUFLNnFPUVB5NkNCQ3AyQXJh?=
 =?utf-8?B?elh1KzcvMjBtRTZTaXJBRWZxTTQvR3VUOTl0VCtYZTRSVU9vcWR5NlV1dnR5?=
 =?utf-8?B?WHpqVElEcWxXekRDa2h4eW1NV1FzVnpUeGFzUzhkUGZTNXJSM3dteGZmbHRS?=
 =?utf-8?B?bGw0UERxTGx1YVRwQzRyZWQra1lxMncyaWdMdFAvZWFRTDdjVVNiOW8xaUd4?=
 =?utf-8?B?K3c4aVRGa1NzMVhWckkxTzUvL3RzMGphRGIvWW96T1lIZDdRdVNPUWUzbTIw?=
 =?utf-8?B?Wk9zS29yTGRiemZwWGZ6UVR5UkRCaFlKTENuc0NZdFlsMHovbVRyN01DczhG?=
 =?utf-8?B?b3RGN0VtSGZ4K3hKMjNodmFNK3dMRHprS3lvY05ld21nWks5VklWa2Q1Wkxu?=
 =?utf-8?B?d0JQWG5URUxJS2xXcXZQQXZBQ3dvcDR0Q3JjYXFpVFZOclZHNVNTSEVCTXh2?=
 =?utf-8?B?bThTODd3RDh6MXp4bi8rZDJ3TStKTGhvR0xVSzYzV2hXZzhvc285RWVTa1B1?=
 =?utf-8?B?R1dCUGEvaFFWOGZqQ1p1UWs4aHJ6WmdCL25qalpONkw4eWtjUmJ0eTlZc0Nw?=
 =?utf-8?B?N0t6RUxkdkRWSlU1Mm9NTVlSL01KQUtMN01vUTc3YzNsTEd0bE5GWGQvenFB?=
 =?utf-8?B?UE0wbHppVG1CMHdTTUowdlYzK1o1d3BBUE5NYjJhZkxHaWEyenVzUHZOSDgw?=
 =?utf-8?B?cjZxRTRjVkE0WlJjRWczZ2p1YnlzSXgrUkVJUU9OV2VoSXRMM2RQT1hpYVVF?=
 =?utf-8?B?MlN0YUpmVFJmTUR4dUJoNEVGa2p2NE9tTWNYUjB6STdKUTk5UDNWdkpKbXg0?=
 =?utf-8?B?Sjg3OUFaMFBKVE5TTFlocUJ6NGREalB0NjY2QWtrWHNiQk1VZGt0WXNJMzBk?=
 =?utf-8?B?TURCTVpaVmVKakdXTDdNUVV6TWd3YjBoTmNuRVRISlF0aTV6c2R1L0N6Vm55?=
 =?utf-8?B?Q1k4T1NZV05BaE10Q1pkYmlsZXM4aUszNGEwdVd4Z1piajR3Mlc3WXh0em9P?=
 =?utf-8?Q?ghku3aAng7dsQVf6lGFOkqzryFqYWyTO0BbK7VJ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572f50c9-97e4-42fb-3dec-08d96ce5df62
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5014.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 01:14:40.2197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8HGPB0KDmAvPG4m6lDDhvYra48CBKoCWzW2qZ6eBGKDkerVnvTdn9wdu6xT8dMffB2MkQdxV3q0ba1IYeNm3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-Proofpoint-GUID: tC14FT7eBUMOPozSLAxBNIcgEKQgIV3n
X-Proofpoint-ORIG-GUID: 4p6AiM4RCRcj5VvhFme8-IQ_PLRiRiuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-31_10,2021-08-31_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010006
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 8/31/21 11:01 PM, Scott Murray wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Tue, 31 Aug 2021, mingli.yu@windriver.com wrote:
> 
>> From: Mingli Yu <mingli.yu@windriver.com>
>>
>> After [1] introduced, the PR server doesn't work in docker when use
>> below setting like before.
>> PRSERV_HOST = "localhost:0"
>>
>> And it's because the localhost is resolved to an ipv6 address ::1 as
>> the below bitbake-prserv shows.
>>   bitbake$ bitbake-prserv --start --host=localhost --port=42005
>>   bitbake$ cat prserv.log
>>      Traceback (most recent call last):
>>        File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 55, in <module>
>>          ret = main()
>>        File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 46, in main
>>          ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile), options.read_only)
>>        File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 226, in start_daemon
>>          run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
>>        File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 202, in run_as_daemon
>>          func()
>>        File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 224, in daemon_main
>>          server.serve_forever()
>>        File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 233, in serve_forever
>>          self.start()
>>        File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 144, in start_tcp
>>          self.server = self.loop.run_until_complete(server_coro)
>>        File "/usr/lib/python3.8/asyncio/base_events.py", line 616, in run_until_complete
>>          return future.result()
>>        File "/usr/lib/python3.8/asyncio/streams.py", line 94, in start_server
>>          return await loop.create_server(factory, host, port, **kwds)
>>        File "/usr/lib/python3.8/asyncio/base_events.py", line 1463, in create_server
>>          raise OSError(err.errno, 'error while attempting '
>>      OSError: [Errno 99] error while attempting to bind on address ('::1', 42005, 0, 0): cannot assign requested address
>>
>> So add the extra logic to make the localhost resolved as expected to
>> make the PR service work especially in docker.
>>
>> [1] 6a2b23e2 prserv: Replace XML RPC with modern asyncrpc implementation
>>
>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>> ---
>>   lib/prserv/serv.py | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
>> index 68db3d3e..0a20b927 100644
>> --- a/lib/prserv/serv.py
>> +++ b/lib/prserv/serv.py
>> @@ -126,7 +126,7 @@ class PRServSingleton(object):
>>
>>       def start(self):
>>           self.prserv = PRServer(self.dbfile)
>> -        self.prserv.start_tcp_server(self.host, self.port)
>> +        self.prserv.start_tcp_server(socket.gethostbyname(self.host), self.port)
>>           self.process = self.prserv.serve_as_process()
>>
>>           if not self.prserv.address:
>> @@ -221,7 +221,7 @@ def start_daemon(dbfile, host, port, logfile, read_only=False):
>>       dbfile = os.path.abspath(dbfile)
>>       def daemon_main():
>>           server = PRServer(dbfile, read_only=read_only)
>> -        server.start_tcp_server(host, port)
>> +        server.start_tcp_server(ip, port)
>>           server.serve_forever()
>>
>>       run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
>>
> 
> Richard has picked up Martin's patch in master-next, I think that would
> remove the need for this one?

The patch from Martin is just make the error message specific, but 
localhost still does't work in docker with Martin's patch and this patch 
is used to make it work in docker.

Thanks,

> 
> Scott
> 
