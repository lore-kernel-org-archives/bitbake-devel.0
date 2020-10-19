Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.96])
 by mx.groups.io with SMTP id smtpd.web10.11820.1603109523272659888
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Oct 2020 05:12:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@prevas.dk header.s=selector1 header.b=iO/ByHfO;
 spf=pass (domain: prevas.dk, ip: 40.107.6.96, mailfrom: rasmus.villemoes@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dz3Av7YRTYpqbn3R5v8P9AV8I/LyPtJzS2BmL6U/g0yQ8FmSIuyKWk+Y9J+GB/N0hhrXsssz3OZOIPQLHW0KolTNX4GvDZh9vrHX/KlYbYrx9otThtlMO8/7jQ9VHWXt0AS9rHpH1yfDhK6hq13eJs40/hyXNGXuB57k2rbDtJZ6lGv5CcqDylLgQl/uzVYsoiB+BNmJ4N1RSOckHEgU2FkwZqEPcJGB0DIDzAoKI8/fg6H/M/zSgrvS2ezujdPzEEljdF36nBbGcK1U0fMAzoYEjvPnZn2qjZIWdvNkbMohTWIV/zE06Z06dd9e4lUZwkjRyNOoM7eO8gUgnPubAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1ssLD8x+Mhw92ygdKKsYJ0yR1U4ZoOlXj95CgO9FZc=;
 b=f77zEXEWAsT7t83rR+bv2gAzSMxRD8zMM9sFWnfYP8CbT67yw6eF335pG0z3+vu5KUJsM758u6NgSBCLrvghh6EnH1ZEjUqDCp8WRDhkbgqf34P+iiNfDMjfZXhreqIbkOdTnm97iCxpeZQmf1gGihZmWkYfDkudpridOORnsutLKuZo/m4+wuCYhCjbllXTmCQ5oKJ3kEwzzPf7JosczdExzgpPX9iDG33/eHvn3kqRVe/1vA4m3eDXOsDzyBHsRLTEd3zemhFo883dDZ/G77CTkNKKT5nv3vh3/ILN90qcTBReISZOIjP+fzXDQUDbbaa+fGQGYqaFos+YQzn/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1ssLD8x+Mhw92ygdKKsYJ0yR1U4ZoOlXj95CgO9FZc=;
 b=iO/ByHfOQVGvKanUw+MpBYBi+WATqNIa6uxfdmtRxJsy5eaYqrA5NGdaiXTjavldOlo//30taZJSJl6E6SWUT2vyow1yRxQQZVaRZsd7JOuKEE6IAdM/zfZ6lKsGNbCo7awltuZJBqbx49zCdvc44pwQUhTTuNahUfu1TgKEBNg=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB2355.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 19 Oct
 2020 12:12:00 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 12:12:00 +0000
Subject: Re: [PATCH] fetch: git: add reference parameter
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
 <5654d90cef29064a898f279d73c6deb6f6f91052.camel@linuxfoundation.org>
 <419c5a91-a38b-5b87-31c9-b1dc72adf1be@prevas.dk>
 <5db6530fb6bf4bb39c9e5bbe4b44e57fb30c02e9.camel@linuxfoundation.org>
 <194b0b91-dad8-e355-b290-e27141995d6b@prevas.dk>
 <0b4b27c9446be03e2bc6f9df61345b34bafc8721.camel@linuxfoundation.org>
From: "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>
Message-ID: <7190c343-b802-8f3d-4e38-7441a917ff0b@prevas.dk>
Date: Mon, 19 Oct 2020 14:11:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <0b4b27c9446be03e2bc6f9df61345b34bafc8721.camel@linuxfoundation.org>
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM3PR05CA0090.eurprd05.prod.outlook.com
 (2603:10a6:207:1::16) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
Return-Path: rasmus.villemoes@prevas.dk
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM3PR05CA0090.eurprd05.prod.outlook.com (2603:10a6:207:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27 via Frontend Transport; Mon, 19 Oct 2020 12:12:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5818cd5a-d7b1-478e-a2eb-08d874282ec6
X-MS-TrafficTypeDiagnostic: AM0PR10MB2355:
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB23555694FAE3EC4AA76074F8931E0@AM0PR10MB2355.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jdM+pQHgeUmCpc6ZKtDiZXCj0l6dTS4n9/o4vAYsCoGK+jQdrzHlN2enpht7Aeaut8qvoAack/jSjqaSOCj1oHd/GBxYe425fxf0GgHm+vGVurwvIjn3GW0ttbmgljkQqH1Wfu6f4V1KEGlype6qRofHCK1wDIc8cXylJMtu8GEmMqVnrCAfb6yUBRgXcjAF9Uyj7SS5fJO7j2rr4qjODgezsTVqKzm6wiWCHBxoy62AH1+Y8+UG3Q35lrq5EsOshMpKXQLa+VtUnirUbt6aM80IB2NnEpNw5oS+CfKWjddEKR5sScs/OKXyknyx2lSN8b1Qmpy1qBC61zAUaqjAoJjSyBzE/3wk16hk3BB4D+vUv/5+z0tseWolcSfuPLBP
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(346002)(39850400004)(4001150100001)(66946007)(66476007)(66556008)(31696002)(16576012)(44832011)(2906002)(6486002)(86362001)(316002)(52116002)(478600001)(5660300002)(2616005)(956004)(26005)(186003)(16526019)(8936002)(31686004)(36756003)(8676002)(8976002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 
	KsIJ++eX+CHaufxIuTCZG9n9wm3aGabWYIlJ0gJ0Gqy1vRgMs0SJLsMpowh1yIXcAIxGalnqHYbbvz8tot9wu1HlB9WPu5yq48HB335QU53km5bJzB49ArP54OiPdlKvNwZEpdi/OYD+PEnvrA2ysdgDMymTylKDelCkfhMzmTXUqEveUSPyAvR8lo8YYcNsh6Yx0MJGWLk8ICamuaBt/hMSJA1/l4VSFqMR41TBotpjSdRBcB0XARMnyw2luhAp5fkEEkgJfRGS158AqlQEyKWzPaNgYKr9cYCoFAcdTvgT9dLgJpFAo1Z5OGBxBL51C0VbNuK2samJ8R2/rEWyIRo3NYdLH2xURuyUBR2+YKnc4als3UxWvB2La2sqjCJrcCX/hT025HfTuXrmMXw/Imy4yvF9z9Aq5HezRKmlD2ldxskhdiy2ogdxNUMFl/cddLyC7l8UT8rQMfM3r12F42dmS7j1UhRvCPky5nIRVJEPsiAPHixwBhSN7FmSsNU5Mq8aoumSnjzRazE2/8+zDFwKzV3lcl/HYXAY/uMRfjGSQ8qygBvX0xQNk2gdbMBqRH9iPDhIwtVbmSDdC9yYUsOQAC79MJz03aY3hfd6vQ1x9gDt9If4pRnwolcl1rkRelzAXMSG5Wa/IlzNMy/vXw==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5818cd5a-d7b1-478e-a2eb-08d874282ec6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 12:12:00.6558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aqnc9YfigrmuyB7IXTWY04+P9+LmBug22Foz7TZQZNQ0/hu5j9dEhGGvbKVDP06mFGthAJM8DyxDUkWCXPM0Uj/sPL5Tp+vWmqqBgu8gUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2355
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 19/10/2020 13.37, Richard Purdie wrote:
> On Mon, 2020-10-19 at 13:25 +0200, Rasmus Villemoes wrote:

>> I'll have to respin for the git version issue anyway I think, so what
>> do you prefer?
> 
> How about we just have the user set:
> 
> BBFETCH_GIT_REFERENCEDIR = "${DL_DIR}/git-reference-mirrors/"
> 
> and then unconditionally mark up recipes with:
> 
> ;reference=linux-kernel
> 
> then the fetcher code looks in ${BBFETCH_GIT_REFERENCEDIR}/<reference>
> for reference clones if and only if BBFETCH_GIT_REFERENCEDIR is set?

Works for me, as long as there's no requirement that
BBFETCH_GIT_REFERENCEDIR is located below DL_DIR (but I assume that was
just an example). In fact, at least for our CI setup (where everything
runs in docker containers and we map in appropriate host dirs), setting
up that directory is rather easy, adding

  -v /hosts/linux-repo:/git-refs/linux-kernel:ro

to the docker run command and set BBFETCH_GIT_REFERENCEDIR = "/git-refs".

But, uh, how does this avoid the checksum/sstate issue?
BBFETCH_GIT_REFERENCEDIR will need to be exempt somehow, right? I mean,
I do want to be able to use sstate artifacts generated by our CI, but
not setting up BBFETCH_GIT_REFERENCEDIR (at least not necessarily
setting it up in exactly the same way).

> This avoids all the messing with vardeps, keeps the SRC_URIs simple and
> should generally be much more usable/scalable?
> 
> If BBFETCH_GIT_REFERENCEDIR is set, we'd also probably want to make
> successful clones push references into that directory to cache them?

Absolutely not, the referenced repository is not to be modified in any way.

Rasmus
