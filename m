Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id CA36B776F4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Oct 2017 16:56:23 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP; 02 Oct 2017 09:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,470,1500966000"; d="scan'208";a="141813294"
Received: from lsandov1-mobl2.zpn.intel.com ([10.219.128.134])
	by orsmga002.jf.intel.com with SMTP; 02 Oct 2017 09:56:22 -0700
Date: Mon, 2 Oct 2017 12:05:48 -0500
From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
To: akuster <akuster@mvista.com>
Message-Id: <20171002120548.7adef3e92d4cb423f624a97d@linux.intel.com>
In-Reply-To: <324e7e99-7b13-5e30-36a2-4814be8f7b5b@mvista.com>
References: <20171002153849.24922-1-leonardo.sandoval.gonzalez@linux.intel.com>
	<20171002153849.24922-3-leonardo.sandoval.gonzalez@linux.intel.com>
	<324e7e99-7b13-5e30-36a2-4814be8f7b5b@mvista.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/3] README: new readme file including main aspects of the project
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
X-List-Received-Date: Mon, 02 Oct 2017 16:56:23 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

 
> Is there any value in providing a sample command:
> 
> git send-patch -M -1 --subject-prefix=Bitbake][PATCH --to
> bitbake-devel@lists.openembedded.org

yes, I think it adds value, specially for new contributors (also this is an effort to reduce patches that get as attachments to the ML).

> 
> - Armin
> - armin
> > +
> > +Mailing list:
> > +
> > +    http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> > +
> > +Source code:
> > +
> > +    http://git.openembedded.org/bitbake/
> 


-- 
Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>

