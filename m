Return-Path: <scott.m.rifenbark@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 71EEA60889
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Jun 2014 05:05:27 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 26 Jun 2014 22:00:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,558,1400050800"; d="scan'208";a="564294799"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 26 Jun 2014 22:05:26 -0700
Received: from [10.254.73.225] (unknown [10.254.73.225])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id 370B46A4007
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jun 2014 22:04:56 -0700 (PDT)
Message-ID: <53ACFB92.7070007@linux.intel.com>
Date: Thu, 26 Jun 2014 22:05:22 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@linux.intel.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <alpine.LFD.2.11.1406201322310.28485@localhost>
In-Reply-To: <alpine.LFD.2.11.1406201322310.28485@localhost>
Subject: Re: is there a TODO/issues list for bitbake user manual enhancements?
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
X-List-Received-Date: Fri, 27 Jun 2014 05:05:35 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Robert,

The best way to track this stuff is to open a bug on it in Bugzilla 
(https://bugzilla.yoctoproject.org/).  Assign the bug to me and note 
these specific variables.

Thanks,
Scott

On 6/20/2014 10:26 AM, Robert P. J. Day wrote:
>    is there anywhere to track proposed changes to the bitbake user
> manual? one of the things i've already noted is that the variable
> glossary is somewhat incomplete. for example, at the very least, it
> should include the following variables that are explicitly set in
> bitbake's own bitbake.conf file:
>
>   CVSDIR
>   DEPLOY_DIR
>   DEPLOY_DIR_IMAGE
>   FILE_DIRNAME
>   GITDIR
>   IMAGE_CMD
>   IMAGE_ROOTFS
>   P
>   S
>   SVNDIR
>   TARGET_ARCH
>   TMPDIR
>   WORKDIR
>
> is there a list to add these to? or is most of the effort these days
> being invested in the yocto version of the ref manual?

I spend time in the BitBake manual as needed.  BTW - your patches to it 
have been applied.  They might not be in the BitBake repo yet but they 
are applied and in my contrib area.  And, of course, you can see them in 
the "latest" version of the manual.

>
> rday
>


