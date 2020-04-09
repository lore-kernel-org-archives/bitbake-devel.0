Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.78])
 by mx.groups.io with SMTP id smtpd.web10.5824.1586425953346950823
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Apr 2020 02:52:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=kBl5QTea;
 spf=pass (domain: windriver.com, ip: 40.107.223.78, mailfrom: changqing.li@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiRr8O0CI6eB6QsjbI8guye1R5ZjDxqI+jjX98dR1nvSXovhivP3wzixPsqvIqYzXgIIrlYgPmMrR+ac2jUiLEicHAF46D+XLViqQeIL2JRIBXdC9yHOsHqmedD5GJ9XqF/VS2cOQoSJWsmKbWnO+nzpUwDaxm7PZiQYSKo4Z5v9/gsL+na1NCVwF7k5IBA9IkcS215+ETNflrJILU7jA+z+M7wSFKr6LOQ3HnFk51LLi6bx+2ShfaSIprcvMCWLPzE9ljs7dJLILCWRR7g6gYEVHHfHvb4FYmZ4hb2wz0G3beB+kC+2DIJeQ7bPd0X3obbU2QzhpPMPA0zqlOzSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9boezzTOEuDWwpenJIaQcw+5NaE8JPp8PFdtL8sNxc=;
 b=RWWYOQoWkqzK+ATDvw7gS1VztIiA8zTSPyjuBqGjbggAXH+bwlB5ML6/+4GTe4W2mXaqTFll5v2VEFpIcTrHgIl348u7zSsFAmel5Z8+ncpL7RsiFubOp9/iLvD5tavpRn5eNNsk0ohHXp7oF2/fVT7dDmqrTIm1K0zj3bP4N+c47Dan00Q/PkEWDHH6u7WQXUSOcxbX8Ita+YUqJG4N1yHRO76NhLkMfiB6Fp8n7WntIdteeRa1Gxp6A0MKSsJ1XT9sWkKhuOQGx9uhRV2f900CGuskDiE9U4ui8As1yJXLDZWnEsJ2Qoaj4uGi/2tpp/cLsvPK3kOzfO9x1FW8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9boezzTOEuDWwpenJIaQcw+5NaE8JPp8PFdtL8sNxc=;
 b=kBl5QTeamnQDylg4/k1NAi4uxp1tsw9nh8bgd7wr2syBnBuP8Y0mPGcPxkekA4meaJwvL/AaUSqLTRKkAdqveplijp7mXaFQd45XkZ5rhsyDOmp9uhLecChy5yi/L4DsICPTYmzH2pNnu81sR+qpYtnpbxOspc6m112MayISzg4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changqing.Li@windriver.com; 
Received: from SN6PR11MB2557.namprd11.prod.outlook.com (2603:10b6:805:56::33)
 by SN6PR11MB3151.namprd11.prod.outlook.com (2603:10b6:805:d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Thu, 9 Apr
 2020 09:52:31 +0000
Received: from SN6PR11MB2557.namprd11.prod.outlook.com
 ([fe80::3ce1:6359:35f0:ec2d]) by SN6PR11MB2557.namprd11.prod.outlook.com
 ([fe80::3ce1:6359:35f0:ec2d%6]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 09:52:31 +0000
Subject: Re: [bitbake-devel] [RFC][PATCH] fetch2/git.py: update way to check contains lfs
To: bitbake-devel@lists.openembedded.org, naveen.kumar.saini@intel.com
References: <16041DC6947144EF.5874@lists.openembedded.org>
From: "Changqing Li" <changqing.li@windriver.com>
Message-ID: <520d4dcd-c040-9f83-be28-be0e7890f039@windriver.com>
Date: Thu, 9 Apr 2020 17:52:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
In-Reply-To: <16041DC6947144EF.5874@lists.openembedded.org>
X-ClientProxiedBy: SL2PR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:100:55::13) To SN6PR11MB2557.namprd11.prod.outlook.com
 (2603:10b6:805:56::33)
Return-Path: changqing.li@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.189] (60.247.85.82) by SL2PR03CA0001.apcprd03.prod.outlook.com (2603:1096:100:55::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend Transport; Thu, 9 Apr 2020 09:52:29 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 278d569a-09ba-4c16-cdc1-08d7dc6bb840
X-MS-TrafficTypeDiagnostic: SN6PR11MB3151:
X-Microsoft-Antispam-PRVS: 
	<SN6PR11MB3151C691CC358524170B3C9D82C10@SN6PR11MB3151.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2557.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(366004)(346002)(39840400004)(376002)(396003)(31686004)(81156014)(8676002)(16526019)(15650500001)(316002)(478600001)(2616005)(2906002)(53546011)(44832011)(956004)(6706004)(31696002)(26005)(86362001)(966005)(186003)(6666004)(5660300002)(36756003)(52116002)(8936002)(16576012)(66476007)(66946007)(81166007)(33964004)(66556008)(6486002)(78286006)(43043002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tXbcAZTuRqpJbfw0sDXtnWBFGtwfyHwJ5zvG6UCoim9HvXpe0HOQMu8s0GPdoCZHEo9133huWpWJER7zc3YbFA4mHHAcut8XaftnWu/j328fZx5t5T3Zgjrqk2WoZRKoHsuHlRJ5aracQmPqEWUCpxWYB9WRsT2FEqZ7gR1VQEJFUPCzrbX4vubdHhjmJnWkEoQTDEDJGBKHUk6cpC/vx/luSoyKV/Azh3AnP55A+axQmxm3vidtbtmPyMLJTnInVvumqL8aYnFtMTeRlqw3T9Hb4G7U4GIqiVCmjdx7CfzmHPAwgiz+wogg5rPRP2wRf6MCONuj1C3lf4qciWfANCg3N7FS+c4+2bngNCuNGFpcRmC6PuC7ozvG4TWWYrQB8Y+KjKu86SwHq8s6HChKT0Dkv0yk9ehRV0AbH6+OISaIdvrHDOEMYBv//BBDsV+/OwRPc9dXXBMlJD0Zy8DNMTm6Cf487t9CJtERD3erlwTRKMcx1ndDPQdHDYRfJyDVuCsUSeR1w0TRnpSLQRoZhHbw2Uh1WB+XU2kPMJL64y6GzTsHrxqEwAucgTT3gwro4OZLBuNWwuEugH1+beE7TfsvX54Nxm3Ggvguj149/HVhgExdlYAH29e2QTJVV0f0Yneeu+8Jg+keq/PYs2l0SQ==
X-MS-Exchange-AntiSpam-MessageData: 
	dR0T8f325Yn27MN07ds3DgqtUKKWnCGbN2LYNovj5VPZtpr0rHFW4nsQ/hVMEuNlTRYBuBuqrbMV4jqX6TStWJ8XEdgLXbocAjT1LJIUD0o7qwGM3B4ZQVL8wojqN14XIujULF1e935+jINyJPjmYQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278d569a-09ba-4c16-cdc1-08d7dc6bb840
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 09:52:30.9539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAT5n64nmPnHieSWWVpwpjpRgle2zvufDNW8Cwg0YePM82SpeJhVmhOEVOwYqXMFMxnC6antL5C/May5cx8GUp1YzU4mmAAv7XDI5n/DHYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3151
Content-Type: multipart/alternative;
 boundary="------------225DC9A395FF0EBFDC5FFA5B"
Content-Language: en-US

--------------225DC9A395FF0EBFDC5FFA5B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/9/20 5:48 PM, Changqing Li wrote:
> From: Changqing Li <changqing.li@windriver.com>
>
> Fix below do_unpack failure since "_contains_lfs" check
> result is wrong:
> Fetcher failure: Repository ... has LFS content, install git-lfs on host
> to download (or set lfs=0 to ignore it)
>
> Take recipe freeradius as example:
> current freeradius is version 3.0.20, and branch is v3.0.x.
> and it don't contains lfs. but since we checked HEAD, which is
> point to master by default, _contains_lfs will think it contains lfs
> since the master contains lfs, and meantime, we don't have
> git-lfs on host, so unpack will failed.
>
> Fixed by check on the configured branch.
>
> Signed-off-by: Changqing Li <changqing.li@windriver.com>
> ---
>   bitbake/lib/bb/fetch2/git.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 5b3793a..3c5e200 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -563,8 +563,8 @@ class Git(FetchMethod):
>           """
>           Check if the repository has 'lfs' (large file) content
>           """
> -        cmd = "%s grep lfs HEAD:.gitattributes | wc -l" % (
> -                ud.basecmd)
> +        cmd = "%s grep lfs origin/%s:.gitattributes | wc -l" % (
> +                ud.basecmd, ud.branches[ud.names[0]])
>           try:
>               output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
>               if int(output) > 0:

This can fix mismatch caused by branch,  but I think maybe there still

maybe mismatch caused by different version, like version 3.0.20 / 3.0.21.

what is your opinion about this?

>
> 

--------------225DC9A395FF0EBFDC5FFA5B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/9/20 5:48 PM, Changqing Li wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:16041DC6947144EF.5874@lists.openembedded.org">
      <pre class="moz-quote-pre" wrap="">From: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a>

Fix below do_unpack failure since &quot;_contains_lfs&quot; check
result is wrong:
Fetcher failure: Repository ... has LFS content, install git-lfs on host
to download (or set lfs=0 to ignore it)

Take recipe freeradius as example:
current freeradius is version 3.0.20, and branch is v3.0.x.
and it don't contains lfs. but since we checked HEAD, which is
point to master by default, _contains_lfs will think it contains lfs
since the master contains lfs, and meantime, we don't have
git-lfs on host, so unpack will failed.

Fixed by check on the configured branch.

Signed-off-by: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a>
---
 bitbake/lib/bb/fetch2/git.py | 4 &#43;&#43;--
 1 file changed, 2 insertions(&#43;), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 5b3793a..3c5e200 100644
--- a/bitbake/lib/bb/fetch2/git.py
&#43;&#43;&#43; b/bitbake/lib/bb/fetch2/git.py
@@ -563,8 &#43;563,8 @@ class Git(FetchMethod):
         &quot;&quot;&quot;
         Check if the repository has 'lfs' (large file) content
         &quot;&quot;&quot;
-        cmd = &quot;%s grep lfs HEAD:.gitattributes | wc -l&quot; % (
-                ud.basecmd)
&#43;        cmd = &quot;%s grep lfs origin/%s:.gitattributes | wc -l&quot; % (
&#43;                ud.basecmd, ud.branches[ud.names[0]])
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
             if int(output) &gt; 0:
</pre>
    </blockquote>
    <p>This can fix mismatch caused by branch,&nbsp; but I think maybe there
      still</p>
    <p>maybe mismatch caused by different version, like version 3.0.20 /
      3.0.21.</p>
    <p>what is your opinion about this?<br>
    </p>
    <blockquote type="cite" cite="mid:16041DC6947144EF.5874@lists.openembedded.org"><br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------225DC9A395FF0EBFDC5FFA5B--
