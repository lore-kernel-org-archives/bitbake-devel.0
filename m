Return-Path: <andrew@bradfordembedded.com>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
	[66.111.4.26])
	by mail.openembedded.org (Postfix) with ESMTP id DC818774FD
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jun 2016 13:33:06 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 51BD8208C1;
	Fri,  3 Jun 2016 09:33:07 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
	by compute2.internal (MEProxy); Fri, 03 Jun 2016 09:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	bradfordembedded.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=NlJQgVDr4r5zyWNVGe+nm66OAVw=; b=fzmfpE
	cuSXOFlxHHlh+wKOWLmBmrpDvnf4qCdBkDgfU5p82t9x26bBnOFuC26CGcuwGBAH
	9ldi1A6JkCqfI9Zu6GGJ4Fegepb94J5MgfbkSmwf4NmGZKsTcXrgiHf6JAFvxuJH
	vu6QZgjx4eTtgUFVvPSlIuMxFqeIbI3hRXKkM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=NlJQgVDr4r5zyWNVGe+nm66OAVw=; b=qwtsV
	vHcb4rMGCkmkaGeehaHKl8+t4NXhpqEl28tCLTLrIHpJAWJlLx8tdF7CXajYfpsI
	FSK0QUzF2kDJILv+2WWBGN06liJZrWSs0zJEU77jfE8vDj1zcHV367xM5X0nCKH1
	r0tDCCU2uzMWfiEPxDFbmg8WnHDaie27c6h+go=
X-Sasl-enc: ulXBql2/MJ7jH2jCSVhhswi7wx8C47XYsaZkkW8jZ4NB 1464960787
Received: from kaim-eeyore.kodakalaris.net (clr-vpn01.kodakalaris.com
	[198.140.222.129])
	by mail.messagingengine.com (Postfix) with ESMTPA id E791BF29F5;
	Fri,  3 Jun 2016 09:33:06 -0400 (EDT)
Date: Fri, 3 Jun 2016 09:33:05 -0400
From: Andrew Bradford <andrew@bradfordembedded.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20160603133305.GA18943@kaim-eeyore.kodakalaris.net>
References: <1464205704-26377-1-git-send-email-andrew@bradfordembedded.com>
	<1464205704-26377-2-git-send-email-andrew@bradfordembedded.com>
	<CAJTo0LbvONwNTroCJrJ8K1MP1zJ_98g-NrWw7SbNfeOp94nQGA@mail.gmail.com>
	<1464950281.13979.13.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1464950281.13979.13.camel@linuxfoundation.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Andrew Bradford <andrew.bradford@kodakalaris.com>
Subject: Re: [PATCH 1/2] perforce fetcher: Rework to support SRCREV and P4CONFIG
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
X-List-Received-Date: Fri, 03 Jun 2016 13:33:07 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Richard,

On 06/03 11:38, Richard Purdie wrote:
> On Fri, 2016-06-03 at 10:47 +0100, Burton, Ross wrote:
> > Master has just landed the Python3 port, so can you rebase this to
> > current git master?
> 
> I replied to the OE-Core patches and I think that will mean there are
> some changes needed to this patch too so that can all hopefully be
> rolled together in the next version of the patch.

Yes, I have a few changes from your oe-core patch comments and I'll also
rebase on the python3 changes.  I'll be sending a v2 bitbake patchset
for the perforce fetcher and documentation changes.

Thanks!
-Andrew

