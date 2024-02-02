Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186FCC47258
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 04:24:56 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.15988.1706847894804413534
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Feb 2024 20:24:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=Fo0jVFVm;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=27622a5336=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4123pbdq028005
	for <bitbake-devel@lists.openembedded.org>; Fri, 2 Feb 2024 04:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:message-id:date:subject:to:cc:references:from
	:in-reply-to:mime-version; s=PPS06212021; bh=0eFwVcuHXvgjSaHNzrk
	8flbKyfkCVnFwCbW6Nn+MAuE=; b=Fo0jVFVmSq2qdmqOptCyIQZubEK/Tw3VyBO
	Z9vUVks1sGcHMiKj0sn8TA9Mytm23UlDegEwR3W5eIX7eSIlVSav8/hvpQcoikCr
	VYfXERDPiNqZJCxxNvvo8jV/uzgvp5opHfG7mnu4GE1f3whPPH6kkByxapoC0EGI
	nxkhng6/fzIh97/w0kUU9RIB/atelyZJN5GuG7SPkqab0uVCL+6qniZKIyzSpeYI
	d2GzK+cpRoEwIGXFPoDJcZOQv6IKtSpTaETpW24aNHC+Pl0TYASY1qbzFQbkXmY/
	OZ3sAn1OG6iF+RRQJPfHWzgRzW57uWC2dxeU/ZmPGTZ7LFdwqWA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w0pvg036n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 02 Feb 2024 04:24:53 +0000 (GMT)
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 4124OrjD000586;
	Fri, 2 Feb 2024 04:24:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w0pvg036k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 04:24:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNv6+2q1DMZjm+FYJ9MSg3nNwXJO72MzAqDBODoDPcNgzbLFvLhyjFcN/EBphmKk+GZ/eQj4sagLlWEiAQZLt/567Jj7oVtfCMXukd5c0yr7SllhMsfHlhxN71mfdYvzdnHcr5w0ak7SRYG3kEgQL9ytMu9NlyTp7N4kiOtzdGdJ2/gNEjMR47GCXb+5syfVCOvlZydxbHmFP6wb90hyvnjarL0Gj08VBe1cawEgsDgaGeJ+kdT6uL/l5zH/rJC2wgImgIkxNaQ9GR9xlHkNVdA/OtiG0t+613o5qnQ6AYkUBCLEM6ZKLztrp4glLAxoCRBP/8kmWivHZUw+130R0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eFwVcuHXvgjSaHNzrk8flbKyfkCVnFwCbW6Nn+MAuE=;
 b=G3saK8irWXvuCfTg4AKKT3vJfHWi1sIqHLbVzjvAzYg5Y9GuHOlk68ebWVxozuKbgBQRKi11RgyTiYKHUavBVwkEnu5Lmj7KO+18aWwYAuwF8FJFAC1JdhPJNzP+rcJt97vIpDwf1DpqdkwxrP716IUq7OJayxf7rJ5jWtsPvNERFRIi4hnRxcgZcYR4/VrutLi/3L1iS0VQw9A/5BJQ5pZi+w2GmXLO3JD6h4UhKZXp1XeKVDo+b2XuFr8DRVzh9AO4voSAPxz32qN1jbedmAnV4dlv9Id8vTR33uAuXkMvQU8kG5BezK5A5rm+d4vamF6HTAfT5WR4MJsLJivMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CY5PR11MB6486.namprd11.prod.outlook.com (2603:10b6:930:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 2 Feb
 2024 04:24:49 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315%7]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 04:24:49 +0000
Content-Type: multipart/alternative;
 boundary="------------ncSn8vbmQt0bx6sg1VU0yiuQ"
Message-ID: <2c53ca2e-0e5f-1292-ae85-4ef16812ebc3@windriver.com>
Date: Fri, 2 Feb 2024 12:24:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bitbake-devel][PATCH 3/3] fetch2/git.py: add comment in
 try_premirrors
Content-Language: en-US
To: Sam Liddicott <sam@liddicott.com>
Cc: bitbake-devel@lists.openembedded.org
References: <20240201033100.3617421-1-Qi.Chen@windriver.com>
 <20240201033100.3617421-3-Qi.Chen@windriver.com>
 <CAOj-5WBWkddTbtEXiHvKZvCjbxijaC244N07TwniJDM8ZR8ftw@mail.gmail.com>
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CAOj-5WBWkddTbtEXiHvKZvCjbxijaC244N07TwniJDM8ZR8ftw@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0056.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::17) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CY5PR11MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f032916-340d-47f1-9b1b-08dc23a6e4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3FmzWS3DMGtvhfPSJ5OO53xV2f1ahAy5yHrCFflao/W0+79b3QWrqgI+onyO6pf3W0dl5J++/hUPuxzEPmyXUmRLvtUBrkgwz72jtOcbzzNsAFcEXU7HmEePRijgyv7HRIeBSxHm6O1Pa8S5Wk9chedDjhwYoNqOdgIzGu4vQJYmrp50872iOldVum8KvwyMOHkHbAU+6AwLtXzFpmhkWWYRJ+3tL+Ts0knIIKcSA0DGkEYlXgQzwNs+hYjMYr/2jqs+wxwZ919zDQ7H3SCJ+YQWYJBs2VmvKXikGVNpMVG8o8aSix2vTbp+jiRnILUgjuLSJ5bF53dXIfi1c4IIn9lOJssabEqQfIop4+Of2XZ/7zS8VwClUBoa5eiiBnx0Xy3YBjBbVOnaJ2QJL8f/FcVsvnQ7ZrboGa0N72yjSJ75ghS/7ekd7VmnPSZ44NPliUR9OEYFBdcxUOrAF6IAqs0qKKnXImPmFX9wheVvyZEIpPf4OsOCohhLotXac+KNZveEmHrRlEPh8H2b6GaujXKAhBhHAaPKYu+op9Aa0nNeFnzm6GnxFcTtPAKw5kwmyPiYCJ2oIOnz8PqPTm4/hi+o0yt0at84rinsX1xU5e1gKsP09Q6ookVuHV++cfUWHn4ohhaQzwDFd/bj8XusF0rlCn2Sdbw0l7XHH5dfgoQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39850400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(316002)(6916009)(66946007)(66476007)(2906002)(4326008)(6512007)(8676002)(36756003)(8936002)(66556008)(5660300002)(86362001)(31696002)(38100700002)(166002)(31686004)(83380400001)(26005)(2616005)(41300700001)(66899024)(6666004)(6486002)(6506007)(966005)(478600001)(33964004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VCsweHc5OWRrRTlwaHpSMTB6bUJiZ0JlNmwwcXNDb1N5dzVZZ28zY1JhdVVp?=
 =?utf-8?B?S0dnOUNtNENrWmwvckIxaWpCOENQdHEyL1dMNTNPbEhMb0Y2c2xOanlyK0hv?=
 =?utf-8?B?L2Nrb1daVmhlejdlZUUzTU81dWNNcXBmemgrWS82UmsyS3l0d1FEbU5Tejdr?=
 =?utf-8?B?QXRwTXo2REpySzQ3MVNReUtUN1Z6dGZYNWJ1SWJQcUxFY1ZSMEo3YWh3WGxT?=
 =?utf-8?B?aFZGclo0M1FmeGRCcEI0SXRFNTVzTmticlowMUYraGxmNEc0L2tjaVVBbEdB?=
 =?utf-8?B?UG00V3hnU1h0ZFRURlJ6MFM3VkhVYnlCQUxtdGxoUkZCZjlrbWVEL3NBb1A3?=
 =?utf-8?B?UVRmTDNqRThsbi9FUjlkTjhUUmRYbGs5R0EyYVdQVGl4Zys0N3JMN1RVdFMw?=
 =?utf-8?B?WDdkNU9vampNK1NkcUQrZHJEZEZkQ2ovSndNKzlkdlZyUEFyRVJoSVdUNkwx?=
 =?utf-8?B?eWErcGpIb1REVVdXeXk0aERnQTNVeXFyM3hOYnpWd2dmampsVHNIVnB3U0g3?=
 =?utf-8?B?OFFSOHhvQjdrRWVYM1dVOGNiVHA1cW9uZ2pCYWUycWZCY3BwamtFditIR1M5?=
 =?utf-8?B?dVhtNjRMdS93T3FMdkJ6NEhCVjlzdlFHZFZiMUNkZCtKZStwYU1Cd0JXN2Vn?=
 =?utf-8?B?dlB5b3U0dWU4TEsva2xJZWp5N1hSVTc5UkhyaUM3UUxnUFowOHp1dkQ1dVp6?=
 =?utf-8?B?UUNmZ1QwbHFpNXlERkdoMkNycFNlNW1NQ2lYR2RQNXErT1RQU3VDUFhMYjhZ?=
 =?utf-8?B?Q1pMVzdSVmJFS3FFYVcrMXFGT3NFSUVmY2FxTUJFOVI5d1FjMFpyaHh4bGVC?=
 =?utf-8?B?SkI4Q0laUStHcnMxU29xRFJNdjhUcWFKczFNZUsvaXZhd1gzbmtSYUJuODBZ?=
 =?utf-8?B?QkFZUW0zRWd4Z0gxY0kzSDNPTDFRYkRhRDVsa0ZPMUFTRlpuVm5IWWRMQjZG?=
 =?utf-8?B?amNiMEkrK1dDcnRodzI3Z1RLSWJ0anVoUkpKMEc1YnRURDVXSXJGUGVVd1dl?=
 =?utf-8?B?Y3BtSFZMeXFjNmJ6KzRRcFE4SEZ1cUVDSlFyOWVyWGl4NHpVSzdZRG5PMWhr?=
 =?utf-8?B?eUlyQlBuOHR5cktJWXpHelVrbGtLTVE0QXFtVUh1TkhNeCs4ZTlQbWVUMXhW?=
 =?utf-8?B?NHU0TTlBSVNTSituODJXMGx1NldYYmo4ZHBlY3RHbmdITFFoZGRxQjVGWUhZ?=
 =?utf-8?B?Rm9nbHkxOXl5RmIreE1wM3JMQUh1UTY4aFlGRWxvaEJPQWJjMFd1eUFicWlt?=
 =?utf-8?B?ditzaGYyNzl4UVl2aG9zblFzamZuRzhxUysydUlQSHZjUHZFK01hSzFnbG8r?=
 =?utf-8?B?SjFzOXFnSSt2cUxYbUJVU1JGbDVyL1dxeXpmT2lzVlBHc00vZFNpbWlja2Ra?=
 =?utf-8?B?ZUZiWnhwNTVQWStjeXpRQ2w2THRiYnF1cHV3SXdhNy9hWS9RL1hYUEJvbE54?=
 =?utf-8?B?Q25mQWprTDMwZ1lDcTY1MkRvZjcyS1NIMnVEVlN6OWdMNnFBYkdNZHR2clZQ?=
 =?utf-8?B?TlVxUGtGT1BHQ1pLaXViS0pLMFdta0p4dGh6dUNtc1NoalFvV3RqSGF3TnlU?=
 =?utf-8?B?dkRERElzYzRNckVoeDdMOWhySUpoamFENi85bmRPZ3Z5b2JMQ0IwdVN2L2hj?=
 =?utf-8?B?K2FuVG5XQld3dThjZFkyazVWcnFPZXZaNlZvbElINWs1b0EzbjExczZQN0hM?=
 =?utf-8?B?Z01DWWN1MUFjTmNQZCtRM1RNRmZnU2djYkUreFpQemxYMjhnanZuZWcvT2d3?=
 =?utf-8?B?emFtWWJVRFdZbnczS3JRNVdnbVhGejZvbUF4Q1pJWlg2WnJKcjJEWmdRTmht?=
 =?utf-8?B?TlRxQUFrMHdSVU9OL3l2ZHhsdGtrUXpTNEUzWGVVZWlEWnZJdVVWZy9WU2FE?=
 =?utf-8?B?NXhSckM4ZmdYamJzT0t5WGJ6c1VRS2VXYzBmOGRDQVVnMEdGZHIvNVJ5enpW?=
 =?utf-8?B?SVhyNm04SUJBcHp2clJzdkQ3VEdPK20wNzRpK2RuL2c4M2hNN3QzamFIc3c0?=
 =?utf-8?B?NkFqSDdPVEZ4c0dYZkowSThUb293MzJheXpSdmtsb09GdkEvK294K21vaDVi?=
 =?utf-8?B?cFJKb25LTlNCQXJOMDVENXFSOFVmNWJQNkp3TDF6WjNvQm1lM0RtR1dlNklQ?=
 =?utf-8?Q?OFtcth6EPv98CyF8rSuKVJz64?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f032916-340d-47f1-9b1b-08dc23a6e4d0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 04:24:49.0855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCGDAmclpFVSzB3UQ/+HnFeaOacT72zuQAl8fChwmsga9ieBZS+Q1z5jUVEpDRCC3OYtobcLPjcc4gtnjsmdTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6486
X-Proofpoint-GUID: 87lUaIRAC5svTmbDN1PMbRxxuQ0bfQYz
X-Proofpoint-ORIG-GUID: emJ68RLHrsCsGJSQTL50U6Sj697-y_wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020029
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Feb 2024 04:24:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15820

--------------ncSn8vbmQt0bx6sg1VU0yiuQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 4123pbdq028005

On 2/1/24 19:15, Sam Liddicott wrote:
> This reminds me of a case while using a kirkstone branch, where a git=20
> submodule was the same repo but a different branch as the parent=20
> module, and the fetcher was not able to complete even without mirrors.

I think the problem you encountered is a different one. If you have a=20
reliable way to reproduce the issue (try poky master first), then you=20
can file a bug in yocto bugzilla.

P.S.

1. Some projects delete branches and I once encountered this. Did you=20
manually check that all revs are still available in upstream for those=20
submodules.

2. You can try using meta-virtualization/scripts/oe-go-mod-autogen.py=20
when you work with go mod recipes, though your recipe's repo seems to=20
handle go modules in a custom way and you may not need this.

Regards,

Qi

>
> It was a go project where vendor modules were kept in a branch whose=20
> name was vendor/ prefixed to the branch of the main project. This=20
> allowed the module dependencies to be regulated (and not fetched=20
> during compile) while still being associated with the project branch=20
> without tainting the project branch or history - but it meant that the=20
> fetcher would hang.
>
> Would these changes address that?
>
> Sam
>
> On Thu, 1 Feb 2024 at 03:31, Chen Qi via lists.openembedded.org=20
> <https://urldefense.com/v3/__http://lists.openembedded.org__;!!AjveYdw8=
EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZ=
AcAe6eDotE$>=20
> <Qi.Chen=3Dwindriver.com@lists.openembedded.org> wrote:
>
>     From: Chen Qi <Qi.Chen@windriver.com>
>
>     The purpose of ensuring 'incremental fetch' is not easy to see from
>     the codes. So add comments to explain this.
>
>     Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>     ---
>     =C2=A0bitbake/lib/bb/fetch2/git.py
>     <https://urldefense.com/v3/__http://git.py__;!!AjveYdw8EvQ!abkk4w1K=
DkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAPZ807pk$>
>     | 5 +++++
>     =C2=A01 file changed, 5 insertions(+)
>
>     diff --git a/bitbake/lib/bb/fetch2/git.py
>     <https://urldefense.com/v3/__http://git.py__;!!AjveYdw8EvQ!abkk4w1K=
DkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAPZ807pk$>
>     b/bitbake/lib/bb/fetch2/git.py
>     <https://urldefense.com/v3/__http://git.py__;!!AjveYdw8EvQ!abkk4w1K=
DkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAPZ807pk$>
>     index 322a9366da..fa8c597ea2 100644
>     --- a/bitbake/lib/bb/fetch2/git.py
>     <https://urldefense.com/v3/__http://git.py__;!!AjveYdw8EvQ!abkk4w1K=
DkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAPZ807pk$>
>     +++ b/bitbake/lib/bb/fetch2/git.py
>     <https://urldefense.com/v3/__http://git.py__;!!AjveYdw8EvQ!abkk4w1K=
DkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAPZ807pk$>
>     @@ -361,6 +361,11 @@ class Git(FetchMethod):
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# we need to try premirrors first=
 as using upstream is
>     destined to fail.
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not trusted_network(d, ud.url)=
:
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # the following check is to ensure inc=
remental fetch in
>     downloads, this is
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # because the premirror might be old a=
nd does not contain
>     the new rev required,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # and this will cause a total removal =
and new clone. So
>     if we can reach to
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # network, we prefer upstream over pre=
mirror, though the
>     premirror might contain
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # the new rev.
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.clonedir):
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True
>     --=20
>     2.42.0
>
>
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>     Links: You receive all messages sent to this group.
>     View/Reply Online (#15818):
>     https://lists.openembedded.org/g/bitbake-devel/message/15818
>     <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitba=
ke-devel/message/15818__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTU=
Gc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcA8nSAEcE$>
>     Mute This Topic:
>     https://lists.openembedded.org/mt/104090273/7497305
>     <https://urldefense.com/v3/__https://lists.openembedded.org/mt/1040=
90273/7497305__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQ=
WW5b6Y-UppkBFI7S3Mz0xK7iiZAcAWxGg7kI$>
>     Group Owner: bitbake-devel+owner@lists.openembedded.org
>     <mailto:bitbake-devel%2Bowner@lists.openembedded.org>
>     Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub
>     <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitba=
ke-devel/unsub__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxr=
QWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAMfW6SJU$>
>     [sam@liddicott.com]
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

--------------ncSn8vbmQt0bx6sg1VU0yiuQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2/1/24 19:15, Sam Liddicott wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAOj-5WBWkddTbtEXiHvKZvCjbxijaC244N07TwniJDM8ZR8ftw@mail.gmail.com">
      
      <div dir="ltr">This reminds me of a case while using a kirkstone
        branch, where a git submodule was the same repo but a different
        branch as the parent module, and the fetcher was not able to
        complete even without mirrors.</div>
    </blockquote>
    <p>I think the problem you encountered is a different one. If you
      have a reliable way to reproduce the issue (try poky master
      first), then you can file a bug in yocto bugzilla.</p>
    <p>P.S.</p>
    <p>1. Some projects delete branches and I once encountered this. Did
      you manually check that all revs are still available in upstream
      for those submodules.</p>
    <p>2. You can try using
      meta-virtualization/scripts/oe-go-mod-autogen.py when you work
      with go mod recipes, though your recipe's repo seems to handle go
      modules in a custom way and you may not need this.<br>
    </p>
    <p>Regards,</p>
    <p>Qi<br>
    </p>
    <blockquote type="cite" cite="mid:CAOj-5WBWkddTbtEXiHvKZvCjbxijaC244N07TwniJDM8ZR8ftw@mail.gmail.com">
      <div dir="ltr">
        <div>
          <div><br>
          </div>
          <div>It was a go project where vendor modules were kept in a
            branch whose name was vendor/ prefixed to the branch of the
            main project. This allowed the module dependencies to be
            regulated (and not fetched during compile) while still being
            associated with the project branch without tainting the
            project branch or history - but it meant that the fetcher
            would hang.</div>
        </div>
        <div><br>
        </div>
        <div>Would these changes address that?</div>
        <div><br>
        </div>
        <div>Sam</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Thu, 1 Feb 2024 at 03:31,
          Chen Qi via <a href="https://urldefense.com/v3/__http://lists.openembedded.org__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAe6eDotE$" moz-do-not-send="true">lists.openembedded.org</a>
          &lt;Qi.Chen=<a href="mailto:windriver.com@lists.openembedded.org" moz-do-not-send="true" class="moz-txt-link-freetext">windriver.com@lists.openembedded.org</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From:
          Chen Qi &lt;<a href="mailto:Qi.Chen@windriver.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">Qi.Chen@windriver.com</a>&gt;<br>
          <br>
          The purpose of ensuring 'incremental fetch' is not easy to see
          from<br>
          the codes. So add comments to explain this.<br>
          <br>
          Signed-off-by: Chen Qi &lt;<a href="mailto:Qi.Chen@windriver.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">Qi.Chen@windriver.com</a>&gt;<br>
          ---<br>
          &nbsp;bitbake/lib/bb/fetch2/<a href="https://urldefense.com/v3/__http://git.py__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAPZ807pk$" moz-do-not-send="true">git.py</a> | 5 +++++<br>
          &nbsp;1 file changed, 5 insertions(+)<br>
          <br>
          diff --git a/bitbake/lib/bb/fetch2/<a href="https://urldefense.com/v3/__http://git.py__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAPZ807pk$" moz-do-not-send="true">git.py</a> b/bitbake/lib/bb/fetch2/<a href="https://urldefense.com/v3/__http://git.py__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAPZ807pk$" moz-do-not-send="true">git.py</a><br>
          index 322a9366da..fa8c597ea2 100644<br>
          --- a/bitbake/lib/bb/fetch2/<a href="https://urldefense.com/v3/__http://git.py__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAPZ807pk$" moz-do-not-send="true">git.py</a><br>
          +++ b/bitbake/lib/bb/fetch2/<a href="https://urldefense.com/v3/__http://git.py__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAPZ807pk$" moz-do-not-send="true">git.py</a><br>
          @@ -361,6 +361,11 @@ class Git(FetchMethod):<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# we need to try premirrors first as using upstream
          is destined to fail.<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if not trusted_network(d, ud.url):<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return True<br>
          +&nbsp; &nbsp; &nbsp; &nbsp; # the following check is to ensure incremental fetch
          in downloads, this is<br>
          +&nbsp; &nbsp; &nbsp; &nbsp; # because the premirror might be old and does not
          contain the new rev required,<br>
          +&nbsp; &nbsp; &nbsp; &nbsp; # and this will cause a total removal and new clone.
          So if we can reach to<br>
          +&nbsp; &nbsp; &nbsp; &nbsp; # network, we prefer upstream over premirror, though
          the premirror might contain<br>
          +&nbsp; &nbsp; &nbsp; &nbsp; # the new rev.<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if os.path.exists(ud.clonedir):<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return False<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return True<br>
          -- <br>
          2.42.0<br>
          <br>
          <br>
          -=-=-=-=-=-=-=-=-=-=-=-<br>
          Links: You receive all messages sent to this group.<br>
          View/Reply Online (#15818): <a href="https://urldefense.com/v3/__https://lists.openembedded.org/g/bitbake-devel/message/15818__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcA8nSAEcE$" rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.openembedded.org/g/bitbake-devel/message/15818</a><br>
          Mute This Topic: <a href="https://urldefense.com/v3/__https://lists.openembedded.org/mt/104090273/7497305__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAWxGg7kI$" rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.openembedded.org/mt/104090273/7497305</a><br>
          Group Owner: <a href="mailto:bitbake-devel%2Bowner@lists.openembedded.org" target="_blank" moz-do-not-send="true">bitbake-devel+owner@lists.openembedded.org</a><br>
          Unsubscribe: <a href="https://urldefense.com/v3/__https://lists.openembedded.org/g/bitbake-devel/unsub__;!!AjveYdw8EvQ!abkk4w1KDkQAv1NfDTy93YpSD4d1825gTUGc4LYGxrQWW5b6Y-UppkBFI7S3Mz0xK7iiZAcAMfW6SJU$" rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.openembedded.org/g/bitbake-devel/unsub</a>
          [<a href="mailto:sam@liddicott.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">sam@liddicott.com</a>]<br>
          -=-=-=-=-=-=-=-=-=-=-=-<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------ncSn8vbmQt0bx6sg1VU0yiuQ--

