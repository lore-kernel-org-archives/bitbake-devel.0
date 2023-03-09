Return-Path: <mark.asselstine@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57866C64EC4
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 21:54:15 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.4290.1678398854230656753
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Mar 2023 13:54:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=WpooDho2;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=243240c5d2=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329KqGO5025348
	for <bitbake-devel@lists.openembedded.org>; Thu, 9 Mar 2023 13:54:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=O/BgsA2IZudtnf3hRDad+NgiaoYkENiwvdc8nSV1G4o=;
 b=WpooDho2KIKnFFofrpnzuZQXmPYmQjFMjtd7rsDGyH2/g9vp+/uvH/hJM0xZQ/8uvM+B
 51ms7sZH1UAfXk8p94dPzVEIfVA3LH40T3OJ+1fV347Uja8evAM1ZHzAOTkDD0xQ9gBz
 clJSbujvpZot1JOUvDqQbRPH0wPvTy2x03woQVMb488bYdbvvZzHlTP8MgUgxRMTlbk3
 az8yqXcKPo8MwRbzrvzNy2s8Fh1xtNJ8KEYGcYa2tcAGTiAxAPGbIt9S8ReOd/zHp5nS
 2ePSPBUW48EwNtSSyd0ab0ugU6Sv6cAt3/BHk6q54jPTVehT/98Z61EANnVKgYTTscDa PA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p6ffd25gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 13:54:13 -0800
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329LqUWj023055
	for <bitbake-devel@lists.openembedded.org>; Thu, 9 Mar 2023 13:54:13 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p6ffd25gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Mar 2023 13:54:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHmN868VV4xsKpEvtv6dxI2eDsHq3J4bEOE3PkKKCW+tsd9nW9j5AP2LPN+AtygytaXSJOBpexPIdGKAy2+LMCV624/tcEcj5ETs0pCjqUn+LRONnsJ5s3CQz3M/FyhskxT51E1G2yT7iTfhD2N+ThDo+TaChrweX/2QI3y6CrJew0wIjUGhNiOup1mn2c9pZyrK0Mja/WXXhNZlRx/swBYlBFEnPfjHOR6STdB5i17GfxalAqJ3N+W7UYLvT0DAjuXma0CDgQlr5fT31fazVWRF1Yuy5YKFYMBT64VD8xtWaYY+8wUvHiiPdgPKg5lVbaEcFcQv0fSooeDWbOp2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/BgsA2IZudtnf3hRDad+NgiaoYkENiwvdc8nSV1G4o=;
 b=ClS0yMmAsZwo5Lp3l3UnnRiurFTqoCrV3LyHN/t7QUYJvMTFnOYD+gLOgxwb5LqCVnHB/2FGOxgLJ0CB1j0oeVlE3QrrPoY3TIeYdlkciHqfTXDsfEWRPzF4oVvyUe6FGzhQ4Zfi1uoX8PGOgUEgZnV10EgxiCurpTSybilCCob0f6EYoisaaTbsFdnyvZf/kWTzL7+kh1o0WkspydemcHLlFVsrskFYe4y8vU9cZlMgPB0o2FZYJO02Q6OEV1AAXGo9PTFRZfjKBHzjSTiIiD9zGcJnhxZZRt8UPaHo4o0qGdqgLtkee3tJLD28rBxdn/9fM4t4PjoNsqOIf7A1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6543.namprd11.prod.outlook.com (2603:10b6:8:d1::10) by
 DS0PR11MB6424.namprd11.prod.outlook.com (2603:10b6:8:c4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Thu, 9 Mar 2023 21:54:10 +0000
Received: from DS0PR11MB6543.namprd11.prod.outlook.com
 ([fe80::c9ac:b5b6:24e7:153d]) by DS0PR11MB6543.namprd11.prod.outlook.com
 ([fe80::c9ac:b5b6:24e7:153d%3]) with mapi id 15.20.6156.028; Thu, 9 Mar 2023
 21:54:09 +0000
Message-ID: <d653a078-dbc3-89bc-b5b8-17b1d924a99c@windriver.com>
Date: Thu, 9 Mar 2023 16:54:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [bitbake-devel] [PATCH] build: Make python output print to stdout
 when running with -v (verbose)
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <20230309192138.991-1-mark.asselstine@windriver.com>
 <fe609df3cf13d7eb6f0021eb2d3f34704cfaddb8.camel@linuxfoundation.org>
From: Mark Asselstine <mark.asselstine@windriver.com>
In-Reply-To: <fe609df3cf13d7eb6f0021eb2d3f34704cfaddb8.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::19) To DS0PR11MB6543.namprd11.prod.outlook.com
 (2603:10b6:8:d1::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6543:EE_|DS0PR11MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f520a3-72ab-4377-07a6-08db20e8cfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ejK8LKCxcmm4vYUdjr1JHptg0XKhbtF4VwgTxpSYc5h9He5aAxcBV0fSFJk8CIjVTIRu8+XnKAwVubsjgsrnrhxsYY8Qjk3fKcB8K6Ag4pFRFZF1pAM/hfuzjY61G/o9DAMILHXoJdFrMvB1jb3nB6nB4KpnGFnVrZ9zQJzgiUmWwsOBisxldvwfV0CE6JBcBt7PPyFg0WVnN/Eq4Ig59/PQcqUHoa5xpyAqKzcQ5VWeAwnP+XverfDP1lIatTYQbbri7DUG2pdabuLHx2wx1JNwTYUSWZNU6usvI/vNYXF8RG4lshAGLkYIZsWz9AS6Y1rDC+qLKoRmuU4CT+0MbSTgoLdA9gZthGsjSNcV9jGxtheIAs/mfBMSz61MjbOWq6Iby+EGDnkqmnr1dDqJvGnaJ0XYUYag6i38TgvFQ3BDJdzojkIAZQWKFJCweg6NntHmn6evG3zoVRmb85EZyu3sRA9LIs8THt0zoN7JlfgN2FQfg6lX+oVsfDeRytj57lerKmRRPj89rrQKY2PiBtd0vcwD6IiuB1GzP4ZBQ7BiSq6TsIvuVDpNuAJhFBRrW3t/MpxctnKS2tIUJ+HtbegZOw+MX8Nyxf2ov2aYnbOxEm7ua0xKsBXriJoxACakR2jv7WHzGcd2weKvnSC2mDwnjQjxc4Lv4k6Wu2ntYrexYLHMSEz2hD17LsNxV30evaQzj6n43CXBsLIB5Ur3RmblCPYynOn66d+DJcUwfoU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6543.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39850400004)(136003)(366004)(396003)(451199018)(31696002)(31686004)(86362001)(316002)(36756003)(6486002)(5660300002)(83380400001)(186003)(6506007)(2906002)(66556008)(41300700001)(66476007)(8676002)(2616005)(478600001)(26005)(53546011)(6512007)(6666004)(8936002)(44832011)(66946007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cnVidm1OYXRydlpKN2lLQ29TNExWWitDQjZwOXNFcEEyc0ZpYWdtMlRlb3My?=
 =?utf-8?B?amkvVGNGMHVFMXgwSFFkNGhIRnhhUW9oTWF3RHRzYjVsYXp1ZEFuNlA4UGZX?=
 =?utf-8?B?WkM2OXl6YTMrNVRBTElqc3pBZ3pkL3BrWEsvL1VRTWlCQm9zWXRQWU9TeW50?=
 =?utf-8?B?QzhqMklMVXhHRHowMUhMMzhZck9NSnFYNVdya094MGZ5U2dISVR3Q281di91?=
 =?utf-8?B?NTJWcjNyd2VETjRyTnkwcVNYUVRNQ2RTcUkvbHpjRXRXazNrWFU4SEp5dUdN?=
 =?utf-8?B?RDluZzRNVjZtSlovZjBWbEVSSFNkY0pRMHJZT0QybVltUnh3cFNrZGp4dEda?=
 =?utf-8?B?cDhkMm5ocTVXMmk1aXBGd0lYQlB5aDkxK1lSR0xXVkVnUEs5ZWJTSUQxTmcw?=
 =?utf-8?B?QnJpUnRnYVQ2clRrL3A4TGw5ZXFQWEh4UkM3VE8vaVNkQzREekNOVVl3TkpE?=
 =?utf-8?B?aVBQTEFac1drdGIzVFQ3aTMvYlpyMU1DTG5ieUFLVDdSeTV2YlVMRCs2TWM5?=
 =?utf-8?B?U2hNbFJtZXhtNWJLU05XL2NaN2pUVzM3VzlzbmRxMHk5SXFZNk9IYVJTdkh1?=
 =?utf-8?B?c241UXEzeGhrelp0cTJhbFhRb2RqZ3hXV1JCa3dHTkUwYXovb3pqMFJnelBJ?=
 =?utf-8?B?Y2Vubi9xZStsUjIzZHFwTW5kN1pTZEhyVUNEUnFEVEduOUlNMHJodjdrUFpS?=
 =?utf-8?B?bUtKWWIrNWE5TkQ2QWNpcHVEUGZITm9ZU1BQcUFDSEFIaWR6aUtPV2F5d0RB?=
 =?utf-8?B?Mit4dzVObjh5UU5tekdNWlVIVWJYTTZGelR3cStCbzgzN282VWdsSTYxeTE2?=
 =?utf-8?B?ZERKL0tHd2hKdmpYMGhNWGF6VGNaOTgvMXllUCtHSmdUd1VSaktUQ2Y2VVZv?=
 =?utf-8?B?V0hFN3R1TFAyc2d2NVRJVlVvMFN0aHhEa2RSMTIwVUllNTAxRm5PZnhtQU56?=
 =?utf-8?B?Ykl1NElxaWo4NzRoVWFxSERPL2VTYXRWVDcrMlYxYXJTc1UyVnJndGxCcUN5?=
 =?utf-8?B?L0hTQVFHeXlsL2Q0VytZZnZ4TTBVYk4xeS83K1ozMXlvUCtkd2lMbXFDNUdR?=
 =?utf-8?B?VFRsZ0sxOG1PVXdZYXExN2M1QzBEdDc4d3Q0c3VHcnFSZTdwaWZJZWhZL0Y2?=
 =?utf-8?B?WmlPMEh0Y3UyNThobXMrdmhPMEhvK0JIcDFoTXRZYUoyemVGMjhJMVVCUy85?=
 =?utf-8?B?L1k4c3JxOEJ6bnduanZZZ0lXckNwZEVVT0NqVkNRbG04VVRQZWxOWVJyN3ph?=
 =?utf-8?B?bXNGK0NWKy90VEFRaWo3SnpPdGtPNVBMS1Y0WFROeFZEbnZReFBmWnFPdWRQ?=
 =?utf-8?B?dG5iVzNjWGJkV1ZFWWFMQktYQ2F2bkdCV2V3YVpONHpNeC9FaWRGczRBTmVN?=
 =?utf-8?B?RmJMMWV4d0lQZElTTGNOSFkrM3VDZ0ZSQVJKWTRVa09RVUE1OU16dUlDSTVm?=
 =?utf-8?B?N2ZLSWIvRDM4Y2hQdHBJNkZBR05GTVZ3OE1jNHdLM3ByeXBPdEJlcGhHWWlV?=
 =?utf-8?B?MmFaR3JKMUMwUnBFWXlWYnFRTkJyUTJXVTdKZmMvWlovcHFra21vb3ZpSXpv?=
 =?utf-8?B?aVI5eTZGZXpadlNzU1lNenpWaXdaTjlIS29HYXQxU2s5a2tMVk5JZWRJcmZp?=
 =?utf-8?B?cTE3Z2ppemlRT3BXT0JyZS9oOHZjYmtvdkNsN2pXU0JsZXVmK042Z3NzYzBl?=
 =?utf-8?B?RjI0dEduUVRHMEg4NDhCMzZVVVJYNkFwWlFoSXVqQ2lkV21Eb2ZHVkJTMnhY?=
 =?utf-8?B?UlVLTitFSEEzdXluclo4SE56TGhieDlJalZUdnliOHk0dVp2ajN3K1o5TlMz?=
 =?utf-8?B?Ly9qcXU5ZG1TT1Z1ZWZ4Q2FUVDd0T0RpVUF0T0xTNXA2b3RWMUNObDVQdjJi?=
 =?utf-8?B?NHRDZ0pmOExjbXA0UjQxTlNRWEdCMzI3ZFpRUHlGRnJTcXlrMFZpaDBuaTNB?=
 =?utf-8?B?MU1hTm0wSzFOWTVRM09kMElRcTQ2Y3laTGt6Z2c0cEo1WXpNbExmRi9oY0U2?=
 =?utf-8?B?SnNCTnpWbUxKUkR5amllalhySzZpWVlhSWlWNSt1OTBEVUZjdzBsSkV5SVFm?=
 =?utf-8?B?ZzhncE5WdlFCMEp0eUxiMUJ6R3R5b0EwWHhRc0NvbzI5WmNTZW5XanQ0Z1hO?=
 =?utf-8?B?VENZZTV6b1RYTmFoeTdtallZRlF0R3RPbHZPNEtiSUhwMEptWTBFSmJqcit6?=
 =?utf-8?Q?JbIIOQj12FtDTn5MLmFUX9E=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f520a3-72ab-4377-07a6-08db20e8cfe9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6543.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 21:54:09.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nweTm95FkK41CmgfY5q74dsiZSs8rRDlRziP7GiYgd0yg5HKtUPIV8MdX0lCOT0UxyOrycHJYJm/lUR6kD0FbQR51HlTyVaIzeS26J+1APA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6424
X-Proofpoint-GUID: btfhH14X8hW3JTIv7_tAJKB-EUTv6ECf
X-Proofpoint-ORIG-GUID: 6H0LPYXGrkEF6FLa6cIP7QULNopsvsml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_12,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090175
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 21:54:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14533



On 3/9/2023 4:49 PM, Richard Purdie wrote:
> On Thu, 2023-03-09 at 14:21 -0500, Mark Asselstine wrote:
>> When tasks are run with -v (verbose) on the bitbake commandline, shell
>> tasks print their stdout, python tasks do not.
>>
>> This change redirects the python task's print output to an in memory
>> buffer. After the task is executed the output is printed to stdout via
>> the logger. This makes the python task behavior match the shell task
>> behavior when running with -v. The contents of the task's log files
>> remain unchanged after this change.
>>
>> This approach should keep the correct order in most cases, however, if
>> the python task accesses the logger directly, that content will appear
>> before other output. On the other hand, this change should negate the
>> need for python tasks to access the logger directly.
>>
>> The following example will produce out-of-order output
>>
>> --
>> python do_build() {
>>     print("Start")
>>     bb.plain("********************");
>>     bb.plain("*                  *");
>>     bb.plain("*  Hello, World!   *");
>>     bb.plain("*                  *");
>>     bb.plain("********************");
>>     print("Finish")
>> }
>> --
>> will output
>> --
>> ********************
>> *                  *
>> *  Hello, World!   *
>> *                  *
>> ********************
>> Start
>> Finish
>> --
>>
>> The logging-test.bb in meta-selftest or the above 'hello world!' can
>> be used to review this change.
>>
>> [Yocto #14544]
>>
>> Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
>> ---
>>   lib/bb/build.py | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/lib/bb/build.py b/lib/bb/build.py
>> index 5a172711..eb2d5b59 100644
>> --- a/lib/bb/build.py
>> +++ b/lib/bb/build.py
>> @@ -25,6 +25,7 @@ import bb
>>   import bb.msg
>>   import bb.process
>>   import bb.progress
>> +from io import StringIO
>>   from bb import data, event, utils
>>   
>>   bblogger = logging.getLogger('BitBake')
>> @@ -296,9 +297,17 @@ def exec_func_python(func, d, runfile, cwd=None):
>>           lineno = int(d.getVarFlag(func, "lineno", False))
>>           bb.methodpool.insert_method(func, text, fn, lineno - 1)
>>   
>> +        if verboseStdoutLogging:
>> +            sys.stdout.flush()
>> +            sys.stdout = execio = StringIO()
>>           comp = utils.better_compile(code, func, "exec_func_python() autogenerated")
>>           utils.better_exec(comp, {"d": d}, code, "exec_func_python() autogenerated")
>>       finally:
>> +        if verboseStdoutLogging:
>> +            execio.flush()
>> +            logger.plain("%s" % execio.getvalue())
>> +            sys.stdout = sys.__stdout__
>> +            execio.close()
>>           # We want any stdout/stderr to be printed before any other log messages to make debugging
>>           # more accurate. In some cases we seem to lose stdout/stderr entirely in logging tests without this.
>>           sys.stdout.flush()
> 
>  From memory, I think exec_func_python can get called recursively so I
> suspect this is going to corrupt sys.stdout. You could save it's value,
> then restore it?
> 

I was actually dithering on this and was saving and restoring it in my 
first iteration. I opted for simplicity when I believed that it was 
allways going to be __stdout__. Regardless if it every changes it would 
be safer to save and restore. I will return to that approach in V2.

> Also, what about stderr?

Tunnel vision at play, I was only focused on stdout :). It should be 
simple to add stderr and I will do so in V2.

MarkA

> 
> Cheers,
> 
> Richard
> 

