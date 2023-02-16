Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD2FC636CC
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 10:27:39 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.63])
 by mx.groups.io with SMTP id smtpd.web10.6918.1676543249316616324
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Feb 2023 02:27:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=fvc3RJaw;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.105.63, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIizDZY5Tjrm7w1YB8t+vOr+Syizds+8dHfrOVkAeByxMdgP7N3LW1odFVRc/He3iYlr3xHmnMWPDhRLJ861ox45KtVNQpWZ/iNIThDTtGFL2xPhYA0HyVEuEQPq4oOjAfe4Vp3Q3By9aIpVZJy58qQ4jRrtfWcEyDvuXNKkbJIL4RcljLRPzYK8kbceX+DhSBPhhcdnNYSQ1JtQYgVvvYtWA5F8E0u8KEJd78/Z1+ArdOZyZTZfuX38rF6oYTOo+fiymoT/YdXiEm3lAxUm1l9NC0Jn9wxYWvHaneEDKUic2PCXNOq7qpsBEiG0m7n4Kz/JAwpEcc5DmG7gixPqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBjmFlrG2YJrSqKyq2UZ8bn+fYgatRErYpZ/j+zCDGg=;
 b=VvkxtgEx0dUabmctZ/K1M2KKZUrjAvgZNLAjU56kkNB8kUHmvfDnvu9+KzF/EgIYjQStZ3rpqd0Ll0iBdszRZI4+PeNpW6gcB2jF18OlDrSLJUyJ5QkzlsEIFBKYmnPFNsT2GPaeFSg8CNaiIe4ZOYaYVDZNTE5hsxnc/MP7guT/Yze5FjoGKzkMadDBkEDioZuvorEzpbg8TThHWpJhWrZiNJSlhn9MlaYwDU6Oae1QWtEp90RzfoAcFmzY8Cx/Ki9mT86gSIjJxuM3nP4Xycs+oF6UNfXXWxAf82G8MclkJGSPBqDgarLKetWf+My0RYt70dOAyi3R4R18z5VWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBjmFlrG2YJrSqKyq2UZ8bn+fYgatRErYpZ/j+zCDGg=;
 b=fvc3RJaw+VlvfVQW6OrOpX8xkz//nZnzP4+JT+VC3oxYLUq1nUAPQNKzwui0IhkTFundv1Xb0ph/F/8PQdHFpsy2jXyV7aEDV5SnE/7mzndx3dBOqEarrjqbNO19mFskCXP81MWTsgMOeZvONdOca0+LKoROqZe1OHxGVHLcjDMQGh0CPGfssg1mIWG7ESbXa1VrMkaeAKRywBVe9AhN1nN373Tn6SDShcmB3pEXfb4Nbf+a1qUiq8tnK/1otzWTrxn+czlfI0S4qCYRVAay0UyEZ8mGmC24MM2Hi+0adPwgu89vEi3LUho59QoyhTM1UYmJ+jYPSHrHCbesNEyZGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB7526.eurprd04.prod.outlook.com (2603:10a6:20b:299::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 10:27:26 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd%7]) with mapi id 15.20.6111.012; Thu, 16 Feb 2023
 10:27:26 +0000
Message-ID: <29626c21-7470-5e00-e7a6-79c2664d25b2@theobroma-systems.com>
Date: Thu, 16 Feb 2023 11:27:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [bitbake-devel] kirkstone DEPEND problem
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <50f86c1869166da73d083d3c2e86f112faa978b9.camel@infinera.com>
 <0c4d7472e556e555ef57032d7af7a9377c05fbc7.camel@infinera.com>
 <913e646320fa02fd174566d8bfc5ca04cae269a4.camel@infinera.com>
 <e952433b38bd2cbde4efaffd0e2c1699ecfdbe8c.camel@linuxfoundation.org>
 <aeeff77922efed8c645fcebb1b91732ba31f1be7.camel@infinera.com>
 <84d237fb56c5db3f7fa8ac433802ec301f78f947.camel@linuxfoundation.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <84d237fb56c5db3f7fa8ac433802ec301f78f947.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 3814a91d-b1e0-4c8b-c844-08db1008661f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mQ0F1n9uAfuDbRAHsiNiqxg5jj5MbDwrW7oGYehzW+cmE4nKF2uizETIlSnnywigW4ByOWLsMwCcML2N2bVmqGp2gibvgUVCxFHlmIn6wdvRBnJ/y73uB8o7HGcst+3WfXh6ooKducFSBzcVHAEcB61Wn+dE2Dvet4e+vH+nlXMWUndiSNJvD1tCxcxrsj4FcyKXuBIutmidktyeObtg8dWUQdt5SNg2aCsStdlAgNsvkFNF/jKJbOIj31h5WU28bSvYu1wo+fFQVFYJnfsUMkUeR6rArj2OINetOUAkbBQ01ZKTpgBBJvB9qP01SIkoGusutx4zUJLuz0GBaffhUmls/+66VtG8Q+McL7dsfSn6quLADXHm1FTO4S6vNbSPoXl1+tDiXxArOpfAWZV8f4R1N93AjQSPYn+JKzZpiWTrqBzT+W+FKNEMrKAmlKSZuRoAHqIhS7jMizJLPnajq1BBkMQIT2m6pkv2VrEPI3WjRjiQ3WNKaLBxD6Xk/+S9WWyu+rBMcF941oy1mjBw6R0y50aRHzjheQJwaumJ1NFlJr65P7o/hAN70U1Xy4S30EWnyTD04XAGQQjHQ/qZA9FCG9nA92WbTwmnNkpzoLyFGi5zSyCtw8QBV83H+/DheoWRd0wm5JsjBDLmp0PpjJ5mTHpJzKv1etKCw5gl2WkCAgNjr+4oq56uJnO4gT/2Bcv41ezZuF4br8YXZk/FO75tq1p0uGGe5MPxApk8n5Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39850400004)(396003)(136003)(376002)(451199018)(44832011)(31686004)(6486002)(83380400001)(38100700002)(36756003)(966005)(478600001)(2906002)(86362001)(31696002)(2616005)(26005)(186003)(6506007)(6512007)(66476007)(66556008)(66946007)(316002)(41300700001)(53546011)(110136005)(8676002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkN5dGFpcjVhVVhCTWFJc2FzbFlDRkRxbFl4eHU5a0x3NDVtdHNvQm14YW9m?=
 =?utf-8?B?bGhxdTVuUGFyUGpELzBnem5vbVp1cmVOQUtyT3QyQS83c1I3UUZ5MzVhT2Rj?=
 =?utf-8?B?YXFFTzhkYkNQMWdxUHE1Y0xNNktCWmFYOTl6OFRWS0hhcm1zMU9jdHpwUVhY?=
 =?utf-8?B?YUV4U2pIdDJ5c21vcTkyTURvemo2R29SY0ZwSGMvOGEzQjh4ZUlTd0N3L1l2?=
 =?utf-8?B?MFkrRFF6b2d2c2tCMVNPMWQwQ3h4Rm93SHR2NzF0UC9pWUdmRllWZWloSkk4?=
 =?utf-8?B?bGFGcklEMVk3NjFvelRCNG4xYTQyWG85V1FuOE8zYnRFbkxPZ09ObXNxd005?=
 =?utf-8?B?NmdSekljblVpblBVYkVrUTlncWwvK0htZUh6MnVRUUtBckprWFNBajlINWVL?=
 =?utf-8?B?OVJ1T3N0djVPNVpDMG9DVnZPTTNiTWx3U2dQa1NYbjZQY0Fuc2UvKzBWYWth?=
 =?utf-8?B?MWhRaC9pM2NmNTFlL0NQU1lsZThBWjUwRW44SHZaOGFWQUVQRjZmbnF4STNu?=
 =?utf-8?B?NlNSYlUvM1lEd0xIK1FOWnl2VHpLaUdnNGhPa2RCRTFsMVExQnNpRHFzZGEx?=
 =?utf-8?B?NVc3MnFxazJuRGpGTkNBcXVieURJSDluU0RPOEpDUGtWeWZrbG9VeWVubmMx?=
 =?utf-8?B?eHJ5SGhsR2pKQWx3K2pTeU1uRjMvVzN4MmlHU3l0allTRXlRa3phOVpKTjls?=
 =?utf-8?B?Z2NNNHh0eTcvQ25RRXQrMzU5VWp0TnZ1aFBYQ0Y4ZzZoV3g4RmhnbzhYOXJo?=
 =?utf-8?B?UnBVR29tL1FRYmREeWRmSXpaOUF6anYvUGpFd3JORUdoV0lKTU9aQWlQNWtT?=
 =?utf-8?B?V0hiSFdCcWovdTJKTmJ2UGFKak81QkdPeDZmaXd0M1J6c2lHakxBWlpmUmpx?=
 =?utf-8?B?RnVLTktxMVhOdTBSS3lldzUxS3YrYU5YRmZnaks4Y1RmNFFzcS92UlNaOFhN?=
 =?utf-8?B?SUVRNFFNVmxvanFlR0gzcGNYV0FOSlRRMExFSHJxeHhEWC8yVVl1ZDk2bnA2?=
 =?utf-8?B?RFFxQ1RYU2xNQ1FkdDZkbExiaFVWM2c1MW05RW8rNDhCcTl2TzU3aUtRbzlp?=
 =?utf-8?B?L1Z2M1d4WGR3WTNldGpmVHAwNDl3cGRmZ2drTXNYVUZzWkRJN0k5czFZQVE2?=
 =?utf-8?B?NzVZbVJ4WDVlQTV2Nlh6dUo5UWpndy9Lb3QxdDZ2VUFxTk56NGJzZzV0VHB1?=
 =?utf-8?B?eUZ5ekJaRkRoUGw1NHpYWUdWNmxIeksxZDZycnZpbGV5cmNtWEV2TDFLdUtE?=
 =?utf-8?B?ZWV4bDV0WlJidmtoTjRINW9VTVg0SmJDK0ZRYnVaTUttUldmQWNGMEpBMzM4?=
 =?utf-8?B?WTBUU2Yzd1ROb28xbktDZ21EbnBnaHBYMW4vT2t3RmJKNTRNSEVmRkZsbm1O?=
 =?utf-8?B?NU1ES3BTSm56cWpMVm9oU0FMMENQYkpyTUdROE8rMUJkZmk5QmVWVFYxNVhB?=
 =?utf-8?B?dE1mVUM4Y3NzQkhBenNOVTVVTUx2eHhmamQxZkVQTDd4elNCaUpVbWhpYW45?=
 =?utf-8?B?aUhWL1R2ZEw3cktGM1plelllMlNwWE1hdDVJamt6eFBhVENSbXRYWUZrM3BJ?=
 =?utf-8?B?K05uQWtyUDg3eE15WHdnMzRPT3ZYT1Vickt3S2gzaWxGaGNPNHh3ckFjaW9v?=
 =?utf-8?B?ai96SzNYdTJUeDZjMWx6dWlvalBuSjUrWUI2Zlg5MlN3NHJ1MVc3TnlnL3p4?=
 =?utf-8?B?VUloczFVMzg0OEh4TUlNd3RQbEk3OHpPVjU1NzJsN0Nab2hhNmZnK0VNb1hX?=
 =?utf-8?B?VERlVHVrR3BjdEFFazJFQjV5dis0S1ZRTk5tYXdOWDd0NDZienhWeDNyb3pI?=
 =?utf-8?B?cUlsYmE5c1ZUaXFSYkhSYVo1allSaSs5MjAzSGhZUWU2djcvOHRpalVRUHpS?=
 =?utf-8?B?V0d3YkpDaERJcWFwSjFFQkttWTYrd1lnV1ZrS3FkeExsRG1pUDZuR2pQb002?=
 =?utf-8?B?RjFlSzlLYXRVYW5Rc0xxeEk5eE1pUFBKSWdsa3YxVGs5UGJmdTNURUx6NGNV?=
 =?utf-8?B?SFJ2ZXB3UWxYUFpLNmJKMUYxRjI1VCtZYTczTk11MEF5MFRMcFVLUjRRRnBE?=
 =?utf-8?B?K3hEM1Q3WWw1ekNJRExkeDFnL0E1ditrbVZwaGhFdzAwdDV2Y0xlVi9PcEV2?=
 =?utf-8?B?d0ZrN05zS205TXpOMGNZejQvUUpSSUdLdk4xNFNBWExUVllmcmlFc2FPWUU0?=
 =?utf-8?Q?ZioVssmXaSZqxSGrDm7/M8c=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3814a91d-b1e0-4c8b-c844-08db1008661f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 10:27:26.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgtCmttKXwICDFp0tJc+aV8tGcKqmlZ5gr/3aonYgqMM+ocyUHguVJIcD/iGh9xxyeKfN/2uTWrjRQcSyeQ7ahQar1T+qOZri6JyuleLJJaXZYBiv6JEfnmCLZPH8F49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7526
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Feb 2023 10:27:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14445

Hi all,

On 2/15/23 11:41, Richard Purdie wrote:
> On Wed, 2023-02-15 at 10:38 +0000, Joakim Tjernlund wrote:
>> On Wed, 2023-02-15 at 10:02 +0000, Richard Purdie wrote:
>>> On Tue, 2023-02-14 at 14:22 +0000, Joakim Tjernlund wrote:
>>>> On Tue, 2023-02-14 at 15:06 +0100, Joakim Tjernlund wrote:
>>>>> in swupdate.inc there is
>>>>>      depends = d.getVar('DEPENDS', False)
>>>>>      pn = d.getVar('PN')
>>>>>      rdepends = d.getVar("RDEPENDS:%s" % pn) or ""
>>>>>
>>>>>      if 'CONFIG_REMOTE_HANDLER=y\n' in features:
>>>>>          depends += ' zeromq'
>>>>>
>>>>>      if 'CONFIG_SSL_IMPL_OPENSSL=y\n' in features:
>>>>>          depends += ' openssl'
>>>>>      elif 'CONFIG_SSL_IMPL_MBEDTLS=y\n' in features:
>>>>>          depends += ' mbedtls'
>>>>>      elif 'CONFIG_SSL_IMPL_WOLFSSL=y\n' in features:
>>>>>          depends += ' wolfssl'
>>>>>
>>>>>      if 'CONFIG_JSON=y\n' in features:
>>>>>          depends += ' json-c'
>>>>> ....
>>>>>      d.setVar('DEPENDS', depends)
>>>>>      d.setVar("RDEPENDS:%s" % pn, + rdepends)
>>>>>
>>>>> This fails to pick up dep in depends variable, but if I change '' to "" like so
>>>>>     depends += " mbedtls"
>>>>> then swupdate builds.
>>>>>
>>>>> This worked in dunfell so perhaps a bug i kirkstone?
>>>>>
>>>>>    Jocke
>>>>>
>>>>
>>>> Correction, bitbake swupdate builds but bitbake lib32-swupdate does not.
>>>> To make lib32-swupdate build I have to add deps directly to DEPENDS variable:
>>>> -DEPENDS += "libconfig zlib"
>>>> +DEPENDS += "libconfig zlib lua mtd-utils mbedtls"
>>>
>>> The multilib code changed between dunfell and kirkstone. I haven't gone
>>> into the details of how swupdate.inc is calling the code above but I
>>> can believe the multilib improvements and fixes made for kirkstone did
>>> change the behaviour.
>>
>> Something else that may have changed (we just found out) is python venv does
>> not install the "pip" binary(symlink) into the venv/bin dir. Is there some change
>> in kirkstone here ?
> 
> That really isn't a bitbake question. I'd suggest looking at the recipe
> in question to find out the history, I have no idea.
> 

Wondering if this isn't a case of a missing ${MLPREFIX}?

c.f. 
https://docs.yoctoproject.org/dev-manual/common-tasks.html#preparing-to-use-multilib 
and specifically:
"""
If you are extending any manual code in the recipe, you can use the 
${MLPREFIX} variable to ensure those names are extended correctly.
"""

Cheers,
Quentin

