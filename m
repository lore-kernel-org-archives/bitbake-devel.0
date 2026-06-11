Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDF8CD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 12:10:50 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43881.1781179843460967731
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 05:10:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=ddhM0DEB;
 spf=pass (domain: cherry.de, ip: 52.101.72.25, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HViWjdCBu+DTUaHBY8wtyBsW6sz9qAK6WBm1WrjhYo3gKdzU5VZaPyTN8KJlhBO/jNTpihhDCurVdO+W2n5XdjUFknjGTGmhDuSCAmlAxJEQ2v6yNB9/QrdGWLC3YdYARdWxeH/JYxnzx/aQ7IOzcXj9Kt1T0RqnYrNHXk/kh8KtZ3xkQIQkvR+Z2sn4p6/nbOO4ZjhxiI/FqhB74VxdYDvSZCeeqQuuIrj+ygjRQnYDtunw6GGXekt+o3HEbT+pRFTYJhUFPaoEDZcOhSZGoCjm/zbJ8VhWxXTjLsgCMtaIb69Q3DKPTlBwswe1iAXxi4FkOCV4Px/jnLEnNCPXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhofzQyBSj9iDzxJfLSFt9gFdq6zKWGypK0WBvAVvr4=;
 b=HI+sOoGy07efI4IFBQkD71WaO8wUf9MSpRlbWAlQtXRNRcK07qQskVJdBKDRBP6HRVwZ0kU4RTtA1gmZ7iWJq/BextzyN1osGXi8CWWIeXhK+Ueg7WLXxIQR5ihC6azHagbjSNS2qUW0oxIa6Gp6mSUDS1kLZWpuRg7jIQBI/XlHBy/y2H/8gIeCc11L+4ffqTE+fDntyihAAx2iq7yWyT6Ua7Q60XyPH0+h+FbaG24+ab1nNhdlNhxwH27uF3cn4niGtsUbJwYQElWjZWaDvRl7LxnWfmAprVQ7VNfuuGmVlRyR87t4hrSeJfRQUUbRgmC3tmfW9mCpHs1Pwj77Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhofzQyBSj9iDzxJfLSFt9gFdq6zKWGypK0WBvAVvr4=;
 b=ddhM0DEBFw63/4OG1QMHrd1+nSXvadtfeSts70K3A6ba7eR5u3h7FstIyhlOBKkPMgAPWCZYuOuHyJXsGsV3+YSioFfVQ7DMiw3xDaJFRbgeqm2j/nOaDjXcdnw2iiM3zh4LaTSfOjuXlDETZJ+rlLy5ADqxf/UKroxVysrcFwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DUZPR04MB10016.eurprd04.prod.outlook.com (2603:10a6:10:4dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 12:10:37 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Thu, 11 Jun 2026
 12:10:37 +0000
Message-ID: <43101549-7aa8-42b7-a316-ec99ac3225f5@cherry.de>
Date: Thu, 11 Jun 2026 14:10:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 2/2] lib/bb: Further shell=True cleanups
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
References: <20260611110523.322273-1-richard.purdie@linuxfoundation.org>
 <20260611110523.322273-2-richard.purdie@linuxfoundation.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260611110523.322273-2-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::16) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DUZPR04MB10016:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3bd741-38f0-485e-7536-08dec7b272a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|4022899009|366016|4143699003|6133799003|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 
	rso0zQSAdKATkv9BCp6tYWKCS/MuAafuVvbBqSuRqLyWU2UKKJ2RRixfO6P4pz5SA/qiTFfzHtHjDWuFcgVuFL4HIVByx+bwfuKTT/Bb/gWoaQ9oglDQVKsKZQGLRTmGjzue1sWUy70GVcFDkNn9mRs1W7yqlAKexvEbFQ0wnt+sI11766onlNZjYzUuY7lNey38hppYvbfimUdHICips5zk2If6ioagfFZU524O+yCQeoInC+HAqTWfZ6t3owsGlUN3bP4+eAX00qHxQmAMJhKw28ZNy3zVfFSf7oeIcUM/Aa7fl55PR7ow513+al0fc/hPQyPHEFvBQTzmHnD1ffPd/cRJ1n8zRtcEo+ZQXrdXGcB7jG+EsR9aVA8dQVj/786eJ7GZ6FAbvuDmUR92G6KtnJzJMEOgLHd0CVzGM0iWP0RU/Y4/b4Bp/a8IbXt/YiLW1gHYmrNzEE9Eyj8BVt0+M+hioTg6J3zdO5Dix0VT9RAtC6rNqWaFha8Xx10cGZvL26uInq0fsPkuwEY9C93F61KqoaWSWBvTfJ8xNrs7WFgDG29E8oGKiwvJyVHHbSsoJnImpxeegD7pg51KYTfOtqxhO4SYK4SirwSVlTF611L0/XDhy2WdgAoetX2FvichX8n8mldn1BbQjgy3du3pdNxgYDnnrgJA208cRt1QxmEgEZx6R0eKdM077LqlaT5sv8wlPB9CoJX1bbx75Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(4022899009)(366016)(4143699003)(6133799003)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmgvMm83dndmSmR2N3RTeXVKZ1M0NUJCVlV1Qm05VW5ZMURCU25wRFJUMDNv?=
 =?utf-8?B?bDRkNVZGa0RMQnA0aFZUbmVjZWIvSEw0QmZHSTdIR1FIMlVUeGJ1bUhTeU5T?=
 =?utf-8?B?SlNoN0IwUXZIVzVjQTBoVUwzbWxCenNzUVBxNjcrM2xqTTZqcGpiSHRDbC9j?=
 =?utf-8?B?V0NmVWV4dGhMdXpidDU3MHFJcEJvKzFUZDNsdTJWN1hDSXFZM1JxNGM4a2Zl?=
 =?utf-8?B?Y2UxQ1hZVm01MTNNTEM1aTNoQ1dTa1pBZGNURkl1UFpwcm1rcnpaT2hhSUFQ?=
 =?utf-8?B?aFRvbmNjTDBoOXZqSzluRFBoQWFmeUFMVldha2tDU0pWTWtOcTJHTVh6d09z?=
 =?utf-8?B?ek15TWEzRDNjb2ZQa2tuVmNtdWhBVThYbzN0YkNQa3cyTFF4d2Vsa3lQR1My?=
 =?utf-8?B?TVpPN0M0U21mM3h4ZVJPV3RHQjBCM1dGa0hoUEk0WmFIRER0dkpPUnJvampC?=
 =?utf-8?B?NlkrZU0vL0thekcyUlN1bDRwdUtna1NWTHJyTmVjSGhQSkRPcEUzZ2pQWGpV?=
 =?utf-8?B?elFmUjJNUnA5SDByVE5BQStWRFdIYWpBNG9Ed0gzUTFrYU90SitvbnlsY2Fy?=
 =?utf-8?B?QUFiak1pSEJjd3d3LzdrL1FsVTgrU3ZVTHFMcmdGU2w2MWV2VUo0S1cyTTBm?=
 =?utf-8?B?dVhZbUl5WXlha21uTlYvSHZ6RWx0UExIQlVpV0dsLzdsWjVLRkNCeXo2RGR2?=
 =?utf-8?B?UWxhVDBXY0NUR1Q3ZG1GVWtFYkJmYWgvQVNUOUpKNFZXd0J1U2Nlemd2UXJJ?=
 =?utf-8?B?MmF4OG5sNm41Sklya0tLR0hOY3Zqd0JQRXJWR0MxbFB0N2J5UjZ4ZmJ5bXBV?=
 =?utf-8?B?MkZPajIvaVlXa1lHQTlwdmxRei9jVWlsUnNpSTAxQVJPS1hpa0YxVDJsYi85?=
 =?utf-8?B?ajFrWmJiazA2V2RSOTYzelFVdGh1OXFCZzNxT1R3VnlnbWFzeHRuSHN1M2s4?=
 =?utf-8?B?SzdpK0tBcUh0cmVHcll3QTJOQi9DM3pvNEdSU1VZbjJnaUVhVmIrQ3Q3a2J6?=
 =?utf-8?B?VWpjQzZ5STJadzRCbk1CNUt0RGJ1ZzBNZlNxYW93QVY3SkZmRlVPblBSSFVG?=
 =?utf-8?B?MDNzY3poMlpOeWRnQVRvcWc3NEY3clhtRndRRkE2clFZaFR6YXdOTmdrMU15?=
 =?utf-8?B?MVA0Vy9mVC8xZjNPVU1jdWc2N2tVaW5mcjFKS3lRYWlvK2tBR2xpaG5FUEJa?=
 =?utf-8?B?RjN4WGNiZXV6UEpyL0JES3NyUEp4UXNzeXZ3dFh1WGJFWCtyTmVVL0l3ajFP?=
 =?utf-8?B?QWc4dVBpbm4xOTdqZENLUWNKNDZwdnNKN0lIeldGK3NDanlUSjhqRjJrMFdH?=
 =?utf-8?B?RzNQOGhOSmVHbmFLTmhvWTNOSGZubjVWaTdOd1VaeFMvakxFWTRwRUhIRkRO?=
 =?utf-8?B?UDBhc2JpSnBXY1VGOGdmSVNOWG8rQmV1MnhPVStJVWR1cGxLNkhnMFF4V2k0?=
 =?utf-8?B?MEZ6OUtVVzMrOFNzUHAvMTNQTzJSQUhwazVIVHdwM2M0NmkvZnhYU0lCWUdK?=
 =?utf-8?B?UDhveTJiaGZlb1VuSkxuRVc4S25CV09nVS9QVU5XeGQxZDYwbHVqVzFUMDA1?=
 =?utf-8?B?bjlMeDZyM1BmU1IzMVA5bjFRam1abytUcEcyZmZjNXpvYnRJNGt0d0lsVm9s?=
 =?utf-8?B?UGduRUYzZ1B3UnJiNGpUZWxtQ3M4R1h2YzlobnA1cDcrOUZkcnF5dUJoUDZ2?=
 =?utf-8?B?K0h4STA0K2RFdjR2bG1ISnJZMFRJRXpYcVRyZktCRVdVTEkrVlNiSUhHbThU?=
 =?utf-8?B?MlhaUGRtbFZPV3BqK2U4b0ZCN0NpMkV0aFlnQVRTMUplTENjbnRRNTUzQWNQ?=
 =?utf-8?B?aUFuV1VsQ3F1anQvQlBJRWJ1aFk5TCsrZ3NPSWVPZEF1NDVueHhnemh6TG5p?=
 =?utf-8?B?c2ZacjgzejFIbFZZOCs0QTljY0JFa1VQSXowTUJCUVFBQmxMTVhsWFJ5cUJU?=
 =?utf-8?B?bmtkRklDTnhKZldMVm82ZzA3S3ArK0xwTmZybm96bWZWLzNxVEpMSXZQK0FC?=
 =?utf-8?B?UWZwalFCY2JzRHNvaHYxV2pBZzhDd0svZG5HekpDQ045UlFkMTF4b0pHY1Rn?=
 =?utf-8?B?S1RJUTUzTUV3dVpES0dWc3hucXNnZGRISkR1b0NObWgxVnBibytDdis2OENM?=
 =?utf-8?B?TERFUmplNTNxUGxGbDMrN2xzS25kTnhyd0s3Qk5Zcm9wcnBFdlJtdEoxblNz?=
 =?utf-8?B?dzFKRlVBTmNJSEk1cXYzTUJGbms0UmkxNWdGM0s2dm9jN2JEMVk4cGVUck1Q?=
 =?utf-8?B?SUZaU1ArcEw3YzdsRlQ5cmlwMkx3OTE0MFdZT3NrTWh5VEY1YlM4ajVXYmIz?=
 =?utf-8?B?VHUrMTRUVFpwbEllcHpGdGNMYUsvLzdjREFSRExBaG5jYk9YNGl3dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3bd741-38f0-485e-7536-08dec7b272a4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:10:37.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+/oczU04KHOEoTV4ErrR9K8+hnKL1l2yzNhCZyvNzYkcRspMZkglDPIoxZzlFBb8uQJieIsQMmw4FBkCVeBBdn1mtQlG1PD0vEWzE6S0y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10016
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 12:10:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19657

Hi Richard,

On 6/11/26 1:05 PM, Richard Purdie via lists.openembedded.org wrote:
> Go through the remaining shell=True references in bitbake and clean them up
> to use lists where possible. By using existing helpers, chdir and PATH
> settings can be dropped.
> 
> In toaster, the current branch can be obtained more easily with modern git
> commands.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/fetch2/crate.py                        | 21 ++++---------------
>   lib/bb/fetch2/gomod.py                        |  7 ++-----
>   lib/bb/ui/ncurses.py                          |  2 +-
>   .../bldcontrol/localhostbecontroller.py       | 21 +++++++++++--------
>   lib/toaster/toastermain/settings.py           |  4 ++--
>   5 files changed, 21 insertions(+), 34 deletions(-)
> 
> diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
> index 8f928ea6b4d..f94e153ee3b 100644
> --- a/lib/bb/fetch2/crate.py
> +++ b/lib/bb/fetch2/crate.py
> @@ -17,7 +17,7 @@ import subprocess
>   import re
>   from functools import cmp_to_key
>   import bb
> -from   bb.fetch2 import logger, subprocess_setup, UnpackError
> +from   bb.fetch2 import logger, subprocess_setup, UnpackError, runfetchcmd
>   from   bb.fetch2.wget import Wget
>   
>   
> @@ -110,19 +110,15 @@ class Crate(Wget):
>           # possible metadata we need to write out
>           metadata = {}
>   
> -        # change to the rootdir to unpack but save the old working dir
> -        save_cwd = os.getcwd()
> -        os.chdir(rootdir)
> -
>           bp = d.getVar('BP')
>           if bp == ud.parm.get('name'):
> -            cmd = "tar -xz --no-same-owner -f %s" % thefile
> +            cmd = ['tar', '-xz', '--no-same-owner', '-f', thefile]
>               ud.unpack_tracer.unpack("crate-extract", rootdir)
>           else:
>               cargo_bitbake = self._cargo_bitbake_path(rootdir)
>               ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)
>   
> -            cmd = "tar -xz --no-same-owner -f %s -C %s" % (thefile, cargo_bitbake)
> +            cmd = ['tar', '-xz', '--no-same-owner', '-f', thefile, '-C', cargo_bitbake]
>   
>               # ensure we've got these paths made
>               bb.utils.mkdirhier(cargo_bitbake)
> @@ -135,17 +131,8 @@ class Crate(Wget):
>               metadata['files'] = {}
>               metadata['package'] = tarhash
>   
> -        path = d.getVar('PATH')
> -        if path:
> -            cmd = "PATH=\"%s\" %s" % (path, cmd)
>           bb.note("Unpacking %s to %s/" % (thefile, os.getcwd()))
> -
> -        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
> -
> -        os.chdir(save_cwd)
> -
> -        if ret != 0:
> -            raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), ud.url)
> +        runfetchcmd(cmd, d, workdir=rootdir)
>   
>           # if we have metadata to write out..
>           if len(metadata) > 0:
> diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
> index 8a64f644dfd..5cdf8f99814 100644
> --- a/lib/bb/fetch2/gomod.py
> +++ b/lib/bb/fetch2/gomod.py
> @@ -135,13 +135,10 @@ class GoMod(Wget):
>           unpackdir = os.path.dirname(unpackpath)
>           bb.utils.mkdirhier(unpackdir)
>           ud.unpack_tracer.unpack("file-copy", unpackdir)
> -        cmd = f"cp {ud.localpath} {unpackpath}"
> -        path = d.getVar('PATH')
> -        if path:
> -            cmd = f"PATH={path} {cmd}"
> +        cmd = ['cp', ud.localpath, unpackpath]
>           name = os.path.basename(unpackpath)
>           bb.note(f"Unpacking {name} to {unpackdir}/")
> -        subprocess.check_call(cmd, shell=True, preexec_fn=subprocess_setup)
> +        runfetchcmd(cmd, d)
>   
>           if name.endswith('.zip'):
>               # Unpack the go.mod file from the zip file
> diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
> index 18a706547aa..228fa9a6dc7 100644
> --- a/lib/bb/ui/ncurses.py
> +++ b/lib/bb/ui/ncurses.py
> @@ -291,7 +291,7 @@ class NCursesUI:
>   #                            bb.error("log data follows (%s)" % logfile)
>   #                            number_of_lines = data.getVar("BBINCLUDELOGS_LINES", d)
>   #                            if number_of_lines:
> -#                                subprocess.check_call('tail -n%s %s' % (number_of_lines, logfile), shell=True)
> +#                                subprocess.check_call(['tail', '-n' + number_of_lines, logfile])
>   #                            else:
>   #                                f = open(logfile, "r")
>   #                                while True:
> diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
> index 50069d47a4c..dcbd9a8260d 100644
> --- a/lib/toaster/bldcontrol/localhostbecontroller.py
> +++ b/lib/toaster/bldcontrol/localhostbecontroller.py
> @@ -51,7 +51,10 @@ class LocalhostBEController(BuildEnvironmentController):
>               env=os.environ.copy()
>   
>           logger.debug("lbc_shellcmd: (%s) %s" % (cwd, command))
> -        p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
> +        if isinstance(command, str):
> +            p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
> +        else:
> +            p = subprocess.Popen(command, cwd = cwd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
>           if nowait:
>               return
>           (out,err) = p.communicate()
> @@ -136,7 +139,7 @@ class LocalhostBEController(BuildEnvironmentController):
>           cached_layers = {}
>   
>           try:
> -            for remotes in self._shellcmd("git remote -v", self.be.sourcedir,env=git_env).split("\n"):
> +            for remotes in self._shellcmd(['git', 'remote', '-v'], self.be.sourcedir, env=git_env).split("\n"):
>                   try:
>                       remote = remotes.split("\t")[1].split(" ")[0]
>                       if remote not in cached_layers:
> @@ -172,8 +175,7 @@ class LocalhostBEController(BuildEnvironmentController):
>               # see if our directory is a git repository
>               if os.path.exists(localdirname):
>                   try:
> -                    localremotes = self._shellcmd("git remote -v",
> -                                                  localdirname,env=git_env)
> +                    localremotes = self._shellcmd(['git' ,'remote', '-v'], localdirname, env=git_env)
>                       # NOTE: this nice-to-have check breaks when using git remaping to get past firewall
>                       #       Re-enable later with .gitconfig remapping checks
>                       #if not giturl in localremotes and commit != 'HEAD':
> @@ -186,12 +188,12 @@ class LocalhostBEController(BuildEnvironmentController):
>               else:
>                   if giturl in cached_layers:
>                       logger.debug("localhostbecontroller git-copying %s to %s" % (cached_layers[giturl], localdirname))
> -                    self._shellcmd("git clone \"%s\" \"%s\"" % (cached_layers[giturl], localdirname),env=git_env)
> -                    self._shellcmd("git remote remove origin", localdirname,env=git_env)
> -                    self._shellcmd("git remote add origin \"%s\"" % giturl, localdirname,env=git_env)
> +                    self._shellcmd(['git', 'clone', cached_layers[giturl]], localdirname], env=git_env)

Isn't there a spurious square bracket after cached_layers[giturl]? (the 
one after localdirname is correct I believe).

Cheers,
Quentin

> +                    self._shellcmd(['git', 'remote', 'remove', 'origin'], localdirname, env=git_env)
> +                    self._shellcmd(['git', 'remote', 'add', 'origin', giturl], localdirname, env=git_env)
>                   else:
>                       logger.debug("localhostbecontroller: cloning %s in %s" % (giturl, localdirname))
> -                    self._shellcmd('git clone "%s" "%s"' % (giturl, localdirname),env=git_env)
> +                    self._shellcmd(['git', 'clone', giturl, localdirname], env=git_env)
>   
>               # branch magic name "HEAD" will inhibit checkout
>               if commit != "HEAD":
> @@ -199,7 +201,8 @@ class LocalhostBEController(BuildEnvironmentController):
>                   ref = commit if re.match('^[a-fA-F0-9]+$', commit) else 'origin/%s' % commit
>                   # DEBUGGING NOTE: this is the 'git fetch" to disable after the initial clone to
>                   # prevent inserted debugging commands from being lost
> -                self._shellcmd('git fetch && git reset --hard "%s"' % ref, localdirname,env=git_env)
> +                self._shellcmd(['git', 'fetch'], localdirname, env=git_env)
> +                self._shellcmd(['git', 'reset', '--hard', ref], localdirname, env=git_env)
>   
>               # verify our repositories
>               for name, dirpath, index in gitrepos[(giturl, commit)]:
> diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
> index d2a449627f8..9d2dbc464ec 100644
> --- a/lib/toaster/toastermain/settings.py
> +++ b/lib/toaster/toastermain/settings.py
> @@ -229,8 +229,8 @@ from os.path import dirname as DN
>   SITE_ROOT=DN(DN(os.path.abspath(__file__)))
>   
>   import subprocess
> -TOASTER_BRANCH = subprocess.Popen('git branch | grep "^* " | tr -d "* "', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
> -TOASTER_REVISION = subprocess.Popen('git rev-parse HEAD ', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
> +TOASTER_BRANCH = subprocess.check_output(['git', 'branch', '--show-current'], cwd=SITE_ROOT, text=True).strip()
> +TOASTER_REVISION = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=SITE_ROOT, text=True).strip()
>   
>   ROOT_URLCONF = 'toastermain.urls'
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19655): https://lists.openembedded.org/g/bitbake-devel/message/19655
> Mute This Topic: https://lists.openembedded.org/mt/119754620/6293953
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [quentin.schulz@cherry.de]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


