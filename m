Return-Path: <paul.barker@sancloud.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB80C433EF
	for <webhook@archiver.kernel.org>; Thu,  3 Feb 2022 15:14:48 +0000 (UTC)
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (GBR01-CWL-obe.outbound.protection.outlook.com [40.107.11.105])
 by mx.groups.io with SMTP id smtpd.web09.10352.1643901287159465263
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Feb 2022 07:14:47 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@sancloud.onmicrosoft.com
 header.s=selector2-sancloud-onmicrosoft-com header.b=DyoPIXrl;
 spf=pass (domain: sancloud.com, ip: 40.107.11.105,
 mailfrom: paul.barker@sancloud.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG71WQXxLtMXijX3Fo9agORyksfwo3mv0E/bwVV6LesaowxiHWbX1II/xuVxrEzgkW+6B5GzyxBkWSXzOibj0Ez5MCMXslLPLzg7rU6T6oLWE76PXdvNquIG1G9buR7+YkN6GHmcMCGo7pStzu/0mFZeJXptyQ5Kv0NlvHP7w2XayoZNdK9QIqUNZfxjE9NvcrelrcV3NyUhawvhu59hnksFwbUcTvuJStBdB/TfwejhafFfy5ggvT5dJyFNPdU6+yGvTU8nVNwYh1mQGjIige7CmM9kFlvIqQxRILbUIY0L6lMqYFu/W232Src7F/s2h8qIWX44tcSvHSLRYa5CAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axszBVesdTHP8rLvKiHkQNFUAiy7HXBHEpi0S1Z5rUU=;
 b=WGIYdW6W2/RjgevOa7VcB00yJiIwIP1mQuexaaeUZ8r1mPdp0I3Qg6Pm1pOo7mfQ3r1q3/XkWFTkax2NsoYbf+8npPubQwkh6ICNMhL99bJSFGvtNxlTIztSVTn9vNvMWvL3HdKWchuaHUYb4SQ4/UGYMai0feXAQGIjV4zJ+rmZoqXzV4S0LKbSRHepZxdUYcdlXuzwxgL53NEQNn26Glz2jfV8FJ8qKqTDDkGFgpMlWtr5n1pMesKowmgyOjT5kRg4am0yp6yo75nSimx2ZUwDnODhwIVWIn7mxAz7JHk22GOA9282T4uP07iwIJ7qCMRjgEygGjer6MX24mw6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sancloud.onmicrosoft.com; s=selector2-sancloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axszBVesdTHP8rLvKiHkQNFUAiy7HXBHEpi0S1Z5rUU=;
 b=DyoPIXrlBY3+1L7McwJ/EQ5OcvA+lHZ/I3cv2gW40eQJae40sHar5B/NPHD37+xp3MYfntcFiBBQo/WFXeqvSlSY64LDt98CRjLuFpRMpcGfty0Fl/a/BDgwMnayyKUPoEQD+1IIIX5UfGmQT3phcLIHAv2K7Y83KXA4Rrknxhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sancloud.com;
Received: from CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:61::19)
 by CWLP123MB5370.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 15:14:44 +0000
Received: from CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5d88:2deb:7b9b:838d]) by CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5d88:2deb:7b9b:838d%4]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 15:14:44 +0000
Message-ID: <4f74226a-9a69-3b83-52ce-c6447d09add4@sancloud.com>
Date: Thu, 3 Feb 2022 15:14:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: build/conf/local.conf ignored
To: valerio.di.gregorio@huawei.com, bitbake-devel@lists.openembedded.org
References: <b7ie.1643894227515340279.b554@lists.openembedded.org>
From: Paul Barker <paul.barker@sancloud.com>
In-Reply-To: <b7ie.1643894227515340279.b554@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0082.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::15) To CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:61::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846350c5-51c7-4f7f-e625-08d9e727e8c5
X-MS-TrafficTypeDiagnostic: CWLP123MB5370:EE_
X-Microsoft-Antispam-PRVS: 
	<CWLP123MB53702597FA49069EF5BE19EE93289@CWLP123MB5370.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	h/tKaRRn0OIpXiOyy9eeVeP6T1IZ1J2AF72cnrGRpj5LXsztsV629KNTkU/r5XxwxA+Jx/M+vejioI1o0l7h8dkvJNFjrz3AgHU1ORQNnrx7FMDULf70yMwMdI8Iz65v7KzK9sKCXZx8pYqyJs2+q51Qx+u3Vp8wRRQGZawEiH5dpTKBaP7KRmKYzOl9BJC3sxLPtKhkA4DoFHMYx9SULI80HE2YYPsCvyHkNPb2tBNnCwtJrsNR+VuvS/TLqw1DEIf4ITTUlWjNXaQ2DKiA5GgELlmvm8Tmag83iBFu6WfsV8/pMATefJT8t347Lmg6w0XSwTxp94VfZAOt/7aEgI1qpg7s/fr+hOKz1Dm1YxslotxThZQFktPnsRnhJz4Jiu9xlPwL8z9wJUlRJCQPrDmgSMopeGSqrzaHWz6jNQodIyz5uAAhLG8TqQfT4xx98o5SwyGIyi6r8W3Klybub/Q02y+i5Pwh0MZbqS7qQQ6jk7P2LhaWRq6BoclWf0w9/ikSJfgtY37ah+R7hLVchfvk6CqFCC6jZbkpQH2CHyN7TFEzwuwAc7weeEojrPhW4k+R8BTp1/fFJVd0brPg2X0V9RNChaUxV4bY9GLGUgs1wGv6JXH6dgXLSrAGk/27jqvKcVocwbHI6+UhV8qCeo19r/b+Hbc6dd9rOsD0F0aqO0e4oOFBUcWetlSBCoLfH3v8/PQUvtR7Ckimr4sJhgjh+xei9UpFo7fykonbX7pQduRSFn1L1W8/i92l3bAoDPNS1cZYtW1vRXRdWQm0bahfncY2l8gFITTuCe5HbyK/kdeERXeqzO3YVxd35ovdtV54M0V8lX06nfZ4XhshPB9wRB4mYSPI6kjkM7gsi/0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(366004)(396003)(136003)(376002)(346002)(66556008)(66476007)(66946007)(8676002)(8936002)(4744005)(3480700007)(2906002)(5660300002)(86362001)(316002)(2616005)(508600001)(38100700002)(31696002)(38350700002)(44832011)(26005)(186003)(6512007)(966005)(31686004)(6506007)(6486002)(36756003)(52116002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GkHdbdXn1xGGejh97MkpCai7yfGD0c1IvRn38lN6HWCHCAjUVkzWtFlovbXf?=
 =?us-ascii?Q?xqb9fR5OYC7VhjWMi4rz+WOEw/0BjW8ZeTYYZJiGt5tqkFwPeaQnuIlrl+hE?=
 =?us-ascii?Q?EicpA31pQ6i/B0WeXyQcSaZdKV2EXYpUy9u9XptpxaGapCvAASmCFqY4vngD?=
 =?us-ascii?Q?owqY4BE5FTkelM7OVSeS1Y0KIs0A7Axq+ku3Jtr/wvGPcVlnwphNLof0sJwd?=
 =?us-ascii?Q?WOg+luaiV44AS3gKJckTTQvqjU9G64dWzi/O6fBzJbYscNmnyb6N/15VxEjI?=
 =?us-ascii?Q?mW5lZSBxOOi+j0ZmJamy4hLvwwm5kEkDH2y3pGp0uQnuLc/H+HNE/kGFbQ1x?=
 =?us-ascii?Q?/FEjAuBK749Vk+FipQm2vIdrptgSCrhzrrA5rAd3fd1JRsIJp8+Cd0Qcdk9b?=
 =?us-ascii?Q?Fgztz7taswYwokH6ZhlmxIuIrM//UNH1a6t0mWGa/5pXbk0k4zrIuIyN1beG?=
 =?us-ascii?Q?AtfZL2N/GWl9lHZhfrFPjzRstDkE4FghdDjh+gNHGdrdaR1EyZkBP7HpMwS+?=
 =?us-ascii?Q?zr246J9B7atZo/L0Y+YkSjLbvnlYrdW9RdnulYC1kt+w5ya5igW6x5QNuhmC?=
 =?us-ascii?Q?DvE/lklAuUZ42Gds4pU9jCF7xM4tTW+pJInNh5oW/vnksiDgqMUXN9rrnn7J?=
 =?us-ascii?Q?GUSMoBXioaBSlezz35qcMp7Vj9DJSo/v8afphp286/TYSSEGW8gGQqP0r9ru?=
 =?us-ascii?Q?ZoYJ2BOfGCvqbXZqHSAc1ptLXe3N7jousseQC+7CYGHcGSXscB1MsUXCjDGV?=
 =?us-ascii?Q?uQjXs/+w3XFbVBVnUvZUVvxHLin9jN7m0Z86UGBAWDUsIoDOSH0fnMAPWcnK?=
 =?us-ascii?Q?cxbZd3En2UqJNCGWi/6PdDk/KTTEFTcuUkde46Y41R6t5qUKbXhbj64jwgKW?=
 =?us-ascii?Q?tQkX6mRa2aWa/ezOsoVFTJ0etL/CZ2+uy0xpagqr9ufYRCWA8Pd+Brquyuh0?=
 =?us-ascii?Q?o4AW9kx94RdDS4TiTJ+Jkw7GclPwtjgZlnbpSuPR1OHweqt4skTho9Ojd9+U?=
 =?us-ascii?Q?9jVRi31T+eS3AJxQWhcSeksYF2CXo7cjbIAmrpriUv3hFZLnnXA7IL7LJLrx?=
 =?us-ascii?Q?IM7tX4OeAKjrsSZ8wl8f5w5oeDz/yqgd8y//E22Pb0xYks/FJIegCTaP8jCg?=
 =?us-ascii?Q?h1vyGAh5klpfgIo09yAYXk3N4pffmJFAaFaESZAsRw5mA6d/pn6QUkDpxp9/?=
 =?us-ascii?Q?xkiSyda7kSdbE2MnMvRlsFgst7KyjQPLwuvvK9FatX28u2310tg1H6KWmUaM?=
 =?us-ascii?Q?EXcccMSITs+X01rwqsQ5eCEQAvXG1fH5xVENvURW8FWENUV9mfhVEsVixbao?=
 =?us-ascii?Q?XSM0q8UA/LS7z0cBwNhf0UvHtjAstDl1GXCeCwV5VRyYrrfdMpOEkqUtqGD4?=
 =?us-ascii?Q?2Fy8ardlYoGOcgbPc61f4VLB6e8+Ymd4qY5DYBdF+A+g+POMlrNwNCUO7VQm?=
 =?us-ascii?Q?/gWc34jsvEf4/5Iq3cDA20nGaGdpn+uw79+5s/kBrNVWKbeE99oAbHcaqAys?=
 =?us-ascii?Q?Cv0Es4JpXhEfuzIFOh/qP9IoLs62rzsE8Lu8DKjnD0PyaKRs9I0deWWttiaA?=
 =?us-ascii?Q?LMibFL+eS44Z7AO2DMKYduHCZmaTjP8KXWBVE+1yn27GWFClFBvhFcgfKF9o?=
 =?us-ascii?Q?fKhAb7xJv81cupAoPGbhIs0qnTUsZAv1bKDKZ7naIdgECnRNRWCxuGgcFNg0?=
 =?us-ascii?Q?mOCrZw=3D=3D?=
X-OriginatorOrg: sancloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 846350c5-51c7-4f7f-e625-08d9e727e8c5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 15:14:44.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 840be37c-244a-450e-9bcc-2064862de1f4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 uLRcBYoKeNxD0mTFCNvhAJLzOdFNKryxTHr1iKw/SK0wPcF8Qup/108j+P/cEGhkTT4NjX7jjOheVvrZbx7ni83/hKMe3ZncWwZeTJyfx4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5370
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Feb 2022 15:14:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13310

On 03/02/2022 13:17, valerio.di.gregorio@huawei.com wrote:
> Hello,
> I'm new to bitbake. I'm trying to use the tool in a brand new=20
> environment (no yocto, poky, etc.). I see that it ignores=20
> my=C2=A0build/conf/local.conf unless I use "-r conf/local.conf" and in th=
at=20
> case all works as expected. Can someone help me understanding why?

If you're using bitbake without openembedded-core or poky you'll need=20
your own bitbake.conf file. If you look at the bitbake.conf file in=20
oe-core or poky you'll see an include statement for conf/local.conf. So=20
if you want to support a local.conf file in your environment you'll need=20
to add a similar include to your bitbake.conf file.

Thanks,

--=20
Paul Barker
Principal Software Engineer
SanCloud Ltd

e: paul.barker@sancloud.com
w: https://sancloud.co.uk/

