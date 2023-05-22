Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16115C7EE23
	for <webhook@archiver.kernel.org>; Mon, 22 May 2023 14:42:10 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.23796.1684766519571955652
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 May 2023 07:42:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=XZ+be6Zu;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=450641d5dc=randy.macleod@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MC1vDU020266
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 14:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=PPS06212021;
 bh=Am0FMKuby5JS5BEWVJ9yPVla0Ejb4BwtwdHZKvaoIB4=;
 b=XZ+be6ZufuoGyOukvyAKphGhiQj1gTVjMY5fhlIaMcr6PsQyLiJtzt9rNoGpLsuT9dsV
 TzT6Hp9knIVV3QkKnIs/vqGng1BUsIi3mxKi5uObDp6mB06cu/INQ7/66ZEeimmk+6RC
 Pv4V8zGseO8Hm0zH0fbILNVGVOcmlK2llwkCNLGazGUSwl/HCH4DL7X8ktDyTjs685iN
 FTYpV9xOE/ETCWeghSBwb0xcyFNxDefLCv9SokOY91yqeqihoSPNiZvDzZ1iOpKTTXyO
 yq9opE1JhbRfKoO+NmmckihfeQEaj7r9UG8zsG8ipy4vjqr76xMve3mHCG3Pwwukbp+G Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpkn1hvpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 14:41:58 +0000
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MEfwDc021424
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 14:41:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpkn1hvpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 May 2023 14:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AogbSXQEvxMapBtTjAzjRA6DbI8JE0NCCay2rlaQ/efeNsPHzoYcO2zlFNrjz6MKfyoPbD14X8uDjcjklcHWhciVDp1L5h1wglOmsopOLp6a7mkH3+VGLAhGLSNtnCNldUv4GkYtxXc7QK2Hluuyj5EPMkQA/nCNo82oRn1pPtD7XjlEkfGsUIEytBBK0iIvP3XxQW5Qa4cxni+aFY4DWqahY85srEw0HF3fU6bYypWav51W7WMGPDmQhX/pkZJMRQ6fLk6j98HrIWKuW0Rz8W82rZU/X+QWzYyQ8xyKscSvrmLR3fjQqL2K1DyMHXPRc7/jpR69ZBgXIvzN1Awp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am0FMKuby5JS5BEWVJ9yPVla0Ejb4BwtwdHZKvaoIB4=;
 b=BCdzkZ4fuuRMXTQSHIWKSkg+wV0kxlbRPvgjKwmDDLEOF+nSfcMqTwHrxwL1f8CuJd3mjIcyx7QUblZwkEWNu5QjnCoTrjCMde9NcJhbO7FdU6qZEzgaLyduUXNrbmSXQ6/Nloh+pVRXA5lHCOv+sLJrjAP3JpP29hkCq8d0acJm0egKGxux4HhIP1fWo57+YDFvWF6MVKg59R2WIw1j1fOmAJxDDMI9UuUtJx17c6cZxOxHJSZ/H6Akg7MuV4D3V0e5jsQiXQDCDxeXYK9OiWrh7ZC7kzThvG1+7WvVQ9bdHshOulh1l3Eu1Ni5dh7k5CQnUFi0KrO4DlZoc1ayow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Mon, 22 May
 2023 14:41:52 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::a2e6:a5d4:b628:fa7f]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::a2e6:a5d4:b628:fa7f%6]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 14:41:52 +0000
Content-Type: multipart/alternative;
 boundary="------------dTQ8IBqATs2kFaJ2oSAW2n70"
Message-ID: <3dd30f41-688d-5691-f26e-66fc73bb49d0@windriver.com>
Date: Mon, 22 May 2023 10:41:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [bitbake-devel] Bitbake PSI checker
Content-Language: en-CA
To: Ola x Nilsson <ola.x.nilsson@axis.com>, ChenQi <Qi.Chen@windriver.com>
Cc: contrib@zhengqiu.net, Richard Purdie
 <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <jwq5yegq5h5.fsf@axis.com>
 <49ffc1db-9b43-e570-d726-dba12d560a30@windriver.com>
 <jwqfsdbo6w9.fsf@axis.com>
 <C2B324F8-26C0-4FD6-848C-1224EB502474@zhengqiu.net>
 <732553c1-870e-c794-c245-d664afa14343@windriver.com>
 <5fb8eecc-135f-c34a-3d1a-1d4b9ae62509@windriver.com>
 <jwqzg5w4s0y.fsf@axis.com>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <jwqzg5w4s0y.fsf@axis.com>
X-ClientProxiedBy: SJ0PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::22) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|CH0PR11MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6591017c-dbc4-48e8-8f4a-08db5ad2ae47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lxIL2wNBr3UgleymDojh6DXkaIq3FUheAX4UBEoq/bObSSGiXr03p4gE98uXWvqBEn9aMCXWv0uKuCOoidcmSgWKLCJtlRMdVgra3r8pRtVwUG0aq7m743NSerU5+xRqyS70RBn79ZWF+h3lLQwr3MBr1EfXU/gNokLqyfX+qKG7eRP/w/ZPR6xYbkU2BggWSoARYa2h+v2q9VbRGIkoAIbaGYQl0eiJUVGbRDKx9uPrrMyOI2YhFhci8KkbRqrgVW4+XNpG9BfA5CDhOACrXneMGV7Fn1FWJyZjUQ4khZ2FPLhyrkBUG7FF8vVRpDxtWqNGlCW9pfOxm8QCXdTaErZtigSD2KdFiv/qv7De1sTYh9yyP071NsZLBv1sHfnecpxIUCblJhYTIJNTsJU/lOusc+BbvhKYh1rfPfC8H6jRGCCX+hcy5It7n3z/q03e5gDb2nVgDXkAEBOe0D3g5EB5nx5e6USUXW89Eg/LtqHjRkA+ujsh5dk/bRyxeyEgDZ2KkBmadMewhH/JW8A/+P0LsCQH/0at9qDiKpI27JcDyZeqzzNAcDqowWWX63Tk4Mu9EuEe4M8rG6rSt9tEsD1tnQKQR6g10QGreskn+5zA3Xnq5E2TDKefZmlIIQ8py4+sV73T2qg0Zg83oW0IlYUDN98WJxJE+8VwSaR4gpSJtQdbiPvyxQn9BvEhVjFD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39850400004)(366004)(396003)(346002)(451199021)(33964004)(6486002)(966005)(6666004)(26005)(53546011)(6512007)(186003)(6506007)(5660300002)(2616005)(66556008)(166002)(31696002)(66946007)(66476007)(31686004)(8936002)(86362001)(41300700001)(6636002)(4326008)(38100700002)(316002)(8676002)(66899021)(30864003)(4001150100001)(110136005)(36756003)(2906002)(478600001)(83380400001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RjBUWDd2M25xQjVFUUVSQlFFajRsWlc2ckZlMVpFTnJrL2ZiMGhqUVYrMFdV?=
 =?utf-8?B?emc2NzlsYnZ5UTF0VTkyeFQzY3VwYmxXdmJyL29uUUQrRFpWUVBsb2N5MmNu?=
 =?utf-8?B?bXhkeDNoVk52dGp3Q2N4SkFRbHFyTjFxSloxakxpVHQzRnAvd3Vlb3RTREt6?=
 =?utf-8?B?NnhuRUhzam41TWJOYUdQZllGSjlRMlhUa0tFN2lpWWJjRUtLMkRvS0VmSzBS?=
 =?utf-8?B?RFE3Qng3NXU4cHhMaHI0VzFwYzRkVDk2MFhhbWI1R1JLT2dBNXRTVE5IV1hK?=
 =?utf-8?B?RGdNRFJpZ0ZVU1plQlhrUXdKQ0I2MDlsV0pVaEt5cUNhb1Z5N2xPMzVBU21j?=
 =?utf-8?B?SUtocVZOeVpxanZrN1BMa21yTUlxTGZjU2pMbmpPNiswUWp6R0pVVkFRcE5K?=
 =?utf-8?B?SGVuSTFGem9QanQvM3g4aTVYWmtEZmkrSW1zbk1YYTdHdVdGVFJMYWhiTlBR?=
 =?utf-8?B?SkFoV2U0b2E4M0NoeVR2MHMvM0FPdzN6VVBXK1BoeE1ibitORGEwWGtmUXVy?=
 =?utf-8?B?MkdFQmV2Rm9uVUNOUWhLVzZrSXBFS2NrQnJub3pKWXJLSGgrOWNHWHpSUTRT?=
 =?utf-8?B?YVJiaTlXRnl1WHo5dTRjTE9MSFZ6QXM3V2FrR0s2UFV5dFJ6MldBeDYyeGlV?=
 =?utf-8?B?Z0NSQnJrQ3hhM3gyV2xQN25xUDZuVmc0VnVvanlvMGFoaWxkQXlSOENZT084?=
 =?utf-8?B?andaOWJyU2Y3QXpPalVLYzBLaGNuQ3FzVEJHNWlDbEsvdGtqZXNnNk11MktR?=
 =?utf-8?B?M2JnbVVid1U1aE1WV3pETmd2VjQ4aUQzQ1NqcndtUVRlRHBHTmNJKytsRHZU?=
 =?utf-8?B?VzVGQlNpcmNJUCtFeWNmL1JVV0xLVk80WEk3aXNqYklvMVF4NVBxS3htR0FS?=
 =?utf-8?B?ZlNiREdSTnpiaHFyd3Q3Zm92aDlOMEVSM0JJd042bFNMUk5qQjBReTVUN1Vm?=
 =?utf-8?B?SnZ3UTBqSTRpUURHNWJJT3d3OU50QUhOaXhneUZFWGI4OVA0R3BOOW5uMDV6?=
 =?utf-8?B?elV5bkJwNytla0g0OWJMVTlwNE5KSXZmck5IdS9YMDRaQngxZ1NYNWFIaHVV?=
 =?utf-8?B?b1B4SGlUU3doemQwVXFSTG94V3gva1VHL0NSOG8vOHdOazRhZXI5ZXQ4SmIv?=
 =?utf-8?B?WVp2NWpWamhueEMvbmNpTkJiK0xIc1dqdjAra2xuMDc4VnhIRHBLTzFGNnIx?=
 =?utf-8?B?UVJ6K3docUUwczhCakVVQW9EMlhVeE9xaFFTbUs1UU8yNXZxM2JHVmVMMHRp?=
 =?utf-8?B?d3JtTmE4bXZURXNoUjd1UEF2Vy9KbkZseFNsY29NWnBGRzV0KzlHSXVtWlpC?=
 =?utf-8?B?TGMydkhtV2RMRmd3OWVCa3JuN2dWZ3hwMDdvczc1RWtkdG9qWStsbjhTYnpM?=
 =?utf-8?B?VkVLWnloRkFzV1A5M0dmYXhvdGtDTVVXbVlRY3A4cWxheWh6UWxDeGxmMTN2?=
 =?utf-8?B?TkJWR28xNldXT0FtU3F1VEpveVM3MzlLMlZyalNoclJoOFQ2RGN3TENIZEZT?=
 =?utf-8?B?dzlWTXpzMFQzUktPT0h3WWRha2I2U2FNSDRNZWo0cXhCQmxLKzJwNzM1Q3ZO?=
 =?utf-8?B?bHQvTUFjSmg4ZjRxNjFMRmdVWVp3aWNFNS9ha3RjRWZVUzZ2YUl0TEYyWGNF?=
 =?utf-8?B?dUFzdkxDUlZyTHZJWG1ZbEt1QVp1RHRhazg1N1Q0TVcyMjg2SlBFUHcvTU51?=
 =?utf-8?B?TlYxN0FFa21kTlZjdzZUQjMvM0NOdFdwZmRiWWJianpPSFBsV0QxTFp3TEN6?=
 =?utf-8?B?RkIzZy8wZjdPd0V5WmxldkNJcWkxTDN5QWlneHk3SkhvVmR5cysrREU5VWRI?=
 =?utf-8?B?TEVpYjZMOXpITVl1OHZFV1A1UEpBVXJmRGU4MUMwYnJTZjQwRGZuSEZzZmVX?=
 =?utf-8?B?aVRGbjFYTTloTFBmUXBBL1RrY0ptVkx0L0Nmb2tSVUlUbDFRWFVoRnZraEwr?=
 =?utf-8?B?SVJNditnWUxQRlFDMmxBdld0aGxUSWNEMjdxZnk1U0NGVWdhM1pjOTAxKzAx?=
 =?utf-8?B?Z3BWVUJ5S1Vqc3F5U256MStWRWMzZCtCcjhpSzM4NlovZ2ZTRzdCL0tmWFJ3?=
 =?utf-8?B?eTdGN0hsZWt2RGdFYXVnY2RQUlJ1bEV0eGFhaFRCZzgvbXNyQkZpMFJhcHVY?=
 =?utf-8?B?YW50b2FoQmlsVnhzUnMwbjRKdkJLMjJMMCthSjduZ1o2R3Ftb3d5cEpBalZm?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6591017c-dbc4-48e8-8f4a-08db5ad2ae47
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 14:41:51.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t609U4VRqqNTgE9NwMNKIyS+GtDWZKAkNMbLKFDrXzr7UH9AqjyIi1dPqZ6AsyInW+HbxlHvjk4sN8D89jeoVjzWqWSLgtldl1j5A/7561Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
X-Proofpoint-ORIG-GUID: PzXje6Hx_KOnofH0nKeZjdeKV8wpxtl3
X-Proofpoint-GUID: G-oZioV9BV2Cqu2-6CDIyaGcseRk2wkL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_10,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305220122
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 14:42:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14795

--------------dTQ8IBqATs2kFaJ2oSAW2n70
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 34MC1vDU020266

On 2023-05-22 05:36, Ola x Nilsson wrote:
> Hi Qi and Randy,
>
> I did some testing this morning, and I think this works fine for the <1=
s
> intervals.
>
> I added log prints whenever the exceeds_max_pressure function was calle=
d
> and was a bit suprised at some of my observations.


Yes, the kernel uses per-cpu variables to track pressure
efficiently and only updates what you see in /proc/pressure
periodically. Fun, eh!

I don't have a graph at hand to show that but here's a
CPU pressure typical pattern:

https://photos.app.goo.gl/XCMVAjywmBgoqj4E6

for those who haven't looked at the data.

This graph doesn't show that if you over-sample you'll get the same
value from pressure repeatedly until the per-cpu data is updated.
I might have that data on hand somewhere else but officially today is
a holiday so I'm not going to go look for it even if graphs are more
of a hobby than work!

>
> It seems setscene tasks are started without checking the PSI.  Is this
> by design?
Well, more like by lack of design!

I'll take a look, hopefully this week.


>   With the antivirus program forced on me by IT I easily reach
> CPU PSI on above 600000 (my current limit) while only running setscene
> tasks.
Ugh!
>
> If the PSI threshold has been reached, no new tasks will be started for
> a while.  But once the PSI check passes, it seems as many tasks as are
> allowed are started at once.  Considering the time interval between
> checks for each started task would be very small, this would probably
> happen even if the PSI was checked for each task start.  But won't this
> cause 'waves' of tasks that compete and cause high PSI instead of
> allowing just a few (one?) tasks to start and then wait a second?
Yes, I've considered that but hadn't gather data when
on it when Zheng was still working with me. I also was
concerned that we didn't want to slow the builds down
too much. I'm not sure how to make that trade-off in a
generic manner given that we don't know if a new build

will generate little, some or tremendous pressure.


The problem is even harder if you have 2 or 3 builds on the
same machine. The related but not exactly appropriate term
for this phenomena is, 'The thundering herd problem",
https://en.wikipedia.org/wiki/Thundering_herd_problem

I expect that there are good or even optimal solutions but
I haven't had/taken time to read the literature.


>
> These two things are obviously not connected to this patch.  I think
> this is fine except for the commit message which refers to runqemu.py
> instead of runqueue.py.


Oops.... I don't actually see that error but if it's done, c'est la vie.

>
> Thank you for this improvment.

+1 Qi !

Ola,
Thanks for checking and reporting and helping push us to do better!

../Randy



> /Ola
>
> On Mon, May 22 2023, ChenQi wrote:
>
>> Hi Ola & Randy,
>>
>> I just checked the codes and I think Ola is right. The current PSI che=
ck cannot block spawning of new tasks if the time interval
>> is small between current check and last check. I'll send out a patch t=
o fix this issue.
>>
>> Also, I don't think calculating the value too often is a good idea, so=
 I'll change the check to be >1s.
>>
>> Please help review the patch.
>>
>> Regards,
>> Qi
>>
>> On 5/21/23 03:58, Randy MacLeod wrote:
>>
>>   On 2022-12-19 14:49, Zheng Qiu via lists.openembedded.org wrote:
>>
>>   On Dec 19, 2022, at 7:50 AM, Ola x Nilsson<ola.x.nilsson@axis.com>  =
wrote:
>>
>>   On Mon, Dec 12 2022, Randy MacLeod wrote:
>>
>>   CCing Richard
>>
>>   On 2022-12-12 05:07, Ola x Nilsson via lists.openembedded.org wrote:
>>
>>   Hi,
>>
>>   I've been looking into using the pressure stall information awarenes=
s of
>>   bitbake
>>
>>   That's good to hear Ola.
>>
>>    but I have some problems getting it to work.  Actually I think
>>   it just doesn't work at all.
>>
>>   Doesn't work at all?
>>
>>   Well that would be surprising. See below.
>>
>>   OK, it will occasionally block a task. But since the next attempt wi=
ll
>>   always be a very short time interval it will almost always start a n=
ew
>>   task even if the pressure is high.
>>   At least this is what I observe on my system.
>>
>>   <snip>
>>
>>   1. Rather than just keep track of the previous pressure values
>>   seen more than 1 second ago as done currently:
>>
>>         if now - self.prev_pressure_time > 1.0:
>>
>>   and always using that as a reference, we can
>>   store say 10 values per second and use that as a reference.
>>
>>   There are some challenges in that approach in that we don't control
>>   how often the function is called. Averaging over the last 10 calls
>>   is tempting but likely has some edge cases such as when there are
>>   lots of tasks starting/ending.
>>
>>   2. If there has been a long delay since the function was last called=
,
>>   we could check the pressure, sleep for a short period of time and ch=
eck it
>>   again. Some people would not like this since it will needlessly dela=
y
>>   the build
>>   so we'd have to keep the delay to < 1 second. Too short a delay will=
 reduce
>>   the accuracy of the result but I suspect that 0.1 seconds is suffici=
ent
>>   for most
>>   users. We could also look at the avg10 value in this case or even so=
me
>>   combination of
>>   both the current contention and avg10.
>>
>>   3. Just calculate the pressure per second by:
>>
>>      ( current pressure - last pressure ) / (now - last_time)
>>
>>   This could handle  short time differences such os milliseconds
>>   as would be a 'cheap' way to deal with long delays. In your case,
>>   the pressure would be:
>>
>>     978077.0 io_pressure 1353882.0 mem_pressure 20922.0
>>
>>   divided by ~19 since the initial values were close to zero.
>>
>>   Then for the next time, just 0.1 seconds later:
>>
>>   1670840042.384582 cpu_pressure 8978077.0 io_pressure 1353882.0 mem_p=
ressure 20922.0
>>   1670840042.384582 cpu io  pressure exceeded over 18.677629 seconds
>>   1670840042.486946 cpu_pressure 466.0 io_pressure 30792.0 mem_pressur=
e 0.0
>>
>>   Multiplying by 10 or easy calculation, the would be a pressure:
>>
>>   cpu: 4660, io: 307920, mem: 0.
>>
>>   Do you have another idea or a preference as to which approach we tak=
e?
>>
>>   I think 3 is a good first step.  Using multiple samples could improv=
e
>>   our calculated "avg1", but lets do that later if needed.
>>
>>   I agree; Randy and I have been working on patching make and have tak=
en a similar approach:
>>
>>   make.png
>>   ZhengQ2/make at cpu-pressure github.com
>> make.png
>>   Additionally, we found that when the pressure read is too frequent, =
we may get the same cpu pressure as an result,
>>   even if the pressure have actually changed. This is likely due to th=
e per cpu variables used in the kernel.
>>   So, in addition to the algorithm Randy talked above, we also compare=
s if the cpu pressure has been changed, if not,
>>   we will return the last result that has been produced.
>>
>>   I will CC you when I have a patch, and you can try it out before the=
 commit gets merged if you like.
>>
>>   Ola,
>>
>>   Does Qi's patch below help in your situation?
>>
>>   I still want/intent to add a bitbake PSI test case that uses stress-=
ng to induce load
>>   and a lightweight sleep task but there are never enough hours in the=
 day/week/...
>>
>>   The basic idea is to:
>>
>>   1. Run a task that just sleeps for say 10 seconds and confirm that t=
he actual
>>   execution time is < 11 seconds or so.
>>
>>   2. use stress to get the system into a CPU pressure environment abov=
e
>>   the current threshold for say 30 seconds and simultaneously / shortl=
y there after,
>>   launch the same sleep task and confirm that this time, the actual ex=
ectuion time of
>>   the launch to completion time is 40+ seconds.
>>
>>   ../Randy 'getting caught up on email on the weekend' MacLeod
>>
>>   =E2=9D=AF git show ba94f9a3b1960cc0fdc831c20a9d2f8ad289f307
>>   commit ba94f9a3b1960cc0fdc831c20a9d2f8ad289f307
>>   Author: Chen Qi<Qi.Chen@windriver.com>
>>   Date:   Thu Apr 6 23:07:14 2023
>>
>>       bitbake: runqueue: fix PSI check calculation
>>      =20
>>       The current PSI check calculation does not take into considerati=
on
>>       the possibility of the time interval between last check and curr=
ent
>>       check being much larger than 1s. In fact, the current behavior d=
oes
>>       not match what the manual says about BB_PRESSURE_MAX_XXX, even i=
f
>>       the value is set to upper limit, 1000000, we still get many bloc=
ks
>>       on new task launch. The difference between 'total' should be div=
ided
>>       by the time interval if it's larger than 1s.
>>      =20
>>       (Bitbake rev: b4763c2c93e7494e0a27f5970c19c1aac66c228b)
>>      =20
>>       Signed-off-by: Chen Qi<Qi.Chen@windriver.com>
>>       Signed-off-by: Richard Purdie<richard.purdie@linuxfoundation.org=
>
>>
>>   =CE=94 bitbake/lib/bb/runqueue.py
>>   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80
>>  =20
>>
>>   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>>   =E2=80=A2 198: class RunQueueScheduler(object): =E2=94=82
>>   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>>                   curr_cpu_pressure =3D cpu_pressure_fds.readline().sp=
lit()[4].split("=3D")[1]
>>                   curr_io_pressure =3D io_pressure_fds.readline().spli=
t()[4].split("=3D")[1]
>>                   curr_memory_pressure =3D memory_pressure_fds.readlin=
e().split()[4].split("=3D")[1]
>>                   exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure a=
nd (float(curr_cpu_pressure) - float(self.prev_cpu_pressure))
>>   > self.rq.max_cpu_pressure
>>                   exceeds_io_pressure =3D  self.rq.max_io_pressure and=
 (float(curr_io_pressure) - float(self.prev_io_pressure)) >
>>   self.rq.max_io_pressure
>>                   exceeds_memory_pressure =3D self.rq.max_memory_press=
ure and (float(curr_memory_pressure) - float
>>   (self.prev_memory_pressure)) > self.rq.max_memory_pressure
>>                   now =3D time.time()
>>                   if now - self.prev_pressure_time > 1.0:
>>                   tdiff =3D now - self.prev_pressure_time
>>                   if tdiff > 1.0:
>>                       exceeds_cpu_pressure =3D  self.rq.max_cpu_pressu=
re and (float(curr_cpu_pressure) - float
>>   (self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
>>                       exceeds_io_pressure =3D  self.rq.max_io_pressure=
 and (float(curr_io_pressure) - float(self.prev_io_pressure)) /
>>   tdiff > self.rq.max_io_pressure
>>                       exceeds_memory_pressure =3D self.rq.max_memory_p=
ressure and (float(curr_memory_pressure) - float
>>   (self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
>>                       self.prev_cpu_pressure =3D curr_cpu_pressure
>>                       self.prev_io_pressure =3D curr_io_pressure
>>                       self.prev_memory_pressure =3D curr_memory_pressu=
re
>>                       self.prev_pressure_time =3D now
>>                   else:
>>                       exceeds_cpu_pressure =3D  self.rq.max_cpu_pressu=
re and (float(curr_cpu_pressure) - float
>>   (self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
>>                       exceeds_io_pressure =3D  self.rq.max_io_pressure=
 and (float(curr_io_pressure) - float(self.prev_io_pressure)) >
>>   self.rq.max_io_pressure
>>                       exceeds_memory_pressure =3D self.rq.max_memory_p=
ressure and (float(curr_memory_pressure) - float
>>   (self.prev_memory_pressure)) > self.rq.max_memory_pressure
>>               return (exceeds_cpu_pressure or exceeds_io_pressure or e=
xceeds_memory_pressure)
>>           return False
>>
>>   ZQ
>>
>>   /Ola
>>
>>   ../Randy
>>
>>   /Ola Nilsson
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#14206):https://lists.openembedded.org/g/bitbake-de=
vel/message/14206
>> Mute This Topic:https://lists.openembedded.org/mt/95618299/3616765
>> Group Owner:bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [ran=
dy.macleod@windriver.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--=20
# Randy MacLeod
# Wind River Linux

--------------dTQ8IBqATs2kFaJ2oSAW2n70
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 34MC1vDU020266

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 2023-05-22 05:36, Ola x Nilsson
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:jwqzg5w4s0y.fsf@axis.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">Hi Qi and Randy,

I did some testing this morning, and I think this works fine for the &lt;=
1s
intervals.

I added log prints whenever the exceeds_max_pressure function was called
and was a bit suprised at some of my observations.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Yes, the kernel uses per-cpu variables to track pressure<br>
      efficiently and only updates what you see in /proc/pressure<br>
      periodically. Fun, eh! <br>
    </p>
    <p>I don't have a graph at hand to show that but here's a<br>
      CPU pressure typical pattern:</p>
    <p>&nbsp;&nbsp; <a class=3D"moz-txt-link-freetext" href=3D"https://ph=
otos.app.goo.gl/XCMVAjywmBgoqj4E6">https://photos.app.goo.gl/XCMVAjywmBgo=
qj4E6</a></p>
    <p>for those who haven't looked at the data.<br>
    </p>
    <p>This graph doesn't show that if you over-sample you'll get the
      same<br>
      value from pressure repeatedly until the per-cpu data is updated.<b=
r>
      I might have that data on hand somewhere else but officially today
      is<br>
      a holiday so I'm not going to go look for it even if graphs are
      more<br>
      of a hobby than work! <br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:jwqzg5w4s0y.fsf@axis.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">

It seems setscene tasks are started without checking the PSI.  Is this
by design? </pre>
    </blockquote>
    Well, more like by lack of design! <br>
    <br>
    <p>I'll take a look, hopefully this week.<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:jwqzg5w4s0y.fsf@axis.com">
      <pre class=3D"moz-quote-pre" wrap=3D""> With the antivirus program =
forced on me by IT I easily reach
CPU PSI on above 600000 (my current limit) while only running setscene
tasks.</pre>
    </blockquote>
    Ugh!<br>
    <blockquote type=3D"cite" cite=3D"mid:jwqzg5w4s0y.fsf@axis.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">

If the PSI threshold has been reached, no new tasks will be started for
a while.  But once the PSI check passes, it seems as many tasks as are
allowed are started at once.  Considering the time interval between
checks for each started task would be very small, this would probably
happen even if the PSI was checked for each task start.  But won't this
cause 'waves' of tasks that compete and cause high PSI instead of
allowing just a few (one?) tasks to start and then wait a second?</pre>
    </blockquote>
    Yes, I've considered that but hadn't gather data when <br>
    on it when Zheng was still working with me. I also was<br>
    concerned that we didn't want to slow the builds down<br>
    too much. I'm not sure how to make that trade-off in a<br>
    generic manner given that we don't know if a new build<br>
    <p>will generate little, some or tremendous pressure.</p>
    <p><br>
    </p>
    <p>The problem is even harder if you have 2 or 3 builds on the<br>
      same machine. The related but not exactly appropriate term <br>
      for this phenomena is, 'The thundering herd problem&quot;, <br>
      &nbsp;&nbsp; <a class=3D"moz-txt-link-freetext" href=3D"https://en.=
wikipedia.org/wiki/Thundering_herd_problem">https://en.wikipedia.org/wiki=
/Thundering_herd_problem</a></p>
    <p>I expect that there are good or even optimal solutions but<br>
      I haven't had/taken time to read the literature. <br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:jwqzg5w4s0y.fsf@axis.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">

These two things are obviously not connected to this patch.  I think
this is fine except for the commit message which refers to runqemu.py
instead of runqueue.py.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Oops.... I don't actually see that error but if it's done, c'est
      la vie.<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:jwqzg5w4s0y.fsf@axis.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">

Thank you for this improvment. </pre>
    </blockquote>
    <p>+1 Qi !<br>
    </p>
    <p>Ola,<br>
      Thanks for checking and reporting and helping push us to do
      better!</p>
    <p>../Randy<br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:jwqzg5w4s0y.fsf@axis.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
/Ola

On Mon, May 22 2023, ChenQi wrote:

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">Hi Ola &amp; Randy,

I just checked the codes and I think Ola is right. The current PSI check =
cannot block spawning of new tasks if the time interval
is small between current check and last check. I'll send out a patch to f=
ix this issue.

Also, I don't think calculating the value too often is a good idea, so I'=
ll change the check to be &gt;1s.

Please help review the patch.

Regards,
Qi

On 5/21/23 03:58, Randy MacLeod wrote:

 On 2022-12-19 14:49, Zheng Qiu via lists.openembedded.org wrote:

 On Dec 19, 2022, at 7:50 AM, Ola x Nilsson <a class=3D"moz-txt-link-rfc2=
396E" href=3D"mailto:ola.x.nilsson@axis.com">&lt;ola.x.nilsson@axis.com&g=
t;</a> wrote:

 On Mon, Dec 12 2022, Randy MacLeod wrote:

 CCing Richard

 On 2022-12-12 05:07, Ola x Nilsson via lists.openembedded.org wrote:

 Hi,

 I've been looking into using the pressure stall information awareness of
 bitbake

 That's good to hear Ola.

  but I have some problems getting it to work.  Actually I think
 it just doesn't work at all.

 Doesn't work at all?

 Well that would be surprising. See below.

 OK, it will occasionally block a task. But since the next attempt will
 always be a very short time interval it will almost always start a new
 task even if the pressure is high.
 At least this is what I observe on my system.

 &lt;snip&gt;

 1. Rather than just keep track of the previous pressure values
 seen more than 1 second ago as done currently:

       if now - self.prev_pressure_time &gt; 1.0:

 and always using that as a reference, we can
 store say 10 values per second and use that as a reference.

 There are some challenges in that approach in that we don't control
 how often the function is called. Averaging over the last 10 calls
 is tempting but likely has some edge cases such as when there are
 lots of tasks starting/ending.

 2. If there has been a long delay since the function was last called,
 we could check the pressure, sleep for a short period of time and check =
it
 again. Some people would not like this since it will needlessly delay=20
 the build
 so we'd have to keep the delay to &lt; 1 second. Too short a delay will =
reduce
 the accuracy of the result but I suspect that 0.1 seconds is sufficient=20
 for most
 users. We could also look at the avg10 value in this case or even some=20
 combination of
 both the current contention and avg10.

 3. Just calculate the pressure per second by:

    ( current pressure - last pressure ) / (now - last_time)

 This could handle  short time differences such os milliseconds
 as would be a 'cheap' way to deal with long delays. In your case,
 the pressure would be:

   978077.0 io_pressure 1353882.0 mem_pressure 20922.0

 divided by ~19 since the initial values were close to zero.

 Then for the next time, just 0.1 seconds later:

 1670840042.384582 cpu_pressure 8978077.0 io_pressure 1353882.0 mem_press=
ure 20922.0
 1670840042.384582 cpu io  pressure exceeded over 18.677629 seconds
 1670840042.486946 cpu_pressure 466.0 io_pressure 30792.0 mem_pressure 0.=
0

 Multiplying by 10 or easy calculation, the would be a pressure:

 cpu: 4660, io: 307920, mem: 0.

 Do you have another idea or a preference as to which approach we take?

 I think 3 is a good first step.  Using multiple samples could improve
 our calculated &quot;avg1&quot;, but lets do that later if needed.

 I agree; Randy and I have been working on patching make and have taken a=
 similar approach:

 make.png=20
 ZhengQ2/make at cpu-pressure github.com  =20
make.png
 Additionally, we found that when the pressure read is too frequent, we m=
ay get the same cpu pressure as an result,=20
 even if the pressure have actually changed. This is likely due to the pe=
r cpu variables used in the kernel.
 So, in addition to the algorithm Randy talked above, we also compares if=
 the cpu pressure has been changed, if not,
 we will return the last result that has been produced.

 I will CC you when I have a patch, and you can try it out before the com=
mit gets merged if you like.

 Ola,=20

 Does Qi's patch below help in your situation?

 I still want/intent to add a bitbake PSI test case that uses stress-ng t=
o induce load
 and a lightweight sleep task but there are never enough hours in the day=
/week/...

 The basic idea is to:

 1. Run a task that just sleeps for say 10 seconds and confirm that the a=
ctual
 execution time is &lt; 11 seconds or so.

 2. use stress to get the system into a CPU pressure environment above
 the current threshold for say 30 seconds and simultaneously / shortly th=
ere after,=20
 launch the same sleep task and confirm that this time, the actual exectu=
ion time of
 the launch to completion time is 40+ seconds.

 ../Randy 'getting caught up on email on the weekend' MacLeod

 =E2=9D=AF git show ba94f9a3b1960cc0fdc831c20a9d2f8ad289f307
 commit ba94f9a3b1960cc0fdc831c20a9d2f8ad289f307
 Author: Chen Qi <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Qi.Che=
n@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>
 Date:   Thu Apr 6 23:07:14 2023

     bitbake: runqueue: fix PSI check calculation
    =20
     The current PSI check calculation does not take into consideration
     the possibility of the time interval between last check and current
     check being much larger than 1s. In fact, the current behavior does
     not match what the manual says about BB_PRESSURE_MAX_XXX, even if
     the value is set to upper limit, 1000000, we still get many blocks
     on new task launch. The difference between 'total' should be divided
     by the time interval if it's larger than 1s.
    =20
     (Bitbake rev: b4763c2c93e7494e0a27f5970c19c1aac66c228b)
    =20
     Signed-off-by: Chen Qi <a class=3D"moz-txt-link-rfc2396E" href=3D"ma=
ilto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>
     Signed-off-by: Richard Purdie <a class=3D"moz-txt-link-rfc2396E" hre=
f=3D"mailto:richard.purdie@linuxfoundation.org">&lt;richard.purdie@linuxf=
oundation.org&gt;</a>

 =CE=94 bitbake/lib/bb/runqueue.py
 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80
=20

 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
 =E2=80=A2 198: class RunQueueScheduler(object): =E2=94=82
 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
                 curr_cpu_pressure =3D cpu_pressure_fds.readline().split(=
)[4].split(&quot;=3D&quot;)[1]
                 curr_io_pressure =3D io_pressure_fds.readline().split()[=
4].split(&quot;=3D&quot;)[1]
                 curr_memory_pressure =3D memory_pressure_fds.readline().=
split()[4].split(&quot;=3D&quot;)[1]
                 exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure and (=
float(curr_cpu_pressure) - float(self.prev_cpu_pressure))
 &gt; self.rq.max_cpu_pressure
                 exceeds_io_pressure =3D  self.rq.max_io_pressure and (fl=
oat(curr_io_pressure) - float(self.prev_io_pressure)) &gt;
 self.rq.max_io_pressure
                 exceeds_memory_pressure =3D self.rq.max_memory_pressure =
and (float(curr_memory_pressure) - float
 (self.prev_memory_pressure)) &gt; self.rq.max_memory_pressure
                 now =3D time.time()
                 if now - self.prev_pressure_time &gt; 1.0:
                 tdiff =3D now - self.prev_pressure_time
                 if tdiff &gt; 1.0:
                     exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure a=
nd (float(curr_cpu_pressure) - float
 (self.prev_cpu_pressure)) / tdiff &gt; self.rq.max_cpu_pressure
                     exceeds_io_pressure =3D  self.rq.max_io_pressure and=
 (float(curr_io_pressure) - float(self.prev_io_pressure)) /
 tdiff &gt; self.rq.max_io_pressure
                     exceeds_memory_pressure =3D self.rq.max_memory_press=
ure and (float(curr_memory_pressure) - float
 (self.prev_memory_pressure)) / tdiff &gt; self.rq.max_memory_pressure
                     self.prev_cpu_pressure =3D curr_cpu_pressure
                     self.prev_io_pressure =3D curr_io_pressure
                     self.prev_memory_pressure =3D curr_memory_pressure
                     self.prev_pressure_time =3D now
                 else:
                     exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure a=
nd (float(curr_cpu_pressure) - float
 (self.prev_cpu_pressure)) &gt; self.rq.max_cpu_pressure
                     exceeds_io_pressure =3D  self.rq.max_io_pressure and=
 (float(curr_io_pressure) - float(self.prev_io_pressure)) &gt;
 self.rq.max_io_pressure
                     exceeds_memory_pressure =3D self.rq.max_memory_press=
ure and (float(curr_memory_pressure) - float
 (self.prev_memory_pressure)) &gt; self.rq.max_memory_pressure
             return (exceeds_cpu_pressure or exceeds_io_pressure or excee=
ds_memory_pressure)
         return False

 ZQ

 /Ola

 ../Randy

 /Ola Nilsson

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#14206): <a class=3D"moz-txt-link-freetext" href=3D"ht=
tps://lists.openembedded.org/g/bitbake-devel/message/14206">https://lists=
.openembedded.org/g/bitbake-devel/message/14206</a>
Mute This Topic: <a class=3D"moz-txt-link-freetext" href=3D"https://lists=
.openembedded.org/mt/95618299/3616765">https://lists.openembedded.org/mt/=
95618299/3616765</a>
Group Owner: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:bitbake=
-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedd=
ed.org</a>
Unsubscribe: <a class=3D"moz-txt-link-freetext" href=3D"https://lists.ope=
nembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bit=
bake-devel/unsub</a> [<a class=3D"moz-txt-link-abbreviated" href=3D"mailt=
o:randy.macleod@windriver.com">randy.macleod@windriver.com</a>]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------dTQ8IBqATs2kFaJ2oSAW2n70--

