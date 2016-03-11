Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id A0F10731D3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Mar 2016 03:22:17 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u2B3MAWE027494
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 10 Mar 2016 19:22:13 -0800
Received: from [128.224.162.155] (128.224.162.155) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.248.2;
	Thu, 10 Mar 2016 19:22:10 -0800
To: Praveenreddy Padamati <praveenreddy.p@hcl.com>,
	"'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
References: <09856974BCEE6F48AB378E52E4CAA73C226DA890@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <56E239E0.7010003@windriver.com>
Date: Fri, 11 Mar 2016 11:22:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <09856974BCEE6F48AB378E52E4CAA73C226DA890@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
Subject: Re: Hi
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 11 Mar 2016 03:22:19 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit



On 03/10/2016 03:10 PM, Praveenreddy Padamati wrote:
> Hi all,
>
> I need to add zetakey browser to the yocto core-image-sato. Can you provide any
> data how to add this browse to the build.

Add this to local.conf:

IMAGE_INSTALL_append = " zetakey"

Note, there is a space " " which is a must, then:

$ bitbake core-image-sato

>
> *Thanks and Regards,*
>
> *Praveen Reddy P**
> **HCL Technologies Ltd*| Lead Engineer | Alstom ODC| ERS-SS-SCS-Embedded
> Platform Lab
>
> P*hone:* +914443935173 | *Mobile:* +919989642159 | *E-mail:*
> _praveenreddy.p@hcl.com <mailto:praveenreddy.p@hcl.com>_
>
> *Company address:*HCL Technologies Ltd ,73-74, South Phase,Ambattur Industrial
> Estate (AMB-5), Chennai - 600 058,India
> *Switchboard:*__+91-44-4393-5000  Web*Site:* www.hclt.com <http://www.hclt.com/>
>
>
>
> ::DISCLAIMER::
> ----------------------------------------------------------------------------------------------------------------------------------------------------
>
> The contents of this e-mail and any attachment(s) are confidential and intended
> for the named recipient(s) only.
> E-mail transmission is not guaranteed to be secure or error-free as information
> could be intercepted, corrupted,
> lost, destroyed, arrive late or incomplete, or may contain viruses in
> transmission. The e mail and its contents
> (with or without referred errors) shall therefore not attach any liability on
> the originator or HCL or its affiliates.
> Views or opinions, if any, presented in this email are solely those of the
> author and may not necessarily reflect the
> views or opinions of HCL or its affiliates. Any form of reproduction,
> dissemination, copying, disclosure, modification,
> distribution and / or publication of this message without the prior written
> consent of authorized representative of
> HCL is strictly prohibited. If you have received this email in error please
> delete it and notify the sender immediately.
> Before opening any email and/or attachments, please check them for viruses and
> other defects.
>
> ----------------------------------------------------------------------------------------------------------------------------------------------------
>
>
>

