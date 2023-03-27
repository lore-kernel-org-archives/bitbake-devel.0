Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97306C7619A
	for <webhook@archiver.kernel.org>; Mon, 27 Mar 2023 05:06:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.27962.1679893591738790203
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Mar 2023 22:06:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=FVeNKhaB;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=24501e850a=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R4lngM021212
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 05:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=K/hNNo/Ix9uGalN8A9KS2BwIa7RHCHWFEXTiYuadrFQ=;
 b=FVeNKhaB/l+ez0CgXjhOxEGWmnmmN5ZuI201CoiQPNiNsZ0+fBSxSTCH+nN3ILX4QfcW
 R9n01LbUjHMRB2fdxfrQlziprPqzNFc5AiDYgdul3OmAIkBp1OsOFFGlQW3eO9Q/Bg/J
 nzDMrePRFHfiEX8cf9gjP18NFa4G7TBVtyohYOZ4dKX2NJZTEXykuV1GQxUWmoqcNiWB
 Sff3OIhrROYqOkPxENqdm6iQkubdJZPw/70ppyqvQiGbTYnD9yHPJQZzoqsY86PntCOs
 zxK1clvRgtJtXAeUGKCd5iELRVvHrWa5rqF+O4qQcBDHV6oMG3Z1yR3RfcuNdEuf37hW XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3phqxbsjtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 05:06:30 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32R56U2q025424
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 05:06:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3phqxbsjtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Mar 2023 05:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT+ATVLaiHf1ec8Z5G0odoChht58i6D0AIQKWSMOEqTQKJBcizmB1bJRjfePB6OOsvRKElgun6cR0Bg5u6p+6FpWliHolE7fUiUHgMUD50z6scorXVf0faUB3SHELwsl3d6AlxYylRyczSkZvWDDZpi/Ng/NmIV0hHWeR4mPm/TOB7ejNcBPnuNAhqjX9jsd/yPSbniI32DhoQS5BTKaVRtM++lW0kv8m0zvMSXQLZViOifGJPOyAtMo8OhyiVY5yh/dHZkWsceafntgqu9qN3pQJFepQNVRqCOwWttAyJcCh/dfVP3Ee03xAYkJUubM3gaKN285ej3/dH2B8CRrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/hNNo/Ix9uGalN8A9KS2BwIa7RHCHWFEXTiYuadrFQ=;
 b=GI2fCd0wZJQxSJfAqgueEHtIhc3hX0bp1aEjtiTOO+cLE4Pnsfq232/QxH2G9PVC43bBUMw/mJBnuObrBmWwu8N5hS+oclC0A0Psg/mO1z0s+trlnGnE/xi1NI7iskzD4dzejPGjkqN+ExaUt/mKNKR5OemtYS85jxEsqne5iqy8wVf5JWE1+n4r1VoOI1/5TL/Z2g7k8/oxvDA4DDCjNEzN1lPJkzYRnJUTDQVkk4rFfoHa/G79PNJ7WUIQs5eqtotKCIykmmVlyLVNGVU/nZKUb+Hu4PqEoLTPTu4Y0zu/IjaiuS9Y+UZf2KHYTNd5XxVERWqrmhANGBz7WfKtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by IA0PR11MB7212.namprd11.prod.outlook.com (2603:10b6:208:43e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 05:06:25 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::f4a4:6efd:1e60:66c]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::f4a4:6efd:1e60:66c%5]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 05:06:25 +0000
Message-ID: <7a849ce6-052e-2ac0-d619-1f25bedb3e87@windriver.com>
Date: Mon, 27 Mar 2023 13:06:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] fetch/git: Fix local clone url to make it work with
 repo
To: Sam Liddicott <sam@liddicott.com>, "Theodore A. Roth"
 <troth@openavr.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
References: <cover.1679641659.git.liezhi.yang@windriver.com>
 <e763d75fb33b69bbfbf3350b2592b4eea7d3878d.1679641659.git.liezhi.yang@windriver.com>
 <CAFMvBt3DoQmj371=wjzTefmvKdXUFwZGjSXggGnFYgqcK=Ftaw@mail.gmail.com>
 <CAOj-5WA_qcjPBOH7Jt7N-Hb1saPNeijHg+VA3qKL_3gs7DYD_w@mail.gmail.com>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <CAOj-5WA_qcjPBOH7Jt7N-Hb1saPNeijHg+VA3qKL_3gs7DYD_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_|IA0PR11MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: d318861b-2f2b-40a1-98d4-08db2e81034f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XNwL7onmwL/wb0ZVAk6a2/7zWEeo2rt5zzgHtIxfmV+bwwr5Z185bx9V3LaUOkqclpsq1fWXF1/rojk4Udd+BK+vLmSeIvPT4yLFfjYZhPBLgAjakrz5vktXSdjWnN7AKUL74WnPR20Q/XoCI6kQxOUt2FQX0I5wWyXDJfu8qqQlzdrVsZdVxXcIxXEntCBqnWWKfaJ1sl/nvQVefYXxC1EhqAgwhrptaqmQ1Cp58sXGJ++kgtUIw7V07TgcyGnocTaRMJhYJBujPL8teJ5OFY81O9Rm8m5U9C7WQDTv64HKlKKgh+miaxFMwm/nGfnxMhFvSUDWzjGt0kkBT6vPZRUEFhUOV7wT22AYjC3SdtQjr/i+e024Fu/a9Bh6/PKnWFCmuTzqars+bxe3+DJlYRwLI9DNhEL0D/4FERTpHhubQoBRGnF7v5xDxUTe5eSw34FWnDq/U7RSaHxkqsN+gksggAeYHu9VQ+6e9AfMrELGhU8D1dMBYypzu2JL82Edsk9aZfRRiIOubA0fya6Uj+HWg6Dimeyy7hkK0Ed8hjKeUw7PZiptaoucwzI8m9NHYYMIDswtTb2U0/uNBmowrJIkX7Lzq0qNehZIYffzd6HcscDCJp/xAY27hce9xZYOVdJ2Vk/5UmkUUfeMD1z36A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39850400004)(136003)(396003)(451199021)(31696002)(86362001)(36756003)(2906002)(31686004)(478600001)(6486002)(966005)(26005)(6666004)(83380400001)(2616005)(4326008)(316002)(110136005)(66946007)(66556008)(66476007)(8676002)(186003)(6512007)(6506007)(53546011)(38100700002)(5660300002)(8936002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnIzeS8ydVVFRkR2UDVmeVdqVHJUZ08vVnNIcUN1emRXZnBla3hOMExwYVdi?=
 =?utf-8?B?TUJyRkdMank4RW5hc0s1dWNBQklJa2M3V0JnMzVKZkEwblYxOVdwTTA1N0tw?=
 =?utf-8?B?Mzh4bEhqN1M0MDdNakJLcGNqS3Q1bndLamZXaWlyZXgzVW5FL0VoeS9QMWRZ?=
 =?utf-8?B?emNXdmZMQWRDT0lLSHRIeGpiSnFFa0FGbU8vQk5mUldNcCtjT1Fqem8vODU1?=
 =?utf-8?B?NnZxQXZDUTZMOWt6QUVuTEZCZm1tdk9LeVdqRmtnZHZOUXpubjFzODFNTDBL?=
 =?utf-8?B?djEvalRDViswbVY4UFdVakZTQjdHOExORnJHRjdFUEpBanZ0ZTlQWHFtZnZJ?=
 =?utf-8?B?WmM5R0p1SWZ5UTVLdVpWVWNUb1ZBcGRPak4reGZjT2VPdEtOZVJMaTRTeHNa?=
 =?utf-8?B?bytiYit0QlJIbWVNVklWWVhGRWVteFFpQlNJYVQwRjdzZ2lTeERvai9aZ05P?=
 =?utf-8?B?YTd0eVpTOVRCSXd1S0VZZk9aQ3M3Zjg2RmJLMWJiRzNRaXdBVHNIMW9sYnVZ?=
 =?utf-8?B?YXFFKytWYVNXQzAxNmhGSG9HQXlRZUwrYnJaaWRWbDk5WG5hNFVGL2p2R3h2?=
 =?utf-8?B?TUxxMHRuSFBhcUpOWVgzRllCSHAwaytNMmtnZE9FdWhWUXdxelFoZFAwMmRS?=
 =?utf-8?B?VFdPTktMaHVKR1hOWDBFZnZuRzJpUmZ1a1BsQkFHcG1PN1VvREcyWlFKL3hr?=
 =?utf-8?B?U09OVURNaUV5N3JWVER5c2pueXNvalNJMDhVN0NoU04wVU9LVnRNWE5ucmJN?=
 =?utf-8?B?WCtwSFJRVEpFdVhpVHovWDNDR20wcy9UZTE1ZjRZOVRpbEVVUWJWSGpzeWJs?=
 =?utf-8?B?U3hFaW1vY3R1bXgzL2gwWm5ZclpoT0RlQm56NFFCZlpBYUtSTTB4TENlaXE1?=
 =?utf-8?B?MlZJVTZ2T0doNnhJZlpST1h1eDQxMFRFOC95SXMwd2wveGxLQWFvL3A1ZVFl?=
 =?utf-8?B?a3NScjlSeG9JZ0kya2N6Uk1Qd1AzUlphUlNQVmg2TG9PbHlJOWlVQ05DbGYz?=
 =?utf-8?B?S3BJLzZPRzB0Y0JCMlFXSlpvM2ZzT2FZQ1A1Z2hnY2p1WDNKb1JTTjBDRkhC?=
 =?utf-8?B?T3prTVR2Tm4reEl4ZnRvR3pSVmFxM0plQ1VEY0FUYUpRUnE0NXZyWUFIMnMr?=
 =?utf-8?B?TDYwcEErZHJwTm1yQ09CaEtzRDk0VGsxWTlYOWpOQjhCcmxoOGdCWmV1UWdw?=
 =?utf-8?B?Y1kvenBDSlFkR0JPL0lxS0dvcDU5ZDZmNEl5V00xbTBhR3RlLy9lUGEwelFo?=
 =?utf-8?B?aTZ6MUhCWUgrMGg1eXkzbTJHRGdpUDhjSVM2RWpIVTV1VmI3Ui9sQ2YyUDhL?=
 =?utf-8?B?R2YrWW5hYjFhTUxld2VvN0Y3Zko1US80Y3hnamhMeHJwVVlUMmk1ZmEwczNl?=
 =?utf-8?B?L1h4Z1RpMUVTQWNNUGJqbmtsMXhBSEEyVno5VGJwY2JDcnl0SjcvSnVvR2NN?=
 =?utf-8?B?T3pXblNNN1V5WFBaemptbUtybjNCSDRmMEQzZW44UzhSQmR5V012TTBqM2tj?=
 =?utf-8?B?ZzdiN0NVMHgvV1V0ci9veU81aU9HcWFVRi9Yckd5MXo1RXU4UVhRd3dxWk9X?=
 =?utf-8?B?cEltN2RTZWhyV2NoZnNZL2MvL0I0U1JQYXBXSVRxQjhZUURNb1ZKOEhCdWla?=
 =?utf-8?B?YVlCUWxidkNYaXZkeUdzeDFZRnVJTnNJU0dDZTYrWU1UK3RUSEI4N2lUUFIy?=
 =?utf-8?B?dkwySkJLenFzU0hkWEFsLzJCKzRMWEFMWkdHaUQwSDZKVlNTNDhoa0tJVnZo?=
 =?utf-8?B?eFRzVEE5YjBMRkc3Q2d3cXA0Y0FUM0MyUThoemR4TkVZOGxiNEVENjBCbmhW?=
 =?utf-8?B?eFl3RUV1cUtZbTltQ3g5L08zOXIzWk9uUWpZTWpNZG4rZFlvNzlMT29UUXps?=
 =?utf-8?B?QVB4TG1zN2J1dkFSbHpsbThnQ3N6Vk0zZEZ1c09qRnFuQWR2SSs1Mit4ak1I?=
 =?utf-8?B?NzNOMG9PclZxOXhHWDZJVjJ6dEh4NmR6YnRjOGxYa2lwZVkvbjVEbHJLQTRq?=
 =?utf-8?B?SzI2eHRFc0g0akZvZ3BMZWFQOWliTGpaVVprVXhpanpEYXdCQThhNjM2TmxD?=
 =?utf-8?B?UmFzUklWaHp3cFE5T1BBN3VBcDJjU1dXZUExczRzYWMxWlc0aFY4YlVNWHdE?=
 =?utf-8?B?NDlHc1Rzbkp0RUNjTXUyZTVzeHNVajArTVVvTmUrQnQwTkF6Nzc4bzJZaGRG?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d318861b-2f2b-40a1-98d4-08db2e81034f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 05:06:24.7545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qt6Q9X6Dl+F91FlONpYjX2EbHdzoE8FUYpFfeorEUnAIf2kLi33UqMyJJ6ITqQiDTUX4zm3A9hWtwQc4KbAsv2xHyswR2mKAgxnjN/aIwAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7212
X-Proofpoint-GUID: nhW76yBpYMKR3_cvY7zY3zaysH4YMEbx
X-Proofpoint-ORIG-GUID: slVMuElkFPGAZ9BUgsJUttJE7qIUlyf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=249
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270042
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 32R4lngM021212
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 05:06:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14620

Hi Sam,

On 3/26/23 10:18 PM, Sam Liddicott wrote:
> Thanks for responding to this.
>=20
> Does this method allow symlinking for local clones?

Did you mean "git clone -s/--shared"? No, it doesn't support that as the =
code=20
shows. Use "git clone --shared" would save time and disk spaces, but
it would cause problems, for example, it doesn't work with=20
BB_GENERATE_MIRROR_TARBALL since the .git/objects/info/alternates will be
invalid on other hosts.

I'm not sure whether we need fix other parts to make "--shared" work, let=
's see
whether RP has any suggestions.

>=20
> I have a large git repository checked out using the repo --mirror optio=
n, which=20
> is then cloned for each target workspace.

Maybe consider using a shared DL_DIR among the builds, e.g.:

DL_DIR =3D "/path/to/shared/downloads"

// Robert

>=20
> I'd like to avoid doing large local clones for each MACHINE workspace (=
there's a=20
> good dozen) but instead just symlink git objects as has been working pr=
eviously=20
> and according to the patch I submitted.
>=20
> Sam
>=20
> On Fri, 24 Mar 2023, 19:51 Theodore A. Roth, <troth@openavr.org=20
> <mailto:troth@openavr.org>> wrote:
>=20
>     On Fri, Mar 24, 2023 at 1:09=E2=80=AFAM Robert Yang <liezhi.yang@wi=
ndriver.com
>     <mailto:liezhi.yang@windriver.com>> wrote:
>      >
>      > The "git clone /path/to/git/objects_symlink" couldn't work after=
 the
>     following
>      > change:
>      >
>      >
>     https://github.com/git/git/commit/6f054f9fb3a501c35b55c65e547a244f1=
4c38d56
>     <https://urldefense.com/v3/__https://github.com/git/git/commit/6f05=
4f9fb3a501c35b55c65e547a244f14c38d56__;!!AjveYdw8EvQ!bAhzaY_csImWvjvDB4Fa=
1yvAmmEJ32SC4duzLyDarpR7o36SD7vwI2lra1HmH7jt_x22MPCDWbmT2knQRA$>
>      >
>      > But repo command manages the git repo as symlinks, so check whet=
her the
>     objects
>      > is an symlink to fix the problem:
>      >
>      > * Nothing is changed if git/objects is not a symlink
>      > * Use "git clone file://" when git/objects is a symlink
>      >
>      > Signed-off-by: Robert Yang <liezhi.yang@windriver.com
>     <mailto:liezhi.yang@windriver.com>>
>=20
>     Tested-by: Theodore A. Roth <troth@openavr.org <mailto:troth@openav=
r.org>>
>=20

