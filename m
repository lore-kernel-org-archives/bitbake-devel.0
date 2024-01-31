Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DD2C47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 03:54:05 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.6980.1706673240726721074
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jan 2024 19:54:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=akFSENeE;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=27603b1cdb=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V3mfu6022587
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 03:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=gV0xbGWtiNzgCdT5GYuZng0ZuX0UtAztR6RDkDneYp8=; b=
	akFSENeEsZte5Dt0i0okNsRZCgVrqNx6SDkxwFEB09bV0pMBRylCECgXgnvstw94
	uPNcOLU8JdkzUvR5Sf9WVV6S1sXe693GNfDv/QE1QW57evYzoN0uolXTyG5VmzT+
	fp4+0VDHpLyrgzQi57JYVQ4BjnqgAr/6VZF6b8PUM2GgyDBWGwotMds9od0swc9i
	nxvgNXNjZDc7v8ABPMRUSeqlUZCbzMBMyK89y5OqN2X2ensiwSY8iG0iTb7YA0kV
	oMseunbryGdS/pJsoIlp24zrS75mx0OUgkzqw9K7VnvJGmMd9JRnzbVry8J5Z+Mj
	qZjp8udCavoUwl23DUaGQg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vyatvg50c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 03:53:59 +0000 (GMT)
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 40V3rxqf028469
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 03:53:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vyatvg50b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 03:53:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA8E1SwKI4Ni0cvJdODBZj7HZ3XYbkVQxv8slJh6mqViqoFi4yW8jaOVU0POl/v9TObJeAbufeTG4cI/J9LkbPNTyZycaQYkKAiPeE1BlFo4XiXWPqXRocKbbI/E6RM4WwLCsnIs7kAzvSHCkK1Hsic6oScXHtHiAX69JIJut7rfphXj1TLSFkrPM7KaV/b8DwMX+DRgr5WtPRhkYlfJDI5/Vzf6sEelSD5LmTHZQgqnKK6b+vboXb7WmeSjd7VK/epX+J+I4GHw05GXvFg1PHaSu9XBB2oQ5EUGRl/3hxVk46BJ5gmSNWzZe1IgKuESfUORBF/b/5tk6IV4OJeahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV0xbGWtiNzgCdT5GYuZng0ZuX0UtAztR6RDkDneYp8=;
 b=XO7Yw03/iieaiioI0qd17F8ZJuWNGm+NJplglWIaAdCbRaUkf2rZn+GHw6bab6EcuihfZv9mJa0oHkJpEEA0GcAmYJyY68+n8VdOa9FiouhTXNIzn0M3STaChTUjOsiZ4Cx5tBc96LYeXM4U36kEPdSp1kRtbrpFllDlXFuoC11pQxnbRX422xpLaPDTz23ZiMyABj0uGR1NnFy9FlvaSMlK8KilJSlR6Avg3kJGO2i4GtkO8mKcwqrG6mkVryxnz9nLDNKMkSwLQeLSEnX/dTAuGv2573phvo75sOzjGLIHB79xYzlG5esVBZeqAzTEeJCOrubalRjZ+MFjzECzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by LV8PR11MB8487.namprd11.prod.outlook.com (2603:10b6:408:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 03:53:55 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 03:53:55 +0000
Message-ID: <0b842389-284d-0709-1dd8-ad63e2f8921f@windriver.com>
Date: Wed, 31 Jan 2024 11:49:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch2/git.py: Fetch mirror into HEAD
Content-Language: en-US
To: Pavel Zhukov <pavel@zhukoff.net>, bitbake-devel@lists.openembedded.org
References: <20240127121536.2849664-2-pavel@zhukoff.net>
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <20240127121536.2849664-2-pavel@zhukoff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|LV8PR11MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: b14b2820-22ad-41b5-a5e8-08dc22103efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gC9HJxbt07JyYFiUwCdeQDCx/cK1uDsMMmUAzIAdID5YoMju2rkWRW6la1tXD3mjfbmWG0XXaRcx4BXgc9Pa1qRhL1PwyqEbSEzkn2QpFj3SpuKPyZ5GEAql91t624IwKx6xuVV2RVF/JA0P7dW6x7cFnonhals8TP/Fwx9gCW3PG6LvLq25KSV67095+ePHkjxtHpUly2aJv/KPbj6LuMtwhFb/4yLIF9dePG3qNthng7foxuQbft9MSNNXFPMwGck+YrIiT+0FnIrFu9z5vBQ0JGaGuRsjJdQJSS/IK+FgDU4gV1oOQFoyI4syzwsUaE1gWnF7Qtesovvx/RFIYsxhELHOtB5HztGdn1/HHqsWDHf2fw85yZaWgo9vrnbeROcstdl0xJ848K90TJSNNuZmRLanFBlL/5uDCLwQvlGzGP8BjvtjjoVF/e4dNySazaWZrGie2OVUaNz8Qx+URe2gdHDSMDqfIG+s+0HWLO6fyTVsjoQY9HYTReq4h1fDo0mInndY3hVMC5pj8eslKUkZ4muj4WUm4L9PJF0od2/4FvqhlqqFrceMClqXuIm+I0+0puVwG+Rxk/O1s7uQxxCRnq1mUGXYeEkwKhLoDMLBaZttdf3G1hOk5Mln/adYcFyP7/6gRocasmD9uxph+tJHnBFCGIsxV0xsHSC8u4oYmKgERYuj9O/JHMsRtqws
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(376002)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66899024)(8936002)(8676002)(2906002)(5660300002)(31696002)(86362001)(66946007)(66556008)(66476007)(316002)(36756003)(38100700002)(53546011)(6506007)(6512007)(478600001)(6486002)(966005)(6666004)(83380400001)(26005)(2616005)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rm9pYXh0SldPQk5MM0UvbTZMeFhDV3VGbGFlZ2RyTjFwRlFnV1B3R0ZjNVlK?=
 =?utf-8?B?QlJpREhkcDYzM1ZIY1RhTnpQOGMzSFI3WVpmY2xYcGJmMXFIUzMyTDZPa0JT?=
 =?utf-8?B?dVhVUUVURW8rOGI3RXBHYTBzNmcvVUVCUFNCT2VDTUJVcXk0Tlp2REZBYjB0?=
 =?utf-8?B?cEpvaXlGMUI3My9EakdacXhzRDFQaGFPMjhOYytWak5NWlhaTjdJU0owamxx?=
 =?utf-8?B?QkJPL2tieGZFT1o5STYyNm92Tno3aEtJV2JSK2ptbGJOdGcxcjl4RHRkeHNj?=
 =?utf-8?B?cVBiejJqR0JiZktMZmNvSE9PZjN5T3V4d1FSSklBZ1VyZm1BeG9DWVN4enpH?=
 =?utf-8?B?YVlVMzRQbWNURTI2cEk5NlFXM3pNa2plZXdRaFFIR0J2R1ozT1pEU201Mkh5?=
 =?utf-8?B?eHE5N2szbmRwNlZuN3dRSDdBbm5PMUU5U2VKWlhjeDdrR0lTcHRUMVhpT0Mr?=
 =?utf-8?B?QmUwbTFBb3RpdlV2dzV2SG9RUkJ4Nm5Ka1UveDRZVm1MWHNhNlNMdmQzR0ZZ?=
 =?utf-8?B?bXFQVFJCVm9qUHVJOFNXYUMxYnJBYWFZMVVOY3p6ZXpaTDBrRWk3VWtCQnll?=
 =?utf-8?B?UC96cWpOamZLNm1EMjl1bzYrSnFZdFFXc29xNFk5TkRLQStSNjVlM21TWVRZ?=
 =?utf-8?B?VmxtMGZEK2F4cTVNbzJMRFJndDhYMTVyUDRhVHhJSUp2NUFNd0ZkS1YydFBv?=
 =?utf-8?B?ODNlTEZCUnNycEd6dy8vRzlwQUU3VVhqQUxCeDJUck1jUmdIb2dOdHIxVWxw?=
 =?utf-8?B?ckhleHNMWUdLUWRCRXVzRWU5TVFMUEtrTHROQ3FSVlFaSmErd1A5Y0VEdStO?=
 =?utf-8?B?dUFINUNDRDJ5bnRXK1ZmSTNkWEdZZVFFa3ptRkhJTVk4UU5DNks2Z0doZHVS?=
 =?utf-8?B?OCtVM2Jic3ZHZ1F1TWpnZEFYUS9GNWZZeWI1SHFJREtNazhGZUFjaU50S2Zn?=
 =?utf-8?B?UUpJeStWd2kwYklHWWV2L0hVekNNZHlzblZhbURkVHpSUlZneHRRbHVURXRO?=
 =?utf-8?B?eWRCTkxjblkwbWlicllTSDZYc0dtMlNJNldlRG1jb24va2toSE44NDdVVkNX?=
 =?utf-8?B?L2hkWklBY1lHbmZDaWtxenhldTQxZjQva2lSOG85cGJLOXQxak1lRmdXR3Uw?=
 =?utf-8?B?THZ1bzNUMTBqUy9jQjliaVBBS2NFTzJTei9PT1N3TTB4dllvazMza2VCT3Nt?=
 =?utf-8?B?RUlwMUVDZHBtVGlib1pNQ3Znd3J1U05lNVp2Q2w3M2lGajZRWitNWEp6UFFZ?=
 =?utf-8?B?MGpjRUhoZDFLUDhCSS9vS3NRL3Z4UlhNMlJrckJ0dThqUU1pd1VzTWl2Zk5h?=
 =?utf-8?B?ak5XamhPK1EvVHM5eDhFSXpGUXJDSmYyZnVUUVo5STBhMjk3Zm53ZnRDR214?=
 =?utf-8?B?M2NQbUJYSDI0djFxNnNDSGVHZGVlVHJJajMzamg0NzIxNHBySjNPaDJmTTBw?=
 =?utf-8?B?bDhzSTBZakp6ZTNtNFN6Skk0d3lHY3QwcWgwNUNGRmdmdkR6bWJXMk9Kc3kr?=
 =?utf-8?B?OGFwMUg3Nk45ZWRCU2ZmbWpqUnNkWkxnOXNiYjA5d0FJRFl5UDJDNDZiWW5U?=
 =?utf-8?B?b3RzVkM0NDk4UzlaNU93eXBrNXR1TUVpY3phOUxRR01YeDVzeWE0UW82WkdY?=
 =?utf-8?B?SUNXZ1pBelZKZGdheCs2OVovSjVSM2x1aGdzUGQ2MkJwZ3lvSXVRT2szUkJj?=
 =?utf-8?B?aEMrSXBpL2s3dEs0YXVBQU1KL2dvY3B1Z0t3TGNBK3kxanlpZUlPVEdPWXdC?=
 =?utf-8?B?MWhaeEROLzUrMkRmQlJNUTZVOEZibHdMUFE2dEdwNUxJQVpoQUZ5VlpQR3N3?=
 =?utf-8?B?ellnZ3lYNnNDZ2xlQVJnU0NRemsyL3ZGUXVWRXE1dms3amZobW10S1l6TUV5?=
 =?utf-8?B?Sy9NdXVSbm84djRDTFlRZExaNTdsV1c2VHRCWVRBNjBUL09wZlFQUjloczEr?=
 =?utf-8?B?bmpNSXR5V29Yc2lmWXJrNW8wM3hWTjRUZTZjT3JEQm1ST2RMSDVWdS9VOXh3?=
 =?utf-8?B?MFVBcjRoc1JPdTZweExtWXRIWWdaRVBEM2pWa1ZUZERzMVhNdGgxenVqWENm?=
 =?utf-8?B?ekZyaHVGVmVET2llNndBVllSWllIQmdqSHU2Q0ZzVHlicDBhMUt3Y0h1L1dz?=
 =?utf-8?Q?aSJbeQw0jcOVAWlPfZITHajpt?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14b2820-22ad-41b5-a5e8-08dc22103efd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 03:53:55.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6qKRoByX1odXWW+HOGUSGxMCozSRuTSnssUD2PLbYV9SVfxMwMXJTdzeorCSdjNai1fMQUkzZwNRa/NvGShlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8487
X-Proofpoint-ORIG-GUID: gof2MzvEbp4-g7g6NUs4IHerZFAVsJq0
X-Proofpoint-GUID: jBw2QCZRj5zB9Jdp00h-Kq7Qp2OFiDIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310030
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 03:54:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15813

On 1/27/24 20:15, Pavel Zhukov wrote:
> Fix the issue with using of (pre)mirror in case if clonedir exists but
> outdated.

If I understand it right, the error only appears when 
BB_FETCH_PREMIRRORONLY is set, right?

If so, could you please update the commit message to include this 
information?

Regards,

Qi

> Previous version of the code fetched new mirror content into FETCH_HEAD
> instead of branch which caused refetch from the upstream. Add new remote
> add fetch from it instead so the ref can be found by "_contains_ref"
>
> Fixes [Yocto #15369]
>
> Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
> ---
>   bitbake/lib/bb/fetch2/git.py | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 0deeb5cee1..b4497911f1 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -375,7 +375,11 @@ class Git(FetchMethod):
>               else:
>                   tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
>                   runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
> -                fetch_cmd = "LANG=C %s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
> +                output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
> +                if 'mirror' in output:
> +                    runfetchcmd("%s remote rm mirror" % ud.basecmd, d, workdir=ud.clonedir)
> +                runfetchcmd("%s remote add --mirror=fetch mirror %s" % (ud.basecmd, tmpdir), d, workdir=ud.clonedir)
> +                fetch_cmd = "LANG=C %s fetch -f --update-head-ok  --progress mirror " % (ud.basecmd)
>                   runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
>           repourl = self._get_repo_url(ud)
>   
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15800): https://lists.openembedded.org/g/bitbake-devel/message/15800
> Mute This Topic: https://lists.openembedded.org/mt/103994536/7304865
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


