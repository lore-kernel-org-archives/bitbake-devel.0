Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id E01086013D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Mar 2015 13:24:29 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 03 Mar 2015 05:24:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,681,1418112000"; d="scan'208";a="535389192"
Received: from tmlemanx-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.7.97])
	by orsmga003.jf.intel.com with ESMTP; 03 Mar 2015 05:24:28 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Himanshu Pandey <pandey_himanshu80@rediffmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 03 Mar 2015 13:24:28 +0000
Message-ID: <2028424.2egtMTeCxi@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.4 (Linux/3.18.7-100.fc20.x86_64; KDE/4.14.4; x86_64; ; )
MIME-Version: 1.0
Subject: Re: Beginner help
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
X-List-Received-Date: Tue, 03 Mar 2015 13:24:38 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

These are OE questions not bitbake; in future please post these to either
the openembedded-core@lists.openembedded.org or yocto@yoctoproject.org
mailing list. Could you also please not post unrelated questions in reply to
an existing thread - start a new thread instead.

On Tuesday 03 March 2015 12:45:53 Himanshu  Pandey wrote:
> When I compile my image using the command bitbake:
> bitbake core-image-lb
> it shows:
> meta-lb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
> "&lt;unknown&gt;:&lt;unknown&gt;"

This just means that no revision information could be determined for the
specified layer, i.e. it's not a git/svn/etc. repository. It's nothing to worry
about.
 
> Also I have included the package "bash" in conf/local.conf for this image.
> But the image is neither compiling the bash package nor it is installing
> it. Where shall I include the bash package in my image.

Please see the following manual section on how to add packages to an image:

http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#usingpoky-extend-customimage



-- 

Paul Eggleton
Intel Open Source Technology Centre

