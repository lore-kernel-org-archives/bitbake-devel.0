Return-Path: <Peter.Seebach@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C40EB608F7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 16:32:48 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r4VGWlcx027588
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 31 May 2013 09:32:47 -0700 (PDT)
Received: from e6410-2 (172.25.40.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.342.3;
	Fri, 31 May 2013 09:32:46 -0700
Date: Fri, 31 May 2013 11:32:35 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20130531113235.2bd2df62@e6410-2>
In-Reply-To: <1369985383.14887.341.camel@ted>
References: <1369799698-1417-1-git-send-email-mark.hatle@windriver.com>
	<1369985383.14887.341.camel@ted>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker.py: Remove explicit build targets from the ignored list
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 31 May 2013 16:32:48 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2013 08:29:43 +0100
Richard Purdie <richard.purdie@linuxfoundation.org> wrote:

> I'm not sure this is the right thing to do, the reason being
> determinism. I don't expect different results for X in the different
> cases:
> 
> bitbake X Y
> 
> bitbake X
> 
> (assuming Y is ASSUME_PROVIDED)
> 
> For example, X will rebuild between these two commands since the sstate
> and task checksums will be different between the two. This really needs
> more thought to make a consistent user experience...

Hmm. I don't *normally* expect different results, but might if the first one
produced a diagnostic: "Warning: Y is in ASSUME_PROVIDED. Rebuilding Y will
produce different versions of anything which depends on Y."

Paul's suggestion that we just print a diagnostic for anything which is in
both targets and ASSUME_PROVIDED might well do, too. Although it might be nice
to have a reasonably straight forward command-line way to express "no, really,
I want you to build Y" which doesn't require config file action.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.

