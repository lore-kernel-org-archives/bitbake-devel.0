Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFBAC433F5
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 10:39:57 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.71])
 by mx.groups.io with SMTP id smtpd.web09.26632.1643279994898795473
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jan 2022 02:39:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=iPz89LVQ;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.71,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTG4K3Ur3NiYVFmlolyjoUM+kf6PKJg+cIETUgOuDmnx5OFCPwLBlwapm9xT/tby3518ZHgjG7zlN/gJXllx9Qvs0IMFRojZm/ZoQaKvsrTyFUQn4V4p1a99esH6Ix9C/ePBefkM/ZVkDJ2WHtGO+VFBKqf21ZIlJ2sbMPVO8RCsIEHsC9CWNnwMVo3Njuouhybtx8oGSPh3E8h6Q/Inlp7k7OCDkjTVctIGn7/D6XlfWc57iD3S1SvVdFS718tuWfD9S/Nwdj60zKb11JkElpmQZVTxBrqPzgZNSaHdtlf7aTPgP7UhcZLdHNL4mfiVbvo9rd+7qFaTT2R+szelCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvnJor59gigz0YSIX7DxtZQ5/y3eYxUm78JLCvvThB4=;
 b=A7aQvBdKZ0FaVAFa1ehzB7aPhw0oQzNxjPvuBzpLqV4IE2Xpij06R3ltigsLpaqIgQpPgSUKzaMFE0uCprgS9DLiM9g+4L7bv1DdmIEGsxK49hspkupNq+CQ/Ax0yPzMHnS6Sjc4oYRTG+O68Yg8VYvC1ZnmsyDPHvmjyw6Cjolb63U5TnzXUOUqTaEV/l37+s90df7CHX39DcI/eh5dJ2DSFm/kBZY55+wN6mXTKtSDNmakvwZRtYj1E3cddENmFfLldbkpd4HOpxXwQgTglYdwq6GyHqVY/46i2QdHkPN1IOyzPUcAF4IiWd5T2QjZonpzH3FpUCZjha1czYgS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvnJor59gigz0YSIX7DxtZQ5/y3eYxUm78JLCvvThB4=;
 b=iPz89LVQKzZpiyGnJOBy/OJo4okvc6T3T4hf3fSCLTikOChotZniuB6LnFNv8brTUBbE/vouqQFoWxnc62vaLjMZPHn/HXh2rwTtNVfAgUyowE9ou3/153yWDYdHKFML0R4z1gIfD9+I712nEf2JRad7FRjWQeYTUyPsDFgeXOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AM6PR08MB4005.eurprd08.prod.outlook.com (2603:10a6:20b:a4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 27 Jan
 2022 10:39:51 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::245e:139f:5d4d:1dc2]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::245e:139f:5d4d:1dc2%3]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 10:39:51 +0000
Message-ID: <b889e360-9b6e-4517-c03a-f31f3168e36e@weidmueller.com>
Date: Thu, 27 Jan 2022 11:39:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add crate fetcher
Content-Language: en-US
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
References: <20220119180015.1931903-1-richard.purdie@linuxfoundation.org>
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <20220119180015.1931903-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5P194CA0014.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::24) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ee630a5-71c1-490e-cb2e-08d9e1815951
X-MS-TrafficTypeDiagnostic: AM6PR08MB4005:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR08MB40058371B65D4B24A71D57EBD7219@AM6PR08MB4005.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+yvdJ+jjoKb8yzm27yjtbs4e4RsoTcAb+xPGajLzKTeSt0T5BSSHBir2MMdh1WvqAiNV//ZQ7BIv+uRlzopot9l58ADErsgNegAq2v8497eMryTZIzKke2H+baE2zp9KQSB740R8IMqx1ZoYPas1Fl7o7bQ/gt0AzHo3aE55KKlQm4yYMeH5nI23+kqJqjPNbEz5U/8uc2AgFdL1It/ena7ylBaoMTvql6t+uteAPCV/jmNuT38NMxzC/iUzWZ1vWCeBZ7NEUCuFz02mlwkypiiBsz6o939tQk+0P/GNPqg66/+TqYY9PjaBwlamhZen5tU3iNSWR0PBcW6Lcon3nh60QVaYT5/5WYf39o0px9ejKOh/SdyDr7ttKeDgCNRaYlMOcJAp/DWGtfahpaxhvHOREdFA3xkMe7RUKrmIMzykWRbzK1nqzEaIUM99wFixDCTgIXzsl7K+f7xpneumyBFMQOWU9qOLpzDIzUTJaRBF/HLuMUVTLJ8fXTXDoQfSYgDxpF+3wSZnBHsJAJtlnzJCh3PoToO093f+/fhOYFb585akZjpGDKipQaC+Kc/if22223LaxW/KoDjH1jtKIkt8J4Jgwv8j4HWdgZyQSf12fAfpn5ewu0sWiOnV9i0z56G6YNBfy7uvE6es2s21uqdBdrviYwKAU8H1BAoRJO6V5p0oiDHOwmF6CQ//mPwowwly23hcux7xRkKNq3/pt2IiHvhrPrBXkOhe2NGEh7V1yuXs926Qz4DOM/2ETIqHe6zallO6ngnCeKMwyvJuMQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(8676002)(186003)(31696002)(83380400001)(66946007)(86362001)(36756003)(8936002)(26005)(2616005)(6486002)(31686004)(38350700002)(316002)(6506007)(38100700002)(5660300002)(2906002)(508600001)(52116002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVB4OFdrTDRUNTg4bzZaemRKOVBnTFJwcmxNVFV5dDcxM0pFMlhHbHhtY0xp?=
 =?utf-8?B?NmJ1OXdBdnAyQnJ2ODltUVZNMDltSFRCaXNCSVZOZWRrM04yT281OW9qRFh5?=
 =?utf-8?B?QVFiREtCaWtsUTFkclpIei83Mi85L004MkFDZlJBWUE0QkNuekMvWkhxWmdN?=
 =?utf-8?B?YllOUUVLSm8wWGZURTR0THB2MUt5dVVPVUNFUzErZXozN3ZSRVJyNkF5alNm?=
 =?utf-8?B?ek1abnFzZm90eFRUNC9Ec09ab1gxZStUcXlBdEZWK3B2Z0IwQzdWZ3JSTUNz?=
 =?utf-8?B?TEtocWFpZnkxd1hsWEU2bXVLdk5IS1IyUEJVa1plbzJnVWt0cWE4TnhIK253?=
 =?utf-8?B?cUlCdVYrRi9FY2Y2K1FVcXVRYlpxRXR5bTVDNlBCdzB5cktnMFVDeGxBUVdt?=
 =?utf-8?B?Z1hPc3QrQTRpZTcyN3FpWHJrZU53MVpCOUJ6anRKRjVXaTZsdlcvMkN3MjB2?=
 =?utf-8?B?SG9teWx1YjNOWG1lUTdwaVBPeVZFY1JHZXp2S2liSXdkU2YvV3htSUtxUHpq?=
 =?utf-8?B?RUZsM3JiSHo2bDgweThwK2N1VjU1YlVya0hjNkZBZ1FKQm1IVXc2Q3lHNDAv?=
 =?utf-8?B?T0lSTzdRbmVjOTZqSUdaT1hObEkyRHJ4RjVLdGxuMHV3a2xMZWduYTFWRUlT?=
 =?utf-8?B?ZGwveGZncHdWVnR6UFpGdFNPMkNIdE4yK2xjc2NqTzBsU2xpbEVQUm9KemhB?=
 =?utf-8?B?TUFocm9LRnFGT0RVVFlub1J4bTAvdWprbFQ2Ti8xZHFhMFRnS2xWZVRyb2Ur?=
 =?utf-8?B?MUxma0xCTW05MFZ4YVl2RnhlVjYzOG0zK2RoNDhOSmN0RkRIUmZEaVA3OTdC?=
 =?utf-8?B?R1BkK1FSL2g5Sy8zZ3VzbzVjR0pQcE83OVhaZlhHV0pFUWJDWjBDNWVEdHJt?=
 =?utf-8?B?WklWYmo4UnNDZU16RkxtR2RXaEhxdWphbGVSYThsbkF6UXI0K29sQzBabWxP?=
 =?utf-8?B?MW11WlNZdWRMSW5na0E2NkkvVytLbG8zR0MyNEU0SUhoMVJ2TEtuOFdGNXFt?=
 =?utf-8?B?Y1VlcXljQkJ0WDEyOWg3YU5QcDZSQW9TelFkRUk0NnUySldwbnNBQ0lQemRr?=
 =?utf-8?B?M2dSa09nNDdaQis3V3hmcjA1eFNWZWwzWFJ4a3Bnbjl3bElocXJQdTRxaUps?=
 =?utf-8?B?a2RXYXl6cmo3OW5IYnRReElQU3FnZ0tONjlLdFZlQzBxWVIzK1B1blFPVnpq?=
 =?utf-8?B?SC9HeUNiSC94RXZoZG5zY3FmejF6REt4ODlhaExVUzNrakFUTnU4SHlpcTZV?=
 =?utf-8?B?OTNJODRRNkJPaWFSZ1c2VjdpdFlhUExtZXhjUVVpOTkxYVVJUWlmT1dBdkNk?=
 =?utf-8?B?VzJ5QlBPajJkelJEV3pvVlBxRDJWYktaVDAwT2pmamQ0aTczSWQrUThUNlBu?=
 =?utf-8?B?K3JVb2trMjA3VVBQVWNISzRheW4za1lPUjcwTkt1TDJSeW5acy90RCsxZmQ5?=
 =?utf-8?B?dlh4SE5vTEx1YU03T1lUOGpnMlcxb242d2U4SlBSMC9jb3dFUTExK0hkT0ZD?=
 =?utf-8?B?c25jYjY4YWp1YnZHaWdLbnJoZjZTL1UxZUVSUnFUa2diN1F6SFY2RWJYUGNu?=
 =?utf-8?B?RkxhSGpmTXMrQklEWmF4aU8vMU15cXBseVI4cGRtSXN0RFA4eTAybm9RdTZs?=
 =?utf-8?B?UDFJbFZQanltVnRML3VzUXFjbmVobHlFYWZJemxCNTg3SWVVWkw2eElQeUlV?=
 =?utf-8?B?VFpvRVViRGpFbDVvczhFeExMSWZxT0VWcncrZlZQb3JjZkNLWVN0aWZRL2Qy?=
 =?utf-8?B?YWxaS3Z2R1NjMUd6aWxRMFB3VHRMNkJ5MGtRMy83OE8zYkhkOW40Q3FzUTFr?=
 =?utf-8?B?UmJTaEE4bmVmREVSZlRXWEl0ME5jdlBXSTNUSEZaNzI3RzhJUGN0ZytOc1hM?=
 =?utf-8?B?NUl4WFc4a0FLV01nMllUYmw0K21pdzhDNTZrOVYwU0Q2V2hGeGRMZVNFQklD?=
 =?utf-8?B?N0h3MWR3c2VJTTdPc045Y1VSaUpxTkozN2E1Ti8ranhRYmV5UnVObnlDK0Fr?=
 =?utf-8?B?bjI1WGpCTGRnbFo0MDRHOE5UUnhRUUtZbXlpckliK1FNN3IxZU5pT0tSdXQ2?=
 =?utf-8?B?cWtFQmZWR0lwZW1QZE42SjYvNG14RHJ6SW9CanY4bU5BaUpSNkZ3cVpxTGUx?=
 =?utf-8?B?a2ZIdmJrRlI1aHp6RWFlQkFEOHRXRXZsTFJDd25VSHRVOWV3d21vTEtIM2t3?=
 =?utf-8?Q?o2U6eSD+8bnRpboRq0kKhcc=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5ee630a5-71c1-490e-cb2e-08d9e1815951
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 10:39:51.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 MoqCUpnEUSZgdrK7QYchzt4i/AionpLJ4PySk/st/41kUG1YhK0q7lTPi0z/FTge+lNh0pTkf/Wgf1GxXjB3Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4005
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Jan 2022 10:39:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13287

Hi Richard,

Am 19.01.2022 um 19:00 schrieb Richard Purdie via lists.openembedded.org:
> This imports the crate fetcher from OE-Core to resolve various module issues
> and adds some very very basic tests of that new fetcher.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/fetch2/__init__.py |   2 +
>   lib/bb/fetch2/crate.py    | 137 ++++++++++++++++++++++++++++++++++++++
>   lib/bb/tests/fetch.py     |  35 ++++++++++
>   3 files changed, 174 insertions(+)
>   create mode 100644 lib/bb/fetch2/crate.py
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 0b39ea6aaa..d37174185a 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1942,6 +1942,7 @@ from . import clearcase
>   from . import npm
>   from . import npmsw
>   from . import az
> +from . import crate
>   
>   methods.append(local.Local())
>   methods.append(wget.Wget())
> @@ -1962,3 +1963,4 @@ methods.append(clearcase.ClearCase())
>   methods.append(npm.Npm())
>   methods.append(npmsw.NpmShrinkWrap())
>   methods.append(az.Az())
> +methods.append(crate.Crate())
> diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
> new file mode 100644
> index 0000000000..f7e2354afb
> --- /dev/null
> +++ b/lib/bb/fetch2/crate.py
> @@ -0,0 +1,137 @@
> +# ex:ts=4:sw=4:sts=4:et
> +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
> +"""
> +BitBake 'Fetch' implementation for crates.io
> +"""
> +
> +# Copyright (C) 2016 Doug Goldstein
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Based on functions from the base bb module, Copyright 2003 Holger Schurig
> +
> +import hashlib
> +import json
> +import os
> +import shutil
> +import subprocess
> +import bb
> +from   bb.fetch2 import logger, subprocess_setup, UnpackError
> +from   bb.fetch2.wget import Wget
> +
> +
> +class Crate(Wget):
> +
> +    """Class to fetch crates via wget"""
> +
> +    def _cargo_bitbake_path(self, rootdir):
> +        return os.path.join(rootdir, "cargo_home", "bitbake")
> +
> +    def supports(self, ud, d):
> +        """
> +        Check to see if a given url is for this fetcher
> +        """
> +        return ud.type in ['crate']
> +
> +    def recommends_checksum(self, urldata):
> +        return False

Why is this false? How the fetcher check the integrity?

> +
> +    def urldata_init(self, ud, d):
> +        """
> +        Sets up to download the respective crate from crates.io
> +        """
> +
> +        if ud.type == 'crate':
> +            self._crate_urldata_init(ud, d)
> +
> +        super(Crate, self).urldata_init(ud, d)

Why is this needed? The ud.type should always be 'crate'.

> +
> +    def _crate_urldata_init(self, ud, d):
> +        """
> +        Sets up the download for a crate
> +        """
> +
> +        # URL syntax is: crate://NAME/VERSION
> +        # break the URL apart by /

Why does this fetcher use a '/' as separation? The npm fetcher use 
package and version options:

npm://some.registry.url;package=${BPN];version=${PV}

> +        parts = ud.url.split('/')
> +        if len(parts) < 5:
> +            raise bb.fetch2.ParameterError("Invalid URL: Must be crate://HOST/NAME/VERSION", ud.url)
> +
> +        # last field is version
> +        version = parts[len(parts) - 1]
> +        # second to last field is name
> +        name = parts[len(parts) - 2]
> +        # host (this is to allow custom crate registries to be specified
> +        host = '/'.join(parts[2:len(parts) - 2])

This is error-prone because it is impossible to detect a missing name or 
version if the real host url is used.

> +
> +        # if using upstream just fix it up nicely
> +        if host == 'crates.io':
> +            host = 'crates.io/api/v1/crates'
> +
> +        ud.url = "https://%s/%s/%s/download" % (host, name, version)
> +        ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
> +        ud.parm['name'] = name
> +
> +        logger.debug(2, "Fetching %s to %s" % (ud.url, ud.parm['downloadfilename']))
> +
> +    def unpack(self, ud, rootdir, d):
> +        """
> +        Uses the crate to build the necessary paths for cargo to utilize it
> +        """
> +        if ud.type == 'crate':
> +            return self._crate_unpack(ud, rootdir, d)
> +        else:
> +            super(Crate, self).unpack(ud, rootdir, d)

Why is this needed? The ud.type should always be 'crate'.

> +
> +    def _crate_unpack(self, ud, rootdir, d):
> +        """
> +        Unpacks a crate
> +        """
> +        thefile = ud.localpath
> +
> +        # possible metadata we need to write out
> +        metadata = {}
> +
> +        # change to the rootdir to unpack but save the old working dir
> +        save_cwd = os.getcwd()
> +        os.chdir(rootdir)
> +
> +        pn = d.getVar('BPN')
> +        if pn == ud.parm.get('name'):
> +            cmd = "tar -xz --no-same-owner -f %s" % thefile
> +        else:
> +            cargo_bitbake = self._cargo_bitbake_path(rootdir)
> +
> +            cmd = "tar -xz --no-same-owner -f %s -C %s" % (thefile, cargo_bitbake)
> +
> +            # ensure we've got these paths made
> +            bb.utils.mkdirhier(cargo_bitbake)
> +

Why don't you use the origin unpack and set the subdir to the correct 
folder. This allows the usage of the wget fetcher for crate archives 
outside of a repository.

> +            # generate metadata necessary
> +            with open(thefile, 'rb') as f:
> +                # get the SHA256 of the original tarball
> +                tarhash = hashlib.sha256(f.read()).hexdigest()

Why don't you reuse the checksum from the recipe.

> +
> +            metadata['files'] = {}
> +            metadata['package'] = tarhash
> +
> +        path = d.getVar('PATH')
> +        if path:
> +            cmd = "PATH=\"%s\" %s" % (path, cmd)
> +        bb.note("Unpacking %s to %s/" % (thefile, os.getcwd()))
> +
> +        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
> +
> +        os.chdir(save_cwd)
> +
> +        if ret != 0:
> +            raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), ud.url)
> +
> +        # if we have metadata to write out..
> +        if len(metadata) > 0:
> +            cratepath = os.path.splitext(os.path.basename(thefile))[0]
> +            bbpath = self._cargo_bitbake_path(rootdir)
> +            mdfile = '.cargo-checksum.json'
> +            mdpath = os.path.join(bbpath, cratepath, mdfile)
> +            with open(mdpath, "w") as f:
> +                json.dump(metadata, f)

[snip]

