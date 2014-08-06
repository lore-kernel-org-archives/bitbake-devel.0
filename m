Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 4983C65CC1
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Aug 2014 16:51:42 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 06 Aug 2014 09:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,812,1400050800"; d="scan'208";a="572619887"
Received: from cgwithan-mobl.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.26])
	by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2014 09:51:20 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Wed, 06 Aug 2014 17:51:19 +0100
Message-ID: <5235357.yFAteX2b5M@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.13.3 (Linux/3.15.7-200.fc20.x86_64; KDE/4.13.3; x86_64; ; )
In-Reply-To: <alpine.LFD.2.11.1406201322310.28485@localhost>
References: <alpine.LFD.2.11.1406201322310.28485@localhost>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Wed, 06 Aug 2014 16:51:53 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Robert,

On Friday 20 June 2014 13:26:08 Robert P. J. Day wrote:
>   is there anywhere to track proposed changes to the bitbake user
> manual? one of the things i've already noted is that the variable
> glossary is somewhat incomplete. for example, at the very least, it
> should include the following variables that are explicitly set in
> bitbake's own bitbake.conf file:
> 
>  CVSDIR
>  DEPLOY_DIR
>  DEPLOY_DIR_IMAGE
>  FILE_DIRNAME
>  GITDIR
>  IMAGE_CMD
>  IMAGE_ROOTFS
>  P
>  S
>  SVNDIR
>  TARGET_ARCH
>  TMPDIR
>  WORKDIR

This may seem logical at face value, but almost all of these variables aren't 
actually intrinsically understood by BitBake, they are just being provided 
there as an example of how to build something on top of BitBake (based on a 
very small subset of what OE looked like years ago). Thus, it wouldn't make 
sense to add these to the reference section of the BitBake manual.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

