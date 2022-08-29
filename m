Return-Path: <mingli.yu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36437ECAAD2
	for <webhook@archiver.kernel.org>; Mon, 29 Aug 2022 06:42:14 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web09.67609.1661755330178910748
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Aug 2022 23:42:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=OIr1/los;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=6240b32d85=mingli.yu@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27T6Wkqc015525
	for <bitbake-devel@lists.openembedded.org>; Sun, 28 Aug 2022 23:42:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id : date
 : subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=Ywh3WQ+DeJwMinDyclMSjEtEanTeJBbEJGhWLEm4/Uk=;
 b=OIr1/losKde0kqG3iDl+sKN7UhplLGjgEKt5qxeu40kt7W2lripCA2zUDw/M9NRMcpxs
 KyPmQQRJ0USM1Xl9CXbc4G9lTb8i/3K8QRnQ1Vr0j/vPePx+4OlsWIWsVY3lVnmOd4VU
 xDU8AWmdAUEJ8OMI/LNlDLDZ6fz/guLje3VrfLxKmsvWPQxGvsvMY7kvOLKsI/Q2Zg3j
 aRomS4ja25aEhPfSp1xzX9jv3w+WwwUnwr7kdx75rR5s7OYyXY74PQrogS6bLQMmf+Wm
 Hl95HsiY5dmg5xupCcwqqL1wSGdJbhdewyvfG1mfiwLMShelWj8BzD9z2Cu1164VqIbs UA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3j7jsk957n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 28 Aug 2022 23:42:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWHpJXyettb3QTIaFElC+MFVlDV2+00hJLoLqx9ETD3OAtVEe+HUkiEow3WV6H/sA05Z33T7vQmTtp1J0d6MEdSmPJ/9cU2TmyJWvcLaacHio/Y+p2QsY9MELntvVJfQwr1oxdhgV1hdrJib4lD9BlMqTeJM2xXmTxkpdwCZzTs+n2R+2UgmKBfv0XjOUfh7fxaYAxzP7YfZNZFYWKg2XhtZHE/WNJoatViLPPlrW9SoAVvy3vRcOWgk2BKxguWzcNxwKNr+T+2F+DCoFm8mKtrZoRkrri21nyyh/f/0A7vwrgJ4p8pVxYxy6VUifk99ixz3bxsLcmUtn142wFDxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ywh3WQ+DeJwMinDyclMSjEtEanTeJBbEJGhWLEm4/Uk=;
 b=lbmBF+CEPaLy2SstC+t3k6os+PcBCqRsfInZU1DnujPNVlnannr8JLl5IFncIgFjIfILx+2ixC99HcChGv+qVjH/aVv9v9e7jzTaMk/j0yckPB9DIyogNjDILy8XDdjnQsAVd09JYmfrP96UykkxU9z7O9Is6jYNB52YAd5gssSKYGJyxgvnhkMeJMT6p0zN59aIUslqKH68+MS4c67GGq3oMs7O7sgeZ9+ns/LOTGDoNn3WcPmBWMFS/YuOsjmfdNzDbKoNN9GY/ughXcMqUutVEHDlzXD3pw56FSAJOhdnCdiJmK3CuBuKdlrGqQkYGdaP8KaZug4PvMLD+QTr0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by MN2PR11MB4240.namprd11.prod.outlook.com (2603:10b6:208:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 06:42:06 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::fb:42c3:2c21:391a]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::fb:42c3:2c21:391a%3]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 06:42:05 +0000
Message-ID: <0abf1f86-d023-a445-0758-436f4767e7ef@windriver.com>
Date: Mon, 29 Aug 2022 14:41:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [bitbake-devel] [PATCH] fetch: use BPN instead
Content-Language: en-US
From: "Yu, Mingli" <mingli.yu@windriver.com>
To: bitbake-devel@lists.openembedded.org
References: <170B7854B4242295.1911@lists.openembedded.org>
In-Reply-To: <170B7854B4242295.1911@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6230942d-dbfd-44df-073d-08da89899665
X-MS-TrafficTypeDiagnostic: MN2PR11MB4240:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gFKMcN628HKy/ZWhzm5dXPec5fQHgZbyvJgqkVOxGmLPCk47aHgO0pN5bIGJXE7/7tnr9MVXjf8ClClJsc3HOSFJ76FCcXiNZFuaQwHV6iduZmFF1a1ELbpwDWLuU6rEwV936ot1h3BmYpCYXqZCUpP9quElcxoKQvGbcOm1WHZuxKqMnugdo9OJyCuP/zLLroLvEIgYOA7BY3w+OGFxadAjeaFdWUwKh++wqEV+cTGA32pFSo8nptpCT0jzvssdDEpLaj3EPQIO8HRISzYk/wvBav/Rk4Le4yZUoFlcn2cNzjRy6rsD7ozmJsEoWZA8xGkl/KBm58+WJK5cpAe7x8TW++cQFQa7C8l9y06wR0v27WqwvEAApesS1vDXF9KadSN/iIzhWTbDovM3WN3eKrfCITKCFmdZBjCiMJqao7EllAlQA/mTBlfuwKa4z1VaVBI0y6m0cFPvNKe0bfLjl2TxSEOK1Exdhys59bjm/rL4dlaB5VTDfPdzVyMJIhkL5UvmoUld3bII82EXspHB302X4qHgObtAU4FY1Fp6E5Wo3OlOEb0XAX7aYGWxyHafDUKEzEr8DnpU5j3UzNkp8BZmv4RxDDsfAw4mawQnu5aE/8kCbHLieZDRVq7QF0cPGRAIq0JeGFCkkeunyzdMQsVkVGgRuCFfFAVQja1UNBNGohCT/v9gQ3rz8e7oB1bmJOjZ2s731Nil9ysWCQ1AB+2143Q2s83bWEySbG3MUmXHWPvYdzpxBjI2z/rf2T78glB0BZsPYqERhRcAPLOQI7ip2losuO2mdfzOWhtRgZLKgqdcXgkBcwTaSm4Ok5RFud3uadSCtpsqeGa9uci8bFhBarCm2YvZPA+mrYtTEvw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39840400004)(366004)(136003)(346002)(8936002)(66556008)(8676002)(5660300002)(66946007)(36756003)(2906002)(66476007)(86362001)(31696002)(83380400001)(186003)(38100700002)(6486002)(966005)(478600001)(6916009)(316002)(2616005)(26005)(6506007)(41300700001)(6666004)(6512007)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTNuNVl3N0U3OTRiVkc2SEZNbDRvSmtIUmtha3h0NUlMNjkwVXU0Q2MyN1hh?=
 =?utf-8?B?ckt6K1g2TVJiSHR2cG9VWFUwdExWZHgzZVM5eFVSU2JXTU9kQjR2M2ZIeHhw?=
 =?utf-8?B?Vmtobys4bytjczJsVnRhZE9mVzhDOFJFdE5CQllFYTdycXdZMUZmQ1A1Zlpn?=
 =?utf-8?B?dTllakRDUU5wTlJWVHhZbWh1TlRxY2JSa2xCWVdIdXJ2bzN3V0NHMk9uRTNE?=
 =?utf-8?B?SU1GS3lpb2xvRmhCSmxnc29QR2dhcEs4MDVVZndlMkYwQ0RMcC8vSDhyME0z?=
 =?utf-8?B?RlBITUlqT05aeEtreEZlZWFSZFVKemlhWGJISE10eEtlWTZHQXhVM0Y4MTAw?=
 =?utf-8?B?SnVzaFdEWmVVWHROeUdUZS9lWmZmbnBZRTkvcnVSMlZ0RzE2VXFqSDdtcThX?=
 =?utf-8?B?WFBobnFrc25UcWlaRlFsZjlLdkMwS0JpUVlQTkYvSXJsNFNxL0JwbWgrVHV4?=
 =?utf-8?B?VkFVUkxLMFU4bDc5V2YxemZVek1qWHFmN0hIQ0RDQXI4TFJERWZpcDFRbHdT?=
 =?utf-8?B?NCtEZjFINWlQT0NBN1FvQUwvNWg4L1FlOUYwckFKZW10UERrenl0cWJSclhp?=
 =?utf-8?B?Wis4OHNoam1NNmpVdkIrK0E4VXlyVnBRU2JDT2duRzhQMGpSeXpCRWNhWkE0?=
 =?utf-8?B?VlNxUklPTDlhSnJxWWNrNXljU1R3RjdHYm5QV0RCSnJUMXhZQTIyQWR0Qnor?=
 =?utf-8?B?ZVdGUHVHQldTaG5TajBFQkNjcnllSEtBY1lKazJlRm4vTjFGRCttaFJJUGpU?=
 =?utf-8?B?K0FveCtHM0NqV0hYbWtSKzE1enFXa1BpNEpGZi9BMVZldnJYZlpZNXk1Z0lI?=
 =?utf-8?B?L0dJUGFXeUVPTlc4N1FiSGJvY213dUlrR2Rpb05KbHdrc1UvQWN3U0wyM0VL?=
 =?utf-8?B?NmxOQjg5ZzRHaDVicDlCZjMwdFFZbExMN3YxanZDNzFjRVZ0ZW9wSHNMOXNp?=
 =?utf-8?B?UUJjWG56d1g2M1FxUEo3UlJnZWJzR1ZlYllMd0l5bXMza0tXbHpZOFdYMCt1?=
 =?utf-8?B?dWpNaWtmZlNpMDZnc1licWZPcjZhbVY0V2k0eUM2TDBjNGtJTy9TNVdkQUI5?=
 =?utf-8?B?Njc0eWVKckxyWGZ5MmtnaFo0RVRVMExHYnI3Wjc3dkY3dVNBNVQ4OTdnSjdW?=
 =?utf-8?B?clNpTUtJcnhRMytxbEJta2d6d1dsUm1qdEhOZDZ4ZGdxRjk2dTBqRE55akdm?=
 =?utf-8?B?NERCUzVGRExkay92c244UlZLVm80aU9VTDlyN3JTZDNpREprK29TMlU0Wmc0?=
 =?utf-8?B?UlVkVldCRU1iaE1jSmR6bUNPUHBuUTVVcEVRVGd2bmNvVnkwZnlXTHhyZGFY?=
 =?utf-8?B?UWhXVERpamRoZVBaengzeGRFNkt0MVMvQS9QTWtKYjZFSHZHZ0hHZ2hzWjdo?=
 =?utf-8?B?MWJRS3RCUS9JUXc5bVhkdGVOU1lZNFJxRSsrMFBudDh4eHZFUDJHOE9xN3ZW?=
 =?utf-8?B?Q3BsWlJSVVNONS9yQ09ma0MzakhqendYM1FxYXpUdXFkK0Z3Vkw4cTdJOGIz?=
 =?utf-8?B?UXJZaHdEdDBHcmgxRFNKNGlkREdOdnovK2haNHdMdmRBYW1INGU4c3Vla0J4?=
 =?utf-8?B?WndZUTZ1MjFZb0o2RVpjdTBuZ0tURCtqWU85YkdqeGpRWDQ2Y2d2R1drYW5o?=
 =?utf-8?B?WWlueC8yS3JZSGNrZUUxOHpueHJlL00vZUcxN2l2QnRrRWRPS0F5WGFDL0NC?=
 =?utf-8?B?WlRBU2I5dW1FNURncndrS2xiNjBDcnFyN2NjdzVtcTZGRlFKNVVTOTFxWi9t?=
 =?utf-8?B?cndodDBVUW15MTYwTlR1TVUvSlp4UHZLVlV1UllSMEdPSDNlVC95ZG0rN3l2?=
 =?utf-8?B?N0R1bzd4QUNudGl5ek13R2xGYXJnZjRQdlE1VmRZQ1FYSkhtWWhPSS90Z1Nn?=
 =?utf-8?B?SXpDdzBnRlZjTXpyaXlOczY0eS82Ni8xRkNaK2s1bTN0N2hEaW15S0hzZ0Jh?=
 =?utf-8?B?VWtyYUNiTmJKenR5ZlUrZWtySTEyeHVleUlENGZTYVFtdmFTL2dKOEhjSzVD?=
 =?utf-8?B?UXQvUFBaSWdSNFBQN2ZOQ3llTGx0eHQ2c2ErMmJXMlAwbFlWUmJJdHl5S3Av?=
 =?utf-8?B?Y1lWbk5udm5IZVhYTlBua0F4bDFEK1hGTWdKSkhsQzdaTXpjL25NSUdLdlVl?=
 =?utf-8?Q?dn/2u8BegJlfE5KziTfJ24hHq?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6230942d-dbfd-44df-073d-08da89899665
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 06:42:05.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 gBLvxqQ1Emb0DHjMonsYI6sKAvisr6Zs4e8VSCsya0rRB0W2bam/2hhLWreKpmoINOndwgNupN0cZaLHBcoA4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4240
X-Proofpoint-GUID: tj3WmjZLDBPF1j2WA4WnSXxLu2vjr6I6
X-Proofpoint-ORIG-GUID: tj3WmjZLDBPF1j2WA4WnSXxLu2vjr6I6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_03,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxlogscore=918
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290032
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Aug 2022 06:42:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13942

Ping.

On 8/15/22 16:46, Yu, Mingli wrote:
> From: Mingli Yu <mingli.yu@windriver.com>
> 
> When checking for the non-existing file, BPN is actually the acutal recipe
> name. And we should use BPN for the error message and it also fix the below
> test when multilib is enabled.
>   $ oe-selftest -r bbtests.BitbakeTests.test_invalid_recipe_src_uri
> 
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>   lib/bb/fetch2/__init__.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 0fb718b2..43d07e56 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1236,7 +1236,7 @@ def get_checksum_file_list(d):
>               if not found:
>                   bb.fatal(("Unable to get checksum for %s SRC_URI entry %s: file could not be found"
>                               "\nThe following paths were searched:"
> -                            "\n%s") % (d.getVar('PN'), os.path.basename(f), '\n'.join(paths)))
> +                            "\n%s") % (d.getVar('BPN'), os.path.basename(f), '\n'.join(paths)))
>   
>       return " ".join(filelist)
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13896): https://lists.openembedded.org/g/bitbake-devel/message/13896
> Mute This Topic: https://lists.openembedded.org/mt/93032280/3618448
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [mingli.yu@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

