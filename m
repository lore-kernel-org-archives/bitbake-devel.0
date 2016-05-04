Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id ECBFD6FFE8;
	Wed,  4 May 2016 21:29:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u44LTCla019367
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Wed, 4 May 2016 14:29:12 -0700
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Wed, 4 May 2016 14:29:11 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <1462352176.18407.11.camel@linuxfoundation.org>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <53677acc-ca69-58d0-1747-b1144aaf8f1b@windriver.com>
Date: Wed, 4 May 2016 16:29:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
	Gecko/20100101 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <1462352176.18407.11.camel@linuxfoundation.org>
Subject: Re: [Openembedded-architecture] Python 3 for Bitbake
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
X-List-Received-Date: Wed, 04 May 2016 21:29:14 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 5/4/16 3:56 AM, Richard Purdie wrote:
> My proposal is we decide to have the flag day, we queue up the patches
> on a python3 branch both in oe-core and bitbake, then we switch when we
> get successful autobuilder builds. I'd ideally like to do this quite
> soon and get one with it (within a few weeks), leaving plenty of time
> to handle issues and the other changes planned for this release cycle
> and give other layers time to adapt.
> 
> I will likely push things so the basics in the core work, I'll then
> need help for things like toaster, the QA framework, the supporting
> tools (devtool, recipetool and so on).
> 
> Does anyone object to this?

I think this is a good plan.  Flag day, and switch.

Question, do we need any type of identifier in layers to say they're "python3"
compatible or not?

I'd hate for someone to bring in a layer and find it doesn't work, without
understanding WHY it doesn't work.

Alternative would be to change the 'python' identifier to 'python3'..  Then if
'python' is parsed, we error?

--Mark

> Cheers,
> 
> Richard
> 
> 
> 
> _______________________________________________
> Openembedded-architecture mailing list
> Openembedded-architecture@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/openembedded-architecture
> 


