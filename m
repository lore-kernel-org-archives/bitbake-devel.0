Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F78E95A96
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 15:17:00 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.77])
 by mx.groups.io with SMTP id smtpd.web11.64704.1696864609854961051
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Oct 2023 08:16:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=hRP9tATO;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.22.77, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7/tzu90qLH4L5zbEybSRxi3FoUtOxVOsVEnK1sI5+Ro4oquqRZjhBI6S97x5Hl0UmVxv8avLfkn2dIAswhb18BcMkshoqrkKLmq6qCrijeVr7+D0nwxIonqDUzOfVu7BgkJXu/3b8tevGXjroXFHLh6dFn7ezXOsl7UOD0bhpZT1N/nOYLrORnCD3N5kX97g3Nvzwp6j4nPiM0Ws5h7r8FxTcqOIXBK76e0E2sHKOQBzs/m2gIqSdROUZCHLotw4FAnj0F5OmYhBP7xnTOZshgpt/xlu0zFvT6z0+G7RAfVkBmCHpFxRsnSbcwPnCxR44JejXdQI+JOuDUeXpvzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+/Rms5xb3d9Cutw01XyCv7PqOVjBZbD8+03RnTSKCo=;
 b=b3uJvENihxDOtxCPB5goPJGzz2ogS8zNWZV6bk/lgiJLNzgT3zqb/Iu0N3ZM3tW+vDhlWjsbj8I63bFh8Y+zp3eLgD9alHxSTHm/iSQUfcoGZcNVLE4IlSVKMBqR0JgeEvEIWxESfSXbpulcCD5YRDZbOsfcAAJKlw7A7SoTzGbLxYb8biQ57b9KwXPiZRGcIQC8teu483lrJqV63AH/pyA0M+hF2/DdzNM4Z9KWkFfOqXH6Kawt/ViAITGliFEF4ChZ4at4E+Cy0oc+83wqVe+d+ndhmep7sWJid8t+aKLKU7GeTHhNRi/Eevj94ynPUTCy9tP6fEHkARcF0F0wJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+/Rms5xb3d9Cutw01XyCv7PqOVjBZbD8+03RnTSKCo=;
 b=hRP9tATOZ+dusVjXL+u5P8JHmbxXfFTcDkLs/mohC8I5C2cjODZzF32f2E993Sc/qSsF/mySFtfL85DDl13qsOcRjsXUZztRUhr9Y08BW/O6vWYs2jAcXCvJcJ9sRVbQQb+tZ5taQ68ar/UEjNUyscD4ZIeL67MveWQYzdkQcO6LTBwwW9X95iRU/f7+2c1LBIwVCKLoq63bkFcS4ZAIEUX2zZpIpf0zduoQJOnqnOYZ1Wfl1rKbcfM7WXKkfLNcMFPHjkZupqaxWnhug3cJquAe25ih8XsO2uT30K8dNNA9wHbFlx4MN/E4Odp0nttkfzueEyAkVs65DyZczFEGIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB9002.eurprd04.prod.outlook.com (2603:10a6:20b:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 15:16:45 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::a05e:353b:a447:8152]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::a05e:353b:a447:8152%5]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 15:16:45 +0000
Message-ID: <bae7df5d-fbf2-48e1-b11a-dd0bf326f15c@theobroma-systems.com>
Date: Mon, 9 Oct 2023 17:16:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] Fix find_bbfiles when BBFILES contains
 directory
Content-Language: en-US
To: bhstalel@gmail.com, bitbake-devel@lists.openembedded.org
References: <20231009145918.900167-1-bhstalel@gmail.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20231009145918.900167-1-bhstalel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e5185f-52fc-4095-1ca5-08dbc8dac009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ewpk/b0yoG7RFS39tfHLXQQcIsLuCKELiBGa11y6j7VGhKT13H1vFveefGrp5g4hvPOCAju7CxrXsfka4oSYACy9Ujy9sLRAa3B1+CdbHDJNA0zN9O8lJLFjxKjRlqxRLSQOx9Jr8hpZ6E5Xp5Eu75gtmK02zq7jIG6tehsO9XHAnba8oSEwNt4pkhe56vwPAtvxn/Bc+o4hfDA1qf3KAG2eSLzUNbnuG6xPAgmoNPbZaDm5PFCU/qJXE2B+f0a305J0vi8a91kqjToPcS9zzmSJ7iTMMtNbZzaS0Txa1kIckzALD+WuIVw63Kuh7dkOEWDyLivfdqdlSt7nA8asgSFErNei1xp/EccxLd09GBQszG1Qg/Pk4KHLygvgwGIEfgz/mnirUhkgy6RzBOXaNri0sat1SAlhwJXskU7QjaoBskD3v6vnNmvGgnoDQ9mO45tV6dhL/Qe/8wSxqVyYtkfAeM6adnHGffSFuwdm0EtDy7Mf6ms0nd/vvCRU9bH65KOWi1dLJIZMDC9E10vMfUQFZFoo6i8G/pFF/Y3zD7NRdRz39N25Mru/rM6BuKXVWuvtdnT/EA8mmvT88SrCrzmbjfhxJi0oHz1wbznWxdw0zP9IcQX+ItZsOKyMen8i7RJH0cnLVMwdvOS6/2UY+Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39840400004)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(83380400001)(53546011)(2616005)(26005)(66556008)(66946007)(66476007)(316002)(8676002)(41300700001)(5660300002)(6506007)(44832011)(6486002)(6512007)(478600001)(8936002)(36756003)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bG1XMGZIODRtbzF5QVRJTUpwMkpkZCt6ek9lcUtvbnUwem05bjAwSWhDb2Nm?=
 =?utf-8?B?QTU0V1hJaC93bUoxK0lPbG9pdmh5Z21xbEoxTVYyZ1c4VERRT2NrTG5MZ0Vk?=
 =?utf-8?B?OTk2MXlrcHdqa2crZEFldTEyQUZVdVZLZi9DYkR4ZHZrNmEzRDFKZGozVEJ1?=
 =?utf-8?B?U1JKbFgxKzhWVXRDNVljcklCZVVNM0l4cnlJUEtuRDlrYjhvNHgvVWRHQWxt?=
 =?utf-8?B?Sm9BOTA2dnZ3UG8rWGc5SEFPZHVnd1p6NGpQRmo2MTJycEVuSTlpMGFvbU1G?=
 =?utf-8?B?SmRCWlF6UjY4TlJMQ1llN2VuSTJQRGxiUE9HMVV4WXlJbkhtVVZDRGl2cjVP?=
 =?utf-8?B?VElWamhZbVpSdnBia25XTjNxY25kS3k0RGVwUm1uVnFxZEhLUWp2b1AzdGZR?=
 =?utf-8?B?MkJSNkN3MnR3MGNxc3J1QStPZGIvYzRTK1pGSDNNZ2Z2MTNVYXNTeU1VMVNp?=
 =?utf-8?B?b0g2NjYyeldjSTFRNG9EMjd3cXFnQWZYQ3F1SUgyb0xtbXdUdUt4RmU2QXJq?=
 =?utf-8?B?Z3ZFOWhpb2dlMFk1VGNJdFJlS2RFa2dFakc2WmRYeitueTBNWFUwNk5VZ2RZ?=
 =?utf-8?B?ZThBQmZ6R0F0Vm9aY1ViWXBNT0c5N0N4eFBhbFYwa3B6VGhHTGNFc1hNMUZC?=
 =?utf-8?B?bXNjZU9FMmxPcGtsOFNwQUhaU1c5bXRKNDkydUJNNXJkK0E1WnNrOWJIcEhh?=
 =?utf-8?B?SFprWGllb0NtUHdhczd5OXFVWTFIUE5DNWVoUW1ySEF6OWtNcGJKb0RjR0tq?=
 =?utf-8?B?YVR3ZnU0cWUvMXpnZlphRXJBRzZ2b3hRMGsrZ044ZkVNTU55WnV4YTQxWHNw?=
 =?utf-8?B?aVM2NVpacVZuSTlUeGxXU3VjZzlEUzcvK3J0V3FnTGlpdG5tV0hpWnVaNCtP?=
 =?utf-8?B?NWxUUm5XOG4va3FNbzZQb2VRcVJoMC9UdTM3ZWFCdUFIS1BTUWtJUEhQS2xa?=
 =?utf-8?B?eU1SNktidStQUjh3QVcwOWVIa0k0VzJKQWM2NXBxSGU0bXRxYmlDSFJzdW16?=
 =?utf-8?B?dGlWS3VCUVhqdk5SUW9XTWdaVEZrS25EL2V4cDJpRjZrckZIYTFXQkJFUTVh?=
 =?utf-8?B?R1pROEQ0YXF3Ym9aRzNhSDZKeWdCVlQ0bjAycUJkeXVBL3d1NDVwU0E2cFo3?=
 =?utf-8?B?bGttYU55S1VjbnJlSzlNUWorMG12dkU5aWdrbGxCUXZjVVVhK0txK3BQSG1P?=
 =?utf-8?B?NGRRcUtiMkdra2dsVjg3UVNHN3lIekZvZCszcStKRWpidXUyYmt2MlBlVUk0?=
 =?utf-8?B?Q1FOcHFqRE96SHJta1ZEQ2RwVU5lVVVKTlYrejJPWlV6UHYwR29JWUs0elI2?=
 =?utf-8?B?UnhNL25lbXpqdkloakVOZEQ3L3B5YlZxTGJ0MDlUUDBUOFFZM01odTZuSHRw?=
 =?utf-8?B?dGF4dnhDalNVeVBZR25odldLbDN5K05PWDMxeEh1QWNQOG84dUE2ejk3SGVO?=
 =?utf-8?B?TzJJUGlMMG5nTzAzVE02M0NZeDNpL3BRVmVwb3dqeTlvVk01c2hKV0dWeWZJ?=
 =?utf-8?B?UmlUb1NPdW1Ub0x0dnBxTm9nU3NHclBFUWNkSi9zb3NhY2xnWGhMYVQ1RUZP?=
 =?utf-8?B?Si9Gb0wwNkszVVdxMDF0NnZTUXFlK1o4ZVNuRi90UTlmcDVlN3BMRHpobW1U?=
 =?utf-8?B?amlqaGhHT21mWlpMTllSNnBQRlM3TThWZFFjZUxqYUE2RkFsSndJRUs2TlVv?=
 =?utf-8?B?S0tTaW8weVA5M2pkTFRJbVp3Vmd0WFVpUmxKUkgyK0dQZkJmckhDNmk3YVVH?=
 =?utf-8?B?d05Ld1VWSVBmMWFLaTJnRXdlVVcxQjlNbVRxckVrUWYyOVNKZzJXVUV0dThh?=
 =?utf-8?B?NUlWWFdEdTZCQ1gzYjNWWUFLSVU2dkI4aXNiRldQZk9SRnMzU3oydkdSQkN4?=
 =?utf-8?B?SGtJSmg5L1oyS2FPM1VrcUx1MmJlNzltbjBFcEVIc01mR3BwQ0tHV3Rma3JH?=
 =?utf-8?B?QXhtSExCeFN1bFdPSVczODJnVXdWdW5YN0VGRmdJWWZUdm44UnZxU1dkeUtl?=
 =?utf-8?B?bFc0SHV1bFFUR3N2SXdxSVZ1ai92R0RkTC9RRnpsQ2JZRjBvYko1MEpvclBV?=
 =?utf-8?B?RkM1TFR3R3IvMWIxb3VGcVovQ3ZaN05kUzZMeUJpUCtiTUJiOS9jUDFXSlFP?=
 =?utf-8?B?Yk9nMTEwdzAvQ25sVGZEcW9rcC8yUW1JLzVoTmxkbGd4Tk1UakJqVWhEL3VR?=
 =?utf-8?Q?qayauqB1uSe0DiUq4lMWkkQ=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e5185f-52fc-4095-1ca5-08dbc8dac009
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:16:45.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siSsMym4nUh0ZKkfyGWLQagyUUJU/j//qcb4afEwFEhn6OBOLzQYNLZN3wicN76Lxmq0wek2RLUB/WLD0b/3wtPg6T7waVh7+eilsqBDu3xhgyK6NSGtNC8iabqxBM47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9002
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Oct 2023 15:17:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15195

Hi Talel,

On 10/9/23 16:59, BELHADJ SALEM Talel via lists.openembedded.org wrote:
> 
> When BBFILES in layer.conf contains a directory, this triggers find_bbfiles function
1) BBFILES docs clearly specifies:

A space-separated list of recipe files BitBake uses to build software.

So I would say that giving it a directory is incorrect. If it is 
supposed to be supported, then we need to fix the documentation.

What are you trying to do?

> which will fail on endswith that does not expect a list.
> 
> Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
> ---
>   bitbake/lib/bb/cooker.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 2adf4d297d..a354f2f0ab 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):
>               for ignored in ('SCCS', 'CVS', '.svn'):
>                   if ignored in dirs:
>                       dirs.remove(ignored)
> -            found += [os.path.join(dir, f) for f in files if (f.endswith(['.bb', '.bbappend']))]
> +            found += [os.path.join(dir, f) for f in files if (f.endswith(tuple(['.bb', '.bbappend'])))]

2) Just replace the square brackets with parenthesis instead to save an 
unnecessary array creation.

Cheers,
Quentin

