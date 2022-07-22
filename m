Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D824C433EF
	for <webhook@archiver.kernel.org>; Fri, 22 Jul 2022 13:53:36 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.8130.1658498008471387162
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Jul 2022 06:53:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=lh8fHFqH;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=42024cb71c=randy.macleod@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 26MDfS57018650
	for <bitbake-devel@lists.openembedded.org>; Fri, 22 Jul 2022 06:53:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id : date
 : subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=mZYHzid9ZWg/v1UJ5ogiMKvYbDPlHxddV7ytcF7l5lE=;
 b=lh8fHFqH57jbDfQ4jjVMq/i5/znU/2np63DV2cHL5Pl8rB7DjdLP9ueRc36OHbagNh83
 qxtkxWlkRaHDZ+RbD2fwlRRC3/xXceXHNLdabzCBrnW6YzgqXM7FVRfM60WljehuhxBt
 Yych6eRMPYL8YB/NfYd32ghvt9RaYmDR+t9TrslMOitUxL2ifPpfE65xFOj9arEBrNYg
 acKuS3iR3K87r12pFIOvY1uLpqLsDR1m3FElS2wl9iZeIENKLjLxTA+HF5oHRvxWc0Xa
 Dl+QIDiaoXms0yIyi/bjZ32w++Idd9XL8y4SfgMwwjTLrfiBlxJJGFc6EOdzJT0Q42Nb sA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hbrm84ue3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 22 Jul 2022 06:53:28 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26MDrRD9012257
	for <bitbake-devel@lists.openembedded.org>; Fri, 22 Jul 2022 06:53:27 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hbrm84ue2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Jul 2022 06:53:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlIhoCkONMC4960cp8/zgsKmZl5glFDmxqFKDtT2TC43Nohy4KfSdP3Gsv5WbGQaqD03x81gKti5t6Vr6gwL5gIwlXzOpHqJtPproYXWWtPS0ltGwggsBsn1ep8bVpb/qPwbsYW07gb8nxgOUhYMX1NSDumWsxm8/9bMrtpl3kiLlkxxX3p7rXbjHyMpxtIVu87Fe5jCJ4z98SDVtESgmnBixP4DAcz51OWf26wpzncTGbKG01Raq2OxAQkfIRenidEcXY0kmVgfhfScgKV/n+BJfGL62AFiT57TOhM9W/b35E5gLwqpFpaydKZLBhd2POF82nDkvT06J2bcgF3r+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZYHzid9ZWg/v1UJ5ogiMKvYbDPlHxddV7ytcF7l5lE=;
 b=RDvlLOxqDUts7POG72VfOmw36UkmeBToG2jzx19Rg+hWgXKYOBENlGzrcxH+mW0bUOd6jsOZWG9iTPC5YyXHkUfviaKzgE9Ugcus3E1Uz87NsHUQJDxkZMeBDZGAWf+8NBSBGaTInSPe/QTG5iKXBgsehl5q2KNo+EYTg5gHF3Obh00MLJVSsAJIsGnE7hdhHrEb274Fc44G0ShyGeOJU0enH7l3Kf7HWVdz9l1uUZ7WHSvSPPd0NNYCRrq/2KuboemXT2im55wUfrpTlcsPHuDU9Ax64fbG3Am4+QZDKKbV6Z1Zvn4DqdVngp02moXwFK6gdsbrQuW7n00VOgX9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by MWHPR11MB0061.namprd11.prod.outlook.com (2603:10b6:301:65::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Fri, 22 Jul
 2022 13:53:24 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::d84b:7432:aca3:bbff]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::d84b:7432:aca3:bbff%7]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 13:53:24 +0000
Message-ID: <8b222833-539e-5654-9432-de0fddbb274a@windriver.com>
Date: Fri, 22 Jul 2022 09:53:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bitbake-devel] Upstreaming Vim runtime files
Content-Language: en-CA
To: Gregory Anders <greg@gpanders.com>, bitbake-devel@lists.openembedded.org
References: <7afb-62cc8780-4ef-55e55e0@5241339>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <7afb-62cc8780-4ef-55e55e0@5241339>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:a03:100::45) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b02af755-c2a3-48b7-0d1e-08da6be98ba6
X-MS-TrafficTypeDiagnostic: MWHPR11MB0061:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IYCqYEbg7dbL2ejA+J9xXSqMMPUYzBdbVAZcVNif2vKWJgNll7dhnimWtLbZQkNQ/0viD7NJfagPCnQrzQchS+gu1A2DJqW52wz6dMo7SzSHCC5ZSx8Jvlh/XJ3RSu1+esfuPhyS8fF/ORcpVqhcPgqcj0PQuJH9nu7SvBxtU/5MkSPNqpLxR7Q4Mn/8oDPD+vZ/8HxQlI1wDkCxbHxKQZOQ3P2drLcNgAWWyGM6eppShu1PMl2IsjcyNYnmgksGAJbmseXpkeEtr55mBPegfrTXcskRvmYABBQQuaqxONRdq+EQW0hm9H6kRORsvrT2TL4CL+XnambKlvyTor3q9Quj/ojP4Y6K4uMGhd80aeqEZE9dsbf7rBFWi/KSPD17Ay+wgvu0L+js0ZppfJN3EQdC3uCD/NKq4lpVCgBC78PGX5OZwaEDr1aMItKsplYQ5klh5JwngLc843+f8xmRwrO0h2sQ/2cGiXGWigzBTT+PNQQd+oKjnxpyTsVX1GwgxrNPA2AZMpdxfApAxN/vmdIy/gjmxnKRWiYCAeWNissrs3vRrApdzhYUvAs6sMJvBmHu2NA0zfpLVXGLms7lAZSvnm0n9X0bIb0wdswXkcoyf0g33UD3DJayfQfdXtUq1xStTeYMft7NAaNAWFtfkrATssiFgCM2lp4SNmU3JeO+kZurqQ7kY0tPdp5wcejZhAaH/h/C8wbI9W/IHgBtwFApo8zkjjUTWPw1ogVllq5a+Lv2svTwynxFAIek3LznfaWk/ddI6DeUvkgyYaEkV0JCEifXwRhNDsT/33WAzyxvZcd8li1emW0btpY9XbDZxPsug4bk2MVlqmvju5u/66T5PrPKuTOBTET7kiy692ue3qJajMtbw0WeHSxk5QyfGqYkhnoRJFt/oLEddJKHfCXj1ArTTtI508d1/16KMJVyZT3asUh3YQlxbwa8cwbu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39850400004)(346002)(396003)(136003)(366004)(6486002)(6512007)(53546011)(6506007)(41300700001)(5660300002)(26005)(478600001)(8676002)(86362001)(38350700002)(316002)(52116002)(966005)(8936002)(6666004)(66556008)(2906002)(83380400001)(2616005)(38100700002)(186003)(66476007)(31696002)(36756003)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bFZkV1ptU2lRRlpDRWdEZjlBbCt6Y2Z0U1huZ2taeStaendNU0RzN2cwOGJI?=
 =?utf-8?B?OVRNeHhJcTd5RnBlRkZyRVRlWUFVdVN6T3VvNjZuTG8zd1NHTXpXUitkUHZ6?=
 =?utf-8?B?N1BiWk1CV3BLN0REY1U5SVN5MVBnTlhUZUYyZGo1SU9YU0ZXWm5MaHk4cDIz?=
 =?utf-8?B?dXU4T1Y1N053RVlCNVV2cGVKc01YQzRxTGV3MW9zcjluWTRBamFkeXFCTGRu?=
 =?utf-8?B?TXl0Y1lvUzVEeHRmUTdlbVAzZXdEZDZIRVdOMWxQMTE1MVNZeUowYkJqZSt3?=
 =?utf-8?B?ZEdvNmRid1h1L3VMMnM0cDVlMjR3ajMrdVRZSDhRS2NZY0VqWFFlS3pnWlAy?=
 =?utf-8?B?cHhJdU14TFNKcGF3Y0RQa0FrWGx4S1l6aE1aQVdHUGJVZ2huUFQybkE1ZFFr?=
 =?utf-8?B?Mmt5U1NnQ0RCN1Y4UGtROGNQbklFWm1sTEFEUWxBUmhmTGRYWjZieGlWcnl5?=
 =?utf-8?B?UTFyNW5PZ1VBWmoxd3BqcGJtWS93UnM5R1hpRFIyd0FsYlNmU0ZkZHkzYVkz?=
 =?utf-8?B?TWNoUlJydGs5NkFVSDdER1c2T1hJbVZXWE5OWHhhZUNpRjkyY1FGRTJpQjdq?=
 =?utf-8?B?eDdLVmFtNjBnV2xhVWpjbGpJd1M1WUFvWG9QTjNDOWd1MW1wSU90S3YxNllR?=
 =?utf-8?B?QTZ6RWdkV0lJMThlUCs5TGw2bzlmQklYLzE3ZlpQd0VYaXU3bURLSUJoTGs3?=
 =?utf-8?B?UDZUWnA2aXhyaDdwK0dmQVZRak9URDEvMHRSUFY0T0REb09XQnpYKytVZnhp?=
 =?utf-8?B?ZnhRRVpMcktkZUNESm95ZmxWVFhYMVZyaFFReC8vT1FwT2V2VnE3K0JoREs2?=
 =?utf-8?B?SndxR3hvaytETkQxNGpwRldCZU9Ja2kzRXkrTmMwTm5KUDZQSnlsOXIwNmZj?=
 =?utf-8?B?ckJ2eG9RZXZ6ODBFWmZUajhnYmdKS2crQjhFdThhMDVUdFh1alNXNXN2Rnlu?=
 =?utf-8?B?SXZqc09ReWR2bHlSRG9lTnZ6SnowdDkyOUZiMzNYQ0E1UzZFdGg1dDMzUm5p?=
 =?utf-8?B?WDlBUnVzeGJtckZWeXlxcXdxM1dTM1VXclhEUDRLeTlGT1o2UkZYTVRWUmln?=
 =?utf-8?B?djdlWkkrRTIzdUVUWW1ycVhLYko3YXVwV2hwbXQ5bW81bDY0SGQvYm95dG10?=
 =?utf-8?B?dEIrQmxBSldNT3kwdHo0TG1IU2llclNnWDdNWmZuejFtSS85QldGa2c5b2Z5?=
 =?utf-8?B?cUNQMW9PUkVDRVZSVUxnQ2gycEo1VjZCbWRtV2NRQk51dXhVemhMbjNDSWRR?=
 =?utf-8?B?K2pWQU0wUG9GOGI2OHd3cFQxSEg5c0syRjFVK0t0WGRVWDh4dFlOQlBXZmZC?=
 =?utf-8?B?aTN0UTF0bnpiNDlLZ0ZlcHZGOUJqek1keExONTRPVlYxcmsyTy93WEIrTW1z?=
 =?utf-8?B?RTZYbFQ3akFtOTNic3lEczMwbjFtaGJISldPdlZrUlVNdTNhcXIwTC90Y0Nk?=
 =?utf-8?B?V1RLSnZXU3pqOHZQMlcrNDBwSE8vR1lJVmJEWHI3NXpmOVlEWWFwODYwZW10?=
 =?utf-8?B?OU1yRnBsUXlRMnBUMThJdVZydTRnbmUyTTRqdmt4VGhTN3gyeERlSXV0eXZ6?=
 =?utf-8?B?TUljZzlmdklRdFlHWHZ6cUtJRGhMcGdlc016Ui94MUVkaWpGYmNTZGk1ajlV?=
 =?utf-8?B?anlWbW1NcGliankzZG8zWGpvaGduSmhIT3ZIYTJjaUl3SS81YXQwS2NKSElH?=
 =?utf-8?B?UDFoSmFWQ1c0VWNXaFVqTFRMd0d5cllKNDdnRnFZaVg5NCtRRlp5OEtsNGJS?=
 =?utf-8?B?MFpKUW8wZnk2azlRaE1MVUJybVZnY00xVkdQQ240NTNZcTJqN0JUV2VzcWov?=
 =?utf-8?B?UWQyRyt4RnlGc3M3OVVQOXNzMERUdEtCRlhhMVdrWjRvUFY2SWtLbmlEa0xl?=
 =?utf-8?B?MkFJNkx4REcrUmNQeDZHQ0I3eDJET2FRbFgzanIyZG1LTk1oRzJLck1zbkNB?=
 =?utf-8?B?MURGZHlYNUVKNjJuQzREcnBiSlBna1hYTDRxc0hZelZGQzhmdDhNbmNWcnJy?=
 =?utf-8?B?WWpVN1lFUGZmTXo5MU5MS1N0QlpMVGNndVJVRW9YVEF5MmJpZHpSWEkyTzZj?=
 =?utf-8?B?a1ZHMVdQZmlBeGNFYVpnb3E2czBtOXA2MkN4RkU3VThQZzEwUHJDZCtZVUFx?=
 =?utf-8?B?WEJMN3V0T085d2JyYzFNK2dTVVhxcVlHRnBOVDg3RUNVUW1MZ21OaDAwSmZh?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b02af755-c2a3-48b7-0d1e-08da6be98ba6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 13:53:24.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 HcrneaQNxBPx7QrTRZGbttwZukMq5e98sRH7mvSHG9eGjm0tyDSeLIxIJtl/gHV+TB21jsaNuboBZrMQ/Aur6RTY8vn1WwMRWKqrLPsaFK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0061
X-Proofpoint-GUID: idUYtueKw-pSBGa1FZXiVp1rINu5LR8-
X-Proofpoint-ORIG-GUID: OFbQ_FHT9QOhYQ4IzJllF_lUkRqev1eG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_04,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=967 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 22 Jul 2022 13:53:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13836

On 2022-07-11 16:27, Gregory Anders wrote:
> Hello all,
>
> I'd like to submit a patch to Vim to upstream the ftplugin and syntax files
> found here:
>
>      https://github.com/openembedded/bitbake/tree/master/contrib/vim
>
> Note that this does not preclude the bitbake project from continuing to
> maintain their own version of these files. If and when significant changes
> occur, it's a simple process to send a new patch to Vim to upstream any
> updates.
>
> Please let me know if anyone has any objections or questions.

Hi Gregory,

It looks like there aren't any concerns but I wanted to reply so you get 
some feedback.


This is just a local file rather than a patch to vim AFAICT so

I don't think there's anything to do in bitbake until the changes land 
upstream.


Thanks for letting everyone know so that they don't duplicate what 
you're doing,

../Randy 'from the cult of emacs' MacLeod

>
> Thanks,
>
> Greg
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13820): https://lists.openembedded.org/g/bitbake-devel/message/13820
> Mute This Topic: https://lists.openembedded.org/mt/92321784/3616765
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [randy.macleod@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

-- 
# Randy MacLeod
# Wind River Linux


