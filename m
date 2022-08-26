Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDACFECAAD4
	for <webhook@archiver.kernel.org>; Fri, 26 Aug 2022 12:27:25 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.36347.1661516842825118801
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Aug 2022 05:27:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=ia1lOoS3;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=5237a95137=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27QC78sA029940
	for <bitbake-devel@lists.openembedded.org>; Fri, 26 Aug 2022 05:27:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id : date
 : subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=EfdWC9o/IFogxKWzKBQ6QNP9Ttb2xE8W6RZlWJTcdgA=;
 b=ia1lOoS3gJ4Mq2pptj8CDBJOEMP5N8AqMc7J10+JvLzA6r/Dsv/wr6jRrGy8razdRzrX
 Im0OFOPdbfMVPu4JfMracL1vNNy1HPIbZgbSNenGqLAaHxSvtyfhRGpI5SMK/CGYyihI
 1muvJlKufsVGZxrUQgbEX32rtHO8aoJznyc1WBztEkmYmHjW3P6R3Pgbw9XuvbXj9zmP
 0I1zZPXJhE0pXl50pcqO4bJxItPCgEUywddThFPpzEM7NSAbZLNW7npndCiz5WgHhD8i
 Zx9rAr+okARAK20dFWtQn5yCXo2cP3TXkuIBuQldPq5LpIIfROjSwzhXDTXllYv1qYLp HA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3j53rvaqnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 26 Aug 2022 05:27:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niOjvR8zVutvMiuQe0R7N/MkBty0g6wqWx+jV8SNIaI/lU42jGf3CW0Dy7JEiGdIAxVEsy+DjowXQQTJtGRFJt5fYCd/pYktduqIfxd120AoOXhpttSRXQV/nVqWNRQClGUiVrPmcBI9Kry/F4Er1H7V36bq00t3Ox7WFthM+CeczkKWnEgDjFRmkRJX4wbfl/4pGY1ngBZ8zGCBiRF2d0UT3GNB79TuruJZRPE1IaqjHhqBi4jPoUWGzAsxRJS3LPmytjV3aIZ9VpoEAVef0M0iov/WY7pjXoOrOuStJDyGvF3sMIUp3U0S4++7GfWt3aPgx/egKb7MwGr/fhNCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfdWC9o/IFogxKWzKBQ6QNP9Ttb2xE8W6RZlWJTcdgA=;
 b=XSvpncOuaeil7yUAosUGc5sVoWVAqcDI7Mvn7QjqwlHtG+ix5qc1Q0YdCjiUQHM8AfPdBHW9imx0jTM/wvbuKruSzS+mThmysUDJQyRN4Ag8KMoFpC5nmdgOoMwNDuviQZPJSFg/wcyVdEsb8i89V6YD9HocFog2V20bzXaW22prZ++rz5fhqkH8LY18VAN7zFS/1Nh08lMh5uLG3C//fXEfCk3Sx+73b/fj63eRwf/nwShgeUPBfUnV7xlicTKysTj9kFgQ55xvaNJl3qEJ7kiHgjydnGlxUyKO8YAv4mMndVs6jEzojhWSaiPcga64C2+sltIh1+KHA2SnUHuIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by MWHPR11MB2031.namprd11.prod.outlook.com (2603:10b6:300:29::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Fri, 26 Aug
 2022 12:27:19 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::3cda:360d:94b:1b67]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::3cda:360d:94b:1b67%4]) with mapi id 15.20.5546.025; Fri, 26 Aug 2022
 12:27:17 +0000
Message-ID: <d2a6d29d-b35f-13f8-bde3-7c955c9bdc6a@windriver.com>
Date: Fri, 26 Aug 2022 20:27:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bitbake-devel] [RFC][PATCH] bitbake: fetch2/git: Use git fetch
 to shallow clone revisions
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
To: bitbake-devel@lists.openembedded.org
References: <170EE40270CCF106.16609@lists.openembedded.org>
In-Reply-To: <170EE40270CCF106.16609@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0197.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::10) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e941f330-716f-41db-af31-08da875e50a0
X-MS-TrafficTypeDiagnostic: MWHPR11MB2031:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	drR2mTckH0+xTsxfCK2yRj/VXFwhmoTrYeLU6/ULaS0sTEWzehaRzlMPorGMAU5F3KflWbfz2vRvEAHpUVTLBudtmWrJqzRCLjauVgCRtdhdgrmIN2j6o2TCSGVpjSHmT9PQTzL37jEgSv3q0j/QJipFB3P5b4JqJVbKdOxHm5g1tkzRLe7HHqhEPdLJIPMT/yejLeevvwvNZluGh4fj+7AsVurDVV9rXT4BGbs8d8y0j3dqbqWkTiJPmcHmMxfz1kgkqlhxDMAKlrtghgySGDqfXQnzYFJgGkAxYvyTY9gf+04Cd2KeLXfET6gklgmALQvtZEVmvkz1/SB1U1BlLoxS5Zcq7mwwPsPCQx6nzvO1Ht0DH9N4en6a2o8omd2Fqh3JZ6kJy9wGQ1itAA8fi0uSWqjOBLVAYVrj+5mLHHe0317+PrzYT4z2HhthyMmnAkS4QI3TQnppd/jk3DG4544+dDko8z9rnWluXvUTDfEO6TVJlEAa5MzeCh80ILZvrmn0B5PIl+duVKh9sK223a80ivb0UZ7pu52Uvj8caeEUKR37tjKfIX2GZ80oai2HRN999MO80GhMUcB8zrGs36kefYcO4VIdro3PLdE8oWTs+gWVNv+J0ju4nigEpd7/3qdYJzxxyKpX5W2CN6m4WBcjNqZ3PFCzD4dVIj/10GMILEG+hhB7EKqCauSwQHSAoYjgpYkqI8/LoK9uD0l/7YXXcGbxqQIqDgGSUps6hUNb/RvZcK9bvyZGRBU0G/j1ySOaBfNw+6uTc4y5M6rZsPiZFfTADRyVWKxnaekv3MY7kEJnBSN0J8hDxB27xUMsjiAyd2Rtk1PGPchaE4m4G+due0+65wqlFrSQrS7frag=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(86362001)(31696002)(6916009)(26005)(2906002)(38100700002)(53546011)(6666004)(41300700001)(316002)(6512007)(966005)(478600001)(66946007)(6506007)(6486002)(2616005)(186003)(66556008)(8676002)(36756003)(31686004)(8936002)(66476007)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MmFNQktPRC9Namthd2l2SitZWUV4d08vN3I1QWdueG1VWmhMTVVFSmoxc05B?=
 =?utf-8?B?YWJlL0l0dzZ6M3J2UHBhdHZ5cFNmRzQzK3p3aFhxQkhVMkNYVll3cWpFV1di?=
 =?utf-8?B?VmFWMWRKWUxJRlZZUFFYUU1BZ3VSUVZWWE1VMytlTTNNR21Rb2M2MTYwUUZR?=
 =?utf-8?B?TG1ZRHZSWms4VVlaclNtamFTeXQ3bExJbHlnbUlVM2tHVXpzd1hiaWNOdlh2?=
 =?utf-8?B?SzcxSTZhbHYyNWpTTThlYW9NSnZhQXVaNFprbHJ0K0YzVldLTXJGS0w2VWVH?=
 =?utf-8?B?YVJJYy9SUWpZTjJMSVRiemdkTnRscmQvZ3ZqYnJ1TGdXNEZUUlg2RVNkUHUy?=
 =?utf-8?B?T2VKblU1dUorMXJjVUxzaWZ3RS82SjY5RWRRb1d0bGhXczNTT0NvcTFJcjJ3?=
 =?utf-8?B?T2FuL2QzMVdBeG5MOGZZNHlLUERsdmd3NlNWR28zeHU2dnJBTDJvc0hOaWhE?=
 =?utf-8?B?NjhCSGk3YmpXWXVLb2xFc0tMTWZ1L2FWdmUrUlVzYWhBb2dEOTNUZ0FHTmNR?=
 =?utf-8?B?Rjc5by9qMThlNTJhTCs2WmdmWUdIdXBhK2I0a2xoNUE1RWtLUVVLVmVxSVFN?=
 =?utf-8?B?ZVJzRkpEUzUvbUNqQ1R1b1J6MGRIdFMxanRPcmFNY2s4SS9ZQWtMT0J2aEVw?=
 =?utf-8?B?ZWdKdVZ5S1Z3a3VwblRlbFVRWGgvRDdBS2E5RkVRNkUrRjEwVUs2bVlJVW9G?=
 =?utf-8?B?SytPd2JoYXVKdW5VYlI3bXlwcGhaUENHR3NROU5BZncvMTBXcnErYjBzS0gr?=
 =?utf-8?B?aktjcERucGxtUzdsSWx2NXJvZzVvdTNJRjBndmUzUDl3UFJOVTVRUFl4amVs?=
 =?utf-8?B?RG5UbDhQMkpSTkk4bUU2Z2VxcFo5TFBYcVU3Q1lzTTNQd2xQdkVxT216dkhN?=
 =?utf-8?B?aXVDYjFCWGtaQTgvb0VDajEvVm1vd203cS9mTE50cGpWREE1dHhRWVhsdWRX?=
 =?utf-8?B?ejRsdUgyY1h6Mml6MHZXYjZJaW5RdHh0NXBlMkptc08vU1RoTkRJaUp5clpk?=
 =?utf-8?B?aTZDdzRVdHBobEtwTHdqTVRJOUk0aldCdThBMVEybW52em9UcmpORjF6em1M?=
 =?utf-8?B?MWFYMmJKbjFXNXNyUjB5SVZVakxaZWZlTXpzR3hNZ2dKOVdETXZEL3lPMlRS?=
 =?utf-8?B?bktMNEVLa0pxOXd1Yzg0ODc3NnJzaHJXSUtqMDQ4b3E4Q21UckdTZXU4aUh5?=
 =?utf-8?B?MEtiY3BzQm1IaytsSFY3dmN1andEV0ZnSHl0N0xodnlJMi9EeXUwUUZMVmJz?=
 =?utf-8?B?VGl0TlVEWENxeTBuYlBmQ2liZDFXMTZGZ001Q2d4cWZHdDkzWHRHa2lFck1M?=
 =?utf-8?B?MnIvU2RMWTh6YW8rN3hLNmp4ci9hV3g4cXozaXNXYjBZcE5ONHgvL3NRYS8v?=
 =?utf-8?B?amhHMHZoVnpOdmtGV2FncnF4QVRXZzBDQ0dGWU9BRVNvdDlhOGU5RVBMc0xW?=
 =?utf-8?B?OHhrOWFMdU83clNyYmp1cDBmdlkxTXJnNVNSZ09GckJJeTdBOFczL2VoaHda?=
 =?utf-8?B?L0RpOHA0NWhPc3VqTGxvOEhJdTgvOUsxaE5acS9TQnM0ZlVNRWRhZU1acGNv?=
 =?utf-8?B?czVUM09DUUVzQkV5bDFRVC9sR0RXTnhrNjhSRmQ0a1oybmRTL0FrN2dyS09D?=
 =?utf-8?B?OFdndTZzRXVYMk5taENNSEhkZ2c2VWplSW9tem1VQ2dvbDdwT29jc09LWVJq?=
 =?utf-8?B?RnVsRnVuWTJTc3djTGZXSmZHcWV2d1pXL050MjV0ZjlHem0zdklIU1l2aUNh?=
 =?utf-8?B?NUJYKzN0UWRDbmNGQmRTSzFNSSs0YjJ0MHNNQWJoVkpoa3EwUWczSC9wNDRY?=
 =?utf-8?B?aWlwbnBDc0QvTXgrVnhNbmRETHI4Z3haUXU0b09wT0szWFdSVm9CekNiZmFp?=
 =?utf-8?B?R2l3eWhKazRtd2ZObVRxUXZoMTc0c09vNVlVWWsyL2JkUVZZUGFDRzZuUita?=
 =?utf-8?B?eW9xalRkVGYzaVZua0VsK2Y5Y216eWgyNXRma2F0UFBBZWFzTkZNUWhKbElr?=
 =?utf-8?B?V3pQVnZSblA1N1R6and2UWR6TGhDTGFubThJSWFMem92WklNMkltN2RpZk1t?=
 =?utf-8?B?SjhhVis0WGR1ZU5mY0UyK0FVSTdsZUhNbGNDaE5wM0NJZ0FYWmE1VnMwcWJY?=
 =?utf-8?B?ZC82SStqUFAyWHFMWnhXQXJUVzVETjJQM1ZRK3Z3Yy9MWGpxbFBBa2JlaGdS?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e941f330-716f-41db-af31-08da875e50a0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 12:27:17.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 2A5nEC5UQBhUhapB4cbrDp/2uXJ0TChoggrOeHaD0uvRFRWvC2xilKo4jx8tAtxXK7+HjD5Nbgs/16DqyUCoqlXQuh19f8t4GFd0GcbUoNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2031
X-Proofpoint-ORIG-GUID: m59Ov38DwLyqH4vhGx8foXWQF3vsWFxF
X-Proofpoint-GUID: m59Ov38DwLyqH4vhGx8foXWQF3vsWFxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_06,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260052
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Aug 2022 12:27:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13938



On 8/26/22 8:13 PM, Robert Yang wrote:
> The "git clone --depth" only works for refs, doesn't support revisions, but
> "git fetch --depth" supports revisions, o use it to do the shallow clone, so
> use it to do the shallow clone, the idea is from
> "git clone --recurse-submodules --shallow-submodules".
> 
> The workflow is (Only enable when BB_GIT_SHALLOW = "1"):
> $ git init --bare <clonedir>
> $ git remote add origin <url>
> $ git fetch origin --depeth <depeth> revision
> $ git branch <branchname> FETCH_HEAD
> $ git tag v<branchname> FETCH_HEAD
> 
> Here is the testing data based on poky, the testing server has a very good
> network bandwidth:
> 
> Add 'BB_GIT_SHALLOW = "1"' conf/local.conf
> $ rm -fr tmp downloads # Fresh download for each build
> $ time bitbake world --runall=fetch
> 
>         Full        Shallow      Saved
> --------------------------------------
> Time:  15m59        2m31         84% (13m28s)
> Size:  1.2G         12G          90% (10.8G)

Sorry, here should 12G -> 1.2G, saved 10.8G, not increased.

// Robert

> 
> * Size is the size of downloads/git2/, the tarballs are not counted.
> 
> We can see that it saves a lot of download speed and disk space, for example:
> 
> linux-yocto: 2.8G -> 228M
> llvm: 2.5G -> 171M
> cryptography: 1.5G -> 35M
> 
> And "$ bitbake world" works well.
> 
> This a RFC patch, feel free to give you comments.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>   bitbake/lib/bb/fetch2/git.py | 83 ++++++++++++++++++++++++++++--------
>   1 file changed, 66 insertions(+), 17 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 4534bd75800..57bb61d5ee1 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -244,6 +244,7 @@ class Git(FetchMethod):
>                   ud.unresolvedrev[name] = 'HEAD'
>   
>           ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false -c core.pager=cat"
> +        ud.basecmd = "LANG=C %s" % ud.basecmd
>   
>           write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
>           ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
> @@ -344,6 +345,49 @@ class Git(FetchMethod):
>               return False
>           return True
>   
> +    def shallow_clone_by_fetch(self, ud, repourl, d):
> +        """
> +        Use "git fetch --depth <depth> revision" to implement shallow clone
> +        since git can't clone a revision, a better solution should be:
> +        "git fetch --depth <depth> revision:<branchname>" but it doesn't work
> +        when revision is a tag, e.g.:
> +        error: cannot update ref 'refs/heads/master': trying to write
> +                non-commit object <revision> to branch 'refs/heads/master'
> +        """
> +
> +        import datetime
> +
> +        depth = ud.shallow_depths[ud.names[0]]
> +        revision = ud.revisions[ud.names[0]]
> +        branchname = ud.branches[ud.names[0]]
> +        if not branchname:
> +            branchname = "master"
> +
> +        # Rename branchname if it exists which can:
> +        # - Avoid conflicts during update
> +        # - Keep the revision on a branch so that "git submodule update --recursive"
> +        #    can work since it requires the revision on a branch.
> +        branch_path = os.path.join(ud.clonedir, 'refs/heads/%s' % branchname)
> +        if os.path.exists(branch_path):
> +            os.rename(branch_path, '%s.%s' % (branch_path, datetime.datetime.now().strftime("%Y%m%d%H%M%S")))
> +
> +        init_cmd = "%s init --bare -q" % ud.basecmd
> +        add_remote_cmd = "%s remote add origin %s" % (ud.basecmd, shlex.quote(repourl))
> +        fetch_cmd = "%s fetch --progress origin --depth %s %s" % (ud.basecmd, depth, revision)
> +        # Create both branch and tag for the revision
> +        branch_cmd = "%s branch -f %s FETCH_HEAD" % (ud.basecmd, branchname)
> +        tag_cmd = "%s tag -f v%s FETCH_HEAD" % (ud.basecmd, branchname)
> +
> +        if ud.proto.lower() != 'file':
> +            bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
> +
> +        if not os.path.exists(ud.clonedir):
> +            bb.utils.mkdirhier(ud.clonedir)
> +
> +        progresshandler = GitProgressHandler(d)
> +        for cmd in (init_cmd, add_remote_cmd, fetch_cmd, branch_cmd, tag_cmd):
> +            runfetchcmd(cmd, d, log=progresshandler, workdir=ud.clonedir)
> +
>       def download(self, ud, d):
>           """Fetch url"""
>   
> @@ -360,7 +404,7 @@ class Git(FetchMethod):
>               else:
>                   tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
>                   runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
> -                fetch_cmd = "LANG=C %s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
> +                fetch_cmd = "%s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
>                   runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
>           repourl = self._get_repo_url(ud)
>   
> @@ -369,27 +413,32 @@ class Git(FetchMethod):
>               # We do this since git will use a "-l" option automatically for local urls where possible
>               if repourl.startswith("file://"):
>                   repourl = repourl[7:]
> -            clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
> -            if ud.proto.lower() != 'file':
> -                bb.fetch2.check_network_access(d, clone_cmd, ud.url)
> -            progresshandler = GitProgressHandler(d)
> -            runfetchcmd(clone_cmd, d, log=progresshandler)
> +            if ud.shallow:
> +                self.shallow_clone_by_fetch(ud, repourl, d)
> +            else:
> +                clone_cmd = "%s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
> +                progresshandler = GitProgressHandler(d)
> +                if ud.proto.lower() != 'file':
> +                    bb.fetch2.check_network_access(d, clone_cmd, ud.url)
> +                runfetchcmd(clone_cmd, d, log=progresshandler)
>   
>           # Update the checkout if needed
>           if self.clonedir_need_update(ud, d):
>               output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
>               if "origin" in output:
> -              runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
> -
> -            runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
> -            fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
> -            if ud.proto.lower() != 'file':
> -                bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
> -            progresshandler = GitProgressHandler(d)
> -            runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir)
> -            runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
> -            runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdir=ud.clonedir)
> -            runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d, workdir=ud.clonedir)
> +                runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
> +            if ud.shallow:
> +                self.shallow_clone_by_fetch(ud, repourl, d)
> +            else:
> +                runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
> +                fetch_cmd = "%s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
> +                if ud.proto.lower() != 'file':
> +                    bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
> +                progresshandler = GitProgressHandler(d)
> +                runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir)
> +                runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
> +                runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdir=ud.clonedir)
> +                runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d, workdir=ud.clonedir)
>               try:
>                   os.unlink(ud.fullmirror)
>               except OSError as exc:
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13937): https://lists.openembedded.org/g/bitbake-devel/message/13937
> Mute This Topic: https://lists.openembedded.org/mt/93268338/3616940
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liezhi.yang@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

