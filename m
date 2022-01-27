Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DC5C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 12:00:48 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.85])
 by mx.groups.io with SMTP id smtpd.web10.27791.1643284845422035588
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jan 2022 04:00:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=b/FhCOBO;
 spf=pass (domain: weidmueller.com, ip: 40.107.7.85,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUjPDQmSgp+hLcucLLOVSYm/Wqao0OlJ61Q28pwY0/wfsesArPRoxntvKccw7R5l8tiBr8ILLGVSKxl4idWKEs5BovZRUCMvo3r1JeTabAXRE37EZDSsGVnwhz9uyd9ITVgG1IY45rIS9CUWE0OtGB4wgWlj3ePqM+c9sckUc0EvggISPaYYIWbvB6qQIUEvW7CDjvrOPbZF+tZHxz8XZrgHTglEAAOllEyQBB4DiWGtbKgj/v2pvjrCvX/6Wx8DB4QccazK63IRRM1K1nq5RrWKkx1nilkdkbe23TnOvYzAYQVewSsOuRaKkL5ytjdS5mv94sDDiO/yIyAc6xtESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYVCt8ps+s4aChcewiAD32z/8am4OLXbX3pzFsq8usk=;
 b=QIp8O+qU8JyhHTq74LPFguj5lYh4zuCZ2tqM8UvECOkavYTfdKmJDgtbrvUeV926JxjhdOG2gMpcCMuBdy/VJj6kDhRCoaHJzVtzerCTv8BSBp+xU2UKGpyd3v9zdnUniC69MSHNjqruYoPnl+FyHc58jpUOvI3t0L0IGyPejpc1rmS+hg3sBOoLPqn7S7CGi11Ih/ETa+fX4gGiETjMlryat+fKnPyuw3U+JJGo2gkz0/pfdrymUNzn/dJL83iiXy1ot2iji7MI7PplmCaYlSKzSQVWRTS+iT/DnnjqcNbhM7oPhWOdJ9q4gd7fS1SUI30m5tORDS4NECbThXm8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYVCt8ps+s4aChcewiAD32z/8am4OLXbX3pzFsq8usk=;
 b=b/FhCOBOwDwdFPFOSkrQZ5p1C5Y3Nl2Cp33ey2+iu4xcK4yCHyxzUgmg7Iy8nXEMiyhtzH06rthvv3xGjrGyYcu7wnpxH5522IjBITV7/CfDhO6jmaK5V5so0YPfCdulw7UC9YV/vXjXVjzWQsqjwkyVud60W1mffyySrvRllaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PAXPR08MB7396.eurprd08.prod.outlook.com (2603:10a6:102:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 27 Jan
 2022 12:00:41 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::245e:139f:5d4d:1dc2]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::245e:139f:5d4d:1dc2%3]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 12:00:41 +0000
Message-ID: <c70b25c8-417c-1a67-ae2e-cc717151c198@weidmueller.com>
Date: Thu, 27 Jan 2022 13:00:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add crate fetcher
Content-Language: en-US
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <20220119180015.1931903-1-richard.purdie@linuxfoundation.org>
 <b889e360-9b6e-4517-c03a-f31f3168e36e@weidmueller.com>
 <CANNYZj8X3-zB+JBf2aHhiNmgPEBZ6KrrdZCAxBr9gj6WVJwsxQ@mail.gmail.com>
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: 
 <CANNYZj8X3-zB+JBf2aHhiNmgPEBZ6KrrdZCAxBr9gj6WVJwsxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0075.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::16) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 418fc382-b2d9-44d3-5ca5-08d9e18ca3d1
X-MS-TrafficTypeDiagnostic: PAXPR08MB7396:EE_
X-Microsoft-Antispam-PRVS: 
	<PAXPR08MB7396AB7AF151D6547B975E0CD7219@PAXPR08MB7396.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WUf9FmbCg5RTUYZHBJrZHJQxHwvM1qgV1jjnQ7TN/wpNOBt2jVUo/ntDpN6Vk/kNd7WzRc4TV3ljWnKm6AxNPh+5TEO8io5x1jLFfKLbFjsDPNGN6GOJ7Do8fXNYOIWEVIxEH+JIROb0qWkg//Tqvs4hMZhwaos54eS0KWKhE8Xx95nniebfEse2OZ9auuGheH7D8iXzAvgbIJC+x5P5zyRiGLEmEGLSK23oT2O2QM/5ZHW/AwTqsWWIxn1zKSNnGRMZ7b5SM10zGA6GG7XH6vf7GlVE09NNgByc9QA1j6ga3CbH0vvkEK0MgyP6cBJVbM9VcaNycd7H4HahD3e/yhGGm3IOf14m/0CcnfalUPuU9nrDFY8hk0NOaCg/q7oaJKyMBvLjHpS7iiYs9NjWugjnj47i7rSfioQEK51ADgghybpxYGaozqH7NAp0yfqk+XIxajtmeHeNFgM+Flnd47iLIW+KRNCWZNAeCJ3CBxCqPVe+b33v1V9IQD1TTeavtRq+Xzvl/AnnYkjoRFV6BZXv3Xr36hF7gJc5QQgPwslxJq+RQ8PkC9NUauAFdNQ2HbqfK1++60bkHX9ZVeuO5Ad6CitLkbg0QNKc8HnHNkPbQ7XDWtaREdCQVw4cAnlL1NDAQuypTjtUbcK9IRIQkJuCQ9WXxN8wJqLjSh9gL7uuc0lZycmcNQJeUzIBBJBrHCnCQKngRb7JGSqw/h5QmSdxLEAgx3BloYSSgP62Zo7d1nl1LkwGJvEhZjF7C+QI7pwqfPeMEGFOKIq7kZRpFA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(54906003)(38100700002)(66556008)(5660300002)(2906002)(66476007)(6916009)(66946007)(4326008)(8676002)(2616005)(31686004)(186003)(508600001)(316002)(8936002)(86362001)(31696002)(52116002)(36756003)(83380400001)(26005)(6506007)(38350700002)(4744005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SlhMaU1vSExLdHBpUzl6WlM2c2FBcFlhSXlGV09EbGIrWHg4UWxvc2FUY1BL?=
 =?utf-8?B?Y2pTamdNTDMrY1FvWldLS0xvM25HcXBpWmJmejlZNXZCcmRjTEEzTVUwZTBI?=
 =?utf-8?B?QTJocFhtZDNNVzY0MjBxbnk3bEdRVThpZGhpbXRQMjZqYU4zdHVyM3dEd25x?=
 =?utf-8?B?QXZMYSswZlNLeGFGRmtPMmw3N2x4Sm53WmFPdEErbE0ya1Q2bjhHS0pjWUxw?=
 =?utf-8?B?WVJxZnRuUXJ2UE43NTBZc1BZRFhzSEQ0TUJXYmJXT3NCRFFLSjFpOVJhQzVo?=
 =?utf-8?B?em1lbHpKemxEb2Rha0NiSm52Z0V0Mm53NmFRK3JPWVh1aGxhaTJRZE42Vmd6?=
 =?utf-8?B?Q0JRNEVKN0ZzdU5WLzROa2ZSa05FbjBxVWpzOXJtMnpqQWYzSGJweUR0amZ4?=
 =?utf-8?B?N3l1dCtsZGs1MUN2UWkrVDdMeHhRWUJvK0IwQnRWZ0NjV0NPTFh5Z3c2M0lW?=
 =?utf-8?B?ejg5LzRBbG1rU3lZdGZiRFl0K2JPdDluTTV3OW1sakxJK0s5TWxWQU1uUUli?=
 =?utf-8?B?b0tmVS9MS1IxbUl5VzFFd0VzMnJaQ3lUVFViSFdJQU1nVGlZUmQ5dTc4RkJD?=
 =?utf-8?B?aFhiTTlUNGtiSGpUTlFBbjJXb2k3R2RyUFQ3ei9FOUpQUU92eXdPRlhiOTJF?=
 =?utf-8?B?YzRFMWN3clFuVWdodHFJWHdxL0N5NW1GMnVLSnJ2T2hxa1ExRG1tQStwNE9o?=
 =?utf-8?B?aVhLK0RmcWlsV0hPa3U4VFpzWlN1SktlMzdtYVR4bUhRWlBCeFVZS05JZEls?=
 =?utf-8?B?TGJqS0ZVQTNtUWtubnRKU2ZSL1NVSTJEaEgvaEs0TS9mc3VaaVErd01YTVZJ?=
 =?utf-8?B?aHRreGRaOXlBK084V3dnVHJSdnlqc1BMWjBESTVVcFlVK3FWcWFxMjBTc3Zz?=
 =?utf-8?B?bkRGRWgxamRpU1FyV3Q5WnJwZWNtZytadnI1QXJxcDU1a1cvQUs1NTMzeVBR?=
 =?utf-8?B?SUJqWmNyUXNMVldzTzZDcndwcjVFOCsyME03MWFxTFNieGlOSmUyQnF0ajUx?=
 =?utf-8?B?U2l5a3c2Tm80YkhLbUVmR0dCajBiZHE5T0crQkhqcnRKcEdQMGRWKzZTcmY3?=
 =?utf-8?B?R3gzcXJCcGlvTG9lQ0xqVDZ5SUpJMTVKRjVRUHVzY2N1UTZORWRzVkJkWGs4?=
 =?utf-8?B?cS9yVDBoYkhXV21zZDI2SFNQYmJMczZRNUxJSE82ZFV0aGROOVpESGx3NnNF?=
 =?utf-8?B?OGxDVyswUUw5OG9ZbHdQblpuMGtTQXZ2Z041Vll5a2pXUE81WVNLVktDc21j?=
 =?utf-8?B?dFV3dlkxdFF2REZaWEkzdXFHMkQydWVHZ2d0dE1XN3Z6bnJ5bGpoY0NVamJ6?=
 =?utf-8?B?b2xpc2h6RUlOcjlKOHRUTlh1WjdsRWo5d1NmR1BlVTc3RzAvWjBma2NRYmp3?=
 =?utf-8?B?RmFsYUxCbXdYa1R5WExWaU5sT2lYdVZRK3R5bjZXdjBCQU16RzMzVks5N2wz?=
 =?utf-8?B?SkdPbnRFTFM4L0p1bFBDTWJrRUh5blBTWWdkdDYxUlYrQm56MVZJajZuWEFL?=
 =?utf-8?B?cXFKR2NPYnZOVmpYNkcxekpwVExkUE96V0RucmU1Sk5pZEZ2ZXg3amVyaXN1?=
 =?utf-8?B?TG1UUDNxWFF4U3Vka0h4cWN6ZlRJWlJCN2hMK1BjdnVKR0JVQnIzSjVlNXNq?=
 =?utf-8?B?eHVYRXlkQlZJSHNFUEJ5MndyeWczcnd1eC82b3RST0VaSytQdElOQmMzbGxE?=
 =?utf-8?B?eVlid1pwSHVQMmlKM1dKc1NETnZoZDVtbWtoU2Q0Rng2OVc3VkdjVkJqNzlw?=
 =?utf-8?B?ZTBHRmc3ZTV0WjJyK1BoRzlBNkx5blZPOEJlNGk1ZGVSWUtQeUJ4RDh2RHZn?=
 =?utf-8?B?NnBBcUJMa2hNWFlheU1JdWhmdTEyVmpRWkl0L2hWSkNlNS9xK1QzcitmT1RZ?=
 =?utf-8?B?VFdxYUFiSzJOQVpUM3F0RktqRDJnT3RqMUpSVXlRUHV6MHdaMXUyWjhIOVFS?=
 =?utf-8?B?R2t5bTJqWGZUY3ZubDUrMXpHUE83ZjlEcWU0TEVWMFdQdVRlbnNpRUxzUXF2?=
 =?utf-8?B?UnBURmh0TmZWUVlwdVF4UjF4Y0RmRWMyOEVQVS9PRFRER29jclMyVFRiWWMx?=
 =?utf-8?B?Nkg2UDRCMUNMTlFXUElFTUVNeGJETWlwVGVLOEV4c1dIQyt5SStHbVRqQ2Rr?=
 =?utf-8?B?UHIxSVJCVlhRRzd4SDNLNkt3QkkvZWg2U25IQkhObzF2WnFmeTlpNEhvZGVp?=
 =?utf-8?Q?3sqgvqPoLxpQw1NWwcfa2VY=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 418fc382-b2d9-44d3-5ca5-08d9e18ca3d1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 12:00:41.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 F0UataxfkUVYY94zuKnbH8PvMzHBdWSZ2dwRXGFpstAmdpiuPnJiol2l8en0CAVFdKyPHf5TbG9rShtz7rvm+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7396
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Jan 2022 12:00:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13289

Hi Alex,

Am 27.01.2022 um 11:53 schrieb Alexander Kanavin:
> this is already in master, so the concerns you have are probably better 
> addressed with followup patches.

Does this means the SRC_URI syntax is fixed and we have total different 
syntax to specific a repository, package name and version for npm and crate?

