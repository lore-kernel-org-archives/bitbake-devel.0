Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5957C433EF
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 14:03:03 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.92.90.34])
 by mx.groups.io with SMTP id smtpd.web12.12080.1636034583275845977
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 07:03:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=jJhLDNzQ;
 spf=pass (domain: outlook.com, ip: 40.92.90.34,
 mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGRY8zlZUamKw0zXp09UNAiOVEJSnzrUvafCyGknlXexc4aGDlLPANBHq01IKFdZSliFo58EvfuN6VNEkWATG5fXD1UhcnKr489xb4egCnp4gFQwPf814dFo6MrZIILBLuLcws1bMJeOJTtJ67NyL4qMpzon6G2pfKZj03aSzbNaoqcDn5zH7Gtp+3HG1l6VhCyrZR1OBmQHdQVL19fApW9vBKzKHQRjo0BJr+jvOwoq32kEGWgHNa2NP6z4+MZ28v2QZE/bjWYbVlpdE8oLjldBOrDf96sAnFvgHAOiFW/xvAbG/UI8N4ogfjijFqmx3FZ8vkVvqCbad2ZOVY9zbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dtaplr4qCmHmBHM86svZk3sdeql/a2c/E5yb4z5t3Cs=;
 b=Il9pcDYVlKeA1IzFrmEjPciYCjD0VFy78zzpdsqwDqjPdwItQ92eqCokD1/Ep43eC+RMX25yfh10gi31qI5fW/K1l0lSBxcX2sidRqcBF97iJKr5uuT+oN0bZ0K2KZM2ESll9PDSje5c1ovuvrAX89wRuq7ZzbWlsioApyUYdD0RSHYLFKwokGVQTzXDg36aSvKHD7ailsnGDejkjq8VIP+gJVx+18Cz5BivvEagAQcMvTqrskGsAVTbj504C1o/H/kQJHstl41yxtik74MobFBjZLAcyknQngArU7LWXDYFR2LwgzivJ7jVxmvzj0FrdR1UzRVQv7KQK7/02vPoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtaplr4qCmHmBHM86svZk3sdeql/a2c/E5yb4z5t3Cs=;
 b=jJhLDNzQqs4tcA8WRbWpoEdAj/622g2B6Q4GhwSxBq4EltV+CC6xrGU/9rhKSY/OHUQjPMNWiEHxZPE5lHiJ3jv5qmg8FEl+kjmWtEmENO29kFkbBAp2xgC7u8LwenJTcGpaqpbVu+xFWZOaruwUPeYPMZoi0BQrUS07ZX5JNk6e7mglNl/1XLczuKZHGqMHbJt7ATwVg5fAc1bSNYN987F3OtK3rRGLvoAQZF/Rx9XuTiS0iv2Tg1ZnG9LJXcqev5GQfBGkMeMvkfLYerHUrkUXETRGVPxlqJscRA6YQhTuixHhooP1KVPyYDT9mnwU35vX6FBhQ26gyqYb8YKs4Q==
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com (2603:10a6:20b:284::24)
 by AM0PR09MB2641.eurprd09.prod.outlook.com (2603:10a6:208:e2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 14:02:59 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710%4]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 14:02:59 +0000
Subject: Re: [bitbake-devel] [PATCH] parse/ast: Show errors for
 append/prepend/remove operators combined with +=/.=
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20211104135848.3621936-1-richard.purdie@linuxfoundation.org>
From: Konrad Weihmann <kweihmann@outlook.com>
Message-ID: 
 <AM9PR09MB4642D846F590EE6FA7CB00E6A88D9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Thu, 4 Nov 2021 15:02:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211104135848.3621936-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN: [Ud9gcbsREXqp45feyh8NxtUWDVr9T+mDWNF8YM+V5k2K19LOQCotYIWWu+dvYjpN]
X-ClientProxiedBy: AM0PR03CA0061.eurprd03.prod.outlook.com (2603:10a6:208::38)
 To AM9PR09MB4642.eurprd09.prod.outlook.com (2603:10a6:20b:284::24)
X-Microsoft-Original-Message-ID: 
 <73d12ef4-8792-f4af-c30c-047037dc9ee2@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:3103:205c:200:bed3:df7f:f488:16a2]
 (2a02:3103:205c:200:bed3:df7f:f488:16a2) by
 AM0PR03CA0061.eurprd03.prod.outlook.com (2603:10a6:208::38) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 14:02:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33fb4376-0d7c-4534-dd31-08d99f9bcef7
X-MS-TrafficTypeDiagnostic: AM0PR09MB2641:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dYTI2mGyWH+QqroK0rqI+CWv2skTTOZ6uLn1aOMGHLPyc8fEVrRt7cczs/eb8+tUeFqMGJplLv1mBqUKHSXmgkz9QADRziMF4JFPjpRdlVV8xUz2H1r6wjHJZlWtDqQ3qsHYPLqjj9ZV6Kj6SH9V+LwTIzfba/K4cVZJwEOb99y2xTo31q4suUrt44YZh5iHCctXTALQbJ3ikKN6/gb7urmv6Qpf+foKKpBlhD4FJ+GD71sEQZt32qKvvlcsKmAA70YyT4KgYl4kS9jd6C9stjJ+j5IddPBpSLPLFf2N8ogQEV2F6bFqbxrbTmU2Gk+iE3smNfOGsOuH+mxtMzZukzo2aLp3IrxCjZpCoAXu3kvwZ3BWycwFKYk49RZYSUZrh/TqObfKXUTUnqgYt2oJbI9AP7B1vvOLnCGmWwsdQ7kHX3Dg94gN1m98kgIHVYvyUFgjqGkCTK5YZSj8mDCKibQFWVGsURj4YKHR7do8VHlX6/b+z37Qcc6OM/MXlnG4r9qzYGTdyFIyLo0idnSkCXD0/EH8f9q2eLB3WC0YsmLinIsIJceTmTVFBDfpuIiENJNH2iO22sioEoSkyhxiCugghv5q6wEn5nIxhME+3Lw7ga82asgAWMGOwrK44a6u
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	cBhTcJUsH/Xtbjnaa1bAMqcky8nxqx1cgavZBb0YMervnnAUd/OQJYAIvo25wQsCYEGE4RNGE0pOdnGd2GFnelyKXqfUfVh/tn9KkPK6+c173akdanJQ2hcT+oVc//9L+CVrOwRT3RwJQrnEa3nTrzB5t9xSMMRehjJgAGMGuaSGeZkyV6H+yZo5FLYNsEASgfCBLK/yB7Wc8V86o8eg+SGwm79ophkDaOQuGQAyzvEJRzGJECi/QjuUD0QnwiuQOm4UI4Y9epLTPjQglxD4rwLRd0J39j7paY0Pw6ZYpUs3Ikwm3BRz0f5dyIsW3wUInGZGYnq0IgsmfihjAFZrpQ1gNRFhlqAlbeQgqG3AOk9PWq+19drorrP2bdNK0jzt0oJAQ7zf80oTlHxq2IHYKJCtMU+eq8ak9fdMsfjw2i2AXVskckqVWS7ynOM8gnPNF1r0tm1LFUkTjziLDWXcXcSblN5wjmp/vDuvLJR9NOEjMc9s+1wCTk8OFv26WeUcrujx2ILlMV0nmx0acYPv/UVIkyd8rVdYmVCPFvJvAEUomWtHc4WZRkLmcwcV4g8qjg4jNDhug380eWoQyzhyo6LLo3Zq6DbUnx5XuSyyLmRQY4hOfg3NhmzyHGnd74xgrX+dmbNiWgRkvF6ON47DFzyxSmw/mXMejzlQxvI4pm++izQJPF8l2U875bqMCNbkLAJ8HD174vjQLJTGYK7Wt5g38UZ7rzGS873E/u6oazolmTca0RSKZ9P4w1i4J9MYDmOSobvJ0nqwRlgAWvWsfg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 33fb4376-0d7c-4534-dd31-08d99f9bcef7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4642.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 14:02:59.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2641
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Nov 2021 14:03:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12878



On 04.11.21 14:58, Richard Purdie wrote:
> Operations like XXX:append += "YYY" are almost always wrong and this
> is a common mistake made in the metadata. Show warnings for these usages
> with a view to making it a fatal error eventually.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/parse/ast.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> index 743ea0dfc0..93cbf285ef 100644
> --- a/lib/bb/parse/ast.py
> +++ b/lib/bb/parse/ast.py
> @@ -130,6 +130,10 @@ class DataNode(AstNode):
>           else:
>               val = groupd["value"]
>   
> +        if ":append" in key or ":remove" in key or ":prepend" in key:
> +            if op in ["append", "prepend", "postdot", "predot"]:
> +                bb.warn(key + " " + groupd[op] + " is not a recommended operator combination, please replace it.")
> +

I've seen also weird combinations like

append:remove

with multiple contradicting override operations out in the wild, might 
be worth to warn about them as well in a follow-up

>           flag = None
>           if 'flag' in groupd and groupd['flag'] is not None:
>               flag = groupd['flag']
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12877): https://lists.openembedded.org/g/bitbake-devel/message/12877
> Mute This Topic: https://lists.openembedded.org/mt/86816155/3647476
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [kweihmann@outlook.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

