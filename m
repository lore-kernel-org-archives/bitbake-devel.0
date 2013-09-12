Return-Path: <denis@denix.org>
Received: from vms173013pub.verizon.net (vms173013pub.verizon.net
	[206.46.173.13])
	by mail.openembedded.org (Postfix) with ESMTP id D3BCB60664
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Sep 2013 02:24:55 +0000 (UTC)
Received: from gandalf.denix.org ([unknown] [108.45.150.102])
	by vms173013.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0MSZ0070PQP751N1@vms173013.mailsrvcs.net> for
	bitbake-devel@lists.openembedded.org;
	Wed, 11 Sep 2013 21:24:44 -0500 (CDT)
Received: by gandalf.denix.org (Postfix, from userid 1000)	id 8ABB426998; Wed,
	11 Sep 2013 22:24:43 -0400 (EDT)
Date: Wed, 11 Sep 2013 22:24:43 -0400
From: Denys Dmytriyenko <denis@denix.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-id: <20130912022443.GK5834@denix.org>
References: <1378830807-24027-1-git-send-email-denis@denix.org>
	<1378830807-24027-2-git-send-email-denis@denix.org>
	<1378918805.3484.201.camel@ted>
MIME-version: 1.0
In-reply-to: <1378918805.3484.201.camel@ted>
User-Agent: Mutt/1.5.20 (2009-06-14)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [1.18][PATCH] methodpool: Retire it, remove global method scope
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
X-List-Received-Date: Thu, 12 Sep 2013 02:24:56 -0000
Content-type: text/plain; charset=us-ascii
Content-disposition: inline

On Wed, Sep 11, 2013 at 06:00:05PM +0100, Richard Purdie wrote:
> On Tue, 2013-09-10 at 12:33 -0400, Denys Dmytriyenko wrote:
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> > Having a global method scope confuses users and with the introduction
> > of parallel parsing, its not even possible to correctly detect conflicting
> > functions. Rather than try and fix that, its simpler to retire the global
> > method scope and restrict functions to those locations they're defined
> > within. This is more what users actually expect too.
> > 
> > If we remove the global function scope, the need for methodpool is reduced
> > to the point we may as well retire it. There is some small loss of caching
> > of parsed functions but timing measurements so the impact to be neglibile
> > in the overall parsing time.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > Tested-by: Denys Dmytriyenko <denys@ti.com>
> 
> In general I wouldn't take this (as a feature removal) however the code
> in question was really broken when we introduced parallel parsing. Its
> therefore totally broken, has been for a long time and this patch is
> therefore a good thing as it is a bugfix rather than feature removal.
> 
> So I've merged it.

Thanks, Richard, appreciate it.

-- 
Denys

