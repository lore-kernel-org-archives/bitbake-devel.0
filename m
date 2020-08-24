Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.82])
 by mx.groups.io with SMTP id smtpd.web10.186855.1598232400438749576
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 23 Aug 2020 18:26:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=LSTNHeOm;
 spf=pass (domain: windriver.com, ip: 40.107.92.82, mailfrom: hongxu.jia@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Luo9o9RLLcB5Kjx0VCoFa56MTFm0I+nYzmFQDGFgwbXmshFvQ6eJ7sQJLfzaBeCA+1coMnw93WssjBsXGUVshfFFEhTLCDg9yRLvMX4UUsXYOJD4NEQVSxCJ6ftCfyRpORwINnMx9mFGUJ/FjW5WzqZbfWt2ZQ+2qEGd+4XEhRwPRXIc/eGlG3WEAxfLB4We0wF3sJCQrYjoRgCXehbTyl85MVWINeQ2RUhxQ4AOEGTiiw8r+2W284X0t0BYQa0m/elLsZtl3IqnytoqPHMi0sV4GuLSN6cds7BUOQjJV5YssQ0gwRfCVlKwnkrQPBfAjhyrKBQ9Z6/UCOG0b6eq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyEkZlnbsGY5pD17tsyyWrE93SLLUGJWrtjCSbHFWd4=;
 b=NjdcrhrplYuXy78Lf/s3NmYONqCCt2yGq39NXvF6BQy3fmrH1QfbV4prWkUUft5/EN6ckTQMmrqqLOjwXH6ydBtZtkPjiRGVY1+ig85jWCD/QLrq0Tcmu80N5KQuRpiTrOaCNOetf1gQKBpk6ly2ES4jYLBGzeov9qhg69oR13Ml25ZYbrrSi3vACm5YUD93OftD/LLaUS59ttV2iE/JFVgXe1UkpVd1FpChAPirf5aSPDlOl+VSvWsHpZaiE32jtLfzOQLtMLp7t8oP9/eozPigfkZExU1NQImnk15F5VaMk2LnH66GWugEehwYNtYs75cJMPhR2zaDowqe8GUceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyEkZlnbsGY5pD17tsyyWrE93SLLUGJWrtjCSbHFWd4=;
 b=LSTNHeOm2xPikSUcxFlFbK+LgAd7ZBolmRLC6RaXMse3GZNhhxEToW0TJoYXdmjjggEE1AO/e9x1xr3m5Xw2RNDt6BkaTqWFG7gXgdZ6JmgTjw8DYhw/bj4k3IFn9xGld65aA/tollnYU+tPhMwS9Qim1aUCZ2/6necI+WBM3c0=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4380.namprd11.prod.outlook.com (2603:10b6:5:14e::20)
 by DM6PR11MB4513.namprd11.prod.outlook.com (2603:10b6:5:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 01:26:38 +0000
Received: from DM6PR11MB4380.namprd11.prod.outlook.com
 ([fe80::213c:2f71:aad:4494]) by DM6PR11MB4380.namprd11.prod.outlook.com
 ([fe80::213c:2f71:aad:4494%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 01:26:38 +0000
Subject: Re: [bitbake-devel] [PATCH] server/process: fix exit racing between process and thread
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <162D282190DD8FB5.7353@lists.openembedded.org>
 <9b28fe30-a475-2949-118e-1fe70aef4fe4@windriver.com>
 <0e45aff7dadff33243ae2590e2f813395b71f35e.camel@linuxfoundation.org>
 <d9f5d95c-1796-de85-bfa3-889c1ce31c2f@windriver.com>
 <83d152f2c66dad66c620d7a6063f7364533c16d8.camel@linuxfoundation.org>
From: "hongxu" <hongxu.jia@windriver.com>
Message-ID: <fceb31f7-e4be-d07f-7c1c-ed79b85bb053@windriver.com>
Date: Mon, 24 Aug 2020 09:26:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <83d152f2c66dad66c620d7a6063f7364533c16d8.camel@linuxfoundation.org>
X-ClientProxiedBy: HK2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:202:2e::14) To DM6PR11MB4380.namprd11.prod.outlook.com
 (2603:10b6:5:14e::20)
Return-Path: hongxu.jia@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by HK2PR06CA0002.apcprd06.prod.outlook.com (2603:1096:202:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 01:26:36 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b4078c8-95f0-4734-6d65-08d847ccbed3
X-MS-TrafficTypeDiagnostic: DM6PR11MB4513:
X-Microsoft-Antispam-PRVS: 
	<DM6PR11MB45137185C9C366EA5DCF31F394560@DM6PR11MB4513.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	64j6PkSg+QPTfL7vWciPVM0G9PajPRcYfmlYa6ucwwSajMxLRgX7DuQfofnclALuzD3Bv20zbLSX01pZsbIMiguLpPYYd/bLO1L4Z5lgo7YhuRnnkfxfXcMvNJU9CI5fC7HP/yhJ7XkqGEJQQ+V+L2PlMO3NYUctYIT3sx9x+r4VS8HSnqIrScLwOKA0c0eO/6ryK2gNoGpH5s9prkQm5MmGIreCeqcGw/W+1lLyZrs2PW3QBAAFS5dMjIPVKiWyMVYALeKpk0HI5Qqm4IsAF1+qMdBsZW7XjUXGWLyI635bjvJY6KpkS/JtJIzrA2LN6TpsRfyFRcJETuPeySy8ydAuaIRqljmxhwU8qb3n8t2X4jxWb3DxZclpDYCIhPO3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39830400003)(346002)(376002)(136003)(66556008)(8676002)(478600001)(36756003)(5660300002)(186003)(31696002)(53546011)(52116002)(26005)(66946007)(2906002)(66476007)(83380400001)(2616005)(8936002)(31686004)(6486002)(316002)(6666004)(86362001)(956004)(16576012)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	fOJSD2ecELpFF/o6B/5TZ71UK4vSoxDJmhg+0hszWZR+I4aG1sfuE/BJcBKoIRM/WDw5CSYGuk9RI6JRS1ruMXOQCM7hR4HhwmMjmiEyzUIznuRfUH1N2VUG0kmOr+PdF3Su4quCqmfbXybjxj9gkJ+CxnpGDDo5rIr53SWl0Ma0D/RxI/oPd3uF1GtT5KFztF96maU/91Gd7SZx9Dsl+5PUZ7kei7TqBgc+p+CNZ6z5xrVCS8rNJaxN0o8cob1Jd4ZV7dBVEvlUyqWePBQSAofDJQ1KZCF4Mbnyv1/NyZCzzOP67ugyWJEz9T1oguEhG60rzSBHK058BWC1kzMHo1qzPrp4+2pS/rrFiMFdQKCBeYmylSQMWKKfDjogmQZCQTCrswNYBr8zCxwvFg3pt1H0CabyPcX/hdWZNzBqKhYnKMBZl4hFmCiqrEX81+k2adnYn7dLF+dnMlwBqn+8l30r/PIZvyFzcnOQ7cvAdxC9fMoLu6uzVKAYsgNbcfOL3bt8ZkMfIBZTK6WdPHF5yxdpBwV5hIIRDTF0h79YI051oKOljRSfgXadAOoDnYra7qI9vJiDjAoRKWCNLcUihG0f6nKD504mAJ6dCFg502gPIss2fGbvr0gQAoXDBTNJmS/Pyw/yCvlzKFHVLgEatQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4078c8-95f0-4734-6d65-08d847ccbed3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 01:26:37.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZH0/OpMGLFpEPoQAHgF/xCgUN4IgiwINgv5Ltn/e5OG1YyG844S8vNsTJCEYmj2W/R7KU4FR44hijSm2yH0SwRtVooZD/9fPe6Xhaxonog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

On 8/22/20 10:19 PM, Richard Purdie wrote:
> On Fri, 2020-08-21 at 23:47 +0800, Hongxu Jia wrote:
>> Yes, after applying solution 1 fix, I check the content of
>> bitbake.lock,
>>
>> the saved getpid is the same with cooker process. But it differs
>>
>> with the log message in bitbake-cookerdaemon.log (the log message
>>
>> is before multiprocessing.start)
>>
>> So I think the fix of get multiprocessing.Process back is the best
>> choice
>>
>> we have which reduces unknown risk
> I don't like creating extra processes just because it seems to fix an
> issue so I don't really want to add the multiprocessing call back, we
> need to understand why its breaking instead.
>
> I went digging and found that the os._exit() call from the server was
> why the atexit and Finalize handlers weren't running. I sent a patch
> for that.
>
> I also realised that the write for the cache file could happen after
> bitbake shuts down. That could be bad for a lot of reasons and means
> Finalize and atexit are the wrong way to do this, it has to happen
> before we drop the lock.
>
> I've therefore sent a patch to fix that too.

Got it

//Hongxu

> Cheers,
>
> Richard
>

