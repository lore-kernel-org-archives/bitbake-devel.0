Received: from EUR02-VE1-obe.outbound.protection.outlook.com (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.113])
 by mx.groups.io with SMTP id smtpd.web09.10551.1603103139994877289
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Oct 2020 03:25:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@prevas.dk header.s=selector1 header.b=I5GnPEKt;
 spf=pass (domain: prevas.dk, ip: 40.107.2.113, mailfrom: rasmus.villemoes@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnTXlhnI4ire5RtqPiF9Kdqy91wSDS6BY9uV4IJZ+rLsJxi4ynB33M4tlXhcznaFU2Ce9Uot9HgBSHRYX4QoaupWWRyUqXHbD0GBl9nPqmQ4vOzaL13swLXz7L6RTly2rWFb8aLZCuEky5nPWO/hs4BwEmzbCKdTImFydw9kct4WD8YH5eBigKSk++Q89gfmNvVf5siNL+pOyHsfMpwXe6mWcX/APt4KaniBAIT5ch5ahioLwa3mYGttFAScDlQCxCorYlkNz0tZsidd1gLwowsIcqH3r6sgNVgFySESPHlevGPa2fqpi90skgxCgYedOHz8xRTsHtusWLL/pdoxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VZ5L8mENWYZRgLR1z0FguJ/BokVKU4OMO6CFRn4qXc=;
 b=M9oTYrMWZtHNiUFPHzJATtGMMf0PjW2JZLqOoG7eXagR2gj4v+y5W/ckxQD4kYrKG8kT7x1kGfRTYabWrdJXhR8AHjJi+LPmAALOJ5GXNErQPP4GsyhEgxPdNYFNs3Pe6PosUWGy9GTvRxz4f1hWPKDUk6qVv3U0/fWU0mGG0hgfZYt6Be8zSfiJMP0DDYiUQ/b4NC5r4LPYZgTQ/89usrZFibcVi90EQQfIkQIePucovEj/lUo0R8aVaolABVRlztOfAYB8XHAedW1JH7rq1ze1SqIkh29Lc9YQDtNg9S4EjvdGYHXPyso5nFqCvWd5ZctXA+dqPQVEfrlkH2ozqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VZ5L8mENWYZRgLR1z0FguJ/BokVKU4OMO6CFRn4qXc=;
 b=I5GnPEKtGdQt1nXd1/R3WV6pLbf+Y19bkPHyLSpChbuE6JpuNtOMBDI3UGw98Ytg+AQ4GaI0CjBP6q4+lnGz1/UtrCQbvS59wZlkIEyMKHb5pEJPtJEb9sMhkWa0Xahw0i42ZNKX+h78nNnhoaSU3O7SvpsLMoEMcfUhM7MOMoA=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB3250.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 19 Oct
 2020 10:25:34 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 10:25:34 +0000
Subject: Re: [PATCH] fetch: git: add reference parameter
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
 <5654d90cef29064a898f279d73c6deb6f6f91052.camel@linuxfoundation.org>
From: "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>
Message-ID: <419c5a91-a38b-5b87-31c9-b1dc72adf1be@prevas.dk>
Date: Mon, 19 Oct 2020 12:25:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5654d90cef29064a898f279d73c6deb6f6f91052.camel@linuxfoundation.org>
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM0PR10CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::29) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
Return-Path: rasmus.villemoes@prevas.dk
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM0PR10CA0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 10:25:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 927db97c-877f-4139-96db-08d874195030
X-MS-TrafficTypeDiagnostic: AM0PR10MB3250:
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB3250E4F8C8BE6BF7DDA9C6A4931E0@AM0PR10MB3250.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jUEbg6vfVJ6riYcBJ/ybycCR0FD1xEZKsDd/PHXLbD+P+iMQgnRf3aqs3VVH06YVDepZi8q9MMF02TJSoXfDJ3ejw8sUKTR2xDWmZUz+PQGV5kon6+VJVH99TrWYBo+BIWNsQu97jPtK31Mjw5t0uCbUxiSQtDBA6D7Svbcyufl5R3ryDdUdl65R2de1QUtn8dDSkbWmYxE6N9pgLKfNvhOtvJmu0Y+EkRkyZX0a1+WQLrUdi7VdINwgCpI915q1sKC49Q09g0vyD8Ac7W9XW5+NoGlYkqzBdZpAsaeLq6l1DRMe7LylxDN/MtPRUc6qHcXkMThePGHBCCUMPOcbdNWxVEK8pllVNt581cHjsAqV9rux+mIx0pmPV+LRZZqi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(39840400004)(376002)(86362001)(44832011)(956004)(31696002)(8976002)(66946007)(6486002)(36756003)(2906002)(2616005)(186003)(26005)(8936002)(66476007)(66556008)(478600001)(8676002)(31686004)(16526019)(5660300002)(316002)(16576012)(52116002)(83380400001)(4001150100001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 
	1tuFo3L7aUlp3bgNbeMIFN4IhyHVRCKAXtLn9svpCnDD8b7Vg8UQITXM/gV5BkX3iMI24g47j4zvhJga4snLUZkS89gWOxVYbHmsB2OLlLrMRRWoopT0Xm3qiOuv9t2nHjiezI7yJ0aRAktPbQxRBl25APByu6n3xQ5ArtcteaxYTwz6GasevIQilZ0UWxEeokRoUHCZII/uVPd/4wE6csKeZuhP2dAyirKS2wsB6RBPOzJRsujx2IS+PaLGT5f0iuCxblcbKh6H1vHkiKzcXq2JJwuy9jMfaT85b0oSD2QHD9Oae7Rtd7OPvmZgYzL2Mx7KBLmMowJQkdsdt/hSzpfe+oKDFbalVwlq2Tdd8OCY0BhVJO3qMzD0cejK22CYYofzMGsVgSDUy+eFTf9M7v99tOhzkphfOB4bP9NKiTPkxZkGoNO4CcI2aq5NSy686qkkz+Fsu6LZJXs+7TkA3NXj5a1d2VpT5tjr2vVqRsubU8JUyUR1bkx3HIlzRUi1vK+a+4L57AuDWfWAZ7R9ap5U0QQcydNN6UTWNG7gAm0LStNpKc/4yy6uAmvTnso/Gws5RagNneEEOb9MPdsM8b+txXxM/bmX0wT96iuT5qdoPOrSxUJj4DipVPa9kPomXA+IxkmWVZaq90/T8nC43Q==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 927db97c-877f-4139-96db-08d874195030
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 10:25:34.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOxGsu7iZ5yHj/pWCD29yGStmpjjwjw6EE2ELZoNu96eK5OBAjErnbRr1VuMcdfe5ixBB7VX3Ykq447f8YK0I14DVrYvpNFxa+2nMCqRE9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3250
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 19/10/2020 11.09, Richard Purdie wrote:
> On Sun, 2020-10-18 at 23:33 +0200, Rasmus Villemoes wrote:
>> The --reference(-if-able) option to git clone can significantly speed
>> up the initial do_fetch if one is able to point git at a local
>> repository containing a large number of the objects that would
>> otherwise need to be downloaded.
>>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> ---
>>  lib/bb/fetch2/git.py | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
> 
> Whilst I can see why this is useful, it is going to end up causing
> problems when you share that recipe using this term with others :(. I
> don't think we should add API which will cause scaling issues end
> "encourage" behaviour which leads to problems.
> 
> Clone by reference also causes problems for the archiver.

How? Note that I unconditionally add the --dissociate, so that after the
download, there's absolutely no link between the referenced and the
cloned repository. Also, I use the -if-able variant which will just
silently ignore the given repo if it cannot be used (often, because it
doesn't exist). So I don't think the presence of absence of ;reference=
can ever affect the correctness or end result. But see below; I don't
think any recipes should/would ever grow a ;reference= directly, as it's
really a local opt-in optimization, so the recipe should just be written
to allow that easily.
> I have often wondered about this issue though, my own thoughts were
> some kind of "keyword" system where if present, a base repository could
> be cloned, then added to from the original upstream. At the end of
> cloning, revisions could be pushed back into that making it a kind of
> mirror.
> 
> So yes, I see the attraction/need but I think to have something merged,
> it would need to be more usable in the general case.

By far, the biggest pain point and what we're mostly going to use this
for is cloning linux repositories - those are usually at least 2G in
size, and every project/board uses such a thing. So my example is based
on that. In our linux recipe, we have (simplified)

LINUX_SRC_URI ?= "git://our.server/generic/linux.git;protocol=ssh"
SRC_URI = "${LINUX_SRC_URI}"
SRC_URI += [various .cfg files etc.]

i.e., we have made sure that the main component of SRC_URI is its own
variable, which can thus easily be overridden from machine config or
elsewhere - when doing development, it's nice to able to just put

LINUX_SRC_URI = "git:///some/local/path;protocol=file"

in local.conf (the branch and SRCREV are similarly defined via such
LINUX_* variables). So I was thinking that a LINUX_SRC_URI_append =
";reference=..." would do the trick. Alternatively, I'd rewrite the
recipe to read

SRC_URI = "${LINUX_SRC_URI}${LINUX_SRC_URI_REF}"

with LINUX_SRC_URI_REF of course being ?= "". Then any developer can
just set LINUX_SRC_URI_REF = ";reference=/my/local/linux-tree", and our
CI setup (which, when asked to do clean build, runs with an empty
initial downloads dir) could similarly be taught to set that variable.

Sure, this is all just for one recipe/repo, but (a) the user would
necessarily need to provide such a reference for each recipe making use
of this and (b) there are not really that many projects whose repo sizes
warrant this, so it's quite manageable to tweak the few recipes.

I'll also note that this has been a bigger pain for the past few months
when I've been working from home, connected to our infrastructure over a
slow vpn connection. Nothing indicates that things are returning to
normal any time soon, so I'd really like to find some way to reduce the
necessary network traffic.

Rasmus
