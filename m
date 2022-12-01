Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0607C4321E
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 12:10:51 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.41386.1669896644496031512
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Dec 2022 04:10:44 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=ZqUEWGE9;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=933439c92d=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1BYOT5019427
	for <bitbake-devel@lists.openembedded.org>; Thu, 1 Dec 2022 12:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=uotoZTHIUHfatxxaGz6cmm12nxANxuVpS7XMqYD9WBs=;
 b=ZqUEWGE9UMISOgXvEmVfVFc4RO7mK0YfRS/wh/UCxf2AKLaFeQPev6EbkJrQpTS4uDyL
 X2bANUQvOZueyAXShKBU7eZ7yQtrVIx84W39kKXH/+M/5gCciMDYcVbJdvG8CJevR5vc
 sZyONcpwyLEKU99E3+DD1Kec4DhYLmThJyemAwIO1A95WPUTjtdV4gfg3jluhhnHyFYy
 Tn3c2tUqVJ27VQTMF6G4dGl7opXkEQ6xGmNzkJZ+lfynHo45Rdivksukrcn9HF0cxdKW
 rSSGK+enUq0N9PBqGf0aGZ6NHyGBu/F4sW7EH8NYzxHWcCU4WzqgM7xnxpd7AozrqU75 Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3m39sbv9fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 01 Dec 2022 12:10:43 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B1CAh5a000975
	for <bitbake-devel@lists.openembedded.org>; Thu, 1 Dec 2022 12:10:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3m39sbv9fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Dec 2022 12:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb/yDwqpoPRv+CHHlJtP3r/l5i/w2wuqXlMCwfjG6zSYTjO2wadFpRZehgfKKf43oBWj+8GNRphikQQGJ2Qxn6jG6+V/V8In419OsMcCAyQpebVuve+fIpVQ2fOjQ4f4g08L/VlpfejYdlPkTi1J3CabxH9J1KHpGfnvnmR7tIqWRK2KLywdahXLuTT4T/GCYJl3CNB7wSTX1VGOsqGwf5FOA+q0yh7p6xQEog1kTrq9x12oDeTRrDFhIAgT6HS+1DVeeJ8mkRFyquDOFn9EOU/tNzgyVgpgZaETsEv/tfoHrujugia1mpib/fzzqzifIawibq1OlKIizLoPfB+q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uotoZTHIUHfatxxaGz6cmm12nxANxuVpS7XMqYD9WBs=;
 b=OCk0CHn2mXIh5ucTh8EnjI4FtcLSH6uzGTsRL+qkgH4n9X3bsBmIxfqpiu4r8pQKfrBGWPE54EmxnHJGNqYrw2InkLj8wNMOAXIDv25cKZyELoYJtBOVGw9CsJfxsr30W5MeL6K0/ATcIzbhQtHmDlsYnFeoGA/8DS7AYB4K7MetkfyUM1wfq80eUromgUsm87TXTxrhxLT700HUX7Taxxn/K1jV7wWKTM7N2G2OJNj7CgsMXfncCNZvpxQ+day6zo6XAbVJLgv7osm2k57TkcuEpTMUC9ae3tRfBIak8n00iNZhqAG6yNus1x8Rqxwa6E6SLw0/mdlNPi3NBa0COw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by SJ0PR11MB5770.namprd11.prod.outlook.com (2603:10b6:a03:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 12:10:39 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::6736:bbc7:d903:a7bf]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::6736:bbc7:d903:a7bf%7]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 12:10:39 +0000
Message-ID: <a15e22da-3175-09bf-0199-4e0c047d1469@windriver.com>
Date: Thu, 1 Dec 2022 20:10:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [bitbake-devel] [PATCH] command.py: cleanup bb.cache.parse_recipe
Content-Language: en-US
To: Martin Jansa <martin.jansa@gmail.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>,
        Chen Qi <Qi.Chen@windriver.com>
References: <20221124091045.12018-1-Qi.Chen@windriver.com>
 <089c8b5944101a3ec48844fc744d7b6fd1558931.camel@linuxfoundation.org>
 <CO6PR11MB560282F9B2FC30CCCA5803D9ED0F9@CO6PR11MB5602.namprd11.prod.outlook.com>
 <CA+chaQeFjOD-=ppAj063EVZkd3v6E7J+1JQSY134hgg0LoT10A@mail.gmail.com>
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <CA+chaQeFjOD-=ppAj063EVZkd3v6E7J+1JQSY134hgg0LoT10A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SL2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::15) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_|SJ0PR11MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 47536dc9-31ed-4a52-a48a-08dad3950f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bUs+6RaHMFZyiUEy9BqLfNgux1M1oH+wLjjU2xNmaWObnWuUPNvqefNqo0+3iVS27kOIde+uKKY6Lxk1XuoMQYWL9RDDdKDLAdBee0LcEbQwnGmfqRcoioAPppLJU8Wq8FP+z7zik1oTZk7UFh8FnZiqmVQZZmp/IC8uP/oz2II7I0dXQIW799op/1KPwZGv2Fb8m1mKhIxf1FFt6tul+OzQ9slU8VLvHQ1tmK95yxhKD0FKwp+CMMdEC7WlqfcbDXTcpO0b89CtQiSZgGlZvQwaeSt0+VbJxCpG+CTSA5qoiKWdB4OwAn0PmTgszsAdR1Sy/H9I/3jUX0dIiEGP1hQmtRNA9BhoeBiBbTHtNtE8yH/haS8Ovcq5voScx02rjOV8sUfMc+42Z1yJmsxaTzP+ZmtGeQmHiuuJ7d1G7H7H2aa03sUD6YpUi2/991Ji0lEeKCQMvA1zfRtMxtkNibq3bpD2uVJ8WFw9DEJLxC0BfmtwYxGghmk15JGxdJEVKhd1Bq+nnzUq8qkC4mZw9abvKV3+QGgCeIc0XVm4/6bwyllMe9ENREsFTkntNpb6O5jHqLhKhiE6qwOzM8mIosxCsIgc/8LPpP+lPqyoFgULIJJY5U85Qn6PH3vLkXEYa8wNnlrzmv2t5yITXUUHU1MjrDhZ4z6cb6TXpaaTCm1EW7cLJuAQTnDFBMQPXerSF8ri/mzxHyJU+R4H2nmpiHlqs1K8L/nyaoDyVQb99ZenvLjJKr6ikUxzeczjKVJn72gx/ZoPv3hV2KXOUQpXYRj7s+Hgu8sh+9m1UrVFKCBW1iIbb7T+2eK0u9AFvFgO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(346002)(366004)(396003)(376002)(451199015)(41300700001)(36756003)(66946007)(86362001)(8936002)(66556008)(66476007)(38100700002)(5660300002)(8676002)(4001150100001)(107886003)(31696002)(83380400001)(6666004)(6512007)(478600001)(26005)(6506007)(2616005)(186003)(54906003)(6486002)(316002)(966005)(110136005)(53546011)(2906002)(31686004)(4326008)(66899015)(9126006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXI4YUc1OXUzWWVzMVBiT0lKa2hCWnV4TTF4Mlp0R3huODNFWE02N0dwbG5E?=
 =?utf-8?B?MUE2c2E4ZUZGcW9PY1NXcWh5SHdFR04wbEx3ZW1oYjdEZjNjNndDSmExVGM0?=
 =?utf-8?B?RnN1c21RbUl1VEVsWklRK2RQUDZ3WWs4NnN2N3AvOURmM3pYZFVJWVJ1QUx3?=
 =?utf-8?B?U3A4aktRVFNVRG5xbWQrUHU1N2V6SXFpSDVCakZZQzdCSXJiV0dBNWRZZjJY?=
 =?utf-8?B?Nmg0a3VTT3d2akF4S2h0cWdGOGwzdFlFV3VwcnpyZ2xRTFdkaTBaRytGSy9Y?=
 =?utf-8?B?KzhPNkVyVHdHU09yRUZoTEw5cGhrd1Fwdk02V3NtWThWbzM4czNabUJhV0ta?=
 =?utf-8?B?b2NkQkU2K1BzQ3g1UUZ3Skp3dGpxdnYwelFwZ28zVkw1dzVhclQzMHVHYjZK?=
 =?utf-8?B?OFRua0Y4SHorNU9VdTI3bGdmcHliS1BrZUoyREI2WVBsMGkzSjBVRENTZVhv?=
 =?utf-8?B?T3JrQ3p0eGV6alo4ZWJJYUxNWEFYZ3UxYlhkeU5PZ2gvVGRVQWJ1L0x2WWtS?=
 =?utf-8?B?NTdaT1BpKzhwWFhHazNLWWNZck5STllIY2k0SE4wSnR5QjcyMXVJbk5oeWVS?=
 =?utf-8?B?MFN0UGt2My9PVXUvWVZvL0tZenNlRUxhR2dydWlNWlpoYzZJUUJrMy9PWUs5?=
 =?utf-8?B?NEFGcFgxSXoxUHNLQVpBRGdKV3o4Rlc1ckwweXRMcTF3QlJmbGh1RTd5dWZ1?=
 =?utf-8?B?M3V6VldrVEVlMWM4OTFnQUpLY09qZzFTZEpibDVEOTJRaDg0TXovbXlab2pY?=
 =?utf-8?B?Sm96b0l6QVVQKzdHNnZyaEJ2S1ZuRlcrZU1keVRnUUQxSVF2NXM3Y1YraTUv?=
 =?utf-8?B?WXl2ZUhPeHU3MlJxQ3NUck9ZUTIyYkV2WVRLNmFpU081U05oUjhKTjNZbUFa?=
 =?utf-8?B?c21FNUhxOVNwalNRTTkxY2dqRUxzTVh1ODF0dGhUL3ZFT0hqMGRoZkorVjhp?=
 =?utf-8?B?Z0JzZTUwK2ZBVzJpUjdyRzJNRWhtdjcxVGlFUWhQMlZnNXFCSGJXQjc3RDh1?=
 =?utf-8?B?aVRxR1IvdzdNYUJXRkhDVTdheXNsQytsLzlNeThIS2cvbGRQSGIxL0c1RFFz?=
 =?utf-8?B?V2N6TDRhcDUvbk0wZHpUa0ZnRHI4SWdVVXVLMXFxeFRYay9RL2dnZU9XV0dM?=
 =?utf-8?B?YUlYY1l1cHVPNk1GZzI5aWhlTTRKcGVoUy9RcWlJVDdWcTl1QWlPWkxuSHRC?=
 =?utf-8?B?VUFxWDNDODYrS0R4TXJINkVocGIzR2FzV21uUm1QSXlrUUk0L25KY3hFL0d4?=
 =?utf-8?B?N2RCN2VINlM0cjdmVzl0U3VBVEhndm9nMmU4QWMvRnlNNEwrRkpTWWVDMjNJ?=
 =?utf-8?B?ekZpaERRVUtqdHU0Ni9JWUE0dW5nc2t1emVzcW9KTC90d29wcHZBODRTeURm?=
 =?utf-8?B?M0tkUEdTd3BOYzhKQmJLb2FWYWhmOFBwYXhRYmExQmtiN2xVMDB0eUN6Y2cx?=
 =?utf-8?B?TW5EUTMxWXd4bnpvRzdRTGpSMHRnMjFZSk03Y291SUVMbTZ5ejV6K3I4b2Q3?=
 =?utf-8?B?VXJYTnNMODUrSXBES3NCMDdaZUJvM0Jrc3JQUWU3VWlJN1d4bDRKR1hXVXVk?=
 =?utf-8?B?SUNBeXR2VWUxNFpjcnhzd21mUVVzWkhNSDBSMERpSVZFNXE2RXU3YWFOeUtm?=
 =?utf-8?B?d2JBaGkzTnpQaW5IS1JkOTdpMVgxN21oNjdQNnEvakQ3YTBDMmdiTlpTR1o1?=
 =?utf-8?B?UXBINkFrV2ZIcHUxQ0h6b1l2T1gzbCtQaXlQNi9BMXpHMExJbGt1anNKcDcr?=
 =?utf-8?B?bUV0VXErc0c4ZEpuSTlqYWtubnVFUWdMZkwwSXFrMW5XVEFqTWJlWFNrdTFn?=
 =?utf-8?B?RUlIYkROaG42RXYyeEdXWlc5ZkV4Ukx1R1Z3RHp1aExNUWV6MWtsZTBmY01J?=
 =?utf-8?B?TGxJbkhWSXhBSlpBYStydVRCSklrenFOZlFRTHNCVnNJQm5VVThpTWtLZUNn?=
 =?utf-8?B?YXo1VFRTUmszYjd6eVJPTmtWT0RVb3ZiWnhWcTk0RGpXZElIY2RMVmNOQ1FZ?=
 =?utf-8?B?eDcrNGN6RytjYVFwcXhvNFJkZ2Y0Zmt1cWNsMFM4c05Ja1NNTjdITXlhdlhE?=
 =?utf-8?B?MWRnSXVhWTgrTVp3blpVemUxa2RoOHYwcjJyT0VHd2RIYlh6NXc0K2U1dmJr?=
 =?utf-8?B?QmV4VWdKWVRDUDU3Y3MveE1JUkt0Qi9YbHVqQ0pCY0pqRVY5Qjk1UTFINSt2?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47536dc9-31ed-4a52-a48a-08dad3950f5c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 12:10:38.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdrVuhcjr0MuX47v71+SEQy/6877hFM2kAC8Z1/1R+DLloiky0/OFleIthDY4Vc0uzc8Dgqt108wdJQ3H+GBxnTRomCbgI0FZ1bcu1emJ34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5770
X-Proofpoint-GUID: ekxML2B5fYtoT9So-iL6LrhTDtKocwER
X-Proofpoint-ORIG-GUID: FEV05HWPfm_vb71s4VjfEBe3C0D5XSfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010087
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 2B1BYOT5019427
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Dec 2022 12:10:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14127

Hi Richard and Martin,

I've setup a pure oe-core layerindex (No Wind River specific settings) lo=
cally,
it works well.

For Richard's question, where is the config_data from, it is from=20
layerindex-web/layerindex/update_layer.py:

envdata =3D tinfoil.parse_recipe_file(fn, appends=3DFalse, config_data=3D=
data)

The error will be gone if remove "config_date=3Ddata", so we can confirm =
that it=20
is from the line.

For Martin, maybe a git process had crashed so that index.lock was not cl=
eaned
up, you can try to remove the lock file (Or ask layerindex maintainer to =
do that):

$ rm -f /opt/workdir/git___git_openembedded_org_bitbake/.git/index.lock

// Robert


On 11/30/22 02:20, Martin Jansa wrote:
> On Thu, Nov 24, 2022 at 1:17 PM Chen Qi <Qi.Chen@windriver.com=20
> <mailto:Qi.Chen@windriver.com>> wrote:
>=20
>     Hi Richard,
>=20
>     I met the error on our layerindex.
>=20
>=20
> "our" is
> https://layers.openembedded.org=20
> <https://urldefense.com/v3/__https://layers.openembedded.org__;!!AjveYd=
w8EvQ!dAyNXqU5oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGByabqoJrG8NnQky1xP1KOAGSW5K=
8aoKC-Im1stueEvYcmIy7OIU$>
>=20
> or some other instance in windriver?
>=20
> I'm asking because parsing on https://layers.openembedded.org=20
> <https://urldefense.com/v3/__https://layers.openembedded.org__;!!AjveYd=
w8EvQ!dAyNXqU5oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGByabqoJrG8NnQky1xP1KOAGSW5K=
8aoKC-Im1stueEvYcmIy7OIU$> seems to be broken for a while. I've checked r=
andomly selected 3 layers and all show the same issue as "Updates" tab in=
:
> https://layers.openembedded.org/layerindex/branch/master/layer/openembe=
dded-core/ <https://urldefense.com/v3/__https://layers.openembedded.org/l=
ayerindex/branch/master/layer/openembedded-core/__;!!AjveYdw8EvQ!dAyNXqU5=
oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGByabqoJrG8NnQky1xP1KOAGSW5K8aoKC-Im1stueE=
vYcM7oxI8A$>
>=20
> ERROR: fatal: Unable to create=20
> '/opt/workdir/git___git_openembedded_org_bitbake/.git/index.lock': File=
 exists.
>=20
> Another git process seems to be running in this repository, e.g.
> an editor opened by 'git commit'. Please make sure all processes
> are terminated then try again. If it still fails, a git process
> may have crashed in this repository earlier:
> remove the file manually to continue.
> ERROR: Traceback (most recent call last):
>  =C2=A0 File "update_layer.py", line 384, in main
>  =C2=A0 =C2=A0 (tinfoil, tempdir) =3D recipeparse.init_parser(settings,=
 branch, bitbakepath,=20
> nocheckout=3Doptions.nocheckout, logger=3Dlogger)
>  =C2=A0 File "/opt/layerindex/layerindex/recipeparse.py", line 36, in i=
nit_parser
>  =C2=A0 =C2=A0 utils.checkout_repo(bitbakepath, bitbake_ref, logger=3Dl=
ogger)
>  =C2=A0 File "/opt/layerindex/layerindex/utils.py", line 282, in checko=
ut_repo
>  =C2=A0 =C2=A0 runcmd(['git', 'reset', '--hard'], repodir, logger=3Dlog=
ger)
>  =C2=A0 File "/opt/layerindex/layerindex/utils.py", line 369, in runcmd
>  =C2=A0 =C2=A0 raise e
> subprocess.CalledProcessError: Command '['git', 'reset', '--hard']' ret=
urned=20
> non-zero exit status 128.
>=20
>=20
>=20
>     Error message is as below.
>     NOTE: Starting bitbake server...
>     ERROR: Unable to read
>     /home/oelayer/layerindex/git___lxgit_wrs_com_layers_meta-arm/meta-a=
rm/recipes-bsp/trusted
>     -firmware-m/trusted-firmware-m_1.6.0.bb
>     <https://urldefense.com/v3/__http://trusted-firmware-m_1.6.0.bb__;!=
!AjveYdw8EvQ!dAyNXqU5oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGByabqoJrG8NnQky1xP1K=
OAGSW5K8aoKC-Im1stueEvYcR8tYvdQ$>: Traceback (most recent call last):
>      =C2=A0 File
>     "/home/oelayer/layerindex/git___lxgit_wrs_com_bitbake/lib/bb/comman=
d.py",
>     line 90, in runCommand
>      =C2=A0 =C2=A0 result =3D command_method(self, commandline)
>      =C2=A0 File
>     "/home/oelayer/layerindex/git___lxgit_wrs_com_bitbake/lib/bb/comman=
d.py",
>     line 567, in parseRecipeFile
>      =C2=A0 =C2=A0 envdata =3D bb.cache.parse_recipe(config_data, fn, a=
ppendfiles, mc)['']
>     AttributeError: module 'bb.cache' has no attribute 'parse_recipe'
>=20
>     Regards,
>     Qi
>=20
>     -----Original Message-----
>     From: Richard Purdie <richard.purdie@linuxfoundation.org
>     <mailto:richard.purdie@linuxfoundation.org>>
>     Sent: Thursday, November 24, 2022 8:02 PM
>     To: Chen, Qi <Qi.Chen@windriver.com <mailto:Qi.Chen@windriver.com>>=
;
>     bitbake-devel@lists.openembedded.org
>     <mailto:bitbake-devel@lists.openembedded.org>
>     Subject: Re: [bitbake-devel] [PATCH] command.py
>     <https://urldefense.com/v3/__http://command.py__;!!AjveYdw8EvQ!dAyN=
XqU5oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGByabqoJrG8NnQky1xP1KOAGSW5K8aoKC-Im1s=
tueEvYcJ_BcC5o$>: cleanup bb.cache.parse_recipe
>=20
>     On Thu, 2022-11-24 at 01:10 -0800, Chen Qi wrote:
>      > The parse_recipe has been removed from bb.cache, replace it with=
 the
>      > databuilder._parse_recipe.
>      >
>      > Signed-off-by: Chen Qi <Qi.Chen@windriver.com <mailto:Qi.Chen@wi=
ndriver.com>>
>      > ---
>      >=C2=A0 lib/bb/command.py
>     <https://urldefense.com/v3/__http://command.py__;!!AjveYdw8EvQ!dAyN=
XqU5oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGByabqoJrG8NnQky1xP1KOAGSW5K8aoKC-Im1s=
tueEvYcJ_BcC5o$> | 2 +-
>      >=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>      >
>      > diff --git a/lib/bb/command.py
>     <https://urldefense.com/v3/__http://command.py__;!!AjveYdw8EvQ!dAyN=
XqU5oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGByabqoJrG8NnQky1xP1KOAGSW5K8aoKC-Im1s=
tueEvYcJ_BcC5o$> b/lib/bb/command.py <https://urldefense.com/v3/__http://=
command.py__;!!AjveYdw8EvQ!dAyNXqU5oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGByabqo=
JrG8NnQky1xP1KOAGSW5K8aoKC-Im1stueEvYcJ_BcC5o$> index
>      > fa9fd054c..c9571f63d 100644
>      > --- a/lib/bb/command.py
>     <https://urldefense.com/v3/__http://command.py__;!!AjveYdw8EvQ!dAyN=
XqU5oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGByabqoJrG8NnQky1xP1KOAGSW5K8aoKC-Im1s=
tueEvYcJ_BcC5o$>
>      > +++ b/lib/bb/command.py
>     <https://urldefense.com/v3/__http://command.py__;!!AjveYdw8EvQ!dAyN=
XqU5oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGByabqoJrG8NnQky1xP1KOAGSW5K8aoKC-Im1s=
tueEvYcJ_BcC5o$>
>      > @@ -564,7 +564,7 @@ class CommandsSync:
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if config_data:
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # We have to use=
 a different function here if we're passing
>     in a datastore
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # NOTE: we took =
a copy above, so we don't do it here again
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 envdata =3D bb.cache.=
parse_recipe(config_data, fn,
>     appendfiles, mc)['']
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 envdata =3D
>      > + command.cooker.databuilder._parse_recipe(config_data, fn,
>      > + appendfiles, mc)['']
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Use the standa=
rd path
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 envdata =3D comm=
and.cooker.databuilder.parseRecipe(fn,
>      > appendfiles)
>=20
>     How did you run into that? I'm a bit worried we're missing some tes=
t
>     coverage here?
>=20
>     Cheers,
>=20
>     Richard
>=20
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>     Links: You receive all messages sent to this group.
>     View/Reply Online (#14107):
>     https://lists.openembedded.org/g/bitbake-devel/message/14107
>     <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitba=
ke-devel/message/14107__;!!AjveYdw8EvQ!dAyNXqU5oP_MdnjNgg7iOIT0fNgYfCx6IJ=
x_5jvGByabqoJrG8NnQky1xP1KOAGSW5K8aoKC-Im1stueEvYcFi8osuw$>
>     Mute This Topic: https://lists.openembedded.org/mt/95234638/3617156
>     <https://urldefense.com/v3/__https://lists.openembedded.org/mt/9523=
4638/3617156__;!!AjveYdw8EvQ!dAyNXqU5oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGByab=
qoJrG8NnQky1xP1KOAGSW5K8aoKC-Im1stueEvYcb2VAskM$>
>     Group Owner: bitbake-devel+owner@lists.openembedded.org
>     <mailto:bitbake-devel%2Bowner@lists.openembedded.org>
>     Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub
>     <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitba=
ke-devel/unsub__;!!AjveYdw8EvQ!dAyNXqU5oP_MdnjNgg7iOIT0fNgYfCx6IJx_5jvGBy=
abqoJrG8NnQky1xP1KOAGSW5K8aoKC-Im1stueEvYc339AjuA$> [Martin.Jansa@gmail.c=
om <mailto:Martin.Jansa@gmail.com>]
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

