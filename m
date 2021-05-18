Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.61])
 by mx.groups.io with SMTP id smtpd.web08.6059.1621329582938677517
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 02:19:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=KRBB3lZm;
 spf=pass (domain: windriver.com, ip: 40.107.94.61, mailfrom: mingli.yu@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv2D37WWgCQat9Iwve69Zu1KFY4Itd4jZX8dpNCADEhwhcHXkWCfmENxnX4ncmkV3hU8XVJPhtA16VRVeDKXcV3Kahvc2bzBcJBJNAL3ZSWYcIs5Cx7aSuk6WK4b+nIJiytqH2aBG9eRIl8DY6Hod9t8v01p/BY+9uHUZSvkubEx/ioqrIF15MbwrWFLxsxxvQ0Gr/dFvhWn8wJlteg1/oduHbOGYvdAHC5rJ2D/Edfx8oL53ab5sguudehwuFIYHlKgF95KB1RE0d6QtORPhG4gsY+bFEuBcONcGhQAYUwMlfco4rRFh44qPR2Vvl9pk8lwawUvfSKvhE6JXuXP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6oONcw9njTMKj7DZYvdHuEf0Oyw2cnfx3VR6VXaH7E=;
 b=MT+d8YvDoQXJqWr8m6P4Sf9wt+ZfG7XAWz1Jbx5DiseZuiI+PTR+c7j/dFbWoSuYuqftCi6IkAba97Nu25XASfM4QwAUv8RGttIh7Xn7GrFPTQH8eL7N6T5/tli0iQJw6phhFIj+U33X28OwwkHCTFArBpes0JTIo8Ip1qrPlVbS5pUX23HP74KHR8ee+CTu0ai9IwigXZj7f9dx5FENps2eyxPBQ3cQ4XWJeFWkMXr4ColqtTBM1dIpZ1ZrCka+1MiaO4gv+EpRb6T+2XNVI7i0G4pI6pKrMOoWiLoIhoxhRYcZeBfy9dZvOd1FDXSDqSNMUuaqBbhP+3eFFcYnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6oONcw9njTMKj7DZYvdHuEf0Oyw2cnfx3VR6VXaH7E=;
 b=KRBB3lZmD5RxMklhJ/413j8tguCsBqgAQ2IcWY+LwUkTrzSWacLClJURZBds+n41t3SsKKk0SmVeXcJZAd3+fH7uY8JUNgbrRFYJOpU9fCIgbhPZBGi4j5k9qVkv3hgW57MI/TOEZQme3RBcURksnWcE4EI5lQDhyLyFaf60biw=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by MWHPR11MB1536.namprd11.prod.outlook.com (2603:10b6:301:b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 09:19:41 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::c129:2a53:5093:81e8]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::c129:2a53:5093:81e8%3]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 09:19:40 +0000
Subject: Re: [bitbake-devel] [PATCH] fetch2: make sure the uri added as expected
From: "Yu, Mingli" <mingli.yu@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20210514060443.33335-1-mingli.yu@windriver.com>
 <6517f5c83f3902eb26367fa59b7d07ad1c24f106.camel@linuxfoundation.org>
 <167EDE5E75B22E11.24280@lists.openembedded.org>
Message-ID: <0bfd5486-9494-38f8-1dbc-a9210c6a8dfe@windriver.com>
Date: Tue, 18 May 2021 17:25:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <167EDE5E75B22E11.24280@lists.openembedded.org>
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:202:2::18) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
Return-Path: mingli.yu@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.140] (60.247.85.82) by HK2PR0401CA0008.apcprd04.prod.outlook.com (2603:1096:202:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 09:19:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7ad26f0-81b2-4e3c-1b7f-08d919de10cb
X-MS-TrafficTypeDiagnostic: MWHPR11MB1536:
X-Microsoft-Antispam-PRVS: 
	<MWHPR11MB15366F8A2353A1FB1DC0B14DF12C9@MWHPR11MB1536.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JJBcgcsd0abDjSLgY/qqEzdZmdhha3a2gv0jxkoPCcVeCEA5ph8S0lXs2y+VK7Ce/dR2kfSpx9JRBKClaCFGzfsaU4P1Q+Drkk63iCJ3lXpUB7DHPXXYc1eDGY8AIW58OPw/+qNWwPXAsCJnUTg4zIa4HEvGKBN/2u+g5PL0nY6Jgfq+0siApcLXLKDKNCdr72OhnKyq1iv5NFQk/+6ZN8HPGY++mze6KSc5eFfJjaGlp7jdtrI7qKGcemFff8TtnVbQy96waRiIvjKMkDA8SBv/FOLIsE8I36HhXs67HEMEMpGkVUWAvaEQ139qSnHq9iRcDlIDlZlqrQSePtcwKbTPw82eAWuqYIY+Ab5IlwmtjwKqeIn6O6mEzOWCCP99ZPtugtdXthsVpFYgM0y/Xhpbd99iPF0FeEAsyw96iE6gs4pyFCxxm9f1XN6c6FD3NzEFbpZ7masqMrb3XFaDK0OnhGD3KaLa49d44cUXyC5F5/NWQLzs/FNi0Klpnmy78V7QKgYTeSZZsFuF1+uv+uRZIliB4vvN/K+aVlc9wevjsWNuUYRzSNEX9RUgG+b21PlGlGQQRKMi/iHUx7nXdOV8g21hv6IqnqsPP/aJZDsj8mh63IzRr/NZrIzRnVrFxULFIESPNWxDv5qR1O0tGDCt8xFLMz1eSMOhCc2xBk1AnLC2BU7aAUQZ2Q+4XI5Ef8Lf9Douv/vTQIGu0zxMSYfhV9TAnZqoIDLO4v4dXj8LafXQph3NcRguGMTWnKDencph5CJa/Dlkb+es6cALHALtgEtrfl715vjLAk2Igh/Yjl84xiVsJLnaUdeCPxJY7Y3M7A1ajpwwk/F9ZYovCMHuqDc03dRPI1PavrkWUMI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39850400004)(136003)(376002)(53546011)(31696002)(316002)(38350700002)(31686004)(956004)(478600001)(6706004)(6666004)(16576012)(6486002)(66476007)(5660300002)(38100700002)(8936002)(52116002)(36756003)(186003)(86362001)(2906002)(66556008)(83380400001)(66946007)(16526019)(966005)(2616005)(8676002)(26005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?ZeOnCttYKuA+oTdyiRrxJCr8dPMXb+m1hxmW0Iz+ICOCt9v/1S5fohMSI6WS?=
 =?us-ascii?Q?dOJD1TgVeTMh/2lUXeVQQGgIu8pyjYdVy/r1u+Usc2NiNtSWevohQSZuVxdK?=
 =?us-ascii?Q?YKlF+2wlY5pWOmfnLtWFzOyomu5ikl+oLN/+HCl11BnJOzXVIFfwg+u5bqPu?=
 =?us-ascii?Q?dZ/zDERekeKZqQVUfCO8OW6+uwET7qQ2eG53X36bgWyhCNVv5okI5GIhI8UR?=
 =?us-ascii?Q?aZmb/Q3ZHgRrYXBnoWHIUH8kRbE2pJkXXpAyi/k/s2BsBzBH8sq62VOFDHAL?=
 =?us-ascii?Q?ypuprZBzLuc5YsfqahsbQAbsPKv7Lab9kCNcKu9Znkiyk89cCgHOo5SMumHs?=
 =?us-ascii?Q?J67VFfzvEproM0vSXh81AKdKz16//ImPCFU3cgjrSqA0HeBheTev495wxmDs?=
 =?us-ascii?Q?+KvVBBIuYsSPAaNYq/gSiPfqLKSI7AMIFbrJsgudlTjbQIlY3S3TU8VIrILX?=
 =?us-ascii?Q?kI7ZwmWLVIYwg6Sl0UjUO6ErfbHBCv8rqgIBWdpIyYv5QabazUg0MJOT/pjn?=
 =?us-ascii?Q?mxfUfNG4wfh/YhNs1DWucBH+n0toqn6YPPjRmZ4KXPFm0DIhnwJCJrk02GA0?=
 =?us-ascii?Q?R9p2FzxlUdYDGUMIi2jX+30ovfx73UClkwGap8qvzNQJw/aHtdH2yECZofcF?=
 =?us-ascii?Q?eLrVPSanFicoMJvJBSZWTDW8WTXxlnEZ6uLPRc9X0CpSPspuN+hECEMt1YJI?=
 =?us-ascii?Q?q1tyXsv7GVHRfhXl3Dqaxe62CtjjHFKClyqPllTEseeq+LjLW3Hvrk8Lzl8e?=
 =?us-ascii?Q?VYcCiti8fJ0UlF1tRykD72AFfAgCV2Rm3WfeGyVq+9YDFWInidzimPXrQz4/?=
 =?us-ascii?Q?68ycBZkuKy7Qu5SGKCTSDATscyxMcYSJg9/Zrfv5FO1bcd2pMieOd1fB8E6B?=
 =?us-ascii?Q?wQFUq2DDlkb7zfsrm7bAnkl5xgYCo7jng+yxIZfM5tRp6PtPMVYLFu20EKZY?=
 =?us-ascii?Q?vdpNPCtyRNmeMQftWtq6dpAyF9QjK3QXJCDcZLf1jbWWZnW0xCa/IvybUY+5?=
 =?us-ascii?Q?eVNEBSaELNm/wpacsXef2pcdN47BPYTNRSuY3rJL29CANZgE72CVAAlZWVxS?=
 =?us-ascii?Q?+pvjiAKhGma4Sr74tAhAzSv5v/6rkeK6xbEO1+/+T+5+DiPU23e8tOjPU3RP?=
 =?us-ascii?Q?HwFlUiztpn24ds44Y49uv/ocCm9pvynk7alwmCfUEvrq1345lEWsy8m1WfwR?=
 =?us-ascii?Q?sfCYLr19NbnsJNIbaQv+q8gdSryhf/BxA2avEKyu3Rol+/GM4u+4mBeMCk+N?=
 =?us-ascii?Q?DL/gINJ7YwCuxzUNgsCprdwqR9Sujb+wdyymaeck2ZeXhL8QAqCXIycs7C/R?=
 =?us-ascii?Q?FFL8igX/b5S3d/zAyNw/0+Wj?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ad26f0-81b2-4e3c-1b7f-08d919de10cb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 09:19:40.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoWUxlvgpVtCVPN2tfR1rZFcr2600x3na5H8wMHXmWQxqi+gGRZlyORX1q6/Js4X3MgLCu6hwQLSqDoxsTah3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1536
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
