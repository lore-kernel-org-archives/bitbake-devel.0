Return-Path: <rich.tollerton@ni.com>
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8DD11724D8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Dec 2014 20:18:04 +0000 (UTC)
Received: from us-aus-mgwout1.amer.corp.natinst.com (nb-snip2-1338.natinst.com
	[130.164.19.135])
	by us-aus-skprod3.natinst.com (8.14.5/8.14.5) with ESMTP id
	sBIKI36A019109; Thu, 18 Dec 2014 14:18:03 -0600
Received: from weregild ([130.164.14.198])
	by us-aus-mgwout1.amer.corp.natinst.com (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2014121814180352-232601 ;
	Thu, 18 Dec 2014 14:18:03 -0600 
From: Richard Tollerton <rich.tollerton@ni.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1418898565.5106.19.camel@linuxfoundation.org>
References: <1418865078-10484-1-git-send-email-rich.tollerton@ni.com>
	<1418898565.5106.19.camel@linuxfoundation.org>
User-Agent: Notmuch/0.18.1 (http://notmuchmail.org) Emacs/24.4.1
	(x86_64-unknown-linux-gnu)
Date: Thu, 18 Dec 2014 14:18:03 -0600
Message-ID: <87tx0su2ys.fsf@weregild.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on US-AUS-MGWOut1/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 12/18/2014 02:18:03 PM,
	Serialize by Router on US-AUS-MGWOut1/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 12/18/2014 02:18:03 PM,
	Serialize complete at 12/18/2014 02:18:03 PM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.13.68, 1.0.33,
	0.0.0000
	definitions=2014-12-18_06:2014-12-18, 2014-12-18,
	1970-01-01 signatures=0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] data: Avoid attempting to assign readonly shell vars
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
X-List-Received-Date: Thu, 18 Dec 2014 20:18:05 -0000
Content-Type: text/plain

Richard Purdie <richard.purdie@linuxfoundation.org> writes:

> On Wed, 2014-12-17 at 19:11 -0600, Richard Tollerton wrote:
>> The fix is to attempt to modify the variable in a subshell before doing
>> the assignment.
>
> Isn't this going to involve fork() calls for every single shell
> variable?

Yes :(

I'm not quite sure how to rigorously check the performance difference;
is there a decent test case that exercises this and only this?

> There must be a better way to do this?

Not unless we rewrite how we set up the environment. My reading of POSIX
is that no query facility exists for determining the read-only status of
a variable [1] [2], and that the only permitted action for attempting to
set a read-only variable is to exit [3] [4].

I suppose that enforcing a hard dependency on bash (via #!/usr/bin/env
bash) could work around this, since this only seems to appear in POSIX
mode; but I'm not yet convinced that the bash execution behavior when
run as bash (vs sh) won't change in the future. Should I bring this up
on bug-bash?

The only *unambiguous* alternative that I see is to rewrite environment
setup to use env. That is, instead of generating:

export A=B
export C=D
...
do_fn () { fn; }
do_fn

We could do:

env - \
A=B \
C=D \
/bin/sh -c 'do_fn() { fn; }; do_fn;'

But obviously that is an extremely intrusive change.

[1] http://pubs.opengroup.org/onlinepubs/009695399/utilities/test.html
[2] http://stackoverflow.com/questions/4440842/test-if-a-variable-is-read-only
[3] http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_09_01
[4]
http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_08_01

> Cheers,
>
> Richard

-- 
Richard Tollerton <rich.tollerton@ni.com>

