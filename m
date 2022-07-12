Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3EEC433EF
	for <webhook@archiver.kernel.org>; Tue, 12 Jul 2022 23:36:42 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.16127.1657668996197078344
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Jul 2022 16:36:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=X8k+hcfb;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=419250626b=randy.macleod@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 26CNUAPh018993
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Jul 2022 16:36:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=content-type :
 message-id : date : subject : to : references : from : in-reply-to :
 mime-version; s=PPS06212021;
 bh=3dI+wnwumL7/MO4/F6bsIEXAsXq6ZWYu+RpcCNslXIs=;
 b=X8k+hcfb7rmlp6K7V3nD8dAwomkeCFCvKqIcDqqMIKSU1lVb4xZ5X7jX6Gg+WCn6DTx8
 GdLMpjrDg+U4ODVvTJfFB7VJBDIFDnEarLLMGrAp4jSf40+NkQ1Qs4RYhPIPPNDMfk9h
 jSnUe7DdS5w+mCOhbwwglg7niOOljRZ6FN1xtoDE2mOAL2VfUnr+v5tO1/wRuKujcINd
 k6c3zIh84Qz59ayquFt2VoEJFXWeiHU8AyWks1UnKZrHNTnaAId90P7eMBq+riD5MFa1
 D1AhldnUjTjZgN38E1Jbnoc+mxxnhVRj5svUtuJW0aeqXMI8klS6Fg9iGtkby9xD0Crl xw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3h796ktmj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Jul 2022 16:36:35 -0700
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26CNaYQZ032106
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Jul 2022 16:36:34 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3h796ktmj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Jul 2022 16:36:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrv+DKMkvpPvfnqhnW6iQ1Dm50WQnRmZz+6W631pAzYxZ73g1uRwm6XjnjOcV8JkElfqd+T2tGC8cpEba7nURUZcL32BYhOpF6GnBQRYozFUOkZWobuXZ08NPorh+MI3wgb5yaWPtMa1ut7hjbTDzr83nYEPnQEmTxE7+D+qZtVMnRLWfudALj7zy2ZM1hrBRNurxfe+pOz/iyqJLH/feMlSYYRZikmmIcBHPjmQGwj14rOPuwIYfnN6MiihSIYPhpTqgegczMAfrOKYfVTOC62yhSjC9OWOjuFojtf/wm7d/g4D7tEM2i9WoeLP4NBs63savPN9ZMbQR7WM0riUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dI+wnwumL7/MO4/F6bsIEXAsXq6ZWYu+RpcCNslXIs=;
 b=ajhZ30qANkh5imrEX46zHetlIRzYpCVyMCcSLP2eJ6CrgBLLCp4/JlwkgSQDP0+CRSGOMyiCTQKUadjvCm+JBrDGJZSMhEZ01jo8yAjZutqXIRTaUyETgD2KIDw5VlXVx0FUtT/I2q749/QCd5LBfZ2ZYrhssCyJ4VoO3eUBuTbLUkx4PRBO9avu48pg2goTsKvWFdVB2Yw+V0qcvqcCJl1wkRiiyFB+/9XCiAU8Ij2Y/yz7+cHjJBnOqItL1UnCVZ8dPcnqosA0Vvk6Ib9pmha5y6eUe/Nrrqz9+lgXxaJuvmIgqd1rHY0z1ZHcaueqpzhzuKgV0QUsYUWWqEcFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 23:36:31 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::d84b:7432:aca3:bbff]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::d84b:7432:aca3:bbff%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 23:36:30 +0000
Content-Type: multipart/alternative;
 boundary="------------sh9M0t21JHPVIRjp60mnt5nT"
Message-ID: <0f5c8ce5-032b-0758-5423-f864b42d1c7a@windriver.com>
Date: Tue, 12 Jul 2022 19:36:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bitbake-devel] [PATCH v3] runqueue: add cpu/io pressure
 regulation
Content-Language: en-CA
To: Paulo Neves <ptsneves@gmail.com>, bitbake-devel@lists.openembedded.org,
        Aryaman Gupta <aryaman.gupta@windriver.com>
References: <20220706205048.2492443-1-aryaman.gupta@windriver.com>
 <24475.1657365757702269187@lists.openembedded.org>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <24475.1657365757702269187@lists.openembedded.org>
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ad9253c-a1a6-4fdd-de04-08da645f591b
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NwD7JxG6ObFAIu2IDczgT18odEw2da5KAUX0lh4mS3oeYF2Wrl3rsmc/95QnxuoPLpRqZMXZC4tOKkzVWJu8+1vV2lyd3Icxgy58SrIq7D8BcKZ3KHLda98GEe9xck+O02udVaK1j7vQwLfam3ohPetpBFMVQhBYUivO4/OxG3vlXx/u3w5hLxhNGtP5nsEQAYy98igjht8fWAXd0CyBZdlYkVX8NMgmuVvTgOTofHINLvZQXusJGZfqV50XEHNXXsXG7rCpJiIvoHG0JRnANVqkjosT/TOdgvbWpG6n7rTuszFy43Q0bUJQv6SMygjQr8cbQh0O2h5OhBHuJOM12c+aZUxhDC5ER+7nnSS0Rbizj6Ov5ZvxMVJjlfHJkxAItFwjywl/Wl40WlY0e+DbnIvSg8uUzJZQuyV6XBC2OroPreN7RiojqGEehdcaAV2YCrD94t5ma/iLo2SCbvmfa1jDdKVzeswC+59WVTzOhosJmaZyRkSxnL4SjQcs5rfHlH3hS40ut1Csd7wQdcQyCPkXb6goIw7WHtwZnBEIPiIV6KQMNJcI+uPTTw/jMBEZbYmWsHKmn8vFS/Ntvh7XVu9E2zZlajY8xx7sp15jwnJa7XGTPY0mhuetbsm+2H70omK2PGPU0N+sScI5ot770OGbsi9iFpNxG0HaDUDt8lqxevjLQ/0dINpY3ml6aJpRsqEF5XA7mj9TKmLnhbCGypa6N03+T6hFlQIb3lFnSM6A43ZwAVEwhq/0k8ZGPFK+nPMLu73ax29fTm3pL+MDVD9Ui+OULj3PtK+aOcsnz8tZh3XBMj67f8UYkjSMB5HyMFmhynW7qeCOayIEuFHjCouHwkEMRkmaqfw0dMtRtEN1jWimGIecdJvSnEPW245DXF9s0rk2MxjwCKlb1dhvqbgZajJx0DTbgOKOW4yZFwFtMmkKBWx7GStm4T0glLhF
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39850400004)(376002)(396003)(366004)(110136005)(966005)(66556008)(6486002)(41300700001)(166002)(86362001)(36756003)(478600001)(38100700002)(38350700002)(2616005)(26005)(6512007)(6636002)(33964004)(53546011)(31686004)(6666004)(52116002)(31696002)(66476007)(186003)(8676002)(316002)(66946007)(6506007)(5660300002)(8936002)(30864003)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Qk9XdHRDb0hPNzFJV2NYS2ZJdmpRZHF4SGZNYXo5UklacFVWcjVaRXpRWnBj?=
 =?utf-8?B?d3R6TWhWNHRBTldRTGdWQStiRUV3R2VVV21FUVZvbDRDWWJGM3Q5clFSaTFq?=
 =?utf-8?B?djNaNld5UExzTTU0a2JuUzY2WDdrWjN4ejFzQ3UyWW5WenF0ckt5THUwdnZX?=
 =?utf-8?B?a1Nad2NDM3V0N1U0aVY0cWc2bEU1WVQ0RDBjcU1ldDV3VHgwbzFZMjJsQlZt?=
 =?utf-8?B?VUcxTnV4L1lGZTJnQ2JSdnpJczJsYkc1TFZEY1BDSWJLcTJXWklZQmYrYlhq?=
 =?utf-8?B?bmE5dmZhYTBBWG54V01TWnF6d1lUMDZXUXl2N3pYRGsrOFpSM3BOMyt6bXZJ?=
 =?utf-8?B?amV0cXBXWEs5S2Irc3JBMTJoWS9mK0hJVUtwdmVFZXpEbktVNjdVSVY5MDJw?=
 =?utf-8?B?YXZXd21NVXFpSnl5dHhMR2pDaWFXN3dEYnRDbElyL291U3MyYUhNR0t6Y1FL?=
 =?utf-8?B?YTdEYTJXMUlxZHg2SEI2d2x3dVZWb25XQ3ovNEswNmZRWnFoV0JoaXVNUVp5?=
 =?utf-8?B?MURVa0F5V1VHM1N5RStUNXJ2bS8rczZ3SHZUc2dlTkVGZTI1ZXJxWitVdW1P?=
 =?utf-8?B?N0hscFphbWpIUktSNW5GZnhhZFBQd3B0SDFHc0QrTEVtTXZGTHFKRHp1RDdL?=
 =?utf-8?B?RGYwVlN0di9yOFdOc1o5b0t1QTJzUkMwWjRzeHpoMXpuWHkwcUFDZVB0aUU5?=
 =?utf-8?B?S3NXTUtpUmVPZXR3N3NTdXF0b3k3ZkZXWFRQVklrVlREbDdQRzMybWN3MG9E?=
 =?utf-8?B?amdCQWxtMG1pVmEzcWRmT3dNazZqbXVnTWtnNFNIR0RGZTJIdjNLVGx4V05X?=
 =?utf-8?B?VUJuUUZFUi92M1l0YUdpMiswcGFsaVM4bEhVL1U4WUZZcjZTWVJ1U1NVRnIx?=
 =?utf-8?B?YkxUbUt2d2p0ZWk0a1JaeHpQano1MjNXSlo2T2dvcWVHMXB1ZDl3TDZjUDRS?=
 =?utf-8?B?RVdpdWQ2d1JXc25pVi9vM0MxQ0ptYitteVBuazhTeVhpUXdtOWQzaUQyOXJI?=
 =?utf-8?B?SDZ1blFpeGNtOXBWeG1zUWlSQ2NYbkhjcUZPV2VJSjZvOWFBQ3JtOENHQUxB?=
 =?utf-8?B?OUcwV1VFVUd1blVJRWtvSFQ1OEJ0MFJDODBEMjE3YmxDaGlZdHdaYlJEMUNl?=
 =?utf-8?B?UWRJaEdRbjdUSGNsa0UvTURQKzAyVDdiTkptdXBHNkFhVmg4RkkzNnFsTXRL?=
 =?utf-8?B?cmttd1NKeGZxbjNkZkQvZEZnM3dMOEwwNHVQZ3pFTzV0eU5UeitJQmlqUG1o?=
 =?utf-8?B?VWtHeFhXeUJQMXpxdGVRSkk5UGdyeFpwQ2Jlck9zVzBCK05XZERYZ0NMd2tP?=
 =?utf-8?B?NGVuakNEdU12STVHV2swVHFmUU1VcXFWeVNyS2xXZVVZMndva2FHTmdFMDBl?=
 =?utf-8?B?MDdVT1V2U2FvL1pjenR5VWluTjNFMzkyTFVqRHdXN2NiUHpxU0gxWEhJUys4?=
 =?utf-8?B?WGh6MVM2TmJkUlhQYUNYN0VoZWJQdDc4bkxxRzNMQUQrQnczL2xHVHczQjQx?=
 =?utf-8?B?WVV0bThTc0xsVjBEaHZYWTZnbFd0clVyOVNpNGpCQzE0cmdVdk0xTGFMemk3?=
 =?utf-8?B?cmhtVmlXWDFrRFpueE5wWlpaQ1gwVTNNQ3RlbHNRVUV3dUNlS29ZMExHMWs5?=
 =?utf-8?B?QUhxdEhsZXFuTml1NzdSNDlIK3ZONE50Z0dCQnZKN3NKMWI3VElycUZZMlU0?=
 =?utf-8?B?d0p3aVZiaFV5NXNhREVBT0NuR3F4MFpnTjV5c0lVWE1idlY2Z0pNTmloeXFU?=
 =?utf-8?B?RHFVdDlZSVIwNnhFbktPb0FPdmR3S2xQQk5SLzZwZ3hrUTRjUnYyK2pNejRu?=
 =?utf-8?B?dWhPdDZCZFZ6bXRuR01OVnpRbmJSYnZ5anFWVlVocHZab0pBVS9xYmc5eDFS?=
 =?utf-8?B?UUtBZGdGNzFpQytqOG1HUndnYUQyTmVLaTN6WituYnpOMnMrVFhBRWw1Wk1z?=
 =?utf-8?B?bnJSbEFzNFRTczc4YXVTNXFXRVNiM3ZOdXBwMzFzVzFkYmxNbU1TSVFRV3J6?=
 =?utf-8?B?NFFrcGtFMmJzekd4L0dMMUN0TUl6bDNZTGR4dWpwbnRLRlJtQjVJMS9oY2lC?=
 =?utf-8?B?ZGtyTHRnYlZYdURnenNzWmdyblJFRGNNUWlhUnI4MlIxeGl6ckluQXpNS3pt?=
 =?utf-8?B?TmhOT0VBcUNVdkUzaEtCSVJ1WERpV0gzSGcxK21zdmR1bkV1eXZWblhMMDI2?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5ad9253c-a1a6-4fdd-de04-08da645f591b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 23:36:30.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 Be+i0Utee1GF22tfud6xn1nYZK5l5PZn9MvnelUngm5NGL6NuzZbo9u48Lzg1ptlywnNf9nYkJhiUvdg0SU1ys0KCGCHgDQ92srmfddsSlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-Proofpoint-GUID: YlIqZvxmhrtYIhZcAE-AynnITB2Apk0M
X-Proofpoint-ORIG-GUID: ghOZnmihyDpAPgE7k_MbD7MNMMVdk5J5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_12,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120096
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Jul 2022 23:36:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13821

--------------sh9M0t21JHPVIRjp60mnt5nT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-07-09 07:22, Paulo Neves wrote:
> On Wed, Jul 6, 2022 at 01:51 PM, Aryaman Gupta wrote:
>
>     Stop the scheduler from starting new tasks if the current cpu or io
>     pressure is above a certain threshold and there is at least one active
>     task. This threshold can be specified through the
>     "BB_PRESSURE_MAX_SOME_{CPU|IO}" variables in conf/local.conf.
>
>     If the thresholds aren't specified, pressure is not monitored and
>     hence
>     there is no impact on build times.
>     Arbitary lower limit of 1.0 results in a fatal error to avoid
>     extremely
>     long builds. If the percentage limits are higher than 100, then the
>     vales are rounded down to 100 and warnings are issued to inform users
>     that the specified limit is out of bounds.
>
>     The current bitbake scheduling algorithm requires that at least one
>     task be active. This means that if high pressure is seen, then new
>     tasks
>     will not be started and pressure will be checked only for as long
>     as at
>     least one task is active. When there are no active tasks, an
>     additional task
>     will be started and pressure checking resumed. This behaviour
>     means that
>     if an external source is causing the pressure to exceed the threshold,
>     bitbake will continue to make some progress towards the requested
>     target.
>     This violates the intent of limiting pressure but, given the current
>     scheduling algorithm as described above, there seems to be no
>     other option.
>     In the case where only one bitbake build is running, the
>     implications of
>     the scheduler requirement will likely result in pressure being higher
>     than the threshold. More work would be required to ensure that
>     the pressure threshold is never exceeded, for example adding pressure
>     monitoring to make/ninja.
>
>     Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
>     Signed-off-by: Randy Macleod <randy.macleod@windriver.com>
>     ---
>     * Changes in V3:
>     - Ensure that there is always at least one active task before
>     monitoring
>     pressure.
>     - Fix formatting issues and make code more Pythonic.
>
>     * Changes in V2:
>     - Replace subprocess() calls with open()
>     - Rename BB variables to BB_PRESSURE_MAX_SOME_{CPU|IO}
>     - Skip the checking of pressure when no value is provided.
>
>     bitbake/lib/bb/runqueue.py
>     <https://urldefense.com/v3/__http://runqueue.py__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvDNAxhxSw$>
>     | 48 ++++++++++++++++++++++++++++++++++++++
>     1 file changed, 48 insertions(+)
>
>     diff --git a/bitbake/lib/bb/runqueue.py
>     <https://urldefense.com/v3/__http://runqueue.py__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvDNAxhxSw$>
>     b/bitbake/lib/bb/runqueue.py
>     <https://urldefense.com/v3/__http://runqueue.py__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvDNAxhxSw$>
>     index 1e47fe70ef..eb3bea07a9 100644
>     --- a/bitbake/lib/bb/runqueue.py
>     <https://urldefense.com/v3/__http://runqueue.py__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvDNAxhxSw$>
>     +++ b/bitbake/lib/bb/runqueue.py
>     <https://urldefense.com/v3/__http://runqueue.py__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvDNAxhxSw$>
>     @@ -159,6 +159,28 @@ class RunQueueScheduler(object):
>     self.buildable.append(tid)
>
>     self.rev_prio_map = None
>     + # Some hosts like openSUSE have readable /proc/pressure files
>     but throw errors when these files are opened
>     + # and can't actually be read so don't check pressure in that case.
>     + if self.rq.max_cpu_pressure or self.rq.max_io_pressure:
>     + try:
>     + with open("/proc/pressure/cpu") as cpu_pressure_fds,
>     open("/proc/pressure/io") as io_pressure_fds:
>     + cpu_pressure_fds.read()
>     + io_pressure_fds.read()
>     + self.check_pressure = True
>     + except:
>     + bb.warn("The /proc/pressure files can't be read. Continuing
>     build without monitoring pressure")
>     + self.check_pressure = False
>     + else:
>     + self.check_pressure = False
>     +
>
> Can you extract the check into a standalone function returning a 
> boolean? It would be more readable and maintainable.


Good idea, Aryaman or I will implement it that way.


Btw, we've seen, as expected, that using the avg10 is effective but tends
to allow more work to start while pressure is ramping up from below 
threshold and
delays starting work when the average is above threshold but declining.

We've done some experiments with the 'some cpu total' values that 
responds to
changes almost instantaneously. We take the diff every second and if the 
delta exceeds
a threshold, new work is not started ( unless there is no active task ).

More to come in v4. Hopefully that'll be later this week pending some tests.

It would be nice to teach make and ninja about /proc/pressure and it 
shouldn't
be that difficult since they already monitor load when fed the -l flag. 
In the shorter term,
we want to focus on understanding what's causing the high (> 15 second!) 
IO latency spikes
on the Yocto autobuilder machines. eg:

../Randy

>
>     + def exceeds_max_pressure(self):
>     + if self.check_pressure:
>     + # Extract 'some avg10 percent values' from /proc/pressure/{cpu|io}
>     + with open("/proc/pressure/cpu") as cpu_pressure_fds,
>     open("/proc/pressure/io") as io_pressure_fds:
>     + curr_cpu_pressure =
>     cpu_pressure_fds.readline().split()[1].split("=")[1]
>     + curr_io_pressure =
>     io_pressure_fds.readline().split()[1].split("=")[1]
>     + return float(curr_cpu_pressure) > self.rq.max_cpu_pressure or
>     float(curr_io_pressure) > self.rq.max_io_pressure
>     + return False
>
>     def next_buildable_task(self):
>     """
>     @@ -172,6 +194,12 @@ class RunQueueScheduler(object):
>     if not buildable:
>     return None
>
>     + # Bitbake requires that at least one task be active. Only check
>     for pressure if
>     + # this is the case, otherwise the pressure limitation could
>     result in no tasks
>     + # being active and no new tasks started.
>     + if self.rq.stats.active
>     <https://urldefense.com/v3/__http://self.rq.stats.active__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvA4pIS4TQ$>
>     and self.exceeds_max_pressure():
>     + return None
>     +
>     # Filter out tasks that have a max number of threads that have
>     been exceeded
>     skip_buildable = {}
>     for running in self.rq.runq_running.difference(self.rq.runq_complete):
>     @@ -1699,6 +1727,8 @@ class RunQueueExecute:
>
>     self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS") or 1)
>     self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
>     + self.max_cpu_pressure =
>     self.cfgData.getVar("BB_PRESSURE_MAX_SOME_CPU")
>     + self.max_io_pressure =
>     self.cfgData.getVar("BB_PRESSURE_MAX_SOME_IO")
>
>     self.sq_buildable = set()
>     self.sq_running = set()
>     @@ -1733,6 +1763,24 @@ class RunQueueExecute:
>     if self.number_tasks <= 0:
>     bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
>
>     + lower_limit = 1.0
>     + upper_limit = 100.0
>     + if self.max_cpu_pressure:
>     + self.max_cpu_pressure = float(self.max_cpu_pressure)
>     + if self.max_cpu_pressure < lower_limit:
>     + bb.fatal("Invalid BB_PRESSURE_MAX_SOME_CPU %s, minimum value is
>     %s" % (self.max_cpu_pressure, lower_limit))
>     + if self.max_cpu_pressure > upper_limit:
>     + bb.warn("Percentage value of BB_PRESSURE_MAX_SOME_CPU %s rounded
>     down to %s" % (self.max_cpu_pressure, upper_limit))
>     + self.max_cpu_pressure = upper_limit
>     +
>     + if self.max_io_pressure:
>     + self.max_io_pressure = float(self.max_io_pressure)
>     + if self.max_io_pressure < lower_limit:
>     + bb.fatal("Invalid BB_PRESSURE_MAX_SOME_IO %s, minimum value is
>     %s" % (self.max_io_pressure, lower_limit))
>     + if self.max_io_pressure > upper_limit:
>     + bb.warn("Percentage value of BB_PRESSURE_MAX_SOME_IO %s rounded
>     down to %s" % (self.max_io_pressure, upper_limit))
>     + self.max_io_pressure = upper_limit
>     +
>     # List of setscene tasks which we've covered
>     self.scenequeue_covered = set()
>     # List of tasks which are covered (including setscene ones)
>     -- 
>     2.35.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13817):https://lists.openembedded.org/g/bitbake-devel/message/13817
> Mute This Topic:https://lists.openembedded.org/mt/92215602/3616765
> Group Owner:bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [randy.macleod@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

-- 
# Randy MacLeod
# Wind River Linux

--------------sh9M0t21JHPVIRjp60mnt5nT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2022-07-09 07:22, Paulo Neves wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:24475.1657365757702269187@lists.openembedded.org">
      
      On Wed, Jul 6, 2022 at 01:51 PM, Aryaman Gupta wrote:<br>
      <blockquote>Stop the scheduler from starting new tasks if the
        current cpu or io<br>
        pressure is above a certain threshold and there is at least one
        active<br>
        task. This threshold can be specified through the<br>
        &quot;BB_PRESSURE_MAX_SOME_{CPU|IO}&quot; variables in conf/local.conf.<br>
        <br>
        If the thresholds aren't specified, pressure is not monitored
        and hence<br>
        there is no impact on build times.<br>
        Arbitary lower limit of 1.0 results in a fatal error to avoid
        extremely<br>
        long builds. If the percentage limits are higher than 100, then
        the<br>
        vales are rounded down to 100 and warnings are issued to inform
        users<br>
        that the specified limit is out of bounds.<br>
        <br>
        The current bitbake scheduling algorithm requires that at least
        one<br>
        task be active. This means that if high pressure is seen, then
        new tasks<br>
        will not be started and pressure will be checked only for as
        long as at<br>
        least one task is active. When there are no active tasks, an
        additional task<br>
        will be started and pressure checking resumed. This behaviour
        means that<br>
        if an external source is causing the pressure to exceed the
        threshold,<br>
        bitbake will continue to make some progress towards the
        requested target.<br>
        This violates the intent of limiting pressure but, given the
        current<br>
        scheduling algorithm as described above, there seems to be no
        other option.<br>
        In the case where only one bitbake build is running, the
        implications of<br>
        the scheduler requirement will likely result in pressure being
        higher<br>
        than the threshold. More work would be required to ensure that<br>
        the pressure threshold is never exceeded, for example adding
        pressure<br>
        monitoring to make/ninja.<br>
        <br>
        Signed-off-by: Aryaman Gupta <a class="moz-txt-link-rfc2396E" href="mailto:aryaman.gupta@windriver.com">&lt;aryaman.gupta@windriver.com&gt;</a><br>
        Signed-off-by: Randy Macleod <a class="moz-txt-link-rfc2396E" href="mailto:randy.macleod@windriver.com">&lt;randy.macleod@windriver.com&gt;</a><br>
        ---<br>
        * Changes in V3:<br>
        - Ensure that there is always at least one active task before
        monitoring<br>
        pressure.<br>
        - Fix formatting issues and make code more Pythonic.<br>
        <br>
        * Changes in V2:<br>
        - Replace subprocess() calls with open()<br>
        - Rename BB variables to BB_PRESSURE_MAX_SOME_{CPU|IO}<br>
        - Skip the checking of pressure when no value is provided.<br>
        <br>
        bitbake/lib/bb/<a href="https://urldefense.com/v3/__http://runqueue.py__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvDNAxhxSw$" moz-do-not-send="true">runqueue.py</a> | 48
        ++++++++++++++++++++++++++++++++++++++<br>
        1 file changed, 48 insertions(+)<br>
        <br>
        diff --git a/bitbake/lib/bb/<a href="https://urldefense.com/v3/__http://runqueue.py__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvDNAxhxSw$" moz-do-not-send="true">runqueue.py</a> b/bitbake/lib/bb/<a href="https://urldefense.com/v3/__http://runqueue.py__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvDNAxhxSw$" moz-do-not-send="true">runqueue.py</a><br>
        index 1e47fe70ef..eb3bea07a9 100644<br>
        --- a/bitbake/lib/bb/<a href="https://urldefense.com/v3/__http://runqueue.py__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvDNAxhxSw$" moz-do-not-send="true">runqueue.py</a><br>
        +++ b/bitbake/lib/bb/<a href="https://urldefense.com/v3/__http://runqueue.py__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvDNAxhxSw$" moz-do-not-send="true">runqueue.py</a><br>
        @@ -159,6 +159,28 @@ class RunQueueScheduler(object):<br>
        self.buildable.append(tid)<br>
        <br>
        self.rev_prio_map = None<br>
        + # Some hosts like openSUSE have readable /proc/pressure files
        but throw errors when these files are opened<br>
        + # and can't actually be read so don't check pressure in that
        case.<br>
        + if self.rq.max_cpu_pressure or self.rq.max_io_pressure:<br>
        + try:<br>
        + with open(&quot;/proc/pressure/cpu&quot;) as cpu_pressure_fds,
        open(&quot;/proc/pressure/io&quot;) as io_pressure_fds:<br>
        + cpu_pressure_fds.read()<br>
        + io_pressure_fds.read()<br>
        + self.check_pressure = True<br>
        + except:<br>
        + bb.warn(&quot;The /proc/pressure files can't be read. Continuing
        build without monitoring pressure&quot;)<br>
        + self.check_pressure = False<br>
        + else:<br>
        + self.check_pressure = False<br>
        +</blockquote>
      Can you extract the check into a standalone function returning a
      boolean? It would be more readable and maintainable.<br>
    </blockquote>
    <p><br>
    </p>
    <p>Good idea, Aryaman or I will implement it that way.<br>
    </p>
    <p><br>
    </p>
    <p>Btw, we've seen, as expected, that using the avg10 is effective
      but tends<br>
      to allow more work to start while pressure is ramping up from
      below threshold and <br>
      delays starting work when the average is above threshold but
      declining. <br>
      <br>
      We've done some experiments with the 'some cpu total' values that
      responds to <br>
      changes almost instantaneously. We take the diff every second and
      if the delta exceeds<br>
      a threshold, new work is not started ( unless there is no active
      task ).</p>
    <p>More to come in v4. Hopefully that'll be later this week pending
      some tests.</p>
    <p>It would be nice to teach make and ninja about /proc/pressure and
      it shouldn't<br>
      be that difficult since they already monitor load when fed the -l
      flag. In the shorter term,<br>
      we want to focus on understanding what's causing the high (&gt; 15
      second!) IO latency spikes<br>
      on the Yocto autobuilder machines. eg:<br>
      <br>
    </p>
    <p>../Randy<br>
    </p>
    <blockquote type="cite" cite="mid:24475.1657365757702269187@lists.openembedded.org"><br>
      <blockquote>+ def exceeds_max_pressure(self):<br>
        + if self.check_pressure:<br>
        + # Extract 'some avg10 percent values' from
        /proc/pressure/{cpu|io}<br>
        + with open(&quot;/proc/pressure/cpu&quot;) as cpu_pressure_fds,
        open(&quot;/proc/pressure/io&quot;) as io_pressure_fds:<br>
        + curr_cpu_pressure =
        cpu_pressure_fds.readline().split()[1].split(&quot;=&quot;)[1]<br>
        + curr_io_pressure =
        io_pressure_fds.readline().split()[1].split(&quot;=&quot;)[1]<br>
        + return float(curr_cpu_pressure) &gt; self.rq.max_cpu_pressure
        or float(curr_io_pressure) &gt; self.rq.max_io_pressure<br>
        + return False<br>
        <br>
        def next_buildable_task(self):<br>
        &quot;&quot;&quot;<br>
        @@ -172,6 +194,12 @@ class RunQueueScheduler(object):<br>
        if not buildable:<br>
        return None<br>
        <br>
        + # Bitbake requires that at least one task be active. Only
        check for pressure if<br>
        + # this is the case, otherwise the pressure limitation could
        result in no tasks<br>
        + # being active and no new tasks started.<br>
        + if <a href="https://urldefense.com/v3/__http://self.rq.stats.active__;!!AjveYdw8EvQ!f65av5f_qIYMyIUWYyaF0PNd1UCdScGSGjGxc9BqGXoUFyz4ri56lFcyZy2KW4fxnf385-4EHu_lmvA4pIS4TQ$" moz-do-not-send="true">self.rq.stats.active</a> and
        self.exceeds_max_pressure():<br>
        + return None<br>
        +<br>
        # Filter out tasks that have a max number of threads that have
        been exceeded<br>
        skip_buildable = {}<br>
        for running in
        self.rq.runq_running.difference(self.rq.runq_complete):<br>
        @@ -1699,6 +1727,8 @@ class RunQueueExecute:<br>
        <br>
        self.number_tasks = int(self.cfgData.getVar(&quot;BB_NUMBER_THREADS&quot;)
        or 1)<br>
        self.scheduler = self.cfgData.getVar(&quot;BB_SCHEDULER&quot;) or &quot;speed&quot;<br>
        + self.max_cpu_pressure =
        self.cfgData.getVar(&quot;BB_PRESSURE_MAX_SOME_CPU&quot;)<br>
        + self.max_io_pressure =
        self.cfgData.getVar(&quot;BB_PRESSURE_MAX_SOME_IO&quot;)<br>
        <br>
        self.sq_buildable = set()<br>
        self.sq_running = set()<br>
        @@ -1733,6 +1763,24 @@ class RunQueueExecute:<br>
        if self.number_tasks &lt;= 0:<br>
        bb.fatal(&quot;Invalid BB_NUMBER_THREADS %s&quot; % self.number_tasks)<br>
        <br>
        + lower_limit = 1.0<br>
        + upper_limit = 100.0<br>
        + if self.max_cpu_pressure:<br>
        + self.max_cpu_pressure = float(self.max_cpu_pressure)<br>
        + if self.max_cpu_pressure &lt; lower_limit:<br>
        + bb.fatal(&quot;Invalid BB_PRESSURE_MAX_SOME_CPU %s, minimum value
        is %s&quot; % (self.max_cpu_pressure, lower_limit))<br>
        + if self.max_cpu_pressure &gt; upper_limit:<br>
        + bb.warn(&quot;Percentage value of BB_PRESSURE_MAX_SOME_CPU %s
        rounded down to %s&quot; % (self.max_cpu_pressure, upper_limit))<br>
        + self.max_cpu_pressure = upper_limit<br>
        +<br>
        + if self.max_io_pressure:<br>
        + self.max_io_pressure = float(self.max_io_pressure)<br>
        + if self.max_io_pressure &lt; lower_limit:<br>
        + bb.fatal(&quot;Invalid BB_PRESSURE_MAX_SOME_IO %s, minimum value is
        %s&quot; % (self.max_io_pressure, lower_limit))<br>
        + if self.max_io_pressure &gt; upper_limit:<br>
        + bb.warn(&quot;Percentage value of BB_PRESSURE_MAX_SOME_IO %s
        rounded down to %s&quot; % (self.max_io_pressure, upper_limit))<br>
        + self.max_io_pressure = upper_limit<br>
        +<br>
        # List of setscene tasks which we've covered<br>
        self.scenequeue_covered = set()<br>
        # List of tasks which are covered (including setscene ones)<br>
        -- <br>
        2.35.1</blockquote>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre class="moz-quote-pre" wrap="">-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#13817): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/13817">https://lists.openembedded.org/g/bitbake-devel/message/13817</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/92215602/3616765">https://lists.openembedded.org/mt/92215602/3616765</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:randy.macleod@windriver.com">randy.macleod@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------sh9M0t21JHPVIRjp60mnt5nT--

