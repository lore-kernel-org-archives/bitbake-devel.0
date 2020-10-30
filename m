Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.124])
 by mx.groups.io with SMTP id smtpd.web08.14909.1604070409405230097
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Oct 2020 08:06:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@prevas.dk header.s=selector1 header.b=HSvhr4i0;
 spf=pass (domain: prevas.dk, ip: 40.107.8.124, mailfrom: rasmus.villemoes@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnlZDXWfur/Dw6SmbprDlWu8LrAheg6ywHd8V70n0l5pHon/9fvTT6Cbid6qM5pUMa2cCZVMPEImF7WQcud/3I+FGeJjTqPq1aBnPRKTeY3jRM3lfTfP/30BAueqDX4HH+ZFQxRSKz/ne005uwKTfYprANjdYANV04TV/27NPQ9uDmY+x6cocClsiLgGW7rTlbwQkCaV6dxn6L7X/MjiwadRY7Qj5eZd0hEHCh48jD0JGiS+Jz1tZtiiaCo/2MCkBBLgcA3v4Ay3CnDOJ5Lp9fpzNrGdRE2DeRsiehyp7Qa5JJs1QL1bUCkiVgysKD3v90AK/YzS5mqOqM8QZ06Wog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOuCO9Qjolrzbn+ClxuEGuS9e/6tY8ocVG09jQkKLK0=;
 b=kPWk0D2TXjvrv/qEmOnwB/8ZbVd4sOpf8ZD9vDnz++YjpSZZ318hnd/rA2kIdpaniYnwrAGbtiX4qAumanPDwNfPdkmMk0OCztiiRsvhZPscy12Vpvb8G6UENN2ndvfLVs4QKcyf4Y5FCDJIVMQWjALlA9tTc3gV3UUrz8CsF+pfD+c6WB3pf05lbgebvrzGNhAa8eL1CsnRjq01uGMV/eQaGfIMUZf/Bcf4LRW4Z44ClL9HXZFdiKrn0WAtmiuoFpefoDyMOWQqFNE8yhH7lEdAWL442vnLrH+wU1wTON52nfLZOF+pel2LQNallfdyNgtYBgqCBFDHREr/pKMjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOuCO9Qjolrzbn+ClxuEGuS9e/6tY8ocVG09jQkKLK0=;
 b=HSvhr4i02yxWmP/YTia5eBlP5A9Sy+HygxALfV1LkUJWW/SQsvXHvCBV0NuN5xSzA4wMTFdpGp97XzueqzqzMsC2oiJAxibmHpzURL7sE2W3TnoZADhX2VWc1CfkSrcJgngnPF2nsWgcAB9hJ/Jjjw5COz7bJNRXkz5dn3969o4=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM9PR10MB4309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 15:06:46 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62%6]) with mapi id 15.20.3499.024; Fri, 30 Oct 2020
 15:06:46 +0000
Subject: Re: [bitbake-devel] [PATCH v2] fetch: git: add reference parameter
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
 <1640541B397C8D4C.8847@lists.openembedded.org>
 <f1b06485-fc60-df76-f6c5-7973727f605a@prevas.dk>
 <7bfa5ef62fadfad8fbb778f0ffa64920826e624a.camel@linuxfoundation.org>
From: "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>
Message-ID: <4666e4aa-fe0c-b3d1-7ec4-f5d1e333a886@prevas.dk>
Date: Fri, 30 Oct 2020 16:06:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <7bfa5ef62fadfad8fbb778f0ffa64920826e624a.camel@linuxfoundation.org>
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM3PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:207:1::13) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
Return-Path: rasmus.villemoes@prevas.dk
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM3PR05CA0087.eurprd05.prod.outlook.com (2603:10a6:207:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28 via Frontend Transport; Fri, 30 Oct 2020 15:06:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d45e132f-f56f-46a0-f43c-08d87ce56b6b
X-MS-TrafficTypeDiagnostic: AM9PR10MB4309:
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB43096A84CB07BF05B30A258093150@AM9PR10MB4309.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	74kOV0jVL3aEgRu2KZIFcUNTiOWff+DGtaa7X6vf6pH431eUzgci23Nlj+AUj5WRFFAxRW0o5d0papoRrpee73tzpKvvGgpo2F1h0qf43n2B8HQa1krqGy3rxVZZjQA4ZIZavhMQAL3u00FHdSk2H1Yc0leT0u6dOPSYFtdqC3Y1w5gPptN+VZNtX72JAptRW5jdSayG7aFScUAKT2thZ/miCAcMr3NBNeZCrXWPZFWpy4Py+LraBzwhbzNdwgkOtdTR4XyiXO8Q5RRvqcVaseytBVo5TqlwBq6eR1c8JtBWizSFmbVQFL+BUXZ0LZA/oJHQDNIoZRON4xHRVxq5WRtU/wJHvfrCx4XkSIU107IVZbtIZB/Ev9MELsrZG5mp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(346002)(376002)(366004)(136003)(4001150100001)(8976002)(6486002)(44832011)(2906002)(66946007)(2616005)(956004)(52116002)(66476007)(31686004)(5660300002)(86362001)(186003)(83380400001)(31696002)(16576012)(16526019)(8676002)(8936002)(316002)(36756003)(66556008)(26005)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 
	t3wuZHJBsqlWWRS9EywtYseWI2Q85bKQuvoQ2RWB5iiYYUpz4F79GDfpUGnfa25euCge/A7WClVRhMr5vBqKkjR618UFk9e387HWLdPdXfaKnANv0S9Nwt8k/QOoG0fAdgwUQD1sAIS3dbOvGxcLyf5h1x3qA6Rr970IJIZeBZJF/DbtDz7GOru/gX2cy1Y0iTq/KcFVFKizXgnNO8XVIHQhxDmNDQnr8VKSjHRQjN6fxNYiHaxcFE4p2dXJDROuqq/tM9s1HYH9Cj6SPE2QV8m1Da1B/LIEfObAeq9JROaq9qSM5GvFPZc1Aa1GV+XranBHJz09Zb5LXUviqBUQ28kJ6Kc0d6TVso2WcszfTbqHqzw1JR/JrHVUTRGe9QJkEkerGFr0EKIyxrKNyTor1JGDKhg7cSWF0hCRYWhqX3558gDZGdxd7H6rZpsDo8gGIILRUeTVQ4/D8y1l2lXpOJWiTgZlnnSU7OimWziDwpsyqaEXwAcmEvCFg1maaHPYHS7Rxzdm9+0zgO1Yh7BvGJZ133efXfRNOH19GevAQCET+W8LYYpG5DRtRr2WEqTUutZeUCZg3BVzQITJ8itBFDRI//G2hHZ8L8xJmiQ6x/KRRauIzIYcHopu0SAjvw7Qz9l4xkoW79UqZKh4uBcCZQ==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d45e132f-f56f-46a0-f43c-08d87ce56b6b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 15:06:46.6276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyTj8Syj5MFmXjXb8cI9Yu/wskAz7kvxKnCkBY46a4MooJ64DCnypvBzSMtuxSksYf1JhFDD+TxE+dkNpIpKghhoEE6gnEdX1n6bQYDRu9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4309
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 30/10/2020 10.39, Richard Purdie wrote:
> Hi Rasmus,
> 
> On Fri, 2020-10-30 at 09:52 +0100, Rasmus Villemoes wrote:
>> On 22/10/2020 15.38, Rasmus Villemoes via lists.openembedded.org
>> wrote:
>>> The --reference(-if-able) option to git clone can significantly
>>> speed
>>> up the initial do_fetch if one is able to point git at a local
>>> repository containing a large number of the objects that would
>>> otherwise need to be downloaded.
>>>
>>> Allow the developer to define a directory BBFETCH_GIT_REFERENCEDIR,
>>> subdirectories of which can be used as keys for the new reference=
>>> parameter to git SRC_URIs. 
>>
>> Is there anything I can do to help move this forward?
> 
> There are several things concerning me:
> 
> a) no test case for bitbake-selftest

Agreed. I tested it manually (simply observing that the do_fetch was
much faster when a ref repo was provided), but I'm not really sure how
to translate that to an automatic test.

> b) no update to the git fetcher in the documentation

I can certainly copy the text I added at the top of the file to
doc/bitbake-user-manual/bitbake-user-manual-fetching.xml, with the
relevant markup added.

> c) the functionality I mentioned to make this more useful to others is
> left as an exercise for someone else

Yes, because as I said, there are some questions to answer. As I don't
personally see that extra thing you insist on as being something I'd
want to use, I won't even try to provide the answers to those questions.

Also, it is unfair to keep stating that this won't be useful to others
in the current form (though I do note that you said "more useful" here -
previously you said "I'd like something which can be used by others" and
"[...] but in the general case I'd like others to be able to
benefit and use this too.").

> d) the maintainer is apparently misguided about c) in the first place
> having taken the time to try and explain it

I don't know if you're misguided, I merely pointed out that there is no
evidence backing the use of phrases like "most users" or "In the common
case people will want". Sure, _some_ people (and that may, in fact, be
_most_, I don't know) may also want to push the objects into the ref
repo. But nobody gains anything if a ref repo can't be specified in the
first place.

> e) we're in the middle of a feature freeze and release

All the more reason to try and get this in shape for inclusion into the
next release.

> If c) is left there is the risk we find the interface needs tweaking to
> support it and we become a little stuck if the functionality already
> merged.

That's a convenient argument you can use to refuse any feature that is
not implemented to the full extent and exactly as you would have done it
had you had the time to do the code yourself.

I'd argue the other way around: If I implemented the "push the objects
to the ref repo", thus implicitly answering the design questions that
need answering by the behaviour of however I managed to do it, we'd be
stuck with _that_ behaviour alright, even if the choices I had to make
were not those that would have been made by someone who actually had a
real-life usecase for that part, and thus much better insight into what
would be reasonable answers.

Rasmus
