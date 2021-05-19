Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.5882.1621389548626510063
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 18:59:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=HlSlYJEN;
 spf=pass (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0773b53858=mingli.yu@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J1x705017967;
	Wed, 19 May 2021 01:59:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
	by mx0a-0064b401.pphosted.com with ESMTP id 38kuecrd9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 May 2021 01:59:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwe5qNrWkKfNBYjHNBiwL5tcHYu3Q/PXrUD3wmqhZj8P7R0Ai67LYM+Zws7oNja+x+zK09mxr834PcMX9lv4axbIShUgfF2Jd2QuKM5XIfDMjF3j3zCcrj0nJReoB+8dlL7m0oe/VkbS1IRAa5XWFuuzMS2eBNOpYnmDVPgxEHnGYX28tigPKZh69a6RTRf40AF7jw+JM3nZ0oX+PHBaw08u5Ev5DKZttm/Zz6AIfjPBse4HUb8XR0oTrX0nY8FPKaq7LZ97QjgIYnPgpi4Kogsn3IX2C2R4yKkcWXp6RHB6qqO1UYwxGZx22xXil8ZrIagiifuJSdScsTLT7aXrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6oONcw9njTMKj7DZYvdHuEf0Oyw2cnfx3VR6VXaH7E=;
 b=BmKD4wN+qPavhxpck4qIE3v05jU68tUSUmufJr2OIBCISHs+Qw4iMMc74X5KLLi5agmHSfNqZpeVme6pD/BMDqLkMfHCaI4xaliShVH39OsH4AVn1ONpXe9oiKUhtAm1g/Gj0NNhHldTTBFIqaNaoj8T9vCcOzgDRholDJmdcSHB1O05r8qm86I2huBz4aQhZ8aR5BtOPlylnOEjHgbMjx+/qrUkg8tTVC7XFl2LVzujnG7yRfM+AHA68W5SmPbwAy/ShXhFZHaIL0KT9R1GmLtruCB48wafVd8VsFEYc9AzZqX+kF38AZHzMatSKSPI9IWf8HlLr5FXOoWlLMy1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6oONcw9njTMKj7DZYvdHuEf0Oyw2cnfx3VR6VXaH7E=;
 b=HlSlYJEN+o6Y/KipBpbRqvmUuAXVz5IdtdHqeKKbVSa0IVjDJ7N92xTL2vA2ZeLWMJ96jr6iCgEccZjInp0SEd+par6NU/6A6luqDtSziFThLIzuodoXPWX59eR4juldLNPTcvVAsEgjXqFpp8eaYB4Ug8tQF8wTLujHw+bAhAE=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by MWHPR1101MB2318.namprd11.prod.outlook.com (2603:10b6:301:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 01:59:05 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::c129:2a53:5093:81e8]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::c129:2a53:5093:81e8%3]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 01:59:05 +0000
Subject: Re: [bitbake-devel] [PATCH] fetch2: make sure the uri added as expected
From: "Yu, Mingli" <mingli.yu@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <20210514060443.33335-1-mingli.yu@windriver.com>
 <6517f5c83f3902eb26367fa59b7d07ad1c24f106.camel@linuxfoundation.org>
 <167EDE5E75B22E11.24280@lists.openembedded.org>
Message-ID: <d8977b6c-c8bc-ab08-5279-42daa223b31c@windriver.com>
Date: Wed, 19 May 2021 10:05:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <167EDE5E75B22E11.24280@lists.openembedded.org>
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::20) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.140] (60.247.85.82) by HK0PR01CA0056.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 19 May 2021 01:59:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89856480-acbd-4521-3d9f-08d91a69ae75
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2318:
X-Microsoft-Antispam-PRVS: 
	<MWHPR1101MB23186B3856D87E2DC07404F6F12B9@MWHPR1101MB2318.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RCmdY+SZ4EDhk4klmOYoWAMMLApBPA+tAnTuPlIUawJGwRAQSWGI/k/dwNfzntDLiNUXJYU/te8E4Nqf1GPJlKb/ClfixYphg5DdpQsll0NUqoN0M92LU8ej06PcrJsLDkXrwtOu/y4YdW3bWvzJicEtGur9GTwqkummRvVN3jJd467gETIrxRpVMX8oI9uEgCRt2Ily6A1D5qsYzsCI/4xXgbuw8GU9UL5WmW1MDcV5kwvDDc3CQ7lAfwPC9XTvgQrpK9EePq3DfE3nej/GEriqEiCjfwVU+cpeQAMETV9nGaae9fWxz/dLG/z4mXffO0EYiJbE6Xwq+6c/yw0u5mFtkuBTF30oMQZ79qJRx9THGrkDElAlKQfSomL3kty1AxXidmm/vzf1GddAx9/NJp78w0Q6+1vyL0BWqYSxLTJFIk9ky5IWpZHE/izw6ocC7RN3uHPQTPECauFzkfCdqgBfM0E6tA/X3MpLcmRnDseEAf+Njf8qRQGkGCe+78iSi3uSK+O21/AKqSWMeQGqjbCBVodlnKN0Pgs/OVRdnEEtEH0AhlsojMqOp+Qmw6K57o+23NG6Fz8Zj+i3XwIcMoDBIiieggBC4Miccltw41GS0fdesoPAdPXbE7CL9FciqBjrMLVWb+lH4nZHrI9ba2c/ASRJ/sB3sWoCaUGec2X0TwXDORBUNWiJc6YcL2lF+Eqva3rJNCGtm/omxYOpebCWuM3p2QmLdW1hBL3TCqCfWMtLlrzLsg6+G7CsfG9DV8LckeD8fYl72CPVx8T92TRb3puizvSPxrxbxfzmzr9M2lfHunahgavb5bCC8Mug
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(376002)(346002)(366004)(36756003)(966005)(52116002)(2906002)(31696002)(83380400001)(186003)(16526019)(38350700002)(26005)(53546011)(8936002)(86362001)(6486002)(38100700002)(2616005)(956004)(66946007)(66476007)(66556008)(8676002)(6666004)(5660300002)(31686004)(316002)(16576012)(6706004)(478600001)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?a0N0N2EwUE9CWWNiMldDd3FSL29hYlJZRDRzNmdqQzh1bVlsT1JrSVRCeFB3?=
 =?utf-8?B?bm5oenNkd2xGNlROdjcrWDhtbjJvcUtJd2FMV2xhUy96TEZrOTlPYVhQUWdY?=
 =?utf-8?B?RVI0djJYYjZOWEZiYXJpTHJVRmlneWswWHkwNU9pZEZEMGg3VldYb0gxMThR?=
 =?utf-8?B?bFYwUERkKzRZL0c3aEtIb1YzUE1wMzcyL0dnaFlpUCtGeGxCRFJGSlp3by96?=
 =?utf-8?B?ckVCMTg2NlRZdUxkU1p0UkRsbVlKWW9YdzkvWDV3WUhNZ0tFZHhKRWE0TVBF?=
 =?utf-8?B?UTFvc0R6SlQvdzEzU1NYMWY4aHROZ1ZvbHA0cFZTNlY5MXEwZ2xKYWVKTTAw?=
 =?utf-8?B?WUhiUUlBMUVZQ0l3L0NlM0FYemxnUE5XaVh0R013b01JMDQ0L2JzT1ZjNVZM?=
 =?utf-8?B?UktrVFBSMHdad2lXSXd2d0tYdjlpbkU4eFJBK0hSUjh5NGdSV1J4ZWVhRmNu?=
 =?utf-8?B?ajFHYkNpMzJtWVNzbHJCOVA3VkkwTGYyVDFOejVSc1JmTTFDUnlDcUdHNTlk?=
 =?utf-8?B?SGNVQ1FVdUd5akZxbnMvQ2tRem5YalZtUk5PU1I1d0sweFNNSnJKV3JaT0Fj?=
 =?utf-8?B?aVhEc25adGR5MTlMNXBwdVFBLzBMZktscTc5Q0J2LytkaU5iRW9zcWRFWmxT?=
 =?utf-8?B?eWZnZW9FYmZMdDhWdXlWMFBsaG9KUHF6Tzk5VmJ6SFNuajlTUDFicmN5enBa?=
 =?utf-8?B?Vk5Rc3pWOXN0RDZRZ2h2M3ZlbmdabmVsVFg5UTVlSDFsZVFKSDE2U2ZZYjl4?=
 =?utf-8?B?VzVjbEhKeW0zK1BHYTBkN09jbm1sU1ZybDdIeWRuMHJpRkk3L0dGaTVoNWly?=
 =?utf-8?B?eGgvUlREdENhNkw2RUh2Z3BWeWtpSldqckZEVE5LRW11cWEwOG9sZlBnMjQ3?=
 =?utf-8?B?QWZvdnJnVkVqTzdYbWNYNkkrWklmTUF0VGZaaHR1TEdnd2xTNklMM3FMSVh6?=
 =?utf-8?B?dUVUdmVLdVlTVC91RnRwdGV6V3U0aEo1TkQxcWl1ZXgxdlFreGVUVXJCSzZa?=
 =?utf-8?B?OWZlNm9Hc1ZkQjdQNUFON25XT20welllU0kwc0t5RzJuZWMrRlVLbDdJekh3?=
 =?utf-8?B?cnpZSmIzajZZMjBhTDRqSTIzQ1l0dGxWcEtxcStMa012aFF6a1paMnk0bUtJ?=
 =?utf-8?B?a1FuRnpqZFQ1Szd3Sk1obHFBK1dsUkRrTHJodUtrSklURnNmN1h1bWZuMmUx?=
 =?utf-8?B?T0dLenc4bmFoWmQ2dDNLeGZwcVVpSXpJMjNLVXVCaDArZ3g1TnBQU2l2RkZ2?=
 =?utf-8?B?aC9ERWxScCtFMytrT20zK2VCTFJJOHZSRU1Gb3VGSE9kbU9MMm1hYlgweHlW?=
 =?utf-8?B?aEF6V0dwRVVSOHgwUUlGQkhFNmZBM0twbWN3T3VCTDRxbUFqRm81aDlEVDl1?=
 =?utf-8?B?VE0zaHN3SzFtcytQb25mdExUU2pTNVl6THdLcjI3WGgydmpVUVRBUGFNanNn?=
 =?utf-8?B?ZVVSZUZtKzQvTkxGaG1HUFc5N2tUTU0vQVUraTZ3ZjI4Rnp6a1ZQbE5JbXEz?=
 =?utf-8?B?NEMyL0xuMGRrZXREMDk5Z3FMTWJzbzQ2ZVZiaDZCZmdVcDlycHRKVEpLOU1z?=
 =?utf-8?B?b3NjaGxIRFJwelMvMDBnVlRvUGttc3NpN0R6bExxdlg5VytFRnZiNS9Fcmt3?=
 =?utf-8?B?L3Y1OHZDbmlrRlJwd2NJVHFJSDk4amlRWTAzWlNPSitKYXhmMWR6RUVBeUs0?=
 =?utf-8?B?c3pES1VCL3hKbjd1L3pBTkxOSjNYRjRZWDluZ0ZhV2hwamxpZDJIdmRXNmJE?=
 =?utf-8?Q?PCyZ2LOwOGJcBsEcgVuq+ytMFE9ybjX5BdNmDng?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89856480-acbd-4521-3d9f-08d91a69ae75
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 01:59:05.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uThgioD451CNTCltpbgA+NjuDsqU28cDTYqi8ULuJDqhwjC3MPLu1myf6qamcI41iz/GjJBUoZJy8AbToc+hLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2318
X-Proofpoint-ORIG-GUID: WiEaXESNFLTqjqOfG_0vL9Ad2yZPYxzD
X-Proofpoint-GUID: WiEaXESNFLTqjqOfG_0vL9Ad2yZPYxzD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_11:2021-05-18,2021-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190012
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 14J1x705017967
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping.

Thanks,

On 5/14/21 3:36 PM, Yu, Mingli wrote:
>=20
>=20
> On 5/14/21 2:16 PM, Richard Purdie wrote:
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>
>> On Fri, 2021-05-14 at 14:04 +0800, Yu, Mingli wrote:
>>> From: Mingli Yu <mingli.yu@windriver.com>
>>>
>>> Make sure the uri added as expected in some scenarioes such as
>>> with below setting:
>>>
>>> PREMIRRORS_append =3D ".*://.*/.*=20
>>> git:///net/SharedImage/downloads/git2/MIRRORNAME;protocol=3Dfile"
>>>
>>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>>> ---
>>> =C2=A0 lib/bb/fetch2/__init__.py | 2 ++
>>> =C2=A0 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>>> index cf0201c4..6701654b 100644
>>> --- a/lib/bb/fetch2/__init__.py
>>> +++ b/lib/bb/fetch2/__init__.py
>>> @@ -430,6 +430,8 @@ def uri_replace(ud, uri_find, uri_replace,=20
>>> replacements, d, mirrortarball=3DNone):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uri_replace_decoded =3D list(decodeurl(=
uri_replace))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger.debug2("For url %s comparing %s =
to %s" % (uri_decoded,=20
>>> uri_find_decoded, uri_replace_decoded))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result_decoded =3D ['', '', '', '', '',=
 {}]
>>> +=C2=A0=C2=A0=C2=A0 if uri_find_decoded[0] =3D=3D '.*' and uri_replace=
_decoded[0] !=3D=20
>>> 'file':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uri_find_decoded[0] =3D ur=
i_replace_decoded[0]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for loc, i in enumerate(uri_find_decode=
d):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result_decoded[=
loc] =3D uri_decoded[loc]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regexp =3D i
>>
>> I've not thought too much about the fix itself but for these kinds of=
=20
>> changes
>> we do ask that the tests be updated too in lib/bb/tests/ (run with=20
>> bitbake-selftest).
>=20
> Hi RP,
>=20
> I think the current testcase(lib/bb/tests/fetch.py) is enough if this=20
> patch doesn't introduce regression issue(run with bitbake-selftest).
>=20
> BTW, the patch solves the problem which I stated in the comments.
>=20
> Thanks,
>=20
>>
>> Cheers,
>>
>> Richard
>>
>>
>>
>>
>>
>=20
>=20
>=20
>=20
