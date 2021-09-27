Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522B0C433EF
	for <webhook@archiver.kernel.org>; Mon, 27 Sep 2021 08:58:35 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.28529.1632733113907924443
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Sep 2021 01:58:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=rWns2XPW;
 spf=pass (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=4904589bc1=changqing.li@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18R8gbBK019582
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Sep 2021 08:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=PPS06212021;
 bh=f2YcJTvy4DgQVdTe4B47/Gy95yVFI6m0g6zksMEvAoA=;
 b=rWns2XPWfWITHZvUIrLfQN+sL4z9AQWj56VGmaPsEMel3XmASaLoN/GXNZTufhZRJSVd
 zr0ucvRDD47ZnKDv0cAoGdmDbdebbIYcchP3bhEckikExqvQSvS6FIgQnY8gND1lXTeH
 6cR19VTLpHdERc53/xNzL1maSEwDQhHvvOODgd+ONc5yM6hJw8YMQUXtk+1UMo0fXJSz
 qMnoOYUxai3lk/8lszKhr9bfFOmCoz/95SWtMg3XYL+x5tInO7/10Otgo5tLK+PCwIHm
 8KJoJpj8r4Bf2aEyoJVM1/QswaD8Yzk+CCYHBBtxdoTblvhPxkcaLjPdlreHxXoJxuTQ uw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bahp4rmt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Sep 2021 08:58:32 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18R8wWYu014741
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Sep 2021 08:58:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bahp4rmt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Sep 2021 08:58:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNzey+i8LreIrFux9mVQ4BM3Sz1zrbYIXiAARgo3NAsfmsvCCpg2dPY+W3FVFLirn4JKVSZdZCOXetDalMUZJkKV5fjuxwq5pwDNE2T0vdglt8qogy+v83TOEfTvY6moky5nkTrK6DQsTSlPC8smkTJ/PeHJTocD4vMaGYvflbRjBqWDEtH0sl/YVKJsABZXV+XVQteB4FRWSndUcqo5hLuuVjOwOSkAo7pLJeSkm5HL3GsBADqNLF98Y6eeZtnq9e8A9IKJSMV9KyB7FAdgRhyfGTpiRodZVH3c0AubbILUAyXtGThpPHBwC1rTGMdXJ63EI/WWsjsnZ1UEFDFUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=f2YcJTvy4DgQVdTe4B47/Gy95yVFI6m0g6zksMEvAoA=;
 b=U3ReF1PE9AiXxASVJxwVz2HmtnlWlhTANBbqIjWF6YKVsfDt+AANN/rBXLPA2fV7zVH0GVYNx3MsOFUsYHqm0Z3NZh3KdnwewteQjQrxQihHko5/D3ObDB5PLEeIj+MHr7Pc3sgYJpmW5t36BeysMUrzYgwqxvik/8yOq8Wm0tO9Jp4+XEPqKqrVbM+SLraONH1k7SXqOfQYo1Xq4W9m3hG3qyEpyeo5ZPU/JJtJ+fZTpAr7iov3HEUjfYJWFqcS7yGvRwhxmCgyz+D0JjHVfLzkd6KUItTYv4XMIhhRVMAoGKtGNN015XcufUMhHYgTfZio36xKPufAtCZHyatquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SN6PR11MB2557.namprd11.prod.outlook.com (2603:10b6:805:56::33)
 by SN6PR11MB2816.namprd11.prod.outlook.com (2603:10b6:805:5b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 08:58:29 +0000
Received: from SN6PR11MB2557.namprd11.prod.outlook.com
 ([fe80::a544:19b6:196b:f339]) by SN6PR11MB2557.namprd11.prod.outlook.com
 ([fe80::a544:19b6:196b:f339%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 08:58:29 +0000
Subject: Re: [bitbake-devel] [PATCH] cookerdata: Show error for no BBLAYERS in
 bblayers.conf
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <20210910142719.1257009-1-richard.purdie@linuxfoundation.org>
 <20210910142719.1257009-2-richard.purdie@linuxfoundation.org>
From: Changqing Li <changqing.li@windriver.com>
Message-ID: <b299a244-31f1-30fb-3fe0-3ade94815697@windriver.com>
Date: Mon, 27 Sep 2021 16:58:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210910142719.1257009-2-richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative;
 boundary="------------28B70F24EE858212A250AFF6"
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::13) To SN6PR11MB2557.namprd11.prod.outlook.com
 (2603:10b6:805:56::33)
MIME-Version: 1.0
Received: from [128.224.162.189] (60.247.85.82) by
 SJ0PR03CA0188.namprd03.prod.outlook.com (2603:10b6:a03:2ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Mon, 27 Sep 2021 08:58:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 343eefb1-d330-474d-6086-08d98194f9b4
X-MS-TrafficTypeDiagnostic: SN6PR11MB2816:
X-Microsoft-Antispam-PRVS: 
	<SN6PR11MB2816B66ACE85A7B22B4378AA82A79@SN6PR11MB2816.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	84LxK+dyS9eAANUJXEXWVpuqJTHfDDv7wuZdDLkbpNybnEd8bs8nCbGEdiW/Q0749rsm58nYTytfljjN7y9KxV8KkZGUclgWwYJ6HpA8CpSLy+6Llj0m56uxpfE3MhoJ5OGnp774dSORgHwjzPSORd1Noec4BCFgD3lqfzVeAQlQJ3keLLFvWbs2UBMiWEFImkPOCSlsgYg8QU05gheJRl4mtvMcErnZ/ZGmvYlkIB9q7gWJyhYoKGGL1vUwHD9Uc5K4Lned/IJJIRiEqYD+831H410j15XXHzXL5CTubrAEMldYa0OaLvFtS41lYB8fo+TbjQY7m/HU6q0MADH6EazzP8vYe6TDZ+gIG9QDyxnn8sx+F9smmQ8KTl2Q2DA2ne0vezn5Xrzq86EHjVE7Rpg29iJxMvNQuKLoPc62yIbFGmqVwb6dX3heiuRdTqo/HXZ/XbG3uywpDOsYV6mIKdQVKfy2X2/seJerISLhGIcXURtZaafdCQtAGm2yXc5LUOE+lWcFm38EagjpUiSMT1j/k2772av9t9w5gIf7mSnG/rJY0QfNv/x4FwN+GAp06SC0yAiov26fV/E5IX+zJFgi6WO2RfPQp7oE5YFdnN+O9xAlgYY31FvkB8ALV1eMZ1sJHwa9WVWadGWlx9DmnuGMClAnQp3UaGxhFwPEeX9W23SPRll4Sfn+v1eRi8e4Qvm21gatA9bn5Ew8CkdTOTJKo9RlEpy4KfPCYkJ7R44M5m43cB1Q03GecM9wu9Epg7uzLPzP4akfas/ULhpsveDsNc1nB+SzJuoXHnMgGHC1Ef0pCjAe38R06kUbOxHHuEgR/flevbVMbD6PcjHYA8V+1+L9MFJd/DBggxIPkD+s8gKmi1GxZ140gKnm/uURuuQPHw4+AGgvESfE4/wMYJ0ex1TCOP26JzVH9xX4iw0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2557.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2906002)(31686004)(6706004)(6486002)(31696002)(38350700002)(186003)(956004)(66946007)(66556008)(66476007)(966005)(2616005)(38100700002)(36756003)(86362001)(8936002)(33964004)(166002)(52116002)(44832011)(53546011)(5660300002)(83380400001)(16576012)(26005)(316002)(8676002)(6666004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MS8wNCtNR0NCVGphMDZqd3c1R0VCbXB4MHloVEhnUmw3WTdOOGl1VTdQODdO?=
 =?utf-8?B?NUlxWGRSUzFlN3doN05yOEtSSVlpME9rb3djTDdHbUtJVEZsK2tkT0wvOVJp?=
 =?utf-8?B?UVJwY2JPek5KbGNOeTU1Qkp0TE13RVFSd0M0bVhJUFB3SDhXaFVldW9RUmdX?=
 =?utf-8?B?OEtscVZQamcxeUVHZENvV0NrRk9DUXNYL1ZBL1VQM20yYjR1QVgyeUx5Tng5?=
 =?utf-8?B?SmlSb3dOdWp5T0d2WlNRVjRQcS9DeUtGbmp3SDdYcklyZWFtOUxDUzY5S0pk?=
 =?utf-8?B?amc5U2QvYlI1NXBjRWdiSjdIVWJjVXVRWGUrSkxiWnU5dHREeWxyZnFXMW9s?=
 =?utf-8?B?Zm5LeVQ1cFFVdm5YeS9tUGIxWHBFZ3dzWWtBYjUrZS9ZeWNiRnBNblFoQm96?=
 =?utf-8?B?U2RYcDB6andwVzFoM3JwVnJ5QklHMWlwNHVsejZIczNUS3hGdFRSUU9iaGNV?=
 =?utf-8?B?dG0zWVpUUWhFbGFycGxYL1FOcUVvM0Q1MXNNSzF6SmNnRjRZd0tocVptQzVz?=
 =?utf-8?B?OGE2Q2cyTVBQUkVXSWVPTjNjVzlpQW5zQ3FlUFA5dGhDZzlLQ2ZEQkdsMDN6?=
 =?utf-8?B?d2xjSEYrRGR5WEFuNTBnSUVoSjQvQVJibzduSy9jTnljZjNDZnp4djFIVnRJ?=
 =?utf-8?B?Q2RKSkxKNUxQWFpFZzE5c25pOVVpaVkxTXNwejR3WlU2N3RFS1BMME5yVmVz?=
 =?utf-8?B?Y3QxaWxpdmtmRjRyK1pENnNwbzFaUzdMV29qQWJrcVB1WTMxNXY2cEZPK2FW?=
 =?utf-8?B?THAxaG1MOXRPektkT0lFUDJrclBGUGJwQlBMR09DVlIrdm1MbXM1TDBYaTdk?=
 =?utf-8?B?U0RBbUxxYnBzM2JuNjJRcjJOYVVLWHZJSjdVSHRzdWRreGhxcDhiZ3ZySVRo?=
 =?utf-8?B?ZGp4TTNobUVkcS9aOGJrYWVyM0JIaUI4NGtVdEd3RzJXc2FTekROWXFVZlNT?=
 =?utf-8?B?Wm5ydkRqbGNRNHhkSzdqUXdhRFlvRFJaWUJPL0hnTHp2K3ZVQkNoYUt1TUY2?=
 =?utf-8?B?OTdwMUg5R0pldE80OVVFdHZYbjhLb3cxVXVmTUhNWjRoUXRLcTNoRDRvZTMx?=
 =?utf-8?B?a1ZkVCtpNUhCK2ljOUFCZ2k5N3FGejRKY0NaS0pwR3hjT0RuZjljT2U2VDlP?=
 =?utf-8?B?NWFONEFtaitVMmF0L0I5NXppTlM1aGFFc3Z0SGJwV3NnSUJ1aUVWaTNLVU5Y?=
 =?utf-8?B?VzlLYURzZnpKdHlsa1hvTzQ4Wk4yMmtjdEZsNGlKTWdHQ0lTUEhORUlScmlY?=
 =?utf-8?B?S0txSnpUejlqazcvK3h4WDZ0cGZaZm02VlRKcHkwS1lIYXB0SHhKdDU3dEtV?=
 =?utf-8?B?UjZFYkNEbXhPSmZaWE1makJGU0dpOEc0V2M5VWJoWHFSaGU2ZTNzQjBNQS83?=
 =?utf-8?B?OWx5bHhYa2sySkVwZUoxZ3VNbUs0a2VXKzROUkU5QnhxOC9VN3pnMnpjYitR?=
 =?utf-8?B?RmFJVG5mZ2JlLzAzdkFqNnQ3QU8wZEEvdG9wT01admI3MHNpK3I1THFvYlU3?=
 =?utf-8?B?cDIyUGNuV1ZsSjhac2ppQjNzTlg3T2cxdmRRc3gzSExrZVZESkpMejd6SEN3?=
 =?utf-8?B?MDZwMzlENE9NeVNkQlJ2a2V3YkU1NWtwOWtKQXpSSjdLb0lDTjd1c0ZuQjNX?=
 =?utf-8?B?ZVJHZk9nOU9qS0dvalV1SVhEdy9ZK0I3STF0b3d0eWlFWEdtdnU5Y255NWsz?=
 =?utf-8?B?ZG4raUUwNmdWb3hrT2JFL2llQ01GaHpxN3FyUkZBVGw3SGN1eUl2MXlhZnR4?=
 =?utf-8?Q?UyQwazg5e3ZEFeA+MLF77WXVin+KuyKFxNQ0x/Z?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 343eefb1-d330-474d-6086-08d98194f9b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2557.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 08:58:29.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 uhBQEKa4Csn9c79DHmG95Cs9Efrz7bcNri2CE3sBkZaoX9w8e58zE6PpTHZ9bQz4jFIEvgE8rToBI6sz7L7aVMhQSejUc0uYNN95swjAvKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2816
X-Proofpoint-GUID: soRjeimjGkrJqh77Adf-e8ld_RClwJ3g
X-Proofpoint-ORIG-GUID: QqWx498cMTafiKT2dS1M1PJCErBLx9lj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_03,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270061
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Sep 2021 08:58:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12709

--------------28B70F24EE858212A250AFF6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Richard

This patch cause one problem for layerindex.

function init_parser in 
http://git.yoctoproject.org/cgit.cgi/layerindex-web/tree/layerindex/recipeparse.py, 


will setup tinfoil in an temp dir without setting BBLAYERS . This patch 
will make layerindex update failed since setup tinfoil failed.

layerindex setup tinfoil for parsing current target-layer's layer.conf, 
so don't need to set BBLAYERS.

Can we revert this or just report as warning?

Thanks

Changqing

||
On 9/10/21 10:27 PM, Richard Purdie wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> If there is no BBLAYERS set in bblayers.conf show a more helpful
> error and exit.
>
> [YOCTO #14340]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/cookerdata.py | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index e54858cf02..d6206b7319 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -342,6 +342,9 @@ class CookerDataBuilder(object):
>               layers = (data.getVar('BBLAYERS') or "").split()
>               broken_layers = []
>
> +            if not layers:
> +                bb.fatal("The bblayers.conf file doesn't contain any BBLAYERS definition")
> +
>               data = bb.data.createCopy(data)
>               approved = bb.utils.approved_variables()
>
> --
> 2.32.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12629): https://lists.openembedded.org/g/bitbake-devel/message/12629
> Mute This Topic: https://lists.openembedded.org/mt/85510606/3616873
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [changqing.li@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

--------------28B70F24EE858212A250AFF6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi, Richard</p>
    <p>This patch cause one problem for layerindex.</p>
    <p>function init_parser in
<a class="moz-txt-link-freetext" href="http://git.yoctoproject.org/cgit.cgi/layerindex-web/tree/layerindex/recipeparse.py">http://git.yoctoproject.org/cgit.cgi/layerindex-web/tree/layerindex/recipeparse.py</a>,&nbsp;</p>
    <p>will setup tinfoil in an temp dir without setting BBLAYERS . This
      patch will make layerindex update failed since setup tinfoil
      failed.</p>
    <p>layerindex setup tinfoil for parsing current target-layer's
      layer.conf, so don't need to set BBLAYERS.&nbsp; <br>
    </p>
    <p>Can we revert this or just report as warning?</p>
    <p>Thanks</p>
    <p>Changqing<br>
    </p>
    <code></code>
    <div class="moz-cite-prefix">On 9/10/21 10:27 PM, Richard Purdie
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210910142719.1257009-2-richard.purdie@linuxfoundation.org">
      <pre class="moz-quote-pre" wrap="">[Please note: This e-mail is from an EXTERNAL e-mail address]

If there is no BBLAYERS set in bblayers.conf show a more helpful
error and exit.

[YOCTO #14340]

Signed-off-by: Richard Purdie <a class="moz-txt-link-rfc2396E" href="mailto:richard.purdie@linuxfoundation.org">&lt;richard.purdie@linuxfoundation.org&gt;</a>
---
 lib/bb/cookerdata.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index e54858cf02..d6206b7319 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -342,6 +342,9 @@ class CookerDataBuilder(object):
             layers = (data.getVar('BBLAYERS') or &quot;&quot;).split()
             broken_layers = []

+            if not layers:
+                bb.fatal(&quot;The bblayers.conf file doesn't contain any BBLAYERS definition&quot;)
+
             data = bb.data.createCopy(data)
             approved = bb.utils.approved_variables()

--
2.32.0

</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">
-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#12629): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/12629">https://lists.openembedded.org/g/bitbake-devel/message/12629</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/85510606/3616873">https://lists.openembedded.org/mt/85510606/3616873</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:changqing.li@windriver.com">changqing.li@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
  </body>
</html>

--------------28B70F24EE858212A250AFF6--

