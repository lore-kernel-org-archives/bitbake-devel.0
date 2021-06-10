Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web08.4291.1623288674690060577
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Jun 2021 18:31:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=Aenbh8Mh;
 spf=pass (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1795f13b86=mingli.yu@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15A1TnsB003210
	for <bitbake-devel@lists.openembedded.org>; Thu, 10 Jun 2021 01:31:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com with ESMTP id 3934d9r5ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 10 Jun 2021 01:31:08 +0000
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15A1V7Ar007824
	for <bitbake-devel@lists.openembedded.org>; Thu, 10 Jun 2021 01:31:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0064b401.pphosted.com with ESMTP id 3934d9r5vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jun 2021 01:31:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL81PdBjZjwtqdueILcroELA84EWenXiQzs76mK1eQBG9KxD41Xw8HAPEuwt55zJ11A4QGYLYfHDYGBizgZqeIhS91Lp2uNWJF56HqVNErCXlYWz7blIEGC179YSwE1uJn/gNZhMqqF9xg65drD1qJD+heoomWqqUKjOpz0LAAqpzG/kaes0Ru2OCvBHdStKPSg2KDeS8YvzZ4GMu8ciUjxtbpVhIvJz3wZElxiFSB5GLGzc06imRhiDDmphbh11DadEc0XmvX8YygZeMtQ1Yl/SAYlaMUKEyHdb6pU76y9vxEN7bTj740DaSI3pEt3CKSQafsI+kh8KXAPo6yMpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkC/rIb2PlLsd5vK4XPsxDourchB6fr1iKHCOif07bo=;
 b=GFeD8BKzSPjSo/7f6bUO4VIQeHJ5Awcuc70FxTIFL/IKBXktRCNtI7QziJb71AFVifVzinPFqXRI297ArSYAXf47GkK9GWrrmI0kbWaIo/DHP59wkz7Fa5eGzlS1BDTcf0yv4Y7JnjOFEg03esCofQSOPnRsKwD0+UZGe2XePeTL08QW6AcLTa0vncPyNV/FLpxQO1SWs32mqBDaD1wtRmPfXctfzmSB+GHWVuPu7R7KpUGBqriqOkU/G1cdebUHMkMOzlfL2raHen3mIBtvW9I25P/rDiHA0XUfCDICr08Kr1FnHpDJc0ZB+OHezRhuQdzd+blV2EQzTWLWPHCQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkC/rIb2PlLsd5vK4XPsxDourchB6fr1iKHCOif07bo=;
 b=Aenbh8MhFjLpgMucXl3o+3lT7RY7/FGKKI3LrA7twf7rgC0+bVnOKRqosAg94Cj3dtDWDSIJ+N3LJeWLT26Q6+ofd4bv0BfNpn75pmI4AbgtsosBCnT7VJ+K3YzPCWaXO8iL+tRx5Dcpcr2Hkk9Udx8dAYAYIBkX6/Z3fbl8pIM=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by CO1PR11MB5171.namprd11.prod.outlook.com (2603:10b6:303:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 01:31:04 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::ed6b:a25f:3a16:3127]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::ed6b:a25f:3a16:3127%7]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 01:31:04 +0000
Subject: Re: [bitbake-devel] [PATCH v2] fetch2: make sure the uri added as expected
From: "Yu, Mingli" <mingli.yu@windriver.com>
To: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
References: <16806B6C2D8F7DAB.5504@lists.openembedded.org>
 <1682DA98929F43DA.30286@lists.openembedded.org>
Message-ID: <34646eb9-ea8e-572e-a017-73de6935d52d@windriver.com>
Date: Thu, 10 Jun 2021 09:37:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1682DA98929F43DA.30286@lists.openembedded.org>
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.140] (60.247.85.82) by HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Thu, 10 Jun 2021 01:31:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8ab395f-6df6-4c5e-fa9d-08d92baf6993
X-MS-TrafficTypeDiagnostic: CO1PR11MB5171:
X-Microsoft-Antispam-PRVS: 
	<CO1PR11MB5171EB4FFDA792F6646571A0F1359@CO1PR11MB5171.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NhnqJfIEB1Tpyn+o9CwyWa4zm75Mde0Ro3TqbXVsJhlpnn+zNsBKr068vYx2AWcMBgi5ZIoQbfBNRK83q528ywK6spx8LJ7kb7HUw1Z8/j4i0hMJNpfTmChib5pSuKed2YfmvtlAWOlZCIqaBr+K805miITVF8EWTS1KNUaJJJMzdl+GJxA+11wBxeX5v6I4y3pczP4eWX7LTDE7SnqUCxiB+/B8r0idDhsvlGj+6dmtS7wFb0d2dtwQkQx+n+tBUDVNrbY8kY9+2pfwG1igd/PMs5KJrLZ6Ih/vu9MozoXeFxXHo5jDJKcsnLRQi/4UnD2V7mdD+znFa/K8zxaH9svXq8nUNi+DQ6JNLg0p5dIMlrxQbhuxexxPLSLfDBLWRKWD8A7DPCF4wQRxYQCMPoIwvrg/UVSWNfxlAHUpVd/+nXoXj6aiJzrDfiE519zs0NuOW+hmvJfgwsHb++O1V/uljwKk1dWFY/+xZUKBRPZTlhdXENTR0jiSmSg0V4mgWVXuE5gK78EQ5r8Jhz8WQrNeLBorKn1DFzRLWHF5DtaRJclMowk9xis5DmWUyagpS2yo4r0W8BKrcgZ28glFUf/cA7d+ZrSdiGXvmVhBR6sW9GhOh6tC7OQr5Pvh1axmq97DsICpSChnwgwXwyP2E6gB82yWhxfZ7Fn5+yBdYslzL3McsQdSPQfOn+cV8SFZZOQXmUcWArI1hs+ZGP541iq5uEWKQJ01ce9J9JW6Qs95HP+kfIGyOJJU/3DK6V5sYg3Kzkhd2n5AZIOJC7qNhhfzgk7MajV6jKTJ8MdD2sAnZQZTBx4S45o+p/y9oxE6/VepAbJ9Lma4L2tjXDI34GeT3BvzKg138QY1mnG+dQ992EHADKfUgGhYmrUWvb2071chD/3Yh0qhu+H8F9oNwx1rpaSsg7bOktRL1y201L4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(346002)(136003)(396003)(366004)(478600001)(2616005)(6666004)(86362001)(52116002)(5660300002)(66946007)(83380400001)(31686004)(186003)(8936002)(16526019)(38100700002)(956004)(66476007)(6486002)(36756003)(6706004)(66556008)(2906002)(38350700002)(26005)(53546011)(31696002)(8676002)(966005)(316002)(16576012)(78286007)(43740500002)(45980500001)(4084875004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aDEyQ3FmekVqTTFITEp4UWlzbllGQ2IyZFVDNmxOMmxXY1hnL0RKYVBkUDZz?=
 =?utf-8?B?eU1PUy9WUHdNOFN0V2I0MGdTSXJQeDBjOUpwMzNLTDlZalVOWGRJTExIOXAz?=
 =?utf-8?B?Yko4UkRwZXk1UWZBNkVKdXlnUlpZSUdUeUVJVVFnZVBmRUpGaWR3Um1sQXk0?=
 =?utf-8?B?NSs4aGZKMjI1ajdzclRQL1Z2WXhpaUgvc1ovVDdrclZPWFBWSzh0NUEwQk41?=
 =?utf-8?B?eFZTUGdEazNQM2Q5M01yVGYrb2FGM2lMMUVVV01oTk1CYmRlVDJnbWhGeWE2?=
 =?utf-8?B?QTgrWk1yd053R1hyTk01eml2RVZxQzR2Y0lzYjJnQWhPUkQrQ1ZGRE9tVnBZ?=
 =?utf-8?B?Rk0wUjhOejVqc3B6UENZay82ZWhkQ2RZV3FsN082UG43WlhrWlQ5c2x6cU5G?=
 =?utf-8?B?Wk1MNHFpTFBXYXNzR1dQTzFGZEQ4ZVVSalQyU0RaZFJVOGxBV05XMTU2aDUw?=
 =?utf-8?B?c20ydy9IblB6R0U0ZUZ4VkJQSFBEczBSMFRhZGREbHRmOEplekFFSWlOR1NM?=
 =?utf-8?B?WmRrZEE5YVRlUFRJWE1BdythZVgyTEJPK2xPaWJmWnhtRm85OWkzV0pSL1lr?=
 =?utf-8?B?M2xJWUI5Ni9seXF1d3phcEdiQlRDM3JSVGhsRFljMFZHUzkvdmk3eFdnd0w5?=
 =?utf-8?B?b2VxaHdFbFBmU1I0WENiMUl5NWx6Tm5tckE5RitOREg2RW5wKzJzYXlOUTZO?=
 =?utf-8?B?UHdON1NROVRxb2xNY09GSGFQbUtsN2VndS9QTFpabUQ3SjkwMTFDUlhQbVNR?=
 =?utf-8?B?UWt6Z0UwVHJXWHJ4SUhRVGJYeFkxZi9YOFV5cU9jR3hld3JQYUVzTjhqUlMr?=
 =?utf-8?B?ZE55RTVkZHVaUjdocjBKOGdTSm5HaDVMVHdGaXBBMFI3ckNyd3B3eUZOc1Ji?=
 =?utf-8?B?TEJWWmtFVHZpbWhEdFFVNmVLbUdYVkQ2UXVQcStINEZ6bmVkWFpoL2FXekNP?=
 =?utf-8?B?NTUwT3BzaEJDYk5ndzB0TEVqa25qeHJ4RmdXNnhjQlpFS05BM2FJYTZkeDJ1?=
 =?utf-8?B?dXNKUWN3QkNxVS9LMDQwa3Z1U1RSdG1FbUhsdnpNK3daUGRvQkFWR3VKcVQy?=
 =?utf-8?B?a1hsQmNldU1LRmFldHBPN3VEeEpIMXRVcE83YTlDOGo4cXE2UVQzODZEZFJ6?=
 =?utf-8?B?b1VMYTBKeFZCY0xPeWVWc3R2WTcxMkxoU3ZPOXg1NktFOG81SkZUTUVORGJu?=
 =?utf-8?B?SjR4Njl2R21DTm9OeDByTHFidWRwcm5GL0R6STZpeEZRSkd2UHpheUNwVHky?=
 =?utf-8?B?VmlHSThmRlEyRFpJclhZOU1BelNkWSt6eDcxY1NETHdvalRVYitGVDg0bnY3?=
 =?utf-8?B?Vm41Q2RreHdkMjQ2Q1RpdW1wN1hLTGZwcFpOazkydVhaV2dndGswOXd0U1lP?=
 =?utf-8?B?czA2MmhTSENZaXBIekU3QnYzSWNaVlRUdGdNODY1VEVsaFdzQ3VrbXNadlVZ?=
 =?utf-8?B?Z0QyUG1zamJYZlpueFhyVDNYQU1SZEEwbGlvRlUyYUpoZVBIc0xVZXJ6SDlh?=
 =?utf-8?B?YUxtcEZtUkg3dFlsSk5VTXdDZkRyekplaWFFUUJwdjgwbGp3cktPVFovLzIr?=
 =?utf-8?B?eG5vdXprL2dLMlpnRkRyemd3eGlDT0lITTFZamRSem5RdVVvVW1ueFFpVHZQ?=
 =?utf-8?B?dXU5cmRNNThWK0Z0NjA4bFI3RUFZc3BXc3RVMUxGOEIzMEJuNk9mY29kcTNj?=
 =?utf-8?B?T1M4Rk5ETWNvYUQ4S1NlSXVKNml6ZDM1aXZEU3VFR2Q3UXJZajVkeTZHUkFp?=
 =?utf-8?Q?N315ry844VyYrJPL2Ouai90OlTldDEUIB5TMLfx?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ab395f-6df6-4c5e-fa9d-08d92baf6993
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 01:31:04.2542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jbo8ipmyaoOcbrv4jB8lIBAbRWfc3FkOnJtTFkdOtDDRoWD4kIWIKAm2pC9HxwJwI8JFn+78QOPSjHz+L7LjMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5171
X-Proofpoint-GUID: B1CZWuKzn9tz1z1MtlJwdWl_ZtVctzuT
X-Proofpoint-ORIG-GUID: u2Ro9Cm4zv2O6PqiIoOisQ-JFnqbxDVl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_14:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100007
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Ping.

Thanks,

On 5/27/21 3:04 PM, Yu, Mingli wrote:
> From: Mingli Yu <mingli.yu@windriver.com>
> 
> When call uri_replace to get the new uris, we should guarantee the
> new uri is added when the replace uri begins with file if the find
> uri begin with wildcard which mapped as below.
> PREMIRRORS_append = " \
>       .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
> "      |         |
>         |         |
>         |         |
>         find      replace
> 
> Before the patch:
> the original uri
> gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https
> 
> PREMIRRORS_append = " \
>       .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
> "
> The new uri is git://somewhere.org/somedir/github.com.tianocore.edk2.git/git2_github.com.tianocore.edk2.git.tar.gz;protocol=http
> 
> After the patch:
> the original uri
> gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https
> 
> PREMIRRORS_append = " \
>       .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
> "
> The new uri is None as the find begins with wildcard but the replace
> doesn't begin with file.
> 
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>   lib/bb/fetch2/__init__.py | 2 ++
>   lib/bb/tests/fetch.py     | 8 +++++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index cf0201c4..6701654b 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -430,6 +430,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>       uri_replace_decoded = list(decodeurl(uri_replace))
>       logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
>       result_decoded = ['', '', '', '', '', {}]
> +    if uri_find_decoded[0] == '.*' and uri_replace_decoded[0] != 'file':
> +        uri_find_decoded[0] = uri_replace_decoded[0]
>       for loc, i in enumerate(uri_find_decoded):
>           result_decoded[loc] = uri_decoded[loc]
>           regexp = i
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 9291ce4a..85a14301 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -406,6 +406,8 @@ class MirrorUriTest(FetcherTest):
>               : "git://somewhere.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
>           ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890", "git://someserver.org/bitbake", "git://git.openembedded.org/bitbake")
>               : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890",
> +        ("gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https", ".*://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http")
> +            : None,
>           ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache")
>               : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
>           ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache/")
> @@ -447,7 +449,11 @@ class MirrorUriTest(FetcherTest):
>               ud.setup_localpath(self.d)
>               mirrors = bb.fetch2.mirror_from_string("%s %s" % (k[1], k[2]))
>               newuris, uds = bb.fetch2.build_mirroruris(ud, mirrors, self.d)
> -            self.assertEqual([v], newuris)
> +            if not v:
> +                 self.assertEqual([v], newuris)
> +            else:
> +                 self.assertEqual([], newuris)
> +
>   
>       def test_urilist1(self):
>           fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
> 
> 
> 
> 
> 
