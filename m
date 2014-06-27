Return-Path: <scott.m.rifenbark@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A0BE660889
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Jun 2014 05:08:32 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 26 Jun 2014 22:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; d="scan'208";a="357767360"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Jun 2014 22:03:41 -0700
Received: from [10.254.73.225] (unknown [10.254.73.225])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id 06FAD6A4007
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jun 2014 22:08:02 -0700 (PDT)
Message-ID: <53ACFC4D.4020805@linux.intel.com>
Date: Thu, 26 Jun 2014 22:08:29 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@linux.intel.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <alpine.LFD.2.11.1406221041150.4008@localhost>
In-Reply-To: <alpine.LFD.2.11.1406221041150.4008@localhost>
Subject: Re: bitbake user manual: "Variable Flags" section seems to need updating
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
X-List-Received-Date: Fri, 27 Jun 2014 05:08:33 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I will need information from somebody that understands what these 
undocumented flags do.  Anyone?

Thanks,
Scott

On 6/22/2014 7:47 AM, Robert P. J. Day wrote:
>    the "Variable Flags" section of the bitbake user manual seems to be
> incomplete:
>
> http://www.yoctoproject.org/docs/1.6/bitbake-user-manual/bitbake-user-manual.html#variable-flags
>
> at the very least, i see additional task flags such as "selfstamp",
> "lockfiles", "stamp-base" and more, just from having stumbled across
> this:
>
> lib/toaster/orm/fixtures/orm_views_testdata.json:
> "variable_value": "doc defaultval _append _prepend deps depends
> lockfiles type vardepsexclude vardeps vardepvalue file-checksums
> python func task export unexport noexec nostamp dirs cleandirs
> sstate-lockfile-shared prefuncs postfuncs export_func deptask rdeptask
> recrdeptask nodeprrecs stamp-base stamp-extra-info",
>
> but i don't know enough about some of those flags to know what to add
> for them (if anything).
>
> rday
>


