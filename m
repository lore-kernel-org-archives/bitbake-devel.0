Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2347BE77188
	for <webhook@archiver.kernel.org>; Thu,  2 Jan 2025 12:39:19 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.101])
 by mx.groups.io with SMTP id smtpd.web11.7007.1735821554654124253
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Jan 2025 04:39:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=cylL2baY;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.101, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJDaUAbeAiTqDzmD0feR9oJJ1tKXhOigimT91J7MotOo1U/v3SN787MR194/HoRj95j9yX8wQ6nexDT+wq9AAjvbNU/aXjcXKc0wbbFhJT4Q07Qhp30SUVTw957+WR0mOge2GfTpBy/ap1YrxMUuMTdMzZRBP5RxwlJ4KsJkWvZMk2MJV08i6FZiqYNe+HjTMn4wUCUdE1jD8F6n7kXWKaId7YJIvgCnk4AxWgCxvYC7qnW7CDxIAAtSQislXyy+nglyJpcO4Mz0ABWL5SQnvQO69rAKGBuHzMrhUlggw/4lLXeoVNfBtpbBtoDv/s2piXamn8a6nKDSYPdhXpDvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7qjgf/cGciuFdwwblbNb8Gec2vZ4W8QxZMHzPm05d8=;
 b=vRz0l6PkZBu9XfxHnptRlqxT1TnmtwrlKyqwHLmGxvbpnnt6x/e34gLhKYgQOIokng3PbI44gEoJSRsIQA165qfU4cH17YncIFjXbSB+GLnsW+GwKwPaypA9dNW7VXjw+bAewTutwpoqqLTqhMhUBHKkjne/ZFkpC613q3JzvFyUM9sZLI+dInGQFcFAgAwmPK2yJbAmY2HacEqSd+f6ZefeJquRIH6SWAaf4PkaeEIpkZ7jKNRWT+7Hj1Ji9vPW+lvUVR5ileuxYyExENqxavN1KTccONNOUyPyMymSHzDwPdaQiGrQOm6+1DIEu+3hCqtraJyL/KBILwCXpDRXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7qjgf/cGciuFdwwblbNb8Gec2vZ4W8QxZMHzPm05d8=;
 b=cylL2baYF7h75t0zmQ6Q5xGQ8HOtQI5mwIK5SNAl7VTA4cG33FaRm8un36ZzRmwkZOvTUIHqNIQZvXiJJ8RnElu4u0f2+A415r8lPEsioYbmRH3vKGm6vi0KUxi898L+x07ALc+AWwoaGHLYUB2j4uvU5zRLXPRVA5bsIIzHnp+iMeQRrB2SBT+c6VyOTW2WPNzc9WdkfBa6/JsiHs43sU4r7h747Zgl3VX7lsd3m6kp2ryEpO9E7PB4h+dr5m02MdppZA5aYuAsUH6baCsRLdr80bhhR784C8Je6zYz4X4gfuaUgofgjQs4s3JHi2yHVvh9MuR7KwotdNNVQwjL3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB7567.eurprd08.prod.outlook.com (2603:10a6:10:317::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Thu, 2 Jan
 2025 12:39:07 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 12:39:06 +0000
Content-Type: multipart/alternative;
 boundary="------------TvYvEr0iOq0JdzBD3sN0swDI"
Message-ID: <f30a04bf-96f2-458d-9ceb-94fc39895dc8@weidmueller.com>
Date: Thu, 2 Jan 2025 13:39:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 07/21] fetch2: add unpack support for
 npm archives
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20241220112613.22647-8-stefan.herbrechtsmeier-oss@weidmueller.com>
 <f9b92d30b08d5177de4941bc31c17add5ee2f8f4.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <f9b92d30b08d5177de4941bc31c17add5ee2f8f4.camel@linuxfoundation.org>
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU0PR08MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8c7141-d5d8-42ec-fbc0-08dd2b2a7278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b0U3M2NLSzIyRTRZRDJuSkxPaExEOERaNjcxSDRsZStxTmprWlVNM3d4b3pD?=
 =?utf-8?B?cDBxM2M1NG5mbDBHUHMyaVh0cVltdkh3Z1FIcGlJWFdiRVBwUm5GcStiSzhj?=
 =?utf-8?B?Qzk0VkF5cENBWEJURUM4TGt2dEk2K1RCMkZhM1lrdVJNOW12M3lWY3h2NFJl?=
 =?utf-8?B?S3lXSnUra042Y0dVL3pGdXdLUUtDL2xsZ2kxTjFOcE5iQzBOWFcyQXpQamlC?=
 =?utf-8?B?RUo2RGlzekNSSGhQQVpkMkNsUEQ0MktYOHNIMEtUZ1JkZUhTQlBrak9DUVhK?=
 =?utf-8?B?OWcxM3U4eWRMN1JZZCtxYXJWbVVPVmtlNHc4Z3ZtNmQyTmVVYjVEc1F5OUpF?=
 =?utf-8?B?T2d5WHRncHBUdUhxNEdvai93dUhHVkNCZFYzTmhud00wU215Lys5M2lzMzBx?=
 =?utf-8?B?TGxXellHTytUMXhHZDM0amlsK2hsNU1FYjc3NHh4ZmxlVmkrelpIdFd2cUNO?=
 =?utf-8?B?RjY5NzFqZndLY1I4SWJaZUR3U29CZWlqL011dm1MRk91QXkxczFFWjl5ZU1X?=
 =?utf-8?B?azJadWp6SWtSNDdGMGdGemU2TXhlbStzbnFYR0lOZ3hPOW9uQUZPOVFpQmZO?=
 =?utf-8?B?RGp5OHc5NnBQOExYbXArN1JabHczeTVpU3BFWWVTMzY5SEVqa3BuNythZzhy?=
 =?utf-8?B?QWlCL1kxaHpaWW1aazlHT3FaVWcrYitjRUhHZ0ZkY0Q2T1J4eVIwcWtPZ253?=
 =?utf-8?B?R0NvZmcxRGhUNDNSTjRtdGdpNXVJVGpmR3Q4TjlQc3Ria2o5REpCYVU1blI4?=
 =?utf-8?B?MjlZQitBWWxXZFFEcWtpN1VDN0NwRXZuTVYzM3c2N05RVW9aTS9JTkw4bzhK?=
 =?utf-8?B?L3FtRUVRQjVKd2ZiWlZ6aS9jaGNSelpoR2JISkxTRnlwY1hyczdmdTY2N3JS?=
 =?utf-8?B?WC9xU0Qvc3NsK0ZXMy80b04vMW4xc053dWFDZFVlYWpMQTRMYit0K0ZOTTVH?=
 =?utf-8?B?MG9LNHhQMy9FYW9kWGh1cWh2YjRuVkd2WDk2N2ZuNEF6RnFRSGkveTA4Rk9h?=
 =?utf-8?B?TlZEeGczeDFQcmxjYzBSdUc1eUJBbUNhUnZONXRvNzFjY0Y1VG9nVHlLclpK?=
 =?utf-8?B?Um5RWWxUOE5ETzhsWHMxZldTWCtIbjArMjU4MnJVVDAyckhoYXByZlJMSEJN?=
 =?utf-8?B?cHRnMzNzVFluWkkyRTl4UVNTY1RBOXp1SlVVUnVJWkdXL0NSNm96ZCt4OGRy?=
 =?utf-8?B?TCtoSmZ1cVZMbllsclNJa0t5VEFTT1I0SzB6SzI4b1VKZ210cFhWdnZOVDNE?=
 =?utf-8?B?WEM5M2I0Vk52NTIzMlBWckJwZmE5aWloc3VuOUhORkdDbjhncjIyK1d3MFJ3?=
 =?utf-8?B?cVdiaTRDNmxqWlJsOFZ4T0EwMDRJWElGeG00TkdJcGdOWG1UejFZdWY1NUc4?=
 =?utf-8?B?RlhCTFdqalQvOVFpTkJZamZoWkwvMnkzc1BGYkVJRHp0Z01mUWdjU3RGUE9u?=
 =?utf-8?B?N0RUczhWdHBMWWVCQTNFREZzRTIzelZUa29INW83SWdCQmlEdkw0QWIyaGFn?=
 =?utf-8?B?b2NPTVpFQzB2M1VIZlJaSDEySDlNUmJFUTRrK1RTK2JXNnlwQWJqVlJGMkc3?=
 =?utf-8?B?YXYyMHNYVTBCTFV5cUU1Sm1zZEc1eE5nZ2lMSHNuUm9hQTFXZXVlZElVZ25R?=
 =?utf-8?B?ZWhsRlV6bDNBWExUOUJYeXBWU3pKZVlZbElLamFyOElHdXhFSGlYRk92eVlq?=
 =?utf-8?B?U0orcFRyZ3N5QkpScGoxdlI0UVl5YkQzdzdQdkM3MlkzUDBDVXNDSW5ITUwx?=
 =?utf-8?B?T2ZNeG13QjUrTmVsTUMyMUllOGZ4N3E3VGtuSFh5TGZDVHFNTnBpczRLcWlr?=
 =?utf-8?B?bnBlVnZHS3BCTkhzaXU3MyszY2ZzSUIyNlhWdFZBZ3hrckVHZ0lWV1VVT2RV?=
 =?utf-8?Q?N8UhBWJ9NOhop?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2RjSk5mbld5L2ExazVpUHdkNnVFMHVOaVQ5TGUzTkJKT0UzYnNYTUhXN1Fu?=
 =?utf-8?B?V0ptVWVkTCtIaHlnWEp4YW5TUTJaRStrOU96eEJyNEkwQmlqKzU5N053MnFr?=
 =?utf-8?B?TE55SnVvRHJHTVZQR29VNUFXSUF0OC9KdEhDWFNnNWJpTk5oYTdFbUZzb2xl?=
 =?utf-8?B?YmNBU3RVQkFZMTBuTlV3L01CM0Z3eFFEUHNIaitpNGliNm1TTFhKRG9sYVQ5?=
 =?utf-8?B?L05uU3UvWGE0YmVtbTByT2lKckRwbDVhYyt1Vkczd1AxVVRQSkVucEloV0Ew?=
 =?utf-8?B?QzlBcW1kLzN5azVrTEtuOU9iUVkzcDdUdmQwTTgxbEhCVXBub1hDdXlicGxM?=
 =?utf-8?B?Wnd1WEQ5dVVjMUNyYksySWpoemVBQmdzUzAwOWJlZU5BL2xlMnpYSEhUVkdm?=
 =?utf-8?B?dUg2cVN3N1oyWkczNGdoKzRsQVhXRWN6bzdZUEg4Ym9ENHZ2WkNvNlhSNWIw?=
 =?utf-8?B?aE1nSXVMNFNxNXorT0hwM0FQUzZlUnI1S1RmRVFPR1RZTFljSU5YcUJOcm4r?=
 =?utf-8?B?amN6Y0xPQkhEZnZUTWZxWVpmbFVsL0JLbW1xT1dHRytjbjA5VEROeWFGRmZh?=
 =?utf-8?B?bHExOHlPc1QvY1VVdWRtdVg1cjlrc1RQaUE3OVg1RS9oL3h1V0FqRVVwcVE4?=
 =?utf-8?B?TWV4dUpTUlBSWkRwajJJVFlVK3BnTnZjY1FoZ0lEVGNhSDBSSVlqWGU0eHhI?=
 =?utf-8?B?V3BLTFEzMEpHb3lWUW5Vc3ovbzVBZHdDR2NlTnJ2amU2cDJQc3F6WE9kSERE?=
 =?utf-8?B?YlhBVlpRSlA5cmllNFQvT21lR0JBM1h2OTdGSC96T2lLYkFpSnZIWmtSZCtK?=
 =?utf-8?B?U3l6RUhhMCtoWXhSTGNUMGhjemlSbXBISHBlZGpDdzlOVTZhd2dGcEN5VStz?=
 =?utf-8?B?dHRkVDg0bFFjQUlWOTB6Z3JyT2hJTDRCR0dRL3ZGMms3dDB1ZE1RY1VsUkYr?=
 =?utf-8?B?dStEYTloZjgyeFV6L0NFNlZqN0drVi9uRmhmQVlONGYzdlppcUJNVnFtVjN3?=
 =?utf-8?B?cHZteDFNSDByQ3dkYldkZ2dLQ2NWT2lIcWNNalByM2pSdkhqb25SUUJxRGRS?=
 =?utf-8?B?MFUwdmVxQnBzU2tReXpRZGtOaWtFQy9lcWNlOWZvbHRZbE5MWlp0V3ZHRlVk?=
 =?utf-8?B?KzAxT2ZmZ1NWRkZHQ09vTDQzSXhnVWxFR0xCME1uUVVPYTA3bGw4K3ZmY3Vw?=
 =?utf-8?B?NXBSNnJNVDg3aURTckhaRHBuOUxITDhuZXI2c1d2dVVQeE1STE9zZGptRkVw?=
 =?utf-8?B?R3hsTUhhNXdjRDZDa2kvdjJOWnlQMi9TVEdMaHBibnFKVG5Wc3dhZ1N3aGFF?=
 =?utf-8?B?NlRWMGZ1cUlUNk0zUkg2K3NMRDVtZ1FoTHF6RWpud3Y0RisrRUwveEdtc3d5?=
 =?utf-8?B?ODBxeWxpTGsxcUVraDBwNTVFaXBLZGYyT0xoOHpNU2VaZERrVnJRWkM3cEFo?=
 =?utf-8?B?T3UxMmtRa1k2MnptbkNEL1dGMzhYZDhiRjh3aC85YnpzS09DbEZOdWV0QlNt?=
 =?utf-8?B?Um0wR2o5Q2s5Nnh6ejJ1S0lXcEVjek0xcy9GUnhWSHo5d2hubWFBcFR1Mzk2?=
 =?utf-8?B?c1dXVVcrT2x3bmptK0p0aTIvNGxpZzFlOHJLT2ozN3NMQ1VkRG1HV2pyY1o2?=
 =?utf-8?B?T3VyN2kybnhLL1l5Q3lsM1ZTdmpmaXpwNk9EaVZvV2U3aHdXQmxOK3J2MjJ2?=
 =?utf-8?B?NVArRnBJU2tYMmdYc2pCdVJ3TDRuVlZUa055QTA5L1MreU5GWnFrNXoybGgz?=
 =?utf-8?B?STRYdHZ4cDhVSzJLNjVJRU9EQVg3OGF3ZkI1NG9JTWNTeU1LY2pxOTBDcjNl?=
 =?utf-8?B?Qk1VQm1OK0tNU0I5cTFiWkgrMjlJMTcrLzFNVXZMdEZCNFhLZ1JKRFRCTEZ1?=
 =?utf-8?B?RE9uU0lJRUVueFF0cWg5RTRkeWdWb2RzZ1p5UFZFZkU2eStuZXdHZ2xIQjBq?=
 =?utf-8?B?Nkd0MEJXT0UrZ3lCYUZYTkhabU8zTWhqU1ZheFpLMTQrS3Y0aVM5WG1uUjYz?=
 =?utf-8?B?QnVRa0M3Z3NYTTNmTUtGbDM4Z1JLeXpFclJPWDZYdFBjUktMbHhIcll5TFBF?=
 =?utf-8?B?MG9rMVNYMUg1eTRnRndDdndUWFlJb0ZadGwvNkRsdWpZZTN5Z3FnNktuTWVs?=
 =?utf-8?B?eUpQZGJKek9velQ1WUhES2Q1dDZyREpWVkdsSjBwc0tlS3ZuY0oxaWJlNzRk?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8c7141-d5d8-42ec-fbc0-08dd2b2a7278
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 12:39:06.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DsAE8mjEdCj25HpMG0TXr3xS/us5ZEeQCNe4lLXdXlk55vHUaEv9b1CXgHvPr80urvFjSCHmzUlZBnSPgPoNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7567
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 12:39:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16958

--------------TvYvEr0iOq0JdzBD3sN0swDI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.12.2024 um 12:56 schrieb Richard Purdie:
> On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>> From: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>
>>
>> Add unpack support for npm archives with unusual member ordering and
>> disable warnings for unknown extended header keywords.
>>
>> Signed-off-by: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>
>> ---
>>
>>   lib/bb/fetch2/__init__.py | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index 4b7c01d6a..7d8f71b20 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -1535,6 +1535,7 @@ class FetchMethod(object):
>>   
>>           if unpack:
>>               tar_cmd = 'tar --extract --no-same-owner'
>> +            tar_cmd += ' --delay-directory-restore --warning=no-unknown-keyword'
>>               if 'striplevel' in urldata.parm:
>>                   tar_cmd += ' --strip-components=%s' %  urldata.parm['striplevel']
>>               if file.endswith('.tar'):
> I think I'd be happier if this option was only added for the npm fetcher...

Can I check the ud.type to add the args or should I move the args to an 
optional argument for the unpack method or an FetchMethod variable?

--------------TvYvEr0iOq0JdzBD3sN0swDI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 23.12.2024 um 12:56 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:f9b92d30b08d5177de4941bc31c17add5ee2f8f4.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">From: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>

Add unpack support for npm archives with unusual member ordering and
disable warnings for unknown extended header keywords.

Signed-off-by: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>
---

&nbsp;lib/bb/fetch2/__init__.py | 1 +
&nbsp;1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 4b7c01d6a..7d8f71b20 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1535,6 +1535,7 @@ class FetchMethod(object):
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if unpack:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tar_cmd = 'tar --extract --no-same-owner'
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tar_cmd += ' --delay-directory-restore --warning=no-unknown-keyword'
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if 'striplevel' in urldata.parm:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tar_cmd += ' --strip-components=%s' %&nbsp; urldata.parm['striplevel']
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if file.endswith('.tar'):
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think I'd be happier if this option was only added for the npm fetcher...</pre>
    </blockquote>
    <p>Can I check the ud.type to add the args or should I move the args
      to an optional argument for the unpack method or an FetchMethod
      variable?</p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------TvYvEr0iOq0JdzBD3sN0swDI--

